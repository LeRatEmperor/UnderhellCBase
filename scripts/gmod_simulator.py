#!/usr/bin/env python3
"""
gmod_simulator.py — Simulates GMod's viewmodel + c_arms rendering in Blender.

This script:
1. Imports the weapon viewmodel (.mdl) using SourceIO
2. Imports the c_arms_citizen.smd mesh using a custom SMD importer
3. Simulates GMod's bonemerge: copies weapon bone transforms to c_arms bones
4. Renders the scene from the viewmodel camera angle (like GMod sees it)
5. Can play animations and render specific frames

Usage:
  blender --background --python gmod_simulator.py -- <weapon_mdl> <output_dir> [animation_name] [frame]

Examples:
  # Render idle pose
  blender --background --python gmod_simulator.py -- c_m416.mdl ./renders m416_idle

  # Render reload frame 15
  blender --background --python gmod_simulator.py -- c_m416.mdl ./renders m416_reload 15
"""
import bpy
import sys
import os
import math
import struct
import re
import mathutils
import numpy as np

# ============================================================================
# SMD IMPORTER — Custom importer for c_arms_citizen.smd
# ============================================================================
def import_smd(smd_path, armature_name="c_arms_armature", mesh_name="c_arms_mesh"):
    """Import an SMD file as a mesh + armature in Blender.
    
    Returns: (armature_obj, mesh_obj)
    """
    print(f"  Importing SMD: {smd_path}")
    
    with open(smd_path, 'r', errors='ignore') as f:
        lines = f.readlines()
    
    # Parse nodes section
    bone_names = []
    bone_parents = {}
    in_nodes = False
    for line in lines:
        s = line.strip()
        if s == 'nodes':
            in_nodes = True
            continue
        if s == 'end' and in_nodes:
            in_nodes = False
            break
        if in_nodes:
            m = re.match(r'^\s*(\d+)\s+"([^"]+)"\s+(-?\d+)$', s)
            if m:
                bid = int(m.group(1))
                name = m.group(2)
                pid = int(m.group(3))
                bone_names.append((bid, name, pid))
                bone_parents[bid] = pid
    
    # Parse skeleton section (time 0 = bind pose)
    bind_pose = {}
    in_skeleton = False
    in_time_0 = False
    for line in lines:
        s = line.strip()
        if s == 'skeleton':
            in_skeleton = True
            continue
        if s == 'end' and in_skeleton:
            break
        if not in_skeleton:
            continue
        if s.startswith('time'):
            in_time_0 = (s == 'time 0')
            continue
        if in_time_0:
            m = re.match(r'^\s*(\d+)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+'
                         r'(-?\d+\.?\d*)\s+(-?\d+\.?\d*)\s+(-?\d+\.?\d*)', s)
            if m:
                bid = int(m.group(1))
                px, py, pz = float(m.group(2)), float(m.group(3)), float(m.group(4))
                rx, ry, rz = float(m.group(5)), float(m.group(6)), float(m.group(7))
                bind_pose[bid] = (px, py, pz, rx, ry, rz)
    
    # Parse triangles section
    vertices = []
    faces = []
    vertex_weights = []
    material_name = None
    current_tri = []
    in_triangles = False
    
    for line in lines:
        s = line.strip()
        if s == 'triangles':
            in_triangles = True
            continue
        if s == 'end' and in_triangles:
            break
        if not in_triangles:
            continue
        
        # Check if this is a vertex line (starts with a number, with or without indentation)
        parts = s.split()
        is_vertex = False
        if parts:
            try:
                int(parts[0])
                # Check if it has enough fields to be a vertex (at least 9: bone x y z nx ny nz u v)
                if len(parts) >= 9:
                    is_vertex = True
            except ValueError:
                is_vertex = False
        
        if not is_vertex and s:
            material_name = s
            continue
        
        if is_vertex:
            bone_id = int(parts[0])
            x, y, z = float(parts[1]), float(parts[2]), float(parts[3])
            nx, ny, nz = float(parts[4]), float(parts[5]), float(parts[6])
            u, v = float(parts[7]), float(parts[8])
            
            # Parse weight links
            weights = []
            if len(parts) > 9:
                try:
                    num_links = int(parts[9])
                    for j in range(num_links):
                        wb = int(parts[10 + j * 2])
                        wv = float(parts[11 + j * 2])
                        weights.append((wb, wv))
                except (ValueError, IndexError):
                    weights = [(bone_id, 1.0)]
            else:
                weights = [(bone_id, 1.0)]
            
            vert_idx = len(vertices)
            vertices.append((x, y, z))
            vertex_weights.append(weights)
            current_tri.append(vert_idx)
            
            if len(current_tri) == 3:
                faces.append((current_tri[0], current_tri[1], current_tri[2], material_name or "default"))
                current_tri = []
    
    print(f"    Parsed: {len(bone_names)} bones, {len(vertices)} vertices, {len(faces)} faces")
    
    # Create armature
    arm_data = bpy.data.armatures.new(armature_name)
    arm_obj = bpy.data.objects.new(armature_name, arm_data)
    bpy.context.scene.collection.objects.link(arm_obj)
    
    bpy.context.view_layer.objects.active = arm_obj
    bpy.ops.object.mode_set(mode='EDIT')
    
    # Create bones
    bone_obj_map = {}  # bid -> edit_bone
    for bid, name, pid in bone_names:
        if bid in bind_pose:
            px, py, pz, rx, ry, rz = bind_pose[bid]
            bone = arm_data.edit_bones.new(name)
            bone.head = mathutils.Vector((px, py, pz))
            # Tail is along the bone's Y axis (length 1)
            # SMD uses RadianEuler(x,y,z) -> QAngle(y,z,x)
            # For simplicity, point bone along Z axis
            bone.tail = bone.head + mathutils.Vector((0, 0, 0.1))
            bone_obj_map[bid] = bone
    
    # Set parents
    for bid, name, pid in bone_names:
        if bid in bone_obj_map and pid in bone_obj_map and pid >= 0:
            bone_obj_map[bid].parent = bone_obj_map[pid]
    
    bpy.ops.object.mode_set(mode='OBJECT')
    
    # Create mesh using from_pydata (proper Blender API)
    mesh = bpy.data.meshes.new(mesh_name)
    
    # Prepare data for from_pydata
    verts_co = [(x, y, z) for x, y, z in vertices]
    faces_indices = [(f[0], f[1], f[2]) for f in faces]
    
    mesh.from_pydata(verts_co, [], faces_indices)
    mesh.update()
    
    mesh_obj = bpy.data.objects.new(mesh_name, mesh)
    bpy.context.scene.collection.objects.link(mesh_obj)
    
    # Create vertex groups (bone weights)
    bone_name_map = {bid: name for bid, name, pid in bone_names}
    for bid, name in bone_name_map.items():
        mesh_obj.vertex_groups.new(name=name)
    
    # Assign weights
    for vi, weights in enumerate(vertex_weights):
        for wb, wv in weights:
            bone_name = bone_name_map.get(wb, '')
            if bone_name:
                vg = mesh_obj.vertex_groups.get(bone_name)
                if vg:
                    vg.add([vi], wv, 'REPLACE')
    
    # Parent mesh to armature
    mesh_obj.parent = arm_obj
    mod = mesh_obj.modifiers.new("Armature", 'ARMATURE')
    mod.object = arm_obj
    
    mesh.update()
    
    print(f"    Created armature: {arm_obj.name} ({len(arm_data.bones)} bones)")
    print(f"    Created mesh: {mesh_obj.name} ({len(mesh.vertices)} verts, {len(mesh.polygons)} faces)")
    
    return arm_obj, mesh_obj


# ============================================================================
# BONEMERGE SIMULATOR
# ============================================================================
def simulate_bonemerge(weapon_armature, c_arms_armature):
    """Simulate GMod's bonemerge: copy weapon bone transforms to c_arms bones.
    
    GMod's bonemerge SETS bone transforms (not delta from rest).
    To simulate this in Blender, we:
    1. Add Copy Transforms constraints to copy weapon bone transforms
    2. Apply the pose as rest pose (bakes the weapon transforms into the rest pose)
    3. This makes the armature modifier compute correct deformation
    """
    print("  Simulating bonemerge...")
    
    # Parent c_arms armature to weapon armature (like GMod parents c_arms entity to viewmodel)
    c_arms_armature.parent = weapon_armature
    c_arms_armature.parent_type = 'OBJECT'
    
    bpy.context.view_layer.objects.active = c_arms_armature
    bpy.ops.object.mode_set(mode='POSE')
    
    merged_count = 0
    for pbone in c_arms_armature.pose.bones:
        bone_name = pbone.name
        if bone_name in weapon_armature.data.bones:
            # Add a "Copy Transforms" constraint to copy from the weapon bone
            constraint = pbone.constraints.new(type='COPY_TRANSFORMS')
            constraint.target = weapon_armature
            constraint.subtarget = bone_name
            constraint.target_space = 'WORLD'
            constraint.owner_space = 'WORLD'
            merged_count += 1
    
    bpy.ops.object.mode_set(mode='OBJECT')
    
    # Force dependency graph update — the armature modifier will now deform the mesh
    # based on the Copy Transforms constraints (simulating GMod's bonemerge)
    bpy.context.view_layer.update()
    depsgraph = bpy.context.evaluated_depsgraph_get()
    
    print(f"    Merged {merged_count} bones (via Copy Transforms constraints)")
    return merged_count


# ============================================================================
# VIEWMODEL CAMERA SETUP
# ============================================================================
def setup_viewmodel_camera(scene, target_obj=None):
    """Set up a camera like GMod's viewmodel camera.
    
    GMod renders the viewmodel at a specific FOV (usually 60-75) and position.
    """
    cam_data = bpy.data.cameras.new("ViewmodelCam")
    cam_data.lens = 35  # ~60 FOV equivalent
    cam_obj = bpy.data.objects.new("ViewmodelCam", cam_data)
    bpy.context.scene.collection.objects.link(cam_obj)
    
    if target_obj:
        # Position camera to look at the target
        target_loc = target_obj.location
        cam_obj.location = (target_loc.x, target_loc.y - 2, target_loc.z + 0.5)
    else:
        cam_obj.location = (0, -2, 0)
    
    cam_obj.rotation_euler = (math.radians(90), 0, 0)
    
    scene.camera = cam_obj
    return cam_obj


# ============================================================================
# RENDER
# ============================================================================
def render_scene(scene, output_path, resolution=(800, 600)):
    """Render the scene and save to PNG."""
    scene.render.resolution_x = resolution[0]
    scene.render.resolution_y = resolution[1]
    scene.render.engine = 'CYCLES'
    scene.cycles.device = 'CPU'
    scene.cycles.samples = 32
    scene.render.filepath = output_path
    
    # Set background
    if scene.world:
        if not scene.world.node_tree:
            scene.world.use_nodes = True
        bg = scene.world.node_tree.nodes.get("Background")
        if bg:
            bg.inputs[0].default_value = (0.3, 0.3, 0.3, 1.0)
            bg.inputs[1].default_value = 1.0
    
    bpy.ops.render.render(write_still=True)
    print(f"  Rendered: {output_path}")


# ============================================================================
# MAIN
# ============================================================================
def main():
    import sys
    argv = sys.argv
    if "--" in argv:
        argv = argv[argv.index("--") + 1:]
    else:
        argv = []
    
    if len(argv) < 2:
        print("Usage: blender --background --python gmod_simulator.py -- <weapon_mdl> <output_dir> [animation_name] [frame]")
        return
    
    weapon_mdl = argv[0]
    output_dir = argv[1]
    animation_name = argv[2] if len(argv) > 2 else None
    frame = int(argv[3]) if len(argv) > 3 else None
    
    os.makedirs(output_dir, exist_ok=True)
    
    # Add SourceIO to path
    sys.path.insert(0, '/home/z/my-project/tools/SourceIO')
    import source_io
    from SourceIO.blender_bindings.bindings import register
    register()
    
    # Clear scene
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete(use_global=False)
    for mat in bpy.data.materials:
        bpy.data.materials.remove(mat)
    for mesh in bpy.data.meshes:
        bpy.data.meshes.remove(mesh)
    for arm in bpy.data.armatures:
        bpy.data.armatures.remove(arm)
    
    weapon_name = os.path.basename(weapon_mdl).replace('.mdl', '')
    
    print(f"\n{'='*60}")
    print(f"GMod Simulator — {weapon_name}")
    print(f"{'='*60}")
    
    # Step 1: Import weapon model
    print(f"\n[1/4] Importing weapon: {weapon_mdl}")
    try:
        bpy.ops.sourceio.mdl(
            directory=os.path.dirname(weapon_mdl),
            files=[{'name': os.path.basename(weapon_mdl)}],
            discover_resources=False,
            import_animations=False,  # Disable animations due to SourceIO numpy bug
            import_textures=False,
            write_qc=False,
            scale=1.0,  # Don't scale — keep Source units (same as SMD)
        )
        print("  OK (without animations)")
    except Exception as e:
        print(f"  FAILED: {e}")
        return
    
    # Find weapon armature
    weapon_armature = None
    weapon_meshes = []
    for obj in bpy.context.scene.objects:
        if obj.type == 'ARMATURE':
            weapon_armature = obj
        elif obj.type == 'MESH':
            weapon_meshes.append(obj)
    
    if not weapon_armature:
        print("  ERROR: No armature found in weapon model")
        return
    
    print(f"  Armature: {weapon_armature.name} ({len(weapon_armature.data.bones)} bones)")
    print(f"  Meshes: {len(weapon_meshes)}")
    
    # List animations
    if weapon_armature.animation_data and weapon_armature.animation_data.action:
        action = weapon_armature.animation_data.action
        print(f"  Animation: {action.name} (frames {int(action.frame_range[0])}-{int(action.frame_range[1])})")
    
    # Step 2: Import c_arms_citizen
    c_arms_smd = "/home/z/my-project/repos/gmod-animations/c_arms_citizen.smd"
    print(f"\n[2/4] Importing c_arms: {c_arms_smd}")
    try:
        c_arms_armature, c_arms_mesh = import_smd(c_arms_smd)
        print("  OK")
    except Exception as e:
        print(f"  FAILED: {e}")
        import traceback
        traceback.print_exc()
        return
    
    # Step 3: Simulate bonemerge
    print(f"\n[3/4] Simulating bonemerge")
    merged = simulate_bonemerge(weapon_armature, c_arms_armature)
    
    # Step 4: Render
    print(f"\n[4/4] Rendering")
    
    # Set up camera
    # Setup camera that looks at all meshes (using evaluated/deformed positions)
    import mathutils
    
    # Compute bounding box using EVALUATED mesh (after armature deformation)
    depsgraph = bpy.context.evaluated_depsgraph_get()
    min_co = mathutils.Vector((float('inf'), float('inf'), float('inf')))
    max_co = mathutils.Vector((float('-inf'), float('-inf'), float('-inf')))
    
    for obj in weapon_meshes + [c_arms_mesh]:
        obj_eval = obj.evaluated_get(depsgraph)
        mesh_eval = obj_eval.data
        for vert in mesh_eval.vertices:
            world_co = obj_eval.matrix_world @ vert.co
            for i in range(3):
                if world_co[i] < min_co[i]:
                    min_co[i] = world_co[i]
                if world_co[i] > max_co[i]:
                    max_co[i] = world_co[i]
    
    center = (min_co + max_co) / 2
    size = max(max_co - min_co)
    if size < 0.1:
        size = 1.0
    
    print(f"  Combined bounding box: min=({min_co.x:.2f}, {min_co.y:.2f}, {min_co.z:.2f}) max=({max_co.x:.2f}, {max_co.y:.2f}, {max_co.z:.2f})")
    print(f"  Center: ({center.x:.2f}, {center.y:.2f}, {center.z:.2f}) Size: {size:.2f}")
    
    cam_data = bpy.data.cameras.new("ViewCam")
    cam_data.lens = 50
    cam_obj = bpy.data.objects.new("ViewCam", cam_data)
    bpy.context.scene.collection.objects.link(cam_obj)
    cam_obj.location = (center.x, center.y - size * 1.5, center.z)
    direction = center - cam_obj.location
    cam_obj.rotation_euler = direction.to_track_quat('-Z', 'Y').to_euler()
    bpy.context.scene.camera = cam_obj
    cam = cam_obj
    
    # Set up lighting
    light_data = bpy.data.lights.new("KeyLight", type='SUN')
    light_data.energy = 5.0
    light_obj = bpy.data.objects.new("KeyLight", light_data)
    bpy.context.scene.collection.objects.link(light_obj)
    light_obj.location = (2, -3, 3)
    light_obj.rotation_euler = (math.radians(45), math.radians(15), math.radians(30))
    
    # Add fill light
    fill_data = bpy.data.lights.new("FillLight", type='AREA')
    fill_data.energy = 100
    fill_data.size = 5
    fill_obj = bpy.data.objects.new("FillLight", fill_data)
    bpy.context.scene.collection.objects.link(fill_obj)
    fill_obj.location = (-2, -2, 1)
    fill_obj.rotation_euler = (math.radians(60), math.radians(-30), 0)
    
    # Render bind pose (frame 0)
    bpy.context.scene.frame_set(0)
    output_path = os.path.join(output_dir, f"{weapon_name}_bindpose.png")
    render_scene(bpy.context.scene, output_path)
    
    # Render animation frame if specified
    if animation_name:
        # Try to find and play the animation
        if weapon_armature.animation_data:
            for action in bpy.data.actions:
                if animation_name.lower() in action.name.lower():
                    weapon_armature.animation_data.action = action
                    print(f"  Playing animation: {action.name}")
                    break
        
        if frame is not None:
            bpy.context.scene.frame_set(frame)
            output_path = os.path.join(output_dir, f"{weapon_name}_{animation_name}_frame{frame}.png")
            render_scene(bpy.context.scene, output_path)
        else:
            # Render multiple frames
            start_frame = int(bpy.context.scene.frame_start)
            end_frame = int(bpy.context.scene.frame_end)
            step = max(1, (end_frame - start_frame) // 5)
            for f in range(start_frame, end_frame + 1, step):
                bpy.context.scene.frame_set(f)
                output_path = os.path.join(output_dir, f"{weapon_name}_{animation_name}_frame{f}.png")
                render_scene(bpy.context.scene, output_path)
    
    # Also render a side view
    cam.location = (3, 0, 0)
    cam.rotation_euler = (math.radians(90), 0, math.radians(90))
    bpy.context.scene.frame_set(0)
    output_path = os.path.join(output_dir, f"{weapon_name}_sideview.png")
    render_scene(bpy.context.scene, output_path)
    
    print(f"\n{'='*60}")
    print(f"Done! Renders saved to: {output_dir}")
    print(f"{'='*60}")


if __name__ == "__main__":
    main()

# Patch: better camera setup
def setup_better_camera(scene, all_meshes):
    """Set up camera that looks at the center of all meshes."""
    import mathutils
    
    # Compute bounding box of all meshes
    min_co = mathutils.Vector((float('inf'), float('inf'), float('inf')))
    max_co = mathutils.Vector((float('-inf'), float('-inf'), float('-inf')))
    
    for obj in all_meshes:
        for vert in obj.data.vertices:
            world_co = obj.matrix_world @ vert.co
            for i in range(3):
                if world_co[i] < min_co[i]:
                    min_co[i] = world_co[i]
                if world_co[i] > max_co[i]:
                    max_co[i] = world_co[i]
    
    center = (min_co + max_co) / 2
    size = max(max_co - min_co)
    
    cam_data = bpy.data.cameras.new("ViewCam2")
    cam_data.lens = 50
    cam_obj = bpy.data.objects.new("ViewCam2", cam_data)
    bpy.context.scene.collection.objects.link(cam_obj)
    
    # Position camera in front of the model
    cam_obj.location = (center.x, center.y - size * 1.5, center.z)
    
    # Look at center
    direction = center - cam_obj.location
    rot_quat = direction.to_track_quat('-Z', 'Y')
    cam_obj.rotation_euler = rot_quat.to_euler()
    
    scene.camera = cam_obj
    return cam_obj

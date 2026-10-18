#!/usr/bin/env python3
"""
gmod_simulator_v2.py — Improved GMod simulator.

Instead of using Copy Transforms constraints (which Blender's armature modifier
handles differently from GMod's bonemerge), this script:
1. Imports the weapon model (SourceIO)
2. Imports c_arms_citizen.smd (custom importer)
3. For each bone in c_arms that matches a weapon bone, DIRECTLY SETS the
   c_arms bone's matrix to the weapon bone's world matrix (in edit mode)
4. This makes the c_arms mesh deform as if bonemerged
"""
import bpy
import sys
import os
import math
import re
import mathutils

sys.path.insert(0, '/home/z/my-project/tools/SourceIO')
import source_io
from SourceIO.blender_bindings.bindings import register
register()

# Also import the SMD importer from the first simulator
sys.path.insert(0, '/home/z/my-project/scripts')
from gmod_simulator import import_smd, render_scene


def simulate_bonemerge_direct(weapon_armature, c_arms_armature):
    """Simulate GMod's bonemerge by copying weapon bone transforms to c_arms POSE bones.
    
    GMod's bonemerge copies WORLD bone transforms from the viewmodel to c_arms.
    In Blender, the armature modifier deforms the mesh based on POSE bone transforms.
    We need to set each c_arms POSE bone's world matrix to match the weapon bone's.
    """
    print("  Simulating bonemerge (pose matrix copy)...")
    
    bpy.context.view_layer.update()
    
    # Get weapon bone world matrices (rest pose = world in bone.matrix_local)
    weapon_world = {}
    for bone in weapon_armature.data.bones:
        weapon_world[bone.name] = bone.matrix_local.copy()
    
    # Set c_arms POSE bones to match weapon bone world transforms
    bpy.context.view_layer.objects.active = c_arms_armature
    bpy.ops.object.mode_set(mode='POSE')
    
    merged = 0
    for pbone in c_arms_armature.pose.bones:
        if pbone.name in weapon_world:
            # pbone.matrix is the WORLD matrix of the pose bone
            pbone.matrix = weapon_world[pbone.name].copy()
            merged += 1
    
    bpy.ops.object.mode_set(mode='OBJECT')
    bpy.context.view_layer.update()
    
    print(f"    Merged {merged} bones (pose matrix copy)")
    return merged


def main():
    argv = sys.argv
    if "--" in argv:
        argv = argv[argv.index("--") + 1:]
    else:
        argv = []
    
    if len(argv) < 2:
        print("Usage: blender --background --python gmod_simulator_v2.py -- <weapon_mdl> <output_dir>")
        return
    
    weapon_mdl = argv[0]
    output_dir = argv[1]
    os.makedirs(output_dir, exist_ok=True)
    
    weapon_name = os.path.basename(weapon_mdl).replace('.mdl', '')
    
    # Clear scene
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete(use_global=False)
    for mat in bpy.data.materials: bpy.data.materials.remove(mat)
    for mesh in bpy.data.meshes: bpy.data.meshes.remove(mesh)
    for arm in bpy.data.armatures: bpy.data.armatures.remove(arm)
    
    print(f"\n{'='*60}")
    print(f"GMod Simulator v2 — {weapon_name}")
    print(f"{'='*60}")
    
    # Step 1: Import weapon model (scale=1.0 to match SMD units)
    print(f"\n[1/4] Importing weapon: {weapon_mdl}")
    try:
        bpy.ops.sourceio.mdl(
            directory=os.path.dirname(weapon_mdl),
            files=[{'name': os.path.basename(weapon_mdl)}],
            discover_resources=False,
            import_animations=False,
            import_textures=False,
            write_qc=False,
            scale=1.0,
        )
        print("  OK")
    except Exception as e:
        print(f"  FAILED: {e}")
        return
    
    # Find weapon armature and meshes
    weapon_armature = None
    weapon_meshes = []
    for obj in bpy.context.scene.objects:
        if obj.type == 'ARMATURE':
            weapon_armature = obj
        elif obj.type == 'MESH':
            weapon_meshes.append(obj)
    
    if not weapon_armature:
        print("  ERROR: No armature found")
        return
    
    print(f"  Armature: {weapon_armature.name} ({len(weapon_armature.data.bones)} bones)")
    print(f"  Meshes: {len(weapon_meshes)}")
    
    # Step 2: Import c_arms_citizen
    print(f"\n[2/4] Importing c_arms")
    c_arms_smd = "/home/z/my-project/repos/gmod-animations/c_arms_citizen.smd"
    try:
        c_arms_armature, c_arms_mesh = import_smd(c_arms_smd)
        print("  OK")
    except Exception as e:
        print(f"  FAILED: {e}")
        import traceback; traceback.print_exc()
        return
    
    # Step 3: Simulate bonemerge (direct matrix copy)
    print(f"\n[3/4] Simulating bonemerge")
    merged = simulate_bonemerge_direct(weapon_armature, c_arms_armature)
    
    # Step 4: Render
    print(f"\n[4/4] Rendering")
    
    # Compute bounding box of all meshes (weapon + c_arms)
    depsgraph = bpy.context.evaluated_depsgraph_get()
    min_co = mathutils.Vector((float('inf'),) * 3)
    max_co = mathutils.Vector((float('-inf'),) * 3)
    
    for obj in weapon_meshes + [c_arms_mesh]:
        obj_eval = obj.evaluated_get(depsgraph)
        for vert in obj_eval.data.vertices:
            world_co = obj_eval.matrix_world @ vert.co
            for i in range(3):
                min_co[i] = min(min_co[i], world_co[i])
                max_co[i] = max(max_co[i], world_co[i])
    
    center = (min_co + max_co) / 2
    size = max(max_co - min_co)
    if size < 0.1: size = 1.0
    
    print(f"  Combined bbox: center=({center.x:.2f}, {center.y:.2f}, {center.z:.2f}) size={size:.2f}")
    
    # Setup camera
    cam_data = bpy.data.cameras.new("ViewCam")
    cam_data.lens = 50
    cam_obj = bpy.data.objects.new("ViewCam", cam_data)
    bpy.context.scene.collection.objects.link(cam_obj)
    cam_obj.location = (center.x, center.y - size * 1.5, center.z)
    direction = center - cam_obj.location
    cam_obj.rotation_euler = direction.to_track_quat('-Z', 'Y').to_euler()
    bpy.context.scene.camera = cam_obj
    
    # Lighting
    light_data = bpy.data.lights.new("KeyLight", type='SUN')
    light_data.energy = 5.0
    light_obj = bpy.data.objects.new("KeyLight", light_data)
    bpy.context.scene.collection.objects.link(light_obj)
    light_obj.location = (2, -3, 3)
    light_obj.rotation_euler = (math.radians(45), math.radians(15), math.radians(30))
    
    # Render front view
    bpy.context.scene.frame_set(0)
    output_path = os.path.join(output_dir, f"{weapon_name}_front.png")
    render_scene(bpy.context.scene, output_path)
    
    # Render side view
    cam_obj.location = (center.x + size * 1.5, center.y, center.z)
    direction = center - cam_obj.location
    cam_obj.rotation_euler = direction.to_track_quat('-Z', 'Y').to_euler()
    output_path = os.path.join(output_dir, f"{weapon_name}_side.png")
    render_scene(bpy.context.scene, output_path)
    
    # Render top view
    cam_obj.location = (center.x, center.y, center.z + size * 1.5)
    direction = center - cam_obj.location
    cam_obj.rotation_euler = direction.to_track_quat('-Z', 'Y').to_euler()
    output_path = os.path.join(output_dir, f"{weapon_name}_top.png")
    render_scene(bpy.context.scene, output_path)
    
    print(f"\nDone! Renders saved to: {output_dir}")


if __name__ == "__main__":
    main()

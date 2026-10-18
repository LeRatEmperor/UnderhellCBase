#!/usr/bin/env python3
"""
blender_render_viewmodel.py — Render a compiled viewmodel in Blender and save a PNG.

This script:
1. Imports a compiled .mdl file using SourceIO
2. Sets up a camera at the viewmodel position
3. Renders the model to a PNG file
4. Also renders the c_arms_citizen model for comparison
"""
import bpy
import sys
import os
import math

# Add SourceIO to path
sys.path.insert(0, '/home/z/my-project/tools/SourceIO')

# Load and register SourceIO
import source_io
from SourceIO.blender_bindings.bindings import register
register()

def render_weapon(weapon_name, mdl_path, output_path):
    """Render a weapon viewmodel and save as PNG."""
    # Clear scene
    bpy.ops.object.select_all(action='SELECT')
    bpy.ops.object.delete(use_global=False)
    
    # Remove all materials
    for mat in bpy.data.materials:
        bpy.data.materials.remove(mat)
    
    # Remove all meshes
    for mesh in bpy.data.meshes:
        bpy.data.meshes.remove(mesh)
    
    # Remove all armatures
    for arm in bpy.data.armatures:
        bpy.data.armatures.remove(arm)
    
    print(f"\n=== Rendering {weapon_name} ===")
    print(f"  MDL: {mdl_path}")
    print(f"  Output: {output_path}")
    
    # Import the model
    try:
        bpy.ops.sourceio.mdl(
            directory=os.path.dirname(mdl_path),
            files=[{'name': os.path.basename(mdl_path)}],
            discover_resources=False,
            import_animations=False,
            import_textures=False,
            write_qc=False,
        )
        print("  Import: SUCCESS")
    except Exception as e:
        print(f"  Import FAILED: {e}")
        return False
    
    # List all objects
    armature = None
    meshes = []
    for obj in bpy.context.scene.objects:
        if obj.type == 'ARMATURE':
            armature = obj
        elif obj.type == 'MESH':
            meshes.append(obj)
    
    if not armature:
        print("  ERROR: No armature found")
        return False
    
    print(f"  Armature: {armature.name}, bones: {len(armature.data.bones)}")
    print(f"  Meshes: {len(meshes)}")
    
    # Get the bounding box of all meshes
    min_co = [float('inf')] * 3
    max_co = [float('-inf')] * 3
    for obj in meshes:
        for vert in obj.data.vertices:
            world_co = obj.matrix_world @ vert.co
            for i in range(3):
                if world_co[i] < min_co[i]:
                    min_co[i] = world_co[i]
                if world_co[i] > max_co[i]:
                    max_co[i] = world_co[i]
    
    center = [(min_co[i] + max_co[i]) / 2 for i in range(3)]
    size = max(max_co[i] - min_co[i] for i in range(3))
    
    print(f"  Bounding box: min=({min_co[0]:.2f}, {min_co[1]:.2f}, {min_co[2]:.2f})")
    print(f"                max=({max_co[0]:.2f}, {max_co[1]:.2f}, {max_co[2]:.2f})")
    print(f"  Center: ({center[0]:.2f}, {center[1]:.2f}, {center[2]:.2f})")
    print(f"  Size: {size:.2f}")
    
    # Set up camera - viewmodel is typically viewed from slightly above and behind
    # The camera looks at the center of the model
    cam_data = bpy.data.cameras.new(name="ViewCam")
    cam_obj = bpy.data.objects.new("ViewCam", cam_data)
    bpy.context.scene.collection.objects.link(cam_obj)
    
    # Position camera to look at the model from the front
    cam_obj.location = (center[0], center[1] - size * 0.8, center[2])
    cam_obj.rotation_euler = (math.radians(90), 0, 0)
    
    # Point camera at center
    direction = (center[0] - cam_obj.location[0], 
                center[1] - cam_obj.location[1], 
                center[2] - cam_obj.location[2])
    # Simple approach: just look at the center
    import mathutils
    dir_vec = mathutils.Vector(direction)
    cam_obj.rotation_euler = dir_vec.to_track_quat('-Z', 'Y').to_euler()
    
    # Set up lighting
    light_data = bpy.data.lights.new(name="ViewLight", type='SUN')
    light_data.energy = 3.0
    light_obj = bpy.data.objects.new("ViewLight", light_data)
    bpy.context.scene.collection.objects.link(light_obj)
    light_obj.location = (center[0] + 5, center[1] - 5, center[2] + 5)
    light_obj.rotation_euler = (math.radians(45), 0, math.radians(45))
    
    # Set render settings
    bpy.context.scene.render.resolution_x = 800
    bpy.context.scene.render.resolution_y = 600
    bpy.context.scene.render.engine = 'CYCLES'
    bpy.context.scene.cycles.device = 'CPU'
    bpy.context.scene.render.filepath = output_path
    bpy.context.scene.camera = cam_obj
    
    # Set world background to a neutral gray
    bpy.context.scene.world.node_tree.nodes["Background"].inputs[0].default_value = (0.5, 0.5, 0.5, 1.0)
    bpy.context.scene.world.node_tree.nodes["Background"].inputs[1].default_value = 1.0
    
    # Render
    bpy.ops.render.render(write_still=True)
    print(f"  Render saved to: {output_path}")
    
    return True


def main():
    import argparse
    
    # Parse arguments
    argv = sys.argv
    if "--" in argv:
        argv = argv[argv.index("--") + 1:]
    else:
        argv = []
    
    if len(argv) < 2:
        print("Usage: blender --background --python blender_render_viewmodel.py -- <weapon_name> <mdl_path> [output_path]")
        return
    
    weapon_name = argv[0]
    mdl_path = argv[1]
    output_path = argv[2] if len(argv) > 2 else f"/home/z/my-project/scripts/renders/{weapon_name}.png"
    
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    
    render_weapon(weapon_name, mdl_path, output_path)


if __name__ == "__main__":
    main()

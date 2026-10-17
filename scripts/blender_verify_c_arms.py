#!/usr/bin/env python3
"""
blender_verify_c_arms.py — Use Blender + SourceIO to import the BF3 m416 model
and verify the c_arms retargeting worked.
"""
import bpy
import sys
import os
import math

# Add SourceIO to path (since Blender doesn't load it as addon in headless mode)
sys.path.insert(0, '/home/z/my-project/tools/SourceIO')

# Load and register SourceIO
print("=== Loading SourceIO ===")
import source_io
print(f"SourceIO loaded from: {source_io.__file__}")
print(f"loaded_as_addon: {source_io.loaded_as_addon()}")
print(f"running_in_blender: {source_io.running_in_blender()}")

# Register the addon (this registers all operators)
from SourceIO.blender_bindings.bindings import register
register()
print("SourceIO registered!")

# List sourceio operators
print("\n=== Registered sourceio operators ===")
for op_name in dir(bpy.ops):
    if 'source' in op_name.lower():
        sub_ops = [x for x in dir(getattr(bpy.ops, op_name)) if not x.startswith('_')]
        print(f"  bpy.ops.{op_name} -> {sub_ops}")

# Import the compiled c_m416.mdl
print("\n=== Importing c_m416.mdl ===")
model_path = "/home/z/my-project/compile/m416/compiled/c_m416.mdl"
import os
model_dir = os.path.dirname(model_path)
model_name = os.path.basename(model_path)

try:
    bpy.ops.sourceio.mdl(
        directory=model_dir,
        files=[{"name": model_name}],
        discover_resources=False,
        import_animations=False,
        import_textures=False,
        write_qc=False,
    )
    print("Import succeeded!")
except Exception as e:
    print(f"Import failed: {e}")
    import traceback
    traceback.print_exc()

# List all objects in the scene
print("\n=== Scene objects ===")
for obj in bpy.context.scene.objects:
    if obj.type == 'MESH':
        print(f"\n{obj.name} (MESH)")
        print(f"  Vertices: {len(obj.data.vertices)}")
        print(f"  Polygons: {len(obj.data.polygons)}")
        if obj.vertex_groups:
            print(f"  Vertex groups (bone weights): {len(obj.vertex_groups)}")
            for vg in list(obj.vertex_groups)[:5]:
                print(f"    {vg.name}")
            if len(obj.vertex_groups) > 5:
                print(f"    ... and {len(obj.vertex_groups) - 5} more")
    elif obj.type == 'ARMATURE':
        print(f"\n{obj.name} (ARMATURE)")
        print(f"  Total bones: {len(obj.data.bones)}")
        print(f"  Hand bones (first 20):")
        # List bones that look like hand bones
        for bone in obj.data.bones:
            if 'Bip01' in bone.name or 'Spine4' in bone.name:
                mat = bone.matrix_local
                head = bone.head_local
                tail = bone.tail_local
                euler = mat.to_euler()
                print(f"    {bone.name}: pos=({head.x:.2f}, {head.y:.2f}, {head.z:.2f}) "
                      f"rot=({math.degrees(euler.x):.1f}, {math.degrees(euler.y):.1f}, {math.degrees(euler.z):.1f})")

# Save the blend file
output_blend = "/home/z/my-project/scripts/m416_verification.blend"
bpy.ops.wm.save_as_mainfile(filepath=output_blend)
print(f"\nBlend file saved to: {output_blend}")

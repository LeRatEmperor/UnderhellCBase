"""
Blender script to:
1. Import acwr.smd
2. Set the c_hands_invisible material to fully transparent (diffuse_color alpha=0)
3. Re-export the SMD

The export path is set via context.scene.vs.export_path (Blender Source Tools convention).
"""
import sys, os
sys.path.insert(0, '/home/z/my-project/tools/blender/blender-4.2.0-linux-x64/4.2/scripts/addons')
import bpy
import io_scene_valvesource

io_scene_valvesource.register()
print("[OK] Registered Blender Source Tools")

# Clear scene
bpy.ops.wm.read_factory_settings(use_empty=True)

# Import the SMD
smd_path = "/home/z/my-project/compile/acwr/source/acwr.smd"
bpy.ops.import_scene.smd(filepath=smd_path, createCollections=True)
print(f"[OK] Imported {smd_path}")

# Configure export path on the scene
scene = bpy.context.scene
scene.vs.export_path = "/home/z/my-project/compile/acwr/source/"  # absolute path
scene.vs.export_format = 'SMD'  # export as SMD, not DMX

# Set c_hands_invisible material to fully transparent
target_mat_name = "c_hands_invisible"
if target_mat_name in bpy.data.materials:
    mat = bpy.data.materials[target_mat_name]
    mat.use_nodes = False
    mat.diffuse_color = (0.0, 0.0, 0.0, 0.0)  # RGBA - alpha 0 = fully transparent
    mat.specular_color = (0.0, 0.0, 0.0)
    print(f"[OK] Set {target_mat_name}: diffuse_color={mat.diffuse_color}")
else:
    print(f"[!] Material '{target_mat_name}' not found")

# List meshes using the invisible material
print("\nMeshes using c_hands_invisible:")
for obj in bpy.data.objects:
    if obj.type != 'MESH': continue
    for slot in obj.material_slots:
        if slot.material and slot.material.name == target_mat_name:
            vcount = len(obj.data.vertices)
            print(f"  {obj.name}: {vcount} vertices")

# Select all exportable objects (meshes + armature)
bpy.ops.object.select_all(action='DESELECT')
export_objs = [o for o in bpy.data.objects if o.type in ("MESH", "ARMATURE") and o.name in bpy.context.view_layer.objects]
for obj in export_objs:
    obj.select_set(True)
if export_objs:
    bpy.context.view_layer.objects.active = export_objs[0]

# Export
out_path = "/home/z/my-project/compile/acwr/source/acwr.smd"
print(f"\nExporting to {out_path}...")
try:
    bpy.ops.export_scene.smd(export_scene=True)
    print(f"[OK] Exported SMD")
    print(f"  size: {os.path.getsize(out_path)} bytes")
except Exception as e:
    print(f"[FAIL] Export: {e}")
    import traceback
    traceback.print_exc()

print("[DONE]")

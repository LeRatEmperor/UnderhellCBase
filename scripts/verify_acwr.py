"""Blender script to verify the acwr.smd loads correctly with mesh data."""
import sys
sys.path.insert(0, '/home/z/my-project/tools/blender/blender-4.2.0-linux-x64/4.2/scripts/addons')
import bpy
import io_scene_valvesource

try:
    io_scene_valvesource.register()
    print("[OK] Registered Blender Source Tools")
except Exception as e:
    print(f"[FAIL] Register: {e}")
    sys.exit(1)

# Clear scene
bpy.ops.wm.read_factory_settings(use_empty=True)

# Import the SMD
try:
    bpy.ops.import_scene.smd(
        filepath="/home/z/my-project/compile/acwr/source/acwr.smd",
        createCollections=True,
    )
    print("[OK] Imported acwr.smd")
except Exception as e:
    print(f"[FAIL] Import: {e}")
    sys.exit(1)

# Inspect the scene
print(f"\nScene contents:")
print(f"  Objects: {len(bpy.data.objects)}")
print(f"  Meshes: {len(bpy.data.meshes)}")
print(f"  Materials: {len(bpy.data.materials)}")
print(f"  Armatures: {len([o for o in bpy.data.objects if o.type == 'ARMATURE'])}")

# Count triangles per material
mat_counts = {}
for obj in bpy.data.objects:
    if obj.type != 'MESH': continue
    for slot in obj.material_slots:
        if slot.material:
            name = slot.material.name
            mat_counts[name] = mat_counts.get(name, 0) + 1

print(f"\nMaterials used:")
for name, count in sorted(mat_counts.items()):
    print(f"  {name}: {count} mesh(es)")

# List all bones
armatures = [o for o in bpy.data.objects if o.type == 'ARMATURE']
if armatures:
    arm = armatures[0]
    print(f"\nArmature '{arm.name}': {len(arm.data.bones)} bones")
    valve_biped = [b for b in arm.data.bones if 'ValveBiped' in b.name]
    print(f"  ValveBiped bones: {len(valve_biped)}")
    # Print first 5
    for b in valve_biped[:5]:
        print(f"    - {b.name}")

# Verify c_hands_invisible material exists
if 'c_hands_invisible' in bpy.data.materials:
    mat = bpy.data.materials['c_hands_invisible']
    print(f"\nc_hands_invisible material:")
    print(f"  name: {mat.name}")
    print(f"  use_nodes: {mat.use_nodes}")
    print(f"  alpha: {mat.alpha}")
else:
    print("\n[!] c_hands_invisible material NOT FOUND in scene")

print("\n[DONE]")

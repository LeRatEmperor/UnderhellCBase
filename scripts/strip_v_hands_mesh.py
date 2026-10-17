#!/usr/bin/env python3
"""
strip_v_hands_mesh.py — Strip v_hands/sleeve_diffuse triangle data from SMD files.

PROBLEM:
- 9 weapons have the hand mesh BAKED INTO their main weapon mesh SMD (not in a separate hands.smd bodygroup)
- These weapons are: g18, m1911, m249, m82a3, m9, m93r, mp412, mp443, sv98
- Their main mesh SMDs (m9.smd, m249.smd, etc.) contain "v_hands" and "sleeve_diffuse" material triangles
- These triangles render as the old baked-in hand mesh (with missing textures, since we removed the v_hands material references)

FIX:
- For each .smd file in each weapon's source folder, strip out any triangle block that uses
  the "v_hands" or "sleeve_diffuse" material
- This removes the baked-in hand mesh geometry entirely
- The c_arms (via bonemerge) will provide the hand mesh instead

SMD format triangles section:
triangles
<material_name>
  <bone_id> <x> <y> <z> <nx> <ny> <nz> <u> <v> [<weight_data>]
  <bone_id> <x> <y> <z> <nx> <ny> <nz> <u> <v> [<weight_data>]
  <bone_id> <x> <y> <z> <nx> <ny> <nz> <u> <v> [<weight_data>]
<material_name>
  ... (next triangle)
end
"""
import os
import re
from pathlib import Path

COMPILE_DIR = Path("/home/z/my-project/compile")

# Materials to strip (these are the baked-in hand textures we want to remove)
HAND_MATERIALS = {"v_hands", "sleeve_diffuse"}


def strip_hand_triangles_from_smd(smd_path):
    """Strip v_hands/sleeve_diffuse triangle blocks from an SMD file.
    Returns the number of triangles stripped.
    """
    with open(smd_path, 'r', errors='ignore') as f:
        content = f.read()

    original = content
    triangles_stripped = 0

    # Find the triangles section
    triangles_match = re.search(r'^triangles\s*\n', content, re.MULTILINE)
    if not triangles_match:
        return 0

    # Get the section between "triangles" and "end"
    triangles_start = triangles_match.end()
    end_match = re.search(r'^end\s*$', content[triangles_start:], re.MULTILINE)
    if not end_match:
        return 0

    triangles_end = triangles_start + end_match.start()
    triangles_section = content[triangles_start:triangles_end]

    # Parse triangle blocks: each starts with a material name line, followed by 3 vertex lines
    new_triangles = []
    current_material = None
    current_vertices = []

    lines = triangles_section.split('\n')
    i = 0
    while i < len(lines):
        line = lines[i]
        stripped = line.strip()

        # Check if this is a material name line (not indented, not a vertex)
        # Vertex lines start with whitespace + bone_id (a number)
        is_vertex = bool(re.match(r'^\s+\d+\s+', line))

        if not is_vertex and stripped:
            # This is a material name line
            # First, save the previous triangle if it's not a hand material
            if current_material is not None and current_vertices:
                if current_material.lower() not in HAND_MATERIALS:
                    new_triangles.append(current_material)
                    new_triangles.extend(current_vertices)
                else:
                    triangles_stripped += 1

            current_material = stripped
            current_vertices = []
        elif is_vertex:
            current_vertices.append(line)
        elif not stripped:
            # Empty line - preserve
            if current_material is not None and current_vertices:
                if current_material.lower() not in HAND_MATERIALS:
                    new_triangles.append(current_material)
                    new_triangles.extend(current_vertices)
                else:
                    triangles_stripped += 1
                current_material = None
                current_vertices = []

        i += 1

    # Save the last triangle if any
    if current_material is not None and current_vertices:
        if current_material.lower() not in HAND_MATERIALS:
            new_triangles.append(current_material)
            new_triangles.extend(current_vertices)
        else:
            triangles_stripped += 1

    # Rebuild the triangles section
    new_triangles_str = '\n'.join(new_triangles)
    if new_triangles_str:
        new_triangles_str += '\n'

    new_content = (
        content[:triangles_start] +
        new_triangles_str +
        content[triangles_end:]
    )

    if triangles_stripped > 0:
        with open(smd_path, 'w') as f:
            f.write(new_content)

    return triangles_stripped


def main():
    print("=" * 70)
    print("strip_v_hands_mesh.py")
    print("Strip v_hands/sleeve_diffuse triangle data from SMD files")
    print("=" * 70)

    total_stripped = 0
    weapons_processed = 0

    for weapon_dir in sorted(COMPILE_DIR.iterdir()):
        if not weapon_dir.is_dir():
            continue
        if weapon_dir.name == "Battlefield3":
            continue

        weapon = weapon_dir.name
        src_dir = weapon_dir / "source"
        if not src_dir.exists():
            continue

        weapon_stripped = 0
        weapon_smds_modified = 0

        # Process all SMD files in the source folder (including anims subfolder)
        for smd in sorted(list(src_dir.glob("*.smd")) + list((src_dir / f"{weapon}_anims").glob("*.smd")) if (src_dir / f"{weapon}_anims").exists() else list(src_dir.glob("*.smd"))):
            # Check if this SMD contains v_hands material
            with open(smd, 'r', errors='ignore') as f:
                content = f.read()

            if 'v_hands' in content.lower() or 'sleeve_diffuse' in content.lower():
                stripped = strip_hand_triangles_from_smd(smd)
                if stripped > 0:
                    rel_name = smd.relative_to(src_dir)
                    print(f"  {weapon}/{rel_name}: stripped {stripped} hand triangles")
                    weapon_stripped += stripped
                    weapon_smds_modified += 1

        if weapon_stripped > 0:
            print(f"  {weapon}: total {weapon_stripped} hand triangles stripped from {weapon_smds_modified} SMDs")
            total_stripped += weapon_stripped
            weapons_processed += 1

    print()
    print("=" * 70)
    print(f"Total: stripped {total_stripped} hand triangles from {weapons_processed} weapons")
    print("=" * 70)


if __name__ == "__main__":
    main()

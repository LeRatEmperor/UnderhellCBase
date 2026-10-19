#!/usr/bin/env python3
"""split_smd_hands.py — Split an SMD into two files based on texture name.

Splits acwr.smd into:
- acwr_body.smd: all triangles EXCEPT v_hands and sleeve_diffuse
- acwr_hands.smd: only v_hands and sleeve_diffuse triangles

Both files keep the same nodes/skeleton sections so they can each be loaded
by studiomdl as a $bodygroup studio reference.
"""
import sys
import re
from pathlib import Path

HANDS_TEXTURES = {"v_hands", "sleeve_diffuse"}


def split_smd(input_smd: Path, body_out: Path, hands_out: Path):
    text = input_smd.read_text()

    # Find triangles section start
    m = re.search(r'^triangles[ \t]*\r?\n', text, re.MULTILINE)
    if not m:
        print(f"[!] No triangles section found in {input_smd}")
        return False

    tri_start = m.start()
    tri_body_start = m.end()
    # Find the closing "end"
    end_m = re.search(r'^end[ \t]*\r?\n?', text[tri_body_start:], re.MULTILINE)
    if not end_m:
        print(f"[!] No closing 'end' for triangles section")
        return False
    tri_end_abs = tri_body_start + end_m.start()
    after_tri = text[tri_body_start + end_m.end():]

    header = text[:tri_start]  # everything before "triangles"
    triangles_text = text[tri_body_start:tri_end_abs]

    # Split triangles_text into per-triangle chunks
    # Each triangle: a texture name line, then 3 vertex lines
    lines = triangles_text.split('\n')
    body_triangles = []
    hands_triangles = []
    i = 0
    while i < len(lines):
        line = lines[i].rstrip()
        if not line:
            i += 1
            continue
        # This is a texture name. Read 3 vertex lines.
        tex_name = line.strip()
        # Find next 3 non-empty lines
        verts = []
        j = i + 1
        while j < len(lines) and len(verts) < 3:
            vline = lines[j].rstrip()
            if vline:
                verts.append(vline)
            j += 1
        # Add to appropriate bucket
        if tex_name in HANDS_TEXTURES:
            hands_triangles.append(tex_name)
            hands_triangles.extend(verts)
        else:
            body_triangles.append(tex_name)
            body_triangles.extend(verts)
        i = j

    # Write body SMD
    body_text = header + "triangles\n" + "\n".join(body_triangles) + "\nend\n" + after_tri
    body_out.write_text(body_text)
    print(f"[+] Wrote {body_out} ({len(body_triangles) // 4} triangles)")

    # Write hands SMD
    hands_text = header + "triangles\n" + "\n".join(hands_triangles) + "\nend\n" + after_tri
    hands_out.write_text(hands_text)
    print(f"[+] Wrote {hands_out} ({len(hands_triangles) // 4} triangles)")

    return True


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print(f"Usage: {sys.argv[0]} <input.smd> <body_out.smd> <hands_out.smd>")
        sys.exit(1)
    ok = split_smd(Path(sys.argv[1]), Path(sys.argv[2]), Path(sys.argv[3]))
    sys.exit(0 if ok else 1)

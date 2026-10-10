#!/usr/bin/env python3
"""
Fix scope overlay PNGs: fill transparent areas with white RGB.

The Unlittwotexture shader multiplies $basetexture × $texture2 using
the RGB values (not alpha). Transparent areas with RGB=(0,0,0) make
the RT dark (RT × 0 = 0).

Fix: set transparent pixels to RGB=(255,255,255) so the RT shows
through (RT × 1 = RT). The crosshair stays dark (RT × 0 = black lines).
"""

from PIL import Image
import os

SCOPES_DIR = "/home/z/my-project/wwiiunderhell_kate/materials/scopes"

PNG_FILES = [
    "scope_overlay_american.png",
    "scope_overlay_britain.png",
    "scope_overlay_german.png",
    "scope_overlay_japanese.png",
    "scope_overlay_mp.png",
]


def fix_png(filepath):
    """Fill transparent areas with white RGB, preserve alpha."""
    img = Image.open(filepath).convert("RGBA")
    pixels = img.load()
    width, height = img.size

    changed = 0
    for y in range(height):
        for x in range(width):
            r, g, b, a = pixels[x, y]
            if a == 0:
                # Fully transparent — set RGB to white
                pixels[x, y] = (255, 255, 255, 0)
                changed += 1
            elif a < 255:
                # Semi-transparent — blend toward white
                # (keeps the reticle edges anti-aliased but not dark)
                ratio = a / 255.0
                new_r = int(r * ratio + 255 * (1 - ratio))
                new_g = int(g * ratio + 255 * (1 - ratio))
                new_b = int(b * ratio + 255 * (1 - ratio))
                pixels[x, y] = (new_r, new_g, new_b, a)
                changed += 1

    img.save(filepath)
    return changed


def main():
    print(f"Fixing {len(PNG_FILES)} scope overlay PNGs...")
    for fname in PNG_FILES:
        filepath = os.path.join(SCOPES_DIR, fname)
        if not os.path.exists(filepath):
            print(f"  MISSING: {fname}")
            continue
        changed = fix_png(filepath)
        print(f"  FIXED: {fname} ({changed} pixels adjusted)")
    print("\nDone! Re-import these PNGs in VTFEdit with:")
    print("  - Texture Format: DXT5")
    print("  - Gamma Correction: Checked (2.20)")
    print("  - Texture Type: 2D Texture (NOT Volume)")
    print("  - Generate Mipmaps: Checked")


if __name__ == "__main__":
    main()

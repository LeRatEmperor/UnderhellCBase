#!/usr/bin/env python3
"""
Create a reflex dot reticle texture: small dot in center + ring around it.
"""

from PIL import Image, ImageDraw
import os

OUTPUT_DIR = "/home/z/my-project/wwiiunderhell_kate/materials/reflex"

def create_reflex_dot():
    """Create a 128x128 texture: small center dot + ring, transparent background."""
    size = 128
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    center = size // 2

    # Draw the ring (outer circle outline)
    ring_outer = 40  # outer radius of ring
    ring_inner = 34  # inner radius of ring
    for r in range(ring_outer, ring_inner, -1):
        # Draw a circle outline at radius r
        draw.ellipse(
            [center - r, center - r, center + r, center + r],
            outline=(255, 0, 0, 255),
            width=1
        )

    # Draw the center dot (solid filled circle)
    dot_radius = 6
    draw.ellipse(
        [center - dot_radius, center - dot_radius, center + dot_radius, center + dot_radius],
        fill=(255, 0, 0, 255)
    )

    # Add subtle glow around the center dot
    for r in range(dot_radius + 4, dot_radius, -1):
        alpha = int(40 * (1 - (r - dot_radius) / 4))
        draw.ellipse(
            [center - r, center - r, center + r, center + r],
            fill=(255, 0, 0, alpha)
        )

    return img


def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    img = create_reflex_dot()
    png_path = os.path.join(OUTPUT_DIR, "reflex_dot.png")
    img.save(png_path)
    print(f"Created: {png_path}")

    # VMT already exists, just verify
    vmt_path = os.path.join(OUTPUT_DIR, "reflex_dot.vmt")
    if not os.path.exists(vmt_path):
        with open(vmt_path, "w") as f:
            f.write('''"UnlitGeneric"
{
    $basetexture "reflex/reflex_dot"
    $translucent "1"
    $vertexalpha "1"
    $vertexcolor "1"
    $additive "1"
}
''')
        print(f"Created: {vmt_path}")
    else:
        print(f"VMT exists: {vmt_path}")


if __name__ == "__main__":
    main()

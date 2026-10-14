#!/usr/bin/env python3
"""
Create a simple red dot reticle texture for the WWII reflex sight.
The dot is a small red circle on a transparent background.
"""

from PIL import Image, ImageDraw
import os

OUTPUT_DIR = "/home/z/my-project/wwiiunderhell_kate/materials/reflex"

def create_red_dot():
    """Create a 64x64 red dot texture with transparent background."""
    size = 64
    img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)

    # Draw a red dot in the center
    # The dot is ~8px diameter (scaled to 128px on screen = ~16px visual)
    center = size // 2
    radius = 4  # 8px diameter

    # Draw the dot with anti-aliasing (draw multiple circles with varying alpha)
    for r in range(radius, 0, -1):
        alpha = 255 if r == radius else int(255 * (r / radius))
        # Actually just draw a solid red dot
        draw.ellipse(
            [center - r, center - r, center + r, center + r],
            fill=(255, 0, 0, 255)
        )

    # Add a subtle glow (larger, more transparent circle)
    for r in range(radius + 3, radius, -1):
        alpha = int(60 * (1 - (r - radius) / 3))
        draw.ellipse(
            [center - r, center - r, center + r, center + r],
            fill=(255, 0, 0, alpha)
        )

    return img


def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    # Create the red dot PNG
    img = create_red_dot()
    png_path = os.path.join(OUTPUT_DIR, "reflex_dot.png")
    img.save(png_path)
    print(f"Created: {png_path}")

    # Create the VMT
    vmt_path = os.path.join(OUTPUT_DIR, "reflex_dot.vmt")
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


if __name__ == "__main__":
    main()

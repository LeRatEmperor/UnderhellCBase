# Asset references

This category indexes bundled asset path manifests shipped with GMod: the `icon16/` and `flags16/` material filename lists, and the engine/game sound path tree. These are not Lua functions — they are string paths you feed into asset loaders.

Members are called by path, not by method. Materials are loaded once and cached with `Material("icon16/<name>.png")` / `Material("flags16/<code>.png")`, then drawn via `surface.SetMaterial`/`surface.DrawTexturedRect` or used directly on `DImage`/`ImageButton` panels (all client-side). Sound paths are passed to `entity:EmitSound(path)` (positional, networked), `sound.Play(path, pos)` (one-shot at a position), or `surface.PlaySound(path)` (2D UI, client). Choose the right unit by what you need: a small UI glyph → icon16; a nation/locale flag → flags16; anything audible → the sound tree. Always copy the exact path from the per-unit file; a typo silently loads an error material or no sound.

## Most-used
- [materials-icon16.md](materials-icon16.md) — 1011 16×16 Silkicon glyphs; the default icon set for nearly every GMod menu, DButton, and tooltip.
- [sounds.md](sounds.md) — full engine/game sound path tree; the source for every `EmitSound`/`surface.PlaySound` call.
- [materials-flags16.md](materials-flags16.md) — 247 country flag images for locale/nation pickers and player-origin UI.

**Open the per-unit file for exact signatures — do not guess.**

- [materials-icon16.md](materials-icon16.md) — 1011 16×16 Silkicon images (`Material("icon16/...")`)
- [materials-flags16.md](materials-flags16.md) — 247 country flag images (`Material("flags16/...")`)
- [sounds.md](sounds.md) — engine/game sound path tree (`EmitSound`, `sound.Play`, `surface.PlaySound`)

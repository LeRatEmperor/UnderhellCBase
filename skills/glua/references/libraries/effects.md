# effects

**Realm:** Shared  ·  **Members:** 7

The effects library allows you to manually add scripted effects.

[wiki page](https://wiki.facepunch.com/gmod/effects)

### effects.BeamRingPoint · Shared
`effects.BeamRingPoint(pos: Vector, lifetime: number, startRad: number, endRad: number, width: number, amplitude: number, color: Color, extra: table)`

Creates a "beam ring point" effect.

**Arguments:**
- `pos` (Vector) — The origin position of the effect.
- `lifetime` (number) — How long the effect will be drawing for, in seconds.
- `startRad` (number) — Initial radius of the effect.
- `endRad` (number) — Final radius of the effect, at the end of the effect's lifetime.
- `width` (number) — How thick the beam should be.
- `amplitude` (number) — How noisy the beam should be.
- `color` (Color) — Beam's Color.
- `extra` (table) — Extra info, all optional.

[wiki](https://wiki.facepunch.com/gmod/effects.BeamRingPoint)

---

### effects.Bubbles · Shared
`effects.Bubbles(mins: Vector, maxs: Vector, count: number, height: number, speed: number = 0, delay: number = 0)`

Creates a bunch of bubbles inside a defined box.

**Arguments:**
- `mins` (Vector) — The lowest extents of the box.
- `maxs` (Vector) — The highest extents of the box.
- `count` (number) — How many bubbles to spawn.
- `height` (number) — How high the bubbles can fly up before disappearing.
- `speed` (number, default `0`) — How quickly the bubbles move.
- `delay` (number, default `0`) — Delay in seconds after the function call and before the effect actually spawns.

[wiki](https://wiki.facepunch.com/gmod/effects.Bubbles)

---

### effects.BubbleTrail · Shared
`effects.BubbleTrail(startPos: Vector, endPos: Vector, count: number, height: number, speed: number = 0, delay: number = 0)`

Creates a bubble trail effect, the very same you get when shooting underwater.

**Arguments:**
- `startPos` (Vector) — The start position of the effect.
- `endPos` (Vector) — The end position of the effects.
- `count` (number) — How many bubbles to spawn.
- `height` (number) — How high the bubbles can fly up before disappearing.
- `speed` (number, default `0`) — How quickly the bubbles move.
- `delay` (number, default `0`) — Delay in seconds after the function call and before the effect actually spawns.

[wiki](https://wiki.facepunch.com/gmod/effects.BubbleTrail)

---

### effects.Create · Client · `INTERNAL`
`effects.Create(name: string) → table`

Returns the table of the effect specified.

**Arguments:**
- `name` (string) — Effect name.

**Returns:**
- table — The effect table.

[wiki](https://wiki.facepunch.com/gmod/effects.Create) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/effects.lua#L50-L70)

---

### effects.GetList · Client · `INTERNAL`
`effects.GetList() → table`

Returns a list of all Lua-defined effects.

**Returns:**
- table — The effects table.

[wiki](https://wiki.facepunch.com/gmod/effects.GetList) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/effects.lua#L72-L80)

---

### effects.Register · Client · `INTERNAL`
`effects.Register(effect_table: table, name: string)`

Registers a new effect.

**Arguments:**
- `effect_table` (table) — Effect table.
- `name` (string) — Effect name.

[wiki](https://wiki.facepunch.com/gmod/effects.Register) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/effects.lua#L17-L44)

---

### effects.TracerSound · Client
`effects.TracerSound(start: Vector, endpos: Vector, tracerType: number = 1, soundOverride: string = nil)`

Imitates the "near miss" tracer sound, with the ability to override the sound played.

The frequency of the sound is limited internally, as to not overwhelm the player. (same as normal tracers)

**Arguments:**
- `start` (Vector) — Start position of the tracer.
- `endpos` (Vector) — End position of the tracer.
- `tracerType` (number, default `1`) — Tracer type.
- `soundOverride` (string, default `nil`) — If set, this sound will be played instead of the default sound.

[wiki](https://wiki.facepunch.com/gmod/effects.TracerSound)

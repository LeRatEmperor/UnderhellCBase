# widgets

**Realm:** Shared  ·  **Members:** 2

The widgets library.

Widgets allow the player to have mouse interaction with entities, such as being able to manipulate the [bones of an NPC](https://www.youtube.com/watch?v=O3gG0t39-pQ).

[wiki page](https://wiki.facepunch.com/gmod/widgets)

### widgets.PlayerTick · Shared · `INTERNAL`
`widgets.PlayerTick(ply: Player, mv: CMoveData)`

Automatically called to update all widgets.

**Arguments:**
- `ply` (Player) — The player
- `mv` (CMoveData) — Player move data

[wiki](https://wiki.facepunch.com/gmod/widgets.PlayerTick) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/widget.lua#L87-L100)

---

### widgets.RenderMe · Client
`widgets.RenderMe(ent: Entity)`

Renders a widget. Normally you won't need to call this.

**Arguments:**
- `ent` (Entity) — Widget entity to render

[wiki](https://wiki.facepunch.com/gmod/widgets.RenderMe) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/widget.lua#L109-L125)

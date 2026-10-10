# properties

**Realm:** Shared  ·  **Members:** 7

The properties library gives you access to the menu that shows up when right clicking entities while holding C.

[wiki page](https://wiki.facepunch.com/gmod/properties)

### properties.Add · Shared
`properties.Add(name: string, propertyData: table)`

Add properties to the properties module. Properties can be blocked via [GM:CanProperty](https://wiki.facepunch.com/gmod/GM:CanProperty).

**Arguments:**
- `name` (string) — A unique name used to identify the property
- `propertyData` (table) — A table that defines the property.

[wiki](https://wiki.facepunch.com/gmod/properties.Add) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/properties.lua#L28-L36)

---

### properties.CanBeTargeted · Shared
`properties.CanBeTargeted(ent: Entity, ply: Player) → boolean`

Returns true if given entity can be targeted by the player via the properties system.

This should be used serverside in your properties to prevent abuse by clientside scripting.

**Arguments:**
- `ent` (Entity) — The entity to test
- `ply` (Player) — If given, will also perform a distance check based on the entity's Orientated Bounding Box.

**Returns:**
- boolean — True if entity can be targeted, false otherwise

[wiki](https://wiki.facepunch.com/gmod/properties.CanBeTargeted) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/properties.lua#L104-L118)

---

### properties.GetHovered · Client
`properties.GetHovered(pos: Vector, aimVec: Vector) → Entity`

Returns an entity player is hovering over with their cursor.

**Arguments:**
- `pos` (Vector) — Eye position of local player, Entity:EyePos
- `aimVec` (Vector) — Aim vector of local player, Player:GetAimVector

**Returns:**
- Entity — The hovered entity

[wiki](https://wiki.facepunch.com/gmod/properties.GetHovered) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/properties.lua#L120-L154)

---

### properties.List · Shared
`properties.List()`

[wiki](https://wiki.facepunch.com/gmod/properties.List)

---

### properties.OnScreenClick · Shared
`properties.OnScreenClick(eyepos: Vector, eyevec: Vector)`

Checks if player hovers over any entities and open a properties menu for it.

**Arguments:**
- `eyepos` (Vector) — The eye pos of a player
- `eyevec` (Vector) — The aim vector of a player

[wiki](https://wiki.facepunch.com/gmod/properties.OnScreenClick) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/properties.lua#L93-L100)

---

### properties.OpenEntityMenu · Shared
`properties.OpenEntityMenu(ent: Entity, tr: table)`

Opens properties menu for given entity.

**Arguments:**
- `ent` (Entity) — The entity to open menu for
- `tr` (table) — The trace that is passed as second argument to Action callback of a property

[wiki](https://wiki.facepunch.com/gmod/properties.OpenEntityMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/properties.lua#L74-L91)

---

### properties.Remove · Shared
`properties.Remove(name: string)`

Remove an entity right-click property. See [properties.Add](https://wiki.facepunch.com/gmod/properties.Add) for details.

**Arguments:**
- `name` (string) — A unique name used to identify the property to be removed.

[wiki](https://wiki.facepunch.com/gmod/properties.Remove)

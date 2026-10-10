# DEntityProperties

**Realm:** Client  ·  **Members:** 5  ·  **Inherits:** `DProperties`  ·  `INTERNAL`

A panel used by the [Editable Entities](https://wiki.facepunch.com/gmod/Editable%20Entities) system.

[wiki page](https://wiki.facepunch.com/gmod/DEntityProperties)

### DEntityProperties:EditVariable · Client · `INTERNAL`
`DEntityProperties:EditVariable(varname: string, editdata: table)`

Called internally by [DEntityProperties:RebuildControls](https://wiki.facepunch.com/gmod/DEntityProperties:RebuildControls).

**Arguments:**
- `varname` (string)
- `editdata` (table)

[wiki](https://wiki.facepunch.com/gmod/DEntityProperties:EditVariable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dentityproperties.lua#L59-L94)

---

### DEntityProperties:EntityLost · Client · `INTERNAL`
`DEntityProperties:EntityLost()`

Called internally when an entity being edited became invalid.

You should use [DEntityProperties:OnEntityLost](https://wiki.facepunch.com/gmod/DEntityProperties:OnEntityLost) instead.

[wiki](https://wiki.facepunch.com/gmod/DEntityProperties:EntityLost) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dentityproperties.lua#L99-L104)

---

### DEntityProperties:OnEntityLost · Client · `hook`
`DEntityProperties:OnEntityLost()`

Called when we were editing an entity and then it became invalid (probably removed). For Override

[wiki](https://wiki.facepunch.com/gmod/DEntityProperties:OnEntityLost) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dentityproperties.lua#L106-L110)

---

### DEntityProperties:RebuildControls · Client · `INTERNAL`
`DEntityProperties:RebuildControls()`

Called internally by [DEntityProperties:SetEntity](https://wiki.facepunch.com/gmod/DEntityProperties:SetEntity) to rebuild the controls.

[wiki](https://wiki.facepunch.com/gmod/DEntityProperties:RebuildControls) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dentityproperties.lua#L26-L54)

---

### DEntityProperties:SetEntity · Client
`DEntityProperties:SetEntity(ent: Entity)`

Sets the entity to be edited by this panel. The entity must support the [Editable Entities](https://wiki.facepunch.com/gmod/Editable%20Entities) system or nothing will happen.

**Arguments:**
- `ent` (Entity) — The entity to edit

[wiki](https://wiki.facepunch.com/gmod/DEntityProperties:SetEntity) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dentityproperties.lua#L14-L21)

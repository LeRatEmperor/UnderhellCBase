# DExpandButton

**Realm:** Client, Menu  ·  **Members:** 2  ·  **Inherits:** `DButton`  ·  `INTERNAL`

The little "+" button used by [DProperties](https://wiki.facepunch.com/gmod/DProperties) and [DTree_Node](https://wiki.facepunch.com/gmod/DTree_Node).

[wiki page](https://wiki.facepunch.com/gmod/DExpandButton)

### DExpandButton:GetExpanded · Client, Menu
`DExpandButton:GetExpanded() → boolean`

Returns whether this DExpandButton is expanded or not.

**Returns:**
- boolean — True if expanded, false otherwise

[wiki](https://wiki.facepunch.com/gmod/DExpandButton:GetExpanded) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dexpandbutton.lua#L4)

---

### DExpandButton:SetExpanded · Client, Menu
`DExpandButton:SetExpanded(expanded: boolean)`

Sets whether this DExpandButton should be expanded or not. Only changes appearance.

**Arguments:**
- `expanded` (boolean) — True to expand ( visually will show a "-" )

[wiki](https://wiki.facepunch.com/gmod/DExpandButton:SetExpanded) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

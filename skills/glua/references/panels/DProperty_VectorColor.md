# DProperty_VectorColor

**Realm:** Client  ·  **Members:** 2  ·  **Inherits:** `DProperty_Generic`  ·  `INTERNAL`

Color picker control for a DProperties panel. Opens a [DColorCombo](https://wiki.facepunch.com/gmod/DColorCombo) if the color preview is clicked.

		See [Editable Entities](https://wiki.facepunch.com/gmod/Editable%20Entities) for how this is used ingame.

[wiki page](https://wiki.facepunch.com/gmod/DProperty_VectorColor)

### DProperty_VectorColor:Setup · Client · `INTERNAL`
`DProperty_VectorColor:Setup(settings: table)`

Called by a property row to setup a color selection control.

**Arguments:**
- `settings` (table) — A table of settings.

[wiki](https://wiki.facepunch.com/gmod/DProperty_VectorColor:Setup) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/prop_vectorcolor.lua#L34-L116)

---

### DProperty_VectorColor:SetValue · Client
`DProperty_VectorColor:SetValue(color: Vector)`

Sets the color value of the property.

**Arguments:**
- `color` (Vector) — Sets the color to use in a DProperty_VectorColor.

[wiki](https://wiki.facepunch.com/gmod/DProperty_VectorColor:SetValue)

# DProperties

**Realm:** Client  ·  **Members:** 3  ·  **Inherits:** `Panel`

A grid for editing the properties of something using names and values. Properties can be categorized and strongly typed.


##  Associated controls 
* [DProperty_VectorColor](https://wiki.facepunch.com/gmod/DProperty_VectorColor)
* [DProperty_Boolean](https://wiki.facepunch.com/gmod/DProperty_Boolean)
* [DProperty_Generic](https://wiki.facepunch.com/gmod/DProperty_Generic)
* [DProperty_Combo](https://wiki.facepunch.com/gmod/DProperty_Combo)
* [DProperty_Float](https://wiki.facepunch.com/gmod/DProperty_Float)
* [DProperty_Int](https://wiki.facepunch.com/gmod/DProperty_Int)

[wiki page](https://wiki.facepunch.com/gmod/DProperties)

### DProperties:CreateRow · Client
`DProperties:CreateRow(category: string, name: string) → Panel`

Creates a row in the properties panel.

**Arguments:**
- `category` (string) — The category to list this row under
- `name` (string) — The label of this row

**Returns:**
- Panel — An internal Row panel.

[wiki](https://wiki.facepunch.com/gmod/DProperties:CreateRow) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dproperties.lua#L240-L245)

---

### DProperties:GetCanvas · Client
`DProperties:GetCanvas() → Panel`

Returns the [DScrollPanel](https://wiki.facepunch.com/gmod/DScrollPanel) all the properties panels are attached to.

**Returns:**
- Panel — A DScrollPanel canvas

[wiki](https://wiki.facepunch.com/gmod/DProperties:GetCanvas) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dproperties.lua#L206-L217)

---

### DProperties:GetCategory · Client · `INTERNAL`
`DProperties:GetCategory(name: string, create: boolean = false) → Panel`

Returns (or creates) a category of properties.

See [DProperties:CreateRow](https://wiki.facepunch.com/gmod/DProperties:CreateRow) for adding actual properties.

**Arguments:**
- `name` (string) — Name of the category
- `create` (boolean, default `false`) — Create a new category if it doesn't exist.

**Returns:**
- Panel — An internal panel.

[wiki](https://wiki.facepunch.com/gmod/DProperties:GetCategory) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dproperties.lua#L222-L234)

# DButton

**Realm:** Client, Menu  ·  **Members:** 8  ·  **Inherits:** `DLabel`

A standard Derma button.

By default, a [DButton](https://wiki.facepunch.com/gmod/DButton) is 22px tall.

[wiki page](https://wiki.facepunch.com/gmod/DButton)

### DButton:GetDrawBorder · Client, Menu · `DEPRECATED`
`DButton:GetDrawBorder() → boolean`

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc) that returns value set by [DButton:SetDrawBorder](https://wiki.facepunch.com/gmod/DButton:SetDrawBorder). See that page for more info.

**Returns:**
- boolean — value set by DButton:SetDrawBorder.

[wiki](https://wiki.facepunch.com/gmod/DButton:GetDrawBorder) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dbutton.lua#L4)

---

### DButton:IsDown · Client, Menu
`DButton:IsDown() → boolean`

Returns true if the DButton is currently depressed (a user is clicking on it).

**Returns:**
- boolean — Whether or not the button is depressed.

[wiki](https://wiki.facepunch.com/gmod/DButton:IsDown) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dbutton.lua#L26-L30)

---

### DButton:SetConsoleCommand · Client, Menu
`DButton:SetConsoleCommand(command: string, args: string = nil)`

Sets a console command to be called when the button is clicked.

This overrides the button's `DoClick` method.

**Arguments:**
- `command` (string) — The console command to be called.
- `args` (string, default `nil`) — The arguments for the command.

[wiki](https://wiki.facepunch.com/gmod/DButton:SetConsoleCommand) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dbutton.lua#L115-L121)

---

### DButton:SetDrawBorder · Client, Menu · `DEPRECATED`
`DButton:SetDrawBorder(draw: boolean)`

Does absolutely nothing at all. Default value is automatically set to true.

**Arguments:**
- `draw` (boolean) — Does nothing.

[wiki](https://wiki.facepunch.com/gmod/DButton:SetDrawBorder) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DButton:SetIcon · Client, Menu
`DButton:SetIcon(img: string = nil)`

Sets an image to be displayed as the button's background. Alias of [DButton:SetImage](https://wiki.facepunch.com/gmod/DButton:SetImage)

**Arguments:**
- `img` (string, default `nil`) — The image file to use, relative to `/materials`.

[wiki](https://wiki.facepunch.com/gmod/DButton:SetIcon) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dbutton.lua#L32-L51)

---

### DButton:SetImage · Client, Menu
`DButton:SetImage(img: string = nil)`

Sets an image to be displayed as the button's background.

See [DButton:SetMaterial](https://wiki.facepunch.com/gmod/DButton:SetMaterial) for equivalent function that uses [IMaterial](https://wiki.facepunch.com/gmod/IMaterial) instead.

Also see: [DImageButton](https://wiki.facepunch.com/gmod/DImageButton)

**Arguments:**
- `img` (string, default `nil`) — The image file to use, relative to the `materials/` folder.

[wiki](https://wiki.facepunch.com/gmod/DButton:SetImage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dbutton.lua#L32-L51)

---

### DButton:SetMaterial · Client, Menu
`DButton:SetMaterial(img: IMaterial = nil)`

Sets an image to be displayed as the button's background.

See [DButton:SetImage](https://wiki.facepunch.com/gmod/DButton:SetImage) for equivalent function that uses file paths instead. Also see [DImageButton](https://wiki.facepunch.com/gmod/DImageButton).

**Arguments:**
- `img` (IMaterial, default `nil`) — The material to use.

[wiki](https://wiki.facepunch.com/gmod/DButton:SetMaterial) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dbutton.lua#L54-L73)

---

### DButton:UpdateColours · Client, Menu
`DButton:UpdateColours(skin: table)`

A hook called from within [DLabel](https://wiki.facepunch.com/gmod/DLabel)'s [PANEL:ApplySchemeSettings](https://wiki.facepunch.com/gmod/PANEL:ApplySchemeSettings) to determine the color of the text on display.

**Arguments:**
- `skin` (table) — A table supposed to contain the color values listed above.

[wiki](https://wiki.facepunch.com/gmod/DButton:UpdateColours) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dbutton.lua#L86-L94)

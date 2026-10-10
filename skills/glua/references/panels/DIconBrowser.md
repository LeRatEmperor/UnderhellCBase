# DIconBrowser

**Realm:** Client, Menu  ·  **Members:** 10  ·  **Inherits:** `DScrollPanel`

Simply a [DIconLayout](https://wiki.facepunch.com/gmod/DIconLayout) which automatically displays all of the [Silkicons](https://wiki.facepunch.com/gmod/silkicons). 
		Used as a way to get the user to select an icon.

[wiki page](https://wiki.facepunch.com/gmod/DIconBrowser)

### DIconBrowser:Fill · Client, Menu · `INTERNAL`
`DIconBrowser:Fill()`

Automatically called to fill the browser with icons. Will not work if [DIconBrowser:SetManual](https://wiki.facepunch.com/gmod/DIconBrowser:SetManual) is set to true.

[wiki](https://wiki.facepunch.com/gmod/DIconBrowser:Fill) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/diconbrowser.lua#L46-L102)

---

### DIconBrowser:FilterByText · Client, Menu
`DIconBrowser:FilterByText(text: string)`

A simple unused search feature, hides all icons that do not contain given text in their file path.

**Arguments:**
- `text` (string) — The text to search for

[wiki](https://wiki.facepunch.com/gmod/DIconBrowser:FilterByText) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/diconbrowser.lua#L104-L116)

---

### DIconBrowser:GetManual · Client, Menu
`DIconBrowser:GetManual() → boolean`

Returns whether or not the browser should fill itself with icons.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DIconBrowser:GetManual)

---

### DIconBrowser:GetSelectedIcon · Client, Menu
`DIconBrowser:GetSelectedIcon() → string`

Returns the currently selected icon's file path.

**Returns:**
- string — The currently selected icon's file path.

[wiki](https://wiki.facepunch.com/gmod/DIconBrowser:GetSelectedIcon)

---

### DIconBrowser:OnChange · Client, Menu
`DIconBrowser:OnChange()`

Called when the selected icon was changed. Use [DIconBrowser:GetSelectedIcon](https://wiki.facepunch.com/gmod/DIconBrowser:GetSelectedIcon) to get the selected icon's filepath.

[wiki](https://wiki.facepunch.com/gmod/DIconBrowser:OnChange) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/diconbrowser.lua#L140-L141)

---

### DIconBrowser:OnChangeInternal · Client, Menu · `INTERNAL`
`DIconBrowser:OnChangeInternal()`

Use [DIconBrowser:OnChange](https://wiki.facepunch.com/gmod/DIconBrowser:OnChange) instead

[wiki](https://wiki.facepunch.com/gmod/DIconBrowser:OnChangeInternal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/diconbrowser.lua#L126-L130)

---

### DIconBrowser:ScrollToSelected · Client, Menu
`DIconBrowser:ScrollToSelected()`

Scrolls the browser to the selected icon

[wiki](https://wiki.facepunch.com/gmod/DIconBrowser:ScrollToSelected) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/diconbrowser.lua#L21-L27)

---

### DIconBrowser:SelectIcon · Client, Menu
`DIconBrowser:SelectIcon(icon: string)`

Selects an icon from file path

**Arguments:**
- `icon` (string) — The file path of the icon to select.

[wiki](https://wiki.facepunch.com/gmod/DIconBrowser:SelectIcon) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/diconbrowser.lua#L7-L19)

---

### DIconBrowser:SetManual · Client, Menu
`DIconBrowser:SetManual(manual: boolean)`

Sets whether or not the browser should automatically fill itself with icons.

**Arguments:**
- `manual` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DIconBrowser:SetManual)

---

### DIconBrowser:SetSelectedIcon · Client, Menu · `INTERNAL`
`DIconBrowser:SetSelectedIcon(str: string)`

Set the currently selected file path. Do not use. Use [DIconBrowser:SelectIcon](https://wiki.facepunch.com/gmod/DIconBrowser:SelectIcon) instead.

**Arguments:**
- `str` (string)

[wiki](https://wiki.facepunch.com/gmod/DIconBrowser:SetSelectedIcon)

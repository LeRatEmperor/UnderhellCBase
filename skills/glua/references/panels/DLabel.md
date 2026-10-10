# DLabel

**Realm:** Client, Menu  ·  **Members:** 42  ·  **Inherits:** `Label`

A standard Derma text label. A lot of this panels functionality is a base for button elements, such as [DButton](https://wiki.facepunch.com/gmod/DButton)

[wiki page](https://wiki.facepunch.com/gmod/DLabel)

### DLabel:DoClick · Client, Menu · `hook`
`DLabel:DoClick()`

Called when the label is left clicked (on key release) by the player.

This will be called after [DLabel:OnDepressed](https://wiki.facepunch.com/gmod/DLabel:OnDepressed) and [DLabel:OnReleased](https://wiki.facepunch.com/gmod/DLabel:OnReleased).

This can be overridden; by default, it calls [DLabel:Toggle](https://wiki.facepunch.com/gmod/DLabel:Toggle).

See also [DLabel:DoRightClick](https://wiki.facepunch.com/gmod/DLabel:DoRightClick), [DLabel:DoMiddleClick](https://wiki.facepunch.com/gmod/DLabel:DoMiddleClick) and [DLabel:DoDoubleClick](https://wiki.facepunch.com/gmod/DLabel:DoDoubleClick).

[wiki](https://wiki.facepunch.com/gmod/DLabel:DoClick)

---

### DLabel:DoClickInternal · Client, Menu
`DLabel:DoClickInternal()`

Called just before [DLabel:DoClick](https://wiki.facepunch.com/gmod/DLabel:DoClick).

In [DLabel](https://wiki.facepunch.com/gmod/DLabel) does nothing and is safe to override. Used by [DMenuOption](https://wiki.facepunch.com/gmod/DMenuOption) and [DCollapsibleCategory](https://wiki.facepunch.com/gmod/DCollapsibleCategory)'s tabs.

[wiki](https://wiki.facepunch.com/gmod/DLabel:DoClickInternal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabel.lua#L269-L270)

---

### DLabel:DoDoubleClick · Client, Menu · `hook`
`DLabel:DoDoubleClick()`

Called when the label is double clicked by the player with left clicks.

[DLabel:SetDoubleClickingEnabled](https://wiki.facepunch.com/gmod/DLabel:SetDoubleClickingEnabled) must be set to true for this hook to work, which it is by default.

This will be called after [DLabel:OnDepressed](https://wiki.facepunch.com/gmod/DLabel:OnDepressed) and [DLabel:OnReleased](https://wiki.facepunch.com/gmod/DLabel:OnReleased) and [DLabel:DoClick](https://wiki.facepunch.com/gmod/DLabel:DoClick).

See also [DLabel:DoRightClick](https://wiki.facepunch.com/gmod/DLabel:DoRightClick) and [DLabel:DoMiddleClick](https://wiki.facepunch.com/gmod/DLabel:DoMiddleClick).

[wiki](https://wiki.facepunch.com/gmod/DLabel:DoDoubleClick)

---

### DLabel:DoDoubleClickInternal · Client, Menu
`DLabel:DoDoubleClickInternal()`

Called just before [DLabel:DoDoubleClick](https://wiki.facepunch.com/gmod/DLabel:DoDoubleClick). In [DLabel](https://wiki.facepunch.com/gmod/DLabel) does nothing and is safe to override.

[wiki](https://wiki.facepunch.com/gmod/DLabel:DoDoubleClickInternal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabel.lua#L275-L276)

---

### DLabel:DoMiddleClick · Client, Menu · `hook`
`DLabel:DoMiddleClick()`

Called when the label is middle mouse (Mouse wheel, also known as mouse 3) clicked (on key release) by the player.

This will be called after [DLabel:OnDepressed](https://wiki.facepunch.com/gmod/DLabel:OnDepressed) and [DLabel:OnReleased](https://wiki.facepunch.com/gmod/DLabel:OnReleased).

See also [DLabel:DoClick](https://wiki.facepunch.com/gmod/DLabel:DoClick), [DLabel:DoRightClick](https://wiki.facepunch.com/gmod/DLabel:DoRightClick) and [DLabel:DoDoubleClick](https://wiki.facepunch.com/gmod/DLabel:DoDoubleClick).

[wiki](https://wiki.facepunch.com/gmod/DLabel:DoMiddleClick)

---

### DLabel:DoRightClick · Client, Menu · `hook`
`DLabel:DoRightClick()`

Called when the label is right clicked (on key release) by the player.

This will be called after [DLabel:OnDepressed](https://wiki.facepunch.com/gmod/DLabel:OnDepressed) and [DLabel:OnReleased](https://wiki.facepunch.com/gmod/DLabel:OnReleased).

See also [DLabel:DoClick](https://wiki.facepunch.com/gmod/DLabel:DoClick), [DLabel:DoMiddleClick](https://wiki.facepunch.com/gmod/DLabel:DoMiddleClick) and [DLabel:DoDoubleClick](https://wiki.facepunch.com/gmod/DLabel:DoDoubleClick).

[wiki](https://wiki.facepunch.com/gmod/DLabel:DoRightClick)

---

### DLabel:GetAutoStretchVertical · Client, Menu
`DLabel:GetAutoStretchVertical() → boolean`

Returns whether the label stretches vertically or not.

Set by [DLabel:SetAutoStretchVertical](https://wiki.facepunch.com/gmod/DLabel:SetAutoStretchVertical).

**Returns:**
- boolean — Whether the label stretches vertically or not.

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetAutoStretchVertical)

---

### DLabel:GetBright · Client, Menu
`DLabel:GetBright() → boolean`

Returns whether the [DLabel](https://wiki.facepunch.com/gmod/DLabel) should set its text color to the current skin's bright text color.

See [DLabel:SetBright](https://wiki.facepunch.com/gmod/DLabel:SetBright).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetBright)

---

### DLabel:GetColor · Client, Menu
`DLabel:GetColor() → Color`

Returns the actual color of the text.

See also [DLabel:GetTextColor](https://wiki.facepunch.com/gmod/DLabel:GetTextColor) and [DLabel:GetTextStyleColor](https://wiki.facepunch.com/gmod/DLabel:GetTextStyleColor).

**Returns:**
- Color — The the actual Color of the text.

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabel.lua#L59-L63)

---

### DLabel:GetDark · Client, Menu
`DLabel:GetDark() → boolean`

Returns whether the [DLabel](https://wiki.facepunch.com/gmod/DLabel) should set its text color to the current skin's dark text color.

See [DLabel:SetDark](https://wiki.facepunch.com/gmod/DLabel:SetDark).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetDark)

---

### DLabel:GetDisabled · Client, Menu · `DEPRECATED`
`DLabel:GetDisabled() → boolean`

Gets the disabled state of the [DLabel](https://wiki.facepunch.com/gmod/DLabel). This is set with [DLabel:SetDisabled](https://wiki.facepunch.com/gmod/DLabel:SetDisabled).

**Returns:**
- boolean — The disabled state of the label.

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetDisabled)

---

### DLabel:GetDoubleClickingEnabled · Client, Menu
`DLabel:GetDoubleClickingEnabled() → boolean`

Returns whether or not double clicking will call [DLabel:DoDoubleClick](https://wiki.facepunch.com/gmod/DLabel:DoDoubleClick).

See [DLabel:SetDoubleClickingEnabled](https://wiki.facepunch.com/gmod/DLabel:SetDoubleClickingEnabled).

**Returns:**
- boolean — true = enabled, false means disabled

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetDoubleClickingEnabled)

---

### DLabel:GetDrawBackground · Client, Menu · `DEPRECATED`
`DLabel:GetDrawBackground() → boolean`

Returns whether or not the panel background is being drawn. Alias of [DLabel:GetPaintBackground](https://wiki.facepunch.com/gmod/DLabel:GetPaintBackground).

**Returns:**
- boolean — True if the panel background is drawn, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetDrawBackground)

---

### DLabel:GetFont · Client, Menu
`DLabel:GetFont() → string`

Returns the current font of the DLabel. This is set with [DLabel:SetFont](https://wiki.facepunch.com/gmod/DLabel:SetFont).

**Returns:**
- string — The name of the font in use.

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetFont)

---

### DLabel:GetHighlight · Client, Menu
`DLabel:GetHighlight() → boolean`

Returns whether the [DLabel](https://wiki.facepunch.com/gmod/DLabel) should set its text color to the current skin's highlighted text color.

See [DLabel:SetHighlight](https://wiki.facepunch.com/gmod/DLabel:SetHighlight).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetHighlight)

---

### DLabel:GetIsMenu · Client, Menu
`DLabel:GetIsMenu() → boolean`

Used internally by [DComboBox](https://wiki.facepunch.com/gmod/DComboBox).

Returns whether the frame is part of a derma menu or not.

If this is `true`, [CloseDermaMenus](https://wiki.facepunch.com/gmod/Global.CloseDermaMenus) will not be called when the frame is clicked, and thus any open menus will remain open.

**Returns:**
- `isMenu` (boolean) — Whether this panel is a Menu Component

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetIsMenu)

---

### DLabel:GetIsToggle · Client, Menu
`DLabel:GetIsToggle() → boolean`

Returns whether the toggle functionality is enabled for a label. Set with [DLabel:SetIsToggle](https://wiki.facepunch.com/gmod/DLabel:SetIsToggle).

**Returns:**
- boolean — Whether or not toggle functionality is enabled.

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetIsToggle)

---

### DLabel:GetPaintBackground · Client, Menu
`DLabel:GetPaintBackground() → boolean`

Returns whether or not the background should be painted.

**Returns:**
- boolean — If the background is painted or not

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetPaintBackground)

---

### DLabel:GetTextColor · Client, Menu
`DLabel:GetTextColor() → Color`

Returns the "override" text color, set by [DLabel:SetTextColor](https://wiki.facepunch.com/gmod/DLabel:SetTextColor).

**Returns:**
- Color — The Color of the text, or nil.

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetTextColor)

---

### DLabel:GetTextStyleColor · Client, Menu · `INTERNAL`
`DLabel:GetTextStyleColor() → Color`

Returns the "internal" or fallback color of the text.

See also [DLabel:GetTextColor](https://wiki.facepunch.com/gmod/DLabel:GetTextColor) and [DLabel:SetTextStyleColor](https://wiki.facepunch.com/gmod/DLabel:SetTextStyleColor).

**Returns:**
- Color — The "internal" Color of the text

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetTextStyleColor)

---

### DLabel:GetToggle · Client, Menu
`DLabel:GetToggle() → boolean`

Returns the current toggle state of the label. This can be set with [DLabel:SetToggle](https://wiki.facepunch.com/gmod/DLabel:SetToggle) and toggled with [DLabel:Toggle](https://wiki.facepunch.com/gmod/DLabel:Toggle).

In order to use toggle functionality, you must first call [DLabel:SetIsToggle](https://wiki.facepunch.com/gmod/DLabel:SetIsToggle) with `true`, as it is disabled by default.

**Returns:**
- boolean — The current toggle state.

[wiki](https://wiki.facepunch.com/gmod/DLabel:GetToggle)

---

### DLabel:OnDepressed · Client, Menu · `hook`
`DLabel:OnDepressed()`

Called when the player presses the label with any mouse button.

This works as an alternative to [PANEL:OnMousePressed](https://wiki.facepunch.com/gmod/PANEL:OnMousePressed) as that hook is used heavily by [DLabel](https://wiki.facepunch.com/gmod/DLabel) and overriding it will break functionality.

See also [DLabel:DoClick](https://wiki.facepunch.com/gmod/DLabel:DoClick), [DLabel:DoMiddleClick](https://wiki.facepunch.com/gmod/DLabel:DoMiddleClick), [DLabel:DoRightClick](https://wiki.facepunch.com/gmod/DLabel:DoRightClick), [DLabel:OnReleased](https://wiki.facepunch.com/gmod/DLabel:OnReleased) and [DLabel:DoDoubleClick](https://wiki.facepunch.com/gmod/DLabel:DoDoubleClick).

[wiki](https://wiki.facepunch.com/gmod/DLabel:OnDepressed)

---

### DLabel:OnReleased · Client, Menu · `hook`
`DLabel:OnReleased()`

Called when the player releases any mouse button on the label. This is always called after [DLabel:OnDepressed](https://wiki.facepunch.com/gmod/DLabel:OnDepressed).

This works as an alternative to [PANEL:OnMouseReleased](https://wiki.facepunch.com/gmod/PANEL:OnMouseReleased) as that hook is used heavily by [DLabel](https://wiki.facepunch.com/gmod/DLabel) and overriding it will break functionality.

See also [DLabel:DoClick](https://wiki.facepunch.com/gmod/DLabel:DoClick), [DLabel:DoMiddleClick](https://wiki.facepunch.com/gmod/DLabel:DoMiddleClick), [DLabel:DoRightClick](https://wiki.facepunch.com/gmod/DLabel:DoRightClick) and [DLabel:DoDoubleClick](https://wiki.facepunch.com/gmod/DLabel:DoDoubleClick).

[wiki](https://wiki.facepunch.com/gmod/DLabel:OnReleased)

---

### DLabel:OnToggled · Client, Menu · `hook`
`DLabel:OnToggled(toggleState: boolean)`

Called when the toggle state of the label is changed by [DLabel:Toggle](https://wiki.facepunch.com/gmod/DLabel:Toggle).

In order to use toggle functionality, you must first call [DLabel:SetIsToggle](https://wiki.facepunch.com/gmod/DLabel:SetIsToggle) with `true`, as it is disabled by default.

**Arguments:**
- `toggleState` (boolean) — The new toggle state.

[wiki](https://wiki.facepunch.com/gmod/DLabel:OnToggled)

---

### DLabel:SetAutoStretchVertical · Client, Menu
`DLabel:SetAutoStretchVertical(stretch: boolean)`

Automatically adjusts the height of the label dependent of the height of the text inside of it.

**Arguments:**
- `stretch` (boolean) — Whenever to stretch the label vertically or not.

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetAutoStretchVertical) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DLabel:SetBright · Client, Menu
`DLabel:SetBright(bright: boolean)`

Sets the color of the text to the bright text color defined in the skin.

Disables [DLabel:SetDark](https://wiki.facepunch.com/gmod/DLabel:SetDark). Gets overridden by [DLabel:SetHighlight](https://wiki.facepunch.com/gmod/DLabel:SetHighlight).

You should only consider using this if you are using background elements that are not manually painted and are using the skin colors. Otherwise use [DLabel:SetTextColor](https://wiki.facepunch.com/gmod/DLabel:SetTextColor).

**Arguments:**
- `bright` (boolean) — Whenever to set the text to bright or not.

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetBright) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DLabel:SetColor · Client, Menu
`DLabel:SetColor(color: Color)`

Changes color of label. Alias of [DLabel:SetTextColor](https://wiki.facepunch.com/gmod/DLabel:SetTextColor).

**Arguments:**
- `color` (Color) — The color to set.

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabel.lua#L51-L56)

---

### DLabel:SetDark · Client, Menu
`DLabel:SetDark(dark: boolean)`

Sets the color of the text to the dark text color defined in the skin.

Disables [DLabel:SetBright](https://wiki.facepunch.com/gmod/DLabel:SetBright). Gets overridden by [DLabel:SetHighlight](https://wiki.facepunch.com/gmod/DLabel:SetHighlight).

You should only consider using this if you are using background elements that are not manually painted and are using the skin colors. Otherwise use [DLabel:SetTextColor](https://wiki.facepunch.com/gmod/DLabel:SetTextColor).

**Arguments:**
- `dark` (boolean) — Whenever to set the text to dark or not.

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetDark) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DLabel:SetDisabled · Client, Menu · `DEPRECATED`
`DLabel:SetDisabled(disable: boolean)`

Sets the disabled state of the [DLabel](https://wiki.facepunch.com/gmod/DLabel).

When disabled, the label does not respond to click, toggle or drag & drop actions.

**Arguments:**
- `disable` (boolean) — `true` to disable the DLabel, `false` to enable it.

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetDisabled) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabel.lua#L85-L90)

---

### DLabel:SetDoubleClickingEnabled · Client, Menu
`DLabel:SetDoubleClickingEnabled(enable: boolean)`

Sets whether or not double clicking should call [DLabel:DoDoubleClick](https://wiki.facepunch.com/gmod/DLabel:DoDoubleClick).

This is enabled by default.

**Arguments:**
- `enable` (boolean) — true to enable, false to disable

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetDoubleClickingEnabled) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DLabel:SetDrawBackground · Client, Menu · `DEPRECATED`
`DLabel:SetDrawBackground(draw: boolean)`

Sets whether or not to draw the panel background. Alias of [DLabel:SetPaintBackground](https://wiki.facepunch.com/gmod/DLabel:SetPaintBackground).

**Arguments:**
- `draw` (boolean) — True to show the panel's background, false to hide it.

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetDrawBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DLabel:SetFont · Client, Menu
`DLabel:SetFont(fontName: string)`

Sets the font of the label.

**Arguments:**
- `fontName` (string) — The name of the font.

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetFont) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabel.lua#L43-L49)

---

### DLabel:SetHighlight · Client, Menu
`DLabel:SetHighlight(highlight: boolean)`

Sets the color of the text to the highlight text color defined in the skin.

For the default Derma skin this makes the label red.

Overrides colors set by both [DLabel:SetBright](https://wiki.facepunch.com/gmod/DLabel:SetBright) and [DLabel:SetDark](https://wiki.facepunch.com/gmod/DLabel:SetDark) while active.

You should only consider using this if you are using background elements that are not manually painted and are using the skin colors. Otherwise use [DLabel:SetTextColor](https://wiki.facepunch.com/gmod/DLabel:SetTextColor).

**Arguments:**
- `highlight` (boolean) — true to set the label's color to skins's text highlight color, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetHighlight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DLabel:SetIsMenu · Client, Menu
`DLabel:SetIsMenu(isMenu: boolean)`

Used internally by [DComboBox](https://wiki.facepunch.com/gmod/DComboBox).


Sets whether the frame is part of a derma menu or not.

If this is set to `true`, [CloseDermaMenus](https://wiki.facepunch.com/gmod/Global.CloseDermaMenus) will not be called when the frame is clicked, and thus any open menus will remain open.

**Arguments:**
- `isMenu` (boolean) — Whether this pane is a Menu Component

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetIsMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DLabel:SetIsToggle · Client, Menu
`DLabel:SetIsToggle(allowToggle: boolean)`

Enables or disables toggle functionality for a label. Retrieved with [DLabel:GetIsToggle](https://wiki.facepunch.com/gmod/DLabel:GetIsToggle).

You must call this before using [DLabel:SetToggle](https://wiki.facepunch.com/gmod/DLabel:SetToggle), [DLabel:GetToggle](https://wiki.facepunch.com/gmod/DLabel:GetToggle) or [DLabel:Toggle](https://wiki.facepunch.com/gmod/DLabel:Toggle).

**Arguments:**
- `allowToggle` (boolean) — Whether or not to enable toggle functionality.

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetIsToggle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DLabel:SetPaintBackground · Client, Menu
`DLabel:SetPaintBackground(paint: boolean)`

Sets whether or not the background should be painted. This is mainly used by derivative classes, such as [DButton](https://wiki.facepunch.com/gmod/DButton).

**Arguments:**
- `paint` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetPaintBackground) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DLabel:SetTextColor · Client, Menu
`DLabel:SetTextColor(color: Color)`

Sets the text color of the [DLabel](https://wiki.facepunch.com/gmod/DLabel). This will take precedence over [DLabel:SetTextStyleColor](https://wiki.facepunch.com/gmod/DLabel:SetTextStyleColor).

**Arguments:**
- `color` (Color) — The text color.

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetTextColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabel.lua#L51-L56)

---

### DLabel:SetTextStyleColor · Client, Menu · `INTERNAL`
`DLabel:SetTextStyleColor(color: Color)`

Used by [DLabel:SetDark](https://wiki.facepunch.com/gmod/DLabel:SetDark), [DLabel:SetBright](https://wiki.facepunch.com/gmod/DLabel:SetBright) and [DLabel:SetHighlight](https://wiki.facepunch.com/gmod/DLabel:SetHighlight) to set the text color without affecting [DLabel:SetTextColor](https://wiki.facepunch.com/gmod/DLabel:SetTextColor) calls.

**Arguments:**
- `color` (Color) — The text color.

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetTextStyleColor)

---

### DLabel:SetToggle · Client, Menu
`DLabel:SetToggle(toggleState: boolean)`

Sets the toggle state of the label. This can be retrieved with [DLabel:GetToggle](https://wiki.facepunch.com/gmod/DLabel:GetToggle) and toggled with [DLabel:Toggle](https://wiki.facepunch.com/gmod/DLabel:Toggle).

In order to use toggle functionality, you must first call [DLabel:SetIsToggle](https://wiki.facepunch.com/gmod/DLabel:SetIsToggle) with `true`, as it is disabled by default.

**Arguments:**
- `toggleState` (boolean) — The toggle state to be set.

[wiki](https://wiki.facepunch.com/gmod/DLabel:SetToggle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DLabel:Toggle · Client, Menu
`DLabel:Toggle()`

Toggles the label's state. This can be set and retrieved with [DLabel:SetToggle](https://wiki.facepunch.com/gmod/DLabel:SetToggle) and [DLabel:GetToggle](https://wiki.facepunch.com/gmod/DLabel:GetToggle).

In order to use toggle functionality, you must first call [DLabel:SetIsToggle](https://wiki.facepunch.com/gmod/DLabel:SetIsToggle) with `true`, as it is disabled by default.

[wiki](https://wiki.facepunch.com/gmod/DLabel:Toggle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabel.lua#L76-L83)

---

### DLabel:UpdateColours · Client, Menu
`DLabel:UpdateColours(skin: table)`

A hook called from within [PANEL:ApplySchemeSettings](https://wiki.facepunch.com/gmod/PANEL:ApplySchemeSettings) to determine the color of the text on display.

**Arguments:**
- `skin` (table) — A table supposed to contain the color values listed above.

[wiki](https://wiki.facepunch.com/gmod/DLabel:UpdateColours) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabel.lua#L104-L112)

---

### DLabel:UpdateFGColor · Client, Menu · `INTERNAL`
`DLabel:UpdateFGColor()`

Called internally to update the color of the text.

[wiki](https://wiki.facepunch.com/gmod/DLabel:UpdateFGColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dlabel.lua#L65-L74)

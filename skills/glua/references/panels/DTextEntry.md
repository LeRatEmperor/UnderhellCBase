# DTextEntry

**Realm:** Client, Menu  ·  **Members:** 49  ·  **Inherits:** `TextEntry`

A form which may be used to display text the player is meant to select and copy or alternately allow them to enter some text of their own.

> **Note:** At least one of your `DTextEntry`'s parents must either be an [EditablePanel](https://wiki.facepunch.com/gmod/EditablePanel) or derived from it (like a [DFrame](https://wiki.facepunch.com/gmod/DFrame), for example), else it won't be able to focus and thus be unselectable.
> 
> You must also call [Panel:MakePopup](https://wiki.facepunch.com/gmod/Panel:MakePopup) on said panel or the `DTextEntry` will not work.

[wiki page](https://wiki.facepunch.com/gmod/DTextEntry)

### DTextEntry:AddHistory · Client, Menu
`DTextEntry:AddHistory(text: string)`

Adds an entry to [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry)'s history.

See [DTextEntry:SetHistoryEnabled](https://wiki.facepunch.com/gmod/DTextEntry:SetHistoryEnabled).

**Arguments:**
- `text` (string) — Text to add to the text entry's history.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:AddHistory) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L358-L365)

---

### DTextEntry:AllowInput · Client, Menu
`DTextEntry:AllowInput(char: string) → boolean`

Called whenever the value of the panel has been updated (whether by user input or otherwise).

It allows you to determine whether a user can modify the [TextEntry](https://wiki.facepunch.com/gmod/TextEntry)'s text.

By default, this only checks whether the panel disallows numeric characters, preventing it from being edited if the value contains any.

This is actually an engine hook that only works on [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) derived elements.

If you are looking for a way to modify character limits, see [Panel:SetMaximumCharCount](https://wiki.facepunch.com/gmod/Panel:SetMaximumCharCount)

**Arguments:**
- `char` (string) — The last character entered into the panel.

**Returns:**
- boolean — Return `true` to prevent the value from changing, `false` to allow it.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:AllowInput) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L313-L319)

---

### DTextEntry:CheckNumeric · Client, Menu
`DTextEntry:CheckNumeric(strValue: string) → boolean`

Returns whether a string is numeric or not.
Always returns false if the [DTextEntry:SetNumeric](https://wiki.facepunch.com/gmod/DTextEntry:SetNumeric) is set to false.

**Arguments:**
- `strValue` (string) — The string to check.

**Returns:**
- boolean — Whether the string is numeric or not.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:CheckNumeric) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L288-L303)

---

### DTextEntry:GetAutoComplete · Client, Menu
`DTextEntry:GetAutoComplete(inputText: string) → table`

Called by the DTextEntry when a list of autocompletion options is requested. Meant to be overridden.

**Arguments:**
- `inputText` (string) — Player's current input.

**Returns:**
- table — If a table is returned, the values of the table will show up as autocomplete suggestions for the user.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetAutoComplete) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L367-L369)

---

### DTextEntry:GetCursorColor · Client, Menu
`DTextEntry:GetCursorColor() → Color`

Returns the cursor color of a DTextEntry.

**Returns:**
- Color — The color of the cursor as a Color.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetCursorColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L129-L133)

---

### DTextEntry:GetDisabled · Client, Menu · `DEPRECATED`
`DTextEntry:GetDisabled() → boolean`

Returns whether the textbox is disabled. Use [Panel:IsEnabled](https://wiki.facepunch.com/gmod/Panel:IsEnabled) instead.

**Returns:**
- boolean — Whether the textbox is disabled.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetDisabled) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L309-L311)

---

### DTextEntry:GetDrawBackground · Client, Menu · `DEPRECATED`
`DTextEntry:GetDrawBackground() → boolean`

Alias of [DTextEntry:GetPaintBackground](https://wiki.facepunch.com/gmod/DTextEntry:GetPaintBackground). Use that instead.

Whether the background is displayed or not.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetDrawBackground)

---

### DTextEntry:GetDrawBorder · Client, Menu · `DEPRECATED`
`DTextEntry:GetDrawBorder() → boolean`

Returns the value set by [DTextEntry:SetDrawBorder](https://wiki.facepunch.com/gmod/DTextEntry:SetDrawBorder).

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetDrawBorder)

---

### DTextEntry:GetEnterAllowed · Client, Menu
`DTextEntry:GetEnterAllowed() → boolean`

Returns whether pressing Enter can cause the panel to lose focus. Note that a multiline DTextEntry cannot be escaped using the Enter key even when this function returns true.

**Returns:**
- boolean — Whether pressing the Enter key can cause the panel to lose focus.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetEnterAllowed)

---

### DTextEntry:GetFloat · Client, Menu
`DTextEntry:GetFloat() → number`

Returns the contents of the DTextEntry as a number.

**Returns:**
- number — Text of the DTextEntry as a float, or nil if it cannot be converted to a number using tonumber.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetFloat) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L377-L381)

---

### DTextEntry:GetHighlightColor · Client, Menu
`DTextEntry:GetHighlightColor() → Color`

Returns the highlight/text selection color of the text entry. If it was not overwritten, it will return the derma skin value. (`colTextEntryTextHighlight`)

**Returns:**
- Color — The highlight Color.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetHighlightColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L123-L127)

---

### DTextEntry:GetHistoryEnabled · Client, Menu
`DTextEntry:GetHistoryEnabled() → boolean`

Returns whether the history functionality of  [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) is enabled. See [DTextEntry:AddHistory](https://wiki.facepunch.com/gmod/DTextEntry:AddHistory).

**Returns:**
- boolean — Whether the history is enabled or not.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetHistoryEnabled)

---

### DTextEntry:GetInt · Client, Menu
`DTextEntry:GetInt() → number`

Similar to [DTextEntry:GetFloat](https://wiki.facepunch.com/gmod/DTextEntry:GetFloat), but rounds the value to the nearest integer.

**Returns:**
- number — Text of the DTextEntry as a round number, or nil if it cannot be converted to a number.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetInt) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L371-L375)

---

### DTextEntry:GetNumeric · Client, Menu
`DTextEntry:GetNumeric() → boolean`

Returns whether only numeric characters (`123456789.-`) can be entered into the DTextEntry.

**Returns:**
- boolean — Whether the DTextEntry is numeric or not.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetNumeric)

---

### DTextEntry:GetPaintBackground · Client, Menu
`DTextEntry:GetPaintBackground() → boolean`

Whether the background is displayed or not

**Returns:**
- `show` (boolean) — `false` hides the background; this is `true` by default.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetPaintBackground)

---

### DTextEntry:GetPlaceholderColor · Client, Menu
`DTextEntry:GetPlaceholderColor() → Color`

Return current color of panel placeholder

**Returns:**
- Color — Current placeholder color

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetPlaceholderColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L117-L121)

---

### DTextEntry:GetPlaceholderText · Client, Menu
`DTextEntry:GetPlaceholderText() → string`

Returns the placeholder text set with [DTextEntry:SetPlaceholderText](https://wiki.facepunch.com/gmod/DTextEntry:SetPlaceholderText).

**Returns:**
- string

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetPlaceholderText)

---

### DTextEntry:GetTabbingDisabled · Client, Menu
`DTextEntry:GetTabbingDisabled() → boolean`

Returns whether or not the panel accepts  key.

**Returns:**
- boolean — Whether the DTextEntry should ignore .

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetTabbingDisabled)

---

### DTextEntry:GetTextColor · Client, Menu
`DTextEntry:GetTextColor() → Color`

Returns the text color of a DTextEntry.

**Returns:**
- Color — The color of the text as a Color.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetTextColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L111-L115)

---

### DTextEntry:GetUpdateOnType · Client, Menu
`DTextEntry:GetUpdateOnType() → boolean`

Returns whether the [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) is set to run [DTextEntry:OnValueChange](https://wiki.facepunch.com/gmod/DTextEntry:OnValueChange) every time a character is typed or deleted or only when Enter is pressed.

**Returns:**
- boolean

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:GetUpdateOnType)

---

### DTextEntry:IsEditing · Client, Menu
`DTextEntry:IsEditing() → boolean`

Returns whether this DTextEntry is being edited or not. (i.e. has focus)

**Returns:**
- boolean — Whether this DTextEntry is being edited or not

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:IsEditing) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L64-L66)

---

### DTextEntry:OnChange · Client, Menu · `hook`
`DTextEntry:OnChange()`

Called by [DTextEntry:OnTextChanged](https://wiki.facepunch.com/gmod/DTextEntry:OnTextChanged) when the user modifies the text in the [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry).

You should override this function to define custom behavior when the [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) text changes.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:OnChange)

---

### DTextEntry:OnEnter · Client, Menu · `hook`
`DTextEntry:OnEnter(value: string)`

Called whenever enter is pressed on a [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry).

**Arguments:**
- `value` (string) — The current text of the DTextEntry

> **Note:** [DTextEntry:IsEditing](https://wiki.facepunch.com/gmod/DTextEntry:IsEditing) will still return true in this callback!

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:OnEnter)

---

### DTextEntry:OnGetFocus · Client, Menu · `hook`
`DTextEntry:OnGetFocus()`

Called whenever the [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) gains focus.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:OnGetFocus) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L336-L348)

---

### DTextEntry:OnKeyCode · Client, Menu · `hook`
`DTextEntry:OnKeyCode(keyCode: number)`

Called from [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry)'s [TextEntry:OnKeyCodeTyped](https://wiki.facepunch.com/gmod/TextEntry:OnKeyCodeTyped) override whenever a valid character is typed while the text entry is focused.

**Arguments:**
- `keyCode` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — They key code of the key pressed, see KEY.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:OnKeyCode)

---

### DTextEntry:OnLoseFocus · Client, Menu · `hook`
`DTextEntry:OnLoseFocus()`

Called whenever the [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) lose focus.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:OnLoseFocus)

---

### DTextEntry:OnTextChanged · Client, Menu · `INTERNAL`
`DTextEntry:OnTextChanged(noMenuRemoval: boolean)`

Called internally when the text inside the [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) changes. This is an implementation of [TextEntry:OnTextChanged](https://wiki.facepunch.com/gmod/TextEntry:OnTextChanged)

You should not override this function. Use [DTextEntry:OnValueChange](https://wiki.facepunch.com/gmod/DTextEntry:OnValueChange) instead.

**Arguments:**
- `noMenuRemoval` (boolean) — Determines whether to remove the autocomplete menu (false) or not (true).

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:OnTextChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L188-L208)

---

### DTextEntry:OnValueChange · Client, Menu · `hook`
`DTextEntry:OnValueChange(value: string)`

Called when the text changes of the [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) are applied. (And set to the attached console variable, if one is given)

See also [DTextEntry:OnChange](https://wiki.facepunch.com/gmod/DTextEntry:OnChange) for a function that is called on every text change, even if the console variable is not updated.

You should override this function to define custom behavior when the text changes.

This method is called:
* When Enter is pressed after typing
* When [DTextEntry:SetValue](https://wiki.facepunch.com/gmod/DTextEntry:SetValue) is used
* For every key typed - only if [DTextEntry:SetUpdateOnType](https://wiki.facepunch.com/gmod/DTextEntry:SetUpdateOnType) was set to true (default is false)

**Arguments:**
- `value` (string) — The DTextEntry text.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:OnValueChange)

---

### DTextEntry:OpenAutoComplete · Client, Menu · `INTERNAL`
`DTextEntry:OpenAutoComplete(tab: table)`

Builds a [DMenu](https://wiki.facepunch.com/gmod/DMenu) for the DTextEntry based on the input table.

**Arguments:**
- `tab` (table) — Table containing results from DTextEntry:GetAutoComplete.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:OpenAutoComplete) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L213-L232)

---

### DTextEntry:SetCursorColor · Client, Menu
`DTextEntry:SetCursorColor(color: Color)`

Sets the cursor's color in  DTextEntry (the blinking line).

**Arguments:**
- `color` (Color) — The color to set the cursor to.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetCursorColor)

---

### DTextEntry:SetDisabled · Client, Menu · `DEPRECATED`
`DTextEntry:SetDisabled(disabled: boolean)`

Disables input on a DTextEntry and greys it out visually. This differs from [DTextEntry:SetEditable](https://wiki.facepunch.com/gmod/DTextEntry:SetEditable) which doesn't visually change the textbox.

**Arguments:**
- `disabled` (boolean) — Whether the textbox should be disabled

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetDisabled) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L305-L307)

---

### DTextEntry:SetDrawBackground · Client, Menu · `DEPRECATED`
`DTextEntry:SetDrawBackground(show: boolean)`

Alias of [DTextEntry:SetPaintBackground](https://wiki.facepunch.com/gmod/DTextEntry:SetPaintBackground). Use that instead.

**Arguments:**
- `show` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetDrawBackground)

---

### DTextEntry:SetDrawBorder · Client, Menu · `DEPRECATED`
`DTextEntry:SetDrawBorder(bool: boolean)`

Does nothing.

**Arguments:**
- `bool` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetDrawBorder)

---

### DTextEntry:SetEditable · Client, Menu
`DTextEntry:SetEditable(enabled: boolean)`

Disables Input on a DTextEntry. This differs from [DTextEntry:SetDisabled](https://wiki.facepunch.com/gmod/DTextEntry:SetDisabled) - SetEditable will not affect the appearance of the textbox.

**Arguments:**
- `enabled` (boolean) — Whether the DTextEntry should be editable

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetEditable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L321-L326)

---

### DTextEntry:SetEnterAllowed · Client, Menu
`DTextEntry:SetEnterAllowed(allowEnter: boolean)`

Sets whether pressing the Enter key will cause the DTextEntry to lose focus or not, provided it is not multiline. This is true by default.

**Arguments:**
- `allowEnter` (boolean) — If set to false, pressing Enter will not cause the panel to lose focus and will never call DTextEntry:OnEnter.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetEnterAllowed) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DTextEntry:SetFont · Client, Menu
`DTextEntry:SetFont(font: string)`

Changes the font of the DTextEntry.

**Arguments:**
- `font` (string) — The name of the font to be changed to.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetFont)

---

### DTextEntry:SetHighlightColor · Client, Menu
`DTextEntry:SetHighlightColor(color: Color)`

Sets/overrides the default highlight/text selection color of the text entry.

**Arguments:**
- `color` (Color) — The new highlight Color.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetHighlightColor)

---

### DTextEntry:SetHistoryEnabled · Client, Menu
`DTextEntry:SetHistoryEnabled(enable: boolean)`

Enables or disables the history functionality of  [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry). This allows the player to scroll through history elements using up and down arrow keys.

See [DTextEntry:AddHistory](https://wiki.facepunch.com/gmod/DTextEntry:AddHistory).

**Arguments:**
- `enable` (boolean) — Whether to enable history or not.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetHistoryEnabled) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DTextEntry:SetNumeric · Client, Menu
`DTextEntry:SetNumeric(numericOnly: boolean)`

Sets whether or not to decline non-numeric characters as input.

Numeric characters are `1234567890.-`

**Arguments:**
- `numericOnly` (boolean) — Whether to accept only numeric characters.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetNumeric) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DTextEntry:SetPaintBackground · Client, Menu
`DTextEntry:SetPaintBackground(show: boolean)`

Sets whether to show the default background of the DTextEntry.

**Arguments:**
- `show` (boolean) — `false` hides the background; this is `true` by default.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetPaintBackground)

---

### DTextEntry:SetPlaceholderColor · Client, Menu
`DTextEntry:SetPlaceholderColor(color: Color = Color(128, 128, 128))`

Allow you to set placeholder color.

**Arguments:**
- `color` (Color, default `Color(128, 128, 128)`) — The color of the placeholder.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetPlaceholderColor)

---

### DTextEntry:SetPlaceholderText · Client, Menu
`DTextEntry:SetPlaceholderText(text: string = nil)`

Sets the placeholder text that will be shown while the text entry has no user text. The player will not need to delete the placeholder text if they decide to start typing.

**Arguments:**
- `text` (string, default `nil`)

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetPlaceholderText)

---

### DTextEntry:SetTabbingDisabled · Client, Menu
`DTextEntry:SetTabbingDisabled(enabled: boolean)`

Sets whether or not the panel accepts  key.

**Arguments:**
- `enabled` (boolean) — Whether the DTextEntry should ignore .

> **Note:** Disabling tab key prevents the panel from unfocusing by mouse, however, still works for focusing to other keyboard focus.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetTabbingDisabled) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DTextEntry:SetTextColor · Client, Menu
`DTextEntry:SetTextColor(color: Color)`

Sets the text color of the [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry).

**Arguments:**
- `color` (Color) — The text color.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetTextColor)

---

### DTextEntry:SetUpdateOnType · Client, Menu
`DTextEntry:SetUpdateOnType(updateOnType: boolean)`

Sets whether we should fire [DTextEntry:OnValueChange](https://wiki.facepunch.com/gmod/DTextEntry:OnValueChange) every time we type or delete a character or only when Enter is pressed.

**Arguments:**
- `updateOnType` (boolean)

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetUpdateOnType) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DTextEntry:SetValue · Client, Menu
`DTextEntry:SetValue(text: string)`

Sets the text of the [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) and calls [DTextEntry:OnValueChange](https://wiki.facepunch.com/gmod/DTextEntry:OnValueChange).

**Arguments:**
- `text` (string) — The value to set.

> **Note:** The text of the [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) only changes if it's not currently being typed in. If you would rather set the text regardless, use [Panel:SetText](https://wiki.facepunch.com/gmod/Panel:SetText).

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:SetValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L269-L282)

---

### DTextEntry:UpdateConvarValue · Client, Menu · `INTERNAL`
`DTextEntry:UpdateConvarValue()`

Updates the ConVar associated with the TextEntry to its new value.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:UpdateConvarValue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L248-L254)

---

### DTextEntry:UpdateFromHistory · Client, Menu · `INTERNAL`
`DTextEntry:UpdateFromHistory()`

Used internally to set text from the history.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:UpdateFromHistory) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L135-L156)

---

### DTextEntry:UpdateFromMenu · Client, Menu · `INTERNAL`
`DTextEntry:UpdateFromMenu()`

Used internally to set text from the autocomplete menu.

[wiki](https://wiki.facepunch.com/gmod/DTextEntry:UpdateFromMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dtextentry.lua#L158-L186)

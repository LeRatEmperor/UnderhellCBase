# Panel

**Realm:** Client, Menu  ·  **Members:** 290

This is the base panel for every other [VGUI](vgui) panel.

It contains all of the basic methods, some of which may only work on certain VGUI elements. See also [Panel Hooks](https://wiki.facepunch.com/gmod/Panel%20Hooks).

As their functionality is provided at the game's C/C++ level rather than by its Lua script extension, they are unfortunately unavailable for most practical purposes, however, they can still be obtained in a way similar to that provided by the [baseclass](https://wiki.facepunch.com/gmod/baseclass) library:

```lua
-- Create a new panel type NewPanel that inherits all of its functionality from DLabel,
-- but has a different SetText method than DLabel does - all without the hassle of that
-- old DLabel's default text getting in the way. Fun stuff.

local PANEL = {}

function PANEL:Init()

	self:SetText_Base( "" )
	self:SetText( "Time for something different!" )

end

function PANEL:Paint( aWide, aTall )

	local TextX, TextY = 0, 0
	local TextColor = Color( 255, 0, 0, 255 )

	surface.SetFont( self:GetFont() or "default" )
	surface.SetTextColor( TextColor )
	surface.SetTextPos( TextX, TextY )
	surface.DrawText( self:GetText() )

end

-- And here we go:
PANEL.SetText_Base = FindMetaTable( "Panel" ).SetText

function PANEL:SetText( aText ) 

	self.Text = tostring( aText ) 

end

function PANEL:GetText() 

	return self.Text or "" 

end

vgui.Register( "NewPanel", PANEL, "DLabel" )
```

[wiki page](https://wiki.facepunch.com/gmod/Panel)

> **Part 2 of 2** (`SetCookie` – `Valid`). All parts: [1](Panel.md), [2](Panel-2.md)


### Panel:SetCookie · Client, Menu
`Panel:SetCookie(cookieName: string, value: string)`

Stores a string in the named cookie using [Panel:GetCookieName](https://wiki.facepunch.com/gmod/Panel:GetCookieName) as prefix.

You can also retrieve and modify this cookie by using the [cookie](https://wiki.facepunch.com/gmod/cookie). Cookies are stored in this format:

```
panelCookieName.cookieName
```

**Arguments:**
- `cookieName` (string) — The unique name used to retrieve the cookie later.
- `value` (string) — The value to store in the cookie.

> **Warning:** The panel's cookie name MUST be set for this function to work. See [Panel:SetCookieName](https://wiki.facepunch.com/gmod/Panel:SetCookieName).

[wiki](https://wiki.facepunch.com/gmod/Panel:SetCookie) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L226-L233)

---

### Panel:SetCookieName · Client, Menu
`Panel:SetCookieName(name: string)`

Sets the panel's cookie name. Calls [PANEL:LoadCookies](https://wiki.facepunch.com/gmod/PANEL:LoadCookies) if defined.

**Arguments:**
- `name` (string) — The panel's cookie name.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetCookieName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L187-L197)

---

### Panel:SetCursor · Client, Menu
`Panel:SetCursor(cursor: string)`

Sets the appearance of the cursor. You can find a list of all available cursors with image previews [here](https://wiki.facepunch.com/gmod/Cursors).

**Arguments:**
- `cursor` (string) — The cursor to be set.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetCursor)

---

### Panel:SetDragParent · Client, Menu
`Panel:SetDragParent(parent: Panel)`

Sets the drag parent.

Drag parent means that when we start to drag this panel, we'll really start dragging the defined parent.

**Arguments:**
- `parent` (Panel) — The panel to set as drag parent.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetDragParent) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L331-L333)

---

### Panel:SetDrawLanguageID · Client, Menu
`Panel:SetDrawLanguageID(visible: boolean)`

Sets the visibility of the language selection box when typing in non-English mode.

		See [Panel:SetDrawLanguageIDAtLeft](https://wiki.facepunch.com/gmod/Panel:SetDrawLanguageIDAtLeft) for a function that changes the position of the language selection box.

**Arguments:**
- `visible` (boolean) — true to make it visible, false to hide it.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetDrawLanguageID)

---

### Panel:SetDrawLanguageIDAtLeft · Client, Menu
`Panel:SetDrawLanguageIDAtLeft(left: boolean)`

Sets where to draw the language selection box.

See [Panel:SetDrawLanguageID](https://wiki.facepunch.com/gmod/Panel:SetDrawLanguageID) for a function that hides or shows the language selection box.

**Arguments:**
- `left` (boolean) — true = left, false = right

[wiki](https://wiki.facepunch.com/gmod/Panel:SetDrawLanguageIDAtLeft)

---

### Panel:SetDrawOnTop · Client, Menu
`Panel:SetDrawOnTop(drawOnTop: boolean = false)`

Makes the panel render in front of all others, including the spawn menu and main menu.

Priority is given based on the last call, so of two panels that call this method, the second will draw in front of the first.

**Arguments:**
- `drawOnTop` (boolean, default `false`) — Whether or not to draw the panel in front of all others.

> **Note:** This only makes the panel **draw** above other panels. If there's another panel that would have otherwise covered it, users will not be able to interact with it.
> 
> Completely disregards [PANEL:ParentToHUD](https://wiki.facepunch.com/gmod/PANEL:ParentToHUD).
> **Warning:** This does not work when using [PANEL:SetPaintedManually](https://wiki.facepunch.com/gmod/PANEL:SetPaintedManually) or [PANEL:PaintAt](https://wiki.facepunch.com/gmod/PANEL:PaintAt).

[wiki](https://wiki.facepunch.com/gmod/Panel:SetDrawOnTop)

---

### Panel:SetDropTarget · Client, Menu
`Panel:SetDropTarget(x: number, y: number, width: number, height: number)`

Sets the target area for dropping when an object is being dragged around this panel using the [dragndrop](https://wiki.facepunch.com/gmod/dragndrop). 

This draws a target box of the specified size and position, until [Panel:DragHoverEnd](https://wiki.facepunch.com/gmod/Panel:DragHoverEnd) is called. It uses [Panel:DrawDragHover](https://wiki.facepunch.com/gmod/Panel:DrawDragHover) to draw this area.

**Arguments:**
- `x` (number) — The x coordinate of the top-left corner of the drop area.
- `y` (number) — The y coordinate of the top-left corner of the drop area.
- `width` (number) — The width of the drop area.
- `height` (number) — The height of the drop area.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetDropTarget) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L468-L485)

---

### Panel:SetEnabled · Client, Menu
`Panel:SetEnabled(enable: boolean)`

Sets the enabled state of a panel object that supports being disabled, such as a [DButton](https://wiki.facepunch.com/gmod/DButton) or [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry).

Disabled panels cannot be interacted with, and have a different appearance to indicate this.

See [Panel:IsEnabled](https://wiki.facepunch.com/gmod/Panel:IsEnabled) for a function that retrieves the "enabled" state of a panel.

**Arguments:**
- `enable` (boolean) — Whether to enable or disable the panel object.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetEnabled)

---

### Panel:SetExpensiveShadow · Client, Menu
`Panel:SetExpensiveShadow(distance: number, Color: Color)`

Adds a shadow falling to the bottom right corner of the panel's text.

**Arguments:**
- `distance` (number) — The distance of the shadow from the panel.
- `Color` (Color) — The color of the shadow.

> **Note:** This works only on  panels that derive from [Label](https://wiki.facepunch.com/gmod/Label).

[wiki](https://wiki.facepunch.com/gmod/Panel:SetExpensiveShadow)

---

### Panel:SetFGColor · Client, Menu
`Panel:SetFGColor(r: number, g: number, b: number, a: number, color: Color)`

Sets the foreground color of a panel.

For a [Label](https://wiki.facepunch.com/gmod/Label) or [RichText](https://wiki.facepunch.com/gmod/RichText), this is the color of its text.

This function calls [Panel:SetFGColorEx](https://wiki.facepunch.com/gmod/Panel:SetFGColorEx) internally. 

Please note that for most panels the engine will overwrite the foreground and background colors a frame after panel creation via the [PANEL:ApplySchemeSettings](https://wiki.facepunch.com/gmod/PANEL:ApplySchemeSettings) hook, so you may want to set the color in that hook instead.

See [Panel:SetBGColor](https://wiki.facepunch.com/gmod/Panel:SetBGColor) for the background color.

**Arguments:**
- `r` (number) — The red channel of the color.
- `g` (number) — The green channel of the color.
- `b` (number) — The blue channel of the color.
- `a` (number) — The alpha channel of the color.
- `color` (Color) — A Color object/table to read the color from.

> **Note:** This doesn't apply to all VGUI elements (such as [DLabel](https://wiki.facepunch.com/gmod/DLabel)) and its function varies between them

[wiki](https://wiki.facepunch.com/gmod/Panel:SetFGColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L18-L26)

---

### Panel:SetFGColorEx · Client, Menu · `INTERNAL`
`Panel:SetFGColorEx(r: number, g: number, b: number, a: number)`

Sets the foreground color of the panel.

For labels, this is the color of their text.

**Arguments:**
- `r` (number) — The red channel of the color.
- `g` (number) — The green channel of the color.
- `b` (number) — The blue channel of the color.
- `a` (number) — The alpha channel of the color.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetFGColorEx)

---

### Panel:SetFocusTopLevel · Client, Menu
`Panel:SetFocusTopLevel(state: boolean)`

Sets the panel that owns this FocusNavGroup to be the root in the focus traversal hierarchy. This function will only work on EditablePanel class panels and its derivatives.

**Arguments:**
- `state` (boolean)

> **Note:** Child panels that should be part of the tab navigation need [Panel:SetTabPosition](https://wiki.facepunch.com/gmod/Panel:SetTabPosition) called on them.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetFocusTopLevel)

---

### Panel:SetFontInternal · Client, Menu
`Panel:SetFontInternal(fontName: string)`

Sets the font used to render this panel's text. This works for [Label](https://wiki.facepunch.com/gmod/Label), [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) and [RichText](https://wiki.facepunch.com/gmod/RichText), but it's a better idea to use their local `SetFont` ([DTextEntry:SetFont](https://wiki.facepunch.com/gmod/DTextEntry:SetFont), [DLabel:SetFont](https://wiki.facepunch.com/gmod/DLabel:SetFont)) methods when available.

To retrieve the font used by a panel, call [Panel:GetFont](https://wiki.facepunch.com/gmod/Panel:GetFont).

**Arguments:**
- `fontName` (string) — The name of the font.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetFontInternal)

---

### Panel:SetHeight · Client, Menu
`Panel:SetHeight(height: number)`

Sets the height of the panel.

Calls [PANEL:OnSizeChanged](https://wiki.facepunch.com/gmod/PANEL:OnSizeChanged) and marks this panel for layout ([Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout)).
Automatically rounds the height down

See also [Panel:SetSize](https://wiki.facepunch.com/gmod/Panel:SetSize).

**Arguments:**
- `height` (number) — The height to be set.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetHeight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L45-L47)

---

### Panel:SetHTML · Client, Menu
`Panel:SetHTML(HTML: string)`

Allows you to set HTML code within a panel.

**Arguments:**
- `HTML` (string) — The HTML code to set.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetHTML)

---

### Panel:SetKeyBoardInputEnabled · Client, Menu · `DEPRECATED`
`Panel:SetKeyBoardInputEnabled(keyboardInput: boolean)`

Enables or disables the keyboard input for the panel.

**Arguments:**
- `keyboardInput` (boolean) — Whether to enable or disable keyboard input.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetKeyBoardInputEnabled)

---

### Panel:SetLineHeight · Client, Menu
`Panel:SetLineHeight() → number`

Sets the height of a single line of a [RichText](https://wiki.facepunch.com/gmod/RichText) panel.

**Returns:**
- `height` (number) — The new line height.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetLineHeight)

---

### Panel:SetMaximumCharCount · Client, Menu
`Panel:SetMaximumCharCount(maxChar: number)`

Sets the maximum character count this panel should have.

This function will only work on [RichText](https://wiki.facepunch.com/gmod/RichText) and [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) panels and their derivatives.

**Arguments:**
- `maxChar` (number) — The new maximum amount of characters this panel is allowed to contain.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetMaximumCharCount)

---

### Panel:SetMinimumSize · Client, Menu
`Panel:SetMinimumSize(minW: number = nil, minH: number = nil)`

Sets the minimum dimensions of the panel or object.

You can restrict either or both values.

Calling the function without arguments will remove the minimum size.

**Arguments:**
- `minW` (number, default `nil`) — The minimum width of the object.
- `minH` (number, default `nil`) — The minimum height of the object.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetMinimumSize)

---

### Panel:SetModel · Client
`Panel:SetModel(ModelPath: string, skin: number = 0, bodygroups: string = nil)`

Sets the model to be displayed by [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon).

**Arguments:**
- `ModelPath` (string) — The path of the model to set
- `skin` (number, default `0`) — The skin to set
- `bodygroups` (string, default `nil`) — The body groups to set.

> **Note:** This must be called after setting size if you wish to use a different size spawnicon

[wiki](https://wiki.facepunch.com/gmod/Panel:SetModel)

---

### Panel:SetMouseInputEnabled · Client, Menu
`Panel:SetMouseInputEnabled(mouseInput: boolean)`

Enables or disables the mouse input for the panel.

**Arguments:**
- `mouseInput` (boolean) — Whenever to enable or disable mouse input.

> **Note:** Panels parented to the context menu will not be clickable unless [Panel:SetKeyboardInputEnabled](https://wiki.facepunch.com/gmod/Panel:SetKeyboardInputEnabled(lowercase)) is enabled or [Panel:MakePopup](https://wiki.facepunch.com/gmod/Panel:MakePopup) has been called. If you want the panel to have mouse input but you do not want to prevent players from moving, set [Panel:SetKeyboardInputEnabled](https://wiki.facepunch.com/gmod/Panel:SetKeyboardInputEnabled(lowercase)) to false immediately after calling [Panel:MakePopup](https://wiki.facepunch.com/gmod/Panel:MakePopup).

[wiki](https://wiki.facepunch.com/gmod/Panel:SetMouseInputEnabled)

---

### Panel:SetMultiline · Client, Menu
`Panel:SetMultiline(multiline: boolean)`

Enables or disables the multi-line functionality of [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) panel and its derivatives.

**Arguments:**
- `multiline` (boolean) — Whether to enable multiline or not.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetMultiline)

---

### Panel:SetName · Client, Menu
`Panel:SetName(name: string)`

Sets the internal name of the panel. Can be retrieved with [Panel:GetName](https://wiki.facepunch.com/gmod/Panel:GetName).

**Arguments:**
- `name` (string) — The new name of the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetName)

---

### Panel:SetOpenLinksExternally · Menu
`Panel:SetOpenLinksExternally(openExternally: boolean)`

Set to true to open links in an external browser. This only functions on the `x86-64` beta.

**Arguments:**
- `openExternally` (boolean)

[wiki](https://wiki.facepunch.com/gmod/Panel:SetOpenLinksExternally)

---

### Panel:SetPaintBackgroundEnabled · Client, Menu
`Panel:SetPaintBackgroundEnabled(paintBackground: boolean)`

Sets whether the default background of the panel should be drawn or not. It's color is usually set by [Panel:SetBGColor](https://wiki.facepunch.com/gmod/Panel:SetBGColor).

**Arguments:**
- `paintBackground` (boolean) — Whether to draw the background or not.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetPaintBackgroundEnabled)

---

### Panel:SetPaintBorderEnabled · Client, Menu
`Panel:SetPaintBorderEnabled(paintBorder: boolean)`

Sets whether the default border of the panel should be drawn or not.

**Arguments:**
- `paintBorder` (boolean) — Whether to draw the border or not.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetPaintBorderEnabled)

---

### Panel:SetPaintedManually · Client, Menu
`Panel:SetPaintedManually(paintedManually: boolean)`

Enables or disables painting of the panel manually with [Panel:PaintManual](https://wiki.facepunch.com/gmod/Panel:PaintManual).

**Arguments:**
- `paintedManually` (boolean) — True if the panel should be painted manually.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetPaintedManually)

---

### Panel:SetParent · Client, Menu
`Panel:SetParent(parent: Panel)`

Sets the parent of the panel.

**Arguments:**
- `parent` (Panel) — The new parent of the panel.

> **Note:** Panels parented to the context menu will not be clickable unless [Panel:SetMouseInputEnabled](https://wiki.facepunch.com/gmod/Panel:SetMouseInputEnabled) and [Panel:SetKeyboardInputEnabled](https://wiki.facepunch.com/gmod/Panel:SetKeyboardInputEnabled(lowercase)) are both true or [Panel:MakePopup](https://wiki.facepunch.com/gmod/Panel:MakePopup) has been called. If you want the panel to have mouse input but you do not want to prevent players from moving, set [Panel:SetKeyboardInputEnabled](https://wiki.facepunch.com/gmod/Panel:SetKeyboardInputEnabled(lowercase)) to false immediately after calling [Panel:MakePopup](https://wiki.facepunch.com/gmod/Panel:MakePopup).

[wiki](https://wiki.facepunch.com/gmod/Panel:SetParent)

---

### Panel:SetPlayer · Client
`Panel:SetPlayer(player: Player, size: number = 32)`

Used by [AvatarImage](https://wiki.facepunch.com/gmod/AvatarImage) to load an avatar for given player.

**Arguments:**
- `player` (Player) — The player to use avatar of.
- `size` (number, default `32`) — The size of the avatar to use.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetPlayer)

---

### Panel:SetPopupStayAtBack · Client, Menu
`Panel:SetPopupStayAtBack(stayAtBack: boolean)`

If this panel object has been made a popup with [Panel:MakePopup](https://wiki.facepunch.com/gmod/Panel:MakePopup), this method will prevent it from drawing in front of other panels when it receives input focus.

**Arguments:**
- `stayAtBack` (boolean) — If `true`, the popup panel will not draw in front of others when it gets focus, for example when it is clicked.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetPopupStayAtBack)

---

### Panel:SetPos · Client, Menu
`Panel:SetPos(posX: number, posY: number)`

Sets the position of the panel's top left corner.

This will trigger [PANEL:PerformLayout](https://wiki.facepunch.com/gmod/PANEL:PerformLayout). You should avoid calling this function in [PANEL:PerformLayout](https://wiki.facepunch.com/gmod/PANEL:PerformLayout) to avoid infinite loops.

See also [Panel:SetX](https://wiki.facepunch.com/gmod/Panel:SetX) and [Panel:SetY](https://wiki.facepunch.com/gmod/Panel:SetY).

**Arguments:**
- `posX` (number) — The x coordinate of the position.
- `posY` (number) — The y coordinate of the position.

> **Note:** If you wish to position and re-size panels without much guesswork and have them look good on different screen resolutions, you may find [Panel:Dock](https://wiki.facepunch.com/gmod/Panel:Dock) useful

[wiki](https://wiki.facepunch.com/gmod/Panel:SetPos)

---

### Panel:SetRenderInScreenshots · Client, Menu
`Panel:SetRenderInScreenshots(renderInScreenshot: boolean)`

Sets whenever the panel should be rendered in a screenshot. (`jpeg` or `screenshot` commands, Camera SWEP)

**Arguments:**
- `renderInScreenshot` (boolean) — Whether to render in the screenshot or not.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetRenderInScreenshots)

---

### Panel:SetSelectable · Client, Menu
`Panel:SetSelectable(selectable: boolean)`

Sets whether the panel object can be selected or not (like icons in the Spawn Menu, holding ). If enabled, this will affect the function of a [DButton](https://wiki.facepunch.com/gmod/DButton) whilst  is pressed. [Panel:SetSelected](https://wiki.facepunch.com/gmod/Panel:SetSelected) can be used to select/deselect the object.

**Arguments:**
- `selectable` (boolean) — Whether the panel object should be selectable or not.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetSelectable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L23-L27)

---

### Panel:SetSelected · Client, Menu
`Panel:SetSelected(selected: boolean = false)`

Sets the selected state of a selectable panel object. This functionality is set with [Panel:SetSelectable](https://wiki.facepunch.com/gmod/Panel:SetSelectable) and checked with [Panel:IsSelectable](https://wiki.facepunch.com/gmod/Panel:IsSelectable).

**Arguments:**
- `selected` (boolean, default `false`) — Whether the object should be selected or deselected.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetSelected) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L47-L57)

---

### Panel:SetSelectionCanvas · Client, Menu
`Panel:SetSelectionCanvas(set: boolean)`

Enables the panel object for selection (much like the spawn menu).

**Arguments:**
- `set` (boolean) — Whether to enable selection.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetSelectionCanvas) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L10-L15)

---

### Panel:SetSize · Client, Menu
`Panel:SetSize(width: number, height: number)`

Sets the size of the panel.

Calls [PANEL:OnSizeChanged](https://wiki.facepunch.com/gmod/PANEL:OnSizeChanged) and marks this panel for layout ([Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout)).
Automatically rounds the width and height down


See also [Panel:SetWidth](https://wiki.facepunch.com/gmod/Panel:SetWidth) and [Panel:SetHeight](https://wiki.facepunch.com/gmod/Panel:SetHeight).

**Arguments:**
- `width` (number) — The width of the panel.
- `height` (number) — The height of the panel.

> **Note:** If you wish to position and re-size panels without much guesswork and have them look good on different screen resolutions, you may find [Panel:Dock](https://wiki.facepunch.com/gmod/Panel:Dock) useful

[wiki](https://wiki.facepunch.com/gmod/Panel:SetSize)

---

### Panel:SetSkin · Client, Menu
`Panel:SetSkin(skinName: string)`

Sets the derma skin that the panel object will use, and refreshes all panels with [derma.RefreshSkins](https://wiki.facepunch.com/gmod/derma.RefreshSkins).

**Arguments:**
- `skinName` (string) — The name of the skin to use.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetSkin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L364-L373)

---

### Panel:SetSpawnIcon · Client
`Panel:SetSpawnIcon(icon: string)`

Sets the `.png` image to be displayed on a  [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon) or the panel it is based on - [ModelImage](https://wiki.facepunch.com/gmod/ModelImage).

Only `.png` images can be used with this function.

**Arguments:**
- `icon` (string) — A path to the .png material, for example one of the Silkicons shipped with the game.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetSpawnIcon)

---

### Panel:SetSteamID · Client
`Panel:SetSteamID(steamid: string, size: number)`

Used by [AvatarImage](https://wiki.facepunch.com/gmod/AvatarImage) panels to load an avatar by its 64-bit Steam ID (community ID).

**Arguments:**
- `steamid` (string) — The 64bit SteamID of the player to load avatar of
- `size` (number) — The size of the avatar to use.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetSteamID)

---

### Panel:SetTabPosition · Client, Menu
`Panel:SetTabPosition(position: number)`

When TAB is pressed, the next selectable panel in the number sequence is selected.

**Arguments:**
- `position` (number)

> **Note:** This function requires [Panel:SetFocusTopLevel](https://wiki.facepunch.com/gmod/Panel:SetFocusTopLevel) to be called on the parent panel for tab navigation to work.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetTabPosition)

---

### Panel:SetTall · Client, Menu
`Panel:SetTall(height: number)`

Sets height of a panel. An alias of [Panel:SetHeight](https://wiki.facepunch.com/gmod/Panel:SetHeight).

**Arguments:**
- `height` (number) — Desired height to set

[wiki](https://wiki.facepunch.com/gmod/Panel:SetTall)

---

### Panel:SetTerm · Client, Menu
`Panel:SetTerm(delay: number)`

Removes the panel after given time in seconds.

**Arguments:**
- `delay` (number) — Delay in seconds after which the panel should be removed.

> **Note:** This function will not work if [PANEL:AnimationThink](https://wiki.facepunch.com/gmod/PANEL:AnimationThink) is overridden, unless [Panel:AnimationThinkInternal](https://wiki.facepunch.com/gmod/Panel:AnimationThinkInternal) is called every frame.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetTerm) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L10-L15)

---

### Panel:SetText · Client, Menu
`Panel:SetText(text: string)`

Sets the text value of a panel object containing text, such as a [Label](https://wiki.facepunch.com/gmod/Label), [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) or  [RichText](https://wiki.facepunch.com/gmod/RichText) and their derivatives, such as [DLabel](https://wiki.facepunch.com/gmod/DLabel), [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) or [DButton](https://wiki.facepunch.com/gmod/DButton).

**Arguments:**
- `text` (string) — The text value to set.

> **Warning:** [Label](https://wiki.facepunch.com/gmod/Label) & its derivatives has hard length limit, maximum 1023 ascii characters.
> **Warning:** When used on a [Label](https://wiki.facepunch.com/gmod/Label) or its derivatives ( [DLabel](https://wiki.facepunch.com/gmod/DLabel) and [DButton](https://wiki.facepunch.com/gmod/DButton) ), it will automatically call [Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout), meaning that you should avoid running this function every frame on these panels to avoid unnecessary performance loss.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetText)

---

### Panel:SetTextHidden · Client, Menu
`Panel:SetTextHidden(a1: boolean)`

Makes [TextEntry](https://wiki.facepunch.com/gmod/TextEntry)'s text be replaced by `*` characters, just like a password-entry text field would.

**Arguments:**
- `a1` (boolean) — Whether to have the text be hidden.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetTextHidden)

---

### Panel:SetTextInset · Client, Menu
`Panel:SetTextInset(insetX: number, insetY: number)`

Sets the left and top text margins of a text-based panel object, such as a [DButton](https://wiki.facepunch.com/gmod/DButton) or [DLabel](https://wiki.facepunch.com/gmod/DLabel).

**Arguments:**
- `insetX` (number) — The left margin for the text, in pixels.
- `insetY` (number) — The top margin for the text, in pixels.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetTextInset)

---

### Panel:SetTextSelectionColors · Client, Menu
`Panel:SetTextSelectionColors(textColor: Color, backgroundColor: Color)`

Sets text selection colors of a [RichText](https://wiki.facepunch.com/gmod/RichText) element.

**Arguments:**
- `textColor` (Color) — The Color to set for selected text.
- `backgroundColor` (Color) — The Color to set for selected text background.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetTextSelectionColors)

---

### Panel:SetToFullHeight · Client, Menu
`Panel:SetToFullHeight()`

Sets the height of a [RichText](https://wiki.facepunch.com/gmod/RichText) element to accommodate the text inside.

> **Note:** This function internally relies on [Panel:GetNumLines](https://wiki.facepunch.com/gmod/Panel:GetNumLines), so it should be called at least a couple frames after modifying the text using [Panel:AppendText](https://wiki.facepunch.com/gmod/Panel:AppendText)

[wiki](https://wiki.facepunch.com/gmod/Panel:SetToFullHeight)

---

### Panel:SetTooltip · Client, Menu
`Panel:SetTooltip(str: string = nil)`

Sets the tooltip to be displayed when a player hovers over the panel object with their cursor.

By default, [DTooltip](https://wiki.facepunch.com/gmod/DTooltip) will be used. [Panel:SetTooltipPanelOverride](https://wiki.facepunch.com/gmod/Panel:SetTooltipPanelOverride) can be used to override the tooltip panel.

**Arguments:**
- `str` (string, default `nil`) — The text to be displayed in the tooltip.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetTooltip) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L301-L303)

---

### Panel:SetTooltipDelay · Client, Menu
`Panel:SetTooltipDelay(tooltip: number)`

Sets the tooltip delay. (time between hovering over the panel, and the tooltip showing up)

Can be retrieved with [Panel:GetTooltipDelay](https://wiki.facepunch.com/gmod/Panel:GetTooltipDelay).

**Arguments:**
- `tooltip` (number) — The tooltip delay to set.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetTooltipDelay) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L323-L325)

---

### Panel:SetTooltipPanel · Client, Menu
`Panel:SetTooltipPanel(tooltipPanel: Panel = nil)`

Sets the panel to be displayed as contents of a [DTooltip](https://wiki.facepunch.com/gmod/DTooltip) when a player hovers over the panel object with their cursor. See [Panel:SetTooltipPanelOverride](https://wiki.facepunch.com/gmod/Panel:SetTooltipPanelOverride) if you are looking to override [DTooltip](https://wiki.facepunch.com/gmod/DTooltip) itself.

**Arguments:**
- `tooltipPanel` (Panel, default `nil`) — The panel to use as the tooltip.

> **Note:** [Panel:SetTooltip](https://wiki.facepunch.com/gmod/Panel:SetTooltip) will override this functionality.
> **Warning:** Calling this from [PANEL:OnCursorEntered](https://wiki.facepunch.com/gmod/PANEL:OnCursorEntered) is too late! The tooltip will not be displayed or be updated.
> 
> 	Given panel or the previously set one will **NOT** be automatically removed.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetTooltipPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L309-L312)

---

### Panel:SetTooltipPanelOverride · Client, Menu
`Panel:SetTooltipPanelOverride(override: string)`

Sets the panel class to be created instead of [DTooltip](https://wiki.facepunch.com/gmod/DTooltip) when the player hovers over this panel and a tooltip needs creating.

**Arguments:**
- `override` (string) — The panel class to override the default DTooltip.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetTooltipPanelOverride) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L316-L318)

---

### Panel:SetUnderlineFont · Client, Menu
`Panel:SetUnderlineFont(fontName: string)`

Sets the underlined font for use by clickable text in a [RichText](https://wiki.facepunch.com/gmod/RichText). See also [Panel:InsertClickableTextStart](https://wiki.facepunch.com/gmod/Panel:InsertClickableTextStart)

This function will only work on [RichText](https://wiki.facepunch.com/gmod/RichText) panels.

**Arguments:**
- `fontName` (string) — The name of the font.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetUnderlineFont)

---

### Panel:SetURL · Client, Menu
`Panel:SetURL(url: string)`

Sets the URL of a link-based panel such as [DLabelURL](https://wiki.facepunch.com/gmod/DLabelURL).

**Arguments:**
- `url` (string) — The URL to set.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetURL)

---

### Panel:SetVerticalScrollbarEnabled · Client, Menu
`Panel:SetVerticalScrollbarEnabled(display: boolean = false)`

Sets the visibility of the vertical scrollbar.

Works for [RichText](https://wiki.facepunch.com/gmod/RichText) and [TextEntry](https://wiki.facepunch.com/gmod/TextEntry).

**Arguments:**
- `display` (boolean, default `false`) — True to display the vertical text scroll bar, false to hide it.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetVerticalScrollbarEnabled)

---

### Panel:SetVisible · Client, Menu
`Panel:SetVisible(visible: boolean)`

Sets the "visibility" of the panel.

**Arguments:**
- `visible` (boolean) — The visibility of the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetVisible)

---

### Panel:SetWide · Client, Menu
`Panel:SetWide(width: number)`

Sets width of a panel. An alias of [Panel:SetWidth](https://wiki.facepunch.com/gmod/Panel:SetWidth).

**Arguments:**
- `width` (number) — Desired width to set

[wiki](https://wiki.facepunch.com/gmod/Panel:SetWide)

---

### Panel:SetWidth · Client, Menu
`Panel:SetWidth(width: number)`

Sets the width of the panel.

Calls [PANEL:OnSizeChanged](https://wiki.facepunch.com/gmod/PANEL:OnSizeChanged) and marks this panel for layout ([Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout)).
Automatically rounds the width down

See also [Panel:SetSize](https://wiki.facepunch.com/gmod/Panel:SetSize).

**Arguments:**
- `width` (number) — The new width of the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetWidth) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L53-L55)

---

### Panel:SetWorldClicker · Client, Menu
`Panel:SetWorldClicker(enable: boolean)`

This makes it so that when you're hovering over this panel you can "click" on the world. Your weapon aim (and its viewmodel) will follow the cursor. This is primarily used for the Sandbox context menu.

**Arguments:**
- `enable` (boolean) — Whether to enable or disable the feature for this panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetWorldClicker)

---

### Panel:SetWrap · Client, Menu
`Panel:SetWrap(wrap: boolean)`

Sets whether text wrapping should be enabled or disabled on [Label](https://wiki.facepunch.com/gmod/Label) and [DLabel](https://wiki.facepunch.com/gmod/DLabel) panels.

Use [DLabel:SetAutoStretchVertical](https://wiki.facepunch.com/gmod/DLabel:SetAutoStretchVertical) to automatically correct vertical size; [Panel:SizeToContents](https://wiki.facepunch.com/gmod/Panel:SizeToContents) will not set the correct height.

**Arguments:**
- `wrap` (boolean) — `True` to enable text wrapping, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetWrap)

---

### Panel:SetX · Client, Menu
`Panel:SetX(x: number)`

Sets the X position of the panel.

Uses [Panel:SetPos](https://wiki.facepunch.com/gmod/Panel:SetPos) internally.

**Arguments:**
- `x` (number) — The X coordinate of the position.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetX) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L70-L72)

---

### Panel:SetY · Client, Menu
`Panel:SetY(y: number)`

Sets the Y position of the panel.

Uses [Panel:SetPos](https://wiki.facepunch.com/gmod/Panel:SetPos) internally.

**Arguments:**
- `y` (number) — The Y coordinate of the position.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetY) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L73-L75)

---

### Panel:SetZPos · Client, Menu
`Panel:SetZPos(zIndex: number)`

Sets the panels z position which determines the rendering order.

Panels with lower z positions appear behind panels with higher z positions.

This also controls in which order panels docked with [Panel:Dock](https://wiki.facepunch.com/gmod/Panel:Dock) appears.

**Arguments:**
- `zIndex` (number) — The z position of the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetZPos)

---

### Panel:Show · Client, Menu
`Panel:Show()`

Makes a panel visible.

[wiki](https://wiki.facepunch.com/gmod/Panel:Show) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L602-L604)

---

### Panel:SizeTo · Client, Menu
`Panel:SizeTo(sizeW: number = 0, sizeH: number = 0, time: number, delay: number = 0, ease: number = -1, callback: function = nil)`

Uses animation to resize the panel to the specified size.

**Arguments:**
- `sizeW` (number, default `0`) — The target width of the panel.
- `sizeH` (number, default `0`) — The target height of the panel.
- `time` (number) — The time to perform the animation within.
- `delay` (number, default `0`) — The delay before the animation starts.
- `ease` (number, default `-1`) — Easing of the start and/or end speed of the animation.
- `callback` (function, default `nil`) — The function to be called once the animation finishes.

[wiki](https://wiki.facepunch.com/gmod/Panel:SizeTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L182-L197)

---

### Panel:SizeToChildren · Client, Menu
`Panel:SizeToChildren(sizeW: boolean = false, sizeH: boolean = false)`

Resizes the panel to fit the bounds of its children.

**Arguments:**
- `sizeW` (boolean, default `false`) — Resize with width of the panel.
- `sizeH` (boolean, default `false`) — Resize the height of the panel.

> **Note:** The sizeW and sizeH parameters are false by default. Therefore, calling this function with no arguments will result in a no-op.
> **Note:** Your panel must have its layout updated ([Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout)) for this function to work properly.

[wiki](https://wiki.facepunch.com/gmod/Panel:SizeToChildren)

---

### Panel:SizeToContents · Client, Menu
`Panel:SizeToContents()`

Resizes the panel so that its width and height fit all of the content inside.

> **Note:** Only works on [Label](https://wiki.facepunch.com/gmod/Label) derived panels such as [DLabel](https://wiki.facepunch.com/gmod/DLabel) by default, and on any panel that manually implemented the [Panel:SizeToContents](https://wiki.facepunch.com/gmod/Panel:SizeToContents) method, such as [DNumberWang](https://wiki.facepunch.com/gmod/DNumberWang) and [DImage](https://wiki.facepunch.com/gmod/DImage).
> **Warning:** You must call this function **AFTER** setting text/font, adjusting child panels or otherwise altering the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:SizeToContents)

---

### Panel:SizeToContentsX · Client, Menu
`Panel:SizeToContentsX(addVal: number = 0)`

Resizes the panel object's width to accommodate all child objects/contents.

Only works on [Label](https://wiki.facepunch.com/gmod/Label) derived panels such as [DLabel](https://wiki.facepunch.com/gmod/DLabel) by default, and on any panel that manually implemented [Panel:GetContentSize](https://wiki.facepunch.com/gmod/Panel:GetContentSize) method.

**Arguments:**
- `addVal` (number, default `0`) — The number of extra pixels to add to the width.

> **Note:** You must call this function **AFTER** setting text/font or adjusting child panels.

[wiki](https://wiki.facepunch.com/gmod/Panel:SizeToContentsX) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L342-L349)

---

### Panel:SizeToContentsY · Client, Menu
`Panel:SizeToContentsY(addVal: number = 0)`

Resizes the panel object's height to accommodate all child objects/contents.

Only works on [Label](https://wiki.facepunch.com/gmod/Label) derived panels such as [DLabel](https://wiki.facepunch.com/gmod/DLabel) by default, and on any panel that manually implemented [Panel:GetContentSize](https://wiki.facepunch.com/gmod/Panel:GetContentSize) method.

**Arguments:**
- `addVal` (number, default `0`) — The number of extra pixels to add to the height.

> **Note:** You must call this function **AFTER** setting text/font or adjusting child panels.

[wiki](https://wiki.facepunch.com/gmod/Panel:SizeToContentsY) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L330-L337)

---

### Panel:SlideDown · Client, Menu
`Panel:SlideDown(Length: number)`

Slides the panel in from above.

**Arguments:**
- `Length` (number) — Time to complete the animation.

[wiki](https://wiki.facepunch.com/gmod/Panel:SlideDown) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L216-L224)

---

### Panel:SlideUp · Client, Menu
`Panel:SlideUp(Length: number)`

Slides the panel out to the top.

**Arguments:**
- `Length` (number) — Time to complete the animation.

[wiki](https://wiki.facepunch.com/gmod/Panel:SlideUp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L202-L211)

---

### Panel:StartBoxSelection · Client, Menu
`Panel:StartBoxSelection()`

Begins a box selection, enables mouse capture for the panel object, and sets the start point of the selection box to the mouse cursor's position, relative to this object. For this to work, either the object or its parent must be enabled as a selection canvas. This is set using [Panel:SetSelectionCanvas](https://wiki.facepunch.com/gmod/Panel:SetSelectionCanvas).

[wiki](https://wiki.facepunch.com/gmod/Panel:StartBoxSelection) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L134-L160)

---

### Panel:Stop · Client, Menu
`Panel:Stop()`

Stops all panel animations by clearing its animation list. This also clears all delayed animations.

[wiki](https://wiki.facepunch.com/gmod/Panel:Stop) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L78-L82)

---

### Panel:StopLoading · Client, Menu
`Panel:StopLoading()`

Stops the loading of the [HTML](https://wiki.facepunch.com/gmod/HTML) panel's current page.

[wiki](https://wiki.facepunch.com/gmod/Panel:StopLoading)

---

### Panel:StretchBottomTo · Client, Menu
`Panel:StretchBottomTo(tgtPanel: Panel, offset: number = 0)`

Resizes the panel object's height so that its bottom is aligned with the top of the passed panel. An offset greater than zero will reduce the panel's height to leave a gap between it and the passed panel.

**Arguments:**
- `tgtPanel` (Panel) — The panel to align the bottom of this one with.
- `offset` (number, default `0`) — The gap to leave between this and the passed panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:StretchBottomTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L146-L146)

---

### Panel:StretchRightTo · Client, Menu
`Panel:StretchRightTo(tgtPanel: Panel, offset: number = 0)`

Resizes the panel object's width so that its right edge is aligned with the left of the passed panel. An offset greater than zero will reduce the panel's width to leave a gap between it and the passed panel.

**Arguments:**
- `tgtPanel` (Panel) — The panel to align the right edge of this one with.
- `offset` (number, default `0`) — The gap to leave between this and the passed panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:StretchRightTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L145-L145)

---

### Panel:StretchToParent · Client, Menu
`Panel:StretchToParent(offsetLeft: number = nil, offsetTop: number = nil, offsetRight: number = nil, offsetBottom: number = nil)`

Sets the dimensions of the panel to fill its parent. It will only stretch in directions that aren't nil.

**Arguments:**
- `offsetLeft` (number, default `nil`) — The left offset to the parent.
- `offsetTop` (number, default `nil`) — The top offset to the parent.
- `offsetRight` (number, default `nil`) — The right offset to the parent.
- `offsetBottom` (number, default `nil`) — The bottom offset to the parent.

[wiki](https://wiki.facepunch.com/gmod/Panel:StretchToParent) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L80-L103)

---

### Panel:ToggleSelection · Client, Menu
`Panel:ToggleSelection()`

Toggles the selected state of a selectable panel object. This functionality is set with [Panel:SetSelectable](https://wiki.facepunch.com/gmod/Panel:SetSelectable) and checked with [Panel:IsSelectable](https://wiki.facepunch.com/gmod/Panel:IsSelectable). To check whether the object is selected or not, [Panel:IsSelected](https://wiki.facepunch.com/gmod/Panel:IsSelected) is used.

[wiki](https://wiki.facepunch.com/gmod/Panel:ToggleSelection) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L29-L33)

---

### Panel:ToggleVisible · Client, Menu
`Panel:ToggleVisible()`

Toggles the visibility of a panel and all its children.

[wiki](https://wiki.facepunch.com/gmod/Panel:ToggleVisible) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L418-L420)

---

### Panel:Undo · Client, Menu
`Panel:Undo()`

Restores the last saved state (caret position and the text inside) of a [TextEntry](https://wiki.facepunch.com/gmod/TextEntry). Should act identically to pressing CTRL+Z in a [TextEntry](https://wiki.facepunch.com/gmod/TextEntry).

See also [Panel:SaveUndoState](https://wiki.facepunch.com/gmod/Panel:SaveUndoState).

[wiki](https://wiki.facepunch.com/gmod/Panel:Undo)

---

### Panel:UnselectAll · Client, Menu
`Panel:UnselectAll()`

Recursively deselects this panel object and all of its children. This will cascade to all child objects at every level below the parent.

[wiki](https://wiki.facepunch.com/gmod/Panel:UnselectAll) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L35-L43)

---

### Panel:UpdateHTMLTexture · Client, Menu
`Panel:UpdateHTMLTexture()`

Forcibly updates the panels' HTML Material, similar to when Paint is called on it.This is only useful if the panel is not normally visible, i.e the panel exists purely for its HTML Material.

> **Note:** A good place to call this is in the [GM:PreRender](https://wiki.facepunch.com/gmod/GM:PreRender) hook
> **Note:** Only works on with panels that have a HTML Material. See [Panel:GetHTMLMaterial](https://wiki.facepunch.com/gmod/Panel:GetHTMLMaterial) for more details.

[wiki](https://wiki.facepunch.com/gmod/Panel:UpdateHTMLTexture)

---

### Panel:Valid · Client, Menu · `DEPRECATED`
`Panel:Valid() → boolean`

Returns if a given panel is valid or not.

**Returns:**
- boolean — Whether the panel is valid or not, true being it is, false being it isn't.

[wiki](https://wiki.facepunch.com/gmod/Panel:Valid)

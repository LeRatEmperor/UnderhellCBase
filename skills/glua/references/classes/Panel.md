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

> **Part 1 of 2** (`Add` – `SetConVar`). All parts: [1](Panel.md), [2](Panel-2.md)


### Panel:Add · Client, Menu
`Panel:Add(object: Panel, class: string, table: table) → Panel`

When provided with a string or table, this function will create a new vgui element with that name and set the parent to the panel that this method is called on. When provided with a panel it will use [Panel:SetParent](https://wiki.facepunch.com/gmod/Panel:SetParent) on the provided panel to set it to our source panel

**Arguments:**
- `object` (Panel) — The panel to be added (parented).
- `class` (string) — The class to be added.
- `table` (table) — The table to create the panel from.

**Returns:**
- Panel — New panel

[wiki](https://wiki.facepunch.com/gmod/Panel:Add) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L506-L521)

---

### Panel:AddText · Client, Menu · `DEPRECATED`
`Panel:AddText()`

This function does nothing.

[wiki](https://wiki.facepunch.com/gmod/Panel:AddText)

---

### Panel:AlignBottom · Client, Menu
`Panel:AlignBottom(offset: number = 0)`

Aligns the panel on the bottom of its parent with the specified offset.

**Arguments:**
- `offset` (number, default `0`) — The align offset.

[wiki](https://wiki.facepunch.com/gmod/Panel:AlignBottom) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L129-L129)

---

### Panel:AlignLeft · Client, Menu
`Panel:AlignLeft(offset: number = 0)`

Aligns the panel on the left of its parent with the specified offset.

**Arguments:**
- `offset` (number, default `0`) — The align offset.

[wiki](https://wiki.facepunch.com/gmod/Panel:AlignLeft) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L132-L132)

---

### Panel:AlignRight · Client, Menu
`Panel:AlignRight(offset: number = 0)`

Aligns the panel on the right of its parent with the specified offset.

**Arguments:**
- `offset` (number, default `0`) — The align offset.

[wiki](https://wiki.facepunch.com/gmod/Panel:AlignRight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L130-L130)

---

### Panel:AlignTop · Client, Menu
`Panel:AlignTop(offset: number = 0)`

Aligns the panel on the top of its parent with the specified offset.

**Arguments:**
- `offset` (number, default `0`) — The align offset.

[wiki](https://wiki.facepunch.com/gmod/Panel:AlignTop) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L131-L131)

---

### Panel:AlphaTo · Client, Menu
`Panel:AlphaTo(alpha: number, duration: number, delay: number = 0, callback: function = nil)`

Uses animation to transition the current alpha value of a panel to a new alpha, over a set period of time and after a specified delay.

**Arguments:**
- `alpha` (number) — The alpha value (0-255) to approach.
- `duration` (number) — The time in seconds it should take to reach the alpha.
- `delay` (number, default `0`) — The delay before the animation starts.
- `callback` (function, default `nil`) — The function to be called once the animation finishes.

[wiki](https://wiki.facepunch.com/gmod/Panel:AlphaTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L263-L269)

---

### Panel:AnimationThinkInternal · Client, Menu · `INTERNAL`
`Panel:AnimationThinkInternal()`

Performs the per-frame operations required for panel animations.

This is called every frame by [PANEL:AnimationThink](https://wiki.facepunch.com/gmod/PANEL:AnimationThink).

[wiki](https://wiki.facepunch.com/gmod/Panel:AnimationThinkInternal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L20-L59)

---

### Panel:AnimTail · Client, Menu
`Panel:AnimTail() → number`

Returns the [SysTime](https://wiki.facepunch.com/gmod/Global.SysTime) value when all animations for this panel object will end.

**Returns:**
- number — The system time value when all animations will end for this panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:AnimTail) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L90-L100)

---

### Panel:AppendText · Client, Menu
`Panel:AppendText(txt: string)`

Appends text to a [RichText](https://wiki.facepunch.com/gmod/RichText) element. This does not automatically add a new line.

**Arguments:**
- `txt` (string) — The text to append (add on).

[wiki](https://wiki.facepunch.com/gmod/Panel:AppendText)

---

### Panel:AppendTextWithURLs · Client, Menu
`Panel:AppendTextWithURLs(txt: string)`

Appends text to a [RichText](https://wiki.facepunch.com/gmod/RichText) element (exactly like [Panel:AppendText](https://wiki.facepunch.com/gmod/Panel:AppendText)), while also parsing and adding valid URLs ([Panel:InsertClickableTextStart](https://wiki.facepunch.com/gmod/Panel:InsertClickableTextStart)). This does not automatically add a new line.

**Arguments:**
- `txt` (string) — The text to append (add on).

[wiki](https://wiki.facepunch.com/gmod/Panel:AppendTextWithURLs)

---

### Panel:ApplyGWEN · Client, Menu
`Panel:ApplyGWEN(GWENTable: table)`

Used by [Panel:LoadGWENFile](https://wiki.facepunch.com/gmod/Panel:LoadGWENFile) and [Panel:LoadGWENString](https://wiki.facepunch.com/gmod/Panel:LoadGWENString) to apply a GWEN controls table to a panel object.

You can do this manually using [file.Read](https://wiki.facepunch.com/gmod/file.Read) and [util.JSONToTable](https://wiki.facepunch.com/gmod/util.JSONToTable) to import and create a GWEN table structure from a `.gwen` file. This method can then be called, passing the GWEN table's `Controls` member.

**Arguments:**
- `GWENTable` (table) — The GWEN controls table to apply to the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:ApplyGWEN) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L166-L196)

---

### Panel:Center · Client, Menu
`Panel:Center()`

Centers the panel on its parent. 

See [Panel:CenterHorizontal](https://wiki.facepunch.com/gmod/Panel:CenterHorizontal) and [Panel:CenterVertical](https://wiki.facepunch.com/gmod/Panel:CenterVertical) for more specialized functions.

> **Note:** This will center the panel using the current size of the panel, so it should be called **AFTER** setting or adjusting the size of the panel.
> 
> Take special care when using [Panel:Dock](https://wiki.facepunch.com/gmod/Panel:Dock) as it will not update the size immediately.
> 
> You may want to use [Panel:PerformLayout](https://wiki.facepunch.com/gmod/Panel:PerformLayout) to set positions of child panels.

[wiki](https://wiki.facepunch.com/gmod/Panel:Center) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L165-L170)

---

### Panel:CenterHorizontal · Client, Menu
`Panel:CenterHorizontal(fraction: number = 0.5)`

Centers the panel horizontally with specified fraction.

See [Panel:CenterVertical](https://wiki.facepunch.com/gmod/Panel:CenterVertical) for vertical only centering, and  [Panel:Center](https://wiki.facepunch.com/gmod/Panel:Center) for a function that does both axes.

**Arguments:**
- `fraction` (number, default `0.5`) — The center fraction.

[wiki](https://wiki.facepunch.com/gmod/Panel:CenterHorizontal) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L158-L160)

---

### Panel:CenterVertical · Client, Menu
`Panel:CenterVertical(fraction: number = 0.5)`

Centers the panel vertically with specified fraction.

See [Panel:CenterHorizontal](https://wiki.facepunch.com/gmod/Panel:CenterHorizontal) for horizontal only centering, and  [Panel:Center](https://wiki.facepunch.com/gmod/Panel:Center) for a function that does both axes.

**Arguments:**
- `fraction` (number, default `0.5`) — The center fraction.

[wiki](https://wiki.facepunch.com/gmod/Panel:CenterVertical) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L151-L153)

---

### Panel:ChildCount · Client, Menu
`Panel:ChildCount() → number`

Returns the amount of children of the of panel.

**Returns:**
- number — The amount of children the panel has.

[wiki](https://wiki.facepunch.com/gmod/Panel:ChildCount) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmenu.lua#L145-L147)

---

### Panel:ChildrenSize · Client, Menu
`Panel:ChildrenSize() → number, number`

Returns the width and height of the space between the position of the panel (upper-left corner) and the max bound of the children panels (farthest reaching lower-right corner).

**Returns:**
- number — The children size width.
- number — The children size height.

[wiki](https://wiki.facepunch.com/gmod/Panel:ChildrenSize)

---

### Panel:Clear · Client, Menu
`Panel:Clear()`

Removes all of the panel's children. Many panels also override this method to gracefully clear their contents without breaking themselves.

[wiki](https://wiki.facepunch.com/gmod/Panel:Clear) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L590-L596)

---

### Panel:ColorTo · Client, Menu
`Panel:ColorTo(color: Color, length: number, delay: number = 0, callback: function = nil)`

Fades panels color to specified one.

**Arguments:**
- `color` (Color) — The color to fade to
- `length` (number) — Length of the animation
- `delay` (number, default `0`) — Delay before start fading
- `callback` (function, default `nil`) — Function to execute when finished

> **Note:** The panel must have `GetColor` and `SetColor` functions for `ColorTo` to work.

[wiki](https://wiki.facepunch.com/gmod/Panel:ColorTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L240-L250)

---

### Panel:ConVarChanged · Client, Menu
`Panel:ConVarChanged(newValue: string)`

Updates a panel object's associated console variable. This must first be set up with [Derma_Install_Convar_Functions](https://wiki.facepunch.com/gmod/Global.Derma_Install_Convar_Functions), and have a ConVar set using [Panel:SetConVar](https://wiki.facepunch.com/gmod/Panel:SetConVar).

**Arguments:**
- `newValue` (string) — The new value to set the associated console variable to.

[wiki](https://wiki.facepunch.com/gmod/Panel:ConVarChanged) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/init.lua#L86-L91)

---

### Panel:ConVarNumberThink · Client, Menu
`Panel:ConVarNumberThink()`

A think hook for [Panel](https://wiki.facepunch.com/gmod/Panel)s using ConVars as a value. Call it in the Think hook. Sets the panel's value should the convar change.

This function is best for: checkboxes, sliders, number wangs

For a string alternative, see [Panel:ConVarStringThink](https://wiki.facepunch.com/gmod/Panel:ConVarStringThink).

> **Note:** Make sure your Panel has a SetValue function, else you may get errors.

[wiki](https://wiki.facepunch.com/gmod/Panel:ConVarNumberThink) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/init.lua#L106-L119)

---

### Panel:ConVarStringThink · Client, Menu
`Panel:ConVarStringThink()`

A think hook for [panels](https://wiki.facepunch.com/gmod/Panel) using ConVars as a value. Call it in the Think hook. Sets the panel's value should the convar change.

This function is best for: text inputs, read-only inputs, dropdown selects

For a number alternative, see [Panel:ConVarNumberThink](https://wiki.facepunch.com/gmod/Panel:ConVarNumberThink).

> **Note:** Make sure your Panel has a SetValue function, else you may get errors.

[wiki](https://wiki.facepunch.com/gmod/Panel:ConVarStringThink) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/init.lua#L94-L104)

---

### Panel:CopyBase · Client, Menu
`Panel:CopyBase(srcPanel: Panel)`

Gets the size, position and dock state of the passed panel object, and applies it to this one.

**Arguments:**
- `srcPanel` (Panel) — The panel to copy the boundary and dock settings from.

[wiki](https://wiki.facepunch.com/gmod/Panel:CopyBase) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L497-L504)

---

### Panel:CopyBounds · Client, Menu
`Panel:CopyBounds(base: Panel)`

Copies position and size of the panel.

**Arguments:**
- `base` (Panel) — The panel to copy size and position from.

[wiki](https://wiki.facepunch.com/gmod/Panel:CopyBounds) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L175-L182)

---

### Panel:CopyHeight · Client, Menu
`Panel:CopyHeight(base: Panel)`

Copies the height of the panel.

**Arguments:**
- `base` (Panel) — Panel to copy the height from.

[wiki](https://wiki.facepunch.com/gmod/Panel:CopyHeight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L108-L110)

---

### Panel:CopyPos · Client, Menu
`Panel:CopyPos(base: Panel)`

Copies the position of the panel.

**Arguments:**
- `base` (Panel) — Panel to position the width from.

[wiki](https://wiki.facepunch.com/gmod/Panel:CopyPos) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L122-L124)

---

### Panel:CopySelected · Client, Menu
`Panel:CopySelected()`

Performs the  +  key combination effect ( Copy selection to clipboard ) on selected text in a [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) or [RichText](https://wiki.facepunch.com/gmod/RichText) based element.

[wiki](https://wiki.facepunch.com/gmod/Panel:CopySelected)

---

### Panel:CopyWidth · Client, Menu
`Panel:CopyWidth(base: Panel)`

Copies the width of the panel.

**Arguments:**
- `base` (Panel) — Panel to copy the width from.

[wiki](https://wiki.facepunch.com/gmod/Panel:CopyWidth) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L115-L117)

---

### Panel:CursorPos · Client, Menu
`Panel:CursorPos() → number, number`

Returns the cursor position relative to the top left of the panel.

This is equivalent to calling [gui.MousePos](https://wiki.facepunch.com/gmod/gui.MousePos) and then [Panel:ScreenToLocal](https://wiki.facepunch.com/gmod/Panel:ScreenToLocal).

**Returns:**
- number — X coordinate of the cursor, relative to the top left of the panel.
- number — Y coordinate of the cursor, relative to the top left of the panel.

> **Warning:** This function uses a cached value for the screen position of the panel, computed at the end of the last VGUI Think/Layout pass.
> 
> ie. inaccurate results may be returned if the panel or any of its ancestors have been repositioned outside of [PANEL:Think](https://wiki.facepunch.com/gmod/PANEL:Think) or [PANEL:PerformLayout](https://wiki.facepunch.com/gmod/PANEL:PerformLayout) within the last frame.

[wiki](https://wiki.facepunch.com/gmod/Panel:CursorPos)

---

### Panel:CutSelected · Client, Menu
`Panel:CutSelected()`

Performs the  +  (delete text and copy it to clipboard buffer) action on selected text in a [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) or [RichText](https://wiki.facepunch.com/gmod/RichText) based element.

[wiki](https://wiki.facepunch.com/gmod/Panel:CutSelected)

---

### Panel:DeleteCookie · Client, Menu
`Panel:DeleteCookie(cookieName: string)`

Deletes a cookie value using the panel's cookie name ( [Panel:GetCookieName](https://wiki.facepunch.com/gmod/Panel:GetCookieName) ) and the passed extension.

**Arguments:**
- `cookieName` (string) — The unique cookie name to delete.

[wiki](https://wiki.facepunch.com/gmod/Panel:DeleteCookie) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L238-L245)

---

### Panel:DisableLerp · Client, Menu
`Panel:DisableLerp()`

Resets the panel object's [Panel:SetPos](https://wiki.facepunch.com/gmod/Panel:SetPos) method and removes its animation table (`Panel.LerpAnim`). This effectively undoes the changes made by [Panel:LerpPositions](https://wiki.facepunch.com/gmod/Panel:LerpPositions).

In order to use Lerp animation again, you must call [Panel:Stop](https://wiki.facepunch.com/gmod/Panel:Stop) before setting its `SetPosReal` property to `nil`. See the example below.

[wiki](https://wiki.facepunch.com/gmod/Panel:DisableLerp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L359-L365)

---

### Panel:Distance · Client, Menu
`Panel:Distance(tgtPanel: Panel) → number`

Returns the linear distance from the center of this panel object and another. **Both panels must have the same parent for this function to work properly.**

**Arguments:**
- `tgtPanel` (Panel) — The target object with which to compare position.

**Returns:**
- number — The linear (straight-line) distance between the center of the two objects.

[wiki](https://wiki.facepunch.com/gmod/Panel:Distance) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L422-L428)

---

### Panel:DistanceFrom · Client, Menu
`Panel:DistanceFrom(posX: number, posY: number) → number`

Returns the distance between the center of this panel object and a specified point **local to the parent panel**.

**Arguments:**
- `posX` (number) — The horizontal (x) position in pixels of the point to compare with.
- `posY` (number) — The vertical (y) position in pixels of the point to compare with.

**Returns:**
- number — The linear (straight-line) distance between the specified point local to parent panel and the center of this panel object.

[wiki](https://wiki.facepunch.com/gmod/Panel:DistanceFrom) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L430-L437)

---

### Panel:Dock · Client, Menu
`Panel:Dock(dockType: number{DOCK})`

Sets the dock type for the panel, making the panel "dock" in a certain direction, modifying it's position and size.

You can set the inner spacing of a panel's docking using [Panel:DockPadding](https://wiki.facepunch.com/gmod/Panel:DockPadding), which will affect docked child panels, and you can set the outer spacing of a panel's docking using [Panel:DockMargin](https://wiki.facepunch.com/gmod/Panel:DockMargin), which affects how docked siblings are positioned/sized.

You may need to use [Panel:SetZPos](https://wiki.facepunch.com/gmod/Panel:SetZPos) to ensure child panels ([DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry)) stay in a specific order.

**Arguments:**
- `dockType` (number{DOCK}) — Dock type using DOCK.

> **Note:** After using this function, if you want to get the correct panel's bounds (position, size), use [Panel:InvalidateParent](https://wiki.facepunch.com/gmod/Panel:InvalidateParent) (use `true` as argument if you need to update immediately)

[wiki](https://wiki.facepunch.com/gmod/Panel:Dock)

---

### Panel:DockMargin · Client, Menu
`Panel:DockMargin(marginLeft: number, marginTop: number, marginRight: number, marginBottom: number)`

Sets the dock margin of the panel.

The dock margin is the extra space that will be left around the edge when this element is docked inside its parent element.

**Arguments:**
- `marginLeft` (number) — The left margin to the parent.
- `marginTop` (number) — The top margin to the parent.
- `marginRight` (number) — The right margin to the parent.
- `marginBottom` (number) — The bottom margin to the parent.

[wiki](https://wiki.facepunch.com/gmod/Panel:DockMargin)

---

### Panel:DockPadding · Client, Menu
`Panel:DockPadding(paddingLeft: number, paddingTop: number, paddingRight: number, paddingBottom: number)`

Sets the dock padding of the panel.

The dock padding is the extra space that will be left around the edge when child elements are docked inside this element.

**Arguments:**
- `paddingLeft` (number) — The left padding to the parent.
- `paddingTop` (number) — The top padding to the parent.
- `paddingRight` (number) — The right padding to the parent.
- `paddingBottom` (number) — The bottom padding to the parent.

[wiki](https://wiki.facepunch.com/gmod/Panel:DockPadding)

---

### Panel:DoModal · Client, Menu
`Panel:DoModal()`

Makes the panel "lock" the screen until it is removed. All input will be directed to the given panel.

It will silently fail if used while cursor is not visible.
Call [Panel:MakePopup](https://wiki.facepunch.com/gmod/Panel:MakePopup) before calling this function.
This must be called on a panel derived from [EditablePanel](https://wiki.facepunch.com/gmod/EditablePanel).

[wiki](https://wiki.facepunch.com/gmod/Panel:DoModal)

---

### Panel:DragClick · Client, Menu · `INTERNAL`
`Panel:DragClick() → boolean`

Called by [Panel:DragMouseRelease](https://wiki.facepunch.com/gmod/Panel:DragMouseRelease) when a user clicks one mouse button whilst dragging with another.

**Returns:**
- boolean — Always returns `true`.

[wiki](https://wiki.facepunch.com/gmod/Panel:DragClick) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L431-L438)

---

### Panel:DragHover · Client, Menu · `INTERNAL`
`Panel:DragHover(HoverTime: number)`

Called by [dragndrop.HoverThink](https://wiki.facepunch.com/gmod/dragndrop.HoverThink) to perform actions on an object that is dragged and hovered over another.

**Arguments:**
- `HoverTime` (number) — If this time is greater than 0.1, PANEL:DragHoverClick is called, passing it as an argument.

[wiki](https://wiki.facepunch.com/gmod/Panel:DragHover) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L499-L512)

---

### Panel:DragHoverEnd · Client, Menu · `INTERNAL`
`Panel:DragHoverEnd()`

Called to end a drag and hover action. This resets the panel's [PANEL:PaintOver](https://wiki.facepunch.com/gmod/PANEL:PaintOver) method, and is primarily used by [dragndrop.StopDragging](https://wiki.facepunch.com/gmod/dragndrop.StopDragging).

[wiki](https://wiki.facepunch.com/gmod/Panel:DragHoverEnd) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L531-L538)

---

### Panel:DragMousePress · Client, Menu
`Panel:DragMousePress(mouseCode: number)`

Called to inform the [dragndrop](https://wiki.facepunch.com/gmod/dragndrop) that a mouse button is being held down on a panel object.

**Arguments:**
- `mouseCode` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The code for the mouse button pressed, passed by, for example, PANEL:OnMousePressed.

[wiki](https://wiki.facepunch.com/gmod/Panel:DragMousePress) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L412-L429)

---

### Panel:DragMouseRelease · Client, Menu
`Panel:DragMouseRelease(mouseCode: number) → boolean`

Called to inform the [dragndrop](https://wiki.facepunch.com/gmod/dragndrop) that a mouse button has been depressed on a panel object.

**Arguments:**
- `mouseCode` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — The code for the mouse button pressed, passed by, for example, PANEL:OnMouseReleased.

**Returns:**
- boolean — `true` if an object was being dragged, otherwise `false`.

[wiki](https://wiki.facepunch.com/gmod/Panel:DragMouseRelease) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L440-L466)

---

### Panel:DrawDragHover · Client, Menu · `INTERNAL`
`Panel:DrawDragHover(x: number, y: number, width: number, height: number)`

Called to draw the drop target when an object is being dragged across another. See [Panel:SetDropTarget](https://wiki.facepunch.com/gmod/Panel:SetDropTarget).

**Arguments:**
- `x` (number) — The x coordinate of the top-left corner of the drop area.
- `y` (number) — The y coordinate of the top-left corner of the drop area.
- `width` (number) — The width of the drop area.
- `height` (number) — The height of the drop area.

[wiki](https://wiki.facepunch.com/gmod/Panel:DrawDragHover) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L514-L529)

---

### Panel:DrawFilledRect · Client, Menu
`Panel:DrawFilledRect()`

Draws a coloured rectangle to fill the panel object this method is called on. The colour is set using [surface.SetDrawColor](https://wiki.facepunch.com/gmod/surface.SetDrawColor). This should only be called within the object's [PANEL:Paint](https://wiki.facepunch.com/gmod/PANEL:Paint) or [PANEL:PaintOver](https://wiki.facepunch.com/gmod/PANEL:PaintOver) hooks, as a shortcut for [surface.DrawRect](https://wiki.facepunch.com/gmod/surface.DrawRect).

[wiki](https://wiki.facepunch.com/gmod/Panel:DrawFilledRect)

---

### Panel:DrawOutlinedRect · Client, Menu
`Panel:DrawOutlinedRect()`

Draws a hollow rectangle the size of the panel object this method is called on, with a border width of 1 px. The border colour is set using [surface.SetDrawColor](https://wiki.facepunch.com/gmod/surface.SetDrawColor). This should only be called within the object's [PANEL:Paint](https://wiki.facepunch.com/gmod/PANEL:Paint) or [PANEL:PaintOver](https://wiki.facepunch.com/gmod/PANEL:PaintOver) hooks, as a shortcut for [surface.DrawOutlinedRect](https://wiki.facepunch.com/gmod/surface.DrawOutlinedRect).

[wiki](https://wiki.facepunch.com/gmod/Panel:DrawOutlinedRect)

---

### Panel:DrawSelections · Client, Menu
`Panel:DrawSelections()`

Used to draw the magenta highlight colour of a panel object when it is selected. This should be called in the object's [PANEL:PaintOver](https://wiki.facepunch.com/gmod/PANEL:PaintOver) hook. Once this is implemented, the highlight colour will be displayed only when the object is selectable and selected. This is achieved using [Panel:SetSelectable](https://wiki.facepunch.com/gmod/Panel:SetSelectable) and [Panel:SetSelected](https://wiki.facepunch.com/gmod/Panel:SetSelected) respectively.

[wiki](https://wiki.facepunch.com/gmod/Panel:DrawSelections) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L91-L101)

---

### Panel:DrawTextEntryText · Client, Menu
`Panel:DrawTextEntryText(textCol: table, highlightCol: table, cursorCol: table)`

Used to draw the text in a [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry) within a derma skin. This is usually called within the [SKIN:PaintTextEntry](https://wiki.facepunch.com/gmod/SKIN:PaintTextEntry) skin hook.

**Arguments:**
- `textCol` (table) — The colour of the main text.
- `highlightCol` (table) — The colour of the selection highlight (when selecting text).
- `cursorCol` (table) — The colour of the text cursor (or caret).

> **Note:** Will silently fail if any of arguments are not given.

[wiki](https://wiki.facepunch.com/gmod/Panel:DrawTextEntryText)

---

### Panel:DrawTexturedRect · Client, Menu
`Panel:DrawTexturedRect()`

Draws a textured rectangle to fill the panel object this method is called on. The texture is set using [surface.SetTexture](https://wiki.facepunch.com/gmod/surface.SetTexture) or [surface.SetMaterial](https://wiki.facepunch.com/gmod/surface.SetMaterial). This should only be called within the object's [PANEL:Paint](https://wiki.facepunch.com/gmod/PANEL:Paint) or [PANEL:PaintOver](https://wiki.facepunch.com/gmod/PANEL:PaintOver) hooks, as a shortcut for [surface.DrawTexturedRect](https://wiki.facepunch.com/gmod/surface.DrawTexturedRect).

[wiki](https://wiki.facepunch.com/gmod/Panel:DrawTexturedRect)

---

### Panel:Droppable · Client, Menu
`Panel:Droppable(name: string) → table`

Makes this panel droppable. This is used with [Panel:Receiver](https://wiki.facepunch.com/gmod/Panel:Receiver) to create drag and drop events.

Can be called multiple times with different names allowing to be dropped onto different receivers.

**Arguments:**
- `name` (string) — Name of your droppable panel

**Returns:**
- table — Blank table stored on the panel itself under pnl.m_DragSlot[ name ].

[wiki](https://wiki.facepunch.com/gmod/Panel:Droppable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L302-L310)

---

### Panel:EndBoxSelection · Client, Menu
`Panel:EndBoxSelection() → boolean`

Completes a box selection. If the end point of the selection box is within the selection canvas, mouse capture is disabled for the panel object, and the selected state of each child object within the selection box is toggled.

**Returns:**
- boolean — Whether the end point of the selection box was within the selection canvas.

[wiki](https://wiki.facepunch.com/gmod/Panel:EndBoxSelection) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L223-L249)

---

### Panel:Exec · Client, Menu · `INTERNAL`
`Panel:Exec(cmd: string)`

Used to run commands within a [DHTML](https://wiki.facepunch.com/gmod/DHTML) window.

**Arguments:**
- `cmd` (string) — The command to be run.

[wiki](https://wiki.facepunch.com/gmod/Panel:Exec)

---

### Panel:Find · Client, Menu
`Panel:Find(panelName: string) → Panel`

Finds a panel in its children(and sub children) with the given name.

**Arguments:**
- `panelName` (string) — The name of the panel that should be found.

**Returns:**
- Panel — foundPanel

[wiki](https://wiki.facepunch.com/gmod/Panel:Find)

---

### Panel:FocusNext · Client, Menu
`Panel:FocusNext()`

Focuses the next panel in the focus queue.

[wiki](https://wiki.facepunch.com/gmod/Panel:FocusNext)

---

### Panel:FocusPrevious · Client, Menu
`Panel:FocusPrevious()`

Focuses the previous panel in the focus queue.

[wiki](https://wiki.facepunch.com/gmod/Panel:FocusPrevious)

---

### Panel:GetAlpha · Client, Menu
`Panel:GetAlpha() → number`

Returns the alpha multiplier for this panel.

**Returns:**
- number — alphaMul

[wiki](https://wiki.facepunch.com/gmod/Panel:GetAlpha)

---

### Panel:GetBGColor · Client, Menu
`Panel:GetBGColor() → Color`

Returns the background color of a panel such as a [RichText](https://wiki.facepunch.com/gmod/RichText), [Label](https://wiki.facepunch.com/gmod/Label) or [DColorCube](https://wiki.facepunch.com/gmod/DColorCube).

**Returns:**
- `color` (Color) — The Color.

> **Note:** This doesn't apply to all VGUI elements and its function varies between them

[wiki](https://wiki.facepunch.com/gmod/Panel:GetBGColor)

---

### Panel:GetBounds · Client, Menu
`Panel:GetBounds() → number, number, number, number`

Returns the position and size of the panel.

This is equivalent to calling [Panel:GetPos](https://wiki.facepunch.com/gmod/Panel:GetPos) and [Panel:GetSize](https://wiki.facepunch.com/gmod/Panel:GetSize) together.

**Returns:**
- number — The x coordinate of the panel, relative to its parent's top left.
- number — The y coordinate of the panel, relative to its parent's top left.
- number — The width of the panel.
- number — The height of the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetBounds)

---

### Panel:GetCaretPos · Client, Menu
`Panel:GetCaretPos() → number`

Returns the position/offset of the caret (or text cursor) in a text-based panel object.

**Returns:**
- number — The caret position/offset from the start of the text.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetCaretPos)

---

### Panel:GetChild · Client, Menu
`Panel:GetChild(childIndex: number)`

Gets a child by its index. For use with [Panel:ChildCount](https://wiki.facepunch.com/gmod/Panel:ChildCount).

**Arguments:**
- `childIndex` (number) — The index of the child to get.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetChild)

---

### Panel:GetChildPosition · Client, Menu
`Panel:GetChildPosition(pnl: Panel) → number, number`

Gets a child object's position relative to this panel object. The number of levels is not relevant; the child may have many parents between itself and the object on which the method is called.

**Arguments:**
- `pnl` (Panel) — The panel to get the position of.

**Returns:**
- number — The horizontal (x) position of the child relative to this panel object.
- number — The vertical (y) position of the child relative to this panel object.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetChildPosition) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L442-L458)

---

### Panel:GetChildren · Client, Menu
`Panel:GetChildren() → table`

Returns a table with all the child panels of the panel.

**Returns:**
- table — All direct children of this panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetChildren)

---

### Panel:GetChildrenInRect · Client, Menu
`Panel:GetChildrenInRect(x: number, y: number, w: number, h: number) → table`

Returns a table of all visible, selectable children of the panel object that lie at least partially within the specified rectangle.

**Arguments:**
- `x` (number) — The horizontal (x) position of the top-left corner of the rectangle, relative to the panel object.
- `y` (number) — The vertical (y) position of the top-left corner of the rectangle, relative to the panel object.
- `w` (number) — The width of the rectangle.
- `h` (number) — The height of the rectangle.

**Returns:**
- table — A table of panel objects that lie at least partially within the specified rectangle.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetChildrenInRect) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L162-L187)

---

### Panel:GetClassName · Client, Menu
`Panel:GetClassName() → string`

Returns the class name of the panel. This would be the class name of the base engine-level panel, not Lua classname. The latter is stored usually in [Panel:GetName](https://wiki.facepunch.com/gmod/Panel:GetName).

**Returns:**
- string — The panel's class name.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetClassName)

---

### Panel:GetClosestChild · Client, Menu
`Panel:GetClosestChild(x: number, y: number) → Panel, number`

Returns the child of this panel object that is closest to the specified point. The point is relative to the object on which the method is called. The distance the child is from this point is also returned.

**Arguments:**
- `x` (number) — The horizontal (x) position of the point.
- `y` (number) — The vertical (y) position of the point.

**Returns:**
- Panel — The child object that was closest to the specified point.
- number — The distance that this child was from the point.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetClosestChild) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L523-L538)

---

### Panel:GetContentAlignment · Client, Menu
`Panel:GetContentAlignment() → number`

Returns the alignment of the text of a [Label](https://wiki.facepunch.com/gmod/Label).

**Returns:**
- `alignment` (number) — The direction of the content, based on the number pad.

> **Note:** This function only works on [Label](https://wiki.facepunch.com/gmod/Label) panels and its derivatives.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetContentAlignment)

---

### Panel:GetContentSize · Client, Menu
`Panel:GetContentSize() → number, number`

Gets the size of the content/children within a panel object.

Only works with [Label](https://wiki.facepunch.com/gmod/Label) derived panels by default such as [DLabel](https://wiki.facepunch.com/gmod/DLabel).


Will also work on any panel that manually implements this method.

**Returns:**
- number — The content width of the object.
- number — The content height of the object.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetContentSize)

---

### Panel:GetCookie · Client, Menu
`Panel:GetCookie(cookieName: string, default: string) → string`

Gets the value of a cookie stored by the panel object. This can also be done with [cookie.GetString](https://wiki.facepunch.com/gmod/cookie.GetString), using the panel's cookie name, a fullstop, and then the actual name of the cookie.

Make sure the panel's cookie name has not changed since writing, or the cookie will not be accessible. This can be done with [Panel:GetCookieName](https://wiki.facepunch.com/gmod/Panel:GetCookieName) and [Panel:SetCookieName](https://wiki.facepunch.com/gmod/Panel:SetCookieName).

**Arguments:**
- `cookieName` (string) — The name of the cookie from which to retrieve the value.
- `default` (string) — The default value to return if the cookie does not exist.

**Returns:**
- string — The value of the stored cookie, or the default value should the cookie not exist.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetCookie) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L214-L221)

---

### Panel:GetCookieName · Client, Menu
`Panel:GetCookieName() → string`

Gets the name the panel uses to store cookies. This is set with [Panel:SetCookieName](https://wiki.facepunch.com/gmod/Panel:SetCookieName).

**Returns:**
- string — The name the panel uses when reading or writing cookies.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetCookieName)

---

### Panel:GetCookieNumber · Client, Menu
`Panel:GetCookieNumber(cookieName: string, default: number) → number`

Gets the value of a cookie stored by the panel object, as a number. This can also be done with [cookie.GetNumber](https://wiki.facepunch.com/gmod/cookie.GetNumber), using the panel's cookie name, a fullstop, and then the actual name of the cookie.

Make sure the panel's cookie name has not changed since writing, or the cookie will not be accessible. This can be done with [Panel:GetCookieName](https://wiki.facepunch.com/gmod/Panel:GetCookieName) and [Panel:SetCookieName](https://wiki.facepunch.com/gmod/Panel:SetCookieName).

**Arguments:**
- `cookieName` (string) — The name of the cookie from which to retrieve the value.
- `default` (number) — The default value to return if the cookie does not exist.

**Returns:**
- number — The number value of the stored cookie, or the default value should the cookie not exist.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetCookieNumber) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L202-L209)

---

### Panel:GetDock · Client, Menu
`Panel:GetDock() → number`

Returns a dock enum for the panel's current docking type.

**Returns:**
- number — The dock enum for the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetDock)

---

### Panel:GetDockMargin · Client, Menu
`Panel:GetDockMargin() → number, number, number, number`

Returns the docked margins of the panel. (set by [Panel:DockMargin](https://wiki.facepunch.com/gmod/Panel:DockMargin))

**Returns:**
- number — Left margin.
- number — Top margin.
- number — Right margin.
- number — Bottom margin.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetDockMargin)

---

### Panel:GetDockPadding · Client, Menu
`Panel:GetDockPadding() → number, number, number, number`

Returns the docked padding of the panel. (set by [Panel:DockPadding](https://wiki.facepunch.com/gmod/Panel:DockPadding))

**Returns:**
- number — Left padding.
- number — Top padding.
- number — Right padding.
- number — Bottom padding.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetDockPadding)

---

### Panel:GetFGColor · Client, Menu
`Panel:GetFGColor() → Color`

Returns the foreground color of the panel.

For a [Label](https://wiki.facepunch.com/gmod/Label) or [RichText](https://wiki.facepunch.com/gmod/RichText), this is the color of its text.

**Returns:**
- `color` (Color) — The Color.

> **Note:** This doesn't apply to all VGUI elements (such as [DLabel](https://wiki.facepunch.com/gmod/DLabel)) and its function varies between them

[wiki](https://wiki.facepunch.com/gmod/Panel:GetFGColor)

---

### Panel:GetFont · Client, Menu
`Panel:GetFont() → string`

Returns the name of the font that the panel renders its text with.

This is the same font name set with [Panel:SetFontInternal](https://wiki.facepunch.com/gmod/Panel:SetFontInternal).

**Returns:**
- string — The font name.

> **Note:** Only works on [Label](https://wiki.facepunch.com/gmod/Label) and [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) and their derived panels by default (such as [DLabel](https://wiki.facepunch.com/gmod/DLabel) and [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry)), and on any panel that manually implemented the [Panel:GetFont](https://wiki.facepunch.com/gmod/Panel:GetFont) method.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetFont)

---

### Panel:GetHTMLMaterial · Client
`Panel:GetHTMLMaterial() → IMaterial`

Returns the panel's HTML material. Only works with [Awesomium](https://wiki.facepunch.com/gmod/Awesomium), [HTML](https://wiki.facepunch.com/gmod/HTML) and [DHTML](https://wiki.facepunch.com/gmod/DHTML) panels that have been fully loaded.

**Returns:**
- IMaterial — The HTML material used by the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetHTMLMaterial)

---

### Panel:GetLineHeight · Client, Menu
`Panel:GetLineHeight() → number`

Returns the height of a single line of a [RichText](https://wiki.facepunch.com/gmod/RichText) panel.

**Returns:**
- number — The line height.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetLineHeight)

---

### Panel:GetMaximumCharCount · Client, Menu
`Panel:GetMaximumCharCount() → number`

Returns the current maximum character count.

This function will only work on [RichText](https://wiki.facepunch.com/gmod/RichText) and [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) panels and their derivatives.

**Returns:**
- `maxChar` (number) — The maximum amount of characters this panel is allowed to contain.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetMaximumCharCount)

---

### Panel:GetName · Client, Menu
`Panel:GetName() → string`

Returns the internal name of the panel. Can be set via [Panel:SetName](https://wiki.facepunch.com/gmod/Panel:SetName).

**Returns:**
- string — The previously set internal name of the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetName)

---

### Panel:GetNumLines · Client, Menu
`Panel:GetNumLines() → number`

Returns the number of lines in a [RichText](https://wiki.facepunch.com/gmod/RichText) or a [TextEntry](https://wiki.facepunch.com/gmod/TextEntry).

You must wait a couple frames before calling this after using [Panel:AppendText](https://wiki.facepunch.com/gmod/Panel:AppendText) or [Panel:SetText](https://wiki.facepunch.com/gmod/Panel:SetText), otherwise it will return the number of text lines before the text change.

**Returns:**
- number — The number of lines.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetNumLines)

---

### Panel:GetParent · Client, Menu
`Panel:GetParent() → Panel`

Returns the parent of the panel, returns nil if there is no parent.

**Returns:**
- Panel — The parent of given panel

[wiki](https://wiki.facepunch.com/gmod/Panel:GetParent)

---

### Panel:GetPos · Client, Menu
`Panel:GetPos() → number, number`

Returns the position of the panel relative to its [Panel:GetParent](https://wiki.facepunch.com/gmod/Panel:GetParent).

If you require the panel's position **and** size, consider using [Panel:GetBounds](https://wiki.facepunch.com/gmod/Panel:GetBounds) instead.

If you need the position in screen space, see [Panel:LocalToScreen](https://wiki.facepunch.com/gmod/Panel:LocalToScreen).

See also [Panel:GetX](https://wiki.facepunch.com/gmod/Panel:GetX) and [Panel:GetY](https://wiki.facepunch.com/gmod/Panel:GetY).

**Returns:**
- number — X coordinate, relative to this panels parents top left corner.
- number — Y coordinate, relative to this panels parents top left corner.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetPos)

---

### Panel:GetScrollStartIndexes · Client, Menu
`Panel:GetScrollStartIndexes() → number, number`

Returns the vertical and horizontal start indexes of a [TextEntry](https://wiki.facepunch.com/gmod/TextEntry)'s visible text. This is useful when the panel is scrolled.

**Returns:**
- `horizontalIndex` (number) — The horizontal start index.
- `verticalIndex` (number) — The vertical start index.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetScrollStartIndexes)

---

### Panel:GetSelectedChildren · Client, Menu
`Panel:GetSelectedChildren() → table`

Returns a table of all children of the panel object that are selected. This is recursive, and the returned table will include tables for any child objects that also have children. This means that not all first-level members in the returned table will be of type [Panel](https://wiki.facepunch.com/gmod/Panel).

**Returns:**
- table — A table of any child objects that are selected, including tables for children of the child objects (These tables may also contain table members, as the method is recursive).

[wiki](https://wiki.facepunch.com/gmod/Panel:GetSelectedChildren) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L189-L205)

---

### Panel:GetSelectedTextRange · Client, Menu
`Panel:GetSelectedTextRange() → number, number`

Returns the currently selected range of text.

This function will only work on [RichText](https://wiki.facepunch.com/gmod/RichText) and [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) panels and their derivatives.

**Returns:**
- `start` (number) — The start of the range.
- `endrange` (number) — The end of the range.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetSelectedTextRange)

---

### Panel:GetSelectionCanvas · Client, Menu
`Panel:GetSelectionCanvas() → Panel`

Returns the selection canvas for this panel. This will be the first parent that has [Panel:SetSelectionCanvas](https://wiki.facepunch.com/gmod/Panel:SetSelectionCanvas) set to true (or `self` if this panel is the selection canvas)

A selection canvas would be the panel that contains a bunch of selectable panels ([Panel:SetSelectable](https://wiki.facepunch.com/gmod/Panel:SetSelectable)), usually for the drag'n'drop system. Calling this function on any of the selectable items, or any of their children, will return the first parent that can contain selectable panels.

**Returns:**
- Panel — The selection canvas, otherwise `nil`.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetSelectionCanvas) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L116-L131)

---

### Panel:GetSize · Client, Menu
`Panel:GetSize() → number, number`

Returns the size of the panel.

If you require both the panel's position and size, consider using [Panel:GetBounds](https://wiki.facepunch.com/gmod/Panel:GetBounds) instead.

**Returns:**
- number — The panel's width.
- number — The panel's height (Panel:GetTall)

[wiki](https://wiki.facepunch.com/gmod/Panel:GetSize)

---

### Panel:GetSkin · Client, Menu
`Panel:GetSkin() → table`

Returns the table for the derma skin currently being used by this panel object.

**Returns:**
- table — The derma skin table currently being used by this object.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetSkin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L378-L413)

---

### Panel:GetTable · Client, Menu
`Panel:GetTable() → table`

Returns the internal Lua table of the panel.

**Returns:**
- table — A table containing all the members of given panel object.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetTable)

---

### Panel:GetTall · Client, Menu
`Panel:GetTall() → number`

Returns the height of the panel.

See [Panel:GetWide](https://wiki.facepunch.com/gmod/Panel:GetWide) for the width of the panel. See also [Panel:GetSize](https://wiki.facepunch.com/gmod/Panel:GetSize) for a function that returns both.

**Returns:**
- number — height

[wiki](https://wiki.facepunch.com/gmod/Panel:GetTall)

---

### Panel:GetText · Client, Menu
`Panel:GetText() → string`

Returns the panel's text (where applicable).

This method returns a maximum of 1023 bytes, except for [TextEntry](https://wiki.facepunch.com/gmod/TextEntry).

**Returns:**
- string — The panel's text.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetText)

---

### Panel:GetTextInset · Client, Menu
`Panel:GetTextInset() → number, number`

Gets the left and top text margins of a text-based panel object, such as a [DButton](https://wiki.facepunch.com/gmod/DButton) or [DLabel](https://wiki.facepunch.com/gmod/DLabel). This is set with [Panel:SetTextInset](https://wiki.facepunch.com/gmod/Panel:SetTextInset).

**Returns:**
- number — The left margin of the text, in pixels.
- number — The top margin of the text, in pixels.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetTextInset)

---

### Panel:GetTextSize · Client, Menu
`Panel:GetTextSize() → number, number`

Gets the size of the text within a [Label](https://wiki.facepunch.com/gmod/Label) derived panel.

**Returns:**
- number — The width of the text in the DLabel.
- number — The height of the text in the DLabel.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetTextSize)

---

### Panel:GetTooltip · Client, Menu
`Panel:GetTooltip() → string`

Returns the tooltip text that was set with [PANEL:SetTooltip](https://wiki.facepunch.com/gmod/PANEL:SetTooltip).

**Returns:**
- `tooltip` (string) — The tooltip text, if it was set.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetTooltip) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L277-L282)

---

### Panel:GetTooltipDelay · Client, Menu
`Panel:GetTooltipDelay() → number`

Returns the tooltip delay (time between hovering over the panel, and the tooltip showing up) that was set with [Panel:SetTooltipDelay](https://wiki.facepunch.com/gmod/Panel:SetTooltipDelay), or nothing if it was not set.

If the delay is not explicitly set by this function, it will fallback to the value of the `tooltip_delay` [ConVar](https://wiki.facepunch.com/gmod/ConVar), which is `0.5` by default.

**Returns:**
- `tooltip` (number) — The tooltip delay in seconds, if it was set.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetTooltipDelay) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L294-L296)

---

### Panel:GetTooltipPanel · Client, Menu
`Panel:GetTooltipPanel() → Panel`

Returns the tooltip panel that was set with [PANEL:SetTooltipPanel](https://wiki.facepunch.com/gmod/PANEL:SetTooltipPanel).

**Returns:**
- `tooltip` (Panel) — The tooltip panel, if it was set.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetTooltipPanel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L287-L289)

---

### Panel:GetValidReceiverSlot · Client, Menu
`Panel:GetValidReceiverSlot() → Panel, table`

Gets valid receiver slot of currently dragged panel.

**Returns:**
- Panel — The panel this was called on if a valid receiver slot exists, otherwise false.
- table — The slot table.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetValidReceiverSlot) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L335-L359)

---

### Panel:GetValue · Client, Menu
`Panel:GetValue() → any`

Returns the value the panel holds.

In engine is only implemented for [CheckButton](https://wiki.facepunch.com/gmod/CheckButton), [Label](https://wiki.facepunch.com/gmod/Label) and [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) as a string.

**Returns:**
- any — The value the panel holds.

> **Note:** This function is limited to 8092 Bytes. If using [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry), use [Panel:GetText](https://wiki.facepunch.com/gmod/Panel:GetText) for unlimited bytes.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetValue)

---

### Panel:GetWide · Client, Menu
`Panel:GetWide() → number`

Returns the width of the panel.

See [Panel:GetTall](https://wiki.facepunch.com/gmod/Panel:GetTall) for the height of the panel. See also [Panel:GetSize](https://wiki.facepunch.com/gmod/Panel:GetSize) for a function that returns both.

**Returns:**
- number — width

[wiki](https://wiki.facepunch.com/gmod/Panel:GetWide)

---

### Panel:GetX · Client, Menu
`Panel:GetX() → number`

Returns the X position of the panel relative to its [Panel:GetParent](https://wiki.facepunch.com/gmod/Panel:GetParent).

Uses [Panel:GetPos](https://wiki.facepunch.com/gmod/Panel:GetPos) internally.

**Returns:**
- number — X coordinate.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetX) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L62-L65)

---

### Panel:GetY · Client, Menu
`Panel:GetY() → number`

Returns the Y position of the panel relative to its [Panel:GetParent](https://wiki.facepunch.com/gmod/Panel:GetParent).

Uses [Panel:GetPos](https://wiki.facepunch.com/gmod/Panel:GetPos) internally.

**Returns:**
- number — Y coordinate.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetY) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L66-L69)

---

### Panel:GetZPos · Client, Menu
`Panel:GetZPos() → number`

Returns the Z position of the panel.

**Returns:**
- number — The Z order position of the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:GetZPos)

---

### Panel:GoBack · Client, Menu
`Panel:GoBack()`

Goes back one page in the HTML panel's history if available.

[wiki](https://wiki.facepunch.com/gmod/Panel:GoBack)

---

### Panel:GoForward · Client, Menu
`Panel:GoForward()`

Goes forward one page in the HTML panel's history if available.

[wiki](https://wiki.facepunch.com/gmod/Panel:GoForward)

---

### Panel:GoToHistoryOffset · Client, Menu
`Panel:GoToHistoryOffset(offset: number)`

Goes to the page in the HTML panel's history at the specified relative offset.

**Arguments:**
- `offset` (number) — The offset in the panel's back/forward history, relative to the current page, that you would like to skip to.

[wiki](https://wiki.facepunch.com/gmod/Panel:GoToHistoryOffset)

---

### Panel:GotoTextEnd · Client, Menu
`Panel:GotoTextEnd()`

Causes a [RichText](https://wiki.facepunch.com/gmod/RichText) element to scroll to the bottom of its text.

[wiki](https://wiki.facepunch.com/gmod/Panel:GotoTextEnd)

---

### Panel:GotoTextStart · Client, Menu
`Panel:GotoTextStart()`

Causes a [RichText](https://wiki.facepunch.com/gmod/RichText) element to scroll to the top of its text.

[wiki](https://wiki.facepunch.com/gmod/Panel:GotoTextStart)

---

### Panel:GWEN_SetCheckboxText · Client, Menu · `INTERNAL`
`Panel:GWEN_SetCheckboxText(txt: string)`

Used by [Panel:ApplyGWEN](https://wiki.facepunch.com/gmod/Panel:ApplyGWEN) to apply the `CheckboxText` property to a [DCheckBoxLabel](https://wiki.facepunch.com/gmod/DCheckBoxLabel). This does exactly the same as [Panel:GWEN_SetText](https://wiki.facepunch.com/gmod/Panel:GWEN_SetText), but exists to cater for the seperate GWEN properties.

**Arguments:**
- `txt` (string) — The text to be applied to the DCheckBoxLabel.

[wiki](https://wiki.facepunch.com/gmod/Panel:GWEN_SetCheckboxText) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L222)

---

### Panel:GWEN_SetControlName · Client, Menu · `INTERNAL`
`Panel:GWEN_SetControlName(name: string)`

Used by [Panel:ApplyGWEN](https://wiki.facepunch.com/gmod/Panel:ApplyGWEN) to apply the `ControlName` property to a panel. This calls [Panel:SetName](https://wiki.facepunch.com/gmod/Panel:SetName).

**Arguments:**
- `name` (string) — The new name to apply to the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:GWEN_SetControlName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L204)

---

### Panel:GWEN_SetDock · Client, Menu · `INTERNAL`
`Panel:GWEN_SetDock(dockState: string)`

Used by [Panel:ApplyGWEN](https://wiki.facepunch.com/gmod/Panel:ApplyGWEN) to apply the `Dock` property to a  panel object. This calls [Panel:Dock](https://wiki.facepunch.com/gmod/Panel:Dock).

**Arguments:**
- `dockState` (string) — The dock mode to pass to the panel's `Dock` method.

[wiki](https://wiki.facepunch.com/gmod/Panel:GWEN_SetDock) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L214-L220)

---

### Panel:GWEN_SetHorizontalAlign · Client, Menu · `INTERNAL`
`Panel:GWEN_SetHorizontalAlign(hAlign: string)`

Used by [Panel:ApplyGWEN](https://wiki.facepunch.com/gmod/Panel:ApplyGWEN) to apply the `HorizontalAlign` property to a  panel object. This calls [Panel:SetContentAlignment](https://wiki.facepunch.com/gmod/Panel:SetContentAlignment).

**Arguments:**
- `hAlign` (string) — The alignment, as a string, to pass to Panel:SetContentAlignment.

[wiki](https://wiki.facepunch.com/gmod/Panel:GWEN_SetHorizontalAlign) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L208-L212)

---

### Panel:GWEN_SetMargin · Client, Menu · `INTERNAL`
`Panel:GWEN_SetMargin(margins: table)`

Used by [Panel:ApplyGWEN](https://wiki.facepunch.com/gmod/Panel:ApplyGWEN) to apply the `Margin` property to a  panel object. This calls [Panel:DockMargin](https://wiki.facepunch.com/gmod/Panel:DockMargin).

**Arguments:**
- `margins` (table) — A four-membered table containing the margins as numbers: * number left - The left margin.

[wiki](https://wiki.facepunch.com/gmod/Panel:GWEN_SetMargin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L205)

---

### Panel:GWEN_SetMax · Client, Menu · `INTERNAL`
`Panel:GWEN_SetMax(maxValue: number)`

Used by [Panel:ApplyGWEN](https://wiki.facepunch.com/gmod/Panel:ApplyGWEN) to apply the `Max` property to a  [DNumberWang](https://wiki.facepunch.com/gmod/DNumberWang), [Slider](https://wiki.facepunch.com/gmod/Slider), [DNumSlider](https://wiki.facepunch.com/gmod/DNumSlider) or [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch). This calls `SetMax` on one of the previously listed methods.

**Arguments:**
- `maxValue` (number) — The maximum value the element is to permit.

[wiki](https://wiki.facepunch.com/gmod/Panel:GWEN_SetMax) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L207)

---

### Panel:GWEN_SetMin · Client, Menu · `INTERNAL`
`Panel:GWEN_SetMin(minValue: number)`

Used by [Panel:ApplyGWEN](https://wiki.facepunch.com/gmod/Panel:ApplyGWEN) to apply the `Min` property to a  [DNumberWang](https://wiki.facepunch.com/gmod/DNumberWang), [Slider](https://wiki.facepunch.com/gmod/Slider), [DNumSlider](https://wiki.facepunch.com/gmod/DNumSlider) or [DNumberScratch](https://wiki.facepunch.com/gmod/DNumberScratch). This calls `SetMin` on one of the previously listed methods.

**Arguments:**
- `minValue` (number) — The minimum value the element is to permit.

[wiki](https://wiki.facepunch.com/gmod/Panel:GWEN_SetMin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L206)

---

### Panel:GWEN_SetPosition · Client, Menu · `INTERNAL`
`Panel:GWEN_SetPosition(pos: table)`

Used by [Panel:ApplyGWEN](https://wiki.facepunch.com/gmod/Panel:ApplyGWEN) to apply the `Position` property to a  panel object. This calls [Panel:SetPos](https://wiki.facepunch.com/gmod/Panel:SetPos).

**Arguments:**
- `pos` (table) — A two-membered table containing the x and y coordinates as numbers: * number x - The x coordinate.

[wiki](https://wiki.facepunch.com/gmod/Panel:GWEN_SetPosition) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L201)

---

### Panel:GWEN_SetSize · Client, Menu · `INTERNAL`
`Panel:GWEN_SetSize(size: table)`

Used by [Panel:ApplyGWEN](https://wiki.facepunch.com/gmod/Panel:ApplyGWEN) to apply the `Size` property to a  panel object. This calls [Panel:SetSize](https://wiki.facepunch.com/gmod/Panel:SetSize).

**Arguments:**
- `size` (table) — A two-membered table containing the width and heights as numbers: * number w - The width.

[wiki](https://wiki.facepunch.com/gmod/Panel:GWEN_SetSize) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L202)

---

### Panel:GWEN_SetText · Client, Menu · `INTERNAL`
`Panel:GWEN_SetText(txt: string)`

Used by [Panel:ApplyGWEN](https://wiki.facepunch.com/gmod/Panel:ApplyGWEN) to apply the `Text` property to a panel.

**Arguments:**
- `txt` (string) — The text to be applied to the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:GWEN_SetText) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L203)

---

### Panel:HasChildren · Client, Menu
`Panel:HasChildren() → boolean`

Returns whenever the panel has child panels.

**Returns:**
- boolean — hasChilds

[wiki](https://wiki.facepunch.com/gmod/Panel:HasChildren)

---

### Panel:HasFocus · Client, Menu
`Panel:HasFocus() → boolean`

Returns if the panel is focused.

**Returns:**
- boolean — hasFocus

[wiki](https://wiki.facepunch.com/gmod/Panel:HasFocus)

---

### Panel:HasHierarchicalFocus · Client, Menu
`Panel:HasHierarchicalFocus() → boolean`

Returns if the panel or any of its children(sub children and so on) has the focus.

**Returns:**
- boolean — hasHierarchicalFocus

[wiki](https://wiki.facepunch.com/gmod/Panel:HasHierarchicalFocus)

---

### Panel:HasParent · Client, Menu
`Panel:HasParent(parentPanel: Panel) → boolean`

Returns whether the panel is a descendent of the given panel.

**Arguments:**
- `parentPanel` (Panel)

**Returns:**
- boolean — True if the panel is contained within parentPanel.

[wiki](https://wiki.facepunch.com/gmod/Panel:HasParent)

---

### Panel:Hide · Client, Menu
`Panel:Hide()`

Makes a panel invisible.

[wiki](https://wiki.facepunch.com/gmod/Panel:Hide) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L606-L608)

---

### Panel:InsertClickableTextEnd · Client, Menu
`Panel:InsertClickableTextEnd()`

Marks the end of a clickable text segment in a [RichText](https://wiki.facepunch.com/gmod/RichText) element, started with [Panel:InsertClickableTextStart](https://wiki.facepunch.com/gmod/Panel:InsertClickableTextStart).

[wiki](https://wiki.facepunch.com/gmod/Panel:InsertClickableTextEnd)

---

### Panel:InsertClickableTextStart · Client, Menu
`Panel:InsertClickableTextStart(signalValue: string)`

Starts the insertion of clickable text for a [RichText](https://wiki.facepunch.com/gmod/RichText) element. Any text appended with [Panel:AppendText](https://wiki.facepunch.com/gmod/Panel:AppendText) between this call and [Panel:InsertClickableTextEnd](https://wiki.facepunch.com/gmod/Panel:InsertClickableTextEnd) will become clickable text.

The hook [PANEL:OnTextClicked](https://wiki.facepunch.com/gmod/PANEL:OnTextClicked) is called when the text is clicked.

**Arguments:**
- `signalValue` (string) — The text passed as the action signal's value.

> **Note:** The clickable text is a separate Derma panel which will not inherit the current font from the `RichText`.

[wiki](https://wiki.facepunch.com/gmod/Panel:InsertClickableTextStart)

---

### Panel:InsertColorChange · Client, Menu
`Panel:InsertColorChange(r: number, g: number, b: number, a: number)`

Inserts a color change in a [RichText](https://wiki.facepunch.com/gmod/RichText) element, which affects the color of all text added with [Panel:AppendText](https://wiki.facepunch.com/gmod/Panel:AppendText) until another color change is applied.

**Arguments:**
- `r` (number) — The red value `(0 - 255)`.
- `g` (number) — The green value `(0 - 255)`.
- `b` (number) — The blue value `(0 - 255)`.
- `a` (number) — The alpha value `(0 - 255)`.

[wiki](https://wiki.facepunch.com/gmod/Panel:InsertColorChange)

---

### Panel:InsertFade · Client, Menu
`Panel:InsertFade(sustain: number, length: number)`

Begins a text fade for a [RichText](https://wiki.facepunch.com/gmod/RichText) element where the last appended text segment is fully faded out after a specific amount of time, at a specific speed.

The alpha of the text at any given time is determined by the text's base alpha * ((`sustain` - [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime)) / `length`) where [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime) is added to `sustain` when this method is called.

**Arguments:**
- `sustain` (number) — The number of seconds the text remains visible.
- `length` (number) — The number of seconds it takes the text to fade out.

[wiki](https://wiki.facepunch.com/gmod/Panel:InsertFade)

---

### Panel:InvalidateChildren · Client, Menu
`Panel:InvalidateChildren(recursive: boolean = false)`

Invalidates the layout of this panel object and all its children. This will cause these objects to re-layout immediately, calling [PANEL:PerformLayout](https://wiki.facepunch.com/gmod/PANEL:PerformLayout). If you want to perform the layout in the next frame, you will have loop manually through all children, and call [Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout) on each.

**Arguments:**
- `recursive` (boolean, default `false`) — If `true`, the method will recursively invalidate the layout of all children.

[wiki](https://wiki.facepunch.com/gmod/Panel:InvalidateChildren) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L473-L487)

---

### Panel:InvalidateLayout · Client, Menu
`Panel:InvalidateLayout(layoutNow: boolean = false)`

Causes the panel to re-layout in the next frame. During the layout process  [PANEL:PerformLayout](https://wiki.facepunch.com/gmod/PANEL:PerformLayout) will be called on the target panel.

You should avoid calling this function every frame.

**Arguments:**
- `layoutNow` (boolean, default `false`) — If true the panel will re-layout instantly and not wait for the next frame.

> **Bug** ([#2574](https://github.com/Facepunch/garrysmod/issues/2574)): Using this on a panel after clicking on a docked element will cause docked elements to reorient themselves incorrectly. This can be fixed by assigning a unique [Panel:SetZPos](https://wiki.facepunch.com/gmod/Panel:SetZPos) to each docked element.

[wiki](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout)

---

### Panel:InvalidateParent · Client, Menu
`Panel:InvalidateParent(layoutNow: boolean = false)`

Calls [Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout) on the panel's [parent](https://wiki.facepunch.com/gmod/Panel:GetParent). This function will silently fail if the panel has no parent.

This will cause the parent panel to re-layout, calling [PANEL:PerformLayout](https://wiki.facepunch.com/gmod/PANEL:PerformLayout).

Internally sets `LayingOutParent` to `true` on this panel, and will silently fail if it is already set.

**Arguments:**
- `layoutNow` (boolean, default `false`) — If `true`, the re-layout will occur immediately, otherwise it will be performed in the next frame.

[wiki](https://wiki.facepunch.com/gmod/Panel:InvalidateParent) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L250-L260)

---

### Panel:IsChildHovered · Client, Menu
`Panel:IsChildHovered(immediate: boolean = false) → boolean`

Determines whether the mouse cursor is hovered over one of this panel object's children. This is a reverse process using [vgui.GetHoveredPanel](https://wiki.facepunch.com/gmod/vgui.GetHoveredPanel), and looks upward to find the parent.

**Arguments:**
- `immediate` (boolean, default `false`) — Set to true to check only the immediate children of given panel ( first level )

**Returns:**
- boolean — Whether or not one of this panel object's children is being hovered over.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsChildHovered) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L610-L621)

---

### Panel:IsDraggable · Client, Menu
`Panel:IsDraggable() → boolean`

Returns whether this panel is draggable ( if user is able to drag it ) or not.

**Returns:**
- boolean — Whether this panel is draggable ( if user is able to drag it ) or not.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsDraggable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L361-L365)

---

### Panel:IsDragging · Client, Menu
`Panel:IsDragging() → boolean`

Returns whether this panel is currently being dragged or not.

**Returns:**
- boolean — Whether this panel is currently being dragged or not.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsDragging) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L367-L373)

---

### Panel:IsEnabled · Client, Menu
`Panel:IsEnabled() → boolean`

Returns whether the the panel is enabled or disabled.

See [Panel:SetEnabled](https://wiki.facepunch.com/gmod/Panel:SetEnabled) for a function that makes the panel enabled or disabled.

**Returns:**
- boolean — Whether the panel is enabled or disabled.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsEnabled)

---

### Panel:IsHovered · Client, Menu
`Panel:IsHovered() → boolean`

Returns whether the mouse cursor is hovering over this panel or not

Uses [vgui.GetHoveredPanel](https://wiki.facepunch.com/gmod/vgui.GetHoveredPanel) internally.

Requires [Panel:SetMouseInputEnabled](https://wiki.facepunch.com/gmod/Panel:SetMouseInputEnabled) to be set to true.

**Returns:**
- boolean — true if the panel is hovered

[wiki](https://wiki.facepunch.com/gmod/Panel:IsHovered) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L598-L600)

---

### Panel:IsKeyboardInputEnabled · Client, Menu
`Panel:IsKeyboardInputEnabled() → boolean`

Returns true if the panel can receive keyboard input.

**Returns:**
- boolean — keyboardInputEnabled

[wiki](https://wiki.facepunch.com/gmod/Panel:IsKeyboardInputEnabled)

---

### Panel:IsLoading · Client, Menu
`Panel:IsLoading() → boolean`

Determines whether or not a [HTML](https://wiki.facepunch.com/gmod/HTML) or [DHTML](https://wiki.facepunch.com/gmod/DHTML) element is currently loading a page.

**Returns:**
- boolean — Whether or not the (D)HTML object is loading.

> **Note:** Before calling [Panel:SetHTML](https://wiki.facepunch.com/gmod/Panel:SetHTML) or [DHTML:OpenURL](https://wiki.facepunch.com/gmod/DHTML:OpenURL), the result seems to be `false` with the Awesomium web renderer and `true` for the Chromium web renderer. This difference can be used to determine the available HTML5 capabilities.
> **Note:** On Awesomium, the result remains `true` until the root document is loaded and when in-page content is loading (when adding pictures, frames, etc.). During this state, the HTML texture is not refreshed and the panel is not painted (it becomes invisible).
> 
> On Chromium, the value is only `true` when the root document is not ready. The rendering is not suspended when in-page elements are loading.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsLoading)

---

### Panel:IsMarkedForDeletion · Client, Menu
`Panel:IsMarkedForDeletion() → boolean`

Returns if the panel is going to be deleted in the next frame.

**Returns:**
- boolean — markedForDeletion

[wiki](https://wiki.facepunch.com/gmod/Panel:IsMarkedForDeletion)

---

### Panel:IsModal · Client, Menu
`Panel:IsModal() → boolean`

Returns whether the panel was made modal or not. See [Panel:DoModal](https://wiki.facepunch.com/gmod/Panel:DoModal).

**Returns:**
- boolean — True if the panel is modal.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsModal)

---

### Panel:IsMouseInputEnabled · Client, Menu
`Panel:IsMouseInputEnabled() → boolean`

Returns true if the panel can receive mouse input.

**Returns:**
- boolean — mouseInputEnabled

[wiki](https://wiki.facepunch.com/gmod/Panel:IsMouseInputEnabled)

---

### Panel:IsMultiline · Client, Menu
`Panel:IsMultiline() → boolean`

Determines whether or not a [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) panel is in multi-line mode. This is set with [Panel:SetMultiline](https://wiki.facepunch.com/gmod/Panel:SetMultiline).

**Returns:**
- boolean — Whether the object is in multi-line mode or not.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsMultiline)

---

### Panel:IsOurChild · Client, Menu
`Panel:IsOurChild(childPanel: Panel) → boolean`

Returns whether the panel contains the given panel, recursively.

**Arguments:**
- `childPanel` (Panel)

**Returns:**
- boolean — True if the panel contains childPanel.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsOurChild) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L489-L495)

---

### Panel:IsPopup · Client, Menu
`Panel:IsPopup() → boolean`

Returns if the panel was made popup or not. See [Panel:MakePopup](https://wiki.facepunch.com/gmod/Panel:MakePopup)

**Returns:**
- boolean — `true` if the panel was made popup.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsPopup)

---

### Panel:IsSelectable · Client, Menu
`Panel:IsSelectable() → boolean`

Determines if the panel object is selectable (like icons in the Spawn Menu, holding ). This is set with [Panel:SetSelectable](https://wiki.facepunch.com/gmod/Panel:SetSelectable).

**Returns:**
- boolean — Whether the panel is selectable or not.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsSelectable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L66-L70)

---

### Panel:IsSelected · Client, Menu
`Panel:IsSelected() → boolean`

Returns if the panel object is selected (like icons in the Spawn Menu, holding ). This can be set in Lua using [Panel:SetSelected](https://wiki.facepunch.com/gmod/Panel:SetSelected).

**Returns:**
- boolean — Whether the panel object is selected or not.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsSelected) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L59-L64)

---

### Panel:IsSelectionCanvas · Client, Menu
`Panel:IsSelectionCanvas() → any`

Determines if the panel object is a selection canvas or not. This is set with [Panel:SetSelectionCanvas](https://wiki.facepunch.com/gmod/Panel:SetSelectionCanvas).

**Returns:**
- any — The value (if any) set by Panel:SetSelectionCanvas.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsSelectionCanvas) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L17-L21)

---

### Panel:IsValid · Client, Menu
`Panel:IsValid() → boolean`

Returns if the panel is valid and not marked for deletion.

**Returns:**
- boolean — True if the object is valid.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsValid)

---

### Panel:IsVisible · Client, Menu
`Panel:IsVisible() → boolean`

Returns if the panel is visible. This will **NOT** take into account visibility of the parent.

**Returns:**
- boolean — `true` if the panel ls visible, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsVisible)

---

### Panel:IsWorldClicker · Client, Menu
`Panel:IsWorldClicker() → boolean`

Returns if a panel allows world clicking set by [Panel:SetWorldClicker](https://wiki.facepunch.com/gmod/Panel:SetWorldClicker).

**Returns:**
- boolean — If the panel allows world clicking.

[wiki](https://wiki.facepunch.com/gmod/Panel:IsWorldClicker)

---

### Panel:KillFocus · Client, Menu
`Panel:KillFocus()`

Remove the focus from the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:KillFocus)

---

### Panel:LerpPositions · Client, Menu
`Panel:LerpPositions(speed: number, easeOut: boolean)`

Redefines the panel object's [Panel:SetPos](https://wiki.facepunch.com/gmod/Panel:SetPos) method to operate using frame-by-frame linear interpolation ([Lerp](https://wiki.facepunch.com/gmod/Global.Lerp)). When the panel's position is changed, it will move to the target position at the speed defined. You can undo this with [Panel:DisableLerp](https://wiki.facepunch.com/gmod/Panel:DisableLerp).

Unlike the other panel animation functions, such as [Panel:MoveTo](https://wiki.facepunch.com/gmod/Panel:MoveTo), this animation method will not operate whilst the game is paused. This is because it relies on [FrameTime](https://wiki.facepunch.com/gmod/Global.FrameTime).

**Arguments:**
- `speed` (number) — The speed at which to move the panel.
- `easeOut` (boolean) — This causes the panel object to 'jump' at the target, slowing as it approaches.

[wiki](https://wiki.facepunch.com/gmod/Panel:LerpPositions) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L338-L354)

---

### Panel:LoadControlsFromFile · Client, Menu · `DEPRECATED` · `INTERNAL`
`Panel:LoadControlsFromFile(path: string)`

Similar to [Panel:LoadControlsFromString](https://wiki.facepunch.com/gmod/Panel:LoadControlsFromString) but loads controls from a file.

**Arguments:**
- `path` (string) — The path to load the controls from.

[wiki](https://wiki.facepunch.com/gmod/Panel:LoadControlsFromFile)

---

### Panel:LoadControlsFromString · Client, Menu · `DEPRECATED` · `INTERNAL`
`Panel:LoadControlsFromString(data: string)`

Loads controls(positions, etc) from given data. This is what the default options menu uses.

**Arguments:**
- `data` (string) — The data to load controls from.

[wiki](https://wiki.facepunch.com/gmod/Panel:LoadControlsFromString)

---

### Panel:LoadGWENFile · Client, Menu
`Panel:LoadGWENFile(filename: string, path: string = GAME)`

Loads a .gwen file (created by GWEN Designer) and calls [Panel:LoadGWENString](https://wiki.facepunch.com/gmod/Panel:LoadGWENString) with the contents of the loaded file.

Used to load panel controls from a file.

**Arguments:**
- `filename` (string) — The file to open.
- `path` (string, default `GAME`) — The path used to look up the file.

[wiki](https://wiki.facepunch.com/gmod/Panel:LoadGWENFile) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L126-L133)

---

### Panel:LoadGWENString · Client, Menu
`Panel:LoadGWENString(str: string)`

Loads controls for the panel from a JSON string.

**Arguments:**
- `str` (string) — JSON string containing information about controls to create.

[wiki](https://wiki.facepunch.com/gmod/Panel:LoadGWENString) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_gwen.lua#L138-L146)

---

### Panel:LoadTGAImage · Client, Menu · `DEPRECATED`
`Panel:LoadTGAImage(imageName: string, strPath: string)`

Sets a new image to be loaded by a [TGAImage](https://wiki.facepunch.com/gmod/TGAImage).

**Arguments:**
- `imageName` (string) — The file path.
- `strPath` (string) — The PATH to search in.

[wiki](https://wiki.facepunch.com/gmod/Panel:LoadTGAImage)

---

### Panel:LocalCursorPos · Client, Menu
`Panel:LocalCursorPos() → number, number`

Returns the cursor position local to the position of the panel (usually the upper-left corner).

**Returns:**
- number — The x coordinate
- number — The y coordinate

[wiki](https://wiki.facepunch.com/gmod/Panel:LocalCursorPos) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L540-L542)

---

### Panel:LocalToScreen · Client, Menu
`Panel:LocalToScreen(posX: number, posY: number) → number, number`

Takes X and Y coordinates relative to the panel and returns their corresponding positions relative to the screen.

See also [Panel:ScreenToLocal](https://wiki.facepunch.com/gmod/Panel:ScreenToLocal).

**Arguments:**
- `posX` (number) — The X coordinate of the position on the panel to translate.
- `posY` (number) — The Y coordinate of the position on the panel to translate.

**Returns:**
- number — The X coordinate relative to the screen.
- number — The Y coordinate relative to the screen.

> **Note:** If the panel uses [Panel:Dock](https://wiki.facepunch.com/gmod/Panel:Dock), this function will return 0, 0 when the panel was created. The position will be updated in the next frame.
> **Warning:** This function uses a cached value for the screen position of the panel, computed at the end of the last VGUI Think/Layout pass, so inaccurate results may be returned if the panel or any of its ancestors have been re-positioned outside of [PANEL:Think](https://wiki.facepunch.com/gmod/PANEL:Think) or [PANEL:PerformLayout](https://wiki.facepunch.com/gmod/PANEL:PerformLayout) within the last frame.

[wiki](https://wiki.facepunch.com/gmod/Panel:LocalToScreen)

---

### Panel:MakePopup · Client, Menu
`Panel:MakePopup()`

Focuses the panel and enables it to receive input.

This automatically calls [Panel:SetMouseInputEnabled](https://wiki.facepunch.com/gmod/Panel:SetMouseInputEnabled) and [Panel:SetKeyboardInputEnabled](https://wiki.facepunch.com/gmod/Panel:SetKeyboardInputEnabled(lowercase)) and sets them to `true`.

> **Note:** Panels derived from [Panel](https://wiki.facepunch.com/gmod/Panel) will not work properly with this function. Due to this, any children will not be intractable with keyboard. Derive from [EditablePanel](https://wiki.facepunch.com/gmod/EditablePanel) instead.
> 
> For non gui related mouse focus, you can use [gui.EnableScreenClicker](https://wiki.facepunch.com/gmod/gui.EnableScreenClicker).

[wiki](https://wiki.facepunch.com/gmod/Panel:MakePopup)

---

### Panel:MouseCapture · Client, Menu
`Panel:MouseCapture(doCapture: boolean)`

Allows the panel to receive mouse input even if the mouse cursor is outside the bounds of the panel.

**Arguments:**
- `doCapture` (boolean) — Set to true to enable, set to false to disable.

[wiki](https://wiki.facepunch.com/gmod/Panel:MouseCapture)

---

### Panel:MoveAbove · Client, Menu
`Panel:MoveAbove(panel: Panel, offset: number = 0)`

Places the panel above the passed panel with the specified offset.

**Arguments:**
- `panel` (Panel) — Panel to position relatively to.
- `offset` (number, default `0`) — The align offset.

[wiki](https://wiki.facepunch.com/gmod/Panel:MoveAbove) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L137-L137)

---

### Panel:MoveBelow · Client, Menu
`Panel:MoveBelow(panel: Panel, offset: number = 0)`

Places the panel below the passed panel with the specified offset.

**Arguments:**
- `panel` (Panel) — Panel to position relatively to.
- `offset` (number, default `0`) — The align offset.

[wiki](https://wiki.facepunch.com/gmod/Panel:MoveBelow) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L138-L138)

---

### Panel:MoveBy · Client, Menu
`Panel:MoveBy(moveX: number, moveY: number, time: number, delay: number = 0, ease: number = -1, callback: function = nil)`

Moves the panel by the specified coordinates using animation.

**Arguments:**
- `moveX` (number) — The number of pixels to move by in the horizontal (x) direction.
- `moveY` (number) — The number of pixels to move by in the vertical (y) direction.
- `time` (number) — The time (in seconds) in which to perform the animation.
- `delay` (number, default `0`) — The delay (in seconds) before the animation begins.
- `ease` (number, default `-1`) — The easing of the start and/or end speed of the animation.
- `callback` (function, default `nil`) — The function to be called once the animation is complete.

[wiki](https://wiki.facepunch.com/gmod/Panel:MoveBy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L286-L292)

---

### Panel:MoveLeftOf · Client, Menu
`Panel:MoveLeftOf(panel: Panel, offset: number = 0)`

Places the panel left to the passed panel with the specified offset.

**Arguments:**
- `panel` (Panel) — Panel to position relatively to.
- `offset` (number, default `0`) — The align offset.

[wiki](https://wiki.facepunch.com/gmod/Panel:MoveLeftOf) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L140-L140)

---

### Panel:MoveRightOf · Client, Menu
`Panel:MoveRightOf(panel: Panel, offset: number = 0)`

Places the panel right to the passed panel with the specified offset.

**Arguments:**
- `panel` (Panel) — Panel to position relatively to.
- `offset` (number, default `0`) — The align offset.

[wiki](https://wiki.facepunch.com/gmod/Panel:MoveRightOf) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L139-L139)

---

### Panel:MoveTo · Client, Menu
`Panel:MoveTo(posX: number, posY: number, time: number, delay: number = 0, ease: number = -1, callback: function = nil)`

Moves the panel to the specified position using animation.

**Arguments:**
- `posX` (number) — The target x coordinate of the panel.
- `posY` (number) — The target y coordinate of the panel.
- `time` (number) — The time to perform the animation within.
- `delay` (number, default `0`) — The delay before the animation starts.
- `ease` (number, default `-1`) — The easing of the start and/or end speed of the animation.
- `callback` (function, default `nil`) — The function to be called once the animation finishes.

> **Note:** Setting the ease argument to 0 will result in the animation happening instantly, this applies to all MoveTo/SizeTo functions

[wiki](https://wiki.facepunch.com/gmod/Panel:MoveTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L146-L157)

---

### Panel:MoveToAfter · Client, Menu
`Panel:MoveToAfter(siblingPanel: Panel) → boolean`

Moves this panel object in front of the specified sibling (child of the same parent) in the render order, and shuffles up the Z-positions of siblings now behind.

**Arguments:**
- `siblingPanel` (Panel) — The panel to move this one in front of.

**Returns:**
- boolean — `false` if the passed panel is not a sibling, otherwise `nil`.

[wiki](https://wiki.facepunch.com/gmod/Panel:MoveToAfter) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L544-L565)

---

### Panel:MoveToBack · Client, Menu
`Panel:MoveToBack()`

Moves the panel object behind all other panels on screen. If the panel has been made a pop-up with [Panel:MakePopup](https://wiki.facepunch.com/gmod/Panel:MakePopup), it will still draw in front of any panels that haven't.

[wiki](https://wiki.facepunch.com/gmod/Panel:MoveToBack)

---

### Panel:MoveToBefore · Client, Menu
`Panel:MoveToBefore(siblingPanel: Panel) → boolean`

Moves this panel object behind the specified sibling (child of the same parent) in the render order, and shuffles up the [Panel:SetZPos](https://wiki.facepunch.com/gmod/Panel:SetZPos) of siblings now in front.

**Arguments:**
- `siblingPanel` (Panel) — The panel to move this one behind.

**Returns:**
- boolean — `false` if the passed panel is not a sibling, otherwise `nil`.

[wiki](https://wiki.facepunch.com/gmod/Panel:MoveToBefore) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L567-L588)

---

### Panel:MoveToFront · Client, Menu
`Panel:MoveToFront()`

Moves the panel in front of all other panels on screen. Unless the panel has been made a pop-up using [Panel:MakePopup](https://wiki.facepunch.com/gmod/Panel:MakePopup), it will still draw behind any that have.

[wiki](https://wiki.facepunch.com/gmod/Panel:MoveToFront)

---

### Panel:NewAnimation · Client, Menu
`Panel:NewAnimation(length: number, delay: number = 0, ease: number = -1, callback: function = nil) → table`

Creates a new animation for the panel object.

Methods that use this function:
* [Panel:MoveTo](https://wiki.facepunch.com/gmod/Panel:MoveTo)
* [Panel:SizeTo](https://wiki.facepunch.com/gmod/Panel:SizeTo)
* [Panel:SlideUp](https://wiki.facepunch.com/gmod/Panel:SlideUp)
* [Panel:SlideDown](https://wiki.facepunch.com/gmod/Panel:SlideDown)
* [Panel:ColorTo](https://wiki.facepunch.com/gmod/Panel:ColorTo)
* [Panel:AlphaTo](https://wiki.facepunch.com/gmod/Panel:AlphaTo)
* [Panel:MoveBy](https://wiki.facepunch.com/gmod/Panel:MoveBy)
* [Panel:LerpPositions](https://wiki.facepunch.com/gmod/Panel:LerpPositions)

**Arguments:**
- `length` (number) — The length of the animation in seconds.
- `delay` (number, default `0`) — The delay before the animation starts.
- `ease` (number, default `-1`) — The power/index to use for easing.
- `callback` (function, default `nil`) — The function to be called when the animation ends.

**Returns:**
- table — Partially filled Structures/AnimationData with the following members: * number EndTime - Equal to `length` and `delay` arguments added together, plus either the SysTime if there is no other animation queued or the end time of the last animation in the queue.

[wiki](https://wiki.facepunch.com/gmod/Panel:NewAnimation) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L102-L136)

---

### Panel:NewObject · Client, Menu · `INTERNAL`
`Panel:NewObject(objectName: string)`

**Arguments:**
- `objectName` (string)

[wiki](https://wiki.facepunch.com/gmod/Panel:NewObject)

---

### Panel:NewObjectCallback · Client, Menu · `INTERNAL`
`Panel:NewObjectCallback(objectName: string, callbackName: string)`

**Arguments:**
- `objectName` (string)
- `callbackName` (string)

[wiki](https://wiki.facepunch.com/gmod/Panel:NewObjectCallback)

---

### Panel:NoClipping · Client, Menu
`Panel:NoClipping(disableClipping: boolean)`

Sets whether this panel's drawings should be clipped within the parent panel's bounds.

See [render.SetScissorRect](https://wiki.facepunch.com/gmod/render.SetScissorRect) if you wish to set the clipping rect instead.

**Arguments:**
- `disableClipping` (boolean) — Whether to disable clipping or not.

> **Note:** This only disabled clipping for the Paint Related functions (as far as i can tell at the current moment, more testing should be done) so things like the text of a [DLabel](https://wiki.facepunch.com/gmod/DLabel) will still be clipped to the parent.
> 
> To fully disable the clipping of any children see [DisableClipping](https://wiki.facepunch.com/gmod/Global.DisableClipping).

[wiki](https://wiki.facepunch.com/gmod/Panel:NoClipping)

---

### Panel:NumSelectedChildren · Client, Menu
`Panel:NumSelectedChildren() → number`

Returns the number of children of the panel object that are selected. This is equivalent to calling [Panel:IsSelected](https://wiki.facepunch.com/gmod/Panel:IsSelected) on all child objects and counting the number of returns that are `true`.

**Returns:**
- number — The number of child objects that are currently selected.

[wiki](https://wiki.facepunch.com/gmod/Panel:NumSelectedChildren) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/selections.lua#L207-L221)

---

### Panel:OpenURL · Client, Menu
`Panel:OpenURL(URL: string)`

Instructs a HTML control to download and parse a HTML script using the passed URL.

This function can only be used on [HTML](HTML) panel and its derivatives.

**Arguments:**
- `URL` (string) — URL to open.

[wiki](https://wiki.facepunch.com/gmod/Panel:OpenURL)

---

### Panel:PaintAt · Client, Menu
`Panel:PaintAt(posX: number, posY: number)`

Paints a ghost copy of the panel at the given position.

**Arguments:**
- `posX` (number) — The x coordinate to draw the panel from.
- `posY` (number) — The y coordinate to draw the panel from.

> **Warning:** This function sets Z pos of panel's children ([PANEL:SetZPos](https://wiki.facepunch.com/gmod/PANEL:SetZPos)). It also briefly unparents and reparents the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:PaintAt)

---

### Panel:PaintingDragging · Client, Menu
`Panel:PaintingDragging()`

[wiki](https://wiki.facepunch.com/gmod/Panel.PaintingDragging)

---

### Panel:PaintManual · Client, Menu
`Panel:PaintManual(unclamp: boolean = false)`

Paints the panel at its current position. To use this you must call [Panel:SetPaintedManually](https://wiki.facepunch.com/gmod/Panel:SetPaintedManually)(true).

**Arguments:**
- `unclamp` (boolean, default `false`) — If set, overrides panels' clipping so that it can render fully when its size is larger than the game's resolution.

[wiki](https://wiki.facepunch.com/gmod/Panel:PaintManual)

---

### Panel:ParentToHUD · Client
`Panel:ParentToHUD()`

Parents the panel to the HUD.
Makes it invisible on the escape-menu and disables controls.

[wiki](https://wiki.facepunch.com/gmod/Panel:ParentToHUD)

---

### Panel:Paste · Client, Menu · `DEPRECATED`
`Panel:Paste()`

Only works for TextEntries.

Pastes the contents of the clipboard into the TextEntry.

> **Note:** Tab characters will be dropped from the pasted text

[wiki](https://wiki.facepunch.com/gmod/Panel:Paste)

---

### Panel:PositionLabel · Client, Menu
`Panel:PositionLabel(lblWidth: number, x: number, y: number, lbl: Panel, panelObj: Panel) → number`

Sets the width and position of a [DLabel](https://wiki.facepunch.com/gmod/DLabel) and places the passed panel object directly to the right of it. Returns the `y` value of the bottom of the tallest object. The panel on which this method is run is not relevant; only the passed objects are affected.

**Arguments:**
- `lblWidth` (number) — The width to set the label to.
- `x` (number) — The horizontal (x) position at which to place the label.
- `y` (number) — The vertical (y) position at which to place the label.
- `lbl` (Panel) — The label to resize and position.
- `panelObj` (Panel) — The panel object to place to the right of the label.

**Returns:**
- number — The distance from the top of the parent panel to the bottom of the tallest object (the `y` position plus the height of the label or passed panel, depending on which is tallest).

[wiki](https://wiki.facepunch.com/gmod/Panel:PositionLabel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L262-L275)

---

### Panel:Prepare · Client, Menu · `INTERNAL`
`Panel:Prepare()`

Installs Lua defined functions into the panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:Prepare)

---

### Panel:Queue · Client, Menu
`Panel:Queue()`

Enables the queue for panel animations. If enabled, the next new animation will begin after all current animations have ended. This must be called before [Panel:NewAnimation](https://wiki.facepunch.com/gmod/Panel:NewAnimation) to work, and only applies to the next new animation. If you want to queue many, you must call this before each.

[wiki](https://wiki.facepunch.com/gmod/Panel:Queue) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L84-L88)

---

### Panel:RebuildSpawnIcon · Client
`Panel:RebuildSpawnIcon()`

Causes a [SpawnIcon](https://wiki.facepunch.com/gmod/SpawnIcon) to rebuild its model image.

[wiki](https://wiki.facepunch.com/gmod/Panel:RebuildSpawnIcon)

---

### Panel:RebuildSpawnIconEx · Client
`Panel:RebuildSpawnIconEx(data: table)`

Re-renders a spawn icon with customized cam data.

[PositionSpawnIcon](https://wiki.facepunch.com/gmod/Global.PositionSpawnIcon) can be used to easily calculate the necessary camera parameters.

**Arguments:**
- `data` (table) — A four-membered table containing the information needed to re-render: * Vector cam_pos - The relative camera position the model is viewed from.

> **Note:** This function does **not** accept the standard [Structures/CamData](https://wiki.facepunch.com/gmod/Structures/CamData).

[wiki](https://wiki.facepunch.com/gmod/Panel:RebuildSpawnIconEx)

---

### Panel:Receiver · Client, Menu
`Panel:Receiver(name: string, func: function, menu: table = nil)`

Allows the panel to receive drag and drop events. Can be called multiple times with different names to receive multiple different draggable panel events.

**Arguments:**
- `name` (string) — Name of DnD panels to receive.
- `func` (function) — This function is called whenever a panel with valid name is hovering above and dropped on this panel.
- `menu` (table, default `nil`) — A table of strings that will act as a menu if drag'n'drop was performed with a right click

[wiki](https://wiki.facepunch.com/gmod/Panel:Receiver) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L315-L324)

---

### Panel:Refresh · Client, Menu
`Panel:Refresh(ignoreCache: boolean = false)`

Refreshes the HTML panel's current page.

**Arguments:**
- `ignoreCache` (boolean, default `false`) — If true, the refresh will ignore cached content similar to "ctrl+f5" in most browsers.

[wiki](https://wiki.facepunch.com/gmod/Panel:Refresh)

---

### Panel:Remove · Client, Menu
`Panel:Remove()`

Marks a panel for deletion so it will be deleted on the next frame.

This will not mark child panels for deletion this frame, but they will be marked and deleted in the next frame.

See also [Panel:IsMarkedForDeletion](https://wiki.facepunch.com/gmod/Panel:IsMarkedForDeletion)

Will automatically call [Panel:InvalidateParent](https://wiki.facepunch.com/gmod/Panel:InvalidateParent).

[wiki](https://wiki.facepunch.com/gmod/Panel:Remove)

---

### Panel:RequestFocus · Client, Menu
`Panel:RequestFocus()`

Attempts to obtain focus for this panel.

[wiki](https://wiki.facepunch.com/gmod/Panel:RequestFocus)

---

### Panel:ResetAllFades · Client, Menu
`Panel:ResetAllFades(hold: boolean, expiredOnly: boolean, newSustain: number)`

Resets all text fades in a [RichText](https://wiki.facepunch.com/gmod/RichText) element made with [Panel:InsertFade](https://wiki.facepunch.com/gmod/Panel:InsertFade).

**Arguments:**
- `hold` (boolean) — True to reset fades, false otherwise.
- `expiredOnly` (boolean) — Any value equating to `true` will reset fades only on text segments that are completely faded out.
- `newSustain` (number) — The new sustain value of each faded text segment.

[wiki](https://wiki.facepunch.com/gmod/Panel:ResetAllFades)

---

### Panel:RunJavascript · Client, Menu
`Panel:RunJavascript(js: string)`

Executes a string as JavaScript code on a web document panel.

**Arguments:**
- `js` (string) — Specify JavaScript code to be executed.

> **Note:** This function does **NOT** allow you to pass variables from JavaScript (JS) to Lua context.  
> If you wish to pass/return values from JS to Lua, you may want to use [DHTML:AddFunction](https://wiki.facepunch.com/gmod/DHTML:AddFunction) function to accomplish that job.
> **Note:** The Awesomium web renderer automatically delays the code execution if the document is not ready, but the Chromium web renderer does not!
> 
> This means that with Chromium, you cannot JavaScript run code immediatly after calling [Panel:SetHTML](https://wiki.facepunch.com/gmod/Panel:SetHTML) or [Panel:OpenURL](https://wiki.facepunch.com/gmod/Panel:OpenURL). You should wait for the events [HTML:OnDocumentReady](https://wiki.facepunch.com/gmod/HTML:OnDocumentReady) or [HTML:OnFinishLoadingDocument](https://wiki.facepunch.com/gmod/HTML:OnFinishLoadingDocument) to be triggered before proceeding, otherwise you may manipulate an empty / incomplete document.

[wiki](https://wiki.facepunch.com/gmod/Panel:RunJavascript)

---

### Panel:SaveUndoState · Client, Menu
`Panel:SaveUndoState()`

Saves the current state (caret position and the text inside) of a [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) as an undo state.

See also [Panel:Undo](https://wiki.facepunch.com/gmod/Panel:Undo).

[wiki](https://wiki.facepunch.com/gmod/Panel:SaveUndoState)

---

### Panel:ScreenToLocal · Client, Menu
`Panel:ScreenToLocal(screenX: number, screenY: number) → number, number`

Translates global screen coordinate to coordinates relative to the panel.

See also [Panel:LocalToScreen](https://wiki.facepunch.com/gmod/Panel:LocalToScreen).

**Arguments:**
- `screenX` (number) — The x coordinate of the screen position to be translated.
- `screenY` (number) — The y coordinate of the screed position be to translated.

**Returns:**
- number — Relativeposition X
- number — Relativeposition Y

> **Warning:** This function uses a cached value for the screen position of the panel, computed at the end of the last VGUI Think/Layout pass, so inaccurate results may be returned if the panel or any of its ancestors have been re-positioned outside of [PANEL:Think](https://wiki.facepunch.com/gmod/PANEL:Think) or [PANEL:PerformLayout](https://wiki.facepunch.com/gmod/PANEL:PerformLayout) within the last frame.

[wiki](https://wiki.facepunch.com/gmod/Panel:ScreenToLocal)

---

### Panel:SelectAll · Client, Menu
`Panel:SelectAll()`

Selects all items within a panel or object. For text-based objects, selects all text.

> **Note:** Only works on [RichText](https://wiki.facepunch.com/gmod/RichText) and [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) and their derived panels by default (such as [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry)), and on any panel that manually reimplemented this method.

[wiki](https://wiki.facepunch.com/gmod/Panel:SelectAll)

---

### Panel:SelectAllOnFocus · Client, Menu
`Panel:SelectAllOnFocus()`

If called on a [TextEntry](https://wiki.facepunch.com/gmod/TextEntry), clicking the text entry for the first time will automatically select all of the text ready to be copied by the user.

[wiki](https://wiki.facepunch.com/gmod/Panel:SelectAllOnFocus)

---

### Panel:SelectAllText · Client, Menu · `DEPRECATED`
`Panel:SelectAllText(resetCursorPos: boolean)`

Selects all the text in a panel object. Will not select non-text items; for this, use [Panel:SelectAll](https://wiki.facepunch.com/gmod/Panel:SelectAll).

**Arguments:**
- `resetCursorPos` (boolean) — Reset cursor pos?

[wiki](https://wiki.facepunch.com/gmod/Panel:SelectAllText)

---

### Panel:SelectNone · Client, Menu
`Panel:SelectNone()`

Deselects all items in a panel object. For text-based objects, this will deselect all text.

> **Note:** Only works on [RichText](https://wiki.facepunch.com/gmod/RichText) and [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) and their derived panels by default (such as [DTextEntry](https://wiki.facepunch.com/gmod/DTextEntry)), and on any panel that manually reimplemented this method.

[wiki](https://wiki.facepunch.com/gmod/Panel:SelectNone)

---

### Panel:SetAchievement · Client, Menu
`Panel:SetAchievement(id: number)`

Sets the achievement to be displayed by [AchievementIcon](https://wiki.facepunch.com/gmod/AchievementIcon).

**Arguments:**
- `id` (number) — Achievement number ID

[wiki](https://wiki.facepunch.com/gmod/Panel:SetAchievement)

---

### Panel:SetAllowNonAsciiCharacters · Client, Menu
`Panel:SetAllowNonAsciiCharacters(allowed: boolean)`

Configures a [TextEntry](https://wiki.facepunch.com/gmod/TextEntry) to allow user to type characters that are not included in the US-ASCII (7-bit ASCII) character set.

Characters not included in US-ASCII are multi-byte characters in UTF-8. They can be accented characters, non-Latin characters and special characters.

**Arguments:**
- `allowed` (boolean) — Set to true in order not to restrict input characters.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetAllowNonAsciiCharacters)

---

### Panel:SetAlpha · Client, Menu
`Panel:SetAlpha(alpha: number)`

Sets the alpha multiplier for the panel

**Arguments:**
- `alpha` (number) — The alpha value in the range of 0-255.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetAlpha)

---

### Panel:SetAnimationEnabled · Client, Menu
`Panel:SetAnimationEnabled(enable: boolean)`

Enables or disables animations for the panel object by overriding the [PANEL:AnimationThink](https://wiki.facepunch.com/gmod/PANEL:AnimationThink) hook to nil and back.

**Arguments:**
- `enable` (boolean) — Whether to enable or disable animations.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetAnimationEnabled) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/animation.lua#L65-L76)

---

### Panel:SetAutoDelete · Client, Menu
`Panel:SetAutoDelete(autoDelete: boolean)`

Sets whenever the panel should be removed if the parent was removed.

**Arguments:**
- `autoDelete` (boolean) — Whenever to delete if the parent was removed or not.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetAutoDelete)

---

### Panel:SetBGColor · Client, Menu
`Panel:SetBGColor(r: number, g: number, b: number, a: number, color: Color)`

Sets the background color of a panel such as a [RichText](https://wiki.facepunch.com/gmod/RichText), [Label](https://wiki.facepunch.com/gmod/Label), [DColorCube](https://wiki.facepunch.com/gmod/DColorCube) or the base [Panel](https://wiki.facepunch.com/gmod/Panel).

For many panels, such as [DLabel](https://wiki.facepunch.com/gmod/DLabel) and [Panel](https://wiki.facepunch.com/gmod/Panel), you must use [Panel:SetPaintBackgroundEnabled](https://wiki.facepunch.com/gmod/Panel:SetPaintBackgroundEnabled)( true ) for the background to appear.

Please note that for most panels the engine will overwrite the foreground and background colors a frame after panel creation via the [PANEL:ApplySchemeSettings](https://wiki.facepunch.com/gmod/PANEL:ApplySchemeSettings) hook, so you may want to set the color in that hook instead.

See [Panel:SetFGColor](https://wiki.facepunch.com/gmod/Panel:SetFGColor) for the foreground color.

**Arguments:**
- `r` (number) — The red channel of the color.
- `g` (number) — The green channel of the color.
- `b` (number) — The blue channel of the color.
- `a` (number) — The alpha channel of the color.
- `color` (Color) — A Color object/table to read the color from.

> **Note:** This doesn't apply to all VGUI elements and its function varies between them

[wiki](https://wiki.facepunch.com/gmod/Panel:SetBGColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel.lua#L32-L40)

---

### Panel:SetBGColorEx · Client, Menu · `INTERNAL`
`Panel:SetBGColorEx(r: number, g: number, b: number, a: number)`

Sets the background color of the panel.

**Arguments:**
- `r` (number) — The red channel of the color.
- `g` (number) — The green channel of the color.
- `b` (number) — The blue channel of the color.
- `a` (number) — The alpha channel of the color.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetBGColorEx)

---

### Panel:SetCaretPos · Client, Menu
`Panel:SetCaretPos(offset: number)`

Sets the position of the caret (or text cursor) in a text-based panel object.

**Arguments:**
- `offset` (number) — Caret position/offset from the start of text.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetCaretPos)

---

### Panel:SetContentAlignment · Client, Menu
`Panel:SetContentAlignment(alignment: number)`

Sets the alignment of the contents.

**Arguments:**
- `alignment` (number) — The direction of the content, based on the number pad.

> **Note:** This function doesnt work, if [Panel:SetWrap](https://wiki.facepunch.com/gmod/Panel:SetWrap) is true.
> **Note:** This function only works on [Label](https://wiki.facepunch.com/gmod/Label) panels and its derivatives.

[wiki](https://wiki.facepunch.com/gmod/Panel:SetContentAlignment)

---

### Panel:SetConVar · Client, Menu
`Panel:SetConVar(convar: string)`

Sets this panel's convar. When the convar changes this panel will update automatically.

For developer implementation, see [Derma_Install_Convar_Functions](https://wiki.facepunch.com/gmod/Global.Derma_Install_Convar_Functions).

**Arguments:**
- `convar` (string) — The console variable to check.

> **Note:** Blocked convars will not work with this, see [Blocked ConCommands](https://wiki.facepunch.com/gmod/Blocked%20ConCommands)
> **Warning:** This function does not exist on all panels
> **Warning:** This function cannot interact with serverside convars unless you are host

[wiki](https://wiki.facepunch.com/gmod/Panel:SetConVar)

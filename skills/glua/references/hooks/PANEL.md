# PANEL

**Realm:** Client, Menu  ·  **Members:** 37

This is a list of hooks that are available on all panels.

Specific panels can have their own hooks, they are listed on their category.

> **Note:** These hooks are called on your panel. They can't be [hooked](https://wiki.facepunch.com/gmod/hook.Add)

> **Using these hooks:** these are **panel method overrides**, not `hook.Add` events — define `function PANEL:<Name>(...) end` in a `vgui.Register`'d panel, or assign on an instance: `myPanel.<Name> = function(self, ...) end`. The `PANEL:` prefix shown on each member below is the method form you write.

### PANEL:AnimationThink · Client · `hook`
`PANEL:AnimationThink()`

Called every frame unless the panel is not visible ([Panel:IsVisible](https://wiki.facepunch.com/gmod/Panel:IsVisible)). Similar to [PANEL:Think](https://wiki.facepunch.com/gmod/PANEL:Think), but can be disabled by [Panel:SetAnimationEnabled](https://wiki.facepunch.com/gmod/Panel:SetAnimationEnabled) as explained below.

If you are overriding this, you must call [Panel:AnimationThinkInternal](https://wiki.facepunch.com/gmod/Panel:AnimationThinkInternal) every frame, else animations will cease to work.

If you want to "disable" this hook with [Panel:SetAnimationEnabled](https://wiki.facepunch.com/gmod/Panel:SetAnimationEnabled), you must call it after defining this hook. Once disabled, a custom hook **will not** be re-enabled by [Panel:SetAnimationEnabled](https://wiki.facepunch.com/gmod/Panel:SetAnimationEnabled) again - the hook will have to be re-defined.

[wiki](https://wiki.facepunch.com/gmod/PANEL:AnimationThink)

---

### PANEL:ApplySchemeSettings · Client · `hook`
`PANEL:ApplySchemeSettings()`

Called whenever the panel should apply its scheme (colors, fonts, style).

It is called a few frames after panel's creation once.

The engine will overwrite [Panel:SetFGColor](https://wiki.facepunch.com/gmod/Panel:SetFGColor) and [Panel:SetBGColor](https://wiki.facepunch.com/gmod/Panel:SetBGColor) (from the engine panel theme/scheme) for most panels just before this hook is called in Lua.

[wiki](https://wiki.facepunch.com/gmod/PANEL:ApplySchemeSettings)

---

### PANEL:DragHoverClick · Client · `hook`
`PANEL:DragHoverClick(hoverTime: number)`

Called when an object is dragged and hovered over this panel for 0.1 seconds.

This is used by [DPropertySheet](https://wiki.facepunch.com/gmod/DPropertySheet) and [DTree](https://wiki.facepunch.com/gmod/DTree), for example to open a tab or expand a node when an object is hovered over it.

**Arguments:**
- `hoverTime` (number) — The time the object was hovered over this panel.

[wiki](https://wiki.facepunch.com/gmod/PANEL:DragHoverClick) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L540-L541)

---

### PANEL:DroppedOn · Client · `hook`
`PANEL:DroppedOn(pnl: Panel)`

Called when this panel is dropped onto another panel.

Only works for panels derived from [DDragBase](https://wiki.facepunch.com/gmod/DDragBase).

**Arguments:**
- `pnl` (Panel) — The panel we are dropped onto

[wiki](https://wiki.facepunch.com/gmod/PANEL:DroppedOn) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L375-L377)

---

### PANEL:GenerateExample · Client · `hook`
`PANEL:GenerateExample(class: string, dpropertysheet: Panel, width: number, height: number)`

Called when the panel should generate example use case / example code to use for this panel. Used in the panel opened by **derma_controls** console command.

**Arguments:**
- `class` (string) — The classname of the panel to generate example for.
- `dpropertysheet` (Panel) — A DPropertySheet to add your example to.
- `width` (number) — Width of the property sheet?
- `height` (number) — Width of the property sheet?

[wiki](https://wiki.facepunch.com/gmod/PANEL:GenerateExample) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/derma/derma_example.lua#L20)

---

### PANEL:Init · Client · `hook`
`PANEL:Init()`

Called when the panel is created. This is called for each base type that the panel has.

[wiki](https://wiki.facepunch.com/gmod/PANEL:Init)

---

### PANEL:LoadCookies · Client · `hook`
`PANEL:LoadCookies()`

Called after [Panel:SetCookieName](https://wiki.facepunch.com/gmod/Panel:SetCookieName) is called on this panel to apply the just loaded cookie values for this panel.

[wiki](https://wiki.facepunch.com/gmod/PANEL:LoadCookies)

---

### PANEL:OnActivate · Client, Menu · `hook` · `INTERNAL`
`PANEL:OnActivate()`

Called when we are activated during level load. Used by the loading screen panel.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnActivate)

---

### PANEL:OnChildAdded · Client · `hook`
`PANEL:OnChildAdded(child: Panel)`

Called whenever a child was parented to the panel.

**Arguments:**
- `child` (Panel) — The child which was added.

> **Bug** ([#2759](https://github.com/Facepunch/garrysmod/issues/2759)): This is called before the panel's metatable is set.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnChildAdded)

---

### PANEL:OnChildRemoved · Client · `hook`
`PANEL:OnChildRemoved(child: Panel)`

Called whenever a child of the panel is about to removed.

**Arguments:**
- `child` (Panel) — The child which is about to be removed.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnChildRemoved)

---

### PANEL:OnCursorEntered · Client · `hook`
`PANEL:OnCursorEntered()`

Called whenever the cursor entered the panels bounds.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnCursorEntered)

---

### PANEL:OnCursorExited · Client · `hook`
`PANEL:OnCursorExited()`

Called whenever the cursor left the panels bounds.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnCursorExited)

---

### PANEL:OnCursorMoved · Client · `hook`
`PANEL:OnCursorMoved(cursorX: number, cursorY: number) → boolean`

Called whenever the cursor was moved with the panels bounds.

**Arguments:**
- `cursorX` (number) — The new x position of the cursor relative to the panels origin.
- `cursorY` (number) — The new y position of the cursor relative to the panels origin.

**Returns:**
- boolean — Return true to suppress default action.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnCursorMoved)

---

### PANEL:OnDeactivate · Client, Menu · `hook` · `INTERNAL`
`PANEL:OnDeactivate()`

Called when we are deactivated during level load. Used by the loading screen panel.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnDeactivate)

---

### PANEL:OnDrop · Client · `hook`
`PANEL:OnDrop() → Panel`

We're being dropped on something
We can create a new panel here and return it, so that instead of dropping us - it drops the new panel instead! We remain where we are!

Only works for panels derived from [DDragBase](https://wiki.facepunch.com/gmod/DDragBase).

**Returns:**
- Panel — The panel to drop instead of us.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnDrop) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L379-L389)

---

### PANEL:OnFocusChanged · Client · `hook`
`PANEL:OnFocusChanged(gained: boolean)`

Called whenever the panel gained or lost focus.

**Arguments:**
- `gained` (boolean) — If the focus was gained (`true`) or lost (`false`).

> **Note:** [Panel:HasFocus](https://wiki.facepunch.com/gmod/Panel:HasFocus) will only be updated on the next frame and will return the "old" value at the time this hook is run. Same goes for [vgui.GetKeyboardFocus](https://wiki.facepunch.com/gmod/vgui.GetKeyboardFocus).

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnFocusChanged)

---

### PANEL:OnHScroll · Client · `hook`
`PANEL:OnHScroll(offset: number)`

Called when the panel a child [DHScrollBar](https://wiki.facepunch.com/gmod/DHScrollBar) is scrolled.

**Arguments:**
- `offset` (number) — The new horizontal scroll offset.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnHScroll)

---

### PANEL:OnKeyCodePressed · Client · `hook`
`PANEL:OnKeyCodePressed(keyCode: number) → boolean`

Called whenever a keyboard key was pressed while the panel is focused.

**Arguments:**
- `keyCode` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key code of the pressed key, see KEY.

**Returns:**
- boolean — Return `true` to suppress default action.

> **Bug** ([#2886](https://github.com/Facepunch/garrysmod/issues/2886)): This is not run for ESC/"cancelselect" binding.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnKeyCodePressed)

---

### PANEL:OnKeyCodeReleased · Client · `hook`
`PANEL:OnKeyCodeReleased(keyCode: number) → boolean`

Called whenever a keyboard key was released while the panel is focused.

**Arguments:**
- `keyCode` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key code of the released key, see KEY.

**Returns:**
- boolean — Return true to suppress default action.

> **Bug** ([#2886](https://github.com/Facepunch/garrysmod/issues/2886)): This is not run for TILDE/"toggleconsole" binding.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnKeyCodeReleased)

---

### PANEL:OnMousePressed · Client · `hook`
`PANEL:OnMousePressed(keyCode: number) → boolean`

Called whenever a mouse key was pressed while the panel is focused.

**Arguments:**
- `keyCode` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — They key code of the key pressed, see MOUSE.

**Returns:**
- boolean — Return true to suppress default action such as right click opening edit menu for DTextEntry.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnMousePressed)

---

### PANEL:OnMouseReleased · Client · `hook`
`PANEL:OnMouseReleased(keyCode: number) → boolean`

Called whenever a mouse key was released while the panel is focused.

**Arguments:**
- `keyCode` (number, enum [MOUSE](https://wiki.facepunch.com/gmod/Enums/MOUSE)) — They key code of the key released, see MOUSE.

**Returns:**
- boolean — Return true to suppress default action.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnMouseReleased)

---

### PANEL:OnMouseWheeled · Client · `hook`
`PANEL:OnMouseWheeled(scrollDelta: number) → boolean`

Called whenever the mouse wheel was used.

**Arguments:**
- `scrollDelta` (number) — The scroll delta, indicating how much the user turned the mouse wheel.

**Returns:**
- boolean — Return true to suppress default action.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnMouseWheeled)

---

### PANEL:OnRemove · Client · `hook`
`PANEL:OnRemove()`

Called when the panel is about to be removed.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnRemove)

---

### PANEL:OnScreenSizeChanged · Client, Menu · `hook`
`PANEL:OnScreenSizeChanged(oldWidth: number, oldHeight: number, newWidth: number, newHeight: number)`

Called when the player's screen resolution of the game changes.

[ScrW](https://wiki.facepunch.com/gmod/Global.ScrW) and [ScrH](https://wiki.facepunch.com/gmod/Global.ScrH) will return the new values when this hook is called.

**Arguments:**
- `oldWidth` (number) — The previous width of the game's window
- `oldHeight` (number) — The previous height of the game's window
- `newWidth` (number) — The new/current width of the game's window.
- `newHeight` (number) — The new/current height of the game's window.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnScreenSizeChanged)

---

### PANEL:OnScrollbarAppear · Client · `hook`
`PANEL:OnScrollbarAppear()`

Called when the panel a child [DVScrollBar](https://wiki.facepunch.com/gmod/DVScrollBar) or [DHScrollBar](https://wiki.facepunch.com/gmod/DHScrollBar) becomes visible.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnScrollbarAppear)

---

### PANEL:OnSizeChanged · Client · `hook`
`PANEL:OnSizeChanged(newWidth: number, newHeight: number)`

Called just after the panel size changes.

All size functions will return the new values when this hook is called.

**Arguments:**
- `newWidth` (number) — The new width of the panel
- `newHeight` (number) — The new height of the panel

> **Warning:** Changing the panel size in this hook will cause an infinite loop!

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnSizeChanged)

---

### PANEL:OnStartDragging · Client · `hook` · `INTERNAL`
`PANEL:OnStartDragging()`

Called by [dragndrop.StartDragging](https://wiki.facepunch.com/gmod/dragndrop.StartDragging) when the panel starts being dragged.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnStartDragging) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L391-L406)

---

### PANEL:OnStopDragging · Client · `hook` · `INTERNAL`
`PANEL:OnStopDragging()`

Called by [Panel:DragMouseRelease](https://wiki.facepunch.com/gmod/Panel:DragMouseRelease) when the panel object is released after being dragged.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnStopDragging) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/panel/dragdrop.lua#L408-L410)

---

### PANEL:OnTextClicked · Client · `hook`
`PANEL:OnTextClicked(id: string)`

Called whenever clickable text is clicked within a [RichText](https://wiki.facepunch.com/gmod/RichText).

**Arguments:**
- `id` (string) — The identifier of the text clicked.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnTextClicked)

---

### PANEL:OnVScroll · Client · `hook`
`PANEL:OnVScroll(offset: number)`

Called when the panel a child [DVScrollBar](https://wiki.facepunch.com/gmod/DVScrollBar) is scrolled.

**Arguments:**
- `offset` (number) — The new vertical scroll offset.

[wiki](https://wiki.facepunch.com/gmod/PANEL:OnVScroll)

---

### PANEL:Paint · Client, Menu · `hook`
`PANEL:Paint(width: number, height: number) → boolean`

Called whenever the panel should be drawn. 

This hook will not run if the panel is completely off the screen, and will still run if any parts of the panel are still on screen.

You can create panels with a customized appearance by overriding their `Paint()` function, which will prevent the default appearance from being drawn.

See also [PANEL:PaintOver](https://wiki.facepunch.com/gmod/PANEL:PaintOver).

**Arguments:**
- `width` (number) — The panel's width.
- `height` (number) — The panel's height.

**Returns:**
- boolean — Returning true prevents the background from being drawn.

> **Note:** Render operations from the [surface](https://wiki.facepunch.com/gmod/surface) library (and consequentially the [draw](https://wiki.facepunch.com/gmod/draw) library) are always offset by the global position of this panel, as seen in the example below

[wiki](https://wiki.facepunch.com/gmod/PANEL:Paint)

---

### PANEL:PaintOver · Client, Menu · `hook`
`PANEL:PaintOver(width: number, height: number) → boolean`

Called whenever the panel and all its children were drawn, return true to override the default drawing.

This is useful to draw content over the panel without having to overwrite it's [PANEL:Paint](https://wiki.facepunch.com/gmod/PANEL:Paint) hook, for example as an indicator that a panel is selected in [PropSelect](https://wiki.facepunch.com/gmod/PropSelect)

**Arguments:**
- `width` (number) — The panels current width.
- `height` (number) — The panels current height.

**Returns:**
- boolean — Should we disable default PaintOver rendering?

[wiki](https://wiki.facepunch.com/gmod/PANEL:PaintOver)

---

### PANEL:PerformLayout · Client · `hook`
`PANEL:PerformLayout(width: number, height: number)`

Called whenever the panels' layout needs to be performed again. This means all child panels must be re-positioned to fit the possibly new size of this panel.

This can be triggered in numerous ways:
* [Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout) was called this or previous frame (depending on the argument)
* [Panel:SetPos](https://wiki.facepunch.com/gmod/Panel:SetPos) called more than once on the same panel ([Issue](https://github.com/Facepunch/garrysmod-issues/issues/5519))
* A child element was added to this panel (TODO: Verify me)
* The size of this panel has changed

You should not call this function directly. Use [Panel:InvalidateLayout](https://wiki.facepunch.com/gmod/Panel:InvalidateLayout) instead.

You should also be careful to not cause layout loops. You can use `vgui_visualizelayout 1` to visualize panel layouts as they happen for debugging purposes. Panels should not be doing this every frame for performance reasons.

**Arguments:**
- `width` (number) — The panels current width.
- `height` (number) — The panels current height.

[wiki](https://wiki.facepunch.com/gmod/PANEL:PerformLayout)

---

### PANEL:PostAutoRefresh · Client · `hook`
`PANEL:PostAutoRefresh()`

Only works on elements defined with [derma.DefineControl](https://wiki.facepunch.com/gmod/derma.DefineControl) and only if the panel has **AllowAutoRefresh** set to true.

Called after [derma.DefineControl](https://wiki.facepunch.com/gmod/derma.DefineControl) is called with panel's class name.

See also [PANEL:PreAutoRefresh](https://wiki.facepunch.com/gmod/PANEL:PreAutoRefresh)

[wiki](https://wiki.facepunch.com/gmod/PANEL:PostAutoRefresh)

---

### PANEL:PreAutoRefresh · Client · `hook`
`PANEL:PreAutoRefresh()`

Only works on elements defined with [derma.DefineControl](https://wiki.facepunch.com/gmod/derma.DefineControl) and only if the panel has **AllowAutoRefresh** set to true.

Called when [derma.DefineControl](https://wiki.facepunch.com/gmod/derma.DefineControl) is called with this panel's class name before applying changes to this panel.

See also [PANEL:PostAutoRefresh](https://wiki.facepunch.com/gmod/PANEL:PostAutoRefresh)

[wiki](https://wiki.facepunch.com/gmod/PANEL:PreAutoRefresh)

---

### PANEL:TestHover · Client · `hook`
`PANEL:TestHover(x: number, y: number) → boolean`

Called to test if the panel is being `hovered` by the mouse. This will only be called if the panel's parent is being hovered.

**Arguments:**
- `x` (number) — The x coordinate of the cursor, in screen space.
- `y` (number) — The y coordinate of the cursor, in screen space.

**Returns:**
- boolean — Return false when the cursor is not considered on the panel, true if it is considered on the panel.

[wiki](https://wiki.facepunch.com/gmod/PANEL:TestHover)

---

### PANEL:Think · Client, Menu · `hook`
`PANEL:Think()`

Called every frame while [Panel:IsVisible](https://wiki.facepunch.com/gmod/Panel:IsVisible) is true.

[wiki](https://wiki.facepunch.com/gmod/PANEL:Think)

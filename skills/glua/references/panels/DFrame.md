# DFrame

**Realm:** Client, Menu  ·  **Members:** 26  ·  **Inherits:** `EditablePanel`

The DFrame is the moma of basically all VGUI elements. 98% of the time you will parent your element to this.

[wiki page](https://wiki.facepunch.com/gmod/DFrame)

### DFrame:Center · Client, Menu
`DFrame:Center()`

Centers the frame relative to the whole screen and invalidates its layout. This overrides [Panel:Center](https://wiki.facepunch.com/gmod/Panel:Center).

[wiki](https://wiki.facepunch.com/gmod/DFrame:Center) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L104-L110)

---

### DFrame:Close · Client, Menu
`DFrame:Close()`

Hides or removes the DFrame, and calls [DFrame:OnClose](https://wiki.facepunch.com/gmod/DFrame:OnClose).

To set whether the frame is hidden or removed, use [DFrame:SetDeleteOnClose](https://wiki.facepunch.com/gmod/DFrame:SetDeleteOnClose).

[wiki](https://wiki.facepunch.com/gmod/DFrame:Close) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L89-L99)

---

### DFrame:GetBackgroundBlur · Client, Menu
`DFrame:GetBackgroundBlur() → boolean`

Gets whether the background behind the frame is being blurred.

**Returns:**
- boolean — Whether or not background blur is enabled.

[wiki](https://wiki.facepunch.com/gmod/DFrame:GetBackgroundBlur) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L14)

---

### DFrame:GetDeleteOnClose · Client, Menu
`DFrame:GetDeleteOnClose() → boolean`

Determines whether or not the DFrame will be removed when it is closed. This is set with [DFrame:SetDeleteOnClose](https://wiki.facepunch.com/gmod/DFrame:SetDeleteOnClose).

**Returns:**
- boolean — Whether or not the frame will be removed on close.

[wiki](https://wiki.facepunch.com/gmod/DFrame:GetDeleteOnClose) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L8)

---

### DFrame:GetDraggable · Client, Menu
`DFrame:GetDraggable() → boolean`

Gets whether or not the frame is draggable by the user.

**Returns:**
- boolean — Whether the frame is draggable or not.

[wiki](https://wiki.facepunch.com/gmod/DFrame:GetDraggable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L5)

---

### DFrame:GetIsMenu · Client, Menu
`DFrame:GetIsMenu() → boolean`

Gets whether or not the frame is part of a derma menu. This is set with [DFrame:SetIsMenu](https://wiki.facepunch.com/gmod/DFrame:SetIsMenu).

**Returns:**
- boolean — Whether or not this frame is a menu component.

[wiki](https://wiki.facepunch.com/gmod/DFrame:GetIsMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L4)

---

### DFrame:GetMinHeight · Client, Menu
`DFrame:GetMinHeight() → number`

Gets the minimum height the DFrame can be resized to by the user.

You must call [DFrame:SetSizable](https://wiki.facepunch.com/gmod/DFrame:SetSizable) before the user can resize the frame.

**Returns:**
- number — The minimum height the user can resize the frame to.

[wiki](https://wiki.facepunch.com/gmod/DFrame:GetMinHeight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L12)

---

### DFrame:GetMinWidth · Client, Menu
`DFrame:GetMinWidth() → number`

Gets the minimum width the DFrame can be resized to by the user.

You must call [DFrame:SetSizable](https://wiki.facepunch.com/gmod/DFrame:SetSizable) before the user can resize the frame.

**Returns:**
- number — The minimum width the user can resize the frame to.

[wiki](https://wiki.facepunch.com/gmod/DFrame:GetMinWidth) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L11)

---

### DFrame:GetPaintShadow · Client, Menu
`DFrame:GetPaintShadow() → boolean`

Gets whether or not the shadow effect bordering the DFrame is being drawn.

**Returns:**
- boolean — Whether or not the shadow is being drawn.

[wiki](https://wiki.facepunch.com/gmod/DFrame:GetPaintShadow) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L9)

---

### DFrame:GetScreenLock · Client, Menu
`DFrame:GetScreenLock() → boolean`

Gets whether or not the DFrame is restricted to the boundaries of the screen resolution.

**Returns:**
- boolean — Whether or not the frame is restricted.

[wiki](https://wiki.facepunch.com/gmod/DFrame:GetScreenLock) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L7)

---

### DFrame:GetSizable · Client, Menu
`DFrame:GetSizable() → boolean`

Gets whether or not the DFrame can be resized by the user.

This is achieved by clicking and dragging in the bottom right corner of the frame.

**Returns:**
- boolean — Whether the frame can be resized or not.

[wiki](https://wiki.facepunch.com/gmod/DFrame:GetSizable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L6)

---

### DFrame:GetTitle · Client, Menu
`DFrame:GetTitle() → string`

Returns the title of the frame.

**Returns:**
- string — Title of the frame.

[wiki](https://wiki.facepunch.com/gmod/DFrame:GetTitle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L77-L81)

---

### DFrame:IsActive · Client, Menu
`DFrame:IsActive() → boolean`

Determines if the frame or one of its children has the screen focus.

**Returns:**
- boolean — Whether or not the frame has focus.

[wiki](https://wiki.facepunch.com/gmod/DFrame:IsActive) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L112-L119)

---

### DFrame:OnClose · Client, Menu · `hook`
`DFrame:OnClose()`

Called when the DFrame is closed with [DFrame:Close](https://wiki.facepunch.com/gmod/DFrame:Close). This applies when the `close` button in the DFrame's control box is clicked.

This function does nothing and is safe to override.

This is **not** called when the DFrame is removed with [Panel:Remove](https://wiki.facepunch.com/gmod/Panel:Remove), see [PANEL:OnRemove](https://wiki.facepunch.com/gmod/PANEL:OnRemove) for that.

[wiki](https://wiki.facepunch.com/gmod/DFrame:OnClose) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L101-L102)

---

### DFrame:SetBackgroundBlur · Client, Menu
`DFrame:SetBackgroundBlur(blur: boolean)`

Indicate that the background elements won't be usable.

**Arguments:**
- `blur` (boolean) — Whether or not to block mouse on background panels or not.

[wiki](https://wiki.facepunch.com/gmod/DFrame:SetBackgroundBlur) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DFrame:SetDeleteOnClose · Client, Menu
`DFrame:SetDeleteOnClose(shouldDelete: boolean)`

Determines whether or not the DFrame is removed when it is closed with [DFrame:Close](https://wiki.facepunch.com/gmod/DFrame:Close).

**Arguments:**
- `shouldDelete` (boolean) — Whether or not to delete the frame on close.

[wiki](https://wiki.facepunch.com/gmod/DFrame:SetDeleteOnClose) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DFrame:SetDraggable · Client, Menu
`DFrame:SetDraggable(draggable: boolean)`

Sets whether the frame should be draggable by the user. The DFrame can only be dragged from its title bar.

**Arguments:**
- `draggable` (boolean) — Whether to be draggable or not.

[wiki](https://wiki.facepunch.com/gmod/DFrame:SetDraggable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DFrame:SetIcon · Client, Menu
`DFrame:SetIcon(path: string)`

Adds or removes an icon on the left of the [DFrame](https://wiki.facepunch.com/gmod/DFrame)'s title.

**Arguments:**
- `path` (string) — Set to empty string ("") to remove the icon.

[wiki](https://wiki.facepunch.com/gmod/DFrame:SetIcon) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L121-L135)

---

### DFrame:SetIsMenu · Client, Menu
`DFrame:SetIsMenu(isMenu: boolean)`

Sets whether the frame is part of a derma menu or not.

If this is set to `true`, [CloseDermaMenus](https://wiki.facepunch.com/gmod/Global.CloseDermaMenus) will not be called when the frame is clicked, and thus any open menus will remain open.

**Arguments:**
- `isMenu` (boolean) — Whether or not this frame is a menu component.

[wiki](https://wiki.facepunch.com/gmod/DFrame:SetIsMenu) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DFrame:SetMinHeight · Client, Menu
`DFrame:SetMinHeight(minH: number)`

Sets the minimum height the DFrame can be resized to by the user.

This only applies to users attempting to resize the frame; [Panel:SetTall](https://wiki.facepunch.com/gmod/Panel:SetTall) and similar methods will not be affected. You must call [DFrame:SetSizable](https://wiki.facepunch.com/gmod/DFrame:SetSizable) before the user can resize the frame.

**Arguments:**
- `minH` (number) — The minimum height the user can resize the frame to.

[wiki](https://wiki.facepunch.com/gmod/DFrame:SetMinHeight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L189-L189)

---

### DFrame:SetMinWidth · Client, Menu
`DFrame:SetMinWidth(minW: number)`

Sets the minimum width the DFrame can be resized to by the user.

This only applies to users attempting to resize the frame; [Panel:SetWide](https://wiki.facepunch.com/gmod/Panel:SetWide) and similar methods will not be affected. You must call [DFrame:SetSizable](https://wiki.facepunch.com/gmod/DFrame:SetSizable) before the user can resize the frame.

**Arguments:**
- `minW` (number) — The minimum width the user can resize the frame to.

[wiki](https://wiki.facepunch.com/gmod/DFrame:SetMinWidth) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L189-L189)

---

### DFrame:SetPaintShadow · Client, Menu
`DFrame:SetPaintShadow(shouldPaint: boolean)`

Sets whether or not the shadow effect bordering the DFrame should be drawn.

**Arguments:**
- `shouldPaint` (boolean) — Whether or not to draw the shadow.

[wiki](https://wiki.facepunch.com/gmod/DFrame:SetPaintShadow) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DFrame:SetScreenLock · Client, Menu
`DFrame:SetScreenLock(lock: boolean)`

Sets whether the DFrame is restricted to the boundaries of the screen resolution.

**Arguments:**
- `lock` (boolean) — If `true`, the frame cannot be dragged outside of the screen bounds

[wiki](https://wiki.facepunch.com/gmod/DFrame:SetScreenLock) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DFrame:SetSizable · Client, Menu
`DFrame:SetSizable(sizeable: boolean)`

Sets whether or not the [DFrame](https://wiki.facepunch.com/gmod/DFrame) can be resized by the user.

This is achieved by clicking and dragging in the bottom right corner of the frame.

You can set the minimum size using [DFrame:SetMinWidth](https://wiki.facepunch.com/gmod/DFrame:SetMinWidth) and [DFrame:SetMinHeight](https://wiki.facepunch.com/gmod/DFrame:SetMinHeight).

**Arguments:**
- `sizeable` (boolean) — Whether the frame should be resizeable or not.

[wiki](https://wiki.facepunch.com/gmod/DFrame:SetSizable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DFrame:SetTitle · Client, Menu
`DFrame:SetTitle(title: string)`

Sets the title of the frame.

**Arguments:**
- `title` (string) — New title of the frame.

[wiki](https://wiki.facepunch.com/gmod/DFrame:SetTitle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L83-L87)

---

### DFrame:ShowCloseButton · Client, Menu
`DFrame:ShowCloseButton(show: boolean)`

Determines whether the DFrame's control box (close, minimise and maximise buttons) is displayed.

**Arguments:**
- `show` (boolean) — `false` hides the control box; this is `true` by default.

[wiki](https://wiki.facepunch.com/gmod/DFrame:ShowCloseButton) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dframe.lua#L69-L75)

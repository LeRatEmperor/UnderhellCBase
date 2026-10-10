# DAdjustableModelPanel

**Realm:** Client  ·  **Members:** 6  ·  **Inherits:** `DModelPanel`

A derivative of the DModelPanel in which the user may modify the perspective of the model with their mouse and keyboard by clicking and dragging.

The keyboard keys          and  can be used when the right mouse is held down, with  acting as a speed multiplier. When the left mouse is used, the Shift key holds the current `y` angle steady.

This is used by [IconEditor](https://wiki.facepunch.com/gmod/IconEditor) for modifying spawn icons.

[wiki page](https://wiki.facepunch.com/gmod/DAdjustableModelPanel)

### DAdjustableModelPanel:CaptureMouse · Client · `INTERNAL`
`DAdjustableModelPanel:CaptureMouse()`

Used by the panel to perform mouse capture operations when adjusting the model.

[wiki](https://wiki.facepunch.com/gmod/DAdjustableModelPanel:CaptureMouse) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dadjustablemodelpanel.lua#L52-L66)

---

### DAdjustableModelPanel:FirstPersonControls · Client · `INTERNAL`
`DAdjustableModelPanel:FirstPersonControls()`

Used to adjust the perspective in the model panel via the keyboard, when the right mouse button is used.

[wiki](https://wiki.facepunch.com/gmod/DAdjustableModelPanel:FirstPersonControls) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dadjustablemodelpanel.lua#L68-L105)

---

### DAdjustableModelPanel:GetFirstPerson · Client
`DAdjustableModelPanel:GetFirstPerson() → boolean`

Gets whether mouse and keyboard-based adjustment of the perspective has been enabled. See [DAdjustableModelPanel:SetFirstPerson](https://wiki.facepunch.com/gmod/DAdjustableModelPanel:SetFirstPerson) for more information.

This is an [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Returns:**
- boolean — Whether first person controls are enabled.

[wiki](https://wiki.facepunch.com/gmod/DAdjustableModelPanel:GetFirstPerson) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dadjustablemodelpanel.lua#L4)

---

### DAdjustableModelPanel:GetMovementScale · Client
`DAdjustableModelPanel:GetMovementScale() → number`

Returns the movement speed multiplier set by [DAdjustableModelPanel:SetMovementScale](https://wiki.facepunch.com/gmod/DAdjustableModelPanel:SetMovementScale).

	An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Returns:**
- number — The movement scale, where `1` is normal, `2` is double, etc.

[wiki](https://wiki.facepunch.com/gmod/DAdjustableModelPanel:GetMovementScale) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dadjustablemodelpanel.lua#L5)

---

### DAdjustableModelPanel:SetFirstPerson · Client
`DAdjustableModelPanel:SetFirstPerson(enable: boolean)`

Enables mouse and keyboard-based adjustment of the perspective.

This is set to `true` automatically each time mouse capture is enabled, and hence doesn't serve as a usable setting, other than to disable this functionality after the [PANEL:OnMousePressed](https://wiki.facepunch.com/gmod/PANEL:OnMousePressed) event.

An [AccessorFunc](https://wiki.facepunch.com/gmod/Global.AccessorFunc)

**Arguments:**
- `enable` (boolean) — Whether to enable/disable first person controls.

[wiki](https://wiki.facepunch.com/gmod/DAdjustableModelPanel:SetFirstPerson) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dadjustablemodelpanel.lua#L4)

---

### DAdjustableModelPanel:SetMovementScale · Client
`DAdjustableModelPanel:SetMovementScale(a1: number)`

Sets the movement speed multiplier. Currently this only affects first person camera controls.

**Arguments:**
- `a1` (number) — The movement scale, where `1` is normal, `2` is double, etc.

[wiki](https://wiki.facepunch.com/gmod/DAdjustableModelPanel:SetMovementScale) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dadjustablemodelpanel.lua#L5)

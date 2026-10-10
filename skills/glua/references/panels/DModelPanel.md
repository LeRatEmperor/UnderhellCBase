# DModelPanel

**Realm:** Client  ·  **Members:** 27  ·  **Inherits:** `DButton`

DModelPanel is a VGUI element that projects a 3D model onto a 2D plane. See also [DAdjustableModelPanel](https://wiki.facepunch.com/gmod/DAdjustableModelPanel)

[wiki page](https://wiki.facepunch.com/gmod/DModelPanel)

### DModelPanel:DrawModel · Client · `INTERNAL`
`DModelPanel:DrawModel()`

Used by the DModelPanel's paint hook to draw the model and background.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:DrawModel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmodelpanel.lua#L77-L108)

---

### DModelPanel:GetAmbientLight · Client
`DModelPanel:GetAmbientLight() → Color`

Returns the ambient lighting used on the rendered entity.

**Returns:**
- Color — The color of the ambient lighting.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:GetAmbientLight)

---

### DModelPanel:GetAnimated · Client
`DModelPanel:GetAnimated() → boolean`

Returns whether or not the panel entity should be animated when the default [DModelPanel:LayoutEntity](https://wiki.facepunch.com/gmod/DModelPanel:LayoutEntity) function is called.

**Returns:**
- boolean — True if the panel entity can be animated with Entity:SetSequence directly, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:GetAnimated)

---

### DModelPanel:GetAnimSpeed · Client
`DModelPanel:GetAnimSpeed() → number`

Returns the animation speed of the panel entity, see [DModelPanel:SetAnimSpeed](https://wiki.facepunch.com/gmod/DModelPanel:SetAnimSpeed).

**Returns:**
- number — The animation speed.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:GetAnimSpeed)

---

### DModelPanel:GetCamPos · Client
`DModelPanel:GetCamPos() → Vector`

Returns the position of the model viewing camera.

**Returns:**
- Vector — The position of the camera.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:GetCamPos)

---

### DModelPanel:GetColor · Client
`DModelPanel:GetColor() → Color`

Returns the color of the rendered entity.

**Returns:**
- Color — The color of the entity.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:GetColor)

---

### DModelPanel:GetEntity · Client
`DModelPanel:GetEntity() → CSEnt`

Returns the entity being rendered by the model panel.

**Returns:**
- CSEnt — The rendered entity (client-side)

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:GetEntity)

---

### DModelPanel:GetFOV · Client
`DModelPanel:GetFOV() → number`

Returns the FOV (field of view) the camera is using.

**Returns:**
- number — The FOV of the camera.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:GetFOV)

---

### DModelPanel:GetLookAng · Client
`DModelPanel:GetLookAng() → Angle`

Returns the angles of the model viewing camera. Is **nil** until changed with [DModelPanel:SetLookAng](https://wiki.facepunch.com/gmod/DModelPanel:SetLookAng).

**Returns:**
- Angle — The angles of the camera.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:GetLookAng)

---

### DModelPanel:GetLookAt · Client
`DModelPanel:GetLookAt() → Vector`

Returns the position the viewing camera is pointing toward.

**Returns:**
- Vector — The position the camera is pointing toward.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:GetLookAt)

---

### DModelPanel:GetModel · Client
`DModelPanel:GetModel() → string`

Gets the model of the rendered entity.

**Returns:**
- string — The model of the rendered entity.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:GetModel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmodelpanel.lua#L69-L75)

---

### DModelPanel:LayoutEntity · Client · `hook`
`DModelPanel:LayoutEntity(entity: Entity)`

By default, this function slowly rotates and animates the entity being rendered.

If you want to change this behavior, you should override it.

**Arguments:**
- `entity` (Entity) — The entity that is being rendered.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:LayoutEntity)

---

### DModelPanel:PostDrawModel · Client · `hook`
`DModelPanel:PostDrawModel(ent: Entity)`

Called when the entity of the [DModelPanel](https://wiki.facepunch.com/gmod/DModelPanel) was drawn.

This is a rendering hook with 3d drawing context.

**Arguments:**
- `ent` (Entity) — The clientside entity of the DModelPanel that has been drawn.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:PostDrawModel)

---

### DModelPanel:PreDrawModel · Client · `hook`
`DModelPanel:PreDrawModel(ent: Entity) → boolean`

Called **before** the entity of the [DModelPanel](https://wiki.facepunch.com/gmod/DModelPanel) is drawn.

**Arguments:**
- `ent` (Entity) — The clientside entity of the DModelPanel that has been drawn.

**Returns:**
- boolean — Return false to stop the entity from being drawn.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:PreDrawModel)

---

### DModelPanel:RunAnimation · Client
`DModelPanel:RunAnimation()`

This function is used in [DModelPanel:LayoutEntity](https://wiki.facepunch.com/gmod/DModelPanel:LayoutEntity). It will progress the animation, set using [Entity:SetSequence](https://wiki.facepunch.com/gmod/Entity:SetSequence). By default, it is the walking animation.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:RunAnimation) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmodelpanel.lua#L155-L157)

---

### DModelPanel:SetAmbientLight · Client
`DModelPanel:SetAmbientLight(color: Color)`

Sets the ambient lighting used on the rendered entity.

**Arguments:**
- `color` (Color) — The color of the ambient lighting.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:SetAmbientLight)

---

### DModelPanel:SetAnimated · Client
`DModelPanel:SetAnimated(animated: boolean)`

Sets whether or not to animate the entity when the default [DModelPanel:LayoutEntity](https://wiki.facepunch.com/gmod/DModelPanel:LayoutEntity) is called.

**Arguments:**
- `animated` (boolean) — True to animate, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:SetAnimated)

---

### DModelPanel:SetAnimSpeed · Client
`DModelPanel:SetAnimSpeed(animSpeed: number)`

Sets the speed used by [DModelPanel:RunAnimation](https://wiki.facepunch.com/gmod/DModelPanel:RunAnimation) to advance frame on an entity sequence.

**Arguments:**
- `animSpeed` (number) — The animation speed.

> **Note:** [Entity:FrameAdvance](https://wiki.facepunch.com/gmod/Entity:FrameAdvance) doesn't seem to have any functioning arguments and therefore changing this will not have any affect on the panel entity's sequence speed without reimplementation. It only affects the value returned by [DModelPanel:GetAnimSpeed](https://wiki.facepunch.com/gmod/DModelPanel:GetAnimSpeed)

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:SetAnimSpeed)

---

### DModelPanel:SetCamPos · Client
`DModelPanel:SetCamPos(pos: Vector)`

Sets the position of the camera.

**Arguments:**
- `pos` (Vector) — The position to set the camera at.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:SetCamPos)

---

### DModelPanel:SetColor · Client
`DModelPanel:SetColor(color: Color)`

Sets the color of the rendered entity.

**Arguments:**
- `color` (Color) — The render color of the entity.

> **Note:** This does not work on Garry's Mod player models since they use a different color system. To modify a player model color, see Example 2 on the [DModelPanel](https://wiki.facepunch.com/gmod/DModelPanel) page

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:SetColor)

---

### DModelPanel:SetDirectionalLight · Client
`DModelPanel:SetDirectionalLight(direction: number, color: Color)`

Sets the directional lighting used on the rendered entity.

**Arguments:**
- `direction` (number, enum [BOX](https://wiki.facepunch.com/gmod/Enums/BOX)) — The light direction, see BOX.
- `color` (Color) — The Color of the directional lighting.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:SetDirectionalLight) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmodelpanel.lua#L38-L40)

---

### DModelPanel:SetEntity · Client
`DModelPanel:SetEntity(ent: Entity)`

Sets the entity to be rendered by the model panel.

**Arguments:**
- `ent` (Entity) — The new panel entity.

> **Note:** If you set `ent` to a shared entity you must set `ent` to nil before removing this panel or else a "Trying to remove server entity on client!" error is thrown

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:SetEntity)

---

### DModelPanel:SetFOV · Client
`DModelPanel:SetFOV(fov: number)`

Sets the panel camera's FOV (field of view).

**Arguments:**
- `fov` (number) — The field of view value.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:SetFOV)

---

### DModelPanel:SetLookAng · Client
`DModelPanel:SetLookAng(ang: Angle)`

Sets the angles of the camera.

**Arguments:**
- `ang` (Angle) — The angles to set the camera to.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:SetLookAng)

---

### DModelPanel:SetLookAt · Client
`DModelPanel:SetLookAt(pos: Vector)`

Makes the panel's camera face the given position. Basically sets the camera's angles ([DModelPanel:SetLookAng](https://wiki.facepunch.com/gmod/DModelPanel:SetLookAng)) after doing some math.

**Arguments:**
- `pos` (Vector) — The position to orient the camera toward.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:SetLookAt)

---

### DModelPanel:SetModel · Client
`DModelPanel:SetModel(model: string)`

Sets the model of the rendered entity.

**Arguments:**
- `model` (string) — The model to apply to the entity.

> **Note:** This function may give a different model than expected. This is not a bug, however this problem may appear with some player models which are renamed several times in a wrong way. To solve that, you can use [Entity:SetModel](https://wiki.facepunch.com/gmod/Entity:SetModel) and [Entity:SetModelName](https://wiki.facepunch.com/gmod/Entity:SetModelName) on the internal panel entity. More information : https://github.com/Facepunch/garrysmod-issues/issues/4534.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:SetModel) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmodelpanel.lua#L42-L67)

---

### DModelPanel:StartScene · Client
`DModelPanel:StartScene(path: string)`

Runs a [ClientsideScene](https://wiki.facepunch.com/gmod/Global.ClientsideScene) on the panel's entity.

**Arguments:**
- `path` (string) — The path to the scene file.

[wiki](https://wiki.facepunch.com/gmod/DModelPanel:StartScene) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dmodelpanel.lua#L159-L167)

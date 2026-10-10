# cam

**Realm:** Client  ·  **Members:** 15

This directs all drawing to be done to a certain 2D or 3D plane or position, until the corresponding "End" function is called.

The matrix functions exist, but are mostly unusable unless you're familiar with the source engine's layout for each aspect.

[wiki page](https://wiki.facepunch.com/gmod/cam)

### cam.ApplyShake · Client
`cam.ApplyShake(pos: Vector, angles: Angle, factor: number)`

Shakes the screen at a certain position.

**Arguments:**
- `pos` (Vector) — Origin of the shake.
- `angles` (Angle) — Angles of the shake.
- `factor` (number) — The shake factor.

[wiki](https://wiki.facepunch.com/gmod/cam.ApplyShake)

---

### cam.End · Client
`cam.End()`

Switches the renderer back to the previous drawing mode from a 3D context.

This function is an alias of [cam.End3D](https://wiki.facepunch.com/gmod/cam.End3D).

[wiki](https://wiki.facepunch.com/gmod/cam.End)

---

### cam.End2D · Client
`cam.End2D()`

Switches the renderer back to the previous drawing mode from a 2D context.

[wiki](https://wiki.facepunch.com/gmod/cam.End2D)

---

### cam.End3D · Client
`cam.End3D()`

Switches the renderer back to the previous drawing mode from a 3D context.

[wiki](https://wiki.facepunch.com/gmod/cam.End3D)

---

### cam.End3D2D · Client
`cam.End3D2D()`

Switches the renderer back to the previous drawing mode from a 3D2D context.

[wiki](https://wiki.facepunch.com/gmod/cam.End3D2D)

---

### cam.EndOrthoView · Client
`cam.EndOrthoView()`

Switches the renderer back to the previous drawing mode from a 3D orthographic rendering context.

[wiki](https://wiki.facepunch.com/gmod/cam.EndOrthoView)

---

### cam.GetModelMatrix · Client
`cam.GetModelMatrix() → VMatrix`

Returns a copy of the model matrix that is at the top of the stack.

**Returns:**
- VMatrix — The currently active matrix.

> **Note:** Editing the matrix **will not** edit the current view. To do so, you will have to use [cam.PushModelMatrix](https://wiki.facepunch.com/gmod/cam.PushModelMatrix).

[wiki](https://wiki.facepunch.com/gmod/cam.GetModelMatrix)

---

### cam.IgnoreZ · Client
`cam.IgnoreZ(ignoreZ: boolean)`

Tells the renderer to ignore the depth buffer and draw any upcoming operation "ontop" of everything that was drawn yet.

This is identical to calling `render.DepthRange( 0, 0.01 )` for `true` and  `render.DepthRange( 0, 1 )` for `false`. See [render.DepthRange](https://wiki.facepunch.com/gmod/render.DepthRange).

**Arguments:**
- `ignoreZ` (boolean) — Determines whenever to ignore the depth buffer or not.

[wiki](https://wiki.facepunch.com/gmod/cam.IgnoreZ)

---

### cam.PopModelMatrix · Client
`cam.PopModelMatrix()`

Removes the currently active model matrix (pushed previously with [cam.PushModelMatrix](https://wiki.facepunch.com/gmod/cam.PushModelMatrix)) from the stack and reinstates the previous one.

[wiki](https://wiki.facepunch.com/gmod/cam.PopModelMatrix)

---

### cam.PushModelMatrix · Client
`cam.PushModelMatrix(matrix: VMatrix, multiply: boolean = false)`

Pushes the specified matrix onto the render matrix stack. Each pushed matrix must be popped via [cam.PopModelMatrix](https://wiki.facepunch.com/gmod/cam.PopModelMatrix).

When used in [PANEL:Paint](https://wiki.facepunch.com/gmod/PANEL:Paint), if you want to rely on the top-left position of the panel, you must use [VMatrix:Translate](https://wiki.facepunch.com/gmod/VMatrix:Translate) with the (0, 0) position of the panel relative to the screen.

If trying to use it with with [cam.Start3D2D](https://wiki.facepunch.com/gmod/cam.Start3D2D), set `multiply` to `true`, since **cam.Start3D2D** pushes its own model matrix.

**Arguments:**
- `matrix` (VMatrix) — The matrix to push.
- `multiply` (boolean, default `false`) — If set, multiplies given matrix with currently active matrix (cam.GetModelMatrix) before pushing.

[wiki](https://wiki.facepunch.com/gmod/cam.PushModelMatrix)

---

### cam.Start · Client
`cam.Start(dataTbl: table)`

Sets up a new rendering context. This is an extended version of [cam.Start3D](https://wiki.facepunch.com/gmod/cam.Start3D) and [cam.Start2D](https://wiki.facepunch.com/gmod/cam.Start2D). Must be finished by [cam.End3D](https://wiki.facepunch.com/gmod/cam.End3D) or [cam.End2D](https://wiki.facepunch.com/gmod/cam.End2D).

**Arguments:**
- `dataTbl` (table) — Render context config.

> **Bug** ([#2682](https://github.com/Facepunch/garrysmod/issues/2682)): This will not update current view properties for 3D contexts.

[wiki](https://wiki.facepunch.com/gmod/cam.Start)

---

### cam.Start2D · Client
`cam.Start2D()`

Sets up a new 2D rendering context. Must be finished by [cam.End2D](https://wiki.facepunch.com/gmod/cam.End2D).

This is almost always used with a render target from the [render](https://wiki.facepunch.com/gmod/render). To set its position use [render.SetViewPort](https://wiki.facepunch.com/gmod/render.SetViewPort) with a target already stored.

> **Note:** This will put an identity matrix at the top of the model matrix stack. If you are trying to use [cam.PushModelMatrix](https://wiki.facepunch.com/gmod/cam.PushModelMatrix), call it after this function and not before.

[wiki](https://wiki.facepunch.com/gmod/cam.Start2D) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/render.lua#L108-L112)

---

### cam.Start3D · Client
`cam.Start3D(pos: Vector = nil, angles: Angle = nil, fov: number = nil, x: number = nil, y: number = nil, w: number = nil, h: number = nil, zNear: number = nil, zFar: number = nil)`

Sets up a new 3D rendering context. Must be finished by [cam.End3D](https://wiki.facepunch.com/gmod/cam.End3D).

For more advanced settings such as an orthographic view, use [cam.Start](https://wiki.facepunch.com/gmod/cam.Start) instead, which this is an alias of basically.

All parameters are optional, and fall back parameters that of the "current" or "last" render operation.

**Arguments:**
- `pos` (Vector, default `nil`) — Render cam position.
- `angles` (Angle, default `nil`) — Render cam angles.
- `fov` (number, default `nil`) — Field of view.
- `x` (number, default `nil`) — X coordinate of where to start the new view port.
- `y` (number, default `nil`) — Y coordinate of where to start the new view port.
- `w` (number, default `nil`) — Width of the new viewport.
- `h` (number, default `nil`) — Height of the new viewport.
- `zNear` (number, default `nil`) — Distance to near clipping plane.
- `zFar` (number, default `nil`) — Distance to far clipping plane.

> **Bug** ([#1995](https://github.com/Facepunch/garrysmod/issues/1995)): Negative x/y values won't work.
> **Bug** ([#2682](https://github.com/Facepunch/garrysmod/issues/2682)): This will not update current view properties.

[wiki](https://wiki.facepunch.com/gmod/cam.Start3D) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/render.lua#L114-L143)

---

### cam.Start3D2D · Client
`cam.Start3D2D(pos: Vector, angles: Angle, scale: number)`

Sets up the model transformation matrix to draw 2D content in 3D space and pushes it into the stack ([cam.PushModelMatrix](https://wiki.facepunch.com/gmod/cam.PushModelMatrix)).

Matrix formula:
```lua
local m = Matrix()
m:SetAngles( angles )
m:SetTranslation( pos )
m:SetScale( Vector( scale, -scale, 1 ) )
```


[render.SetToneMappingScaleLinear](https://wiki.facepunch.com/gmod/render.SetToneMappingScaleLinear) may of use when dealing with bloom.

**Arguments:**
- `pos` (Vector) — Origin of the 3D2D context, ie.
- `angles` (Angle) — Angles of the 3D2D context.
- `scale` (number) — The scale of the render context.

> **Warning:** This must be closed by [cam.End3D2D](https://wiki.facepunch.com/gmod/cam.End3D2D). If not done so, unexpected issues might arise.

[wiki](https://wiki.facepunch.com/gmod/cam.Start3D2D)

---

### cam.StartOrthoView · Client
`cam.StartOrthoView(leftOffset: number, topOffset: number, rightOffset: number, bottomOffset: number)`

Sets up a new 3d context using orthographic projection.

**Arguments:**
- `leftOffset` (number) — The left plane offset.
- `topOffset` (number) — The top plane offset.
- `rightOffset` (number) — The right plane offset.
- `bottomOffset` (number) — The bottom plane offset.

[wiki](https://wiki.facepunch.com/gmod/cam.StartOrthoView)

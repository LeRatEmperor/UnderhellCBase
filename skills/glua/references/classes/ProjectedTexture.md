# ProjectedTexture

**Realm:** Client  ·  **Members:** 48

A client side projected texture, created by [ProjectedTexture](https://wiki.facepunch.com/gmod/Global.ProjectedTexture).

[wiki page](https://wiki.facepunch.com/gmod/ProjectedTexture)

### ProjectedTexture:GetAngles · Client
`ProjectedTexture:GetAngles() → Angle`

Returns the angle of the ProjectedTexture, which were previously set by [ProjectedTexture:SetAngles](https://wiki.facepunch.com/gmod/ProjectedTexture:SetAngles)

**Returns:**
- Angle — The angles of the ProjectedTexture.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetAngles)

---

### ProjectedTexture:GetBrightness · Client
`ProjectedTexture:GetBrightness() → number`

Returns the brightness of the ProjectedTexture, which was previously set by [ProjectedTexture:SetBrightness](https://wiki.facepunch.com/gmod/ProjectedTexture:SetBrightness)

**Returns:**
- number — The brightness of the ProjectedTexture.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetBrightness)

---

### ProjectedTexture:GetColor · Client
`ProjectedTexture:GetColor() → Color`

Returns the color of the ProjectedTexture, which was previously set by [ProjectedTexture:SetColor](https://wiki.facepunch.com/gmod/ProjectedTexture:SetColor).

**Returns:**
- Color — The Color of the ProjectedTexture.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetColor)

---

### ProjectedTexture:GetConstantAttenuation · Client
`ProjectedTexture:GetConstantAttenuation() → number`

Returns the constant attenuation of the projected texture, which can also be set by [ProjectedTexture:SetConstantAttenuation](https://wiki.facepunch.com/gmod/ProjectedTexture:SetConstantAttenuation).

**Returns:**
- number — The constant attenuation

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetConstantAttenuation)

---

### ProjectedTexture:GetEnableShadows · Client
`ProjectedTexture:GetEnableShadows() → boolean`

Returns whether shadows are enabled for this ProjectedTexture, which was previously set by [ProjectedTexture:SetEnableShadows](https://wiki.facepunch.com/gmod/ProjectedTexture:SetEnableShadows)

**Returns:**
- boolean — Whether shadows are enabled.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetEnableShadows)

---

### ProjectedTexture:GetFarZ · Client
`ProjectedTexture:GetFarZ() → number`

Returns the projection distance of the ProjectedTexture, which was previously set by [ProjectedTexture:SetFarZ](https://wiki.facepunch.com/gmod/ProjectedTexture:SetFarZ)

**Returns:**
- number — The projection distance of the ProjectedTexture.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetFarZ)

---

### ProjectedTexture:GetHorizontalFOV · Client
`ProjectedTexture:GetHorizontalFOV() → number`

Returns the horizontal FOV of the ProjectedTexture, which was previously set by [ProjectedTexture:SetHorizontalFOV](https://wiki.facepunch.com/gmod/ProjectedTexture:SetHorizontalFOV) or [ProjectedTexture:SetFOV](https://wiki.facepunch.com/gmod/ProjectedTexture:SetFOV)

**Returns:**
- number — The horizontal FOV of the ProjectedTexture.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetHorizontalFOV)

---

### ProjectedTexture:GetLightWorld · Client
`ProjectedTexture:GetLightWorld() → boolean`

Returns whenever or not the Texture should light up world geometry.

**Returns:**
- `lightworld` (boolean) — `true` if the Texture should light up world geometry.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetLightWorld)

---

### ProjectedTexture:GetLinearAttenuation · Client
`ProjectedTexture:GetLinearAttenuation() → number`

Returns the linear attenuation of the projected texture, which can also be set by [ProjectedTexture:SetLinearAttenuation](https://wiki.facepunch.com/gmod/ProjectedTexture:SetLinearAttenuation).

**Returns:**
- number — The linear attenuation.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetLinearAttenuation)

---

### ProjectedTexture:GetNearZ · Client
`ProjectedTexture:GetNearZ() → number`

Returns the NearZ value of the ProjectedTexture, which was previously set by [ProjectedTexture:SetNearZ](https://wiki.facepunch.com/gmod/ProjectedTexture:SetNearZ)

**Returns:**
- number — NearZ of the ProjectedTexture.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetNearZ)

---

### ProjectedTexture:GetNoCull · Client
`ProjectedTexture:GetNoCull() → boolean`

Returns the state of projected texture view-frustum culling. See [ProjectedTexture:SetNoCull](https://wiki.facepunch.com/gmod/ProjectedTexture:SetNoCull).

**Returns:**
- `enable` (boolean) — `false` if culling is enabled (default), `true` if disabled.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetNoCull)

---

### ProjectedTexture:GetOrthographic · Client
`ProjectedTexture:GetOrthographic() → boolean, number, number, number, number`

Returns the current orthographic settings of the Projected Texture. To set these values, use [ProjectedTexture:SetOrthographic](https://wiki.facepunch.com/gmod/ProjectedTexture:SetOrthographic).

**Returns:**
- boolean — Whether or not this projected texture is orthographic.
- number — left
- number — top
- number — right
- number — bottom

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetOrthographic)

---

### ProjectedTexture:GetPos · Client
`ProjectedTexture:GetPos() → Vector`

Returns the position of the ProjectedTexture, which was previously set by [ProjectedTexture:SetPos](https://wiki.facepunch.com/gmod/ProjectedTexture:SetPos)

**Returns:**
- Vector — The position of the ProjectedTexture.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetPos)

---

### ProjectedTexture:GetQuadraticAttenuation · Client
`ProjectedTexture:GetQuadraticAttenuation() → number`

Returns the quadratic attenuation of the projected texture, which can also be set by [ProjectedTexture:SetQuadraticAttenuation](https://wiki.facepunch.com/gmod/ProjectedTexture:SetQuadraticAttenuation).

**Returns:**
- number — The quadratic attenuation

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetQuadraticAttenuation)

---

### ProjectedTexture:GetShadowDepthBias · Client
`ProjectedTexture:GetShadowDepthBias() → number`

Returns the shadow depth bias of the projected texture.

Set by [ProjectedTexture:SetShadowDepthBias](https://wiki.facepunch.com/gmod/ProjectedTexture:SetShadowDepthBias).

**Returns:**
- `bias` (number) — The current shadow depth bias.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetShadowDepthBias)

---

### ProjectedTexture:GetShadowFilter · Client
`ProjectedTexture:GetShadowFilter() → number`

Returns the shadow "filter size" of the projected texture. `0` is fully pixelated, higher values will blur the shadow more.

Set by [ProjectedTexture:SetShadowFilter](https://wiki.facepunch.com/gmod/ProjectedTexture:SetShadowFilter).

**Returns:**
- number — The current shadow filter size.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetShadowFilter)

---

### ProjectedTexture:GetShadowSlopeScaleDepthBias · Client
`ProjectedTexture:GetShadowSlopeScaleDepthBias() → number`

Returns the shadow depth slope scale bias of the projected texture.

Set by [ProjectedTexture:SetShadowSlopeScaleDepthBias](https://wiki.facepunch.com/gmod/ProjectedTexture:SetShadowSlopeScaleDepthBias).

**Returns:**
- number — The current shadow depth slope scale bias.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetShadowSlopeScaleDepthBias)

---

### ProjectedTexture:GetSkipShadowUpdates · Client · `NEW`
`ProjectedTexture:GetSkipShadowUpdates() → boolean`

Returns whether shadow updates are disabled for this ProjectedTexture, which was previously set by [ProjectedTexture:SetSkipShadowUpdates](https://wiki.facepunch.com/gmod/ProjectedTexture:SetSkipShadowUpdates).

**Returns:**
- boolean — Whether shadow updates are disabled.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetSkipShadowUpdates)

---

### ProjectedTexture:GetTargetEntity · Client
`ProjectedTexture:GetTargetEntity() → Entity`

Returns the target entity of this projected texture.

**Returns:**
- Entity — The current target entity.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetTargetEntity)

---

### ProjectedTexture:GetTexture · Client
`ProjectedTexture:GetTexture() → ITexture`

Returns the texture of the ProjectedTexture, which was previously set by [ProjectedTexture:SetTexture](https://wiki.facepunch.com/gmod/ProjectedTexture:SetTexture)

**Returns:**
- ITexture — The texture of the ProjectedTexture.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetTexture)

---

### ProjectedTexture:GetTextureFrame · Client
`ProjectedTexture:GetTextureFrame() → number`

Returns the texture frame of the ProjectedTexture, which was previously set by [ProjectedTexture:SetTextureFrame](https://wiki.facepunch.com/gmod/ProjectedTexture:SetTextureFrame)

**Returns:**
- number — The texture frame.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetTextureFrame)

---

### ProjectedTexture:GetVerticalFOV · Client
`ProjectedTexture:GetVerticalFOV() → number`

Returns the vertical FOV of the ProjectedTexture, which was previously set by [ProjectedTexture:SetVerticalFOV](https://wiki.facepunch.com/gmod/ProjectedTexture:SetVerticalFOV) or [ProjectedTexture:SetFOV](https://wiki.facepunch.com/gmod/ProjectedTexture:SetFOV)

**Returns:**
- number — The vertical FOV of the ProjectedTexture.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:GetVerticalFOV)

---

### ProjectedTexture:IsValid · Client
`ProjectedTexture:IsValid() → boolean`

Returns true if the projected texture is valid (i.e. has not been removed), false otherwise.

Instead of calling this directly it's a good idea to call [IsValid](https://wiki.facepunch.com/gmod/Global.IsValid) in case the variable is nil.

```lua
IsValid( ptexture )
```

This not only checks whether the projected texture is valid - but also checks whether it's nil.

**Returns:**
- boolean — Whether the projected texture is valid.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:IsValid)

---

### ProjectedTexture:Remove · Client
`ProjectedTexture:Remove()`

Removes the projected texture. After calling this, [ProjectedTexture:IsValid](https://wiki.facepunch.com/gmod/ProjectedTexture:IsValid) will return false, and any hooks with the projected texture as the identifier will be automatically deleted.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:Remove)

---

### ProjectedTexture:SetAngles · Client
`ProjectedTexture:SetAngles(angle: Angle)`

Sets the angles (direction) of the projected texture.

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `angle` (Angle)

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetAngles)

---

### ProjectedTexture:SetBrightness · Client
`ProjectedTexture:SetBrightness(brightness: number)`

Sets the brightness of the projected texture.

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `brightness` (number) — The brightness to give the projected texture.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetBrightness)

---

### ProjectedTexture:SetColor · Client
`ProjectedTexture:SetColor(color: Color)`

Sets the color of the projected texture.

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `color` (Color) — Unlike other projected textures, this color can only go up to 255.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetColor)

---

### ProjectedTexture:SetConstantAttenuation · Client
`ProjectedTexture:SetConstantAttenuation(constAtten: number)`

Sets the constant attenuation of the projected texture.

See also [ProjectedTexture:SetLinearAttenuation](https://wiki.facepunch.com/gmod/ProjectedTexture:SetLinearAttenuation) and [ProjectedTexture:SetQuadraticAttenuation](https://wiki.facepunch.com/gmod/ProjectedTexture:SetQuadraticAttenuation).

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `constAtten` (number)

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetConstantAttenuation)

---

### ProjectedTexture:SetEnableShadows · Client
`ProjectedTexture:SetEnableShadows(newState: boolean)`

Enable or disable shadows cast from the projected texture.



You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `newState` (boolean)

> **Note:** As with all types of projected textures (including the player's flashlight and env_projectedtexture), there can only be 8 projected textures with shadows enabled in total.This limit can be increased with the launch parameter `-numshadowtextures LIMIT` where `LIMIT` is the new limit.Naturally, many projected lights with shadows enabled will drastically decrease framerate.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetEnableShadows)

---

### ProjectedTexture:SetFarZ · Client
`ProjectedTexture:SetFarZ(farZ: number)`

Sets the distance at which the projected texture ends.

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `farZ` (number)

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetFarZ)

---

### ProjectedTexture:SetFOV · Client
`ProjectedTexture:SetFOV(fov: number)`

Sets the angle of projection.

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `fov` (number) — Must be higher than 0 and lower than 180

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetFOV)

---

### ProjectedTexture:SetHorizontalFOV · Client
`ProjectedTexture:SetHorizontalFOV(hFOV: number)`

Sets the horizontal angle of projection without affecting the vertical angle.

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `hFOV` (number) — The new horizontal Field Of View for the projected texture.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetHorizontalFOV)

---

### ProjectedTexture:SetLightWorld · Client
`ProjectedTexture:SetLightWorld(lightworld: boolean)`

Set whenever or not the Texture should light up world geometry.

**Arguments:**
- `lightworld` (boolean) — Set it to `true` if the Texture should light up world geometry.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetLightWorld)

---

### ProjectedTexture:SetLinearAttenuation · Client
`ProjectedTexture:SetLinearAttenuation(linearAtten: number)`

Sets the linear attenuation of the projected texture.

See also [ProjectedTexture:SetConstantAttenuation](https://wiki.facepunch.com/gmod/ProjectedTexture:SetConstantAttenuation) and [ProjectedTexture:SetQuadraticAttenuation](https://wiki.facepunch.com/gmod/ProjectedTexture:SetQuadraticAttenuation).

The default value of linear attenuation when the projected texture is created is 100. (others are 0, as you are not supposed to mix them)

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `linearAtten` (number)

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetLinearAttenuation)

---

### ProjectedTexture:SetNearZ · Client
`ProjectedTexture:SetNearZ(nearZ: number)`

Sets the distance at which the projected texture begins its projection.

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `nearZ` (number)

> **Note:** Setting this to 0 will disable the projected texture completely! This may be useful if you want to disable a projected texture without actually removing it
> **Note:** This seems to affect the rendering of shadows - a higher Near Z value will have shadows begin to render closer to their casting object. Comparing a low Near Z value (like 1) with a normal one (12) or high one (1000) is the easiest way to understand this artifact

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetNearZ)

---

### ProjectedTexture:SetNoCull · Client
`ProjectedTexture:SetNoCull(enable: boolean)`

Allows disabling of projected texture view-frustum culling for cases where said culling creates unwanted side effects. Disabling culling will have a negative effect on performance.

Culling makes projected textures off screen to stop rendering/updating.

**Arguments:**
- `enable` (boolean) — `false` to enable culling (default), `true` to disable.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetNoCull)

---

### ProjectedTexture:SetOrthographic · Client
`ProjectedTexture:SetOrthographic(orthographic: boolean, left: number, top: number, right: number, bottom: number)`

Changes the current projected texture between orthographic and perspective projection.

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

Shadows dont work. (For non static props and for most map brushes)

**Arguments:**
- `orthographic` (boolean) — When false, all other arguments are ignored and the texture is reset to perspective projection.
- `left` (number) — The amount of units left from the projected texture's origin to project.
- `top` (number) — The amount of units upwards from the projected texture's origin to project.
- `right` (number) — The amount of units right from the projected texture's origin to project.
- `bottom` (number) — The amount of units downwards from the projected texture's origin to project.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetOrthographic)

---

### ProjectedTexture:SetPos · Client
`ProjectedTexture:SetPos(position: Vector)`

Move the Projected Texture to the specified position.

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `position` (Vector)

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetPos)

---

### ProjectedTexture:SetQuadraticAttenuation · Client
`ProjectedTexture:SetQuadraticAttenuation(quadAtten: number)`

Sets the quadratic attenuation of the projected texture.

See also [ProjectedTexture:SetLinearAttenuation](https://wiki.facepunch.com/gmod/ProjectedTexture:SetLinearAttenuation) and [ProjectedTexture:SetConstantAttenuation](https://wiki.facepunch.com/gmod/ProjectedTexture:SetConstantAttenuation).

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `quadAtten` (number)

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetQuadraticAttenuation)

---

### ProjectedTexture:SetShadowDepthBias · Client
`ProjectedTexture:SetShadowDepthBias(bias: number)`

Sets the shadow depth bias of the projected texture.

The initial value is `0.0001`. Normal projected textures obey the value of the `mat_depthbias_shadowmap` [ConVar](https://wiki.facepunch.com/gmod/ConVar).

**Arguments:**
- `bias` (number) — The shadow depth bias to set.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetShadowDepthBias)

---

### ProjectedTexture:SetShadowFilter · Client
`ProjectedTexture:SetShadowFilter(filter: number)`

Sets the shadow "filter size" of the projected texture. `0` is fully pixelated, higher values will blur the shadow more. The initial value is the value of `r_projectedtexture_filter` [ConVar](https://wiki.facepunch.com/gmod/ConVar).

**Arguments:**
- `filter` (number) — The shadow filter size to set.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetShadowFilter)

---

### ProjectedTexture:SetShadowSlopeScaleDepthBias · Client
`ProjectedTexture:SetShadowSlopeScaleDepthBias(bias: number)`

Sets the shadow depth slope scale bias of the projected texture.

The initial value is `2`. Normal projected textures obey the value of the `mat_slopescaledepthbias_shadowmap` [ConVar](https://wiki.facepunch.com/gmod/ConVar).

**Arguments:**
- `bias` (number) — The shadow depth slope scale bias to set.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetShadowSlopeScaleDepthBias)

---

### ProjectedTexture:SetSkipShadowUpdates · Client · `NEW`
`ProjectedTexture:SetSkipShadowUpdates(enable: boolean)`

Sets whether shadow updates are disabled for this ProjectedTexture. This can be useful to save up on performance, but it will inevitably cause graphical glitches if left not updating for long.

**Arguments:**
- `enable` (boolean) — Whether future shadow updates should be skipped.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetSkipShadowUpdates)

---

### ProjectedTexture:SetTargetEntity · Client
`ProjectedTexture:SetTargetEntity(target: Entity = NULL)`

Sets the target entity for this projected texture, meaning it will only be lighting the given entity and the world.

**Arguments:**
- `target` (Entity, default `NULL`) — The target entity, or `NULL` to reset.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetTargetEntity)

---

### ProjectedTexture:SetTexture · Client
`ProjectedTexture:SetTexture(texture: string)`

Sets the texture to be projected.

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `texture` (string) — The name of the texture.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetTexture)

---

### ProjectedTexture:SetTextureFrame · Client
`ProjectedTexture:SetTextureFrame(frame: number)`

For animated textures, this will choose which frame in the animation will be projected.

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `frame` (number) — The frame index to use.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetTextureFrame)

---

### ProjectedTexture:SetVerticalFOV · Client
`ProjectedTexture:SetVerticalFOV(vFOV: number)`

Sets the vertical angle of projection without affecting the horizontal angle.

You must call [ProjectedTexture:Update](https://wiki.facepunch.com/gmod/ProjectedTexture:Update) after using this function for it to take effect.

**Arguments:**
- `vFOV` (number) — The new vertical Field Of View for the projected texture.

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:SetVerticalFOV)

---

### ProjectedTexture:Update · Client
`ProjectedTexture:Update()`

Updates the Projected Light and applies all previously set parameters.

The best place to call this function is in [GM:PreDrawOpaqueRenderables](https://wiki.facepunch.com/gmod/GM:PreDrawOpaqueRenderables).

[wiki](https://wiki.facepunch.com/gmod/ProjectedTexture:Update)

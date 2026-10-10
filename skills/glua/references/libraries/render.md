# render

**Realm:** Client, Menu  ·  **Members:** 141

The render library is a powerful set of functions that let you control how the world and its contents are rendered. It can also be used to draw some 3D clientside effects such as beams, boxes and spheres.

[wiki page](https://wiki.facepunch.com/gmod/render)

### render.AddBeam · Client
`render.AddBeam(startPos: Vector, width: number, textureEnd: number, color: Color)`

Adds a Beam Segment to the Beam started by [render.StartBeam](https://wiki.facepunch.com/gmod/render.StartBeam).

		For more detailed information on Beams, as well as usage examples, see the [Beams Render Reference](https://wiki.facepunch.com/gmod/render_beams).

**Arguments:**
- `startPos` (Vector) — Beam start position.
- `width` (number) — The width of the beam.
- `textureEnd` (number) — The end coordinate of the texture used.
- `color` (Color) — The color to be used.

[wiki](https://wiki.facepunch.com/gmod/render.AddBeam)

---

### render.BlurRenderTarget · Client
`render.BlurRenderTarget(rendertarget: ITexture, blurx: number, blury: number, passes: number)`

Blurs the render target ( or a given texture ).

**Arguments:**
- `rendertarget` (ITexture) — The texture to blur.
- `blurx` (number) — Horizontal amount of blur.
- `blury` (number) — Vertical amount of blur.
- `passes` (number) — Amount of passes to go through.

> **Warning:** Calling this on a RenderTarget created with TEXTUREFLAGS_POINTSAMPLE will result in strange visual glitching.

[wiki](https://wiki.facepunch.com/gmod/render.BlurRenderTarget) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/render.lua#L87-L106)

---

### render.BrushMaterialOverride · Client
`render.BrushMaterialOverride(mat: IMaterial = nil)`

This function overrides the brush material for next render operations. It can be used with [Entity:DrawModel](https://wiki.facepunch.com/gmod/Entity:DrawModel).

**Arguments:**
- `mat` (IMaterial, default `nil`)

[wiki](https://wiki.facepunch.com/gmod/render.BrushMaterialOverride)

---

### render.Capture · Client
`render.Capture(captureData: table) → string`

Captures a part of the current render target and returns the data as a binary string in the given format.

Since the pixel buffer clears itself every frame, this will return a black screen outside of render hooks. To capture the user's final view, use [GM:PostRender](https://wiki.facepunch.com/gmod/GM:PostRender). This will not capture the Steam overlay or third-party injections (such as the Discord overlay, Overwolf, and advanced cheats) on the user's screen.

**Arguments:**
- `captureData` (table) — Parameters of the capture.

**Returns:**
- string — The binary data.

> **Warning:** This function will return nil if escape menu is open
> **Bug** ([#2571](https://github.com/Facepunch/garrysmod/issues/2571)): In PNG mode, this function can produce unexpected result where foreground is rendered as transparent.
> This is caused by [render.SetWriteDepthToDestAlpha](https://wiki.facepunch.com/gmod/render.SetWriteDepthToDestAlpha) set to `true` when doing most of render operations, including rendering in `_rt_fullframefb`. If you want to capture render target's content as PNG image only for output quality, set [Structures/RenderCaptureData](https://wiki.facepunch.com/gmod/Structures/RenderCaptureData)'s `alpha` to `false` when capturing render targets with [render.SetWriteDepthToDestAlpha](https://wiki.facepunch.com/gmod/render.SetWriteDepthToDestAlpha) set to `true`.

[wiki](https://wiki.facepunch.com/gmod/render.Capture)

---

### render.CapturePixels · Client
`render.CapturePixels()`

Dumps the current render target and allows the pixels to be accessed by [render.ReadPixel](https://wiki.facepunch.com/gmod/render.ReadPixel). 

	Capturing outside a render hook will return 0 0 0 255.

[wiki](https://wiki.facepunch.com/gmod/render.CapturePixels)

---

### render.Clear · Client, Menu
`render.Clear(r: number, g: number, b: number, a: number, clearDepth: boolean = false, clearStencil: boolean = false)`

Clears the current render target and the specified buffers.

**Arguments:**
- `r` (number) — Red component to clear to.
- `g` (number) — Green component to clear to.
- `b` (number) — Blue component to clear to.
- `a` (number) — Alpha component to clear to.
- `clearDepth` (boolean, default `false`) — Clear the depth.
- `clearStencil` (boolean, default `false`) — Clear the stencil.

> **Bug** ([#2085](https://github.com/Facepunch/garrysmod/issues/2085)): This sets the alpha incorrectly for [surface](https://wiki.facepunch.com/gmod/surface) draw calls for render targets.

[wiki](https://wiki.facepunch.com/gmod/render.Clear)

---

### render.ClearBuffersObeyStencil · Client, Menu
`render.ClearBuffersObeyStencil(red: number, green: number, blue: number, alpha: number, clearDepth: boolean)`

Tests every pixel of the active [Render Target](https://wiki.facepunch.com/gmod/render_rendertargets) against the current Stencil configuration and sets the Color Channel values and, optionally, the Depth Buffer values for every pixel that passes.

		For more detailed information on the Stencil system, including usage examples, see the [Stencils Render Reference](https://wiki.facepunch.com/gmod/render_stencils) page

**Arguments:**
- `red` (number) — The red Color Channel value for each pixel that is cleared.
- `green` (number) — The green Color Channel value for each pixel that is cleared.
- `blue` (number) — The blue Color Channel value for each pixel that is cleared.
- `alpha` (number) — The alpha (translucency) Color Channel value for each pixel that is cleared.
- `clearDepth` (boolean) — If true, reset the Depth Buffer values.

> **Note:** This function does **not** clear the Stencil Buffer on its own.  
> 			If you would like to clear the Stencil Buffer, you can use [render.ClearStencil](https://wiki.facepunch.com/gmod/render.ClearStencil)

[wiki](https://wiki.facepunch.com/gmod/render.ClearBuffersObeyStencil)

---

### render.ClearDepth · Client, Menu
`render.ClearDepth(clearStencil: boolean = true)`

Resets the depth buffer.

**Arguments:**
- `clearStencil` (boolean, default `true`) — Whether to also clear the stencil buffer.

[wiki](https://wiki.facepunch.com/gmod/render.ClearDepth)

---

### render.ClearRenderTarget · Client
`render.ClearRenderTarget(texture: ITexture, color: color)`

Clears a render target.

It uses [render.Clear](https://wiki.facepunch.com/gmod/render.Clear) then [render.SetRenderTarget](https://wiki.facepunch.com/gmod/render.SetRenderTarget) on the modified render target.

**Arguments:**
- `texture` (ITexture)
- `color` (color) — The color.

[wiki](https://wiki.facepunch.com/gmod/render.ClearRenderTarget) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/render.lua#L31-L38)

---

### render.ClearStencil · Client, Menu
`render.ClearStencil()`

Sets the Stencil Buffer value to `0` for all pixels in the currently active [Render Target](https://wiki.facepunch.com/gmod/render_rendertargets).
		
		For more detailed information on the Stencil system, including usage examples, see the [Stencils Render Reference](https://wiki.facepunch.com/gmod/render_stencils) page.

[wiki](https://wiki.facepunch.com/gmod/render.ClearStencil)

---

### render.ClearStencilBufferRectangle · Client, Menu
`render.ClearStencilBufferRectangle(startX: number, startY: number, endX: number, endY: number, stencilBufferValue: number)`

Sets the Stencil Buffer value for every pixel in a given rectangle to a given value.

This is **not** affected by [render.SetStencilWriteMask](https://wiki.facepunch.com/gmod/render.SetStencilWriteMask).

For more detailed information on the Stencil system, including usage examples, see the [Stencils Render Reference](https://wiki.facepunch.com/gmod/render_stencils) page.

**Arguments:**
- `startX` (number) — The X coordinate of the top left corner of the rectangle to be cleared.
- `startY` (number) — The Y coordinate of the top left corner of the rectangle to be cleared.
- `endX` (number) — The X coordinate of the bottom right corner of the rectangle to be cleared.
- `endY` (number) — The Y coordinate of the bottom right corner of the rectangle to be cleared.
- `stencilBufferValue` (number) — The Stencil Buffer value that all pixels within the rectangle will be set to.

[wiki](https://wiki.facepunch.com/gmod/render.ClearStencilBufferRectangle)

---

### render.ComputeDynamicLighting · Client
`render.ComputeDynamicLighting(position: Vector, normal: Vector) → Vector`

Calculates the lighting caused by dynamic lights for the specified surface.

**Arguments:**
- `position` (Vector) — The position to sample from.
- `normal` (Vector) — The normal of the surface.

**Returns:**
- Vector — A vector representing the light at that point.

[wiki](https://wiki.facepunch.com/gmod/render.ComputeDynamicLighting)

---

### render.ComputeLighting · Client
`render.ComputeLighting(position: Vector, normal: Vector) → Vector`

Calculates the light color of a certain surface.

**Arguments:**
- `position` (Vector) — The position of the surface to get the light from.
- `normal` (Vector) — The normal of the surface to get the light from.

**Returns:**
- Vector — A vector representing the light at that point.

[wiki](https://wiki.facepunch.com/gmod/render.ComputeLighting)

---

### render.ComputePixelDiameterOfSphere · Client
`render.ComputePixelDiameterOfSphere(point: Vector, radius: number) → number`

Calculates diameter of a 3D sphere on a 2D screen.

**Arguments:**
- `point` (Vector) — The position of the sphere in 3D space.
- `radius` (number) — The radius of the sphere in 3D space.

**Returns:**
- number — The diameter of the sphere in 2D screen space.

[wiki](https://wiki.facepunch.com/gmod/render.ComputePixelDiameterOfSphere)

---

### render.CopyRenderTargetToTexture · Client
`render.CopyRenderTargetToTexture(Target: ITexture)`

Copies the currently active Render Target to the specified texture.

**Arguments:**
- `Target` (ITexture) — The texture to copy to.

> **Warning:** This does not copy the Depth buffer, no method for that is known at this moment so a common workaround is to store the source texture somewhere else, perform your drawing operations, save the result somewhere else and reapply the source texture.

[wiki](https://wiki.facepunch.com/gmod/render.CopyRenderTargetToTexture)

---

### render.CopyTexture · Client
`render.CopyTexture(texture_from: ITexture, texture_to: ITexture)`

Copies the contents of one texture to another. Only works with rendertargets.

**Arguments:**
- `texture_from` (ITexture) — The texture to copy from.
- `texture_to` (ITexture) — The texture being copied to.

> **Warning:** This does not copy the Depth buffer, no method for that is known at this moment so a common workaround is to store the source texture somewhere else, perform your drawing operations, save the result somewhere else and reapply the source texture.

[wiki](https://wiki.facepunch.com/gmod/render.CopyTexture) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/render.lua#L60-L69)

---

### render.CullMode · Client, Menu
`render.CullMode(cullMode: number)`

Sets the cull mode. The culling mode defines how back faces are culled when rendering geometry.

**Arguments:**
- `cullMode` (number, enum [MATERIAL_CULLMODE](https://wiki.facepunch.com/gmod/Enums/MATERIAL_CULLMODE)) — Cullmode, see MATERIAL_CULLMODE.

[wiki](https://wiki.facepunch.com/gmod/render.CullMode)

---

### render.DepthRange · Client
`render.DepthRange(depthmin: number, depthmax: number)`

Set's the depth range of the upcoming render.

**Arguments:**
- `depthmin` (number) — The minimum depth of the upcoming render.
- `depthmax` (number) — The maximum depth of the upcoming render.

[wiki](https://wiki.facepunch.com/gmod/render.DepthRange)

---

### render.DrawBeam · Client
`render.DrawBeam(startPos: Vector, endPos: Vector, width: number, textureStart: number, textureEnd: number, color: Color = Color( 255, 255, 255 ))`

Draws a single-segment Beam made out of a textured, billboarded quad stretching between two points.

		For more detailed information, including usage examples, see the [Beams Render Reference](https://wiki.facepunch.com/gmod/render_beams).

**Arguments:**
- `startPos` (Vector) — The Beam's start position.
- `endPos` (Vector) — The Beam's end position.
- `width` (number) — The width of the Beam.
- `textureStart` (number) — The starting coordinate of the Beam's texture.
- `textureEnd` (number) — The end coordinate of the Beam's texture.
- `color` (Color, default `Color( 255, 255, 255 )`) — What Color to tint the Beam.

[wiki](https://wiki.facepunch.com/gmod/render.DrawBeam)

---

### render.DrawBox · Client
`render.DrawBox(position: Vector, angles: Angle, mins: Vector, maxs: Vector, color: Color = Color( 255, 255, 255 ))`

Draws a box in 3D space.

**Arguments:**
- `position` (Vector) — Origin of the box.
- `angles` (Angle) — Orientation of the box.
- `mins` (Vector) — Start position of the box, relative to origin.
- `maxs` (Vector) — End position of the box, relative to origin.
- `color` (Color, default `Color( 255, 255, 255 )`) — The color of the box.

[wiki](https://wiki.facepunch.com/gmod/render.DrawBox)

---

### render.DrawLine · Client
`render.DrawLine(startPos: Vector, endPos: Vector, color: Color = Color( 255, 255, 255 ), writeZ: boolean = false)`

Draws a line in 3D space.

**Arguments:**
- `startPos` (Vector) — Line start position in world coordinates.
- `endPos` (Vector) — Line end position in world coordinates.
- `color` (Color, default `Color( 255, 255, 255 )`) — The color to be used.
- `writeZ` (boolean, default `false`) — Whether or not to consider the Z buffer.

[wiki](https://wiki.facepunch.com/gmod/render.DrawLine)

---

### render.DrawQuad · Client
`render.DrawQuad(vert1: Vector, vert2: Vector, vert3: Vector, vert4: Vector, color: Color = Color( 255, 255, 255 ))`

Draws 2 connected triangles. Expects material to be set by [render.SetMaterial](https://wiki.facepunch.com/gmod/render.SetMaterial).

**Arguments:**
- `vert1` (Vector) — First vertex.
- `vert2` (Vector) — The second vertex.
- `vert3` (Vector) — The third vertex.
- `vert4` (Vector) — The fourth vertex.
- `color` (Color, default `Color( 255, 255, 255 )`) — The color of the quad.

[wiki](https://wiki.facepunch.com/gmod/render.DrawQuad)

---

### render.DrawQuadEasy · Client
`render.DrawQuadEasy(position: Vector, normal: Vector, width: number, height: number, color: Color, rotation: number = 0)`

Draws a quad. Expects material to be set by [render.SetMaterial](https://wiki.facepunch.com/gmod/render.SetMaterial).

**Arguments:**
- `position` (Vector) — Origin of the sprite.
- `normal` (Vector) — The face direction of the quad.
- `width` (number) — The width of the quad.
- `height` (number) — The height of the quad.
- `color` (Color) — The color of the quad.
- `rotation` (number, default `0`) — The rotation of the quad counter-clockwise in degrees around the normal axis.

[wiki](https://wiki.facepunch.com/gmod/render.DrawQuadEasy)

---

### render.DrawScreenQuad · Client
`render.DrawScreenQuad(applyPoster: boolean = false)`

Draws the current material set by [render.SetMaterial](https://wiki.facepunch.com/gmod/render.SetMaterial) to the whole screen. The color cannot be customized.

See also [render.DrawScreenQuadEx](https://wiki.facepunch.com/gmod/render.DrawScreenQuadEx).

**Arguments:**
- `applyPoster` (boolean, default `false`) — If set to true, when rendering a poster the quad will be properly drawn in parts in the poster.

[wiki](https://wiki.facepunch.com/gmod/render.DrawScreenQuad)

---

### render.DrawScreenQuadEx · Client
`render.DrawScreenQuadEx(startX: number, startY: number, width: number, height: number)`

Draws the current material set by [render.SetMaterial](https://wiki.facepunch.com/gmod/render.SetMaterial) to the area specified. Color cannot be customized.

See also [render.DrawScreenQuad](https://wiki.facepunch.com/gmod/render.DrawScreenQuad).

**Arguments:**
- `startX` (number) — X start position of the rect.
- `startY` (number) — Y start position of the rect.
- `width` (number) — Width of the rect.
- `height` (number) — Height of the rect.

[wiki](https://wiki.facepunch.com/gmod/render.DrawScreenQuadEx)

---

### render.DrawSphere · Client
`render.DrawSphere(position: Vector, radius: number, longitudeSteps: number, latitudeSteps: number, color: Color = Color( 255, 255, 255 ))`

Draws a sphere in 3D space. The material previously set with [render.SetMaterial](https://wiki.facepunch.com/gmod/render.SetMaterial) will be applied the sphere's surface.

See also [render.DrawWireframeSphere](https://wiki.facepunch.com/gmod/render.DrawWireframeSphere) for a wireframe equivalent.

**Arguments:**
- `position` (Vector) — Position of the sphere.
- `radius` (number) — Radius of the sphere.
- `longitudeSteps` (number) — The number of longitude steps.
- `latitudeSteps` (number) — The number of latitude steps.
- `color` (Color, default `Color( 255, 255, 255 )`) — The color of the sphere.

[wiki](https://wiki.facepunch.com/gmod/render.DrawSphere)

---

### render.DrawSprite · Client
`render.DrawSprite(position: Vector, width: number, height: number, color: Color = Color( 255, 255, 255 ))`

Draws a sprite in 3D space.

**Arguments:**
- `position` (Vector) — Position of the sprite.
- `width` (number) — Width of the sprite.
- `height` (number) — Height of the sprite.
- `color` (Color, default `Color( 255, 255, 255 )`) — Color of the sprite.

[wiki](https://wiki.facepunch.com/gmod/render.DrawSprite)

---

### render.DrawTextureToScreen · Client
`render.DrawTextureToScreen(tex: ITexture)`

Draws a texture over the whole screen.

**Arguments:**
- `tex` (ITexture) — The texture to draw.

[wiki](https://wiki.facepunch.com/gmod/render.DrawTextureToScreen) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/render.lua#L147-L155)

---

### render.DrawTextureToScreenRect · Client
`render.DrawTextureToScreenRect(tex: ITexture, x: number, y: number, width: number, height: number)`

Draws a textured rectangle.

**Arguments:**
- `tex` (ITexture) — The texture to draw.
- `x` (number) — The x coordinate of the rectangle to draw.
- `y` (number) — The y coordinate of the rectangle to draw.
- `width` (number) — The width of the rectangle to draw.
- `height` (number) — The height of the rectangle to draw.

[wiki](https://wiki.facepunch.com/gmod/render.DrawTextureToScreenRect) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/render.lua#L157-L165)

---

### render.DrawWireframeBox · Client
`render.DrawWireframeBox(position: Vector, angle: Angle, mins: Vector, maxs: Vector, color: Color = Color( 255, 255, 255 ), writeZ: boolean = false)`

Draws a wireframe box in 3D space.

**Arguments:**
- `position` (Vector) — Position of the box.
- `angle` (Angle) — Angles of the box.
- `mins` (Vector) — The lowest corner of the box.
- `maxs` (Vector) — The highest corner of the box.
- `color` (Color, default `Color( 255, 255, 255 )`) — The color of the box.
- `writeZ` (boolean, default `false`) — Sets whenever to write to the zBuffer.

[wiki](https://wiki.facepunch.com/gmod/render.DrawWireframeBox)

---

### render.DrawWireframeSphere · Client
`render.DrawWireframeSphere(position: Vector, radius: number, longitudeSteps: number, latitudeSteps: number, color: Color = Color( 255, 255, 255 ), writeZ: boolean = false)`

Draws a wireframe sphere in 3d space.

**Arguments:**
- `position` (Vector) — Position of the sphere.
- `radius` (number) — The size of the sphere.
- `longitudeSteps` (number) — The amount of longitude steps.
- `latitudeSteps` (number) — The amount of latitude steps.
- `color` (Color, default `Color( 255, 255, 255 )`) — The color of the wireframe.
- `writeZ` (boolean, default `false`) — Whether or not to consider the Z buffer.

[wiki](https://wiki.facepunch.com/gmod/render.DrawWireframeSphere)

---

### render.EnableClipping · Client, Menu
`render.EnableClipping(state: boolean) → boolean`

Sets the status of the clip renderer, returning previous state.

**Arguments:**
- `state` (boolean) — New clipping state.

**Returns:**
- boolean — Previous clipping state.

> **Warning:** To prevent unintended rendering behavior of other mods/the game, you must reset the clipping state to its previous value.

[wiki](https://wiki.facepunch.com/gmod/render.EnableClipping)

---

### render.EndBeam · Client
`render.EndBeam()`

Ends the beam mesh of a beam started with [render.StartBeam](https://wiki.facepunch.com/gmod/render.StartBeam).
		
		For more detailed information on Beams, as well as usage examples, see the [Beams Render Reference](https://wiki.facepunch.com/gmod/render_beams).

[wiki](https://wiki.facepunch.com/gmod/render.EndBeam)

---

### render.FogColor · Client
`render.FogColor(red: number, green: number, blue: number)`

Sets the color of the fog.

**Arguments:**
- `red` (number) — Red channel of the fog color, 0 - 255.
- `green` (number) — Green channel of the fog color, 0 - 255.
- `blue` (number) — Blue channel of the fog color, 0 - 255.

[wiki](https://wiki.facepunch.com/gmod/render.FogColor)

---

### render.FogEnd · Client
`render.FogEnd(distance: number)`

Sets the at which the fog reaches its max density.

**Arguments:**
- `distance` (number) — The distance at which the fog reaches its max density.

[wiki](https://wiki.facepunch.com/gmod/render.FogEnd)

---

### render.FogMaxDensity · Client
`render.FogMaxDensity(maxDensity: number)`

Sets the maximum density of the fog.

**Arguments:**
- `maxDensity` (number) — The maximum density of the fog, 0-1.

[wiki](https://wiki.facepunch.com/gmod/render.FogMaxDensity)

---

### render.FogMode · Client
`render.FogMode(fogMode: number{MATERIAL_FOG})`

Sets the mode of fog.

**Arguments:**
- `fogMode` (number{MATERIAL_FOG}) — Fog mode, see MATERIAL_FOG.

[wiki](https://wiki.facepunch.com/gmod/render.FogMode)

---

### render.FogStart · Client
`render.FogStart(fogStart: number)`

Sets the distance at which the fog starts showing up.

**Arguments:**
- `fogStart` (number) — The distance at which the fog starts showing up.

[wiki](https://wiki.facepunch.com/gmod/render.FogStart)

---

### render.GetAmbientLightColor · Client
`render.GetAmbientLightColor() → Vector`

Returns the ambient color of the map.

**Returns:**
- Vector — The ambient color of the map.

[wiki](https://wiki.facepunch.com/gmod/render.GetAmbientLightColor)

---

### render.GetBlend · Client
`render.GetBlend() → number`

Returns the current alpha blending.

**Returns:**
- number — Current alpha blending in range 0 to 1.

[wiki](https://wiki.facepunch.com/gmod/render.GetBlend)

---

### render.GetBloomTex0 · Client · `INTERNAL`
`render.GetBloomTex0() → ITexture`

Returns the Render Target texture that is used internally for the [Bloom](https://wiki.facepunch.com/gmod/Global.DrawBloom) [Post Processing](https://wiki.facepunch.com/gmod/Post-Processing_Materials) effect.

**Returns:**
- ITexture — The render target texture named `s_pBloomTex0`.

[wiki](https://wiki.facepunch.com/gmod/render.GetBloomTex0)

---

### render.GetBloomTex1 · Client · `INTERNAL`
`render.GetBloomTex1() → ITexture`

Returns the Render Target texture used internally for the [Blur](https://wiki.facepunch.com/gmod/render.BlurRenderTarget) [Post Processing](https://wiki.facepunch.com/gmod/Post-Processing_Materials) effect.

Despite its name, this function is not used for the [Bloom](https://wiki.facepunch.com/gmod/Global.DrawBloom) effect.

**Returns:**
- ITexture — The render target texture named `s_pBloomTex1`.

[wiki](https://wiki.facepunch.com/gmod/render.GetBloomTex1)

---

### render.GetColorModulation · Client
`render.GetColorModulation() → number, number, number`

Returns the current color modulation values as normals.

**Returns:**
- number — Red part of the color.
- number — Green part of the color.
- number — Blue part of the color.

[wiki](https://wiki.facepunch.com/gmod/render.GetColorModulation)

---

### render.GetDXLevel · Client, Menu
`render.GetDXLevel() → number`

Returns the maximum available directX version.

**Returns:**
- number — The directX version.

[wiki](https://wiki.facepunch.com/gmod/render.GetDXLevel)

---

### render.GetFogColor · Client
`render.GetFogColor() → number, number, number`

Returns the current fog color.

**Returns:**
- number — Red part of the color.
- number — Green part of the color
- number — Blue part of the color

[wiki](https://wiki.facepunch.com/gmod/render.GetFogColor)

---

### render.GetFogDistances · Client
`render.GetFogDistances() → number, number, number`

Returns the fog start and end distance.

**Returns:**
- number — Fog start distance set by render.FogStart.
- number — For end distance set by render.FogEnd.
- number — Fog Z distance set by render.SetFogZ.

[wiki](https://wiki.facepunch.com/gmod/render.GetFogDistances)

---

### render.GetFogMaxDensity · Client
`render.GetFogMaxDensity() → number`

Get the maximum density of the fog.

**Returns:**
- `maxDensity` (number) — The maximum density of the fog, 0-1.

[wiki](https://wiki.facepunch.com/gmod/render.GetFogMaxDensity)

---

### render.GetFogMode · Client
`render.GetFogMode() → number`

Returns the current fog mode.

**Returns:**
- number — Fog mode, see MATERIAL_FOG.

[wiki](https://wiki.facepunch.com/gmod/render.GetFogMode)

---

### render.GetFullScreenDepthTexture · Client · `DEPRECATED`
`render.GetFullScreenDepthTexture() → ITexture`

Returns the full screen depth texture.

**Returns:**
- ITexture — The `_rt_FullFrameDepth` texture, which is an alias of `_rt_PowerOfTwoFB` on PC.

[wiki](https://wiki.facepunch.com/gmod/render.GetFullScreenDepthTexture)

---

### render.GetHDREnabled · Client, Menu
`render.GetHDREnabled() → boolean`

Returns whether HDR is currently enabled or not. This takes into account hardware support, current map and current client settings.

**Returns:**
- boolean — `true` if the player currently has HDR enabled.

[wiki](https://wiki.facepunch.com/gmod/render.GetHDREnabled)

---

### render.GetLightColor · Client
`render.GetLightColor(position: Vector) → Vector`

Gets the light exposure on the specified position.

**Arguments:**
- `position` (Vector) — The position of the surface to get the light from.

**Returns:**
- Vector — The light color.

[wiki](https://wiki.facepunch.com/gmod/render.GetLightColor)

---

### render.GetMoBlurTex0 · Client · `INTERNAL`
`render.GetMoBlurTex0() → ITexture`

Returns the first render target texture that is used internally for Motion Blur and Frame Blend post processing effects.

**Returns:**
- ITexture — The render target named `s_pMoBlurTex0`.

[wiki](https://wiki.facepunch.com/gmod/render.GetMoBlurTex0)

---

### render.GetMoBlurTex1 · Client · `INTERNAL`
`render.GetMoBlurTex1() → ITexture`

Returns the second render target texture that is used internally for Motion Blur and Frame Blend post processing effects.

**Returns:**
- ITexture — The render target named `s_pMoBlurTex1`.

[wiki](https://wiki.facepunch.com/gmod/render.GetMoBlurTex1)

---

### render.GetMorphTex0 · Client · `INTERNAL`
`render.GetMorphTex0() → ITexture`

Returns the first render target texture that was used internally for Morph post processing effect

The post processing effect was removed from the base game at some point during development of Garry's Mod 13, but can still be found as a community mod: https://steamcommunity.com/sharedfiles/filedetails/?id=501088470

**Returns:**
- ITexture — The render target texture named `s_pMorphTexture0`.

[wiki](https://wiki.facepunch.com/gmod/render.GetMorphTex0)

---

### render.GetMorphTex1 · Client · `INTERNAL`
`render.GetMorphTex1() → ITexture`

Returns the second render target texture that was used internally for Morph post processing effect.

See [render.GetMorphTex0](https://wiki.facepunch.com/gmod/render.GetMorphTex0) for more information..

**Returns:**
- ITexture — The render target texture named `s_pMorphTexture1`.

[wiki](https://wiki.facepunch.com/gmod/render.GetMorphTex1)

---

### render.GetPowerOfTwoTexture · Client
`render.GetPowerOfTwoTexture() → ITexture`

Returns the Power Of Two Frame Buffer texture.

**Returns:**
- ITexture — The power of two texture, which is `_rt_PowerOfTwoFB` by default.

[wiki](https://wiki.facepunch.com/gmod/render.GetPowerOfTwoTexture)

---

### render.GetRefractTexture · Client · `DEPRECATED`
`render.GetRefractTexture() → ITexture`

Alias of [render.GetPowerOfTwoTexture](https://wiki.facepunch.com/gmod/render.GetPowerOfTwoTexture).

**Returns:**
- ITexture — The render.GetPowerOfTwoTexture.

[wiki](https://wiki.facepunch.com/gmod/render.GetRefractTexture)

---

### render.GetRenderTarget · Client
`render.GetRenderTarget() → ITexture`

Returns the currently active render target.

Instead of saving the current render target using this function and restoring to it later, it is generally better practice to use [render.PushRenderTarget](https://wiki.facepunch.com/gmod/render.PushRenderTarget) and [render.PopRenderTarget](https://wiki.facepunch.com/gmod/render.PopRenderTarget).

**Returns:**
- ITexture — The currently active Render Target.

[wiki](https://wiki.facepunch.com/gmod/render.GetRenderTarget)

---

### render.GetResolvedFullFrameDepth · Client
`render.GetResolvedFullFrameDepth() → ITexture`

Returns the `_rt_ResolvedFullFrameDepth` texture for SSAO depth. It will only be updated if [GM:NeedsDepthPass](https://wiki.facepunch.com/gmod/GM:NeedsDepthPass) returns true. Depth is written using the [Shaders/DepthWrite](https://wiki.facepunch.com/gmod/Shaders/DepthWrite) by rendering scene a second time, using [SSAO_DepthPass function](https://github.com/ValveSoftware/source-sdk-2013/blob/11a677c349b149b2f77184dc903e6bb17f8df69b/src/game/client/viewrender.cpp#L5576).

**Returns:**
- ITexture — The depth texture.

[wiki](https://wiki.facepunch.com/gmod/render.GetResolvedFullFrameDepth)

---

### render.GetScreenEffectTexture · Client
`render.GetScreenEffectTexture(textureIndex: number = 0) → ITexture`

Obtain an [ITexture](https://wiki.facepunch.com/gmod/ITexture) of the screen. You must call [render.UpdateScreenEffectTexture](https://wiki.facepunch.com/gmod/render.UpdateScreenEffectTexture) in order to update this texture with the currently rendered scene.

This texture is mainly used within [GM:RenderScreenspaceEffects](https://wiki.facepunch.com/gmod/GM:RenderScreenspaceEffects).

**Arguments:**
- `textureIndex` (number, default `0`) — Max index is 3, but engine only creates the first two for you.

**Returns:**
- ITexture — The requested texture.

[wiki](https://wiki.facepunch.com/gmod/render.GetScreenEffectTexture)

---

### render.GetSmallTex0 · Client
`render.GetSmallTex0() → ITexture`

Returns the first quarter sized frame buffer texture.

**Returns:**
- ITexture — The render target texture named `_rt_SmallFB0`.

[wiki](https://wiki.facepunch.com/gmod/render.GetSmallTex0)

---

### render.GetSmallTex1 · Client
`render.GetSmallTex1() → ITexture`

Returns the second quarter sized frame buffer texture.

**Returns:**
- ITexture — The render target texture named `_rt_SmallFB1`.

[wiki](https://wiki.facepunch.com/gmod/render.GetSmallTex1)

---

### render.GetSuperFPTex · Client
`render.GetSuperFPTex() → ITexture`

Returns a floating point texture (RGBA16161616F format) the same resolution as the screen.

**Returns:**
- ITexture — Render target named `__rt_SuperTexture1`.

> **Note:** The [gmodscreenspace](https://wiki.facepunch.com/gmod/Shaders/gmodscreenspace) doesn't behave as expected when drawing a floating-point texture to an integer texture (e.g. the default render target). Use an UnlitGeneric material instead

[wiki](https://wiki.facepunch.com/gmod/render.GetSuperFPTex)

---

### render.GetSuperFPTex2 · Client
`render.GetSuperFPTex2() → ITexture`

See [render.GetSuperFPTex](https://wiki.facepunch.com/gmod/render.GetSuperFPTex).

**Returns:**
- ITexture — Render target named `__rt_SuperTexture2`.

[wiki](https://wiki.facepunch.com/gmod/render.GetSuperFPTex2)

---

### render.GetSurfaceColor · Client
`render.GetSurfaceColor(startPos: Vector, endPos: Vector) → Vector`

Performs a render trace and returns the color of the surface hit, this uses a low res version of the texture.

**Arguments:**
- `startPos` (Vector) — The start position to trace from.
- `endPos` (Vector) — The end position of the trace.

**Returns:**
- Vector — The surface color.

[wiki](https://wiki.facepunch.com/gmod/render.GetSurfaceColor)

---

### render.GetToneMappingScaleLinear · Client
`render.GetToneMappingScaleLinear() → Vector`

Returns a vector representing linear tone mapping scale. See [render.SetToneMappingScaleLinear](https://wiki.facepunch.com/gmod/render.SetToneMappingScaleLinear) for details.

**Returns:**
- `scales` (Vector) — The tonemapping scales.

[wiki](https://wiki.facepunch.com/gmod/render.GetToneMappingScaleLinear)

---

### render.GetViewSetup · Client
`render.GetViewSetup(noPlayer: boolean = false) → table`

Returns the current view setup.

**Arguments:**
- `noPlayer` (boolean, default `false`) — If `true`, returns the `view->GetViewSetup`, if `false` - returns `view->GetPlayerViewSetup`.

**Returns:**
- table — Current current view setup.

[wiki](https://wiki.facepunch.com/gmod/render.GetViewSetup)

---

### render.IsTakingScreenshot · Client
`render.IsTakingScreenshot() → boolean`

Lets you know when a screenshot is being taken during rendering hooks.

This is useful to hide certain visual elements from screenshots, such as debug overlays, helper objects, etc.

**Returns:**
- boolean — Returns `true` when a screenshot is being taken.

[wiki](https://wiki.facepunch.com/gmod/render.IsTakingScreenshot)

---

### render.MaterialOverride · Client
`render.MaterialOverride(material: IMaterial|nil = nil)`

Sets the render material override for all next calls of [Entity:DrawModel](https://wiki.facepunch.com/gmod/Entity:DrawModel). Also overrides [render.MaterialOverrideByIndex](https://wiki.facepunch.com/gmod/render.MaterialOverrideByIndex).

See [render.WorldMaterialOverride](https://wiki.facepunch.com/gmod/render.WorldMaterialOverride), [render.BrushMaterialOverride](https://wiki.facepunch.com/gmod/render.BrushMaterialOverride) and [render.ModelMaterialOverride](https://wiki.facepunch.com/gmod/render.ModelMaterialOverride) for similar functions.

**Arguments:**
- `material` (IMaterial|nil, default `nil`) — The material to use as override, use `nil` to disable.

> **Warning:** In certain scenarios such as during entity's shadow pass, using this function can cause unexpected side effects. See example below on how to deal with this.

[wiki](https://wiki.facepunch.com/gmod/render.MaterialOverride)

---

### render.MaterialOverrideByIndex · Client
`render.MaterialOverrideByIndex(index: number = nil, material: IMaterial = nil)`

Similar to [render.MaterialOverride](https://wiki.facepunch.com/gmod/render.MaterialOverride), but overrides the materials per index. For simple entities you may want to just use [Entity:SetSubMaterial](https://wiki.facepunch.com/gmod/Entity:SetSubMaterial).

[render.MaterialOverride](https://wiki.facepunch.com/gmod/render.MaterialOverride) overrides effects of this function.

**Arguments:**
- `index` (number, default `nil`) — The index of the material to override, in range of 0 to 31.
- `material` (IMaterial, default `nil`) — The material to override with, `nil` will reset the override for given index.

[wiki](https://wiki.facepunch.com/gmod/render.MaterialOverrideByIndex)

---

### render.MaxTextureHeight · Client, Menu
`render.MaxTextureHeight() → number`

Returns the maximum texture height the renderer can handle.

**Returns:**
- number — The max height.

[wiki](https://wiki.facepunch.com/gmod/render.MaxTextureHeight)

---

### render.MaxTextureWidth · Client, Menu
`render.MaxTextureWidth() → number`

Returns the maximum texture width the renderer can handle.

**Returns:**
- number — The max width.

[wiki](https://wiki.facepunch.com/gmod/render.MaxTextureWidth)

---

### render.Model · Client
`render.Model(settings: table, ent: CSEnt = nil)`

Creates a new [ClientsideModel](https://wiki.facepunch.com/gmod/Global.ClientsideModel), renders it at the specified pos/ang, and removes it. Can also be given an existing [CSEnt](https://wiki.facepunch.com/gmod/CSEnt) to reuse instead.

**Arguments:**
- `settings` (table) — Requires: * string model - The model to draw.
- `ent` (CSEnt, default `nil`) — If provided, this entity will be reused instead of creating a new one with ClientsideModel.

> **Note:** This function is only meant to be used in a single render pass kind of scenario, if you need to render a model continuously, use a cached [ClientsideModel](https://wiki.facepunch.com/gmod/Global.ClientsideModel) and provide it as a second argument.
> **Bug** ([#2688](https://github.com/Facepunch/garrysmod/issues/2688)): Using this with a map model ([game.GetWorld](https://wiki.facepunch.com/gmod/game.GetWorld)():[GetModel](https://wiki.facepunch.com/gmod/Entity:GetModel)()) crashes the game.

[wiki](https://wiki.facepunch.com/gmod/render.Model) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/render.lua#L174-L198)

---

### render.ModelMaterialOverride · Client
`render.ModelMaterialOverride(material: IMaterial = nil)`

Forces all future draw operations to use a specific [IMaterial](https://wiki.facepunch.com/gmod/IMaterial).  
		
		Because this is independent of a specific [Entity](https://wiki.facepunch.com/gmod/Entity), it can be used to change materials on static models that are part of maps.

**Arguments:**
- `material` (IMaterial, default `nil`) — The IMaterial that will be used for all upcoming draw operations, or `nil` to stop overriding.

> **Warning:** In certain scenarios such as during entity's shadow pass, using this function can cause unexpected side effects. See example on [render.MaterialOverride](https://wiki.facepunch.com/gmod/render.MaterialOverride) about dealing with this.

[wiki](https://wiki.facepunch.com/gmod/render.ModelMaterialOverride)

---

### render.OverrideAlphaWriteEnable · Client, Menu
`render.OverrideAlphaWriteEnable(enable: boolean, shouldWrite: boolean = nil)`

Overrides the write behaviour of all next rendering operations towards the alpha channel of the current render target.

See also [render.OverrideBlend](https://wiki.facepunch.com/gmod/render.OverrideBlend).

**Arguments:**
- `enable` (boolean) — Enable or disable the override.
- `shouldWrite` (boolean, default `nil`) — If the previous argument is true, sets whether the next rendering operations should write to the alpha channel or not.

> **Note:** Doing [surface](https://wiki.facepunch.com/gmod/surface) draw calls with alpha set to 0 is a no-op and will never have any effect.

[wiki](https://wiki.facepunch.com/gmod/render.OverrideAlphaWriteEnable)

---

### render.OverrideBlend · Client, Menu
`render.OverrideBlend(enabled: boolean, sourceMultiplier: number{BLEND}, destinationMultiplier: number{BLEND}, blendingFunction: number{BLENDFUNC}, enabled: boolean, sourceColorMultiplier: number{BLEND}, destinationColorMultiplier: number{BLEND}, colorBlendingFunction: number{BLENDFUNC}, sourceAlphaMultiplier: number{BLEND} = none, destinationAlphaMultiplier: number{BLEND} = none, alphaBlendingFunction: number{BLENDFUNC} = none, enabled: boolean)`

Overrides the way that the final color and alpha is calculated for each pixel affected by upcoming draw operations.

When a draw operation is performed, the rendering system examines each pixel that is affected by the draw operation and determines its new color by combining (or "Blending") the pixel's current color (Called the "Destination" or "Dst" color) with the new color produced by the draw operation (Called the "Source" or "Src" color.)

This function allows you to control the way that those two colors (The Source and Destination) are combined to produce the final pixel color.

It's important to know that while [Colors](https://wiki.facepunch.com/gmod/Global.Color) use values in the range `(0-255)`, the color and alpha values used here are normalized to the range `(0-1)` so that they can be multiplied together to produce a value that is still in the range `(0-1)`.

**Arguments:**
- `enabled` (boolean) — Set to `true` to enable Blend Overrides.
- `sourceMultiplier` (number{BLEND}) — This determines which value each affected pixel's Source color and alpha will be multiplied by before they are sent to the Blending Function.
- `destinationMultiplier` (number{BLEND}) — This determines which value each affected pixel's Destination color and alpha will be multiplied by before they are sent to the Blending Function.
- `blendingFunction` (number{BLENDFUNC}) — After the Source and Destination color and alpha have been multiplied against their corresponding multipliers, they are passed to the Blending Function which combines them into the final color and alpha for the pixel.
- `enabled` (boolean) — Set to `true` to enable Blend Overrides.
- `sourceColorMultiplier` (number{BLEND}) — This determines which value each affected pixel's Source color will be multiplied by before they are sent to the Color Blending Function.
- `destinationColorMultiplier` (number{BLEND}) — This determines which value each affected pixel's Destination color will be multiplied by before they are sent to the Color Blending Function.
- `colorBlendingFunction` (number{BLENDFUNC}) — After the Source and Destination colors have been multiplied against their corresponding multipliers, they are passed to the Color Blending Function which combines them into the final color and alpha for the pixel.
- `sourceAlphaMultiplier` (number{BLEND}, default `none`) — This determines which value each affected pixel's Source alpha will be multiplied by before they are sent to the Alpha Blending Function.
- `destinationAlphaMultiplier` (number{BLEND}, default `none`) — This determines which value each affected pixel's Destination alpha will be multiplied by before they are sent to the Alpha Blending Function.
- `alphaBlendingFunction` (number{BLENDFUNC}, default `none`) — After the Source and Destination alphas have been multiplied against their corresponding multipliers, they are passed to the Alpha Blending Function which combines them into the final alpha for the pixel.
- `enabled` (boolean) — Set to `false` to disable blend overrides.

[wiki](https://wiki.facepunch.com/gmod/render.OverrideBlend)

---

### render.OverrideBlendFunc · Client, Menu · `DEPRECATED`
`render.OverrideBlendFunc(enabled: boolean, srcBlend: number, destBlend: number, srcBlendAlpha: number = nil, destBlendAlpha: number = nil)`

Overrides the internal graphical functions used to determine the final color and alpha of a rendered texture.

See also [render.OverrideAlphaWriteEnable](https://wiki.facepunch.com/gmod/render.OverrideAlphaWriteEnable).

**Arguments:**
- `enabled` (boolean) — true to enable, false to disable.
- `srcBlend` (number, enum [BLEND](https://wiki.facepunch.com/gmod/Enums/BLEND)) — The source color blend function BLEND.
- `destBlend` (number)
- `srcBlendAlpha` (number, default `nil`, enum [BLEND](https://wiki.facepunch.com/gmod/Enums/BLEND)) — The source alpha blend function BLEND.
- `destBlendAlpha` (number, default `nil`)

> **Note:** Doing [surface](https://wiki.facepunch.com/gmod/surface) draw calls with alpha set to 0 is a no-op and will never have any effect.

[wiki](https://wiki.facepunch.com/gmod/render.OverrideBlendFunc)

---

### render.OverrideColorWriteEnable · Client, Menu
`render.OverrideColorWriteEnable(enable: boolean, shouldWrite: boolean)`

Overrides the write behaviour of all next rendering operations towards the color channel of the current render target.

**Arguments:**
- `enable` (boolean) — Enable or disable the override.
- `shouldWrite` (boolean) — If the previous argument is true, sets whether the next rendering operations should write to the color channel or not.

[wiki](https://wiki.facepunch.com/gmod/render.OverrideColorWriteEnable)

---

### render.OverrideDepthEnable · Client, Menu
`render.OverrideDepthEnable(enable: boolean, shouldWrite: boolean)`

Overrides the write behaviour of all next rendering operations towards the depth buffer.

**Arguments:**
- `enable` (boolean) — Enable or disable the override.
- `shouldWrite` (boolean) — If the previous argument is true, sets whether the next rendering operations should write to the depth buffer or not.

[wiki](https://wiki.facepunch.com/gmod/render.OverrideDepthEnable)

---

### render.PerformFullScreenStencilOperation · Client, Menu
`render.PerformFullScreenStencilOperation()`

Performs a Stencil operation on every pixel in the active [Render Target](https://wiki.facepunch.com/gmod/render_rendertargets) without performing a draw operation.

		For more detailed information on the Stencil system, including usage examples, see the [Stencils Render Reference](https://wiki.facepunch.com/gmod/render_stencils) page.

[wiki](https://wiki.facepunch.com/gmod/render.PerformFullScreenStencilOperation)

---

### render.PopCustomClipPlane · Client, Menu
`render.PopCustomClipPlane()`

Removes the current active clipping plane from the clip plane stack.

[wiki](https://wiki.facepunch.com/gmod/render.PopCustomClipPlane)

---

### render.PopFilterMag · Client, Menu
`render.PopFilterMag()`

Pops (Removes) the texture filter most recently pushed (Added) onto the magnification texture filter stack.  
		
		This function should only be called *after* a magnification filter has been pushed via [render.PushFilterMag](https://wiki.facepunch.com/gmod/render.PushFilterMag).

		For more detailed information and a usage example, see [the texture minification and magnification render reference.](https://wiki.facepunch.com/gmod/render_min_mag_filters)

[wiki](https://wiki.facepunch.com/gmod/render.PopFilterMag)

---

### render.PopFilterMin · Client, Menu
`render.PopFilterMin()`

Pops (Removes) the texture filter most recently pushed (Added) onto the minification texture filter stack.  
		
		This function should only be called *after* a minification filter has been pushed via [render.PushFilterMin()](https://wiki.facepunch.com/gmod/render.PushFilterMin).

		For more detailed information and a usage example, see [the texture minification and magnification render reference.](https://wiki.facepunch.com/gmod/render_min_mag_filters)

[wiki](https://wiki.facepunch.com/gmod/render.PopFilterMin)

---

### render.PopFlashlightMode · Client
`render.PopFlashlightMode()`

Pops the current flashlight mode from the flashlight mode stack.

[wiki](https://wiki.facepunch.com/gmod/render.PopFlashlightMode)

---

### render.PopRenderTarget · Client
`render.PopRenderTarget()`

Pops the last render target and viewport from the RT stack and sets them as the current render target and viewport.

This is should be called to restore the previous render target and viewport after a call to [render.PushRenderTarget](https://wiki.facepunch.com/gmod/render.PushRenderTarget).

[wiki](https://wiki.facepunch.com/gmod/render.PopRenderTarget)

---

### render.PushCustomClipPlane · Client, Menu
`render.PushCustomClipPlane(normal: Vector, distance: number)`

Pushes a new clipping plane of the clip plane stack and sets it as active.

**Arguments:**
- `normal` (Vector) — The normal of the clipping plane.
- `distance` (number) — The distance of the plane from the world origin.

> **Bug** ([#2687](https://github.com/Facepunch/garrysmod/issues/2687)): A max of 2 clip planes are supported on Linux/POSIX, and 6 on Windows.

[wiki](https://wiki.facepunch.com/gmod/render.PushCustomClipPlane)

---

### render.PushFilterMag · Client, Menu
`render.PushFilterMag(texFilterType: number)`

Pushes (Adds) a texture filter onto the magnification texture filter stack.  
		This will modify how textures are stretched to sizes larger than their native resolution for upcoming rendering and drawing operations.  
		For a version of this same function that modifies filtering for texture sizes smaller than their native resolution, see [render.PushFilterMin](https://wiki.facepunch.com/gmod/render.PushFilterMin)

		Always be sure to call [render.PopFilterMag](https://wiki.facepunch.com/gmod/render.PopFilterMag) afterwards to avoid texture filtering problems.

		For more detailed information and a usage example, see [the texture minification and magnification render reference.](https://wiki.facepunch.com/gmod/render_min_mag_filters)

If current texture has more than 1 mipmap, this also sets the mipmap filter.

**Arguments:**
- `texFilterType` (number, enum [TEXFILTER](https://wiki.facepunch.com/gmod/Enums/TEXFILTER)) — The texture filter to use.

[wiki](https://wiki.facepunch.com/gmod/render.PushFilterMag)

---

### render.PushFilterMin · Client, Menu
`render.PushFilterMin(texFilterType: number)`

Pushes (Adds) a texture filter onto the minification texture filter stack.  
		This will modify how textures are compressed to a lower resolution than their native resolution for upcoming rendering and drawing operations.  
		For a version of this same function that modifies filtering for texture sizes larger than their native resolution, see [render.PushFilterMag()](https://wiki.facepunch.com/gmod/render.PushFilterMag)

		Always be sure to call [render.PopFilterMin()](https://wiki.facepunch.com/gmod/render.PopFilterMin) afterwards to avoid texture filtering problems.

		For more detailed information and a usage example, see [the texture minification and magnification render reference.](https://wiki.facepunch.com/gmod/render_min_mag_filters)

**Arguments:**
- `texFilterType` (number, enum [TEXFILTER](https://wiki.facepunch.com/gmod/Enums/TEXFILTER)) — The texture filter to use.

[wiki](https://wiki.facepunch.com/gmod/render.PushFilterMin)

---

### render.PushFlashlightMode · Client · `DEPRECATED`
`render.PushFlashlightMode(enable: boolean = false)`

Enables the flashlight projection for the upcoming rendering.

**Arguments:**
- `enable` (boolean, default `false`) — Whether the flashlight mode should be enabled or disabled.

[wiki](https://wiki.facepunch.com/gmod/render.PushFlashlightMode)

---

### render.PushRenderTarget · Client
`render.PushRenderTarget(texture: ITexture = nil, x: number = 0, y: number = 0, w: number = texture:Width(), h: number = texture:Height())`

Pushes the current render target and viewport to the RT stack then sets a new current render target and viewport. If the viewport is not specified, the dimensions of the render target are used instead.

This is similar to a call to [render.SetRenderTarget](https://wiki.facepunch.com/gmod/render.SetRenderTarget) and [render.SetViewPort](https://wiki.facepunch.com/gmod/render.SetViewPort) where the current render target and viewport have been saved beforehand, except the viewport isn't clipped to screen bounds.

See also [render.PopRenderTarget](https://wiki.facepunch.com/gmod/render.PopRenderTarget).

**Arguments:**
- `texture` (ITexture, default `nil`) — The new render target to be used.
- `x` (number, default `0`) — X origin of the viewport.
- `y` (number, default `0`) — Y origin of the viewport.
- `w` (number, default `texture:Width()`) — Width of the viewport.
- `h` (number, default `texture:Height()`) — Height of the viewport.

> **Note:** If you want to render to the render target in 2d mode and it is not the same size as the screen, use [cam.Start2D](https://wiki.facepunch.com/gmod/cam.Start2D) and [cam.End2D](https://wiki.facepunch.com/gmod/cam.End2D).
> **Note:** If the render target is bigger than the screen, rendering done with the surface library will be clipped to the screen bounds unless you call [DisableClipping](https://wiki.facepunch.com/gmod/Global.DisableClipping)

[wiki](https://wiki.facepunch.com/gmod/render.PushRenderTarget)

---

### render.ReadPixel · Client
`render.ReadPixel(x: number, y: number) → number, number, number, number`

Reads the color of the specified pixel from the RenderTarget sent by [render.CapturePixels](https://wiki.facepunch.com/gmod/render.CapturePixels)

**Arguments:**
- `x` (number) — The x coordinate.
- `y` (number) — The y coordinate.

**Returns:**
- `r` (number) — The red channel value.
- `g` (number) — The green channel value.
- `b` (number) — The blue channel value.
- `a` (number) — The alpha channel value or no value if the render target has no alpha channel.

[wiki](https://wiki.facepunch.com/gmod/render.ReadPixel)

---

### render.RedownloadAllLightmaps · Client
`render.RedownloadAllLightmaps(DoStaticProps: boolean = false, UpdateStaticLighting: boolean = false)`

This applies the changes made to map lighting using [engine.LightStyle](https://wiki.facepunch.com/gmod/engine.LightStyle).

**Arguments:**
- `DoStaticProps` (boolean, default `false`) — When true, this will also apply lighting changes to static props.
- `UpdateStaticLighting` (boolean, default `false`) — Forces all props to update their static lighting.

[wiki](https://wiki.facepunch.com/gmod/render.RedownloadAllLightmaps)

---

### render.RenderFlashlights · Client
`render.RenderFlashlights(renderFunc: function)`

Renders additive flashlights on an [IMesh](https://wiki.facepunch.com/gmod/IMesh), a direct replacement for [render.PushFlashlightMode](https://wiki.facepunch.com/gmod/render.PushFlashlightMode).

**Arguments:**
- `renderFunc` (function) — The function that renders the IMesh, or a model.

[wiki](https://wiki.facepunch.com/gmod/render.RenderFlashlights)

---

### render.RenderHUD · Client
`render.RenderHUD(x: number, y: number, w: number, h: number)`

Renders the HUD on the screen.

**Arguments:**
- `x` (number) — X position for the HUD draw origin.
- `y` (number) — Y position for the HUD draw origin.
- `w` (number) — Width of the HUD draw.
- `h` (number) — Height of the HUD draw.

[wiki](https://wiki.facepunch.com/gmod/render.RenderHUD)

---

### render.RenderView · Client
`render.RenderView(view: table = nil)`

Renders the scene with the specified viewData to the current active render target.

**Arguments:**
- `view` (table, default `nil`) — The view data to be used in the rendering.

> **Bug** ([#1330](https://github.com/Facepunch/garrysmod/issues/1330)): Static props and LODs are rendered improperly due to incorrectly perceived distance.
> **Bug:** Using render.RenderView on a RenderTarget texture in a 3d context like SWEP:PostDrawViewModel() while drawing the RenderTarget texture causes screen flickers.

[wiki](https://wiki.facepunch.com/gmod/render.RenderView)

---

### render.ResetModelLighting · Client
`render.ResetModelLighting(r: number, g: number, b: number)`

Resets the model lighting to the specified color.

Calls [render.SetModelLighting](https://wiki.facepunch.com/gmod/render.SetModelLighting) for every direction with given color.

**Arguments:**
- `r` (number) — The red part of the color, 0-1.
- `g` (number) — The green part of the color, 0-1.
- `b` (number) — The blue part of the color, 0-1.

[wiki](https://wiki.facepunch.com/gmod/render.ResetModelLighting)

---

### render.ResetToneMappingScale · Client
`render.ResetToneMappingScale(scale: number)`

Resets the HDR tone multiplier to the specified value.

This will only work on HDR maps, and the value will automatically fade to what it was ( or whatever [render.SetGoalToneMappingScale](https://wiki.facepunch.com/gmod/render.SetGoalToneMappingScale) is ) if called only once.

**Arguments:**
- `scale` (number) — The value which should be used as multiplier.

[wiki](https://wiki.facepunch.com/gmod/render.ResetToneMappingScale)

---

### render.SetAmbientLight · Client
`render.SetAmbientLight(r: number, g: number, b: number)`

Sets the ambient lighting for any upcoming render operation.

**Arguments:**
- `r` (number) — The red part of the color, 0-1.
- `g` (number) — The green part of the color, 0-1.
- `b` (number) — The blue part of the color, 0-1.

[wiki](https://wiki.facepunch.com/gmod/render.SetAmbientLight)

---

### render.SetBlend · Client
`render.SetBlend(blending: number)`

Sets the alpha blending (or transparency) for upcoming render operations.
	
See [render.SetColorModulation](https://wiki.facepunch.com/gmod/render.SetColorModulation) for the function to affect RGB color channels.

By itself, this will cause visible overlapping on parts of a model that are in front of other parts of the same model.  
For a solution to this, see the examples below.

**Arguments:**
- `blending` (number) — The alpha (transparency) for upcoming draw operations.

> **Note:** If a material has the [$alphatest](https://developer.valvesoftware.com/wiki/$alphatest) flag enabled then this function might not behave as expected because alpha will be binary, this has a default cutoff of `0.7`.
> **Bug** ([#3166](https://github.com/Facepunch/garrysmod/issues/3166)): This does not affect non-model `render.Draw*` functions.

[wiki](https://wiki.facepunch.com/gmod/render.SetBlend)

---

### render.SetColorMaterial · Client
`render.SetColorMaterial()`

Sets the current drawing material to "color".

The material is defined as:
```

 "UnlitGeneric"
 {
 	"$basetexture" "color/white"
 	"$model" 		1
 	"$translucent" 	1
 	"$vertexalpha" 	1
 	"$vertexcolor" 	1
 }
```

[wiki](https://wiki.facepunch.com/gmod/render.SetColorMaterial) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/render.lua#L73-L75)

---

### render.SetColorMaterialIgnoreZ · Client
`render.SetColorMaterialIgnoreZ()`

Sets the current drawing material to `color_ignorez`.

The material is defined as:
```

 "UnlitGeneric"
 {
 	"$basetexture" "color/white"
  	"$model" 		1
 	"$translucent" 	1
 	"$vertexalpha" 	1
 	"$vertexcolor" 	1
 	"$ignorez"		1
 }
```

[wiki](https://wiki.facepunch.com/gmod/render.SetColorMaterialIgnoreZ) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/render.lua#L79-L81)

---

### render.SetColorModulation · Client
`render.SetColorModulation(r: number, g: number, b: number)`

Sets the color modulation for upcoming render operations, such as rendering models.

The values can exceed 1 for stronger effect.

See [render.SetBlend](https://wiki.facepunch.com/gmod/render.SetBlend) for the function to affect alpha channel.

**Arguments:**
- `r` (number) — The red channel multiplier normal ranging from 0-1.
- `g` (number) — The green channel multiplier normal ranging from 0-1.
- `b` (number) — The blue channel multiplier normal ranging from 0-1.

[wiki](https://wiki.facepunch.com/gmod/render.SetColorModulation)

---

### render.SetFogZ · Client
`render.SetFogZ(fogZ: number)`

If the [fog mode](https://wiki.facepunch.com/gmod/render.FogMode) is set to [MATERIAL_FOG_LINEAR_BELOW_FOG_Z](https://wiki.facepunch.com/gmod/Enums/MATERIAL_FOG), the fog will only be rendered below the specified height.

**Arguments:**
- `fogZ` (number) — The fog Z.

[wiki](https://wiki.facepunch.com/gmod/render.SetFogZ)

---

### render.SetGoalToneMappingScale · Client
`render.SetGoalToneMappingScale(scale: number)`

Sets the goal HDR tone mapping scale.

Use this in a rendering/think hook as it is reset every frame.

**Arguments:**
- `scale` (number) — The target scale.

[wiki](https://wiki.facepunch.com/gmod/render.SetGoalToneMappingScale)

---

### render.SetLightingMode · Client
`render.SetLightingMode(Mode: number)`

Sets lighting mode when rendering something.

**Arguments:**
- `Mode` (number) — Lighting render mode.

> **Note:** **Do not forget to restore the default value** to avoid unexpected behavior, like the world and the HUD/UI being affected.

[wiki](https://wiki.facepunch.com/gmod/render.SetLightingMode)

---

### render.SetLightingOrigin · Client
`render.SetLightingOrigin(lightingOrigin: Vector)`

Sets lighting origin for the current model.

**Arguments:**
- `lightingOrigin` (Vector) — The position which will be used to calculate lighting for the current model.

[wiki](https://wiki.facepunch.com/gmod/render.SetLightingOrigin)

---

### render.SetLightmapTexture · Client
`render.SetLightmapTexture(tex: ITexture)`

Sets the texture to be used as the lightmap in upcoming rendering operations. This is required when rendering meshes using a material with a lightmapped shader such as LightmappedGeneric.

**Arguments:**
- `tex` (ITexture) — The texture to be used as the lightmap.

[wiki](https://wiki.facepunch.com/gmod/render.SetLightmapTexture)

---

### render.SetLocalModelLights · Client
`render.SetLocalModelLights(lights: table = {})`

Sets up the local lighting for any upcoming render operation. Up to 4 local lights can be defined, with one of three different types (point, directional, spot).

Disables all local lights if called with no arguments.

**Arguments:**
- `lights` (table, default `{}`) — A table containing up to 4 tables for each light source that should be set up.

[wiki](https://wiki.facepunch.com/gmod/render.SetLocalModelLights)

---

### render.SetMaterial · Client
`render.SetMaterial(mat: IMaterial)`

Sets the material to be used in any upcoming render operation using the [render](https://wiki.facepunch.com/gmod/render).

Not to be confused with [surface.SetMaterial](https://wiki.facepunch.com/gmod/surface.SetMaterial).

**Arguments:**
- `mat` (IMaterial) — The material to be used.

[wiki](https://wiki.facepunch.com/gmod/render.SetMaterial)

---

### render.SetModelLighting · Client
`render.SetModelLighting(lightDirection: number{BOX}, red: number, green: number, blue: number)`

Sets up the ambient lighting for any upcoming render operation. Ambient lighting can be seen as a cube enclosing the object to be drawn, each of its faces representing a directional light source that shines towards the object. Thus, there is a total of six different light sources that can be configured separately.

Light color components are not restricted to a specific range (i.e. 0-255), instead, higher values will result in a brighter light.

**Arguments:**
- `lightDirection` (number{BOX}) — The light source to edit, see BOX.
- `red` (number) — The red component of the light color.
- `green` (number) — The green component of the light color.
- `blue` (number) — The blue component of the light color.

[wiki](https://wiki.facepunch.com/gmod/render.SetModelLighting)

---

### render.SetRenderTarget · Client
`render.SetRenderTarget(texture: ITexture)`

Sets the render target to the specified rt.

**Arguments:**
- `texture` (ITexture) — The new render target to be used.

[wiki](https://wiki.facepunch.com/gmod/render.SetRenderTarget)

---

### render.SetRenderTargetEx · Client
`render.SetRenderTargetEx(rtIndex: number, texture: ITexture = nil)`

Sets the render target with the specified index of `COLOR[n]` to the specified rt, allowing you to work with [Multiple Render Targets (MRT)](https://learn.microsoft.com/en-us/windows/win32/direct3d9/multiple-render-targets). Since standard shaders don't use MRT, you might find this useful at [Shaders/screenspace_general](https://wiki.facepunch.com/gmod/Shaders/screenspace_general).

**Arguments:**
- `rtIndex` (number) — The index of output `COLOR[n]` semantics from pixel-shader.
- `texture` (ITexture, default `nil`) — The new render target to be used.

> **Note:** MRT doesn't work with 2D render functions like [render.DrawScreenQuad](https://wiki.facepunch.com/gmod/render.DrawScreenQuad). Instead, you can render a [render.DrawQuad](https://wiki.facepunch.com/gmod/render.DrawQuad) using [cam.Start2D](https://wiki.facepunch.com/gmod/cam.Start2D).
> **Warning:** If you try to render with MSAA and set the main RenderTarget with another RenderTarget, nothing will be rendered.
> 
> [Link to Direct3D 9 documentation on MRT](https://learn.microsoft.com/en-us/windows/win32/direct3d9/multiple-render-targets#:~:text=No%20antialiasing%20is%20supported)
> 
> `Multiple render targets have the following restrictions:`
> * *No antialiasing is supported.*

[wiki](https://wiki.facepunch.com/gmod/render.SetRenderTargetEx)

---

### render.SetScissorRect · Client, Menu
`render.SetScissorRect(startX: number, startY: number, endX: number, endY: number, enable: boolean)`

Sets a scissoring rectangle which limits the drawing area. (otherwise known as clipping)

**Arguments:**
- `startX` (number) — X start coordinate of the scissor rectangle in screen-space coordinates.
- `startY` (number) — Y start coordinate of the scissor rectangle in screen-space coordinates.
- `endX` (number) — X end coordinate of the scissor rectangle in screen-space coordinates.
- `endY` (number) — Y end coordinate of the scissor rectangle in screen-space coordinates.
- `enable` (boolean) — Enable or disable the scissor rect.

[wiki](https://wiki.facepunch.com/gmod/render.SetScissorRect)

---

### render.SetShadowColor · Client
`render.SetShadowColor(red: number, green: number, blue: number)`

Sets the shadow color.

**Arguments:**
- `red` (number) — The red channel of the shadow color.
- `green` (number) — The green channel of the shadow color.
- `blue` (number) — The blue channel of the shadow color.

[wiki](https://wiki.facepunch.com/gmod/render.SetShadowColor)

---

### render.SetShadowDirection · Client
`render.SetShadowDirection(shadowDirections: Vector)`

Sets the shadow projection direction.

**Arguments:**
- `shadowDirections` (Vector) — The new shadow direction.

[wiki](https://wiki.facepunch.com/gmod/render.SetShadowDirection)

---

### render.SetShadowDistance · Client
`render.SetShadowDistance(shadowDistance: number)`

Sets the maximum shadow projection range.

**Arguments:**
- `shadowDistance` (number) — The new maximum shadow distance.

[wiki](https://wiki.facepunch.com/gmod/render.SetShadowDistance)

---

### render.SetShadowsDisabled · Client
`render.SetShadowsDisabled(disable: boolean)`

Sets whether all shadow rendering should be disabled.

Internally sets `r_shadows_gamecontrol` convar, exactly like `shadow_control` does via its `SetShadowsDisabled` input.

**Arguments:**
- `disable` (boolean) — `true` to disable shadows, `false` to enable.

> **Bug:** Currently broken due to internal bug. Will be fixed in the next update, as of 15 Sept 2025.

[wiki](https://wiki.facepunch.com/gmod/render.SetShadowsDisabled)

---

### render.SetStencilCompareFunction · Client, Menu
`render.SetStencilCompareFunction(compareFunction: number{STENCILCOMPARISONFUNCTION})`

Sets the Compare Function that all pixels affected by a draw operation will have their Stencil Buffer value tested against.  

When not set to a static value like NEVER or ALWAYS, the Stencil Buffer value corresponding to each affected pixel will be compared against the current [Reference Value](https://wiki.facepunch.com/gmod/render.SetStencilReferenceValue).

Pixels that **Pass** the Compare Function check move on to the Depth Test, which determines if the draw operation will ultimately be allowed to overwrite the pixel's Color Channel, Stencil Buffer, and Depth Buffer values.

Pixels that **Fail** the Compare Function check have the [Fail Operation](https://wiki.facepunch.com/gmod/render.SetStencilFailOperation) performed on their Stencil Buffer value and do **not** have any of their Render Target layers modified by the draw operation.

For more detailed information on the Stencil system, including usage examples, see the [Stencils Render Reference](https://wiki.facepunch.com/gmod/render_stencils) page.

**Arguments:**
- `compareFunction` (number{STENCILCOMPARISONFUNCTION}) — The Compare Function that each affected pixel's Stencil Buffer value will be evaluated against during a draw operation.

[wiki](https://wiki.facepunch.com/gmod/render.SetStencilCompareFunction)

---

### render.SetStencilEnable · Client, Menu
`render.SetStencilEnable(newState: boolean)`

Enables or disables the Stencil system for future draw operations.

While enabled, all pixels affected by draw operations will have their corresponding values in the active [Render Target's](https://wiki.facepunch.com/gmod/render_rendertargets) Stencil Buffer compared against the current [Reference Value](https://wiki.facepunch.com/gmod/render.SetStencilReferenceValue) and their current Depth Buffer value compared against the depth of the corresponding pixel from the draw operation.  
Depending on the outcomes of these comparisons, one of either the [Pass](https://wiki.facepunch.com/gmod/render.SetStencilPassOperation), [Fail](https://wiki.facepunch.com/gmod/render.SetStencilFailOperation), or [Z-Fail](https://wiki.facepunch.com/gmod/render.SetStencilZFailOperation) operations is performed on the pixel's Stencil Buffer value.  
A pixel will only be updated in the active [Render Target](https://wiki.facepunch.com/gmod/render_rendertargets) if the [Pass Operation](https://wiki.facepunch.com/gmod/render.SetStencilPassOperation) is performed.

For more detailed information on the Stencil system, including usage examples, see the [Stencils Render Reference](https://wiki.facepunch.com/gmod/render_stencils) page.

**Arguments:**
- `newState` (boolean) — The new state.

> **Note:** The Stencil system's configuration does **not** reset automatically.  
> To prevent unexpected behavior, always manually ensure that the Stencil system is configured appropriately for your use-case after enabling it.

[wiki](https://wiki.facepunch.com/gmod/render.SetStencilEnable)

---

### render.SetStencilFailOperation · Client, Menu
`render.SetStencilFailOperation(failOperation: number{STENCILOPERATION})`

Sets the [Stencil Operation](https://wiki.facepunch.com/gmod/Enums/STENCILOPERATION) that will be performed on the Stencil Buffer values of pixels affected by draw operations if the [Compare Function](https://wiki.facepunch.com/gmod/render.SetStencilCompareFunction) did **not** [Pass](https://wiki.facepunch.com/gmod/render.SetStencilPassOperation) the pixel.  

		For more detailed information on the Stencil system, including usage examples, see the [Stencils Render Reference](https://wiki.facepunch.com/gmod/render_stencils) page.

**Arguments:**
- `failOperation` (number{STENCILOPERATION}) — The Stencil Operation to be performed if the Compare Function does not Pass a pixel.

[wiki](https://wiki.facepunch.com/gmod/render.SetStencilFailOperation)

---

### render.SetStencilPassOperation · Client, Menu
`render.SetStencilPassOperation(passOperation: number{STENCILOPERATION})`

Sets the [Stencil Operation](https://wiki.facepunch.com/gmod/Enums/STENCILOPERATION) that will be performed on the Stencil Buffer values of pixels affected by draw operations if the [Compare Function](https://wiki.facepunch.com/gmod/render.SetStencilCompareFunction) Passes the pixel.  

		For more detailed information on the Stencil system, including usage examples, see the [Stencils Render Reference](https://wiki.facepunch.com/gmod/render_stencils) page.

**Arguments:**
- `passOperation` (number{STENCILOPERATION}) — The Stencil Operation to be performed if the Compare Function Passes a pixel.

[wiki](https://wiki.facepunch.com/gmod/render.SetStencilPassOperation)

---

### render.SetStencilReferenceValue · Client, Menu
`render.SetStencilReferenceValue(referenceValue: number)`

Sets the Stencil system's Reference Value which is compared against each pixel's corresponding Stencil Buffer value in the [Compare Function](https://wiki.facepunch.com/gmod/render.SetStencilCompareFunction) and can be used to modify the Stencil Buffer value of those same pixels in the [Pass](https://wiki.facepunch.com/gmod/render.SetStencilPassOperation), [Fail](https://wiki.facepunch.com/gmod/render.SetStencilFailOperation), and [Z Fail](https://wiki.facepunch.com/gmod/render.SetStencilZFailOperation) operations.
		
		For more detailed information on the Stencil system, including usage examples, see the [Stencils Render Reference](https://wiki.facepunch.com/gmod/render_stencils) page.

**Arguments:**
- `referenceValue` (number) — The value that the Compare function and the pass, fail, and z-fail operations will use.

[wiki](https://wiki.facepunch.com/gmod/render.SetStencilReferenceValue)

---

### render.SetStencilTestMask · Client, Menu
`render.SetStencilTestMask(bitMask: number)`

Sets the unsigned 8-bit (`byte`) bitflag mask that will be bitwise ANDed with all values as they are read (tested) from the Stencil Buffer

		This can be considered a "niche" Stencil function as it is not required for many Stencil use-cases.

		This is a companion function to [render.SetStencilWriteMask](https://wiki.facepunch.com/gmod/render.SetStencilWriteMask) which modifies Stencil Buffer values as they are written.

		For more detailed information on the Stencil system, including usage examples, see the [Stencils Render Reference](https://wiki.facepunch.com/gmod/render_stencils) page.

**Arguments:**
- `bitMask` (number) — The 8-bit (`byte`) mask.

[wiki](https://wiki.facepunch.com/gmod/render.SetStencilTestMask)

---

### render.SetStencilWriteMask · Client, Menu
`render.SetStencilWriteMask(bitMask: number)`

Sets the unsigned 8-bit (`byte`) bitflag mask that will be bitwise ANDed with all values as they are written to the Stencil Buffer

		This can be considered a "niche" Stencil function as it is not required for many Stencil use-cases.

		This is a companion function to [render.SetStencilTestMask](https://wiki.facepunch.com/gmod/render.SetStencilTestMask) which modifies Stencil Buffer values as they are read.

		For more detailed information on the Stencil system, including usage examples, see the [Stencils Render Reference](https://wiki.facepunch.com/gmod/render_stencils) page.

**Arguments:**
- `bitMask` (number) — The 8-bit (`byte`) mask.

[wiki](https://wiki.facepunch.com/gmod/render.SetStencilWriteMask)

---

### render.SetStencilZFailOperation · Client, Menu
`render.SetStencilZFailOperation(zFailOperation: number{STENCILOPERATION})`

Sets the [Stencil Operation](https://wiki.facepunch.com/gmod/Enums/STENCILOPERATION) that will be performed on the Stencil Buffer values of pixels affected by draw operations if the [Compare Function](https://wiki.facepunch.com/gmod/render.SetStencilCompareFunction) Passed a given pixel, but it did **not** Pass the Depth Test.

		For more detailed information on the Stencil system, including usage examples, see the [Stencils Render Reference](https://wiki.facepunch.com/gmod/render_stencils) page.

**Arguments:**
- `zFailOperation` (number{STENCILOPERATION}) — The Stencil Operation to be performed if the Compare Function Passes a pixel, but the pixel fails the Depth Test.

[wiki](https://wiki.facepunch.com/gmod/render.SetStencilZFailOperation)

---

### render.SetToneMappingScaleLinear · Client
`render.SetToneMappingScaleLinear(scales: Vector)`

Sets the tone mapping scale for upcoming rendering operations.

**Arguments:**
- `scales` (Vector) — The tonemapping scales.

[wiki](https://wiki.facepunch.com/gmod/render.SetToneMappingScaleLinear)

---

### render.SetViewPort · Client, Menu
`render.SetViewPort(x: number, y: number, w: number, h: number)`

Changes the view port position and size. The values will be clamped to the game's screen resolution.

If you are looking to render something to a texture (render target), you should use [render.PushRenderTarget](https://wiki.facepunch.com/gmod/render.PushRenderTarget).

**Arguments:**
- `x` (number) — X origin of the view port.
- `y` (number) — Y origin of the view port.
- `w` (number) — Width of the view port.
- `h` (number) — Height of the view port.

> **Note:** This function will override values of [ScrW](https://wiki.facepunch.com/gmod/Global.ScrW) and [ScrH](https://wiki.facepunch.com/gmod/Global.ScrH) with the ones you set.

[wiki](https://wiki.facepunch.com/gmod/render.SetViewPort)

---

### render.SetWriteDepthToDestAlpha · Client
`render.SetWriteDepthToDestAlpha(enable: boolean)`

Sets the internal parameter **INT_RENDERPARM_WRITE_DEPTH_TO_DESTALPHA**.

**Arguments:**
- `enable` (boolean)

[wiki](https://wiki.facepunch.com/gmod/render.SetWriteDepthToDestAlpha)

---

### render.Spin · Client
`render.Spin()`

Swaps the frame buffers/cycles the frame. In other words, this updates the screen.

If you take a really long time during a single frame render, it is a good idea to use this and let the user know that the game isn't stuck.

[wiki](https://wiki.facepunch.com/gmod/render.Spin)

---

### render.StartBeam · Client
`render.StartBeam(segmentCount: number)`

Begin drawing a multi-segment Beam.

			For more detailed information on Beams, as well as usage examples, see the [Beams Render Reference](https://wiki.facepunch.com/gmod/render_beams).

**Arguments:**
- `segmentCount` (number) — The number of Beam Segments that this multi-segment Beam will contain.

[wiki](https://wiki.facepunch.com/gmod/render.StartBeam)

---

### render.SupportsHDR · Client, Menu
`render.SupportsHDR() → boolean`

Returns whether the player's hardware supports HDR. (High Dynamic Range) HDR can still be disabled by the `mat_hdr_level` console variable or just not be supported by the map.

**Returns:**
- boolean — `true` if the player's hardware supports HDR.

[wiki](https://wiki.facepunch.com/gmod/render.SupportsHDR) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/client/render.lua#L46-L52)

---

### render.SupportsPixelShaders_1_4 · Client, Menu
`render.SupportsPixelShaders_1_4() → boolean`

Returns if the current settings and the system allow the usage of pixel shaders 1.4.

**Returns:**
- boolean — Whether Pixel Shaders 1.4 are supported or not.

[wiki](https://wiki.facepunch.com/gmod/render.SupportsPixelShaders_1_4)

---

### render.SupportsPixelShaders_2_0 · Client, Menu
`render.SupportsPixelShaders_2_0() → boolean`

Returns if the current settings and the system allow the usage of pixel shaders 2.0.

**Returns:**
- boolean — Whether Pixel Shaders 2.0 are supported or not.

[wiki](https://wiki.facepunch.com/gmod/render.SupportsPixelShaders_2_0)

---

### render.SupportsVertexShaders_2_0 · Client, Menu
`render.SupportsVertexShaders_2_0() → boolean`

Returns if the current settings and the system allow the usage of vertex shaders 2.0.

**Returns:**
- boolean — Whether Vertex Shaders 2.0 are supported or not.

[wiki](https://wiki.facepunch.com/gmod/render.SupportsVertexShaders_2_0)

---

### render.SuppressEngineLighting · Client
`render.SuppressEngineLighting(suppressLighting: boolean)`

Suppresses or enables any engine lighting for any upcoming render operation.

**Arguments:**
- `suppressLighting` (boolean) — True to suppress false to enable.

> **Bug** ([#4070](https://github.com/Facepunch/garrysmod/issues/4070)): This does not affect [IMesh](https://wiki.facepunch.com/gmod/IMesh)es.

[wiki](https://wiki.facepunch.com/gmod/render.SuppressEngineLighting)

---

### render.TurnOnToneMapping · Client
`render.TurnOnToneMapping()`

Enables HDR tone mapping which influences the brightness.

[wiki](https://wiki.facepunch.com/gmod/render.TurnOnToneMapping)

---

### render.UpdateFullScreenDepthTexture · Client
`render.UpdateFullScreenDepthTexture()`

Updates the texture returned by [render.GetFullScreenDepthTexture](https://wiki.facepunch.com/gmod/render.GetFullScreenDepthTexture).

Silently fails if [render.SupportsPixelShaders_2_0](https://wiki.facepunch.com/gmod/render.SupportsPixelShaders_2_0) returns false.

[wiki](https://wiki.facepunch.com/gmod/render.UpdateFullScreenDepthTexture)

---

### render.UpdatePowerOfTwoTexture · Client
`render.UpdatePowerOfTwoTexture() → ITexture`

Updates the power of two texture.

**Returns:**
- ITexture — The render.GetPowerOfTwoTexture.

[wiki](https://wiki.facepunch.com/gmod/render.UpdatePowerOfTwoTexture)

---

### render.UpdateRefractTexture · Client
`render.UpdateRefractTexture()`

Pretty much alias of [render.UpdatePowerOfTwoTexture](https://wiki.facepunch.com/gmod/render.UpdatePowerOfTwoTexture) but does not return the texture.

[wiki](https://wiki.facepunch.com/gmod/render.UpdateRefractTexture)

---

### render.UpdateScreenEffectTexture · Client
`render.UpdateScreenEffectTexture(textureIndex: number = 0)`

Copies the entire screen to the screen effect texture, which can be acquired via [render.GetScreenEffectTexture](https://wiki.facepunch.com/gmod/render.GetScreenEffectTexture). This function is mainly intended to be used in [GM:RenderScreenspaceEffects](https://wiki.facepunch.com/gmod/GM:RenderScreenspaceEffects).

**Arguments:**
- `textureIndex` (number, default `0`) — Texture index to update.

[wiki](https://wiki.facepunch.com/gmod/render.UpdateScreenEffectTexture)

---

### render.WorldMaterialOverride · Client
`render.WorldMaterialOverride(mat: IMaterial = nil)`

This function overrides all map materials for one frame.

**Arguments:**
- `mat` (IMaterial, default `nil`)

[wiki](https://wiki.facepunch.com/gmod/render.WorldMaterialOverride)

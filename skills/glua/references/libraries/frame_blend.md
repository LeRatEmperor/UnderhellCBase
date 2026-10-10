# frame_blend

**Realm:** Client  ·  **Members:** 8

The frame blending library.

[wiki page](https://wiki.facepunch.com/gmod/frame_blend)

### frame_blend.AddFrame · Client · `INTERNAL`
`frame_blend.AddFrame()`

Adds a frame to the blend. Calls [frame_blend.CompleteFrame](https://wiki.facepunch.com/gmod/frame_blend.CompleteFrame) once enough frames have passed since last [frame_blend.CompleteFrame](https://wiki.facepunch.com/gmod/frame_blend.CompleteFrame) call.

[wiki](https://wiki.facepunch.com/gmod/frame_blend.AddFrame) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/frame_blend.lua#L136-L145)

---

### frame_blend.BlendFrame · Client · `INTERNAL`
`frame_blend.BlendFrame()`

Blends the frame(s).

[wiki](https://wiki.facepunch.com/gmod/frame_blend.BlendFrame) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/frame_blend.lua#L147-L170)

---

### frame_blend.CompleteFrame · Client · `INTERNAL`
`frame_blend.CompleteFrame()`

Renders the frame onto internal render target.

[wiki](https://wiki.facepunch.com/gmod/frame_blend.CompleteFrame) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/frame_blend.lua#L119-L134)

---

### frame_blend.DrawPreview · Client · `INTERNAL`
`frame_blend.DrawPreview()`

Actually draws the frame blend effect.

[wiki](https://wiki.facepunch.com/gmod/frame_blend.DrawPreview) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/frame_blend.lua#L94-L102)

---

### frame_blend.IsActive · Client
`frame_blend.IsActive() → boolean`

Returns whether frame blend post processing effect is enabled or not.

**Returns:**
- boolean — Is frame blend enabled or not.

[wiki](https://wiki.facepunch.com/gmod/frame_blend.IsActive) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/frame_blend.lua#L71-L75)

---

### frame_blend.IsLastFrame · Client · `INTERNAL`
`frame_blend.IsLastFrame() → boolean`

Returns whether the current frame is the last frame?

**Returns:**
- boolean — Whether the current frame is the last frame?

[wiki](https://wiki.facepunch.com/gmod/frame_blend.IsLastFrame) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/frame_blend.lua#L77-L85)

---

### frame_blend.RenderableFrames · Client · `INTERNAL`
`frame_blend.RenderableFrames() → number`

Returns amount of frames needed to render?

**Returns:**
- number — Amount of frames needed to render?

[wiki](https://wiki.facepunch.com/gmod/frame_blend.RenderableFrames) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/frame_blend.lua#L87-L92)

---

### frame_blend.ShouldSkipFrame · Client
`frame_blend.ShouldSkipFrame() → boolean`

Returns whether we should skip frame or not.

**Returns:**
- boolean — Should the frame be skipped or not.

[wiki](https://wiki.facepunch.com/gmod/frame_blend.ShouldSkipFrame) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/postprocess/frame_blend.lua#L104-L117)

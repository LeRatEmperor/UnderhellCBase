# IVideoWriter

**Realm:** Client, Menu  ·  **Members:** 5

This is returned from [video.Record](https://wiki.facepunch.com/gmod/video.Record).

[wiki page](https://wiki.facepunch.com/gmod/IVideoWriter)

### IVideoWriter:AddFrame · Client, Menu
`IVideoWriter:AddFrame(frameTime: number, downsample: boolean)`

Adds the current framebuffer to the video stream.

**Arguments:**
- `frameTime` (number) — Usually set to what FrameTime is, or simply 1/fps.
- `downsample` (boolean) — If true it will downsample the whole screenspace to the videos width and height, otherwise it will just record from the top left corner to the given width and height and therefore not the whole screen.

[wiki](https://wiki.facepunch.com/gmod/IVideoWriter:AddFrame)

---

### IVideoWriter:Finish · Client, Menu
`IVideoWriter:Finish()`

Ends the video recording and dumps it to disk.

[wiki](https://wiki.facepunch.com/gmod/IVideoWriter:Finish)

---

### IVideoWriter:Height · Client, Menu
`IVideoWriter:Height() → number`

Returns the height of the video stream.

**Returns:**
- number — height

[wiki](https://wiki.facepunch.com/gmod/IVideoWriter:Height)

---

### IVideoWriter:SetRecordSound · Client, Menu
`IVideoWriter:SetRecordSound(record: boolean)`

Sets whether to record sound or not.

**Arguments:**
- `record` (boolean) — Record.

[wiki](https://wiki.facepunch.com/gmod/IVideoWriter:SetRecordSound)

---

### IVideoWriter:Width · Client, Menu
`IVideoWriter:Width() → number`

Returns the width of the video stream.

**Returns:**
- number — width

[wiki](https://wiki.facepunch.com/gmod/IVideoWriter:Width)

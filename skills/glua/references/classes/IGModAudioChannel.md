# IGModAudioChannel

**Realm:** Client  ·  **Members:** 41

A sound channel returned by a callback of [sound.PlayURL](https://wiki.facepunch.com/gmod/sound.PlayURL) and [sound.PlayFile](https://wiki.facepunch.com/gmod/sound.PlayFile).

[wiki page](https://wiki.facepunch.com/gmod/IGModAudioChannel)

### IGModAudioChannel:EnableLooping · Client
`IGModAudioChannel:EnableLooping(enable: boolean)`

Enables or disables looping of audio channel, requires noblock flag.

**Arguments:**
- `enable` (boolean) — Enable or disable looping of this audio channel.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:EnableLooping)

---

### IGModAudioChannel:FFT · Client
`IGModAudioChannel:FFT(tbl: table<number>, size: number{FFT}) → number`

Computes the [DFT (discrete Fourier transform)](https://en.wikipedia.org/wiki/Discrete_Fourier_transform) of the sound channel.

The size parameter specifies the number of consecutive audio samples to use as the input to the DFT and is restricted to a power of two. A [Hann window](https://en.wikipedia.org/wiki/Hann_function) is applied to the input data.

The computed DFT has the same number of frequency bins as the number of samples. Only half of this DFT is returned, since [the DFT magnitudes are symmetric for real input data](https://en.wikipedia.org/wiki/Discrete_Fourier_transform#The_real-input_DFT). The magnitudes of the DFT (values from 0 to 1) are used to fill the output table, starting at index 1.

**Visualization protip:** For a size N DFT, bin k (1-indexed) corresponds to a frequency of (k - 1) / N * sampleRate.

**Visualization protip:** Sound energy is proportional to the square of the magnitudes. Adding magnitudes together makes no sense physically, but adding energies does.

**Visualization protip:** The human ear works on a logarithmic amplitude scale. You can convert to [decibels](https://en.wikipedia.org/wiki/Decibel) by taking 20 * [math.log10](https://wiki.facepunch.com/gmod/math.log10) of frequency magnitudes, or 10 * [math.log10](https://wiki.facepunch.com/gmod/math.log10) of energy. The decibel values will range from -infinity to 0.

**Arguments:**
- `tbl` (table<number>) — The table to output the DFT magnitudes (numbers between 0 and 1) into.
- `size` (number{FFT}) — The number of samples to use.

**Returns:**
- number — The number of frequency bins that have been filled in the output table.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:FFT)

---

### IGModAudioChannel:Get3DCone · Client
`IGModAudioChannel:Get3DCone() → number, number, number`

Returns 3D cone of the sound channel. See [IGModAudioChannel:Set3DCone](https://wiki.facepunch.com/gmod/IGModAudioChannel:Set3DCone).

**Returns:**
- number — The angle of the inside projection cone in degrees.
- number — The angle of the outside projection cone in degrees.
- number — The delta-volume outside the outer projection cone.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:Get3DCone)

---

### IGModAudioChannel:Get3DEnabled · Client
`IGModAudioChannel:Get3DEnabled() → boolean`

Returns if the sound channel is currently in 3D mode or not. This value will be affected by [IGModAudioChannel:Set3DEnabled](https://wiki.facepunch.com/gmod/IGModAudioChannel:Set3DEnabled).

**Returns:**
- boolean — Is currently 3D or not.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:Get3DEnabled)

---

### IGModAudioChannel:Get3DFadeDistance · Client
`IGModAudioChannel:Get3DFadeDistance() → number, number`

Returns 3D fade distances of a sound channel.

**Returns:**
- number — The minimum distance.
- number — The maximum distance.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:Get3DFadeDistance)

---

### IGModAudioChannel:GetAverageBitRate · Client
`IGModAudioChannel:GetAverageBitRate() → number`

Returns the average bit rate of the sound channel.

**Returns:**
- number — The average bit rate of the sound channel.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetAverageBitRate)

---

### IGModAudioChannel:GetBitsPerSample · Client
`IGModAudioChannel:GetBitsPerSample() → number`

Retrieves the number of bits per sample of the sound channel.

Doesn't work for mp3 and ogg files.

**Returns:**
- number — Number of bits per sample, or 0 if unknown.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetBitsPerSample)

---

### IGModAudioChannel:GetBufferedTime · Client
`IGModAudioChannel:GetBufferedTime() → number`

Returns the buffered time of the sound channel in seconds, for online streaming sound channels. ([sound.PlayURL](https://wiki.facepunch.com/gmod/sound.PlayURL))

For offline channels this will be equivalent to [IGModAudioChannel:GetLength](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetLength).

**Returns:**
- number — The current buffered time of the stream, in seconds.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetBufferedTime)

---

### IGModAudioChannel:GetFileName · Client
`IGModAudioChannel:GetFileName() → string`

Returns the filename for the sound channel.

**Returns:**
- string — The file name.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetFileName)

---

### IGModAudioChannel:GetLength · Client
`IGModAudioChannel:GetLength() → number`

Returns the length of sound played by the sound channel in seconds.

**Returns:**
- number — The length of the sound.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetLength)

---

### IGModAudioChannel:GetLevel · Client
`IGModAudioChannel:GetLevel() → number, number`

Returns the right and left levels of sound played by the sound channel.

**Returns:**
- number — The left sound level.
- number — The right sound level.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetLevel)

---

### IGModAudioChannel:GetPan · Client
`IGModAudioChannel:GetPan() → number`

Gets the relative volume of the left and right channels.

**Returns:**
- `pan` (number) — Relative volume between the left and right channels.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetPan)

---

### IGModAudioChannel:GetPlaybackRate · Client
`IGModAudioChannel:GetPlaybackRate() → number`

Returns the playback rate of the sound channel.

**Returns:**
- number — The current playback rate of the sound channel

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetPlaybackRate)

---

### IGModAudioChannel:GetPos · Client
`IGModAudioChannel:GetPos() → Vector`

Returns position of the sound channel

**Returns:**
- Vector — The position of the sound channel, previously set by IGModAudioChannel:SetPos

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetPos)

---

### IGModAudioChannel:GetSamplingRate · Client
`IGModAudioChannel:GetSamplingRate() → number`

Returns the sample rate for currently playing sound.

**Returns:**
- number — The sample rate in Hz.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetSamplingRate)

---

### IGModAudioChannel:GetState · Client
`IGModAudioChannel:GetState() → number`

Returns the state of a sound channel

**Returns:**
- number — The state of the sound channel, see GMOD_CHANNEL

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetState)

---

### IGModAudioChannel:GetTagsHTTP · Client
`IGModAudioChannel:GetTagsHTTP() → table<string>`

Retrieves HTTP headers from a bass stream channel created by [sound.PlayURL](https://wiki.facepunch.com/gmod/sound.PlayURL), if available.

Of special interest here are headers such as `icy-name`, `icy-br`, `ice-audio-info`, `icy-genre`.

**Returns:**
- `info` (table<string>) — A list of HTTP headers or `nil` if no information is available.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetTagsHTTP)

---

### IGModAudioChannel:GetTagsID3 · Client
`IGModAudioChannel:GetTagsID3() → table`

Retrieves the ID3 version 1 info from a bass channel created by [sound.PlayFile](https://wiki.facepunch.com/gmod/sound.PlayFile) or [sound.PlayURL](https://wiki.facepunch.com/gmod/sound.PlayURL), if available.

ID3v2 is not supported.

**Returns:**
- `info` (table) — A table containing the information, or `nil` if no information is available.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetTagsID3)

---

### IGModAudioChannel:GetTagsMeta · Client
`IGModAudioChannel:GetTagsMeta() → string`

Retrieves ICY metadata from a bass stream channel created by [sound.PlayURL](https://wiki.facepunch.com/gmod/sound.PlayURL), if available.

**Returns:**
- `info` (string) — The meta information, or `nil` if no information is available.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetTagsMeta)

---

### IGModAudioChannel:GetTagsMP4 · Client
`IGModAudioChannel:GetTagsMP4() → table<string>`

Retrieves `.m4a` media info, from a bass channel created by [sound.PlayURL](https://wiki.facepunch.com/gmod/sound.PlayURL) or [sound.PlayFile](https://wiki.facepunch.com/gmod/sound.PlayFile), if available.

**Returns:**
- `info` (table<string>) — A list of available information in no particular order, or `nil` if no information is available.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetTagsMP4)

---

### IGModAudioChannel:GetTagsOGG · Client
`IGModAudioChannel:GetTagsOGG() → table<string>`

Retrieves OGG media info tag, from a bass channel created by [sound.PlayURL](https://wiki.facepunch.com/gmod/sound.PlayURL) or [sound.PlayFile](https://wiki.facepunch.com/gmod/sound.PlayFile), if available.

**Returns:**
- `info` (table<string>) — A list of available information in no particular order, or `nil` if no information is available.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetTagsOGG)

---

### IGModAudioChannel:GetTagsVendor · Client
`IGModAudioChannel:GetTagsVendor() → string`

Retrieves OGG Vendor tag, usually containing the application that created the file, from a bass channel created by [sound.PlayURL](https://wiki.facepunch.com/gmod/sound.PlayURL) or [sound.PlayFile](https://wiki.facepunch.com/gmod/sound.PlayFile), if available.

**Returns:**
- `info` (string) — The OGG vendor tag, or `nil` if no information is available.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetTagsVendor)

---

### IGModAudioChannel:GetTagsWMA · Client
`IGModAudioChannel:GetTagsWMA() → table<string>`

Retrieves `.WMA` media info, from a bass channel created by [sound.PlayURL](https://wiki.facepunch.com/gmod/sound.PlayURL) or [sound.PlayFile](https://wiki.facepunch.com/gmod/sound.PlayFile), if available.

**Returns:**
- `info` (table<string>) — A list of available information in no particular order, or `nil` if no information is available.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetTagsWMA)

---

### IGModAudioChannel:GetTime · Client
`IGModAudioChannel:GetTime() → number`

Returns the current time of the sound channel in seconds

**Returns:**
- number — The current time of the stream

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetTime)

---

### IGModAudioChannel:GetVolume · Client
`IGModAudioChannel:GetVolume() → number`

Returns volume of a sound channel

**Returns:**
- number — The volume of the sound channel

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetVolume)

---

### IGModAudioChannel:Is3D · Client
`IGModAudioChannel:Is3D() → boolean`

Returns if the sound channel is in 3D mode or not.

**Returns:**
- boolean — Is 3D or not.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:Is3D)

---

### IGModAudioChannel:IsBlockStreamed · Client
`IGModAudioChannel:IsBlockStreamed() → boolean`

Returns whether the audio stream is block streamed or not.

**Returns:**
- boolean — Is the audio stream block streamed or not.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:IsBlockStreamed)

---

### IGModAudioChannel:IsLooping · Client
`IGModAudioChannel:IsLooping() → boolean`

Returns if the sound channel is looping or not.

**Returns:**
- boolean — Is looping or not.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:IsLooping)

---

### IGModAudioChannel:IsOnline · Client
`IGModAudioChannel:IsOnline() → boolean`

Returns if the sound channel is streamed from the Internet or not.

**Returns:**
- boolean — Is online or not.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:IsOnline)

---

### IGModAudioChannel:IsValid · Client
`IGModAudioChannel:IsValid() → boolean`

Returns if the sound channel is valid or not.

**Returns:**
- boolean — Is the sound channel valid or not

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:IsValid)

---

### IGModAudioChannel:Pause · Client
`IGModAudioChannel:Pause()`

Pauses the stream. It can be started again using [IGModAudioChannel:Play](https://wiki.facepunch.com/gmod/IGModAudioChannel:Play)

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:Pause)

---

### IGModAudioChannel:Play · Client
`IGModAudioChannel:Play()`

Starts playing the stream.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:Play)

---

### IGModAudioChannel:Set3DCone · Client
`IGModAudioChannel:Set3DCone(innerAngle: number, outerAngle: number, outerVolume: number)`

Sets 3D cone of the sound channel.

**Arguments:**
- `innerAngle` (number) — The angle of the inside projection cone in degrees.
- `outerAngle` (number) — The angle of the outside projection cone in degrees.
- `outerVolume` (number) — The delta-volume outside the outer projection cone.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:Set3DCone)

---

### IGModAudioChannel:Set3DEnabled · Client
`IGModAudioChannel:Set3DEnabled(enable: boolean)`

Sets the 3D mode of the channel. This will affect [IGModAudioChannel:Get3DEnabled](https://wiki.facepunch.com/gmod/IGModAudioChannel:Get3DEnabled) but not [IGModAudioChannel:Is3D](https://wiki.facepunch.com/gmod/IGModAudioChannel:Is3D).

This feature **requires** the channel to be initially created in 3D mode, i.e. [IGModAudioChannel:Is3D](https://wiki.facepunch.com/gmod/IGModAudioChannel:Is3D) should return true or this function will do nothing.

**Arguments:**
- `enable` (boolean) — true to enable, false to disable 3D.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:Set3DEnabled)

---

### IGModAudioChannel:Set3DFadeDistance · Client
`IGModAudioChannel:Set3DFadeDistance(min: number, max: number)`

Sets 3D fade distances of a sound channel.

**Arguments:**
- `min` (number) — The minimum distance.
- `max` (number) — The maximum distance.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:Set3DFadeDistance)

---

### IGModAudioChannel:SetPan · Client
`IGModAudioChannel:SetPan(pan: number)`

Sets the relative volume of the left and right channels.

**Arguments:**
- `pan` (number) — Relative volume between the left and right channels.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:SetPan)

---

### IGModAudioChannel:SetPlaybackRate · Client
`IGModAudioChannel:SetPlaybackRate(rate: number)`

Sets the playback rate of the sound channel. May not work with high values for radio streams.

**Arguments:**
- `rate` (number) — Playback rate to set to.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:SetPlaybackRate)

---

### IGModAudioChannel:SetPos · Client
`IGModAudioChannel:SetPos(pos: Vector, dir: Vector = Vector( 0, 0, 0 ))`

Sets position of sound channel in case the sound channel has a 3d option set.

**Arguments:**
- `pos` (Vector) — The position to put the sound into
- `dir` (Vector, default `Vector( 0, 0, 0 )`) — The direction of the sound

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:SetPos)

---

### IGModAudioChannel:SetTime · Client
`IGModAudioChannel:SetTime(secs: number, dont_decode: boolean = false)`

Sets the sound channel to specified time ( Rewind to that position of the song ). Does not work on online radio streams.

Streamed sounds must have "noblock" parameter for this to work and [IGModAudioChannel:IsBlockStreamed](https://wiki.facepunch.com/gmod/IGModAudioChannel:IsBlockStreamed) must return false.

**Arguments:**
- `secs` (number) — The time to set the stream to, in seconds.
- `dont_decode` (boolean, default `false`) — Set to true to skip decoding to set time, and instead just seek to it which is faster.

> **Note:** Streamed sounds can only have their time set to up to the current [IGModAudioChannel:GetBufferedTime](https://wiki.facepunch.com/gmod/IGModAudioChannel:GetBufferedTime).

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:SetTime)

---

### IGModAudioChannel:SetVolume · Client
`IGModAudioChannel:SetVolume(volume: number)`

Sets the volume of a sound channel

**Arguments:**
- `volume` (number) — Volume to set.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:SetVolume)

---

### IGModAudioChannel:Stop · Client
`IGModAudioChannel:Stop()`

Stop the stream. It can be started again using [IGModAudioChannel:Play](https://wiki.facepunch.com/gmod/IGModAudioChannel:Play).

> **Bug** ([#1497](https://github.com/Facepunch/garrysmod/issues/1497)): Calling this invalidates the IGModAudioChannel object rendering it unusable for further functions.

[wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel:Stop)

# CSoundPatch

**Realm:** Shared  ·  **Members:** 13

CSoundPatch class.

Created with [CreateSound](https://wiki.facepunch.com/gmod/Global.CreateSound)

[wiki page](https://wiki.facepunch.com/gmod/CSoundPatch)

### CSoundPatch:ChangePitch · Shared
`CSoundPatch:ChangePitch(pitch: number, deltaTime: number = 0)`

Adjust the pitch, also known as the speed at which the sound is being played.

Appears to only work while the sound is being played. See also [CSoundPatch:PlayEx](https://wiki.facepunch.com/gmod/CSoundPatch:PlayEx).

This invokes [GM:EntityEmitSound](https://wiki.facepunch.com/gmod/GM:EntityEmitSound).

**Arguments:**
- `pitch` (number) — The pitch can range from 0-255.
- `deltaTime` (number, default `0`) — The time to fade from previous to the new pitch.

[wiki](https://wiki.facepunch.com/gmod/CSoundPatch:ChangePitch)

---

### CSoundPatch:ChangeVolume · Shared
`CSoundPatch:ChangeVolume(volume: number, deltaTime: number = 0)`

Adjusts the volume of the sound played.

Appears to only work while the sound is being played. See also [CSoundPatch:PlayEx](https://wiki.facepunch.com/gmod/CSoundPatch:PlayEx).

**Arguments:**
- `volume` (number) — The volume ranges from 0 to 1.
- `deltaTime` (number, default `0`) — Time to fade the volume from previous to new value from.

[wiki](https://wiki.facepunch.com/gmod/CSoundPatch:ChangeVolume)

---

### CSoundPatch:FadeOut · Shared
`CSoundPatch:FadeOut(seconds: number)`

Fades out the volume of the sound from the current volume to 0 in the given amount of seconds.

**Arguments:**
- `seconds` (number) — Fade time.

[wiki](https://wiki.facepunch.com/gmod/CSoundPatch:FadeOut)

---

### CSoundPatch:GetDSP · Shared
`CSoundPatch:GetDSP() → number`

Returns the DSP (Digital Signal Processor) effect ID for the sound.

**Returns:**
- `dspEffectId` (number) — The numerical ID for the DSP effect currently enabled on the sound.

[wiki](https://wiki.facepunch.com/gmod/CSoundPatch:GetDSP)

---

### CSoundPatch:GetPitch · Shared
`CSoundPatch:GetPitch() → number`

Returns the current pitch.

**Returns:**
- number — The current pitch, can range from 0-255.

[wiki](https://wiki.facepunch.com/gmod/CSoundPatch:GetPitch)

---

### CSoundPatch:GetSoundLevel · Shared
`CSoundPatch:GetSoundLevel() → number`

Returns the current sound level.

**Returns:**
- number — The current sound level, see SNDLVL.

[wiki](https://wiki.facepunch.com/gmod/CSoundPatch:GetSoundLevel)

---

### CSoundPatch:GetVolume · Shared
`CSoundPatch:GetVolume() → number`

Returns the current volume.

**Returns:**
- number — The current volume, ranging from 0 to 1.

[wiki](https://wiki.facepunch.com/gmod/CSoundPatch:GetVolume)

---

### CSoundPatch:IsPlaying · Shared
`CSoundPatch:IsPlaying() → boolean`

Returns whenever the sound is being played.

**Returns:**
- boolean — Is playing or not

[wiki](https://wiki.facepunch.com/gmod/CSoundPatch:IsPlaying)

---

### CSoundPatch:Play · Shared
`CSoundPatch:Play()`

Starts to play the sound. This will reset the sound's volume and pitch to their default values. See [CSoundPatch:PlayEx](https://wiki.facepunch.com/gmod/CSoundPatch:PlayEx)

[wiki](https://wiki.facepunch.com/gmod/CSoundPatch:Play)

---

### CSoundPatch:PlayEx · Shared
`CSoundPatch:PlayEx(volume: number, pitch: number)`

Same as [CSoundPatch:Play](https://wiki.facepunch.com/gmod/CSoundPatch:Play) but with 2 extra arguments allowing to set volume and pitch directly.

**Arguments:**
- `volume` (number) — The volume ranges from 0 to 1.
- `pitch` (number) — The pitch can range from 0-255.

[wiki](https://wiki.facepunch.com/gmod/CSoundPatch:PlayEx)

---

### CSoundPatch:SetDSP · Shared
`CSoundPatch:SetDSP(dspEffectId: number)`

Sets the DSP (Digital Signal Processor) effect for the sound.

Similar to [Player:SetDSP](https://wiki.facepunch.com/gmod/Player:SetDSP) but for individual sounds.

**Arguments:**
- `dspEffectId` (number) — The numerical ID for the DSP effect to be enabled on the sound.

[wiki](https://wiki.facepunch.com/gmod/CSoundPatch:SetDSP)

---

### CSoundPatch:SetSoundLevel · Shared
`CSoundPatch:SetSoundLevel(level: number)`

Sets the sound level in decibel.

**Arguments:**
- `level` (number, enum [SNDLVL](https://wiki.facepunch.com/gmod/Enums/SNDLVL)) — The sound level in decibel.

[wiki](https://wiki.facepunch.com/gmod/CSoundPatch:SetSoundLevel)

---

### CSoundPatch:Stop · Shared
`CSoundPatch:Stop()`

Stops the sound from being played.

> **Bug** ([#3260](https://github.com/Facepunch/garrysmod/issues/3260)): This will not work if the entity attached to this sound patch (specified by [CreateSound](https://wiki.facepunch.com/gmod/Global.CreateSound)) is invalid.

[wiki](https://wiki.facepunch.com/gmod/CSoundPatch:Stop)

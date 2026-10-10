# sound

**Realm:** Shared  ·  **Members:** 11

Used primarily for adding new soundscript entries.

[wiki page](https://wiki.facepunch.com/gmod/sound)

### sound.Add · Shared
`sound.Add(soundData: table{SoundData})`

Creates a [sound scripts](https://developer.valvesoftware.com/wiki/Soundscripts). It can also override sounds, which seems to only work when set on the server.

You can find a list of common sound scripts that are shipped with the game by default here: [Common Sounds](https://wiki.facepunch.com/gmod/Common%20Sounds).

A list of sound scripts can be retrieved with [sound.GetTable](https://wiki.facepunch.com/gmod/sound.GetTable).

**Arguments:**
- `soundData` (table{SoundData}) — The sounds properties.

[wiki](https://wiki.facepunch.com/gmod/sound.Add)

---

### sound.AddSoundOverrides · Shared
`sound.AddSoundOverrides(filepath: string)`

Overrides [sound scripts](https://developer.valvesoftware.com/wiki/Soundscripts) defined inside of a `.txt` file; typically used for adding map-specific sounds.

**Arguments:**
- `filepath` (string) — Path to the script file to load.

[wiki](https://wiki.facepunch.com/gmod/sound.AddSoundOverrides)

---

### sound.EmitHint · Server
`sound.EmitHint(hint: number, pos: Vector, volume: number, duration: number, owner: Entity = NULL)`

Emits a sound hint to the game elements to react to, for example to repel or attract antlions.

**Arguments:**
- `hint` (number, enum [SOUND](https://wiki.facepunch.com/gmod/Enums/SOUND)) — The hint to emit.
- `pos` (Vector) — The position to emit the hint at
- `volume` (number) — The volume or radius of the hint
- `duration` (number) — The duration of the hint in seconds
- `owner` (Entity, default `NULL`) — If set, the sound hint will be ignored/deleted when the given entity is destroyed.

[wiki](https://wiki.facepunch.com/gmod/sound.EmitHint)

---

### sound.Generate · Client
`sound.Generate(identifier: string, samplerate: number, length: number, callbackOrData: function, loopStart: number = nil)`

Creates a sound from a function.

**Arguments:**
- `identifier` (string) — A unique identifier for the sound.
- `samplerate` (number) — The sample rate of the sound.
- `length` (number) — The length in seconds of the sound to generate.
- `callbackOrData` (function) — A function which will be called to generate every sample on the sound.
- `loopStart` (number, default `nil`) — Sample ID of the loop start.

[wiki](https://wiki.facepunch.com/gmod/sound.Generate)

---

### sound.GetLoudestSoundHint · Server
`sound.GetLoudestSoundHint(types: number, pos: Vector) → table`

Returns the most dangerous/closest sound hint based on given location and types of sounds to sense.

**Arguments:**
- `types` (number, enum [SOUND](https://wiki.facepunch.com/gmod/Enums/SOUND)) — The types of sounds to choose from.
- `pos` (Vector) — The position to sense sounds at.

**Returns:**
- table — A table with SoundHintData structure or `nil` if no sound hints are nearby.

[wiki](https://wiki.facepunch.com/gmod/sound.GetLoudestSoundHint)

---

### sound.GetProperties · Shared
`sound.GetProperties(name: string) → table{SoundData}`

Returns properties of a [sound script](https://developer.valvesoftware.com/wiki/Soundscripts).

**Arguments:**
- `name` (string) — The name of the sound script

**Returns:**
- table{SoundData} — The properties of the soundscript.

[wiki](https://wiki.facepunch.com/gmod/sound.GetProperties)

---

### sound.GetTable · Shared
`sound.GetTable() → table<string>`

Returns a list of all registered [sound scripts](https://developer.valvesoftware.com/wiki/Soundscripts).

New ones can be registered using [sound.Add](https://wiki.facepunch.com/gmod/sound.Add), and detailed information about each one can be retrieved via [sound.GetProperties](https://wiki.facepunch.com/gmod/sound.GetProperties).

**Returns:**
- table<string> — The list/array of all registered sound scripts ( No other information is provided )

[wiki](https://wiki.facepunch.com/gmod/sound.GetTable)

---

### sound.Play · Shared
`sound.Play(snd: string, pos: Vector, level: number = 75, pitch: number = 100, volume: number = 1, dsp: number = 0)`

Plays a sound from the specified position in the world.
If you want to play a sound without a position, such as a UI sound, use [surface.PlaySound](https://wiki.facepunch.com/gmod/surface.PlaySound) instead.

This function is similar to [EmitSound](https://wiki.facepunch.com/gmod/Global.EmitSound), but with less options.

**Arguments:**
- `snd` (string) — The sound to play.
- `pos` (Vector) — Where the sound should play.
- `level` (number, default `75`, enum [SNDLVL](https://wiki.facepunch.com/gmod/Enums/SNDLVL)) — Sound level in decibels.
- `pitch` (number, default `100`) — The sound pitch.
- `volume` (number, default `1`) — Output volume of the sound in range 0 to 1.
- `dsp` (number, default `0`) — The DSP preset for this sound.

[wiki](https://wiki.facepunch.com/gmod/sound.Play)

---

### sound.PlayFile · Client
`sound.PlayFile(path: string, flags: string, callback: function)`

Plays a file from GMod directory. You can find a list of all error codes [here](http://www.un4seen.com/doc/#bass/BASS_ErrorGetCode.html)

For external file/stream playback, see [sound.PlayURL](https://wiki.facepunch.com/gmod/sound.PlayURL).

**Arguments:**
- `path` (string) — The path to the file to play.
- `flags` (string) — Flags for the sound.
- `callback` (function) — Callback function that is called as soon as the the stream is loaded.

> **Bug** ([#1752](https://github.com/Facepunch/garrysmod/issues/1752)): This fails for looping .wav files in 3D mode.
> **Bug** ([#2304](https://github.com/Facepunch/garrysmod/issues/2304)): This fails with unicode file names.

[wiki](https://wiki.facepunch.com/gmod/sound.PlayFile)

---

### sound.PlayURL · Client
`sound.PlayURL(url: string, flags: string, callback: function)`

Allows you to play external sound files, as well as online radio streams.
You can find a list of all error codes [here](http://www.un4seen.com/doc/#bass/BASS_ErrorGetCode.html)

For offline file playback, see [sound.PlayFile](https://wiki.facepunch.com/gmod/sound.PlayFile).

**Arguments:**
- `url` (string) — The URL of the sound to play
- `flags` (string) — Flags for the sound.
- `callback` (function) — Callback function that is called as soon as the the stream is loaded.

> **Bug** ([#2296](https://github.com/Facepunch/garrysmod/issues/2296)): Due to a bug with [BASS](http://www.un4seen.com/), AAC codec streams cannot be played in 3D mode.

[wiki](https://wiki.facepunch.com/gmod/sound.PlayURL)

---

### sound.SetActorGender · Shared
`sound.SetActorGender(modelPath: string, gender: string)`

Sets the gender of a specific actor (model). This is a system from [base Half-Life 2](https://developer.valvesoftware.com/wiki/Global_actors) - `global_actors.txt`.

This will affect what voice lines `npc_citizen` will use when they have the given model set.

It is not limited to `npc_citizens` - any sound played on any entity with given model can have gender specific sounds playing, including soundscripts, by including `$gender` token in the sound file path.

**Arguments:**
- `modelPath` (string) — Path to the model file to set the gender of.
- `gender` (string) — Gender to set.

> **Warning:** Internally the gender is stored by model file name only (i.e. `models/alyx.mdl` would be stored as `alyx`), not the full path! Be aware of potential collisions.

[wiki](https://wiki.facepunch.com/gmod/sound.SetActorGender)

# engine

**Realm:** Shared, Menu  ·  **Members:** 22

The engine library provides functions to access various features in the game's engine, most are related to the demo and save systems.

[wiki page](https://wiki.facepunch.com/gmod/engine)

### engine.AbsoluteFrameTime · Shared
`engine.AbsoluteFrameTime() → number`

Returns non paused [FrameTime](https://wiki.facepunch.com/gmod/Global.FrameTime).

**Returns:**
- number — Frame time.

[wiki](https://wiki.facepunch.com/gmod/engine.AbsoluteFrameTime)

---

### engine.ActiveGamemode · Shared, Menu
`engine.ActiveGamemode() → string`

Returns the name of the currently running gamemode.

**Returns:**
- string — The active gamemode's name.

[wiki](https://wiki.facepunch.com/gmod/engine.ActiveGamemode)

---

### engine.CloseServer · Server
`engine.CloseServer()`

Closes the server and completely exits.

To enable this function for use on your server, add `-allowquit` to your commandline, which will make this function run `quit keep_players` when executed, this also does not forcibly disconnect players.

This is also available when running in server test mode (launch option `-systemtest`). Server test mode is used internally at Facepunch as part of the build process to make sure that the dedicated servers aren't crashing on startup.

[wiki](https://wiki.facepunch.com/gmod/engine.CloseServer)

---

### engine.GetAddons · Shared, Menu
`engine.GetAddons() → table`

Returns a list of addons the player have subscribed to on the workshop.

This list will also include "Floating" .gma addons that are mounted by the game, but not the folder addons.

**Returns:**
- table — A table of tables containing 8 keys (downloaded, models, title, file, mounted, wsid, size, updated).

[wiki](https://wiki.facepunch.com/gmod/engine.GetAddons)

---

### engine.GetDemoPlaybackStartTick · Client, Menu
`engine.GetDemoPlaybackStartTick() → number`

When starting playing a demo, [engine.GetDemoPlaybackTick](https://wiki.facepunch.com/gmod/engine.GetDemoPlaybackTick) will be reset and its old value will be added to this functions return value.

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/engine.GetDemoPlaybackStartTick)

---

### engine.GetDemoPlaybackTick · Client, Menu
`engine.GetDemoPlaybackTick() → number`

Current tick of currently loaded demo.

If not playing a demo, it will return amount of ticks since last demo playback.

**Returns:**
- number — The amount of ticks of currently loaded demo.

[wiki](https://wiki.facepunch.com/gmod/engine.GetDemoPlaybackTick)

---

### engine.GetDemoPlaybackTimeScale · Client, Menu
`engine.GetDemoPlaybackTimeScale() → number`

Returns time scale of demo playback.

If not during demo playback, returns 1.

**Returns:**
- number — The time scale of demo playback, value of demo_timescale console variable.

[wiki](https://wiki.facepunch.com/gmod/engine.GetDemoPlaybackTimeScale)

---

### engine.GetDemoPlaybackTotalTicks · Client, Menu
`engine.GetDemoPlaybackTotalTicks() → number`

Returns total amount of ticks of currently loaded demo.

If not playing a demo, returns 0 or the value of last played demo.

**Returns:**
- number — Total amount of ticks of currently loaded demo.

[wiki](https://wiki.facepunch.com/gmod/engine.GetDemoPlaybackTotalTicks)

---

### engine.GetGamemodes · Shared, Menu
`engine.GetGamemodes() → table`

Returns a table containing info for all installed gamemodes.

**Returns:**
- table — The gamemodes.

[wiki](https://wiki.facepunch.com/gmod/engine.GetGamemodes)

---

### engine.GetGames · Shared, Menu
`engine.GetGames() → table`

Returns an array of tables corresponding to all games from which Garry's Mod supports mounting content.

**Returns:**
- table — A table of tables containing all mountable games.

[wiki](https://wiki.facepunch.com/gmod/engine.GetGames)

---

### engine.GetUserContent · Client, Menu · `DEPRECATED`
`engine.GetUserContent() → table`

Returns the UGC (demos, saves and dupes) the player have subscribed to on the workshop.

**Returns:**
- table — Returns a table with 5 keys (title, type, tags, wsid, timeadded).

[wiki](https://wiki.facepunch.com/gmod/engine.GetUserContent)

---

### engine.IsPlayingDemo · Client, Menu
`engine.IsPlayingDemo() → boolean`

Returns true if we're currently playing a demo.

You will notice that there's no server-side version of this. That's because there is no server when playing a demo. Demos are both recorded and played back purely clientside.

**Returns:**
- boolean — Whether the game is currently playing a demo or not.

[wiki](https://wiki.facepunch.com/gmod/engine.IsPlayingDemo)

---

### engine.IsRecordingDemo · Client, Menu
`engine.IsRecordingDemo() → boolean`

Returns true if the game is currently recording a demo file (.dem) using gm_demo.

**Returns:**
- boolean — Whether the game is currently recording a demo or not.

[wiki](https://wiki.facepunch.com/gmod/engine.IsRecordingDemo)

---

### engine.LightStyle · Server
`engine.LightStyle(lightstyle: number, pattern: string)`

This is a direct binding to the function `engine->LightStyle`. This function allows you to change the default light style of the map - so you can make lighting lighter or darker. You’ll need to call [render.RedownloadAllLightmaps](https://wiki.facepunch.com/gmod/render.RedownloadAllLightmaps) clientside to refresh the lightmaps to this new color.

**Arguments:**
- `lightstyle` (number) — The lightstyle to edit.
- `pattern` (string) — The pattern to change the lightstyle to.

> **Bug** ([#3626](https://github.com/Facepunch/garrysmod/issues/3626)): Calling this function with arguments 0 and "a" will cause dynamic lights such as those produced by the Light tool to stop working.

[wiki](https://wiki.facepunch.com/gmod/engine.LightStyle)

---

### engine.OpenDupe · Client
`engine.OpenDupe(dupeName: string) → table`

Loads a duplication from the local filesystem.

**Arguments:**
- `dupeName` (string) — Name of the file.

**Returns:**
- table — A table with a simple field: * string `data` - Compressed dupe data.

[wiki](https://wiki.facepunch.com/gmod/engine.OpenDupe)

---

### engine.ServerFrameTime · Client
`engine.ServerFrameTime() → number, number`

Returns an estimate of the server's performance. Equivalent to calling [FrameTime](https://wiki.facepunch.com/gmod/Global.FrameTime) from the server, according to source code.

**Returns:**
- number — Frame time.
- number — Server framerate standard deviation.

[wiki](https://wiki.facepunch.com/gmod/engine.ServerFrameTime)

---

### engine.SetMounted · Menu
`engine.SetMounted(depotID: string, doMount: boolean)`

Sets the mounting options for mountable content.

**Arguments:**
- `depotID` (string) — The depot id of the game to mount.
- `doMount` (boolean) — The mount state, true to mount, false to unmount

[wiki](https://wiki.facepunch.com/gmod/engine.SetMounted)

---

### engine.TickCount · Shared, Menu
`engine.TickCount() → number`

Returns the number of ticks since the game server started.

**Returns:**
- number — Number of ticks since the game server started.

[wiki](https://wiki.facepunch.com/gmod/engine.TickCount)

---

### engine.TickInterval · Shared, Menu
`engine.TickInterval() → number`

Returns the time interval between each game tick in seconds.

This function is useful for making animations (usually serverside, such as doors rotating) and similar things to be independent of the tickrate in hooks that run at the tick rate, such as [GM:Tick](https://wiki.facepunch.com/gmod/GM:Tick).

Clientside you'd want to use [FrameTime](https://wiki.facepunch.com/gmod/Global.FrameTime) for this purpose in hooks that run every frame.

The default tickrate is `66.6666`, aka `15` milliseconds interval between each game tick.  
The tickrate can be adjusted via the `-tickrate` [command line option](Command_Line_Parameters).

**Returns:**
- number — Number of seconds between each gametick.

[wiki](https://wiki.facepunch.com/gmod/engine.TickInterval)

---

### engine.VideoSettings · Client · `INTERNAL`
`engine.VideoSettings() → table`

Returns video recording settings set by [video.Record](https://wiki.facepunch.com/gmod/video.Record). Used by Demo-To-Video feature.

**Returns:**
- table — The video recording settings, see Structures/VideoData.

[wiki](https://wiki.facepunch.com/gmod/engine.VideoSettings)

---

### engine.WriteDupe · Client · `INTERNAL`
`engine.WriteDupe(dupe: string, jpeg: string)`

Saves a duplication as a file.

**Arguments:**
- `dupe` (string) — Dupe table, encoded by util.TableToJSON and compressed by util.Compress.
- `jpeg` (string) — The dupe icon, created by render.Capture.

[wiki](https://wiki.facepunch.com/gmod/engine.WriteDupe)

---

### engine.WriteSave · Client · `INTERNAL`
`engine.WriteSave(saveData: string, name: string)`

Stores savedata into the game. (can be loaded using the LoadGame menu)

**Arguments:**
- `saveData` (string) — Data generated by gmsave.SaveMap.
- `name` (string) — Name the save will have.

[wiki](https://wiki.facepunch.com/gmod/engine.WriteSave)

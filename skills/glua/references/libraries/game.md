# game

**Realm:** Shared, Menu  ·  **Members:** 40

The game library provides functions to access various features in the game's engine, most of it's functions are related to controlling the map.

[wiki page](https://wiki.facepunch.com/gmod/game)

### game.AddAmmoType · Shared
`game.AddAmmoType(ammoData: table{AmmoData})`

Adds a new ammo type to the game.

You can find a list of default ammo types [here](https://wiki.facepunch.com/gmod/Default_Ammo_Types).

**Arguments:**
- `ammoData` (table{AmmoData}) — The attributes of the ammo.

> **Note:** There is a limit of 256 ammo types, including the default ones.
> **Warning:** This function **must** be called on both the client and server in [GM:Initialize](https://wiki.facepunch.com/gmod/GM:Initialize) or you will have unexpected problems.

[wiki](https://wiki.facepunch.com/gmod/game.AddAmmoType) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/game.lua#L24-L40)

---

### game.AddDecal · Shared
`game.AddDecal(decalName: string, materialName: string)`

Registers a new decal.

**Arguments:**
- `decalName` (string) — The name of the decal.
- `materialName` (string) — The material to be used for the decal.

> **Warning:** There's a rather low limit of around 256 for decal materials that may be registered and they are not cleared on map load.

[wiki](https://wiki.facepunch.com/gmod/game.AddDecal)

---

### game.AddParticles · Shared
`game.AddParticles(particleFileName: string)`

Loads a particle file. Individual particle systems will still need to be precached with [PrecacheParticleSystem](https://wiki.facepunch.com/gmod/Global.PrecacheParticleSystem).

**Arguments:**
- `particleFileName` (string) — The path of the file to add.

> **Note:** You will still need to call this function clientside regardless if you create the particle effects serverside.

[wiki](https://wiki.facepunch.com/gmod/game.AddParticles)

---

### game.BuildAmmoTypes · Shared · `INTERNAL`
`game.BuildAmmoTypes() → table`

Called by the engine to retrieve the ammo types.

**Returns:**
- table — All ammo types registered via game.AddAmmoType, sorted by its name value.

[wiki](https://wiki.facepunch.com/gmod/game.BuildAmmoTypes) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/game.lua#L46-L54)

---

### game.CleanUpMap · Shared
`game.CleanUpMap(dontSendToClients: boolean = false, extraFilters: table = {}, callback: function = nil)`

Removes most entities, and then respawns entities created by the map, as if the map was just loaded.

There are certain exclusions, such as players or weapons held by players, soundscapes and others.  
[EFL_KEEP_ON_RECREATE_ENTITIES](https://wiki.facepunch.com/gmod/enums/EFL) can be set on entities to preserve them through a map cleanup.

On the client it will remove decals, sounds, gibs, dead NPCs, and entities created via [ents.CreateClientProp](https://wiki.facepunch.com/gmod/ents.CreateClientProp). This function is ran on all clients from server automatically, when it is called on the server.

This function calls [GM:PreCleanupMap](https://wiki.facepunch.com/gmod/GM:PreCleanupMap) before cleaning up the map and [GM:PostCleanupMap](https://wiki.facepunch.com/gmod/GM:PostCleanupMap) after cleaning up the map.

Beware of calling this function in hooks that may be called on map clean up (such as [ENTITY:StartTouch](https://wiki.facepunch.com/gmod/ENTITY:StartTouch)) to avoid infinite loops.

**Arguments:**
- `dontSendToClients` (boolean, default `false`) — If set to `true`, don't run this functions on all clients.
- `extraFilters` (table, default `{}`) — Entity classes not to reset during cleanup.
- `callback` (function, default `nil`) — If set, delays the map cleanup until the end of a server tick, allowing bypassing the entity limit on maps with large amounts of them.

> **Bug** ([#2874](https://github.com/Facepunch/garrysmod/issues/2874)): Calling this destroys all BASS streams.
> **Bug** ([#6105](https://github.com/Facepunch/garrysmod/issues/6105)): The EFL_KEEP_ON_RECREATE_ENTITIES flag doesn't prevent an entity from being recreated, which means flagged entities will be duplicated since they are both kept and recreated.

[wiki](https://wiki.facepunch.com/gmod/game.CleanUpMap)

---

### game.ConsoleCommand · Server
`game.ConsoleCommand(stringCommand: string)`

Runs a console command.
Make sure to add a newline ("\n") at the end of the command.

**Arguments:**
- `stringCommand` (string) — String containing the command and arguments to be ran.

> **Warning:** If you use data that were received from a client, you should avoid using this function because newline and semicolon (at least) allow the client to run arbitrary commands!
> 
> For safety, you are urged to prefer using [RunConsoleCommand](https://wiki.facepunch.com/gmod/Global.RunConsoleCommand) in this case.

[wiki](https://wiki.facepunch.com/gmod/game.ConsoleCommand)

---

### game.Get3DSkyboxInfo · Shared · `NEW`
`game.Get3DSkyboxInfo() → table<Structures/Sky3DParams>`

Returns information about the currently active 3D skybox.

**Returns:**
- `sky3dparams` (table<Structures/Sky3DParams>) — The 3D skybox info, or `nil` if the map has no 3d skybox or the function is called too soon during server start up.

[wiki](https://wiki.facepunch.com/gmod/game.Get3DSkyboxInfo)

---

### game.GetAmmoDamageType · Shared
`game.GetAmmoDamageType(id: number) → number`

Returns the damage type of given ammo type.

**Arguments:**
- `id` (number) — Ammo ID to retrieve the damage type of.

**Returns:**
- number — See DMG.

[wiki](https://wiki.facepunch.com/gmod/game.GetAmmoDamageType)

---

### game.GetAmmoData · Shared
`game.GetAmmoData(id: number) → table{AmmoData}`

Returns the [Structures/AmmoData](https://wiki.facepunch.com/gmod/Structures/AmmoData) for given ID.

**Arguments:**
- `id` (number) — ID of the ammo type to look up the data for.

**Returns:**
- table{AmmoData} — The Structures/AmmoData containing all ammo data.

[wiki](https://wiki.facepunch.com/gmod/game.GetAmmoData)

---

### game.GetAmmoForce · Shared
`game.GetAmmoForce(id: number) → number`

Returns the ammo bullet force that is applied when an entity is hit by a bullet of given ammo type.

**Arguments:**
- `id` (number) — Ammo ID to retrieve the force of.

**Returns:**
- number — The ammo force.

[wiki](https://wiki.facepunch.com/gmod/game.GetAmmoForce)

---

### game.GetAmmoID · Shared
`game.GetAmmoID(name: string) → number`

Returns the ammo type ID for given ammo type name.

See [game.GetAmmoName](https://wiki.facepunch.com/gmod/game.GetAmmoName) for reverse.

**Arguments:**
- `name` (string) — Name of the ammo type to look up ID of.

**Returns:**
- number — The ammo type ID of given ammo type name, or -1 if not found.

[wiki](https://wiki.facepunch.com/gmod/game.GetAmmoID)

---

### game.GetAmmoMax · Shared
`game.GetAmmoMax(id: number) → number`

Returns the real maximum amount of ammo of given ammo ID, regardless of the setting of `gmod_maxammo` convar.

**Arguments:**
- `id` (number) — Ammo type ID.

**Returns:**
- number — The maximum amount of reserve ammo a player can hold of this ammo type.

[wiki](https://wiki.facepunch.com/gmod/game.GetAmmoMax)

---

### game.GetAmmoName · Shared
`game.GetAmmoName(id: number) → string`

Returns the ammo name for given ammo type ID.

See [game.GetAmmoID](https://wiki.facepunch.com/gmod/game.GetAmmoID) for reverse.

**Arguments:**
- `id` (number) — Ammo ID to retrieve the name of.

**Returns:**
- string — The name of given ammo type ID or nil if ammo type ID is invalid.

[wiki](https://wiki.facepunch.com/gmod/game.GetAmmoName)

---

### game.GetAmmoNPCDamage · Shared
`game.GetAmmoNPCDamage(id: number) → number`

Returns the damage given ammo type should do to NPCs.

**Arguments:**
- `id` (number) — Ammo ID to retrieve the damage info of.

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/game.GetAmmoNPCDamage)

---

### game.GetAmmoPlayerDamage · Shared
`game.GetAmmoPlayerDamage(id: number) → number`

Returns the damage given ammo type should do to players.

**Arguments:**
- `id` (number) — Ammo ID to retrieve the damage info of.

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/game.GetAmmoPlayerDamage)

---

### game.GetAmmoTypes · Shared
`game.GetAmmoTypes() → table<number,string>`

Returns a list of all ammo types currently registered.

**Returns:**
- table<number,string> — A table containing all ammo types.

[wiki](https://wiki.facepunch.com/gmod/game.GetAmmoTypes)

---

### game.GetGlobalCounter · Server
`game.GetGlobalCounter(name: string) → number`

Returns the counter of a Global State.

See [Global States](https://wiki.facepunch.com/gmod/Global%20States) for more information.

**Arguments:**
- `name` (string) — The name of the Global State to set.

**Returns:**
- number — The value of the given Global State, 0 if the global state doesn't exist.

[wiki](https://wiki.facepunch.com/gmod/game.GetGlobalCounter)

---

### game.GetGlobalState · Server
`game.GetGlobalState(name: string) → number`

Returns whether a Global State is off, active or dead ( inactive ).

See [Global States](https://wiki.facepunch.com/gmod/Global%20States) for more information.

**Arguments:**
- `name` (string) — The name of the Global State to retrieve the state of.

**Returns:**
- number — The state of the Global State.

[wiki](https://wiki.facepunch.com/gmod/game.GetGlobalState)

---

### game.GetIPAddress · Shared
`game.GetIPAddress() → string`

Returns the public IP address and port of the current server. This will return the IP/port that you are connecting through when ran clientside.

**Returns:**
- string — The IP address and port in the format "x.x.x.x:x".

> **Note:** Returns "loopback" in singleplayer.
> **Bug** ([#3001](https://github.com/Facepunch/garrysmod/issues/3001)): Returns "0.0.0.0:`port`" on the server when called too early, including in [GM:Initialize](https://wiki.facepunch.com/gmod/GM:Initialize) and [GM:InitPostEntity](https://wiki.facepunch.com/gmod/GM:InitPostEntity). This bug seems to only happen the first time a server is launched, and will return the correct value after switching maps.

[wiki](https://wiki.facepunch.com/gmod/game.GetIPAddress)

---

### game.GetMap · Shared, Menu
`game.GetMap() → string`

Returns the name of the current map, without a file extension.
On the menu state, returns "menu".

**Returns:**
- string — The name of the current map, without a file extension.

> **Warning:** In Multiplayer this does not return the current map in the CLIENT realm before [GM:Initialize](https://wiki.facepunch.com/gmod/GM:Initialize).

[wiki](https://wiki.facepunch.com/gmod/game.GetMap)

---

### game.GetMapChangeCount · Server
`game.GetMapChangeCount() → number`

Returns the current map change count for the server.

This is useful to determine whether the current map is the initial map, or whether a `changelevel` (using `map` command is also detected) has occurred at any point in the server's session.

**Returns:**
- number — The current map change count.

[wiki](https://wiki.facepunch.com/gmod/game.GetMapChangeCount)

---

### game.GetMapNext · Server
`game.GetMapNext() → string`

Returns the next map that would be loaded according to the file that is set by the mapcyclefile convar.

**Returns:**
- string — nextMap or nil if called too early.

[wiki](https://wiki.facepunch.com/gmod/game.GetMapNext)

---

### game.GetMapVersion · Server
`game.GetMapVersion() → number, number`

Returns the revision (Not to be confused with [VBSP Version](https://developer.valvesoftware.com/wiki/Source_BSP_File_Format#Versions)) and BSP version of the current map.

Map revision is the amount of times the map file was saved in Hammer at the time of the map being compiled. This is useful to detect when a map has changed.

**Returns:**
- number — Revision of the currently loaded map.
- number — BSP version.

[wiki](https://wiki.facepunch.com/gmod/game.GetMapVersion)

---

### game.GetSkillLevel · Shared
`game.GetSkillLevel() → number`

Returns the difficulty level of the game.

**TIP:** You can use this function in your scripted NPCs or Nextbots to make them stronger, however, it is a good idea to lock powerful attacks behind the highest difficulty instead of just increasing the health.

**Returns:**
- number — The difficulty level, Easy (1), Normal (2), Hard (3).

> **Note:** Internally this is tied to the gamerules entity, so you'll have to wait until [GM:InitPostEntity](https://wiki.facepunch.com/gmod/GM:InitPostEntity) is called to return the skill level.

[wiki](https://wiki.facepunch.com/gmod/game.GetSkillLevel)

---

### game.GetTimeScale · Shared
`game.GetTimeScale() → number`

Returns the time scale set with [game.SetTimeScale](https://wiki.facepunch.com/gmod/game.SetTimeScale).

		If you want to get the value of `host_timescale`, use:
		```lua
local timescale = GetConVar( "host_timescale" ):GetFloat()
```

**Returns:**
- number — The time scale.

[wiki](https://wiki.facepunch.com/gmod/game.GetTimeScale)

---

### game.GetWindSpeed · Shared · `NEW`
`game.GetWindSpeed(pos: Vector = nil) → Vector`

Returns the wind's velocity at a given position, as influenced by current map's [env_wind](https://developer.valvesoftware.com/wiki/Env_wind) entities.

**Arguments:**
- `pos` (Vector, default `nil`) — The point to get wind speed at.

**Returns:**
- `windVelocity` (Vector) — `windDir * windSpeed` — the current wind direction multiplied by the current total wind speed.

[wiki](https://wiki.facepunch.com/gmod/game.GetWindSpeed)

---

### game.GetWorld · Shared
`game.GetWorld() → Entity`

Returns the worldspawn entity.

**Returns:**
- Entity — The world.

[wiki](https://wiki.facepunch.com/gmod/game.GetWorld)

---

### game.IsDedicated · Shared
`game.IsDedicated() → boolean`

Returns true if the server is a dedicated server, false if it is a listen server or a singleplayer game.

**Returns:**
- boolean — Is the server dedicated or not.

[wiki](https://wiki.facepunch.com/gmod/game.IsDedicated)

---

### game.KickID · Server
`game.KickID(id: string, reason: string = No reason given)`

Kicks a player from the server. This can be ran before the player has spawned.

**Arguments:**
- `id` (string) — UserID, SteamID or SteamID64 of the player to kick.
- `reason` (string, default `No reason given`) — Reason to display to the player.

[wiki](https://wiki.facepunch.com/gmod/game.KickID)

---

### game.LoadNextMap · Server
`game.LoadNextMap()`

Loads the next map according to the `nextlevel` convar, or from the current `mapcyclefile` set by the respective convar.

[wiki](https://wiki.facepunch.com/gmod/game.LoadNextMap)

---

### game.MapLoadType · Server
`game.MapLoadType() → string`

Returns the map load type of the current map.

After changing the map with the console command `changelevel`, "newgame" is returned. With `changelevel2` (single player only), "transition" is returned.

**Returns:**
- string — The load type.

[wiki](https://wiki.facepunch.com/gmod/game.MapLoadType)

---

### game.MaxPlayers · Shared
`game.MaxPlayers() → number`

Returns the maximum amount of players (including bots) that the server can have.

**Returns:**
- number — The maximum amount of players.

[wiki](https://wiki.facepunch.com/gmod/game.MaxPlayers)

---

### game.MountGMA · Shared
`game.MountGMA(path: string) → boolean, table`

Mounts a GMA addon from the disk.
Can be used with [steamworks.DownloadUGC](https://wiki.facepunch.com/gmod/steamworks.DownloadUGC).

**Arguments:**
- `path` (string) — Location of the GMA file to mount, retrieved from steamworks.DownloadUGC or relative to the `garrysmod/` directory (ignores mounting).

**Returns:**
- boolean — success.
- table — If successful, a table of files that have been mounted.

> **Note:** Any error models currently loaded that the mounted addon provides will be reloaded.
> 
> 
> Any error materials currently loaded that the mounted addon provides will NOT be reloaded. That means that this cannot be used to fix missing map materials, as the map materials are loaded before you are able to call this.

[wiki](https://wiki.facepunch.com/gmod/game.MountGMA)

---

### game.RemoveRagdolls · Shared
`game.RemoveRagdolls()`

Removes all the clientside ragdolls. On server, it will remove all `prop_ragdolls` that have the `SF_RAGDOLLPROP_USE_LRU_RETIREMENT` (4096) spawnflag.

[wiki](https://wiki.facepunch.com/gmod/game.RemoveRagdolls)

---

### game.SetGlobalCounter · Server
`game.SetGlobalCounter(name: string, count: number)`

Sets the counter of a Global State.

See [Global States](https://wiki.facepunch.com/gmod/Global%20States) for more information.

**Arguments:**
- `name` (string) — The name of the Global State to set.
- `count` (number) — The value to set for that Global State.

[wiki](https://wiki.facepunch.com/gmod/game.SetGlobalCounter)

---

### game.SetGlobalState · Server
`game.SetGlobalState(name: string, state: number)`

Sets whether a Global State is off, active or dead ( inactive ).

See [Global States](https://wiki.facepunch.com/gmod/Global%20States) for more information.

**Arguments:**
- `name` (string) — The name of the Global State to set.
- `state` (number, enum [GLOBAL](https://wiki.facepunch.com/gmod/Enums/GLOBAL)) — The state of the Global State.

[wiki](https://wiki.facepunch.com/gmod/game.SetGlobalState)

---

### game.SetSkillLevel · Server
`game.SetSkillLevel(level: number)`

Sets the difficulty level of the game, can be retrieved with [game.GetSkillLevel](https://wiki.facepunch.com/gmod/game.GetSkillLevel).

This will automatically change whenever the "skill" convar is modified serverside.

**Arguments:**
- `level` (number) — The difficulty level, Easy( 1 ), Normal( 2 ), Hard( 3 ).

[wiki](https://wiki.facepunch.com/gmod/game.SetSkillLevel)

---

### game.SetTimeScale · Server
`game.SetTimeScale(timeScale: number)`

Sets the time scale of the game.

This function is supposed to remove the need of using the host_timescale convar, which is cheat protected.  

To slow down or speed up the movement of a specific player, use [Player:SetLaggedMovementValue](https://wiki.facepunch.com/gmod/Player:SetLaggedMovementValue) instead.

**Arguments:**
- `timeScale` (number) — The new timescale, minimum value is 0.001 and maximum is 5.

> **Note:** The true timescale will be `host_timescale` multiplied by [game.GetTimeScale](https://wiki.facepunch.com/gmod/game.GetTimeScale).
> **Note:** Like host_timescale, this method does not affect sounds, if you wish to change that, look into [GM:EntityEmitSound](https://wiki.facepunch.com/gmod/GM:EntityEmitSound).

[wiki](https://wiki.facepunch.com/gmod/game.SetTimeScale)

---

### game.SinglePlayer · Shared
`game.SinglePlayer() → boolean`

Returns whether the current session is a single player game.

**Returns:**
- boolean — isSinglePlayer.

[wiki](https://wiki.facepunch.com/gmod/game.SinglePlayer)

---

### game.StartSpot · Server
`game.StartSpot() → string`

Returns the name of the entity that should be used as player start position.

This is not the same thing as spawn points (See [GM:PlayerSelectSpawn](https://wiki.facepunch.com/gmod/GM:PlayerSelectSpawn) for that), this is used to properly transit the player between maps, and therefore will only be set after a level change via `trigger_changelevel` entity in singleplayer.

**Returns:**
- string — The name of the entity that should be used as start position.

[wiki](https://wiki.facepunch.com/gmod/game.StartSpot)

# Player

**Realm:** Shared  ·  **Members:** 270

This is a list of all methods only available for players. It is also possible to call [Entity](https://wiki.facepunch.com/gmod/Entity) functions on the Player.

[wiki page](https://wiki.facepunch.com/gmod/Player)

> **Part 2 of 2** (`SprintDisable` – `VoiceVolume`). All parts: [1](Player.md), [2](Player-2.md)


### Player:SprintDisable · Server
`Player:SprintDisable()`

Disables the sprint on the player.

[wiki](https://wiki.facepunch.com/gmod/Player:SprintDisable)

---

### Player:SprintEnable · Server
`Player:SprintEnable()`

Enables the sprint on the player.

[wiki](https://wiki.facepunch.com/gmod/Player:SprintEnable)

---

### Player:StartSprinting · Shared · `DEPRECATED`
`Player:StartSprinting()`

Doesn't appear to do anything.

[wiki](https://wiki.facepunch.com/gmod/Player:StartSprinting)

---

### Player:StartWalking · Shared · `DEPRECATED`
`Player:StartWalking()`

When used in a [GM:SetupMove](https://wiki.facepunch.com/gmod/GM:SetupMove) hook, this function will force the player to walk, as well as preventing the player from sprinting.

[wiki](https://wiki.facepunch.com/gmod/Player:StartWalking)

---

### Player:SteamID · Shared
`Player:SteamID() → string`

Returns the player's SteamID.

See [Player:AccountID](https://wiki.facepunch.com/gmod/Player:AccountID) for a shorter version of the SteamID and [Player:SteamID64](https://wiki.facepunch.com/gmod/Player:SteamID64) for the full SteamID.

It is recommended to use [Player:SteamID64](https://wiki.facepunch.com/gmod/Player:SteamID64) over the other SteamID formats whenever possible.

**Returns:**
- string — "Text" representation of the player's SteamID.

> **Note:** In a `-multirun` environment, this will return `STEAM_ID_LAN` for all "copies" of a player because they are not authenticated with Steam.
> 
> For Bots this will return `BOT`.

[wiki](https://wiki.facepunch.com/gmod/Player:SteamID)

---

### Player:SteamID64 · Shared
`Player:SteamID64() → string`

Returns the player's full **64-bit SteamID**, also known as **CommunityID**. Information on how data is packed into this value can be found [here](https://developer.valvesoftware.com/wiki/SteamID).

See [Player:AccountID](https://wiki.facepunch.com/gmod/Player:AccountID) for a function that returns only the Account ID part of the SteamID and [Player:SteamID](https://wiki.facepunch.com/gmod/Player:SteamID) for the text version of the SteamID.

**Returns:**
- string — Player's 64-bit SteamID aka CommunityID.

> **Note:** In a `-multirun` environment, this will return `"0"` for all "copies" of a player because they are not authenticated with Steam.
> 
> For bots, this will return `90071996842377216` (equivalent to `STEAM_0:0:0`) for the first bot to join.
> 
> For each additional bot, the number increases by 1. So the next bot will be `90071996842377217` (`STEAM_0:1:0`) then `90071996842377218` (`STEAM_0:0:1`) and so on.

[wiki](https://wiki.facepunch.com/gmod/Player:SteamID64)

---

### Player:StopSprinting · Shared · `DEPRECATED`
`Player:StopSprinting()`

When used in a [GM:SetupMove](https://wiki.facepunch.com/gmod/GM:SetupMove) hook, this function will prevent the player from sprinting.

When +walk is engaged, the player will still be able to sprint to half speed (normal run speed) as opposed to full sprint speed without this function.

[wiki](https://wiki.facepunch.com/gmod/Player:StopSprinting)

---

### Player:StopWalking · Shared · `DEPRECATED`
`Player:StopWalking()`

When used in a [GM:SetupMove](https://wiki.facepunch.com/gmod/GM:SetupMove) hook, this function behaves unexpectedly by preventing the player from sprinting similar to [Player:StopSprinting](https://wiki.facepunch.com/gmod/Player:StopSprinting).

[wiki](https://wiki.facepunch.com/gmod/Player:StopWalking)

---

### Player:StopZooming · Server
`Player:StopZooming()`

Turns off the zoom mode of the player. (+zoom console command)

Basically equivalent of entering "-zoom" into player's console.

[wiki](https://wiki.facepunch.com/gmod/Player:StopZooming)

---

### Player:StripAmmo · Server · `DEPRECATED`
`Player:StripAmmo()`

Removes all ammo from the player.

[wiki](https://wiki.facepunch.com/gmod/Player:StripAmmo)

---

### Player:StripWeapon · Server
`Player:StripWeapon(weapon: string)`

Removes the specified weapon class from a certain player

**Arguments:**
- `weapon` (string) — The weapon class to remove

> **Note:** this function will call the [Entity:OnRemove](https://wiki.facepunch.com/gmod/Entity:OnRemove) but if you try use [Entity:GetOwner](https://wiki.facepunch.com/gmod/Entity:GetOwner) it will return nil

[wiki](https://wiki.facepunch.com/gmod/Player:StripWeapon)

---

### Player:StripWeapons · Server
`Player:StripWeapons()`

Removes all weapons from a certain player

[wiki](https://wiki.facepunch.com/gmod/Player:StripWeapons)

---

### Player:SuppressHint · Server
`Player:SuppressHint(name: string)`

Prevents a hint from showing up.

**Arguments:**
- `name` (string) — Hint name/class/index to prevent from showing up.

> **Note:** This function is only available in Sandbox and its derivatives

[wiki](https://wiki.facepunch.com/gmod/Player:SuppressHint) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/player_extension.lua#L129-L137)

---

### Player:SwitchToDefaultWeapon · Server
`Player:SwitchToDefaultWeapon()`

Attempts to switch the player weapon to the one specified in the "cl_defaultweapon" convar, if the player does not own the specified weapon nothing will happen.

If you want to switch to a specific weapon, use: [Player:SetActiveWeapon](https://wiki.facepunch.com/gmod/Player:SetActiveWeapon)

[wiki](https://wiki.facepunch.com/gmod/Player:SwitchToDefaultWeapon) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L166-L177)

---

### Player:Team · Shared
`Player:Team() → number`

Returns the player's team ID, set by [Player:SetTeam](https://wiki.facepunch.com/gmod/Player:SetTeam)

Returns 0 clientside when the game is not fully loaded.

**Returns:**
- number — The player's team's index number, as in the TEAM or a custom team defined in team.SetUp.

[wiki](https://wiki.facepunch.com/gmod/Player:Team)

---

### Player:TimeConnected · Server
`Player:TimeConnected() → number`

Returns the time in seconds since the player connected.

Bots will always return value 0.

**Returns:**
- `connectedTime` (number) — How long this player was connected to the server for, in seconds.

[wiki](https://wiki.facepunch.com/gmod/Player:TimeConnected)

---

### Player:TraceHullAttack · Server
`Player:TraceHullAttack(startPos: Vector, endPos: Vector, mins: Vector, maxs: Vector, damage: number, damageFlags: number, damageForce: number, damageAllNPCs: boolean) → Entity`

Performs a trace hull and applies damage to the entities hit, returns the first entity hit.

**Arguments:**
- `startPos` (Vector) — The start position of the hull trace.
- `endPos` (Vector) — The end position of the hull trace.
- `mins` (Vector) — The minimum coordinates of the hull.
- `maxs` (Vector) — The maximum coordinates of the hull.
- `damage` (number) — The damage to be applied.
- `damageFlags` (number, enum [DMG](https://wiki.facepunch.com/gmod/Enums/DMG)) — Bitflag specifying the damage type, see DMG.
- `damageForce` (number) — The force to be applied to the hit object.
- `damageAllNPCs` (boolean) — Whether to apply damage to all hit NPCs or not.

**Returns:**
- Entity — The hit entity

> **Warning:** Hitting the victim entity with this function in [ENTITY:OnTakeDamage](https://wiki.facepunch.com/gmod/ENTITY:OnTakeDamage) can cause infinite loops.

[wiki](https://wiki.facepunch.com/gmod/Player:TraceHullAttack)

---

### Player:TranslateWeaponActivity · Shared
`Player:TranslateWeaponActivity(act: number) → number`

Translates [ACT](https://wiki.facepunch.com/gmod/Enums/ACT) according to the holdtype of players currently held weapon.

**Arguments:**
- `act` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The initial ACT

**Returns:**
- number — Translated ACT

[wiki](https://wiki.facepunch.com/gmod/Player:TranslateWeaponActivity)

---

### Player:UnfreezePhysicsObjects · Shared
`Player:UnfreezePhysicsObjects()`

Unfreezes all objects the player has frozen with their Physics Gun. Same as double pressing  while holding Physics Gun.

[wiki](https://wiki.facepunch.com/gmod/Player:UnfreezePhysicsObjects) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/obj_player_extend.lua#L98-L153)

---

### Player:UniqueID · Shared · `DEPRECATED`
`Player:UniqueID() → number`

Returns a 32 bit integer that remains constant for a player across joins/leaves and across different servers. This can be used when a string is inappropriate - e.g. in a database primary key.

**Returns:**
- number — The player's Unique ID

> **Note:** In Singleplayer, this function will always return 1.
> **Bug** ([#6389](https://github.com/Facepunch/garrysmod/issues/6389)): In a `-multirun` environment, the value returned is different on the serverside and clientside.

[wiki](https://wiki.facepunch.com/gmod/Player:UniqueID)

---

### Player:UniqueIDTable · Shared
`Player:UniqueIDTable(key: any) → table`

Returns a table that will stay allocated for the specific player serverside between connects until the server shuts down or change map. On client it has no such special behavior.

**Arguments:**
- `key` (any) — Unique table key.

**Returns:**
- table — The table that contains any info you have put in it.

> **Note:** This table is not synchronized (networked) between client and server.

[wiki](https://wiki.facepunch.com/gmod/Player:UniqueIDTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/obj_player_extend.lua#L157-L170)

---

### Player:UnLock · Server
`Player:UnLock()`

Unlocks the player movement if locked previously.

Will disable godmode for the player if locked previously.

[wiki](https://wiki.facepunch.com/gmod/Player:UnLock)

---

### Player:UnSpectate · Server
`Player:UnSpectate()`

Stops the player from spectating another entity.

> **Warning:** The player must be respawned, otherwise they will be able to walk through doors and become invincible.

[wiki](https://wiki.facepunch.com/gmod/Player:UnSpectate)

---

### Player:UserID · Shared
`Player:UserID() → number`

Returns the player's user ID. This number will always be unique, but will reset if the player reconnects. (Always increments for each connecting player)

You can use [Player](https://wiki.facepunch.com/gmod/Global.Player) global function to get a player by their user ID.

**Returns:**
- number — The player's user ID

[wiki](https://wiki.facepunch.com/gmod/Player:UserID)

---

### Player:ViewPunch · Shared
`Player:ViewPunch(punchAngle: Angle)`

Simulates a push on the client's screen. This **adds** view punch velocity, and does not reset the current view punch angle, for which you can use [Player:SetViewPunchAngles](https://wiki.facepunch.com/gmod/Player:SetViewPunchAngles).

**Arguments:**
- `punchAngle` (Angle) — The angle in which to push the player's screen.

> **Note:** Despite being defined shared, it only functions when called server-side.

[wiki](https://wiki.facepunch.com/gmod/Player:ViewPunch)

---

### Player:ViewPunchReset · Shared
`Player:ViewPunchReset(tolerance: number = 0)`

Resets the player's view punch (and the view punch velocity, read more at [Player:ViewPunch](https://wiki.facepunch.com/gmod/Player:ViewPunch)) effect back to normal.

**Arguments:**
- `tolerance` (number, default `0`) — Reset all ViewPunch below this threshold.

[wiki](https://wiki.facepunch.com/gmod/Player:ViewPunchReset)

---

### Player:VoiceVolume · Client
`Player:VoiceVolume() → number`

Returns the players voice volume, how loud the player's voice communication currently is, as a number in range of [0,1].

**Returns:**
- number — The voice volume.

[wiki](https://wiki.facepunch.com/gmod/Player:VoiceVolume)

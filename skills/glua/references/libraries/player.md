# player

**Realm:** Shared  ·  **Members:** 12

The player library is used to get the Lua objects that represent players in-game.

[wiki page](https://wiki.facepunch.com/gmod/player)

### player.CreateNextBot · Server
`player.CreateNextBot(botName: string) → Player`

Similar to the serverside command "bot", this function creates a new Player bot with the given name. This bot will not obey to the usual `bot_*` commands, and it's the same bot base used in TF2 and CS:S.

The best way to control the behaviour of a Player bot right now is to use the [GM:StartCommand](https://wiki.facepunch.com/gmod/GM:StartCommand) hook and modify its input serverside.

**Arguments:**
- `botName` (string) — The name of the bot, using an already existing name will append brackets at the end of it with a number pertaining it.

**Returns:**
- Player — The newly created Player bot.

> **Note:** Any Bot created using this method will be considered UnAuthed by Garry's Mod
> **Note:** Despite this Player being fake, it has to be removed from the server by using [Player:Kick](https://wiki.facepunch.com/gmod/Player:Kick) and **NOT** [Entity:Remove](https://wiki.facepunch.com/gmod/Entity:Remove).
> Also keep in mind that these bots still use player slots, so you won't be able to spawn them in singleplayer!

[wiki](https://wiki.facepunch.com/gmod/player.CreateNextBot)

---

### player.GetAll · Shared
`player.GetAll() → table<Player>`

Gets all the current players in the server (not including connecting clients).

This function returns bots as well as human players. See [player.GetBots](https://wiki.facepunch.com/gmod/player.GetBots) and  [player.GetHumans](https://wiki.facepunch.com/gmod/player.GetHumans).

**Returns:**
- table<Player> — All Players currently in the server.

> **Note:** This function returns a sequential table, meaning it should be looped with [ipairs](https://wiki.facepunch.com/gmod/Global.ipairs) instead of [pairs](https://wiki.facepunch.com/gmod/Global.pairs) for efficiency reasons.

[wiki](https://wiki.facepunch.com/gmod/player.GetAll)

---

### player.GetBots · Shared
`player.GetBots() → table<Player>`

Returns a table of all bots on the server.

**Returns:**
- table<Player> — A table only containing bots ( AI / non human players )

[wiki](https://wiki.facepunch.com/gmod/player.GetBots)

---

### player.GetByAccountID · Shared
`player.GetByAccountID(accountID: number) → Player|boolean`

Tried to get the player with the specified [Player:AccountID](https://wiki.facepunch.com/gmod/Player:AccountID).

**Arguments:**
- `accountID` (number) — The Player:AccountID to find the player by.

**Returns:**
- Player|boolean — Player if one is found, `false` otherwise.

> **Warning:** Internally this function iterates over all players in the server, meaning it can be quite expensive in a performance-critical context.

[wiki](https://wiki.facepunch.com/gmod/player.GetByAccountID) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L45-L54)

---

### player.GetByID · Shared
`player.GetByID(connectionID: number) → Player|NULL`

Gets the player with the specified connection ID.

Connection ID can be retrieved via [gameevent.Listen](https://wiki.facepunch.com/gmod/gameevent.Listen) events.

For a function that returns a player based on their [Entity:EntIndex](https://wiki.facepunch.com/gmod/Entity:EntIndex), see [Entity](https://wiki.facepunch.com/gmod/Global.Entity).


For a function that returns a player based on their [Player:UserID](https://wiki.facepunch.com/gmod/Player:UserID), see [Player](https://wiki.facepunch.com/gmod/Global.Player).

**Arguments:**
- `connectionID` (number) — The connection ID to find the player by.

**Returns:**
- Player|NULL — Player if one is found, `NULL` otherwise.

[wiki](https://wiki.facepunch.com/gmod/player.GetByID)

---

### player.GetBySteamID · Shared
`player.GetBySteamID(steamID: string) → Player|boolean`

Gets the player with the specified SteamID.

**Arguments:**
- `steamID` (string) — The Player:SteamID to find the player by.

**Returns:**
- Player|boolean — Player if one is found, `false` otherwise.

> **Warning:** Internally this function iterates over all players in the server, meaning it can be quite expensive in a performance-critical context.

[wiki](https://wiki.facepunch.com/gmod/player.GetBySteamID) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L67-L77)

---

### player.GetBySteamID64 · Shared
`player.GetBySteamID64(steamID64: string) → Player|boolean`

Gets the player with the specified SteamID64.

**Arguments:**
- `steamID64` (string) — The Player:SteamID64 to find the player by.

**Returns:**
- Player|boolean — Player if one is found, `false` otherwise.

> **Warning:** Internally this function iterates over all players in the server, meaning it can be quite expensive in a performance-critical context.

[wiki](https://wiki.facepunch.com/gmod/player.GetBySteamID64) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L79-L89)

---

### player.GetByUniqueID · Shared · `DEPRECATED`
`player.GetByUniqueID(uniqueID: string) → Player|boolean`

Gets the player with the specified uniqueID (not recommended way to identify players).

**Arguments:**
- `uniqueID` (string) — The Player:UniqueID to find the player by.

**Returns:**
- Player|boolean — Player if one is found, `false` otherwise.

> **Warning:** Internally this function iterates over all players in the server, meaning it can be quite expensive in a performance-critical context.
> **Warning:** It is highly recommended to use [player.GetByAccountID](https://wiki.facepunch.com/gmod/player.GetByAccountID), [player.GetBySteamID](https://wiki.facepunch.com/gmod/player.GetBySteamID) or [player.GetBySteamID64](https://wiki.facepunch.com/gmod/player.GetBySteamID64) instead as this function can have collisions ( be same for different people ) while SteamID is guaranteed to unique to each player.

[wiki](https://wiki.facepunch.com/gmod/player.GetByUniqueID) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player.lua#L56-L65)

---

### player.GetCount · Shared
`player.GetCount() → number`

Returns the active player count.

**Returns:**
- number — Number of players.

> **Note:** Players who are currently connecting to the server will not be counted. See function: [player.GetCountConnecting](https://wiki.facepunch.com/gmod/player.GetCountConnecting)
> **Note:** Similar to **#**[player.GetAll](https://wiki.facepunch.com/gmod/player.GetAll)() but with better performance since the player table doesn't have to be generated. If [player.GetAll](https://wiki.facepunch.com/gmod/player.GetAll) is already being called for iteration, then using the **#** operator on the table will be faster than calling this function since it is JITted.

[wiki](https://wiki.facepunch.com/gmod/player.GetCount)

---

### player.GetCountConnecting · Server
`player.GetCountConnecting() → number`

Returns the amount of players connecting to the server, but not yet spawned in.

`player.GetCountConnecting() + player.GetCount()` would result in the total player count on this server.

**Returns:**
- number — Number of players still connecting.

[wiki](https://wiki.facepunch.com/gmod/player.GetCountConnecting)

---

### player.GetHumans · Shared
`player.GetHumans() → table<Player>`

Returns a table containing all human players (non-bot/AI).

Unlike [player.GetAll](https://wiki.facepunch.com/gmod/player.GetAll), this does not include bots.

**Returns:**
- table<Player> — A table containing all human (non-bot/AI) players.

> **Note:** This function returns a sequential table, meaning it should be looped with [ipairs](https://wiki.facepunch.com/gmod/Global.ipairs) instead of [pairs](https://wiki.facepunch.com/gmod/Global.pairs) for efficiency reasons.

[wiki](https://wiki.facepunch.com/gmod/player.GetHumans)

---

### player.Iterator · Shared
`player.Iterator() → function, table<Player>, number`

Returns a [Stateless Iterator](https://www.lua.org/pil/7.3.html) for all players on the server.
		Intended for use in [Generic For-Loops](https://www.lua.org/pil/4.3.5.html).  
		See [ents.Iterator](https://wiki.facepunch.com/gmod/ents.Iterator) for a similar function for all entities.

**Returns:**
- function — The Iterator Function from ipairs.
- table<Player> — Table of all existing Players.
- number — The starting index for the table of players.

> **Note:** Internally, this function uses cached values that are stored in Lua, as opposed to [player.GetAll](https://wiki.facepunch.com/gmod/player.GetAll), which is a C++ function.
> 		Because a call operation from Lua to C++ *and* with a return back to Lua is quite costly, this function will be more efficient than [player.GetAll](https://wiki.facepunch.com/gmod/player.GetAll).

[wiki](https://wiki.facepunch.com/gmod/player.Iterator) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity_iter.lua#L13-L20)

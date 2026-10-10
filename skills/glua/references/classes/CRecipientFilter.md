# CRecipientFilter

**Realm:** Server  ·  **Members:** 16

List of all possible functions to manipulate Recipient Filters. Can be created with [RecipientFilter](https://wiki.facepunch.com/gmod/Global.RecipientFilter).

[wiki page](https://wiki.facepunch.com/gmod/CRecipientFilter)

### CRecipientFilter:AddAllPlayers · Server
`CRecipientFilter:AddAllPlayers()`

Adds all players to the recipient filter.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:AddAllPlayers)

---

### CRecipientFilter:AddPAS · Server
`CRecipientFilter:AddPAS(pos: Vector)`

Adds all players that are in the same [PAS (Potentially Audible Set)](https://developer.valvesoftware.com/wiki/PAS "PAS - Valve Developer Community") as this position.

**Arguments:**
- `pos` (Vector) — A position that players may be able to hear, usually the position of an entity the sound is playing played from.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:AddPAS)

---

### CRecipientFilter:AddPlayer · Server
`CRecipientFilter:AddPlayer(Player: Player)`

Adds a player to the recipient filter

**Arguments:**
- `Player` (Player) — Player to add to the recipient filter.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:AddPlayer)

---

### CRecipientFilter:AddPlayers · Server
`CRecipientFilter:AddPlayers(input: CRecipientFilter|table<Player>)`

Adds players to the recipient filter from a given table or another recipient filter.

**Arguments:**
- `input` (CRecipientFilter|table<Player>) — The filter to add players from.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:AddPlayers)

---

### CRecipientFilter:AddPVS · Server
`CRecipientFilter:AddPVS(Position: Vector)`

Adds all players that are in the same [PVS (Potential Visibility Set)](https://developer.valvesoftware.com/wiki/PVS "PVS - Valve Developer Community") as this position.

**Arguments:**
- `Position` (Vector) — PVS position that players may be able to see.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:AddPVS)

---

### CRecipientFilter:AddRecipientsByTeam · Server
`CRecipientFilter:AddRecipientsByTeam(teamid: number)`

Adds all players that are on the given team to the filter.

**Arguments:**
- `teamid` (number) — Team index to add players from.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:AddRecipientsByTeam)

---

### CRecipientFilter:GetCount · Server
`CRecipientFilter:GetCount() → number`

Returns the number of valid players in the recipient filter.

**Returns:**
- number — Number of valid players in the recipient filter.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:GetCount)

---

### CRecipientFilter:GetPlayers · Server
`CRecipientFilter:GetPlayers() → table<Player>`

Returns a table of all valid players currently in the recipient filter.

**Returns:**
- table<Player> — A table of all valid players currently in the recipient filter.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:GetPlayers)

---

### CRecipientFilter:RemoveAllPlayers · Server
`CRecipientFilter:RemoveAllPlayers()`

Removes all players from the recipient filter.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:RemoveAllPlayers)

---

### CRecipientFilter:RemoveMismatchedPlayers · Server
`CRecipientFilter:RemoveMismatchedPlayers(input: CRecipientFilter)`

Remove players from this recipient filter that are **NOT** present in a given table or recipient filter.

**Arguments:**
- `input` (CRecipientFilter) — The filter that contains a list of players to test against.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:RemoveMismatchedPlayers)

---

### CRecipientFilter:RemovePAS · Server
`CRecipientFilter:RemovePAS(position: Vector)`

Removes all players from the filter that are in [PAS (Potentially Audible Set)](https://developer.valvesoftware.com/wiki/PAS "PAS - Valve Developer Community") for given position.

**Arguments:**
- `position` (Vector) — The position to test

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:RemovePAS)

---

### CRecipientFilter:RemovePlayer · Server
`CRecipientFilter:RemovePlayer(Player: Player)`

Removes the player from the recipient filter.

**Arguments:**
- `Player` (Player) — The player that should be in the recipient filter if you call this function.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:RemovePlayer)

---

### CRecipientFilter:RemovePlayers · Server
`CRecipientFilter:RemovePlayers(input: CRecipientFilter)`

Remove players from this recipient filter that are present in a given table or recipient filter.

**Arguments:**
- `input` (CRecipientFilter) — The filter that contains a list of players to remove.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:RemovePlayers)

---

### CRecipientFilter:RemovePVS · Server
`CRecipientFilter:RemovePVS(pos: Vector)`

Removes all players that can see this [PVS (Potential Visibility Set)](https://developer.valvesoftware.com/wiki/PVS "PVS - Valve Developer Community") from the recipient filter.

**Arguments:**
- `pos` (Vector) — Position that players may be able to see.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:RemovePVS)

---

### CRecipientFilter:RemoveRecipientsByTeam · Server
`CRecipientFilter:RemoveRecipientsByTeam(teamid: number)`

Removes all players that are on the given team from the filter.

**Arguments:**
- `teamid` (number) — Team index to remove players from.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:RemoveRecipientsByTeam)

---

### CRecipientFilter:RemoveRecipientsNotOnTeam · Server
`CRecipientFilter:RemoveRecipientsNotOnTeam(teamid: number)`

Removes all players that are not on the given team from the filter.

**Arguments:**
- `teamid` (number) — Team index.

[wiki](https://wiki.facepunch.com/gmod/CRecipientFilter:RemoveRecipientsNotOnTeam)

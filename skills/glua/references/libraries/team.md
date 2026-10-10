# team

**Realm:** Shared  ·  **Members:** 20

The team library gives you access to the team system built into the Source engine, and allows you to create custom teams and get information about them.

[wiki page](https://wiki.facepunch.com/gmod/team)

### team.AddScore · Shared
`team.AddScore(index: number, increment: number)`

Increases the score of the given team

**Arguments:**
- `index` (number) — Index of the team
- `increment` (number) — Amount to increase the team's score by

[wiki](https://wiki.facepunch.com/gmod/team.AddScore) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L184-L188)

---

### team.BestAutoJoinTeam · Shared
`team.BestAutoJoinTeam() → number`

Returns the team index of the team with the least players. Falls back to TEAM_UNASSIGNED

**Returns:**
- number — Team index

[wiki](https://wiki.facepunch.com/gmod/team.BestAutoJoinTeam) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L190-L211)

---

### team.GetAllTeams · Shared
`team.GetAllTeams() → table`

Returns the real table consisting of information on every defined team

**Returns:**
- table — Team info

[wiki](https://wiki.facepunch.com/gmod/team.GetAllTeams) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L34-L38)

---

### team.GetClass · Shared
`team.GetClass(index: number) → table`

Returns the selectable classes for the given team. This can be added to with [team.SetClass](https://wiki.facepunch.com/gmod/team.SetClass)

**Arguments:**
- `index` (number) — Index of the team

**Returns:**
- table — Selectable classes

[wiki](https://wiki.facepunch.com/gmod/team.GetClass) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L98-L103)

---

### team.GetColor · Shared
`team.GetColor(teamIndex: number) → Color`

Returns the team's color.

**Arguments:**
- `teamIndex` (number) — The team index.

**Returns:**
- Color — The team's color as a Color.

[wiki](https://wiki.facepunch.com/gmod/team.GetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L171-L176)

---

### team.GetName · Shared
`team.GetName(teamIndex: number) → string`

Returns the name of the team.

**Arguments:**
- `teamIndex` (number) — The team index.

**Returns:**
- string — The team name.

[wiki](https://wiki.facepunch.com/gmod/team.GetName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L155-L160)

---

### team.GetPlayers · Shared
`team.GetPlayers(teamIndex: number) → table`

Returns a table with all player of the specified team.

**Arguments:**
- `teamIndex` (number) — The team index.

**Returns:**
- table — A sequential table of Players that belong to the requested team.

> **Note:** This function returns a sequential table, meaning it should be looped with [ipairs](https://wiki.facepunch.com/gmod/Global.ipairs) instead of [pairs](https://wiki.facepunch.com/gmod/Global.pairs) for efficiency reasons.

[wiki](https://wiki.facepunch.com/gmod/team.GetPlayers) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L135-L147)

---

### team.GetScore · Shared
`team.GetScore(teamIndex: number) → number`

Returns the score of the team.

**Arguments:**
- `teamIndex` (number) — The team index.

**Returns:**
- number — score

[wiki](https://wiki.facepunch.com/gmod/team.GetScore) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L149-L153)

---

### team.GetSpawnPoint · Shared
`team.GetSpawnPoint(index: number) → table`

Returns a table of valid spawnpoint classes the team can use. These are set with [team.SetSpawnPoint](https://wiki.facepunch.com/gmod/team.SetSpawnPoint).

**Arguments:**
- `index` (number) — Index of the team

**Returns:**
- table — Valid spawnpoint classes

[wiki](https://wiki.facepunch.com/gmod/team.GetSpawnPoint) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L54-L59)

---

### team.GetSpawnPoints · Shared
`team.GetSpawnPoints(index: number) → table`

Returns a table of valid spawnpoint entities the team can use. These are set with  [team.SetSpawnPoint](https://wiki.facepunch.com/gmod/team.SetSpawnPoint).

**Arguments:**
- `index` (number) — Index of the team

**Returns:**
- table — Valid spawnpoint entities

[wiki](https://wiki.facepunch.com/gmod/team.GetSpawnPoints) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L61-L78)

---

### team.Joinable · Shared
`team.Joinable(index: number) → boolean`

Returns if a team is joinable or not. This is set in [team.SetUp](https://wiki.facepunch.com/gmod/team.SetUp).

**Arguments:**
- `index` (number) — The index of the team.

**Returns:**
- boolean — True if the team is joinable.

[wiki](https://wiki.facepunch.com/gmod/team.Joinable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L47-L52)

---

### team.NumPlayers · Shared
`team.NumPlayers(teamIndex: number) → number`

Returns the amount of players in a team.

**Arguments:**
- `teamIndex` (number) — The team index.

**Returns:**
- number — playerCount

[wiki](https://wiki.facepunch.com/gmod/team.NumPlayers) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L129-L133)

---

### team.SetClass · Shared
`team.SetClass(index: number, classes: any)`

Sets valid classes for use by a team. Classes can be created using [player_manager.RegisterClass](https://wiki.facepunch.com/gmod/player_manager.RegisterClass)

**Arguments:**
- `index` (number) — Index of the team
- `classes` (any) — A class ID or table of class IDs

[wiki](https://wiki.facepunch.com/gmod/team.SetClass) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L89-L96)

---

### team.SetColor · Shared
`team.SetColor(teamIndex: number, color: Color)`

Sets the team's color.

**Arguments:**
- `teamIndex` (number) — The team index.
- `color` (Color) — The team's new color as a Color.

[wiki](https://wiki.facepunch.com/gmod/team.SetColor) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L162-L169)

---

### team.SetScore · Shared
`team.SetScore(index: number, score: number)`

Sets the score of the given team

**Arguments:**
- `index` (number) — Index of the team
- `score` (number) — The team's new score

[wiki](https://wiki.facepunch.com/gmod/team.SetScore) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L178-L182)

---

### team.SetSpawnPoint · Shared
`team.SetSpawnPoint(index: number, classes: any)`

Sets valid spawnpoint classes for use by a team.

**Arguments:**
- `index` (number) — Index of the team
- `classes` (any) — A spawnpoint classname or table of spawnpoint classnames

> **Note:** GM.TeamBased must be set to true for this to work

[wiki](https://wiki.facepunch.com/gmod/team.SetSpawnPoint) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L80-L87)

---

### team.SetUp · Shared
`team.SetUp(teamIndex: number, teamName: string, teamColor: Color, isJoinable: boolean = true)`

Creates a new team. See [GM:CreateTeams](https://wiki.facepunch.com/gmod/GM:CreateTeams) for the hook to call this in.

**Arguments:**
- `teamIndex` (number) — The team index.
- `teamName` (string) — The team name.
- `teamColor` (Color) — The team color.
- `isJoinable` (boolean, default `true`) — Whether the team is joinable or not.

[wiki](https://wiki.facepunch.com/gmod/team.SetUp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L25-L31)

---

### team.TotalDeaths · Shared
`team.TotalDeaths(index: number) → number`

Returns the total number of deaths of all players in the team.

**Arguments:**
- `index` (number) — The team index.

**Returns:**
- number — Total deaths in team.

[wiki](https://wiki.facepunch.com/gmod/team.TotalDeaths) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L105-L115)

---

### team.TotalFrags · Shared
`team.TotalFrags(Entity or number: Entity) → number`

Get's the total frags in a team.

**Arguments:**
- `Entity or number` (Entity) — Entity or number.

**Returns:**
- number — index

[wiki](https://wiki.facepunch.com/gmod/team.TotalFrags) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L117-L127)

---

### team.Valid · Shared
`team.Valid(index: number) → boolean`

Returns true if the given team index is valid

**Arguments:**
- `index` (number) — Index of the team

**Returns:**
- boolean — Is valid

[wiki](https://wiki.facepunch.com/gmod/team.Valid) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/team.lua#L40-L45)

# navmesh

**Realm:** Server  ·  **Members:** 27

The navigation mesh library. To be used with [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

The navigation mesh is used by [NextBot](https://wiki.facepunch.com/gmod/NextBot) to calculate path to its target.

[wiki page](https://wiki.facepunch.com/gmod/navmesh)

### navmesh.AddWalkableSeed · Server
`navmesh.AddWalkableSeed(pos: Vector, dir: Vector)`

Add this position and normal to the list of walkable positions, used before map generation with [navmesh.BeginGeneration](https://wiki.facepunch.com/gmod/navmesh.BeginGeneration)

**Arguments:**
- `pos` (Vector) — The terrain position.
- `dir` (Vector) — The normal of this terrain position.

[wiki](https://wiki.facepunch.com/gmod/navmesh.AddWalkableSeed)

---

### navmesh.BeginGeneration · Server
`navmesh.BeginGeneration()`

Starts the generation of a new navmesh.

> **Note:** This process is highly resource intensive and it's not wise to use during normal gameplay

[wiki](https://wiki.facepunch.com/gmod/navmesh.BeginGeneration)

---

### navmesh.ClearWalkableSeeds · Server
`navmesh.ClearWalkableSeeds()`

Clears all the walkable positions, used before calling [navmesh.BeginGeneration](https://wiki.facepunch.com/gmod/navmesh.BeginGeneration).

[wiki](https://wiki.facepunch.com/gmod/navmesh.ClearWalkableSeeds)

---

### navmesh.CreateNavArea · Server
`navmesh.CreateNavArea(corner: Vector, opposite_corner: Vector) → CNavArea`

Creates a new [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

**Arguments:**
- `corner` (Vector) — The first corner of the new CNavArea
- `opposite_corner` (Vector) — The opposite (diagonally) corner of the new CNavArea

**Returns:**
- CNavArea — The new CNavArea or nil if we failed for some reason.

[wiki](https://wiki.facepunch.com/gmod/navmesh.CreateNavArea)

---

### navmesh.CreateNavLadder · Server
`navmesh.CreateNavLadder(top: Vector, bottom: Vector, width: number, dir: Vector, maxHeightAboveTopArea: number = 0) → CNavLadder`

Creates a new [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder).

**Arguments:**
- `top` (Vector) — The top position of the ladder.
- `bottom` (Vector) — The bottom position of the ladder.
- `width` (number) — Width for the new ladder.
- `dir` (Vector) — Directional vector in which way the ladder should be facing.
- `maxHeightAboveTopArea` (number, default `0`) — If above 0, will limit how much the top of the ladder can be adjusted to the closest CNavArea when automatically connecting the newly created ladder to pre-existing nav areas.

**Returns:**
- CNavLadder — The new CNavLadder or nil if we failed for some reason.

[wiki](https://wiki.facepunch.com/gmod/navmesh.CreateNavLadder)

---

### navmesh.Find · Server
`navmesh.Find(pos: Vector, radius: number, stepHeight: number, dropHeight: number) → table`

Returns a list of areas within distance, used to find hiding spots by [NextBot](https://wiki.facepunch.com/gmod/NextBot)s for example.

**Arguments:**
- `pos` (Vector) — The position to search around.
- `radius` (number) — Radius to search within
- `stepHeight` (number) — Maximum step up height allowed
- `dropHeight` (number) — Maximum step down (fall distance) allowed

**Returns:**
- table — A list of found CNavAreas.

[wiki](https://wiki.facepunch.com/gmod/navmesh.Find)

---

### navmesh.FindInBox · Server
`navmesh.FindInBox(pos1: Vector, pos2: Vector) → table`

Returns a list of [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s overlapping the given cube extents.

**Arguments:**
- `pos1` (Vector) — The start position of the cube to search in.
- `pos2` (Vector) — The "end" position of the cube to search in.

**Returns:**
- table — A list of found CNavAreas.

[wiki](https://wiki.facepunch.com/gmod/navmesh.FindInBox)

---

### navmesh.GetAllNavAreas · Server
`navmesh.GetAllNavAreas() → table<CNavArea>`

Returns an integer indexed table of all [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s on the current map. If the map doesn't have a navmesh generated then this will return an empty table.

**Returns:**
- table<CNavArea> — A table of all the CNavAreas on the current map.

[wiki](https://wiki.facepunch.com/gmod/navmesh.GetAllNavAreas)

---

### navmesh.GetBlockedAreas · Server
`navmesh.GetBlockedAreas() → table`

Returns a table of all blocked [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s on the current map. See [CNavArea:MarkAsBlocked](https://wiki.facepunch.com/gmod/CNavArea:MarkAsBlocked).

**Returns:**
- table — A table of all the blocked CNavAreas on the current map.

[wiki](https://wiki.facepunch.com/gmod/navmesh.GetBlockedAreas)

---

### navmesh.GetEditCursorPosition · Server
`navmesh.GetEditCursorPosition() → Vector`

Returns the position of the edit cursor when nav_edit is set to 1.

**Returns:**
- Vector — The position of the edit cursor.

[wiki](https://wiki.facepunch.com/gmod/navmesh.GetEditCursorPosition)

---

### navmesh.GetGroundHeight · Server
`navmesh.GetGroundHeight(pos: Vector) → number, Vector`

Finds the closest standable ground at, above, or below the provided position.

**Arguments:**
- `pos` (Vector) — Position to find the closest ground for.

**Returns:**
- number — The height of the ground layer.
- Vector — The normal of the ground layer.

> **Note:** The ground must have at least 32 units of empty space above it to be considered by this function, unless 16 layers are tested without finding valid ground.

[wiki](https://wiki.facepunch.com/gmod/navmesh.GetGroundHeight)

---

### navmesh.GetMarkedArea · Server
`navmesh.GetMarkedArea() → CNavArea`

Returns the currently marked [CNavArea](https://wiki.facepunch.com/gmod/CNavArea), for use with editing console commands.

**Returns:**
- CNavArea — The currently marked CNavArea.

[wiki](https://wiki.facepunch.com/gmod/navmesh.GetMarkedArea)

---

### navmesh.GetMarkedLadder · Server
`navmesh.GetMarkedLadder() → CNavLadder`

Returns the currently marked [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder), for use with editing console commands.

**Returns:**
- CNavLadder — The currently marked CNavLadder.

[wiki](https://wiki.facepunch.com/gmod/navmesh.GetMarkedLadder)

---

### navmesh.GetNavArea · Server
`navmesh.GetNavArea(pos: Vector, beneathLimit: number) → CNavArea`

Returns the Nav Area contained in this position that also satisfies the elevation limit.

This function will properly see blocked [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s. See [navmesh.GetNearestNavArea](https://wiki.facepunch.com/gmod/navmesh.GetNearestNavArea).

**Arguments:**
- `pos` (Vector) — The position to search for.
- `beneathLimit` (number) — The elevation limit at which the Nav Area will be searched.

**Returns:**
- CNavArea — The nav area.

[wiki](https://wiki.facepunch.com/gmod/navmesh.GetNavArea)

---

### navmesh.GetNavAreaByID · Server
`navmesh.GetNavAreaByID(id: number) → CNavArea`

Returns a [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) by the given ID.

**Arguments:**
- `id` (number) — ID of the CNavArea to get.

**Returns:**
- CNavArea — The CNavArea with given ID.

> **Note:** Avoid calling this function every frame, as internally it does a lookup trough all the [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s, call this once and store the result

[wiki](https://wiki.facepunch.com/gmod/navmesh.GetNavAreaByID)

---

### navmesh.GetNavAreaCount · Server
`navmesh.GetNavAreaCount() → number`

Returns the total count of nav areas on the map. If you want to get all nav areas, use [navmesh.GetAllNavAreas](https://wiki.facepunch.com/gmod/navmesh.GetAllNavAreas) instead as nav areas IDs are not always sequential.

**Returns:**
- number — The total count of nav areas on the map.

[wiki](https://wiki.facepunch.com/gmod/navmesh.GetNavAreaCount)

---

### navmesh.GetNavLadderByID · Server
`navmesh.GetNavLadderByID(id: number) → CNavLadder`

Returns a [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder) by the given ID.

**Arguments:**
- `id` (number) — ID of the CNavLadder to get.

**Returns:**
- CNavLadder — The CNavLadder with given ID.

[wiki](https://wiki.facepunch.com/gmod/navmesh.GetNavLadderByID)

---

### navmesh.GetNearestNavArea · Server
`navmesh.GetNearestNavArea(pos: Vector, anyZ: boolean = false, maxDist: number = 10000, checkLOS: boolean = false, checkGround: boolean = true, team: number = TEAM_ANY=-2) → CNavArea`

Returns the closest [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) to given position at the same height, or beneath it.

This function will ignore blocked [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s. See [navmesh.GetNavArea](https://wiki.facepunch.com/gmod/navmesh.GetNavArea) for a function that does see blocked areas.

**Arguments:**
- `pos` (Vector) — The position to look from
- `anyZ` (boolean, default `false`) — This argument is ignored and has no effect
- `maxDist` (number, default `10000`) — This is the maximum distance from the given position that the function will look for a CNavArea
- `checkLOS` (boolean, default `false`) — If this is set to true then the function will internally do a util.TraceLine from the starting position to each potential CNavArea with a MASK_NPCSOLID_BRUSHONLY.
- `checkGround` (boolean, default `true`) — If checkGround is true then this function will internally call navmesh.GetNavArea to check if there is a CNavArea directly below the position, and return it if so, before checking anywhere else.
- `team` (number, default `TEAM_ANY=-2`) — This will internally call CNavArea:IsBlocked to check if the target CNavArea is not to be navigated by the given team.

**Returns:**
- CNavArea — The closest CNavArea found with the given parameters, or a NULL CNavArea if one was not found.

[wiki](https://wiki.facepunch.com/gmod/navmesh.GetNearestNavArea)

---

### navmesh.GetPlayerSpawnName · Server
`navmesh.GetPlayerSpawnName() → string`

Returns the classname of the player spawn entity.

**Returns:**
- string — The classname of the spawn point entity.

[wiki](https://wiki.facepunch.com/gmod/navmesh.GetPlayerSpawnName)

---

### navmesh.IsGenerating · Server
`navmesh.IsGenerating() → boolean`

Whether we're currently generating a new navmesh with [navmesh.BeginGeneration](https://wiki.facepunch.com/gmod/navmesh.BeginGeneration).

**Returns:**
- boolean — Whether we're generating a nav mesh or not.

[wiki](https://wiki.facepunch.com/gmod/navmesh.IsGenerating)

---

### navmesh.IsLoaded · Server
`navmesh.IsLoaded() → boolean`

Returns true if a navmesh has been loaded when loading the map.

**Returns:**
- boolean — Whether a navmesh has been loaded when loading the map.

[wiki](https://wiki.facepunch.com/gmod/navmesh.IsLoaded)

---

### navmesh.Load · Server
`navmesh.Load()`

Loads a new navmesh from the .nav file for current map discarding any changes made to the navmesh previously.

> **Warning:** Calling this function too soon, causes the Server to crash!

[wiki](https://wiki.facepunch.com/gmod/navmesh.Load)

---

### navmesh.Reset · Server
`navmesh.Reset()`

Deletes every [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) and [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder) on the map **without saving the changes**.

[wiki](https://wiki.facepunch.com/gmod/navmesh.Reset)

---

### navmesh.Save · Server
`navmesh.Save()`

Saves any changes made to navmesh to the .nav file.

[wiki](https://wiki.facepunch.com/gmod/navmesh.Save)

---

### navmesh.SetMarkedArea · Server
`navmesh.SetMarkedArea(area: CNavArea)`

Sets the [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) as marked, so it can be used with editing console commands.

**Arguments:**
- `area` (CNavArea) — The CNavArea to set as the marked area.

[wiki](https://wiki.facepunch.com/gmod/navmesh.SetMarkedArea)

---

### navmesh.SetMarkedLadder · Server
`navmesh.SetMarkedLadder(area: CNavLadder)`

Sets the [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder) as marked, so it can be used with editing console commands.

**Arguments:**
- `area` (CNavLadder) — The CNavLadder to set as the marked ladder.

[wiki](https://wiki.facepunch.com/gmod/navmesh.SetMarkedLadder)

---

### navmesh.SetPlayerSpawnName · Server
`navmesh.SetPlayerSpawnName(spawnPointClass: string)`

Sets the classname of the default spawn point entity, used before generating a new navmesh with [navmesh.BeginGeneration](https://wiki.facepunch.com/gmod/navmesh.BeginGeneration).

**Arguments:**
- `spawnPointClass` (string) — The classname of what the player uses to spawn, automatically adds it to the walkable positions during map generation.

[wiki](https://wiki.facepunch.com/gmod/navmesh.SetPlayerSpawnName)

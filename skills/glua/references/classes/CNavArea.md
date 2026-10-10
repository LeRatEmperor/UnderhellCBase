# CNavArea

**Realm:** Server  ·  **Members:** 77

An object returned by [navmesh](https://wiki.facepunch.com/gmod/navmesh) functions.

[wiki page](https://wiki.facepunch.com/gmod/CNavArea)

### CNavArea:AddAttributes · Server
`CNavArea:AddAttributes(attribs: number)`

Adds given attributes to given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea). See [CNavArea:HasAttributes](https://wiki.facepunch.com/gmod/CNavArea:HasAttributes) and [CNavArea:SetAttributes](https://wiki.facepunch.com/gmod/CNavArea:SetAttributes).

**Arguments:**
- `attribs` (number, enum [NAV_MESH](https://wiki.facepunch.com/gmod/Enums/NAV_MESH)) — The attributes to add, as a bitflag.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:AddAttributes)

---

### CNavArea:AddHidingSpot · Server
`CNavArea:AddHidingSpot(pos: Vector, flags: number = 7)`

Adds a hiding spot onto this nav area.

There's a limit of 255 hiding spots per area.

**Arguments:**
- `pos` (Vector) — The position on the nav area
- `flags` (number, default `7`) — Flags describing what kind of hiding spot this is.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:AddHidingSpot)

---

### CNavArea:AddToClosedList · Server
`CNavArea:AddToClosedList()`

Adds this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) to the closed list, a list of areas that have been checked by A* pathfinding algorithm.

Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).

More information can be found on the [Simple Pathfinding](https://wiki.facepunch.com/gmod/Simple%20Pathfinding) page.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:AddToClosedList)

---

### CNavArea:AddToOpenList · Server
`CNavArea:AddToOpenList()`

Adds this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) to the Open List.

Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).

More information can be found on the [Simple Pathfinding](https://wiki.facepunch.com/gmod/Simple%20Pathfinding) page.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:AddToOpenList)

---

### CNavArea:ClearSearchLists · Server
`CNavArea:ClearSearchLists()`

Clears the open and closed lists for a new search.

Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).

More information can be found on the [Simple Pathfinding](https://wiki.facepunch.com/gmod/Simple%20Pathfinding) page.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:ClearSearchLists)

---

### CNavArea:ComputeAdjacentConnectionHeightChange · Server
`CNavArea:ComputeAdjacentConnectionHeightChange(navarea: CNavArea) → number`

Returns the height difference between the edges of two connected navareas.

**Arguments:**
- `navarea` (CNavArea)

**Returns:**
- number — The height change

[wiki](https://wiki.facepunch.com/gmod/CNavArea:ComputeAdjacentConnectionHeightChange)

---

### CNavArea:ComputeDirection · Server
`CNavArea:ComputeDirection(pos: Vector) → number`

Returns the [NavDir](https://wiki.facepunch.com/gmod/Enums/NavDir) direction that the given vector faces on this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

**Arguments:**
- `pos` (Vector) — The position to compute direction towards.

**Returns:**
- number — The direction the vector is in relation to this CNavArea.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:ComputeDirection)

---

### CNavArea:ComputeGroundHeightChange · Server
`CNavArea:ComputeGroundHeightChange(navArea: CNavArea) → number`

Returns the height difference on the Z axis of the two [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s. This is calculated from the center most point on both [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s.

**Arguments:**
- `navArea` (CNavArea) — The nav area to test against.

**Returns:**
- number — The ground height change.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:ComputeGroundHeightChange)

---

### CNavArea:ConnectTo · Server
`CNavArea:ConnectTo(area: CNavArea)`

Connects this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) to another [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) or [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder) with a one way connection. ( From this area to the target )

See [CNavLadder:ConnectTo](https://wiki.facepunch.com/gmod/CNavLadder:ConnectTo) for making the connection from ladder to area.

**Arguments:**
- `area` (CNavArea) — The CNavArea or CNavLadder this area leads to.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:ConnectTo)

---

### CNavArea:Contains · Server
`CNavArea:Contains(pos: Vector) → boolean`

Returns true if this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) contains the given vector.

**Arguments:**
- `pos` (Vector) — The position to test.

**Returns:**
- boolean — True if the vector was inside and false otherwise.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:Contains)

---

### CNavArea:Disconnect · Server
`CNavArea:Disconnect(area: CNavArea)`

Disconnects this nav area from given area or ladder. (Only disconnects one way)

**Arguments:**
- `area` (CNavArea) — The CNavArea or CNavLadder this to disconnect from.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:Disconnect)

---

### CNavArea:Draw · Server
`CNavArea:Draw()`

Draws this navarea on debug overlay. (So limitations of [debugoverlay](https://wiki.facepunch.com/gmod/debugoverlay) library apply)

[wiki](https://wiki.facepunch.com/gmod/CNavArea:Draw)

---

### CNavArea:DrawSpots · Server
`CNavArea:DrawSpots()`

Draws the hiding spots on debug overlay. This includes sniper/exposed spots too!

[wiki](https://wiki.facepunch.com/gmod/CNavArea:DrawSpots)

---

### CNavArea:GetAdjacentAreaDistances · Server
`CNavArea:GetAdjacentAreaDistances(dir: number = nil) → table`

Returns a list of all the [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s that have a (one and two way) connection **from** this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) and their pre-computed distances.

If an area has a one-way incoming connection to this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea), then it will **not** be returned from this function, use [CNavArea:GetIncomingConnectionDistances](https://wiki.facepunch.com/gmod/CNavArea:GetIncomingConnectionDistances) to get all one-way incoming connections.

**Arguments:**
- `dir` (number, default `nil`, enum [NavDir](https://wiki.facepunch.com/gmod/Enums/NavDir)) — If set, will only return areas in the specified direction.

**Returns:**
- table — A list of tables in the following format: * CNavArea area - the area that is connected to this area.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetAdjacentAreaDistances)

---

### CNavArea:GetAdjacentAreas · Server
`CNavArea:GetAdjacentAreas() → table`

Returns a list of all the [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s that have a  (one and two way) connection **from** this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

If an area has a one-way incoming connection to this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea), then it will **not** be returned from this function, use [CNavArea:GetIncomingConnections](https://wiki.facepunch.com/gmod/CNavArea:GetIncomingConnections) to get all one-way incoming connections.

See [CNavArea:GetAdjacentAreasAtSide](https://wiki.facepunch.com/gmod/CNavArea:GetAdjacentAreasAtSide) for a function that only returns areas from one side/direction.

**Returns:**
- table — A list of all CNavArea that have a (one and two way) connection from this CNavArea.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetAdjacentAreas)

---

### CNavArea:GetAdjacentAreasAtSide · Server
`CNavArea:GetAdjacentAreasAtSide(navDir: number) → table`

Returns a table of all the [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s that have a ( one and two way ) connection **from** this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) in given direction.

If an area has a one-way incoming connection to this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea), then it will **not** be returned from this function, use [CNavArea:GetIncomingConnections](https://wiki.facepunch.com/gmod/CNavArea:GetIncomingConnections) to get all incoming connections.

See [CNavArea:GetAdjacentAreas](https://wiki.facepunch.com/gmod/CNavArea:GetAdjacentAreas) for a function that returns all areas from all sides/directions.

**Arguments:**
- `navDir` (number, enum [NavDir](https://wiki.facepunch.com/gmod/Enums/NavDir)) — The direction, in which to look for CNavAreas, see NavDir.

**Returns:**
- table — A table of all CNavArea that have a ( one and two way ) connection from this CNavArea in given direction.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetAdjacentAreasAtSide)

---

### CNavArea:GetAdjacentCount · Server
`CNavArea:GetAdjacentCount() → number`

Returns the amount of [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s that have a connection ( one and two way ) **from** this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

See [CNavArea:GetAdjacentCountAtSide](https://wiki.facepunch.com/gmod/CNavArea:GetAdjacentCountAtSide) for a function that only returns area count from one side/direction.

**Returns:**
- number — The amount of CNavAreas that have a connection ( one and two way ) from this CNavArea.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetAdjacentCount)

---

### CNavArea:GetAdjacentCountAtSide · Server
`CNavArea:GetAdjacentCountAtSide(navDir: number) → number`

Returns the amount of [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s that have a connection ( one or two way ) **from** this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) in given direction.

See [CNavArea:GetAdjacentCount](https://wiki.facepunch.com/gmod/CNavArea:GetAdjacentCount) for a function that returns [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) count from/in all sides/directions.

**Arguments:**
- `navDir` (number, enum [NavDir](https://wiki.facepunch.com/gmod/Enums/NavDir)) — The direction, in which to look for CNavAreas, see NavDir.

**Returns:**
- number — The amount of CNavAreas that have a connection ( one or two way ) from this CNavArea in given direction.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetAdjacentCountAtSide)

---

### CNavArea:GetAttributes · Server
`CNavArea:GetAttributes() → number`

Returns the attribute mask for the given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

**Returns:**
- number — Attribute mask for this CNavArea, see NAV_MESH for the specific flags.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetAttributes)

---

### CNavArea:GetCenter · Server
`CNavArea:GetCenter() → Vector`

Returns the center most vector point for the given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

**Returns:**
- Vector — The center vector.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetCenter)

---

### CNavArea:GetClosestPointOnArea · Server
`CNavArea:GetClosestPointOnArea(pos: Vector) → Vector`

Returns the closest point of this Nav Area from the given position.

**Arguments:**
- `pos` (Vector) — The given position, can be outside of the Nav Area bounds.

**Returns:**
- Vector — The closest position on this Nav Area.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetClosestPointOnArea)

---

### CNavArea:GetCorner · Server
`CNavArea:GetCorner(cornerid: number) → Vector`

Returns the vector position of the corner for the given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

**Arguments:**
- `cornerid` (number, enum [NavCorner](https://wiki.facepunch.com/gmod/Enums/NavCorner)) — The target corner to get the position of, takes NavCorner.

**Returns:**
- Vector — The corner position.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetCorner)

---

### CNavArea:GetCostSoFar · Server
`CNavArea:GetCostSoFar() → number`

Returns the cost from starting area this area when pathfinding. Set by [CNavArea:SetCostSoFar](https://wiki.facepunch.com/gmod/CNavArea:SetCostSoFar).

Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).

More information can be found on the [Simple Pathfinding](https://wiki.facepunch.com/gmod/Simple%20Pathfinding) page.

**Returns:**
- number — The cost so far.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetCostSoFar)

---

### CNavArea:GetExposedSpots · Server
`CNavArea:GetExposedSpots() → table`

Returns a table of very bad hiding spots in this area.

See also [CNavArea:GetHidingSpots](https://wiki.facepunch.com/gmod/CNavArea:GetHidingSpots).

**Returns:**
- table — A table of Vectors

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetExposedSpots)

---

### CNavArea:GetExtentInfo · Server
`CNavArea:GetExtentInfo() → table`

Returns size info about the nav area.

**Returns:**
- table — Returns a table containing the following keys: * Vector hi\| * Vector lo\| * number SizeX\| * number SizeY\| * number SizeZ\|

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetExtentInfo)

---

### CNavArea:GetHidingSpots · Server
`CNavArea:GetHidingSpots(type: number = 1) → table`

Returns a table of good hiding spots in this area.

See also [CNavArea:GetExposedSpots](https://wiki.facepunch.com/gmod/CNavArea:GetExposedSpots).

**Arguments:**
- `type` (number, default `1`) — The type of spots to include.

**Returns:**
- table — A table of Vectors

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetHidingSpots)

---

### CNavArea:GetID · Server
`CNavArea:GetID() → number`

Returns this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s unique ID.

**Returns:**
- number — The unique ID.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetID)

---

### CNavArea:GetIncomingConnectionDistances · Server
`CNavArea:GetIncomingConnectionDistances(dir: number = nil) → table`

Returns a table of all the [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s that have a one-way connection **to** this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) and their pre-computed distances.

If a [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) has a two-way connection **to or from** this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) then it will not be returned from this function, use [CNavArea:GetAdjacentAreaDistances](https://wiki.facepunch.com/gmod/CNavArea:GetAdjacentAreaDistances) to get outgoing (one and two way) connections.

**Arguments:**
- `dir` (number, default `nil`, enum [NavDir](https://wiki.facepunch.com/gmod/Enums/NavDir)) — If set, will only return areas in the specified direction.

**Returns:**
- table — A list of tables in the following format: * CNavArea area - the area that is connected to this area.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetIncomingConnectionDistances)

---

### CNavArea:GetIncomingConnections · Server
`CNavArea:GetIncomingConnections() → table<CNavArea>`

Returns a table of all the [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s that have a one-way connection **to** this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

If a [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) has a two-way connection **to or from** this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) then it will not be returned from this function, use [CNavArea:GetAdjacentAreas](https://wiki.facepunch.com/gmod/CNavArea:GetAdjacentAreas) to get outgoing ( one and two way ) connections.

See [CNavArea:GetIncomingConnectionsAtSide](https://wiki.facepunch.com/gmod/CNavArea:GetIncomingConnectionsAtSide) for a function that returns one-way incoming connections from  only one side/direction.

**Returns:**
- table<CNavArea> — A table of all CNavAreas with one-way connection to this CNavArea.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetIncomingConnections)

---

### CNavArea:GetIncomingConnectionsAtSide · Server
`CNavArea:GetIncomingConnectionsAtSide(navDir: number) → table`

Returns a table of all the [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s that have a one-way connection **to** this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) from given direction.

If a [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) has a two-way connection **to or from** this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) then it will not be returned from this function, use [CNavArea:GetAdjacentAreas](https://wiki.facepunch.com/gmod/CNavArea:GetAdjacentAreas) to get outgoing ( one and two way ) connections.

See [CNavArea:GetIncomingConnections](https://wiki.facepunch.com/gmod/CNavArea:GetIncomingConnections) for a function that returns one-way incoming connections from  all sides/directions.

**Arguments:**
- `navDir` (number, enum [NavDir](https://wiki.facepunch.com/gmod/Enums/NavDir)) — The direction, from which to look for CNavAreas, see NavDir.

**Returns:**
- table — A table of all CNavAreas with one-way connection to this CNavArea from given direction.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetIncomingConnectionsAtSide)

---

### CNavArea:GetLadders · Server
`CNavArea:GetLadders() → table<CNavLadder>`

Returns all [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder)s that have a ( one or two way ) connection **from** this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

See [CNavArea:GetLaddersAtSide](https://wiki.facepunch.com/gmod/CNavArea:GetLaddersAtSide) for a function that only returns [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder)s in given direction.

**Returns:**
- table<CNavLadder> — The CNavLadders that have a ( one or two way ) connection from this CNavArea.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetLadders)

---

### CNavArea:GetLaddersAtSide · Server
`CNavArea:GetLaddersAtSide(navDir: number) → table`

Returns all [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder)s that have a ( one or two way ) connection **from** ( one and two way ) this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) in given direction.

See [CNavArea:GetLadders](https://wiki.facepunch.com/gmod/CNavArea:GetLadders) for a function that returns [CNavLadder](https://wiki.facepunch.com/gmod/CNavLadder) from/in all sides/directions.

**Arguments:**
- `navDir` (number) — The direction, in which to look for CNavLadders.

**Returns:**
- table — The CNavLadders that have a ( one or two way ) connection from this CNavArea in given direction.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetLaddersAtSide)

---

### CNavArea:GetParent · Server
`CNavArea:GetParent() → CNavArea`

Returns the parent [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)

**Returns:**
- CNavArea — The parent CNavArea

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetParent)

---

### CNavArea:GetParentHow · Server
`CNavArea:GetParentHow() → number`

Returns how this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) is connected to its parent.

**Returns:**
- number — See NavTraverseType

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetParentHow)

---

### CNavArea:GetPlace · Server
`CNavArea:GetPlace() → string`

Returns the Place of the nav area.

**Returns:**
- string — The place of the nav area, or no value if it doesn't have a place set.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetPlace)

---

### CNavArea:GetRandomAdjacentAreaAtSide · Server
`CNavArea:GetRandomAdjacentAreaAtSide(navDir: number) → CNavArea`

Returns a random [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) that has an outgoing ( one or two way ) connection **from** this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) in given direction.

**Arguments:**
- `navDir` (number, enum [NavDir](https://wiki.facepunch.com/gmod/Enums/NavDir)) — The direction, in which to look for CNavAreas, see NavDir.

**Returns:**
- CNavArea — The random CNavArea that has an outgoing ( one or two way ) connection from this CNavArea in given direction, if any.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetRandomAdjacentAreaAtSide)

---

### CNavArea:GetRandomPoint · Server
`CNavArea:GetRandomPoint() → Vector`

Returns a random point on the nav area.

**Returns:**
- Vector — The random point on the nav area.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetRandomPoint)

---

### CNavArea:GetSizeX · Server
`CNavArea:GetSizeX() → number`

Returns the width this Nav Area.

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetSizeX)

---

### CNavArea:GetSizeY · Server
`CNavArea:GetSizeY() → number`

Returns the height of this Nav Area.

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetSizeY)

---

### CNavArea:GetSpotEncounters · Server
`CNavArea:GetSpotEncounters() → table`

Returns all possible path segments through a [CNavArea](https://wiki.facepunch.com/gmod/CNavArea), and the dangerous spots to look at as we traverse that path segment.

**Returns:**
- `encounters` (table) — A sequential list of spot encounters in the following format: * CNavArea from - What CNavArea the path segment is coming from * Vector from_pos - Origin position of the path segment * number from_dir - Source NavDir direction of the path segment * CNavArea to - What CNavArea the path segment is going towards * Vector to_pos - Target position of the path segment * number to_dir - Target NavDir dir…

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetSpotEncounters)

---

### CNavArea:GetTotalCost · Server
`CNavArea:GetTotalCost() → number`

Returns the total cost when passing from starting area to the goal area through this node. Set by [CNavArea:SetTotalCost](https://wiki.facepunch.com/gmod/CNavArea:SetTotalCost).

Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).

More information can be found on the [Simple Pathfinding](https://wiki.facepunch.com/gmod/Simple%20Pathfinding) page.

**Returns:**
- number — The total cost

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetTotalCost)

---

### CNavArea:GetVisibleAreas · Server
`CNavArea:GetVisibleAreas() → table`

Returns all [CNavArea](https://wiki.facepunch.com/gmod/CNavArea)s that are visible from this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

**Returns:**
- `areas` (table) — A sequential table containing all CNavAreas that are visible from this CNavArea.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetVisibleAreas)

---

### CNavArea:GetZ · Server
`CNavArea:GetZ(pos: Vector) → number`

Returns the elevation of this Nav Area at the given position.

**Arguments:**
- `pos` (Vector) — The position to get the elevation from, the z value from this position is ignored and only the X and Y values are used to this task.

**Returns:**
- number — The elevation.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:GetZ)

---

### CNavArea:HasAttributes · Server
`CNavArea:HasAttributes(attribs: number) → boolean`

Returns true if the given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) has this attribute flag set.

**Arguments:**
- `attribs` (number, enum [NAV_MESH](https://wiki.facepunch.com/gmod/Enums/NAV_MESH)) — Attribute mask to check for, see NAV_MESH

**Returns:**
- boolean — True if the CNavArea matches the given mask.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:HasAttributes)

---

### CNavArea:IsBlocked · Server
`CNavArea:IsBlocked(teamID: number = -2, ignoreNavBlockers: boolean = false) → boolean`

Returns whether the nav area is blocked or not, i.e. whether it can be walked through or not.

**Arguments:**
- `teamID` (number, default `-2`) — The team ID to test, -2 = any team.
- `ignoreNavBlockers` (boolean, default `false`) — Whether to ignore func_nav_blocker entities.

**Returns:**
- boolean — Whether the area is blocked or not

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsBlocked)

---

### CNavArea:IsClosed · Server
`CNavArea:IsClosed() → boolean`

Returns whether this node is in the Closed List.

Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).

More information can be found on the [Simple Pathfinding](https://wiki.facepunch.com/gmod/Simple%20Pathfinding) page.

**Returns:**
- boolean — Whether this node is in the Closed List.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsClosed)

---

### CNavArea:IsCompletelyVisible · Server
`CNavArea:IsCompletelyVisible(area: CNavArea) → boolean`

Returns whether this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) can completely (i.e. all corners of this area can see all corners of the given area) see the given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

**Arguments:**
- `area` (CNavArea) — The CNavArea to test.

**Returns:**
- boolean — Whether the given area is visible from this area

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsCompletelyVisible)

---

### CNavArea:IsConnected · Server
`CNavArea:IsConnected(navArea: CNavArea) → boolean`

Returns whether this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) has an outgoing ( one or two way ) connection **to** given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

See [CNavArea:IsConnectedAtSide](https://wiki.facepunch.com/gmod/CNavArea:IsConnectedAtSide) for a function that only checks for outgoing connections in one direction.

**Arguments:**
- `navArea` (CNavArea) — The CNavArea to test against.

**Returns:**
- boolean — Whether this CNavArea has an outgoing ( one or two way ) connection to given CNavArea.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsConnected)

---

### CNavArea:IsConnectedAtSide · Server
`CNavArea:IsConnectedAtSide(navArea: CNavArea, navDirType: number) → boolean`

Returns whether this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) has an outgoing ( one or two way ) connection **to** given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) in given direction.

See [CNavArea:IsConnected](https://wiki.facepunch.com/gmod/CNavArea:IsConnected) for a function that checks all sides.

**Arguments:**
- `navArea` (CNavArea) — The CNavArea to test against.
- `navDirType` (number, enum [NavDir](https://wiki.facepunch.com/gmod/Enums/NavDir)) — The direction, in which to look for the connection.

**Returns:**
- boolean — Whether this CNavArea has an outgoing ( one or two way ) connection to given CNavArea in given direction.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsConnectedAtSide)

---

### CNavArea:IsCoplanar · Server
`CNavArea:IsCoplanar(navArea: CNavArea) → boolean`

Returns whether this Nav Area is in the same plane as the given one.

**Arguments:**
- `navArea` (CNavArea) — The Nav Area to test.

**Returns:**
- boolean — Whether we're coplanar or not.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsCoplanar)

---

### CNavArea:IsDamaging · Server
`CNavArea:IsDamaging() → boolean`

Returns whether the [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) would damage if traversed, as set by [CNavArea:MarkAsDamaging](https://wiki.facepunch.com/gmod/CNavArea:MarkAsDamaging).

**Returns:**
- boolean — Whether the area is damaging or not

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsDamaging)

---

### CNavArea:IsFlat · Server
`CNavArea:IsFlat() → boolean`

Returns whether this Nav Area is flat within the tolerance of the **nav_coplanar_slope_limit_displacement** and **nav_coplanar_slope_limit** convars.

**Returns:**
- boolean — Whether this CNavArea is mostly flat.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsFlat)

---

### CNavArea:IsOpen · Server
`CNavArea:IsOpen() → boolean`

Returns whether this area is in the Open List.

Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).

More information can be found on the [Simple Pathfinding](https://wiki.facepunch.com/gmod/Simple%20Pathfinding) page.

**Returns:**
- boolean — Whether this area is in the Open List.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsOpen)

---

### CNavArea:IsOpenListEmpty · Server
`CNavArea:IsOpenListEmpty() → boolean`

Returns whether the Open List is empty or not.

Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).

More information can be found on the [Simple Pathfinding](https://wiki.facepunch.com/gmod/Simple%20Pathfinding) page.

**Returns:**
- boolean — Whether the Open List is empty or not.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsOpenListEmpty)

---

### CNavArea:IsOverlapping · Server
`CNavArea:IsOverlapping(pos: Vector, tolerance: number = 0) → boolean`

Returns if this position overlaps the Nav Area within the given tolerance.

**Arguments:**
- `pos` (Vector) — The overlapping position to test.
- `tolerance` (number, default `0`) — The tolerance of the overlapping, set to 0 for no tolerance.

**Returns:**
- boolean — Whether the given position overlaps the Nav Area or not.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsOverlapping)

---

### CNavArea:IsOverlappingArea · Server
`CNavArea:IsOverlappingArea(navArea: CNavArea) → boolean`

Returns true if this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) is overlapping the given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

**Arguments:**
- `navArea` (CNavArea) — The CNavArea to test against.

**Returns:**
- boolean — True if the given CNavArea overlaps this CNavArea at any point.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsOverlappingArea)

---

### CNavArea:IsPartiallyVisible · Server
`CNavArea:IsPartiallyVisible(pos: Vector, ignoreEnt: Entity = NULL) → boolean`

Returns whether this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) can see given position.

**Arguments:**
- `pos` (Vector) — The position to test.
- `ignoreEnt` (Entity, default `NULL`) — If set, the given entity will be ignored when doing LOS tests

**Returns:**
- boolean — Whether the given position is visible from this area

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsPartiallyVisible)

---

### CNavArea:IsPotentiallyVisible · Server
`CNavArea:IsPotentiallyVisible(area: CNavArea) → boolean`

Returns whether this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) can potentially see the given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

**Arguments:**
- `area` (CNavArea) — The CNavArea to test.

**Returns:**
- boolean — Whether the given area is visible from this area

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsPotentiallyVisible)

---

### CNavArea:IsRoughlySquare · Server
`CNavArea:IsRoughlySquare() → boolean`

Returns if we're shaped like a square.

**Returns:**
- boolean — If we're a square or not.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsRoughlySquare)

---

### CNavArea:IsUnderwater · Server
`CNavArea:IsUnderwater() → boolean`

Whether this Nav Area is placed underwater.

**Returns:**
- boolean — Whether we're underwater or not.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsUnderwater)

---

### CNavArea:IsValid · Server
`CNavArea:IsValid() → boolean`

Returns whether this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) is valid or not.

**Returns:**
- boolean — Whether this CNavArea is valid or not.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsValid)

---

### CNavArea:IsVisible · Server
`CNavArea:IsVisible(pos: Vector) → boolean, Vector`

Returns whether we can be seen from the given position.

**Arguments:**
- `pos` (Vector) — The position to check.

**Returns:**
- boolean — Whether we can be seen or not.
- Vector — If we can be seen, this is returned with either the center or one of the corners of the Nav Area.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:IsVisible)

---

### CNavArea:MarkAsBlocked · Server
`CNavArea:MarkAsBlocked(teamID: number = -2)`

Marks the area as blocked and unable to be traversed. See [CNavArea:IsBlocked](https://wiki.facepunch.com/gmod/CNavArea:IsBlocked) and [CNavArea:MarkAsUnblocked](https://wiki.facepunch.com/gmod/CNavArea:MarkAsUnblocked).

**Arguments:**
- `teamID` (number, default `-2`) — TeamID to mark the area as blocked for.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:MarkAsBlocked)

---

### CNavArea:MarkAsDamaging · Server
`CNavArea:MarkAsDamaging(duration: number)`

Marks the area as damaging if traversed, for example when, for example having poisonous or no atmosphere, or a temporary fire present. See [CNavArea:IsDamaging](https://wiki.facepunch.com/gmod/CNavArea:IsDamaging).

**Arguments:**
- `duration` (number) — For how long the area should stay marked as damaging.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:MarkAsDamaging)

---

### CNavArea:MarkAsUnblocked · Server
`CNavArea:MarkAsUnblocked(teamID: number = -2)`

Unblocked this area if it was previously blocked by [CNavArea:MarkAsBlocked](https://wiki.facepunch.com/gmod/CNavArea:MarkAsBlocked).

**Arguments:**
- `teamID` (number, default `-2`) — TeamID to unblock the area for.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:MarkAsUnblocked)

---

### CNavArea:PlaceOnGround · Server
`CNavArea:PlaceOnGround(corner: number)`

Drops a corner or all corners of a [CNavArea](https://wiki.facepunch.com/gmod/CNavArea) to the ground below it.

**Arguments:**
- `corner` (number, enum [NavCorner](https://wiki.facepunch.com/gmod/Enums/NavCorner)) — The corner(s) to drop, uses NavCorner

[wiki](https://wiki.facepunch.com/gmod/CNavArea:PlaceOnGround)

---

### CNavArea:PopOpenList · Server
`CNavArea:PopOpenList() → CNavArea`

Removes a CNavArea from the Open List with the lowest cost to traverse to from the starting node, and returns it.

Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).

More information can be found on the [Simple Pathfinding](https://wiki.facepunch.com/gmod/Simple%20Pathfinding) page.

**Returns:**
- CNavArea — The CNavArea from the Open List with the lowest cost to traverse to from the starting node.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:PopOpenList)

---

### CNavArea:Remove · Server
`CNavArea:Remove()`

Removes the given nav area.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:Remove)

---

### CNavArea:RemoveAttributes · Server
`CNavArea:RemoveAttributes(attribs: number)`

Removes given attributes from given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea). See also [CNavArea:SetAttributes](https://wiki.facepunch.com/gmod/CNavArea:SetAttributes).

**Arguments:**
- `attribs` (number, enum [NAV_MESH](https://wiki.facepunch.com/gmod/Enums/NAV_MESH)) — The attributes to remove, as a bitflag.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:RemoveAttributes)

---

### CNavArea:RemoveFromClosedList · Server · `DEPRECATED`
`CNavArea:RemoveFromClosedList()`

Removes this node from the Closed List.

Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).


More information can be found on the [Simple Pathfinding](https://wiki.facepunch.com/gmod/Simple%20Pathfinding) page.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:RemoveFromClosedList)

---

### CNavArea:SetAttributes · Server
`CNavArea:SetAttributes(attribs: number)`

Sets the attributes for given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea). See [CNavArea:HasAttributes](https://wiki.facepunch.com/gmod/CNavArea:HasAttributes).

**Arguments:**
- `attribs` (number, enum [NAV_MESH](https://wiki.facepunch.com/gmod/Enums/NAV_MESH)) — The attributes to set, as a bitflag.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:SetAttributes)

---

### CNavArea:SetCorner · Server
`CNavArea:SetCorner(corner: number, position: Vector)`

Sets the position of a corner of a nav area.

**Arguments:**
- `corner` (number, enum [NavCorner](https://wiki.facepunch.com/gmod/Enums/NavCorner)) — The corner to set, uses NavCorner
- `position` (Vector) — The new position to set.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:SetCorner)

---

### CNavArea:SetCostSoFar · Server
`CNavArea:SetCostSoFar(cost: number)`

Sets the cost from starting area this area when pathfinding.

Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).

More information can be found on the [Simple Pathfinding](https://wiki.facepunch.com/gmod/Simple%20Pathfinding) page.

**Arguments:**
- `cost` (number) — The cost so far

[wiki](https://wiki.facepunch.com/gmod/CNavArea:SetCostSoFar)

---

### CNavArea:SetParent · Server
`CNavArea:SetParent(parent: CNavArea, how: number)`

Sets the new parent of this [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

**Arguments:**
- `parent` (CNavArea) — The new parent to set
- `how` (number, enum [NavTraverseType](https://wiki.facepunch.com/gmod/Enums/NavTraverseType)) — How we get from parent to us using NavTraverseType

[wiki](https://wiki.facepunch.com/gmod/CNavArea:SetParent)

---

### CNavArea:SetPlace · Server
`CNavArea:SetPlace(place: string) → boolean`

Sets the Place of the nav area.

There is a limit of 256 unique places per `.nav` file.

**Arguments:**
- `place` (string) — Set to `""` to remove place from the nav area.

**Returns:**
- boolean — Returns true of operation succeeded, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:SetPlace)

---

### CNavArea:SetTotalCost · Server
`CNavArea:SetTotalCost(cost: number)`

Sets the total cost when passing from starting area to the goal area through this node.

Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).

More information can be found on the [Simple Pathfinding](https://wiki.facepunch.com/gmod/Simple%20Pathfinding) page.

**Arguments:**
- `cost` (number) — The total cost of the path to set.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:SetTotalCost)

---

### CNavArea:UpdateOnOpenList · Server
`CNavArea:UpdateOnOpenList()`

Moves this open list to appropriate position based on its [CNavArea:GetTotalCost](https://wiki.facepunch.com/gmod/CNavArea:GetTotalCost) compared to the total cost of other areas in the open list.

Used in pathfinding via the [A* algorithm](https://en.wikipedia.org/wiki/A*_search_algorithm).

More information can be found on the [Simple Pathfinding](https://wiki.facepunch.com/gmod/Simple%20Pathfinding) page.

[wiki](https://wiki.facepunch.com/gmod/CNavArea:UpdateOnOpenList)

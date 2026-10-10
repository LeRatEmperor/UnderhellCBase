# PathFollower

**Realm:** Server  ·  **Members:** 31

Path object for a NextBot NPC and bots created by [player.CreateNextbot](https://wiki.facepunch.com/gmod/player.CreateNextbot). Returned by [Path](https://wiki.facepunch.com/gmod/Global.Path).

[wiki page](https://wiki.facepunch.com/gmod/PathFollower)

### PathFollower:Chase · Server
`PathFollower:Chase(bot: NextBot, ent: Entity, generator: function = nil)`

Computes the shortest path to the provided entity arg. PathFollower Object must have `Chase` type. 

For PathFollower objects of the `Follow` type use [PathFollower:Compute](https://wiki.facepunch.com/gmod/PathFollower:Compute)

**Arguments:**
- `bot` (NextBot) — The bot to update along the path.
- `ent` (Entity) — The entity we want to chase
- `generator` (function, default `nil`) — A function that allows you to alter the path generation.

[wiki](https://wiki.facepunch.com/gmod/PathFollower:Chase)

---

### PathFollower:Compute · Server
`PathFollower:Compute(bot: NextBot, goal: Vector, generator: function = nil) → boolean`

Compute shortest path from bot to 'goal' via A* algorithm. This only works if the PathFollower is the `Follow` Type. 

For PathFollowers of the `Chase` Type see [PathFollower:Chase](https://wiki.facepunch.com/gmod/PathFollower:Chase)

**Arguments:**
- `bot` (NextBot) — The nextbot we're generating for.
- `goal` (Vector) — The target location, the goal.
- `generator` (function, default `nil`) — A function that allows you to alter the path generation by adjusting the "cost".

**Returns:**
- boolean — * If returns true, path was found to the goal position.

[wiki](https://wiki.facepunch.com/gmod/PathFollower:Compute)

---

### PathFollower:Draw · Server
`PathFollower:Draw()`

Draws the path. This is meant for debugging - and uses [debugoverlay](https://wiki.facepunch.com/gmod/debugoverlay).

[wiki](https://wiki.facepunch.com/gmod/PathFollower:Draw)

---

### PathFollower:FirstSegment · Server
`PathFollower:FirstSegment() → table`

Returns the first segment of the path.

**Returns:**
- table — A table with Structures/PathSegment.

[wiki](https://wiki.facepunch.com/gmod/PathFollower:FirstSegment)

---

### PathFollower:GetAge · Server
`PathFollower:GetAge() → number`

Returns the age since the path was built

**Returns:**
- number — Path age

[wiki](https://wiki.facepunch.com/gmod/PathFollower:GetAge)

---

### PathFollower:GetAllSegments · Server
`PathFollower:GetAllSegments() → table{PathSegment}`

Returns all of the segments of the given path.

**Returns:**
- table{PathSegment} — A table of tables with Structures/PathSegment.

[wiki](https://wiki.facepunch.com/gmod/PathFollower:GetAllSegments)

---

### PathFollower:GetClosestPosition · Server
`PathFollower:GetClosestPosition(position: Vector) → Vector`

The closest position along the path to a position

**Arguments:**
- `position` (Vector) — The point we're querying for

**Returns:**
- Vector — The closest position on the path

[wiki](https://wiki.facepunch.com/gmod/PathFollower:GetClosestPosition)

---

### PathFollower:GetCurrentGoal · Server
`PathFollower:GetCurrentGoal() → table`

Returns the current goal data. Can return nil if the current goal is invalid, for example immediately after [PathFollower:Update](https://wiki.facepunch.com/gmod/PathFollower:Update).

**Returns:**
- table — A table with Structures/PathSegment.

[wiki](https://wiki.facepunch.com/gmod/PathFollower:GetCurrentGoal)

---

### PathFollower:GetCursorData · Server
`PathFollower:GetCursorData() → table`

Returns the cursor data

**Returns:**
- table — A table with 3 keys: number curvature Vector forward Vector pos

[wiki](https://wiki.facepunch.com/gmod/PathFollower:GetCursorData)

---

### PathFollower:GetCursorPosition · Server
`PathFollower:GetCursorPosition() → number`

Returns the current progress along the path

**Returns:**
- number — The current progress

[wiki](https://wiki.facepunch.com/gmod/PathFollower:GetCursorPosition)

---

### PathFollower:GetEnd · Server
`PathFollower:GetEnd() → Vector`

Returns the path end position

**Returns:**
- Vector — The end position

[wiki](https://wiki.facepunch.com/gmod/PathFollower:GetEnd)

---

### PathFollower:GetGoalTolerance · Server
`PathFollower:GetGoalTolerance() → number`

Returns how close we can get to the goal to call it done.

**Returns:**
- number — The distance we're setting it to

[wiki](https://wiki.facepunch.com/gmod/PathFollower:GetGoalTolerance)

---

### PathFollower:GetHindrance · Server
`PathFollower:GetHindrance() → Entity`

**Returns:**
- Entity

[wiki](https://wiki.facepunch.com/gmod/PathFollower:GetHindrance)

---

### PathFollower:GetLength · Server
`PathFollower:GetLength() → number`

Returns the total length of the path

**Returns:**
- number — The length of the path

[wiki](https://wiki.facepunch.com/gmod/PathFollower:GetLength)

---

### PathFollower:GetMinLookAheadDistance · Server
`PathFollower:GetMinLookAheadDistance() → number`

Returns the minimum range movement goal must be along path.

**Returns:**
- number — The minimum look ahead distance

[wiki](https://wiki.facepunch.com/gmod/PathFollower:GetMinLookAheadDistance)

---

### PathFollower:GetPositionOnPath · Server
`PathFollower:GetPositionOnPath(distance: number) → Vector`

Returns the vector position of distance along path

**Arguments:**
- `distance` (number) — The distance along the path to query

**Returns:**
- Vector — The position

[wiki](https://wiki.facepunch.com/gmod/PathFollower:GetPositionOnPath)

---

### PathFollower:GetStart · Server
`PathFollower:GetStart() → Vector`

Returns the path start position

**Returns:**
- Vector — The start position

[wiki](https://wiki.facepunch.com/gmod/PathFollower:GetStart)

---

### PathFollower:Invalidate · Server
`PathFollower:Invalidate()`

Invalidates the current path

[wiki](https://wiki.facepunch.com/gmod/PathFollower:Invalidate)

---

### PathFollower:IsValid · Server
`PathFollower:IsValid() → boolean`

Returns true if the path is valid

**Returns:**
- boolean — Wether the path is valid or not.

[wiki](https://wiki.facepunch.com/gmod/PathFollower:IsValid)

---

### PathFollower:LastSegment · Server
`PathFollower:LastSegment() → table`

Returns the last segment of the path.

**Returns:**
- table — A table with Structures/PathSegment.

[wiki](https://wiki.facepunch.com/gmod/PathFollower:LastSegment)

---

### PathFollower:MoveCursor · Server
`PathFollower:MoveCursor(distance: number)`

Moves the cursor by give distance.

For a function that sets the distance, see [PathFollower:MoveCursorTo](https://wiki.facepunch.com/gmod/PathFollower:MoveCursorTo).

**Arguments:**
- `distance` (number) — The distance to move the cursor (in relative world units)

[wiki](https://wiki.facepunch.com/gmod/PathFollower:MoveCursor)

---

### PathFollower:MoveCursorTo · Server
`PathFollower:MoveCursorTo(distance: number)`

Sets the cursor position to given distance.

For relative distance, see [PathFollower:MoveCursor](https://wiki.facepunch.com/gmod/PathFollower:MoveCursor).

**Arguments:**
- `distance` (number) — The distance to move the cursor (in world units)

[wiki](https://wiki.facepunch.com/gmod/PathFollower:MoveCursorTo)

---

### PathFollower:MoveCursorToClosestPosition · Server
`PathFollower:MoveCursorToClosestPosition(pos: Vector, type: number = 0, alongLimit: number = 0)`

Moves the cursor of the path to the closest position compared to given vector.

**Arguments:**
- `pos` (Vector)
- `type` (number, default `0`) — Seek type 0 = SEEK_ENTIRE_PATH - Search the entire path length 1 = SEEK_AHEAD - Search from current cursor position forward toward end of path 2 = SEEK_BEHIND - Search from current cursor position backward toward path start
- `alongLimit` (number, default `0`)

[wiki](https://wiki.facepunch.com/gmod/PathFollower:MoveCursorToClosestPosition)

---

### PathFollower:MoveCursorToEnd · Server
`PathFollower:MoveCursorToEnd()`

Moves the cursor to the end of the path

[wiki](https://wiki.facepunch.com/gmod/PathFollower:MoveCursorToEnd)

---

### PathFollower:MoveCursorToStart · Server
`PathFollower:MoveCursorToStart()`

Moves the cursor to the end of the path

[wiki](https://wiki.facepunch.com/gmod/PathFollower:MoveCursorToStart)

---

### PathFollower:NextSegment · Server
`PathFollower:NextSegment() → table`

Returns the next segment of the path.

**Returns:**
- table — A table with Structures/PathSegment.

[wiki](https://wiki.facepunch.com/gmod/PathFollower:NextSegment)

---

### PathFollower:PriorSegment · Server
`PathFollower:PriorSegment() → table`

Returns the previous segment of the path.

**Returns:**
- table — A table with Structures/PathSegment.

[wiki](https://wiki.facepunch.com/gmod/PathFollower:PriorSegment)

---

### PathFollower:ResetAge · Server
`PathFollower:ResetAge()`

Resets the age which is retrieved by [PathFollower:GetAge](https://wiki.facepunch.com/gmod/PathFollower:GetAge) to 0.

[wiki](https://wiki.facepunch.com/gmod/PathFollower:ResetAge)

---

### PathFollower:SetGoalTolerance · Server
`PathFollower:SetGoalTolerance(distance: number)`

How close we can get to the goal to call it done

**Arguments:**
- `distance` (number) — The distance we're setting it to

[wiki](https://wiki.facepunch.com/gmod/PathFollower:SetGoalTolerance)

---

### PathFollower:SetMinLookAheadDistance · Server
`PathFollower:SetMinLookAheadDistance(mindist: number)`

Sets minimum range movement goal must be along path

**Arguments:**
- `mindist` (number) — The minimum look ahead distance

[wiki](https://wiki.facepunch.com/gmod/PathFollower:SetMinLookAheadDistance)

---

### PathFollower:Update · Server
`PathFollower:Update(bot: NextBot)`

Move the bot along the path.

**Arguments:**
- `bot` (NextBot) — The bot to update along the path.

> **Note:** player nextbots require [CUserCmd:SetForwardMove](https://wiki.facepunch.com/gmod/CUserCmd:SetForwardMove) to move forward along the path

[wiki](https://wiki.facepunch.com/gmod/PathFollower:Update)

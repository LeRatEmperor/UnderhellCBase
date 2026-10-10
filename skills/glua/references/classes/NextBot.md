# NextBot

**Realm:** Server  ·  **Members:** 20

NextBots are a new system to create NPCs in the Source Engine, utilizing the more powerful [navmesh](https://wiki.facepunch.com/gmod/navmesh) system for navigation over the old node based system.

This page lists all possible functions usable with NextBots.

See [NextBot NPC Creation](https://wiki.facepunch.com/gmod/NextBot%20NPC%20Creation) for more information on how to create NextBot NPCs.

[wiki page](https://wiki.facepunch.com/gmod/NextBot)

### NextBot:BecomeRagdoll · Server
`NextBot:BecomeRagdoll(info: CTakeDamageInfo) → Entity`

Become a ragdoll and remove the entity.

**Arguments:**
- `info` (CTakeDamageInfo) — Damage info passed from an onkilled event

**Returns:**
- Entity — The created ragdoll, if any.

[wiki](https://wiki.facepunch.com/gmod/NextBot:BecomeRagdoll)

---

### NextBot:BodyMoveXY · Server
`NextBot:BodyMoveXY()`

Should only be called in [NEXTBOT:BodyUpdate](https://wiki.facepunch.com/gmod/NEXTBOT:BodyUpdate). This sets the `move_x` and `move_y` pose parameters of the bot to fit how they're currently moving, sets the animation speed ([Entity:GetPlaybackRate](https://wiki.facepunch.com/gmod/Entity:GetPlaybackRate)) to suit the ground speed, and calls [Entity:FrameAdvance](https://wiki.facepunch.com/gmod/Entity:FrameAdvance).

> **Bug** ([#3420](https://github.com/Facepunch/garrysmod/issues/3420)): This function might cause crashes with some activities.

[wiki](https://wiki.facepunch.com/gmod/NextBot:BodyMoveXY)

---

### NextBot:ClearLastKnownArea · Server
`NextBot:ClearLastKnownArea()`

Clears this bot's last known area. See [NextBot:GetLastKnownArea](https://wiki.facepunch.com/gmod/NextBot:GetLastKnownArea).

[wiki](https://wiki.facepunch.com/gmod/NextBot:ClearLastKnownArea)

---

### NextBot:FindSpot · Server
`NextBot:FindSpot(type: string, options: table) → Vector`

Like [NextBot:FindSpots](https://wiki.facepunch.com/gmod/NextBot:FindSpots) but only returns a vector.

**Arguments:**
- `type` (string) — Either `"random"`, `"near"`, `"far"`.
- `options` (table) — This table should contain the search info.

**Returns:**
- Vector — If it finds a spot it will return a vector.

[wiki](https://wiki.facepunch.com/gmod/NextBot:FindSpot) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L201)

---

### NextBot:FindSpots · Server
`NextBot:FindSpots(specs: table) → table`

Returns a table of hiding spots.

**Arguments:**
- `specs` (table) — This table should contain the search info.

**Returns:**
- table — An unsorted table of tables containing: * Vector vector - The position of the hiding spot * number distance - the distance to that position

[wiki](https://wiki.facepunch.com/gmod/NextBot:FindSpots) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L189)

---

### NextBot:GetActivity · Server
`NextBot:GetActivity() → number`

Returns the currently running activity

**Returns:**
- number — The current activity

[wiki](https://wiki.facepunch.com/gmod/NextBot:GetActivity)

---

### NextBot:GetFOV · Server
`NextBot:GetFOV() → number`

Returns the Field of View of the Nextbot NPC, used for its vision functionality, such as [NextBot:IsAbleToSee](https://wiki.facepunch.com/gmod/NextBot:IsAbleToSee).

**Returns:**
- `fov` (number) — The current FOV of the nextbot

[wiki](https://wiki.facepunch.com/gmod/NextBot:GetFOV)

---

### NextBot:GetLastKnownArea · Server
`NextBot:GetLastKnownArea() → CNavArea`

Returns this bots last known area. See also [NextBot:ClearLastKnownArea](https://wiki.facepunch.com/gmod/NextBot:ClearLastKnownArea).

**Returns:**
- CNavArea — The last area the bot is known to have been in.

[wiki](https://wiki.facepunch.com/gmod/NextBot:GetLastKnownArea)

---

### NextBot:GetMaxVisionRange · Server
`NextBot:GetMaxVisionRange() → number`

Returns the maximum range the nextbot can see other nextbots/players at. See [NextBot:IsAbleToSee](https://wiki.facepunch.com/gmod/NextBot:IsAbleToSee).

**Returns:**
- number — The current vision range

[wiki](https://wiki.facepunch.com/gmod/NextBot:GetMaxVisionRange)

---

### NextBot:GetRangeSquaredTo · Server
`NextBot:GetRangeSquaredTo(to: Vector) → number`

Returns squared distance to an entity or a position.

See also [NextBot:GetRangeTo](https://wiki.facepunch.com/gmod/NextBot:GetRangeTo).

**Arguments:**
- `to` (Vector) — The position to measure distance to.

**Returns:**
- number — The squared distance

[wiki](https://wiki.facepunch.com/gmod/NextBot:GetRangeSquaredTo)

---

### NextBot:GetRangeTo · Server
`NextBot:GetRangeTo(to: Vector) → number`

Returns the distance to an entity or position.

See also [NextBot:GetRangeSquaredTo](https://wiki.facepunch.com/gmod/NextBot:GetRangeSquaredTo).

**Arguments:**
- `to` (Vector) — The position to measure distance to.

**Returns:**
- number — The distance

[wiki](https://wiki.facepunch.com/gmod/NextBot:GetRangeTo)

---

### NextBot:GetSolidMask · Server
`NextBot:GetSolidMask() → number`

Returns the solid mask for given NextBot.

**Returns:**
- number — The solid mask, see CONTENTS and MASK

[wiki](https://wiki.facepunch.com/gmod/NextBot:GetSolidMask)

---

### NextBot:HandleStuck · Server
`NextBot:HandleStuck()`

Called from Lua when the NPC is stuck. This should only be called from the behaviour coroutine - so if you want to override this function and do something special that yields - then go for it.

You should always call self.loco:ClearStuck() in this function to reset the stuck status - so it knows it's unstuck. See [CLuaLocomotion:ClearStuck](https://wiki.facepunch.com/gmod/CLuaLocomotion:ClearStuck).

[wiki](https://wiki.facepunch.com/gmod/NextBot:HandleStuck) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L265)

---

### NextBot:IsAbleToSee · Server
`NextBot:IsAbleToSee(ent: Entity, useFOV: number = true) → boolean`

Returns if the Nextbot NPC can see the give entity or not.

**Arguments:**
- `ent` (Entity) — The entity to test if we can see
- `useFOV` (number, default `true`) — Whether to use the Field of View of the Nextbot

**Returns:**
- boolean — If the nextbot can see or not

> **Warning:** Using this function creates the nextbot vision interface which will cause a significant performance hit!

[wiki](https://wiki.facepunch.com/gmod/NextBot:IsAbleToSee)

---

### NextBot:MoveToPos · Server
`NextBot:MoveToPos(pos: Vector, options: table) → string`

To be called in the behaviour coroutine only! Will yield until the bot has reached the goal or is stuck

**Arguments:**
- `pos` (Vector) — The position we want to get to
- `options` (table) — A table containing a bunch of tweakable options.

**Returns:**
- string — Either `"failed"`, `"stuck"`, `"timeout"` or `"ok"` - depending on how the NPC got on

[wiki](https://wiki.facepunch.com/gmod/NextBot:MoveToPos) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L299)

---

### NextBot:PlaySequenceAndWait · Server
`NextBot:PlaySequenceAndWait(name: string, speed: number = 1)`

To be called in the behaviour coroutine only! Plays an animation sequence and waits for it to end before returning.

**Arguments:**
- `name` (string) — The sequence name
- `speed` (number, default `1`) — Playback Rate of that sequence

[wiki](https://wiki.facepunch.com/gmod/NextBot:PlaySequenceAndWait) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L298-L317)

---

### NextBot:SetFOV · Server
`NextBot:SetFOV(fov: number)`

Sets the Field of View for the Nextbot NPC, used for its vision functionality, such as [NextBot:IsAbleToSee](https://wiki.facepunch.com/gmod/NextBot:IsAbleToSee).

**Arguments:**
- `fov` (number) — The new FOV

[wiki](https://wiki.facepunch.com/gmod/NextBot:SetFOV)

---

### NextBot:SetMaxVisionRange · Server
`NextBot:SetMaxVisionRange(range: number)`

Sets the maximum range the nextbot can see other nextbots/players at. See [NextBot:IsAbleToSee](https://wiki.facepunch.com/gmod/NextBot:IsAbleToSee).

**Arguments:**
- `range` (number) — The new vision range to set.

[wiki](https://wiki.facepunch.com/gmod/NextBot:SetMaxVisionRange)

---

### NextBot:SetSolidMask · Server
`NextBot:SetSolidMask(mask: number)`

Sets the solid mask for given NextBot.

The default solid mask of a NextBot is [MASK_NPCSOLID](https://wiki.facepunch.com/gmod/Enums/MASK).

**Arguments:**
- `mask` (number, enum [MASK](https://wiki.facepunch.com/gmod/Enums/MASK)) — The new mask, see CONTENTS and MASK

[wiki](https://wiki.facepunch.com/gmod/NextBot:SetSolidMask)

---

### NextBot:StartActivity · Server
`NextBot:StartActivity(activity: number)`

Start doing an activity (animation).

This function may not produce the desired result if [Entity:SetModel](https://wiki.facepunch.com/gmod/Entity:SetModel) has not yet been called on the nextbot entity

**Arguments:**
- `activity` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — One of the ACT

[wiki](https://wiki.facepunch.com/gmod/NextBot:StartActivity)

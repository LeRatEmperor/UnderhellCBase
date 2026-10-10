# NPC

**Realm:** Shared  ·  **Members:** 182

This is a list of all methods only available for NPCs. It is also possible to call [Entity](https://wiki.facepunch.com/gmod/Entity) functions on NPCs.

[wiki page](https://wiki.facepunch.com/gmod/NPC)

### NPC:AddEntityRelationship · Server
`NPC:AddEntityRelationship(target: Entity, disposition: number, priority: number = 0)`

Makes the NPC like, hate, feel neutral towards, or fear the entity in question. If you want to setup relationship towards a certain entity `class`, use [NPC:AddRelationship](https://wiki.facepunch.com/gmod/NPC:AddRelationship).

**Arguments:**
- `target` (Entity) — The entity for the relationship to be applied to.
- `disposition` (number, enum [D](https://wiki.facepunch.com/gmod/Enums/D)) — A D representing the relationship type.
- `priority` (number, default `0`) — How strong the relationship is.

> **Note:** NPCs do not see [NextBot](https://wiki.facepunch.com/gmod/NextBot)s by default. This can be fixed by adding the [FL_OBJECT](https://wiki.facepunch.com/gmod/Enums/FL) flag to the NextBot.

[wiki](https://wiki.facepunch.com/gmod/NPC:AddEntityRelationship)

---

### NPC:AddRelationship · Server
`NPC:AddRelationship(relationstring: string)`

Changes how an NPC feels towards another NPC.  If you want to setup relationship towards a certain `entity`, use [NPC:AddEntityRelationship](https://wiki.facepunch.com/gmod/NPC:AddEntityRelationship).

**Arguments:**
- `relationstring` (string) — A string representing how the relationship should be set up.

> **Warning:** Avoid using this in [GM:OnEntityCreated](https://wiki.facepunch.com/gmod/GM:OnEntityCreated) to prevent crashing due to infinite loops. This function may create an entity with given class and delete it immediately after.

[wiki](https://wiki.facepunch.com/gmod/NPC:AddRelationship)

---

### NPC:AdvancePath · Server
`NPC:AdvancePath()`

Advances the NPC on its path to the next waypoint.

> **Warning:** Calling this on an NPC without any route will result in an instant crash.

[wiki](https://wiki.facepunch.com/gmod/NPC:AdvancePath)

---

### NPC:AlertSound · Server
`NPC:AlertSound()`

Force an NPC to play their Alert sound.

[wiki](https://wiki.facepunch.com/gmod/NPC:AlertSound)

---

### NPC:AutoMovement · Server
`NPC:AutoMovement(interval: number, target: Entity = NULL) → boolean`

Executes any movement the current sequence may have.

**Arguments:**
- `interval` (number) — This is a good place to use Entity:GetAnimTimeInterval.
- `target` (Entity, default `NULL`)

**Returns:**
- boolean — `true` if any movement was performed.

[wiki](https://wiki.facepunch.com/gmod/NPC:AutoMovement)

---

### NPC:BecomeRagdoll · Server
`NPC:BecomeRagdoll(info: CTakeDamageInfo) → Entity`

Become a ragdoll and remove the entity. Internally handles serverside/clientside ragdoll creation, momentum calculation, triggering ragdoll creation hooks / events and cloning entity's bone transforms to the created ragdoll.

**Arguments:**
- `info` (CTakeDamageInfo) — Damage info passed from an onkilled event

**Returns:**
- Entity — The created serverside ragdoll, nil if failed or a clientside ragdoll created.

[wiki](https://wiki.facepunch.com/gmod/NPC:BecomeRagdoll)

---

### NPC:CapabilitiesAdd · Server
`NPC:CapabilitiesAdd(capabilities: number{CAP})`

Adds a capability to the NPC.

**Arguments:**
- `capabilities` (number{CAP}) — Capabilities to add, see CAP.

[wiki](https://wiki.facepunch.com/gmod/NPC:CapabilitiesAdd)

---

### NPC:CapabilitiesClear · Server
`NPC:CapabilitiesClear()`

Removes all of Capabilities the NPC has.

[wiki](https://wiki.facepunch.com/gmod/NPC:CapabilitiesClear)

---

### NPC:CapabilitiesGet · Server
`NPC:CapabilitiesGet() → number{CAP}`

Returns the NPC's capabilities along the ones defined on its weapon.

**Returns:**
- number{CAP} — The capabilities as a bitflag.

[wiki](https://wiki.facepunch.com/gmod/NPC:CapabilitiesGet)

---

### NPC:CapabilitiesHas · Server
`NPC:CapabilitiesHas(capabilities: number{CAP})`

Checks whether the NPC has the specified capabilities.

**Arguments:**
- `capabilities` (number{CAP}) — Capabilities to check, see CAP.

[wiki](https://wiki.facepunch.com/gmod/NPC:CapabilitiesHas)

---

### NPC:CapabilitiesRemove · Server
`NPC:CapabilitiesRemove(capabilities: number)`

Remove a certain capability.

**Arguments:**
- `capabilities` (number, enum [CAP](https://wiki.facepunch.com/gmod/Enums/CAP)) — Capabilities to remove, see CAP

[wiki](https://wiki.facepunch.com/gmod/NPC:CapabilitiesRemove)

---

### NPC:Classify · Server
`NPC:Classify() → number{CLASS}`

Returns the NPC relationship class. This is mostly used to tell NPCs who should be attacking who.

Do not confuse with [Entity:GetClass](https://wiki.facepunch.com/gmod/Entity:GetClass)!

**Returns:**
- number{CLASS} — See CLASS

[wiki](https://wiki.facepunch.com/gmod/NPC:Classify)

---

### NPC:ClearBlockingEntity · Server
`NPC:ClearBlockingEntity()`

Resets the [NPC:GetBlockingEntity](https://wiki.facepunch.com/gmod/NPC:GetBlockingEntity).

[wiki](https://wiki.facepunch.com/gmod/NPC:ClearBlockingEntity)

---

### NPC:ClearCondition · Server
`NPC:ClearCondition(condition: number)`

Clears out the specified [COND](https://wiki.facepunch.com/gmod/Enums/COND) on this NPC.

**Arguments:**
- `condition` (number, enum [COND](https://wiki.facepunch.com/gmod/Enums/COND)) — The COND to clear out.

[wiki](https://wiki.facepunch.com/gmod/NPC:ClearCondition)

---

### NPC:ClearEnemyMemory · Server
`NPC:ClearEnemyMemory(enemy: Entity = GetEnemy())`

Clears the Enemy from the NPC's memory, effectively forgetting it until met again with either the NPC vision or with [NPC:UpdateEnemyMemory](https://wiki.facepunch.com/gmod/NPC:UpdateEnemyMemory).

**Arguments:**
- `enemy` (Entity, default `GetEnemy()`) — The enemy to mark

[wiki](https://wiki.facepunch.com/gmod/NPC:ClearEnemyMemory)

---

### NPC:ClearExpression · Server
`NPC:ClearExpression()`

Clears the NPC's current expression which can be set with [NPC:SetExpression](https://wiki.facepunch.com/gmod/NPC:SetExpression).

[wiki](https://wiki.facepunch.com/gmod/NPC:ClearExpression)

---

### NPC:ClearGoal · Server
`NPC:ClearGoal()`

Clears the current NPC goal or target.

[wiki](https://wiki.facepunch.com/gmod/NPC:ClearGoal)

---

### NPC:ClearSchedule · Server
`NPC:ClearSchedule()`

Stops the current schedule that the NPC is doing.

[wiki](https://wiki.facepunch.com/gmod/NPC:ClearSchedule)

---

### NPC:ConditionID · Server
`NPC:ConditionID(conditionName: string) → number`

Returns the ID of a given condition by name. Opposite of [NPC:ConditionName](https://wiki.facepunch.com/gmod/NPC:ConditionName).

This is useful for custom conditions defined by engine NPCs, such as `COND_ZOMBIE_RELEASECRAB` for zombies, and `COND_COMBINE_ON_FIRE` for Combine Soldiers.

**Arguments:**
- `conditionName` (string) — The condition name.

**Returns:**
- number — The condition ID, see COND.

[wiki](https://wiki.facepunch.com/gmod/NPC:ConditionID)

---

### NPC:ConditionName · Server
`NPC:ConditionName(cond: number) → string`

Translates condition ID to a string. For the opposite process, see [NPC:ConditionID](https://wiki.facepunch.com/gmod/NPC:ConditionID).

**Arguments:**
- `cond` (number, enum [COND](https://wiki.facepunch.com/gmod/Enums/COND)) — The NPCs condition ID, see COND

**Returns:**
- string — A human understandable string equivalent of that condition.

[wiki](https://wiki.facepunch.com/gmod/NPC:ConditionName)

---

### NPC:Disposition · Server
`NPC:Disposition(ent: Entity) → number{D}, number`

Returns the way the NPC "feels" about a given entity. See [NPC:AddEntityRelationship](https://wiki.facepunch.com/gmod/NPC:AddEntityRelationship).

**Arguments:**
- `ent` (Entity) — The entity to test our disposition towards.

**Returns:**
- number{D} — The NPCs disposition, see D.
- number — The NPCs disposition priority.

> **Note:** For `ai` type entities, this will return [ENTITY:GetRelationship](https://wiki.facepunch.com/gmod/ENTITY:GetRelationship). If it returns `nil` or for engine NPCs, this will return whatever was last set by [NPC:AddEntityRelationship](https://wiki.facepunch.com/gmod/NPC:AddEntityRelationship). As a last resort, engine will decide on the disposition based on this NPC's [NPC:Classify](https://wiki.facepunch.com/gmod/NPC:Classify).

[wiki](https://wiki.facepunch.com/gmod/NPC:Disposition)

---

### NPC:DropWeapon · Server
`NPC:DropWeapon(weapon: Weapon = nil, target: Vector = nil, velocity: Vector = nil)`

Forces the NPC to drop the specified weapon.

**Arguments:**
- `weapon` (Weapon, default `nil`) — Weapon to be dropped.
- `target` (Vector, default `nil`) — If set, launches the weapon at given position.
- `velocity` (Vector, default `nil`) — If set and previous argument is unset, launches the weapon with given velocity.

[wiki](https://wiki.facepunch.com/gmod/NPC:DropWeapon)

---

### NPC:ExitScriptedSequence · Server
`NPC:ExitScriptedSequence()`

Makes an NPC exit a scripted sequence, if one is playing.

[wiki](https://wiki.facepunch.com/gmod/NPC:ExitScriptedSequence)

---

### NPC:FearSound · Server
`NPC:FearSound()`

Force an NPC to play its Fear sound.

[wiki](https://wiki.facepunch.com/gmod/NPC:FearSound)

---

### NPC:FoundEnemySound · Server
`NPC:FoundEnemySound()`

Force an NPC to play its FoundEnemy sound.

[wiki](https://wiki.facepunch.com/gmod/NPC:FoundEnemySound)

---

### NPC:GetActiveWeapon · Shared
`NPC:GetActiveWeapon() → Entity`

Returns the weapon the NPC is currently carrying, or [NULL](https://wiki.facepunch.com/gmod/Global_Variables).

**Returns:**
- Entity — The NPCs current weapon

[wiki](https://wiki.facepunch.com/gmod/NPC:GetActiveWeapon)

---

### NPC:GetActivity · Server
`NPC:GetActivity() → number`

Returns the NPC's current activity.

**Returns:**
- number — Current activity, see ACT.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetActivity)

---

### NPC:GetAimVector · Server
`NPC:GetAimVector() → Vector`

Returns the aim vector of the NPC. NPC alternative of [Player:GetAimVector](https://wiki.facepunch.com/gmod/Player:GetAimVector).

**Returns:**
- Vector — The aim direction of the NPC, usually a noisy direction to it's NPC:GetEnemy.

> **Note:** If the NPC has both [NPC:GetEnemy](https://wiki.facepunch.com/gmod/NPC:GetEnemy) and [NPC:GetActiveWeapon](https://wiki.facepunch.com/gmod/NPC:GetActiveWeapon), engine will automatically call [ENTITY:GetAttackSpread](https://wiki.facepunch.com/gmod/ENTITY:GetAttackSpread) to add random spread degrees to the return value.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetAimVector)

---

### NPC:GetArrivalActivity · Server
`NPC:GetArrivalActivity() → number`

Returns the activity to be played when the NPC arrives at its goal

**Returns:**
- number — The arrival activity.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetArrivalActivity)

---

### NPC:GetArrivalDirection · Server
`NPC:GetArrivalDirection() → Vector`

Returns the direction from the NPC origin to its current navigational destination.

**Returns:**
- Vector — The arrival direction.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetArrivalDirection)

---

### NPC:GetArrivalDistance · Server
`NPC:GetArrivalDistance() → number`

Returns NPC arrival distance, set by [NPC:SetArrivalDistance](https://wiki.facepunch.com/gmod/NPC:SetArrivalDistance).

**Returns:**
- `dist` (number) — The current arrival distance.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetArrivalDistance)

---

### NPC:GetArrivalSequence · Server
`NPC:GetArrivalSequence() → number`

Returns the sequence to be played when the NPC arrives at its goal.

**Returns:**
- number — Sequence ID to be played, or -1 if there's no sequence.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetArrivalSequence)

---

### NPC:GetArrivalSpeed · Server
`NPC:GetArrivalSpeed() → number`

Returns NPC arrival speed, set by [NPC:SetArrivalSpeed](https://wiki.facepunch.com/gmod/NPC:SetArrivalSpeed).

**Returns:**
- `speed` (number) — The current arrival peed.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetArrivalSpeed)

---

### NPC:GetBestSoundHint · Server
`NPC:GetBestSoundHint(types: number) → table`

Returns the most dangerous/closest sound hint based on the NPCs location and the types of sounds it can sense.

**Arguments:**
- `types` (number, enum [SOUND](https://wiki.facepunch.com/gmod/Enums/SOUND)) — The types of sounds to choose from.

**Returns:**
- table — A table with SoundHintData structure or `nil` if no sound hints are nearby.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetBestSoundHint)

---

### NPC:GetBlockingEntity · Server
`NPC:GetBlockingEntity() → Entity`

Returns the entity blocking the NPC along its path.

**Returns:**
- Entity — Blocking entity

[wiki](https://wiki.facepunch.com/gmod/NPC:GetBlockingEntity)

---

### NPC:GetCurGoalType · Server
`NPC:GetCurGoalType() → number`

Returns the goal type for current navigation path.

**Returns:**
- number — The goal type.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetCurGoalType)

---

### NPC:GetCurrentSchedule · Server
`NPC:GetCurrentSchedule() → number`

Returns the NPC's current schedule.

**Returns:**
- number — The NPCs schedule, see SCHED or -1 if we failed for some reason

[wiki](https://wiki.facepunch.com/gmod/NPC:GetCurrentSchedule)

---

### NPC:GetCurrentWeaponProficiency · Server
`NPC:GetCurrentWeaponProficiency() → number`

Returns how proficient (skilled) an NPC is with its current weapon.

**Returns:**
- number — NPC's proficiency for current weapon.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetCurrentWeaponProficiency)

---

### NPC:GetCurWaypointPos · Server
`NPC:GetCurWaypointPos() → Vector`

Gets the NPC's current waypoint position (where NPC is currently moving towards), if any is available.

**Returns:**
- Vector — The position of the current NPC waypoint.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetCurWaypointPos)

---

### NPC:GetEnemy · Server
`NPC:GetEnemy() → NPC`

Returns the entity that this NPC is trying to fight.

**Returns:**
- NPC — Enemy NPC.

> **Bug** ([#3132](https://github.com/Facepunch/garrysmod/issues/3132)): This returns nil if the NPC has no enemy. You should use [IsValid](https://wiki.facepunch.com/gmod/Global.IsValid) (which accounts for nil and NULL) on the return to verify validity of the enemy.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetEnemy)

---

### NPC:GetEnemyFirstTimeSeen · Server
`NPC:GetEnemyFirstTimeSeen(enemy: Entity = GetEnemy()) → number`

Returns the first time an NPC's enemy was seen by the NPC.

**Arguments:**
- `enemy` (Entity, default `GetEnemy()`) — The enemy to check.

**Returns:**
- `time` (number) — First time the given enemy was seen.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetEnemyFirstTimeSeen)

---

### NPC:GetEnemyLastKnownPos · Server
`NPC:GetEnemyLastKnownPos(enemy: Entity = GetEnemy()) → Vector`

Returns the last known position of an NPC's enemy.

Similar to [NPC:GetEnemyLastSeenPos](https://wiki.facepunch.com/gmod/NPC:GetEnemyLastSeenPos), but the known position will be a few seconds ahead of the last seen position.

**Arguments:**
- `enemy` (Entity, default `GetEnemy()`) — The enemy to check.

**Returns:**
- `pos` (Vector) — The last known position.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetEnemyLastKnownPos)

---

### NPC:GetEnemyLastSeenPos · Server
`NPC:GetEnemyLastSeenPos(enemy: Entity = GetEnemy()) → Vector`

Returns the last seen position of an NPC's enemy.

Similar to [NPC:GetEnemyLastKnownPos](https://wiki.facepunch.com/gmod/NPC:GetEnemyLastKnownPos), but the known position will be a few seconds ahead of the last seen position.

**Arguments:**
- `enemy` (Entity, default `GetEnemy()`) — The enemy to check.

**Returns:**
- `pos` (Vector) — The last seen position.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetEnemyLastSeenPos)

---

### NPC:GetEnemyLastTimeSeen · Server
`NPC:GetEnemyLastTimeSeen(enemy: Entity = GetEnemy()) → number`

Returns the last time an NPC's enemy was seen by the NPC.

**Arguments:**
- `enemy` (Entity, default `GetEnemy()`) — The enemy to check.

**Returns:**
- `time` (number) — Last time the given enemy was seen.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetEnemyLastTimeSeen)

---

### NPC:GetExpression · Server
`NPC:GetExpression() → string`

Returns the expression file the NPC is currently playing.

**Returns:**
- `m_iszExpressionScene` (string) — The file path of the expression.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetExpression)

---

### NPC:GetEyeDirection · Server
`NPC:GetEyeDirection() → Vector`

Returns the eye direction of the NPC.

**Returns:**
- Vector — The eye direction.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetEyeDirection)

---

### NPC:GetFOV · Server
`NPC:GetFOV() → number`

Returns the Field Of View of the NPC. See [NPC:SetFOV](https://wiki.facepunch.com/gmod/NPC:SetFOV).

**Returns:**
- `fov` (number) — The FOV for the NPC in degrees.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetFOV)

---

### NPC:GetGoalPos · Server
`NPC:GetGoalPos() → Vector`

Returns the position we are trying to reach, if any.

**Returns:**
- Vector — The position we are trying to reach.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetGoalPos)

---

### NPC:GetGoalTarget · Server
`NPC:GetGoalTarget() → Entity`

Returns the entity we are trying to reach, if any.

**Returns:**
- Entity — The entity we are trying to reach, or `NULL`.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetGoalTarget)

---

### NPC:GetHeadDirection · Server
`NPC:GetHeadDirection() → Vector`

Returns the 2D head direction of the NPC.

**Returns:**
- Vector — The head direction.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetHeadDirection)

---

### NPC:GetHullType · Server
`NPC:GetHullType() → number`

Returns NPCs hull type set by [NPC:SetHullType](https://wiki.facepunch.com/gmod/NPC:SetHullType).

**Returns:**
- number — Hull type, see HULL

[wiki](https://wiki.facepunch.com/gmod/NPC:GetHullType)

---

### NPC:GetIdealActivity · Server
`NPC:GetIdealActivity() → number`

Returns the ideal activity the NPC currently wants to achieve.

**Returns:**
- number — The ideal activity.

> **Note:** By default, base NPCs will automatically attempt to play a sequence bound to the ideal activity. To prevent ideal activity from overriding NPC's active sequence, set this to `ACT_DO_NOT_DISTURB`.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetIdealActivity)

---

### NPC:GetIdealMoveAcceleration · Server
`NPC:GetIdealMoveAcceleration() → number`

Returns the ideal move acceleration of the NPC.

**Returns:**
- number — The ideal move acceleration.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetIdealMoveAcceleration)

---

### NPC:GetIdealMoveSpeed · Server
`NPC:GetIdealMoveSpeed() → number`

Returns the ideal move speed of the NPC.

**Returns:**
- number — The ideal move speed.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetIdealMoveSpeed)

---

### NPC:GetIdealSequence · Server
`NPC:GetIdealSequence() → number`

Returns the ideal sequence the NPC currently wants to achieve.

**Returns:**
- number — The ideal sequence, specific to the NPCs model.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetIdealSequence)

---

### NPC:GetIdealYaw · Server
`NPC:GetIdealYaw() → number`

Returns the ideal yaw (left right rotation) for this NPC at this moment.

**Returns:**
- number — The ideal yaw.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetIdealYaw)

---

### NPC:GetKnownEnemies · Server
`NPC:GetKnownEnemies() → table`

Returns all known enemies this NPC has. The enemy table is updated with [NPC:UpdateEnemyMemory](https://wiki.facepunch.com/gmod/NPC:UpdateEnemyMemory) and [NPC:ClearEnemyMemory](https://wiki.facepunch.com/gmod/NPC:ClearEnemyMemory), meaning other entities may be in enemies list even though your NPC doesn't hate it. 

See also [NPC:GetKnownEnemyCount](https://wiki.facepunch.com/gmod/NPC:GetKnownEnemyCount)

**Returns:**
- table — Table of entities that this NPC knows as enemies.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetKnownEnemies)

---

### NPC:GetKnownEnemyCount · Server
`NPC:GetKnownEnemyCount() → number`

Returns known enemy count of this NPC.

See also [NPC:GetKnownEnemies](https://wiki.facepunch.com/gmod/NPC:GetKnownEnemies)

**Returns:**
- number — Amount of entities that this NPC knows as enemies.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetKnownEnemyCount)

---

### NPC:GetLastPosition · Server
`NPC:GetLastPosition() → Vector`

Returns the last registered or memorized position of the NPC. When using scheduling, the NPC will focus on navigating to the last position via nodes.

See [NPC:SetLastPosition](https://wiki.facepunch.com/gmod/NPC:SetLastPosition).

**Returns:**
- `position` (Vector) — Where the NPC's last position was set to.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetLastPosition)

---

### NPC:GetLastTimeTookDamageFromEnemy · Server
`NPC:GetLastTimeTookDamageFromEnemy(enemy: Entity = nil) → number`

Returns [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime) based time since this NPC last received damage from given enemy. The last damage time is set when [NPC:MarkTookDamageFromEnemy](https://wiki.facepunch.com/gmod/NPC:MarkTookDamageFromEnemy) is called.

**Arguments:**
- `enemy` (Entity, default `nil`) — The enemy to test.

**Returns:**
- number — Time since this NPC last received damage from given enemy.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetLastTimeTookDamageFromEnemy)

---

### NPC:GetMaxLookDistance · Server
`NPC:GetMaxLookDistance() → number`

Returns NPCs max view distance. An NPC will not be able to see enemies outside of this distance.

**Returns:**
- `dist` (number) — The maximum distance the NPC can see at.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetMaxLookDistance)

---

### NPC:GetMinMoveCheckDist · Server
`NPC:GetMinMoveCheckDist() → number`

Returns how far should the NPC look ahead in its route.

**Returns:**
- number — How far the NPC checks ahead of its route.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetMinMoveCheckDist)

---

### NPC:GetMinMoveStopDist · Server
`NPC:GetMinMoveStopDist(minResult : number = 10) → number`

Returns how far before the NPC can come to a complete stop.

**Arguments:**
- `minResult ` (number, default `10`) — The minimum value that will be returned by this function.

**Returns:**
- number — The minimum stop distance.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetMinMoveStopDist)

---

### NPC:GetMoveDelay · Server
`NPC:GetMoveDelay() → number`

Returns the movement delay for given NPC.

See [NPC:SetMoveDelay](https://wiki.facepunch.com/gmod/NPC:SetMoveDelay).

**Returns:**
- number — The movement delay.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetMoveDelay)

---

### NPC:GetMoveInterval · Server
`NPC:GetMoveInterval() → number`

Returns the current timestep the internal NPC motor is working on.

**Returns:**
- number — The current timestep.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetMoveInterval)

---

### NPC:GetMovementActivity · Server
`NPC:GetMovementActivity() → number`

Returns the NPC's current movement activity.

**Returns:**
- number — Current NPC movement activity, see ACT.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetMovementActivity)

---

### NPC:GetMovementSequence · Server
`NPC:GetMovementSequence() → number`

Returns the index of the sequence the NPC uses to move.

**Returns:**
- number — The movement sequence index

[wiki](https://wiki.facepunch.com/gmod/NPC:GetMovementSequence)

---

### NPC:GetMoveVelocity · Server
`NPC:GetMoveVelocity() → Vector`

Returns the current move velocity of the NPC.

**Returns:**
- Vector — The current move velocity of the NPC.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetMoveVelocity)

---

### NPC:GetNavType · Server
`NPC:GetNavType() → number`

Returns the NPC's navigation type.

**Returns:**
- number — The nav type.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetNavType)

---

### NPC:GetNearestSquadMember · Server
`NPC:GetNearestSquadMember() → NPC`

Returns the nearest member of the squad the NPC is in.

**Returns:**
- `nearest_member` (NPC) — The nearest member of the squad the NPC is in.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetNearestSquadMember)

---

### NPC:GetNextWaypointPos · Server
`NPC:GetNextWaypointPos() → Vector`

Gets the NPC's next waypoint position, where NPC will be moving after reaching current waypoint, if any is available.

**Returns:**
- Vector — The position of the next NPC waypoint.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetNextWaypointPos)

---

### NPC:GetNPCState · Server
`NPC:GetNPCState() → number`

Returns the NPC's state.

**Returns:**
- number — The NPC's current state, see NPC_STATE.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetNPCState)

---

### NPC:GetPathDistanceToGoal · Server
`NPC:GetPathDistanceToGoal() → number`

Returns the distance the NPC is from Target Goal.

**Returns:**
- number — The number of hammer units the NPC is away from the Goal.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetPathDistanceToGoal)

---

### NPC:GetPathTimeToGoal · Server
`NPC:GetPathTimeToGoal() → number`

Returns the amount of time it will take for the NPC to get to its Target Goal.

**Returns:**
- number — The amount of time to get to the target goal.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetPathTimeToGoal)

---

### NPC:GetShootPos · Server
`NPC:GetShootPos() → Vector`

Returns the shooting position of the NPC, i.e. where their bullets would come from, etc. 

If the NPC does not overwrite this, it will return [Entity:GetPos](https://wiki.facepunch.com/gmod/Entity:GetPos).

**Returns:**
- Vector — The NPC's shooting position.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetShootPos)

---

### NPC:GetSquad · Server
`NPC:GetSquad() → string`

Returns the current squad name of the NPC, as set via [NPC:SetSquad](https://wiki.facepunch.com/gmod/NPC:SetSquad).

**Returns:**
- `name` (string) — The new squad name to set.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetSquad)

---

### NPC:GetStepHeight · Server
`NPC:GetStepHeight() → number`

Returns NPC step height.

**Returns:**
- `height` (number) — The current step height.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetStepHeight)

---

### NPC:GetTarget · Server
`NPC:GetTarget() → Entity`

Returns the NPC's current target set by [NPC:SetTarget](https://wiki.facepunch.com/gmod/NPC:SetTarget).

**Returns:**
- Entity — Target entity

> **Bug** ([#3132](https://github.com/Facepunch/garrysmod/issues/3132)): This returns nil if the NPC has no target. You should use [IsValid](https://wiki.facepunch.com/gmod/Global.IsValid) (which accounts for nil and NULL) on the return to verify validity of the target.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetTarget)

---

### NPC:GetTaskStatus · Server
`NPC:GetTaskStatus() → number`

Returns the status of the current task.

**Returns:**
- number — The status.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetTaskStatus)

---

### NPC:GetTimeEnemyLastReacquired · Server
`NPC:GetTimeEnemyLastReacquired(enemy: Entity = nil) → number`

Returns [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime) based time since the enemy was reacquired, meaning it is currently in Line of Sight of the NPC.

**Arguments:**
- `enemy` (Entity, default `nil`) — The enemy to test.

**Returns:**
- number — Time enemy was last reacquired.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetTimeEnemyLastReacquired)

---

### NPC:GetViewOffset · Server
`NPC:GetViewOffset() → Vector`

Returns the view offset of the NPC. Set by [NPC:SetViewOffset](https://wiki.facepunch.com/gmod/NPC:SetViewOffset).

**Returns:**
- Vector — The view offset of the NPC.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetViewOffset)

---

### NPC:GetWeapon · Server
`NPC:GetWeapon(class: string) → Weapon`

Returns a specific weapon the NPC owns.

**Arguments:**
- `class` (string) — A classname of the weapon to try to get.

**Returns:**
- `wep` (Weapon) — The weapon for the specified class, or NULL of the NPC doesn't have given weapon.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetWeapon)

---

### NPC:GetWeapons · Server
`NPC:GetWeapons() → table<Weapon>`

Returns a table of the NPC's weapons.

**Returns:**
- table<Weapon> — A list of the weapons the NPC currently has.

[wiki](https://wiki.facepunch.com/gmod/NPC:GetWeapons)

---

### NPC:Give · Server
`NPC:Give(weapon: string) → Weapon`

Used to give a weapon to an already spawned NPC.

**Arguments:**
- `weapon` (string) — Class name of the weapon to equip to the NPC.

**Returns:**
- Weapon — The weapon entity given to the NPC.

[wiki](https://wiki.facepunch.com/gmod/NPC:Give)

---

### NPC:HasCondition · Server
`NPC:HasCondition(condition: number) → boolean`

Returns whether or not the NPC has the given condition.

**Arguments:**
- `condition` (number, enum [COND](https://wiki.facepunch.com/gmod/Enums/COND)) — The condition index, see COND.

**Returns:**
- boolean — True if the NPC has the given condition, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/NPC:HasCondition)

---

### NPC:HasEnemyEluded · Server
`NPC:HasEnemyEluded(enemy: Entity = GetEnemy()) → boolean`

Polls the enemy memory to check if the given entity has eluded us or not.

**Arguments:**
- `enemy` (Entity, default `GetEnemy()`) — The enemy to test.

**Returns:**
- `eluded` (boolean) — If the enemy has eluded us.

[wiki](https://wiki.facepunch.com/gmod/NPC:HasEnemyEluded)

---

### NPC:HasEnemyMemory · Server
`NPC:HasEnemyMemory(enemy: Entity = GetEnemy()) → boolean`

Polls the enemy memory to check if the NPC has any memory of given enemy.

**Arguments:**
- `enemy` (Entity, default `GetEnemy()`) — The entity to test.

**Returns:**
- `eluded` (boolean) — If we have any memory on given enemy.

[wiki](https://wiki.facepunch.com/gmod/NPC:HasEnemyMemory)

---

### NPC:HasObstacles · Server
`NPC:HasObstacles() → boolean`

Returns true if the current navigation has an obstacle, this is different from [NPC:GetBlockingEntity](https://wiki.facepunch.com/gmod/NPC:GetBlockingEntity), this is for virtual navigation obstacles put by AI's local navigation system to prevent movement to the marked area, forcing NPC to steer around, [for example](https://github.com/ValveSoftware/source-sdk-2013/blob/master/src/game/server/hl2/npc_playercompanion.cpp#L2897).

**Returns:**
- boolean — `true` if the current navigation has an obstacle.

[wiki](https://wiki.facepunch.com/gmod/NPC:HasObstacles)

---

### NPC:IdleSound · Server
`NPC:IdleSound()`

Force an NPC to play their Idle sound.

[wiki](https://wiki.facepunch.com/gmod/NPC:IdleSound)

---

### NPC:IgnoreEnemyUntil · Server
`NPC:IgnoreEnemyUntil(enemy: Entity, until: number)`

Makes the NPC ignore given entity/enemy until given time.

**Arguments:**
- `enemy` (Entity) — The enemy to ignore.
- `until` (number) — How long to ignore the enemy for.

[wiki](https://wiki.facepunch.com/gmod/NPC:IgnoreEnemyUntil)

---

### NPC:IsCrouching · Server
`NPC:IsCrouching() → boolean`

Returns whether the NPC is currently crouching or not. Citizens and Combine Soldiers are capable of this behavior by default.

**Returns:**
- boolean — Whether the NPC is currently crouching.

[wiki](https://wiki.facepunch.com/gmod/NPC:IsCrouching)

---

### NPC:IsCurrentSchedule · Server
`NPC:IsCurrentSchedule(schedule: number) → boolean`

Returns whether or not the NPC is performing the given schedule.

**Arguments:**
- `schedule` (number, enum [SCHED](https://wiki.facepunch.com/gmod/Enums/SCHED)) — The schedule number, see SCHED.

**Returns:**
- boolean — True if the NPC is performing the given schedule, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/NPC:IsCurrentSchedule)

---

### NPC:IsCurWaypointGoal · Server
`NPC:IsCurWaypointGoal() → boolean`

Returns whether the current navigational waypoint is the final one.

**Returns:**
- boolean — Whether the current navigational waypoint is the final one.

[wiki](https://wiki.facepunch.com/gmod/NPC:IsCurWaypointGoal)

---

### NPC:IsFacingIdealYaw · Server
`NPC:IsFacingIdealYaw() → boolean`

Returns whether the NPC is facing their ideal yaw. See [NPC:SetIdealYaw](https://wiki.facepunch.com/gmod/NPC:SetIdealYaw), [NPC:GetIdealYaw](https://wiki.facepunch.com/gmod/NPC:GetIdealYaw) and [NPC:SetIdealYawAndUpdate](https://wiki.facepunch.com/gmod/NPC:SetIdealYawAndUpdate).

**Returns:**
- boolean — Whether the NPC is facing their ideal yaw.

[wiki](https://wiki.facepunch.com/gmod/NPC:IsFacingIdealYaw)

---

### NPC:IsGoalActive · Server
`NPC:IsGoalActive() → boolean`

Returns whether the NPC has an active goal.

**Returns:**
- `act` (boolean) — Whether the NPC has an active goal or not.

[wiki](https://wiki.facepunch.com/gmod/NPC:IsGoalActive)

---

### NPC:IsInViewCone · Server
`NPC:IsInViewCone(position: Vector, ent: Entity) → boolean`

Tests whether a position or an NPC is in the view cone of the NPC.

**Arguments:**
- `position` (Vector) — The position to test.
- `ent` (Entity) — The entity to test.

**Returns:**
- boolean — If the given position is in the view cone.

[wiki](https://wiki.facepunch.com/gmod/NPC:IsInViewCone)

---

### NPC:IsMoveYawLocked · Server
`NPC:IsMoveYawLocked() → boolean`

Returns if the current movement is locked on the Yaw axis.

**Returns:**
- boolean — Whether the movement is yaw locked or not.

[wiki](https://wiki.facepunch.com/gmod/NPC:IsMoveYawLocked)

---

### NPC:IsMoving · Server
`NPC:IsMoving() → boolean`

Returns whether the NPC is moving or not.

**Returns:**
- boolean — Whether the NPC is moving or not.

[wiki](https://wiki.facepunch.com/gmod/NPC:IsMoving)

---

### NPC:IsRunningBehavior · Server
`NPC:IsRunningBehavior() → boolean`

Checks if the NPC is running an **ai_goal**. ( e.g. An npc_citizen NPC following the Player. )

**Returns:**
- boolean — Returns true if running an ai_goal, otherwise returns false.

[wiki](https://wiki.facepunch.com/gmod/NPC:IsRunningBehavior)

---

### NPC:IsSquadLeader · Server
`NPC:IsSquadLeader() → boolean`

Returns whether the current NPC is the leader of the squad it is in.

**Returns:**
- `is_leader` (boolean) — Whether the NPC is the leader of the squad or not.

[wiki](https://wiki.facepunch.com/gmod/NPC:IsSquadLeader)

---

### NPC:IsUnforgettable · Server
`NPC:IsUnforgettable(enemy: Entity) → boolean`

Returns the "forgettable" status for a given enemy, as set by [NPC:SetUnforgettable](https://wiki.facepunch.com/gmod/NPC:SetUnforgettable), or by internal logic of engine NPCs.

**Arguments:**
- `enemy` (Entity) — Enemy entity to check.

**Returns:**
- boolean — Whether the given enemy is unforgettable (`true`) or not.

[wiki](https://wiki.facepunch.com/gmod/NPC:IsUnforgettable)

---

### NPC:IsUnreachable · Server
`NPC:IsUnreachable(testEntity: Entity) → boolean`

Returns true if the entity was remembered as unreachable. The memory is updated automatically from following engine tasks if they failed:
* TASK_GET_CHASE_PATH_TO_ENEMY
* TASK_GET_PATH_TO_ENEMY_LKP
* TASK_GET_PATH_TO_INTERACTION_PARTNER
* TASK_ANTLIONGUARD_GET_CHASE_PATH_ENEMY_TOLERANCE
* SCHED_FAIL_ESTABLISH_LINE_OF_FIRE - Combine NPCs, also when failing to change their enemy

**Arguments:**
- `testEntity` (Entity) — The entity to test.

**Returns:**
- boolean — If the entity is reachable or not.

[wiki](https://wiki.facepunch.com/gmod/NPC:IsUnreachable)

---

### NPC:LostEnemySound · Server
`NPC:LostEnemySound()`

Force an NPC to play their LostEnemy sound.

[wiki](https://wiki.facepunch.com/gmod/NPC:LostEnemySound)

---

### NPC:MaintainActivity · Server
`NPC:MaintainActivity()`

Tries to achieve our ideal animation state, playing any transition sequences that we need to play to get there.

[wiki](https://wiki.facepunch.com/gmod/NPC:MaintainActivity)

---

### NPC:MarkEnemyAsEluded · Server
`NPC:MarkEnemyAsEluded(enemy: Entity = GetEnemy())`

Causes the NPC to temporarily forget the current enemy and switch on to a better one.

**Arguments:**
- `enemy` (Entity, default `GetEnemy()`) — The enemy to mark

[wiki](https://wiki.facepunch.com/gmod/NPC:MarkEnemyAsEluded)

---

### NPC:MarkTookDamageFromEnemy · Server
`NPC:MarkTookDamageFromEnemy(enemy: Entity = nil)`

Marks the NPC as took damage from given entity.

See also [NPC:GetLastTimeTookDamageFromEnemy](https://wiki.facepunch.com/gmod/NPC:GetLastTimeTookDamageFromEnemy).

**Arguments:**
- `enemy` (Entity, default `nil`) — The enemy to mark.

[wiki](https://wiki.facepunch.com/gmod/NPC:MarkTookDamageFromEnemy)

---

### NPC:MoveClimbExec · Server
`NPC:MoveClimbExec(destination: Vector, dir: Vector, distance: number, yaw: number, left: number) → number{AIMR}`

Executes a climb move.

Related functions are [NPC:MoveClimbStart](https://wiki.facepunch.com/gmod/NPC:MoveClimbStart) and [NPC:MoveClimbStop](https://wiki.facepunch.com/gmod/NPC:MoveClimbStop).

**Arguments:**
- `destination` (Vector) — The destination of the climb.
- `dir` (Vector) — The direction of the climb.
- `distance` (number) — The distance.
- `yaw` (number) — The yaw angle.
- `left` (number) — Amount of climb nodes left?

**Returns:**
- number{AIMR} — The result.

[wiki](https://wiki.facepunch.com/gmod/NPC:MoveClimbExec)

---

### NPC:MoveClimbStart · Server
`NPC:MoveClimbStart(destination: Vector, dir: Vector, distance: number, yaw: number)`

Starts a climb move.

Related functions are [NPC:MoveClimbExec](https://wiki.facepunch.com/gmod/NPC:MoveClimbExec) and [NPC:MoveClimbStop](https://wiki.facepunch.com/gmod/NPC:MoveClimbStop).

**Arguments:**
- `destination` (Vector) — The destination of the climb.
- `dir` (Vector) — The direction of the climb.
- `distance` (number) — The distance.
- `yaw` (number) — The yaw angle.

[wiki](https://wiki.facepunch.com/gmod/NPC:MoveClimbStart)

---

### NPC:MoveClimbStop · Server
`NPC:MoveClimbStop()`

Stops a climb move.

Related functions are [NPC:MoveClimbExec](https://wiki.facepunch.com/gmod/NPC:MoveClimbExec) and [NPC:MoveClimbStart](https://wiki.facepunch.com/gmod/NPC:MoveClimbStart).

[wiki](https://wiki.facepunch.com/gmod/NPC:MoveClimbStop)

---

### NPC:MoveGroundStep · Server
`NPC:MoveGroundStep(pos: Vector, targetEntity: Entity = nil, yaw: number = -1, asFarAsCan: boolean = true, testZ: boolean = true) → number`

Similar to other `NPC:Move*` functions, invokes internal code to move the NPC to a given location.

Meant to be used within [ENTITY:OverrideMove](https://wiki.facepunch.com/gmod/ENTITY:OverrideMove).

**Arguments:**
- `pos` (Vector) — The position we want to reach.
- `targetEntity` (Entity, default `nil`) — Used to test whether we hit the move target when deciding success.
- `yaw` (number, default `-1`) — Target Yaw angle at the end of the move.
- `asFarAsCan` (boolean, default `true`) — Whether to move as far as possible.
- `testZ` (boolean, default `true`) — Also test the Z axis of the target position and NPC position to decide success.

**Returns:**
- number — Whether the movement succeeded or not.

[wiki](https://wiki.facepunch.com/gmod/NPC:MoveGroundStep)

---

### NPC:MoveJumpExec · Server
`NPC:MoveJumpExec() → number{AIMR}`

Executes a jump move.

Related functions are [NPC:MoveJumpStart](https://wiki.facepunch.com/gmod/NPC:MoveJumpStart) and [NPC:MoveJumpStop](https://wiki.facepunch.com/gmod/NPC:MoveJumpStop).

**Returns:**
- number{AIMR} — The result.

[wiki](https://wiki.facepunch.com/gmod/NPC:MoveJumpExec)

---

### NPC:MoveJumpStart · Server
`NPC:MoveJumpStart(vel: Vector)`

Starts a jump move.

Related functions are [NPC:MoveJumpExec](https://wiki.facepunch.com/gmod/NPC:MoveJumpExec) and [NPC:MoveJumpStop](https://wiki.facepunch.com/gmod/NPC:MoveJumpStop).

**Arguments:**
- `vel` (Vector) — The jump velocity.

[wiki](https://wiki.facepunch.com/gmod/NPC:MoveJumpStart)

---

### NPC:MoveJumpStop · Server
`NPC:MoveJumpStop() → number{AIMR}`

Stops a jump move.

Related functions are [NPC:MoveJumpExec](https://wiki.facepunch.com/gmod/NPC:MoveJumpExec) and [NPC:MoveJumpStart](https://wiki.facepunch.com/gmod/NPC:MoveJumpStart).

**Returns:**
- number{AIMR} — The result.

[wiki](https://wiki.facepunch.com/gmod/NPC:MoveJumpStop)

---

### NPC:MoveOrder · Server
`NPC:MoveOrder(position: Vector)`

Makes the NPC walk toward the given position. The NPC will return to the player after amount of time set by **player_squad_autosummon_time** [ConVar](https://wiki.facepunch.com/gmod/ConVar).

Only works on Citizens (npc_citizen) and is a part of the Half-Life 2 squad system.

The NPC **must** be in the player's squad for this to work.

**Arguments:**
- `position` (Vector) — The target position for the NPC to walk to.

[wiki](https://wiki.facepunch.com/gmod/NPC:MoveOrder)

---

### NPC:MovePause · Server
`NPC:MovePause()`

Pauses the NPC movement?

Related functions are [NPC:MoveStart](https://wiki.facepunch.com/gmod/NPC:MoveStart), [NPC:MoveStop](https://wiki.facepunch.com/gmod/NPC:MoveStop) and [NPC:ResetMoveCalc](https://wiki.facepunch.com/gmod/NPC:ResetMoveCalc).

[wiki](https://wiki.facepunch.com/gmod/NPC:MovePause)

---

### NPC:MoveStart · Server
`NPC:MoveStart()`

Starts NPC movement?

Related functions are [NPC:MoveStop](https://wiki.facepunch.com/gmod/NPC:MoveStop), [NPC:MovePause](https://wiki.facepunch.com/gmod/NPC:MovePause) and [NPC:ResetMoveCalc](https://wiki.facepunch.com/gmod/NPC:ResetMoveCalc).

[wiki](https://wiki.facepunch.com/gmod/NPC:MoveStart)

---

### NPC:MoveStop · Server
`NPC:MoveStop()`

Stops the NPC movement?

Related functions are [NPC:MoveStart](https://wiki.facepunch.com/gmod/NPC:MoveStart), [NPC:MovePause](https://wiki.facepunch.com/gmod/NPC:MovePause) and [NPC:ResetMoveCalc](https://wiki.facepunch.com/gmod/NPC:ResetMoveCalc).

[wiki](https://wiki.facepunch.com/gmod/NPC:MoveStop)

---

### NPC:NavSetGoal · Server
`NPC:NavSetGoal(pos: Vector, length: number, dir: Vector) → boolean`

Picks random node around given vector, around specified length, using dir as search direction start. Works similarly to [NPC:NavSetRandomGoal](https://wiki.facepunch.com/gmod/NPC:NavSetRandomGoal), but you can decide any position you want as a search starting point rather than your NPC.

**Arguments:**
- `pos` (Vector) — The origin to calculate a path from.
- `length` (number) — The target length of the path to calculate.
- `dir` (Vector) — The direction in which to look for a new path end goal.

**Returns:**
- boolean — Whether path generation was successful or not.

[wiki](https://wiki.facepunch.com/gmod/NPC:NavSetGoal)

---

### NPC:NavSetGoalPos · Server
`NPC:NavSetGoalPos(pos: Vector) → boolean`

Creates a path to closest node at given position. This won't actually force the NPC to move.



See also [NPC:NavSetRandomGoal](https://wiki.facepunch.com/gmod/NPC:NavSetRandomGoal).

**Arguments:**
- `pos` (Vector) — The position to calculate a path to.

**Returns:**
- boolean — Whether path generation was successful or not.

> **Note:** This will call either [NPC:TaskComplete](https://wiki.facepunch.com/gmod/NPC:TaskComplete) or [NPC:TaskFail](https://wiki.facepunch.com/gmod/NPC:TaskFail) for the current schedule and task, forcing the current task to progress to next task or fail.

[wiki](https://wiki.facepunch.com/gmod/NPC:NavSetGoalPos)

---

### NPC:NavSetGoalTarget · Server
`NPC:NavSetGoalTarget(target: Entity, offset: Vector = Vector( 0, 0, 0 )) → boolean`

Set the goal target for an NPC.

This will call either [NPC:TaskComplete](https://wiki.facepunch.com/gmod/NPC:TaskComplete) or [NPC:TaskFail](https://wiki.facepunch.com/gmod/NPC:TaskFail) for the current schedule and task, forcing the current task to progress to next task or fail.

**Arguments:**
- `target` (Entity) — The targeted entity to set the goal to.
- `offset` (Vector, default `Vector( 0, 0, 0 )`) — The offset to apply to the targeted entity's position.

**Returns:**
- boolean — Whether path generation was successful or not

[wiki](https://wiki.facepunch.com/gmod/NPC:NavSetGoalTarget)

---

### NPC:NavSetRandomGoal · Server
`NPC:NavSetRandomGoal(minPathLength: number, dir: Vector) → boolean`

Creates a random path of specified minimum length between a closest start node and random node in the specified direction. This won't actually force the NPC to move.

**Arguments:**
- `minPathLength` (number) — Minimum length of path in units
- `dir` (Vector) — Unit vector pointing in the direction of the target random node

**Returns:**
- boolean — Whether path generation was successful or not

[wiki](https://wiki.facepunch.com/gmod/NPC:NavSetRandomGoal)

---

### NPC:NavSetWanderGoal · Server
`NPC:NavSetWanderGoal(xOffset: number, yOffset: number) → boolean`

Sets a goal in x, y offsets for the NPC to wander to

**Arguments:**
- `xOffset` (number) — X offset
- `yOffset` (number) — Y offset

**Returns:**
- boolean — Whether path generation was successful or not

[wiki](https://wiki.facepunch.com/gmod/NPC:NavSetWanderGoal)

---

### NPC:PickupWeapon · Server
`NPC:PickupWeapon(wep: Weapon) → boolean`

Forces the NPC to pickup an existing weapon entity. The NPC will not pick up the weapon if they already own a weapon of given type, or if the NPC could not normally have this weapon in their inventory.

**Arguments:**
- `wep` (Weapon) — The weapon to try to pick up.

**Returns:**
- `result` (boolean) — Whether the NPC succeeded in picking up the weapon or not.

[wiki](https://wiki.facepunch.com/gmod/NPC:PickupWeapon)

---

### NPC:PlaySentence · Server
`NPC:PlaySentence(sentence: string, delay: number, volume: number) → number`

Forces the NPC to play a sentence from scripts/sentences.txt

**Arguments:**
- `sentence` (string) — The sentence string to speak.
- `delay` (number) — Delay in seconds until the sentence starts playing.
- `volume` (number) — The volume of the sentence, from 0 to 1.

**Returns:**
- number — Returns the sentence index, -1 if the sentence couldn't be played.

[wiki](https://wiki.facepunch.com/gmod/NPC:PlaySentence)

---

### NPC:RememberUnreachable · Server
`NPC:RememberUnreachable(ent: Entity, time: number = 3)`

Makes the NPC remember an entity or an enemy as unreachable, for a specified amount of time. Use [NPC:IsUnreachable](https://wiki.facepunch.com/gmod/NPC:IsUnreachable) to check if an entity is still unreachable.

**Arguments:**
- `ent` (Entity) — The entity to mark as unreachable.
- `time` (number, default `3`) — For how long to remember the entity as unreachable.

[wiki](https://wiki.facepunch.com/gmod/NPC:RememberUnreachable)

---

### NPC:RemoveIgnoreConditions · Server
`NPC:RemoveIgnoreConditions(conditions: table = nil)`

Removes conditions to ignore for the this NPC.

**Arguments:**
- `conditions` (table, default `nil`) — Ignore conditions to remove, see COND.

[wiki](https://wiki.facepunch.com/gmod/NPC:RemoveIgnoreConditions)

---

### NPC:ResetIdealActivity · Server
`NPC:ResetIdealActivity(act: number)`

Resets the ideal activity of the NPC. See also [NPC:SetIdealActivity](https://wiki.facepunch.com/gmod/NPC:SetIdealActivity).

**Arguments:**
- `act` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The new activity.

[wiki](https://wiki.facepunch.com/gmod/NPC:ResetIdealActivity)

---

### NPC:ResetMoveCalc · Server
`NPC:ResetMoveCalc()`

Resets all the movement calculations.

Related functions are [NPC:MoveStart](https://wiki.facepunch.com/gmod/NPC:MoveStart), [NPC:MovePause](https://wiki.facepunch.com/gmod/NPC:MovePause) and [NPC:MoveStop](https://wiki.facepunch.com/gmod/NPC:MoveStop).

[wiki](https://wiki.facepunch.com/gmod/NPC:ResetMoveCalc)

---

### NPC:RunEngineTask · Server
`NPC:RunEngineTask(taskID: number, taskData: number)`

Starts an engine task.

Used internally by the [ai_task](https://wiki.facepunch.com/gmod/ai_task).

**Arguments:**
- `taskID` (number) — The task ID, see ai_task.h
- `taskData` (number) — The task data.

[wiki](https://wiki.facepunch.com/gmod/NPC:RunEngineTask)

---

### NPC:SelectWeapon · Server
`NPC:SelectWeapon(weapon: string|Weapon)`

Forces the NPC to switch to a specific weapon the NPC owns. See [NPC:GetWeapons](https://wiki.facepunch.com/gmod/NPC:GetWeapons).

**Arguments:**
- `weapon` (string|Weapon) — A classname of the weapon or a Weapon entity to switch to.

[wiki](https://wiki.facepunch.com/gmod/NPC:SelectWeapon)

---

### NPC:SentenceStop · Server
`NPC:SentenceStop()`

Stops any sounds (speech) the NPC is currently playing.

Equivalent to `Entity:EmitSound( "AI_BaseNPC.SentenceStop" )`

[wiki](https://wiki.facepunch.com/gmod/NPC:SentenceStop)

---

### NPC:SetActivity · Server
`NPC:SetActivity(act: number)`

Sets the NPC's current activity.

**Arguments:**
- `act` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The new activity to set, see ACT.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetActivity)

---

### NPC:SetArrivalActivity · Server
`NPC:SetArrivalActivity(act: number)`

**Arguments:**
- `act` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — See ACT.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetArrivalActivity)

---

### NPC:SetArrivalDirection · Server
`NPC:SetArrivalDirection(dir: Vector)`

Sets the direction from the NPC origin to its current navigational destination.

**Arguments:**
- `dir` (Vector) — The new arrival direction.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetArrivalDirection)

---

### NPC:SetArrivalDistance · Server
`NPC:SetArrivalDistance(dist: number)`

Sets the distance to goal at which the NPC should stop moving and continue to other business such as doing the rest of their tasks in a schedule.

**Arguments:**
- `dist` (number) — The distance to goal that is close enough for the NPC

[wiki](https://wiki.facepunch.com/gmod/NPC:SetArrivalDistance)

---

### NPC:SetArrivalSequence · Server
`NPC:SetArrivalSequence(seq: number)`

Sets the sequence to be played when the NPC arrives at its goal.

**Arguments:**
- `seq` (number) — See Entity:LookupSequence.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetArrivalSequence)

---

### NPC:SetArrivalSpeed · Server
`NPC:SetArrivalSpeed(speed: number)`

Sets the arrival speed? of the NPC

**Arguments:**
- `speed` (number) — The new arrival speed

[wiki](https://wiki.facepunch.com/gmod/NPC:SetArrivalSpeed)

---

### NPC:SetCondition · Server
`NPC:SetCondition(condition: number{COND})`

Sets an NPC condition.

**Arguments:**
- `condition` (number{COND}) — The condition index, see COND.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetCondition)

---

### NPC:SetCurrentWeaponProficiency · Server
`NPC:SetCurrentWeaponProficiency(proficiency: number)`

Sets the weapon proficiency of an NPC (how skilled an NPC is with its current weapon).

**Arguments:**
- `proficiency` (number, enum [WEAPON_PROFICIENCY](https://wiki.facepunch.com/gmod/Enums/WEAPON_PROFICIENCY)) — The proficiency for the NPC's current weapon.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetCurrentWeaponProficiency)

---

### NPC:SetEnemy · Server
`NPC:SetEnemy(enemy: Entity, newenemy: boolean = true)`

Sets the target for an NPC.

**Arguments:**
- `enemy` (Entity) — The enemy that the NPC should target
- `newenemy` (boolean, default `true`) — Calls NPC:SetCondition(COND.NEW_ENEMY) if the new enemy is valid and not equal to the last enemy.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetEnemy)

---

### NPC:SetExpression · Server
`NPC:SetExpression(m_iszExpressionScene: string) → number`

Sets the NPC's .vcd expression. Similar to [Entity:PlayScene](https://wiki.facepunch.com/gmod/Entity:PlayScene) except the scene is looped until it's interrupted by default NPC behavior or [NPC:ClearExpression](https://wiki.facepunch.com/gmod/NPC:ClearExpression).

**Arguments:**
- `m_iszExpressionScene` (string) — The expression filepath.

**Returns:**
- `flDuration` (number) — Default duration of assigned expression, in seconds.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetExpression)

---

### NPC:SetForceCrouch · Server
`NPC:SetForceCrouch(force: boolean)`

Forces given NPC to crouch, if it is able to do so. Only Citizens and Combine Soldiers can by default.

**Arguments:**
- `force` (boolean) — Whether to force the NPC to crouch or not.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetForceCrouch)

---

### NPC:SetFOV · Server
`NPC:SetFOV(fov: number)`

Sets the Field Of View of the NPC, for use with such functions as [NPC:IsInViewCone](https://wiki.facepunch.com/gmod/NPC:IsInViewCone). it is also used internally by the NPC for enemy detection, etc.

**Arguments:**
- `fov` (number) — The new FOV for the NPC in degrees.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetFOV)

---

### NPC:SetHullSizeNormal · Server
`NPC:SetHullSizeNormal()`

Updates the NPC's hull and physics hull in order to match its model scale. [Entity:SetModelScale](https://wiki.facepunch.com/gmod/Entity:SetModelScale) seems to take care of this regardless.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetHullSizeNormal)

---

### NPC:SetHullType · Server
`NPC:SetHullType(hullType: number)`

Sets the hull type for the NPC.

**Arguments:**
- `hullType` (number, enum [HULL](https://wiki.facepunch.com/gmod/Enums/HULL)) — Hull type.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetHullType)

---

### NPC:SetIdealActivity · Server
`NPC:SetIdealActivity(a1: number)`

Sets the ideal activity the NPC currently wants to achieve. This is most useful for custom SNPCs.

**Arguments:**
- `a1` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The ideal activity to set.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetIdealActivity)

---

### NPC:SetIdealSequence · Server
`NPC:SetIdealSequence(sequenceId: number)`

Sets the ideal sequence the NPC currently wants to achieve. This is most useful for custom SNPCs.

**Arguments:**
- `sequenceId` (number) — The ideal sequence to set.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetIdealSequence)

---

### NPC:SetIdealYaw · Server
`NPC:SetIdealYaw(angle: number)`

Sets the ideal yaw angle (left-right rotation) for the NPC. Does not actually force the NPC to start turning in that direction. See [NPC:UpdateYaw](https://wiki.facepunch.com/gmod/NPC:UpdateYaw), [NPC:GetIdealYaw](https://wiki.facepunch.com/gmod/NPC:GetIdealYaw) and [NPC:SetIdealYawAndUpdate](https://wiki.facepunch.com/gmod/NPC:SetIdealYawAndUpdate).

**Arguments:**
- `angle` (number) — The aim direction to set, the `yaw` component.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetIdealYaw)

---

### NPC:SetIdealYawAndUpdate · Server
`NPC:SetIdealYawAndUpdate(angle: number, speed: number = -1)`

Sets the ideal yaw angle (left-right rotation) for the NPC and forces them to turn to that angle.

**Arguments:**
- `angle` (number) — The aim direction to set, the `yaw` component.
- `speed` (number, default `-1`) — The turn speed.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetIdealYawAndUpdate)

---

### NPC:SetIgnoreConditions · Server
`NPC:SetIgnoreConditions(conditions: table, size: number)`

Sets conditions to ignore, which would normally interrupt an Engine-based schedule. Specified conditions will still be set, will call [ENTITY:OnCondition](https://wiki.facepunch.com/gmod/ENTITY:OnCondition) and can be returned by [NPC:HasCondition](https://wiki.facepunch.com/gmod/NPC:HasCondition), but they will no longer interrupt the Engine schedule.

**Arguments:**
- `conditions` (table) — Conditions to ignore, see COND.
- `size` (number) — Number of conditions to include in the ignored conditions table.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetIgnoreConditions)

---

### NPC:SetLastPosition · Server
`NPC:SetLastPosition(position: Vector)`

Sets the last registered or memorized position for this NPC. When using scheduling, the NPC will focus on navigating to the last position via nodes.

**Arguments:**
- `position` (Vector) — Where the NPC's last position will be set.

> **Note:** The navigation requires ground nodes to function properly, otherwise the NPC could only navigate in a small area. (https://developer.valvesoftware.com/wiki/Info_node)

[wiki](https://wiki.facepunch.com/gmod/NPC:SetLastPosition)

---

### NPC:SetMaxLookDistance · Server
`NPC:SetMaxLookDistance(dist: number)`

Sets NPC's max view distance. An NPC will not be able to see enemies outside of this distance.

**Arguments:**
- `dist` (number) — New maximum distance the NPC can see at.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetMaxLookDistance)

---

### NPC:SetMaxRouteRebuildTime · Server
`NPC:SetMaxRouteRebuildTime(time: number)`

Sets how long to try rebuilding path before failing task.

**Arguments:**
- `time` (number) — How long to try rebuilding path before failing task

[wiki](https://wiki.facepunch.com/gmod/NPC:SetMaxRouteRebuildTime)

---

### NPC:SetMoveDelay · Server
`NPC:SetMoveDelay(delay: number)`

Sets the movement delay for given NPC.

See [NPC:GetMoveDelay](https://wiki.facepunch.com/gmod/NPC:GetMoveDelay).

**Arguments:**
- `delay` (number) — The amount of time in seconds to delay movement by.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetMoveDelay)

---

### NPC:SetMoveInterval · Server
`NPC:SetMoveInterval(time: number)`

Sets the timestep the internal NPC motor is working on.

**Arguments:**
- `time` (number) — The new timestep.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetMoveInterval)

---

### NPC:SetMovementActivity · Server
`NPC:SetMovementActivity(activity: number)`

Sets the activity the NPC uses when it moves.

**Arguments:**
- `activity` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The movement activity, see ACT.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetMovementActivity)

---

### NPC:SetMovementSequence · Server
`NPC:SetMovementSequence(sequenceId: number)`

Sets the sequence the NPC navigation path uses for speed calculation. Doesn't seem to have any visible effect on NPC movement or actively playing sequence.
	
To be able to use this, first set [NPC:SetIdealActivity](https://wiki.facepunch.com/gmod/NPC:SetIdealActivity) to `ACT_DO_NOT_DISTURB`, set this to any sequence with root motion data and call [Entity:SetSequence](https://wiki.facepunch.com/gmod/Entity:SetSequence) on your desired sequence. As long as your NPC's [NPC:GetMovementSequence](https://wiki.facepunch.com/gmod/NPC:GetMovementSequence) has root motion data, your NPC will move to navigation point even though your NPC's [Entity:GetSequence](https://wiki.facepunch.com/gmod/Entity:GetSequence) doesn't have any motion.

**Arguments:**
- `sequenceId` (number) — The movement sequence index

[wiki](https://wiki.facepunch.com/gmod/NPC:SetMovementSequence)

---

### NPC:SetMoveVelocity · Server
`NPC:SetMoveVelocity(vel: Vector)`

Sets the move velocity of the NPC

**Arguments:**
- `vel` (Vector) — The new movement velocity.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetMoveVelocity)

---

### NPC:SetMoveYawLocked · Server
`NPC:SetMoveYawLocked(lock: boolean)`

Sets whether the current movement should locked on the Yaw axis or not.

**Arguments:**
- `lock` (boolean) — Whether the movement should yaw locked or not.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetMoveYawLocked)

---

### NPC:SetNavType · Server
`NPC:SetNavType(navtype: number)`

Sets the navigation type of the NPC.

**Arguments:**
- `navtype` (number, enum [NAV](https://wiki.facepunch.com/gmod/Enums/NAV)) — The new nav type.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetNavType)

---

### NPC:SetNPCState · Server
`NPC:SetNPCState(state: number)`

Sets the state the NPC is in to help it decide on a ideal schedule.

**Arguments:**
- `state` (number, enum [NPC_STATE](https://wiki.facepunch.com/gmod/Enums/NPC_STATE)) — New NPC state, see NPC_STATE

[wiki](https://wiki.facepunch.com/gmod/NPC:SetNPCState)

---

### NPC:SetSchedule · Server
`NPC:SetSchedule(schedule: number)`

Sets the NPC's current schedule.

**Arguments:**
- `schedule` (number, enum [SCHED](https://wiki.facepunch.com/gmod/Enums/SCHED)) — The NPC schedule, see SCHED.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetSchedule)

---

### NPC:SetSquad · Server
`NPC:SetSquad(name: string = nil)`

Assigns the NPC to a new squad. A squad can have up to 16 NPCs. NPCs in a single squad should be friendly to each other.

See also [ai.GetSquadMembers](https://wiki.facepunch.com/gmod/ai.GetSquadMembers) and [NPC:GetSquad](https://wiki.facepunch.com/gmod/NPC:GetSquad).

NPCs within the same squad are meant to function more effectively, tactics wise.

**Arguments:**
- `name` (string, default `nil`) — The new squad name to set.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetSquad)

---

### NPC:SetStepHeight · Server
`NPC:SetStepHeight(height: number)`

Sets the SNPC step height.

**Arguments:**
- `height` (number) — The new step height.

> **Note:** This only works for [scripted NPCs](https://wiki.facepunch.com/gmod/Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/NPC:SetStepHeight)

---

### NPC:SetTarget · Server
`NPC:SetTarget(entity: Entity)`

Sets the NPC's target. This is used in some engine schedules.

**Arguments:**
- `entity` (Entity) — The target of the NPC.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetTarget)

---

### NPC:SetTaskStatus · Server
`NPC:SetTaskStatus(status: number)`

Sets the status of the current task.

**Arguments:**
- `status` (number, enum [TASKSTATUS](https://wiki.facepunch.com/gmod/Enums/TASKSTATUS)) — The status.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetTaskStatus)

---

### NPC:SetUnforgettable · Server
`NPC:SetUnforgettable(enemy: Entity, set: boolean = true)`

Sets given entity as an unforgettable enemy. The state can be retrieved via [NPC:IsUnforgettable](https://wiki.facepunch.com/gmod/NPC:IsUnforgettable).

**Arguments:**
- `enemy` (Entity) — The enemy entity to set.
- `set` (boolean, default `true`) — The entity to set.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetUnforgettable)

---

### NPC:SetViewOffset · Server
`NPC:SetViewOffset(a1: Vector)`

Sets the view offset of the NPC. Player alternative of [Player:SetViewOffset](https://wiki.facepunch.com/gmod/Player:SetViewOffset).

This affects NPC's [NPC:GetShootPos](https://wiki.facepunch.com/gmod/NPC:GetShootPos).

**Arguments:**
- `a1` (Vector) — The view offset to set.

[wiki](https://wiki.facepunch.com/gmod/NPC:SetViewOffset)

---

### NPC:StartEngineTask · Server
`NPC:StartEngineTask(task: number, taskData: number)`

Forces the NPC to start an engine task, this has different results for every NPC.

**Arguments:**
- `task` (number) — The id of the task to start, see ai_task.h
- `taskData` (number) — The task data as a float, not all tasks make use of it.

[wiki](https://wiki.facepunch.com/gmod/NPC:StartEngineTask)

---

### NPC:StopMoving · Server
`NPC:StopMoving(immediate: boolean = true)`

Resets the NPC's movement animation and velocity. Does not actually stop the NPC from moving.

**Arguments:**
- `immediate` (boolean, default `true`) — Whether to stop moving even when currently active goal doesn't want us to.

[wiki](https://wiki.facepunch.com/gmod/NPC:StopMoving)

---

### NPC:TargetOrder · Server
`NPC:TargetOrder(target: Entity)`

Cancels [NPC:MoveOrder](https://wiki.facepunch.com/gmod/NPC:MoveOrder) basically.

Only works on Citizens (npc_citizen) and is a part of the Half-Life 2 squad system.

The NPC **must** be in the player's squad for this to work.

**Arguments:**
- `target` (Entity) — Must be a player, does nothing otherwise.

[wiki](https://wiki.facepunch.com/gmod/NPC:TargetOrder)

---

### NPC:TaskComplete · Server
`NPC:TaskComplete()`

Marks the current NPC task as completed.

This is meant to be used alongside [NPC:TaskFail](https://wiki.facepunch.com/gmod/NPC:TaskFail) to complete or fail custom Lua defined tasks. ([Schedule:AddTask](https://wiki.facepunch.com/gmod/Schedule:AddTask))

[wiki](https://wiki.facepunch.com/gmod/NPC:TaskComplete)

---

### NPC:TaskFail · Server
`NPC:TaskFail(failReason: string)`

Marks the current NPC task as failed.

This is meant to be used alongside [NPC:TaskComplete](https://wiki.facepunch.com/gmod/NPC:TaskComplete) to complete or fail custom Lua defined tasks. ([Schedule:AddTask](https://wiki.facepunch.com/gmod/Schedule:AddTask))

**Arguments:**
- `failReason` (string) — Fail reason to be passed onto ENTITY:OnTaskFailed.

[wiki](https://wiki.facepunch.com/gmod/NPC:TaskFail)

---

### NPC:UpdateEnemyMemory · Server
`NPC:UpdateEnemyMemory(enemy: Entity, pos: Vector)`

Force the NPC to update information on the supplied enemy, as if it had line of sight to it.

**Arguments:**
- `enemy` (Entity) — The enemy to update.
- `pos` (Vector) — The last known position of the enemy.

[wiki](https://wiki.facepunch.com/gmod/NPC:UpdateEnemyMemory)

---

### NPC:UpdateTurnActivity · Server
`NPC:UpdateTurnActivity()`

Updates the turn activity. Basically applies the turn animations depending on the current turn yaw.

[wiki](https://wiki.facepunch.com/gmod/NPC:UpdateTurnActivity)

---

### NPC:UpdateYaw · Server
`NPC:UpdateYaw(speed: number = -1)`

Forces the NPC to turn to their ideal yaw angle. See [NPC:SetIdealYaw](https://wiki.facepunch.com/gmod/NPC:SetIdealYaw) and [NPC:SetIdealYawAndUpdate](https://wiki.facepunch.com/gmod/NPC:SetIdealYawAndUpdate).

**Arguments:**
- `speed` (number, default `-1`) — The turn speed.

[wiki](https://wiki.facepunch.com/gmod/NPC:UpdateYaw)

---

### NPC:UseActBusyBehavior · Server
`NPC:UseActBusyBehavior() → boolean`

**Returns:**
- boolean — If we succeeded setting the behavior.

> **Note:** This function only works on `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/NPC:UseActBusyBehavior)

---

### NPC:UseAssaultBehavior · Server
`NPC:UseAssaultBehavior() → boolean`

Enables the AI's [Assault Behavior](https://developer.valvesoftware.com/wiki/Assault "Assault Behavior") when an `ai_goal_assault` is set for this SENT.

**Returns:**
- boolean — Whether the action succeeded.

> **Note:** This function only works on `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/NPC:UseAssaultBehavior)

---

### NPC:UseFollowBehavior · Server
`NPC:UseFollowBehavior() → boolean`

**Returns:**
- boolean — If we succeeded setting the behavior.

> **Note:** This function only works on `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/NPC:UseFollowBehavior)

---

### NPC:UseFuncTankBehavior · Server
`NPC:UseFuncTankBehavior() → boolean`

Orders the SNPC to control any nearby `func_tank`s looking for an NPC to operate itself, if available.

**Returns:**
- boolean — Whether the action succeeded.

> **Note:** This function only works on `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/NPC:UseFuncTankBehavior)

---

### NPC:UseLeadBehavior · Server
`NPC:UseLeadBehavior() → boolean`

Enables the AI's [Lead Behavior](https://developer.valvesoftware.com/wiki/ai_goal_lead "Lead Behavior") when an `ai_goal_lead` is set for this SENT.

**Returns:**
- boolean — Whether the action succeeded.

> **Note:** This function only works on `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/NPC:UseLeadBehavior)

---

### NPC:UseNoBehavior · Server
`NPC:UseNoBehavior()`

Undoes the other `Use*Behavior` functions.

> **Note:** This function only works on `ai` type [SENTs](Scripted_Entities).

[wiki](https://wiki.facepunch.com/gmod/NPC:UseNoBehavior)

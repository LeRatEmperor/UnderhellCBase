# CLuaLocomotion

**Realm:** Server  ·  **Members:** 40

This class is essentially what controls a [NextBot](https://wiki.facepunch.com/gmod/NextBot) NPC. You can access it in a [NextBot](https://wiki.facepunch.com/gmod/NextBot) NPC by using **self.loco** variable.

[wiki page](https://wiki.facepunch.com/gmod/CLuaLocomotion)

### CLuaLocomotion:Approach · Server
`CLuaLocomotion:Approach(goal: Vector, goalWeight: number)`

Moves the [NextBot](https://wiki.facepunch.com/gmod/NextBot) incrementally closer to the provided goal location.

Each time this function is called, the NextBot moves towards the goal position passed as an argument by the amount previously set by [CLuaLocomotion:SetDesiredSpeed](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetDesiredSpeed).

To achieve smooth movement, this function must be called frequently.  
This is commonly accomplished by calling it in the [ENTITY:Think](https://wiki.facepunch.com/gmod/ENTITY:Think) hook.

**Arguments:**
- `goal` (Vector) — The vector we want to get to.
- `goalWeight` (number) — How influential the movement should be, in case of this function being called multiple times in between physical movements of the entity.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:Approach)

---

### CLuaLocomotion:ClearStuck · Server
`CLuaLocomotion:ClearStuck()`

Removes the stuck status from the bot

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:ClearStuck)

---

### CLuaLocomotion:FaceTowards · Server
`CLuaLocomotion:FaceTowards(goal: Vector)`

Sets the direction we want to face

**Arguments:**
- `goal` (Vector) — The vector we want to face

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:FaceTowards)

---

### CLuaLocomotion:GetAcceleration · Server
`CLuaLocomotion:GetAcceleration() → number`

Returns the acceleration speed

**Returns:**
- number — Current acceleration speed

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetAcceleration)

---

### CLuaLocomotion:GetAvoidAllowed · Server
`CLuaLocomotion:GetAvoidAllowed() → boolean`

Returns whether the Nextbot is allowed to avoid obstacles or not.

**Returns:**
- `allowed` (boolean) — Whether this bot is allowed to try to avoid obstacles.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetAvoidAllowed)

---

### CLuaLocomotion:GetClimbAllowed · Server
`CLuaLocomotion:GetClimbAllowed() → boolean`

Returns whether the Nextbot is allowed to climb or not.

**Returns:**
- `allowed` (boolean) — Whether this bot is allowed to climb.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetClimbAllowed)

---

### CLuaLocomotion:GetCurrentAcceleration · Server
`CLuaLocomotion:GetCurrentAcceleration() → Vector`

Returns the current acceleration as a vector

**Returns:**
- Vector — Current acceleration

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetCurrentAcceleration)

---

### CLuaLocomotion:GetDeathDropHeight · Server
`CLuaLocomotion:GetDeathDropHeight() → number`

Gets the height the bot is scared to fall from

**Returns:**
- number — Current death drop height

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetDeathDropHeight)

---

### CLuaLocomotion:GetDeceleration · Server
`CLuaLocomotion:GetDeceleration() → number`

Gets the deceleration speed

**Returns:**
- number — Current deceleration speed

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetDeceleration)

---

### CLuaLocomotion:GetDesiredSpeed · Server
`CLuaLocomotion:GetDesiredSpeed() → number`

Returns the desired movement speed set by [CLuaLocomotion:SetDesiredSpeed](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetDesiredSpeed)

**Returns:**
- number — The desired movement speed.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetDesiredSpeed)

---

### CLuaLocomotion:GetGravity · Server
`CLuaLocomotion:GetGravity() → number`

Returns the locomotion's gravity.

**Returns:**
- `gravity` (number) — The gravity.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetGravity)

---

### CLuaLocomotion:GetGroundMotionVector · Server
`CLuaLocomotion:GetGroundMotionVector() → Vector`

Return unit vector in XY plane describing our direction of motion - even if we are currently not moving

**Returns:**
- Vector — A vector representing the X and Y movement

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetGroundMotionVector)

---

### CLuaLocomotion:GetGroundNormal · Server
`CLuaLocomotion:GetGroundNormal() → Vector`

Returns the current ground normal.

**Returns:**
- Vector — The current ground normal.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetGroundNormal)

---

### CLuaLocomotion:GetJumpGapsAllowed · Server
`CLuaLocomotion:GetJumpGapsAllowed() → boolean`

Returns whether the Nextbot is allowed to jump gaps or not.

**Returns:**
- `allowed` (boolean) — Whether this bot is allowed to jump gaps.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetJumpGapsAllowed)

---

### CLuaLocomotion:GetJumpHeight · Server
`CLuaLocomotion:GetJumpHeight() → number`

Gets the height of the bot's jump

**Returns:**
- number — Current jump height

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetJumpHeight)

---

### CLuaLocomotion:GetMaxJumpHeight · Server
`CLuaLocomotion:GetMaxJumpHeight() → number`

Returns maximum jump height of this [CLuaLocomotion](https://wiki.facepunch.com/gmod/CLuaLocomotion).

**Returns:**
- number — The maximum jump height.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetMaxJumpHeight)

---

### CLuaLocomotion:GetMaxYawRate · Server
`CLuaLocomotion:GetMaxYawRate() → number`

Returns the max rate at which the NextBot can visually rotate.

**Returns:**
- number — Maximum yaw rate

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetMaxYawRate)

---

### CLuaLocomotion:GetNextBot · Server
`CLuaLocomotion:GetNextBot() → NextBot`

Returns the [NextBot](https://wiki.facepunch.com/gmod/NextBot) this locomotion is associated with.

**Returns:**
- NextBot — The nextbot

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetNextBot)

---

### CLuaLocomotion:GetStepHeight · Server
`CLuaLocomotion:GetStepHeight() → number`

Gets the max height the bot can step up

**Returns:**
- number — Current step height

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetStepHeight)

---

### CLuaLocomotion:GetVelocity · Server
`CLuaLocomotion:GetVelocity() → Vector`

Returns the current movement velocity as a vector

**Returns:**
- Vector — Current velocity

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:GetVelocity)

---

### CLuaLocomotion:IsAreaTraversable · Server
`CLuaLocomotion:IsAreaTraversable(area: CNavArea) → boolean`

Returns whether this [CLuaLocomotion](https://wiki.facepunch.com/gmod/CLuaLocomotion) can reach and/or traverse/move in given [CNavArea](https://wiki.facepunch.com/gmod/CNavArea).

**Arguments:**
- `area` (CNavArea) — The area to test

**Returns:**
- boolean — Whether this CLuaLocomotion can traverse given CNavArea.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:IsAreaTraversable)

---

### CLuaLocomotion:IsAttemptingToMove · Server
`CLuaLocomotion:IsAttemptingToMove() → boolean`

Returns true if we're trying to move.

**Returns:**
- boolean — Whether we're trying to move or not.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:IsAttemptingToMove)

---

### CLuaLocomotion:IsClimbingOrJumping · Server
`CLuaLocomotion:IsClimbingOrJumping() → boolean`

Returns true of the locomotion engine is jumping or climbing

**Returns:**
- boolean — Whether we're climbing or jumping or not

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:IsClimbingOrJumping)

---

### CLuaLocomotion:IsOnGround · Server
`CLuaLocomotion:IsOnGround() → boolean`

Returns whether the nextbot this locomotion is attached to is on ground or not.

**Returns:**
- boolean — Whether the nextbot is on ground or not.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:IsOnGround)

---

### CLuaLocomotion:IsStuck · Server
`CLuaLocomotion:IsStuck() → boolean`

Returns true if we're stuck

**Returns:**
- boolean — Whether we're stuck or not

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:IsStuck)

---

### CLuaLocomotion:IsUsingLadder · Server
`CLuaLocomotion:IsUsingLadder() → boolean`

Returns whether or not the target in question is on a ladder or not.

**Returns:**
- boolean — If the target is on a ladder or not.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:IsUsingLadder)

---

### CLuaLocomotion:Jump · Server
`CLuaLocomotion:Jump(act: number = ACT_JUMP)`

Makes the bot jump. It must be on ground ([Entity:IsOnGround](https://wiki.facepunch.com/gmod/Entity:IsOnGround)) and its model must have `ACT_JUMP` activity.

**Arguments:**
- `act` (number, default `ACT_JUMP`) — The activity to use as the jumping animation.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:Jump)

---

### CLuaLocomotion:JumpAcrossGap · Server
`CLuaLocomotion:JumpAcrossGap(landingGoal: Vector, landingForward: Vector)`

Makes the bot jump across a gap. The bot must be on ground ([Entity:IsOnGround](https://wiki.facepunch.com/gmod/Entity:IsOnGround)) and its model must have `ACT_JUMP` activity.

**Arguments:**
- `landingGoal` (Vector)
- `landingForward` (Vector)

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:JumpAcrossGap)

---

### CLuaLocomotion:SetAcceleration · Server
`CLuaLocomotion:SetAcceleration(speed: number = 400)`

Sets the acceleration speed

**Arguments:**
- `speed` (number, default `400`) — Speed acceleration

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetAcceleration)

---

### CLuaLocomotion:SetAvoidAllowed · Server
`CLuaLocomotion:SetAvoidAllowed(allowed: boolean)`

Sets whether the Nextbot is allowed try to to avoid obstacles or not. This is used during path generation. Works similarly to `nb_allow_avoiding` convar. By default bots are allowed to try to avoid obstacles.

**Arguments:**
- `allowed` (boolean) — Whether this bot should be allowed to try to avoid obstacles.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetAvoidAllowed)

---

### CLuaLocomotion:SetClimbAllowed · Server
`CLuaLocomotion:SetClimbAllowed(allowed: boolean)`

Sets whether the Nextbot is allowed to climb or not. This is used during path generation. Works similarly to `nb_allow_climbing` convar. By default bots are allowed to climb.

**Arguments:**
- `allowed` (boolean) — Whether this bot should be allowed to climb.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetClimbAllowed)

---

### CLuaLocomotion:SetDeathDropHeight · Server
`CLuaLocomotion:SetDeathDropHeight(height: number = 200)`

Sets the height the bot is scared to fall from.

**Arguments:**
- `height` (number, default `200`) — Height

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetDeathDropHeight)

---

### CLuaLocomotion:SetDeceleration · Server
`CLuaLocomotion:SetDeceleration(deceleration: number = 400)`

Sets the deceleration speed.

**Arguments:**
- `deceleration` (number, default `400`) — New deceleration speed.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetDeceleration)

---

### CLuaLocomotion:SetDesiredSpeed · Server
`CLuaLocomotion:SetDesiredSpeed(speed: number = 0)`

Sets how far the NextBot will need to move each time [CLuaLocomotion:Approach](https://wiki.facepunch.com/gmod/CLuaLocomotion:Approach) is called to move at given speed.

The default amount is 0. This means the bot will not move if this value has not been set.

**Arguments:**
- `speed` (number, default `0`) — The new desired speed

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetDesiredSpeed)

---

### CLuaLocomotion:SetGravity · Server
`CLuaLocomotion:SetGravity(gravity: number = 1000)`

Sets the locomotion's gravity.

**Arguments:**
- `gravity` (number, default `1000`) — New gravity to set.

> **Note:** With values 0 or below, or even lower positive values, the nextbot will start to drift sideways, use [CLuaLocomotion:SetVelocity](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetVelocity) to counteract this.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetGravity)

---

### CLuaLocomotion:SetJumpGapsAllowed · Server
`CLuaLocomotion:SetJumpGapsAllowed(allowed: boolean)`

Sets whether the Nextbot is allowed to jump gaps or not. This is used during path generation. Works similarly to `nb_allow_gap_jumping` convar. By default bots are allowed to jump gaps.

**Arguments:**
- `allowed` (boolean) — Whether this bot should be allowed to jump gaps.

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetJumpGapsAllowed)

---

### CLuaLocomotion:SetJumpHeight · Server
`CLuaLocomotion:SetJumpHeight(height: number = 58)`

Sets the height of the bot's jump

**Arguments:**
- `height` (number, default `58`) — Height

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetJumpHeight)

---

### CLuaLocomotion:SetMaxYawRate · Server
`CLuaLocomotion:SetMaxYawRate(yawRate: number = 250)`

Sets the max rate at which the NextBot can visually rotate. This will not affect moving or pathing.

**Arguments:**
- `yawRate` (number, default `250`) — Desired new maximum yaw rate

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetMaxYawRate)

---

### CLuaLocomotion:SetStepHeight · Server
`CLuaLocomotion:SetStepHeight(height: number = 18)`

Sets the max height the bot can step up

**Arguments:**
- `height` (number, default `18`) — Height

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetStepHeight)

---

### CLuaLocomotion:SetVelocity · Server
`CLuaLocomotion:SetVelocity(velocity: Vector)`

Sets the current movement velocity

**Arguments:**
- `velocity` (Vector)

[wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion:SetVelocity)

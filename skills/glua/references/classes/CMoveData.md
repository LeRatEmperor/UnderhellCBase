# CMoveData

**Realm:** Shared  ·  **Members:** 47

A class used to store the inputs from [CUserCmd](https://wiki.facepunch.com/gmod/CUserCmd) and other information related to the current movement simulation, such as velocity, position and so on.

This can only be accessed during [GM:SetupMove](https://wiki.facepunch.com/gmod/GM:SetupMove) , [GM:Move](https://wiki.facepunch.com/gmod/GM:Move) , [GM:PlayerTick](https://wiki.facepunch.com/gmod/GM:PlayerTick) and [GM:FinishMove](https://wiki.facepunch.com/gmod/GM:FinishMove).

[wiki page](https://wiki.facepunch.com/gmod/CMoveData)

### CMoveData:AddKey · Shared
`CMoveData:AddKey(keys: number)`

Adds keys to the move data, as if player pressed them.

**Arguments:**
- `keys` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — Keys to add, see IN

[wiki](https://wiki.facepunch.com/gmod/CMoveData:AddKey)

---

### CMoveData:GetAbsMoveAngles · Shared
`CMoveData:GetAbsMoveAngles() → Angle`

Gets the aim angle. Seems to be same as [CMoveData:GetAngles](https://wiki.facepunch.com/gmod/CMoveData:GetAngles).

**Returns:**
- Angle — Aiming angle

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetAbsMoveAngles)

---

### CMoveData:GetAngles · Shared
`CMoveData:GetAngles() → Angle`

Gets the aim angle. On client is the same as [Entity:GetAngles](https://wiki.facepunch.com/gmod/Entity:GetAngles).

**Returns:**
- Angle — Aiming angle

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetAngles)

---

### CMoveData:GetButtons · Shared
`CMoveData:GetButtons() → number`

Gets which buttons are down

**Returns:**
- number — An integer representing which buttons are down, see IN

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetButtons)

---

### CMoveData:GetConstraintCenter · Shared
`CMoveData:GetConstraintCenter() → Vector`

Returns the center of the player movement constraint. See [CMoveData:SetConstraintCenter](https://wiki.facepunch.com/gmod/CMoveData:SetConstraintCenter).

**Returns:**
- `pos` (Vector) — The constraint origin.

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetConstraintCenter)

---

### CMoveData:GetConstraintRadius · Shared
`CMoveData:GetConstraintRadius() → number`

Returns the radius that constrains the players movement. See [CMoveData:SetConstraintRadius](https://wiki.facepunch.com/gmod/CMoveData:SetConstraintRadius).

**Returns:**
- number — The constraint radius

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetConstraintRadius)

---

### CMoveData:GetConstraintSpeedScale · Shared
`CMoveData:GetConstraintSpeedScale() → number`

Returns the player movement constraint speed scale. See [CMoveData:SetConstraintSpeedScale](https://wiki.facepunch.com/gmod/CMoveData:SetConstraintSpeedScale).

**Returns:**
- number — The constraint speed scale

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetConstraintSpeedScale)

---

### CMoveData:GetConstraintWidth · Shared
`CMoveData:GetConstraintWidth() → number`

Returns the width (distance from the edge of the radius, inward) where the actual movement constraint functions.

**Returns:**
- number — The constraint width

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetConstraintWidth)

---

### CMoveData:GetFinalIdealVelocity · Shared
`CMoveData:GetFinalIdealVelocity() → Vector`

Returns an internal player movement variable `m_outWishVel`.

**Returns:**
- `idealVel` (Vector)

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetFinalIdealVelocity)

---

### CMoveData:GetFinalJumpVelocity · Shared
`CMoveData:GetFinalJumpVelocity() → Vector`

Returns an internal player movement variable `m_outJumpVel`.

**Returns:**
- `jumpVel` (Vector)

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetFinalJumpVelocity)

---

### CMoveData:GetFinalStepHeight · Shared
`CMoveData:GetFinalStepHeight() → number`

Returns an internal player movement variable `m_outStepHeight`.

**Returns:**
- `stepHeight` (number)

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetFinalStepHeight)

---

### CMoveData:GetForwardSpeed · Shared
`CMoveData:GetForwardSpeed() → number`

Returns the players forward speed.

**Returns:**
- number — speed

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetForwardSpeed)

---

### CMoveData:GetImpulseCommand · Shared
`CMoveData:GetImpulseCommand() → number`

Gets the number passed to "impulse" console command

**Returns:**
- number — The impulse

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetImpulseCommand)

---

### CMoveData:GetMaxClientSpeed · Shared
`CMoveData:GetMaxClientSpeed() → number`

Returns the maximum client speed of the player

**Returns:**
- number — The maximum client speed

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetMaxClientSpeed)

---

### CMoveData:GetMaxSpeed · Shared
`CMoveData:GetMaxSpeed() → number`

Returns the maximum speed of the player.

**Returns:**
- number — The maximum speed

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetMaxSpeed)

---

### CMoveData:GetMoveAngles · Shared
`CMoveData:GetMoveAngles() → Angle`

Returns the angle the player is moving at. For more info, see [CMoveData:SetMoveAngles](https://wiki.facepunch.com/gmod/CMoveData:SetMoveAngles).

**Returns:**
- Angle — The move direction

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetMoveAngles)

---

### CMoveData:GetOldAngles · Shared
`CMoveData:GetOldAngles() → Angle`

Gets the aim angle. Only works clientside, server returns same as [CMoveData:GetAngles](https://wiki.facepunch.com/gmod/CMoveData:GetAngles).

**Returns:**
- Angle — The aim angle

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetOldAngles)

---

### CMoveData:GetOldButtons · Shared
`CMoveData:GetOldButtons() → number`

Get which buttons were down last frame

**Returns:**
- number — An integer representing which buttons were down, see IN

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetOldButtons)

---

### CMoveData:GetOrigin · Shared
`CMoveData:GetOrigin() → Vector`

Gets the player's position.

**Returns:**
- Vector — The player's position.

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetOrigin)

---

### CMoveData:GetSideSpeed · Shared
`CMoveData:GetSideSpeed() → number`

Returns the strafe speed of the player.

**Returns:**
- number — speed

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetSideSpeed)

---

### CMoveData:GetUpSpeed · Shared
`CMoveData:GetUpSpeed() → number`

Returns the vertical speed of the player. ( Z axis of [CMoveData:GetVelocity](https://wiki.facepunch.com/gmod/CMoveData:GetVelocity) )

**Returns:**
- number — Vertical speed

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetUpSpeed)

---

### CMoveData:GetVelocity · Shared
`CMoveData:GetVelocity() → Vector`

Gets the players velocity.

**Returns:**
- Vector — The players velocity

> **Bug** ([#3413](https://github.com/Facepunch/garrysmod/issues/3413)): This will return Vector(0,0,0) sometimes when walking on props.

[wiki](https://wiki.facepunch.com/gmod/CMoveData:GetVelocity)

---

### CMoveData:KeyDown · Shared
`CMoveData:KeyDown(key: number) → boolean`

Returns whether the key is down or not

**Arguments:**
- `key` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — The key to test, see IN

**Returns:**
- boolean — Is the key down or not

[wiki](https://wiki.facepunch.com/gmod/CMoveData:KeyDown)

---

### CMoveData:KeyPressed · Shared
`CMoveData:KeyPressed(key: number) → boolean`

Returns whether the key was pressed. If you want to check if the key is held down, try [CMoveData:KeyDown](https://wiki.facepunch.com/gmod/CMoveData:KeyDown)

**Arguments:**
- `key` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — The key to test, see IN

**Returns:**
- boolean — Was the key pressed or not.

[wiki](https://wiki.facepunch.com/gmod/CMoveData:KeyPressed)

---

### CMoveData:KeyReleased · Shared
`CMoveData:KeyReleased(key: number) → boolean`

Returns whether the key was released

**Arguments:**
- `key` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — A key to test, see IN

**Returns:**
- boolean — Was the key released or not.

[wiki](https://wiki.facepunch.com/gmod/CMoveData:KeyReleased)

---

### CMoveData:KeyWasDown · Shared
`CMoveData:KeyWasDown(key: number) → boolean`

Returns whether the key was down or not.




Unlike [CMoveData:KeyDown](https://wiki.facepunch.com/gmod/CMoveData:KeyDown), it will return false if [CMoveData:KeyPressed](https://wiki.facepunch.com/gmod/CMoveData:KeyPressed) is true and it will return true if [CMoveData:KeyReleased](https://wiki.facepunch.com/gmod/CMoveData:KeyReleased) is true.

**Arguments:**
- `key` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — The key to test, see IN

**Returns:**
- boolean — Was the key down or not

[wiki](https://wiki.facepunch.com/gmod/CMoveData:KeyWasDown)

---

### CMoveData:SetAbsMoveAngles · Shared
`CMoveData:SetAbsMoveAngles(ang: Angle)`

Sets absolute move angles.( ? ) Doesn't seem to do anything.

**Arguments:**
- `ang` (Angle) — New absolute move angles

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetAbsMoveAngles)

---

### CMoveData:SetAngles · Shared
`CMoveData:SetAngles(ang: Angle)`

Sets angles.

**Arguments:**
- `ang` (Angle) — The angles.

> **Bug** ([#2382](https://github.com/Facepunch/garrysmod/issues/2382)): This function does nothing.

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetAngles)

---

### CMoveData:SetButtons · Shared
`CMoveData:SetButtons(buttons: number)`

Sets the pressed buttons on the move data

**Arguments:**
- `buttons` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — A number representing which buttons are down, see IN

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetButtons)

---

### CMoveData:SetConstraintCenter · Shared
`CMoveData:SetConstraintCenter(pos: Vector)`

Sets the center of the player movement constraint. See [CMoveData:SetConstraintRadius](https://wiki.facepunch.com/gmod/CMoveData:SetConstraintRadius).

**Arguments:**
- `pos` (Vector) — The constraint origin.

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetConstraintCenter)

---

### CMoveData:SetConstraintRadius · Shared
`CMoveData:SetConstraintRadius(radius: number)`

Sets the radius that constrains the players movement.

Works with conjunction of:
* [CMoveData:SetConstraintWidth](https://wiki.facepunch.com/gmod/CMoveData:SetConstraintWidth)
* [CMoveData:SetConstraintSpeedScale](https://wiki.facepunch.com/gmod/CMoveData:SetConstraintSpeedScale)
* [CMoveData:SetConstraintCenter](https://wiki.facepunch.com/gmod/CMoveData:SetConstraintCenter)

**Arguments:**
- `radius` (number) — The new constraint radius

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetConstraintRadius)

---

### CMoveData:SetConstraintSpeedScale · Shared
`CMoveData:SetConstraintSpeedScale(a1: number)`

Sets the player movement constraint speed scale. This will be applied to the player within the [constraint radius](https://wiki.facepunch.com/gmod/CMoveData:SetConstraintRadius) when approaching its edge.

**Arguments:**
- `a1` (number) — The constraint speed scale

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetConstraintSpeedScale)

---

### CMoveData:SetConstraintWidth · Shared
`CMoveData:SetConstraintWidth(a1: number)`

Sets  the width (distance from the edge of the [radius](https://wiki.facepunch.com/gmod/CMoveData:SetConstraintRadius), inward) where the actual movement constraint functions.

**Arguments:**
- `a1` (number) — The constraint width

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetConstraintWidth)

---

### CMoveData:SetFinalIdealVelocity · Shared
`CMoveData:SetFinalIdealVelocity(idealVel: Vector)`

Sets an internal player movement variable `m_outWishVel`.

**Arguments:**
- `idealVel` (Vector)

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetFinalIdealVelocity)

---

### CMoveData:SetFinalJumpVelocity · Shared
`CMoveData:SetFinalJumpVelocity(jumpVel: Vector)`

Sets an internal player movement variable `m_outJumpVel`.

**Arguments:**
- `jumpVel` (Vector)

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetFinalJumpVelocity)

---

### CMoveData:SetFinalStepHeight · Shared
`CMoveData:SetFinalStepHeight(stepHeight: number)`

Sets an internal player movement variable `m_outStepHeight`.

**Arguments:**
- `stepHeight` (number)

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetFinalStepHeight)

---

### CMoveData:SetForwardSpeed · Shared
`CMoveData:SetForwardSpeed(speed: number)`

Sets players forward speed.

**Arguments:**
- `speed` (number) — New forward speed

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetForwardSpeed)

---

### CMoveData:SetImpulseCommand · Shared
`CMoveData:SetImpulseCommand(impulse: number)`

Sets the impulse command. This isn't actually utilised in the engine anywhere.

**Arguments:**
- `impulse` (number) — The impulse to set

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetImpulseCommand)

---

### CMoveData:SetMaxClientSpeed · Shared
`CMoveData:SetMaxClientSpeed(maxSpeed: number)`

Sets the maximum player speed. Player won't be able to run or sprint faster then this value.


This also automatically sets [CMoveData:SetMaxSpeed](https://wiki.facepunch.com/gmod/CMoveData:SetMaxSpeed) when used in the [GM:SetupMove](https://wiki.facepunch.com/gmod/GM:SetupMove) hook. You must set it manually in the [GM:Move](https://wiki.facepunch.com/gmod/GM:Move) hook.


This must be called on both client and server to avoid prediction errors.


This will **not** reduce speed in air.

**Arguments:**
- `maxSpeed` (number) — The new maximum speed

> **Note:** Setting this to 0 will not make the player stationary. It won't do anything.

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetMaxClientSpeed)

---

### CMoveData:SetMaxSpeed · Shared
`CMoveData:SetMaxSpeed(maxSpeed: number)`

Sets the maximum speed of the player. This must match with [CMoveData:SetMaxClientSpeed](https://wiki.facepunch.com/gmod/CMoveData:SetMaxClientSpeed) both, on server and client.


Doesn't seem to be doing anything on it's own, use [CMoveData:SetMaxClientSpeed](https://wiki.facepunch.com/gmod/CMoveData:SetMaxClientSpeed) instead.

**Arguments:**
- `maxSpeed` (number) — The new maximum speed

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetMaxSpeed)

---

### CMoveData:SetMoveAngles · Shared
`CMoveData:SetMoveAngles(dir: Angle)`

Sets the serverside move angles, making the movement keys act as if player was facing that direction.

This function is predicted, and should be called shared with matching data on client and server.

**Arguments:**
- `dir` (Angle) — The aim direction.

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetMoveAngles)

---

### CMoveData:SetOldAngles · Shared
`CMoveData:SetOldAngles(aimAng: Angle)`

Sets old aim angles. ( ? ) Doesn't seem to be doing anything.

**Arguments:**
- `aimAng` (Angle) — The old angles

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetOldAngles)

---

### CMoveData:SetOldButtons · Shared
`CMoveData:SetOldButtons(buttons: number)`

Sets the 'old' pressed buttons on the move data. These buttons are used to work out which buttons have been released, which have just been pressed and which are being held down.

**Arguments:**
- `buttons` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — A number representing which buttons were down, see IN

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetOldButtons)

---

### CMoveData:SetOrigin · Shared
`CMoveData:SetOrigin(pos: Vector)`

Sets the players position.

**Arguments:**
- `pos` (Vector) — The position

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetOrigin)

---

### CMoveData:SetSideSpeed · Shared
`CMoveData:SetSideSpeed(speed: number)`

Sets players strafe speed.

**Arguments:**
- `speed` (number) — Strafe speed

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetSideSpeed)

---

### CMoveData:SetUpSpeed · Shared
`CMoveData:SetUpSpeed(speed: number)`

Sets vertical speed of the player. ( Z axis of [CMoveData:SetVelocity](https://wiki.facepunch.com/gmod/CMoveData:SetVelocity) )

**Arguments:**
- `speed` (number) — Vertical speed to set

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetUpSpeed)

---

### CMoveData:SetVelocity · Shared
`CMoveData:SetVelocity(velocity: Vector)`

Sets the player's velocity

**Arguments:**
- `velocity` (Vector) — The velocity to set

[wiki](https://wiki.facepunch.com/gmod/CMoveData:SetVelocity)

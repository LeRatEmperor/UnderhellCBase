# CUserCmd

**Realm:** Shared  ·  **Members:** 27

A class used to store the player inputs, such as mouse movement, view angles, [IN](https://wiki.facepunch.com/gmod/Enums/IN) buttons pressed and analog movement, the data from this class is then transfered to a [CMoveData](https://wiki.facepunch.com/gmod/CMoveData) during actual movement simulation.

Can be modified during [GM:CreateMove](https://wiki.facepunch.com/gmod/GM:CreateMove), [GM:StartCommand](https://wiki.facepunch.com/gmod/GM:StartCommand) and used in read only with [GM:SetupMove](https://wiki.facepunch.com/gmod/GM:SetupMove) and [Player:GetCurrentCommand](https://wiki.facepunch.com/gmod/Player:GetCurrentCommand).

[wiki page](https://wiki.facepunch.com/gmod/CUserCmd)

### CUserCmd:AddKey · Shared
`CUserCmd:AddKey(key: number)`

Adds a single key to the active buttons bitflag. See also [CUserCmd:SetButtons](https://wiki.facepunch.com/gmod/CUserCmd:SetButtons).

**Arguments:**
- `key` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — Key to add, see IN.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:AddKey)

---

### CUserCmd:ClearButtons · Shared
`CUserCmd:ClearButtons()`

Removes all keys from the command.

> **Note:** If you are looking to affect player movement, you may need to use [CUserCmd:ClearMovement](https://wiki.facepunch.com/gmod/CUserCmd:ClearMovement) instead of clearing the buttons.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:ClearButtons)

---

### CUserCmd:ClearMovement · Shared
`CUserCmd:ClearMovement()`

Clears the movement from the command.

See also [CUserCmd:SetForwardMove](https://wiki.facepunch.com/gmod/CUserCmd:SetForwardMove), [CUserCmd:SetSideMove](https://wiki.facepunch.com/gmod/CUserCmd:SetSideMove) and  [CUserCmd:SetUpMove](https://wiki.facepunch.com/gmod/CUserCmd:SetUpMove).

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:ClearMovement)

---

### CUserCmd:CommandNumber · Shared
`CUserCmd:CommandNumber() → number`

Returns an increasing number representing the index of the user cmd.

**Returns:**
- number — The command number

> **Warning:** The value returned is occasionally 0 inside [GM:CreateMove](https://wiki.facepunch.com/gmod/GM:CreateMove) and [GM:StartCommand](https://wiki.facepunch.com/gmod/GM:StartCommand). It is advised to check for a non-zero value if you wish to get the correct number.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:CommandNumber)

---

### CUserCmd:GetButtons · Shared
`CUserCmd:GetButtons() → number`

Returns a bitflag indicating which buttons are pressed.

**Returns:**
- number — Pressed buttons, see IN

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:GetButtons)

---

### CUserCmd:GetForwardMove · Shared
`CUserCmd:GetForwardMove() → number`

The speed the client wishes to move forward with, negative if the clients wants to move backwards.

**Returns:**
- number — The desired speed

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:GetForwardMove)

---

### CUserCmd:GetImpulse · Shared
`CUserCmd:GetImpulse() → number`

Gets the current impulse from the client, usually 0. [See impulses list](https://developer.valvesoftware.com/wiki/Impulse) and some [GMod specific impulses](https://wiki.facepunch.com/gmod/CUserCmd:SetImpulse).

**Returns:**
- number — The impulse

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:GetImpulse)

---

### CUserCmd:GetMouseWheel · Shared
`CUserCmd:GetMouseWheel() → number`

Returns the scroll delta as whole number.

**Returns:**
- number — Scroll delta

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:GetMouseWheel)

---

### CUserCmd:GetMouseX · Shared
`CUserCmd:GetMouseX() → number`

Returns the delta of the angular horizontal mouse movement of the player.

**Returns:**
- number — xDelta

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:GetMouseX)

---

### CUserCmd:GetMouseY · Shared
`CUserCmd:GetMouseY() → number`

Returns the delta of the angular vertical mouse movement of the player.

**Returns:**
- number — yDelta

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:GetMouseY)

---

### CUserCmd:GetSideMove · Shared
`CUserCmd:GetSideMove() → number`

The speed the client wishes to move sideways with, positive if it wants to move right, negative if it wants to move left.

**Returns:**
- number — requestSpeed

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:GetSideMove)

---

### CUserCmd:GetUpMove · Shared
`CUserCmd:GetUpMove() → number`

The speed the client wishes to move up with, negative if the clients wants to move down.

**Returns:**
- number — requestSpeed

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:GetUpMove)

---

### CUserCmd:GetViewAngles · Shared
`CUserCmd:GetViewAngles() → Angle`

Gets the direction the player is looking in.

**Returns:**
- Angle — The direction the player is looking in.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:GetViewAngles)

---

### CUserCmd:IsForced · Shared
`CUserCmd:IsForced() → boolean`

When players are not sending usercommands to the server (often due to lag), their last usercommand will be executed multiple times as a backup. This function returns true if that is happening.

This will never return true clientside.

**Returns:**
- boolean — isForced

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:IsForced)

---

### CUserCmd:KeyDown · Shared
`CUserCmd:KeyDown(key: number) → boolean`

Returns true if the specified button(s) is pressed.

**Arguments:**
- `key` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — Bitflag representing which button to check, see IN.

**Returns:**
- boolean — Is key down or not

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:KeyDown)

---

### CUserCmd:RemoveKey · Shared
`CUserCmd:RemoveKey(button: number)`

Removes a key bit from the current key bitflag.

For movement you will want to use [CUserCmd:SetForwardMove](https://wiki.facepunch.com/gmod/CUserCmd:SetForwardMove), [CUserCmd:SetUpMove](https://wiki.facepunch.com/gmod/CUserCmd:SetUpMove) and [CUserCmd:SetSideMove](https://wiki.facepunch.com/gmod/CUserCmd:SetSideMove).

**Arguments:**
- `button` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — Bitflag to be removed from the key bitflag, see IN.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:RemoveKey)

---

### CUserCmd:SelectWeapon · Shared
`CUserCmd:SelectWeapon(weapon: Weapon)`

Forces the associated player to select a weapon. This is used internally in the default HL2 weapon selection HUD.

This may not work immediately if the current command is in prediction. Use [input.SelectWeapon](https://wiki.facepunch.com/gmod/input.SelectWeapon) to switch the weapon from the client when the next available command can do so.

**Arguments:**
- `weapon` (Weapon) — The weapon entity to select.

> **Note:** This is the ideal function to use to create a custom weapon selection HUD, as it allows prediction to run properly for [WEAPON:Deploy](https://wiki.facepunch.com/gmod/WEAPON:Deploy) and [GM:PlayerSwitchWeapon](https://wiki.facepunch.com/gmod/GM:PlayerSwitchWeapon)

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:SelectWeapon)

---

### CUserCmd:SetButtons · Shared
`CUserCmd:SetButtons(buttons: number)`

Sets the buttons as a bitflag. See also [CUserCmd:GetButtons](https://wiki.facepunch.com/gmod/CUserCmd:GetButtons).

**Arguments:**
- `buttons` (number, enum [IN](https://wiki.facepunch.com/gmod/Enums/IN)) — Bitflag representing which buttons are "down", see IN.

> **Note:** If you are looking to affect player movement, you may need to use [CUserCmd:SetForwardMove](https://wiki.facepunch.com/gmod/CUserCmd:SetForwardMove) instead of setting the keys.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:SetButtons)

---

### CUserCmd:SetForwardMove · Shared
`CUserCmd:SetForwardMove(speed: number)`

Sets speed the client wishes to move forward with, negative if the clients wants to move backwards.

See also [CUserCmd:ClearMovement](https://wiki.facepunch.com/gmod/CUserCmd:ClearMovement), [CUserCmd:SetSideMove](https://wiki.facepunch.com/gmod/CUserCmd:SetSideMove) and [CUserCmd:SetUpMove](https://wiki.facepunch.com/gmod/CUserCmd:SetUpMove).

**Arguments:**
- `speed` (number) — The new speed to request.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:SetForwardMove)

---

### CUserCmd:SetImpulse · Shared
`CUserCmd:SetImpulse(impulse: number)`

Sets the impulse command to be sent to the server.

Here are a few examples of impulse numbers:
- `100` toggles their flashlight
- `101` gives the player all Half-Life 2 weapons with `sv_cheats` set to `1`
- `200` toggles holstering / restoring the current weapon  
  When holstered, the `EF_NODRAW` flag is set on the active weapon.
- `154` toggles noclip

[See full list](https://developer.valvesoftware.com/wiki/Impulse)

**Arguments:**
- `impulse` (number) — The impulse to send.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:SetImpulse)

---

### CUserCmd:SetMouseWheel · Shared
`CUserCmd:SetMouseWheel(speed: number)`

Sets the scroll delta.

**Arguments:**
- `speed` (number) — The scroll delta.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:SetMouseWheel)

---

### CUserCmd:SetMouseX · Shared
`CUserCmd:SetMouseX(speed: number)`

Sets the delta of the angular horizontal mouse movement of the player.

See also [CUserCmd:SetMouseY](https://wiki.facepunch.com/gmod/CUserCmd:SetMouseY).

**Arguments:**
- `speed` (number) — Angular horizontal move delta.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:SetMouseX)

---

### CUserCmd:SetMouseY · Shared
`CUserCmd:SetMouseY(speed: number)`

Sets the delta of the angular vertical mouse movement of the player.

See also [CUserCmd:SetMouseX](https://wiki.facepunch.com/gmod/CUserCmd:SetMouseX).

**Arguments:**
- `speed` (number) — Angular vertical move delta.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:SetMouseY)

---

### CUserCmd:SetSideMove · Shared
`CUserCmd:SetSideMove(speed: number)`

Sets speed the client wishes to move sidewards with, positive to move right, negative to move left.

See also [CUserCmd:SetForwardMove](https://wiki.facepunch.com/gmod/CUserCmd:SetForwardMove) and  [CUserCmd:SetUpMove](https://wiki.facepunch.com/gmod/CUserCmd:SetUpMove).

**Arguments:**
- `speed` (number) — The new speed to request.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:SetSideMove)

---

### CUserCmd:SetUpMove · Shared
`CUserCmd:SetUpMove(speed: number)`

Sets speed the client wishes to move upwards with, negative to move down.

See also [CUserCmd:SetSideMove](https://wiki.facepunch.com/gmod/CUserCmd:SetSideMove) and  [CUserCmd:SetForwardMove](https://wiki.facepunch.com/gmod/CUserCmd:SetForwardMove).

**Arguments:**
- `speed` (number) — The new speed to request.

> **Note:** This function does **not** move the client up/down ladders. To force ladder movement, consider [CUserCMD:SetButtons](https://wiki.facepunch.com/gmod/CUserCMD:SetButtons) and use IN_FORWARD from [IN](https://wiki.facepunch.com/gmod/Enums/IN).

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:SetUpMove)

---

### CUserCmd:SetViewAngles · Shared
`CUserCmd:SetViewAngles(viewAngle: Angle)`

Sets the direction the client wants to move in.

**Arguments:**
- `viewAngle` (Angle) — New view angles.

> **Note:** For human players, the pitch (vertical) angle should be clamped to +/- 89° to prevent the player's view from glitching.
> **Note:** For fake clients (those created with [player.CreateNextBot](https://wiki.facepunch.com/gmod/player.CreateNextBot)), this functionally dictates the 'move angles' of the bot. This typically functions separately from the colloquial view angles. This can be utilized by [CUserCmd:SetForwardMove](https://wiki.facepunch.com/gmod/CUserCmd:SetForwardMove) and its related functions.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:SetViewAngles)

---

### CUserCmd:TickCount · Shared
`CUserCmd:TickCount() → number`

Returns tick count since joining the server.

**Returns:**
- number — The amount of ticks passed since joining the server.

> **Note:** This will always return 0 for bots.
> **Note:** Returns 0 clientside during prediction calls. If you are trying to use CUserCmd:Set*() on the client in a movement or command hook, keep doing so till TickCount returns a non-zero number to maintain prediction.

[wiki](https://wiki.facepunch.com/gmod/CUserCmd:TickCount)

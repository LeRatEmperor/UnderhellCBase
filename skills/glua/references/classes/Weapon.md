# Weapon

**Realm:** Shared  ·  **Members:** 35

This is a list of all methods only available for weapons. It is also possible to call [Entity](https://wiki.facepunch.com/gmod/Entity) functions on weapons.

> **Note:** A list of available methods has been expanded in your navigation bar.

[wiki page](https://wiki.facepunch.com/gmod/Weapon)

### Weapon:AllowsAutoSwitchFrom · Shared
`Weapon:AllowsAutoSwitchFrom() → boolean`

Returns whether the weapon allows to being switched from when a better ( [Weapon:GetWeight](https://wiki.facepunch.com/gmod/Weapon:GetWeight) ) weapon is being picked up.

**Returns:**
- boolean — Whether the weapon allows to being switched from.

[wiki](https://wiki.facepunch.com/gmod/Weapon:AllowsAutoSwitchFrom)

---

### Weapon:AllowsAutoSwitchTo · Shared
`Weapon:AllowsAutoSwitchTo() → boolean`

Returns whether the weapon allows to being switched to when a better ([Weapon:GetWeight](https://wiki.facepunch.com/gmod/Weapon:GetWeight)) weapon is being picked up.

**Returns:**
- boolean — Whether the weapon allows to being switched to.

[wiki](https://wiki.facepunch.com/gmod/Weapon:AllowsAutoSwitchTo)

---

### Weapon:CallOnClient · Shared
`Weapon:CallOnClient(functionName: string, data: string)`

Calls a SWEP function on client. Does nothing on client.

**Arguments:**
- `functionName` (string) — Name of function to call.
- `data` (string) — Custom data to be passed to the target SWEP function as the first argument.

> **Warning:** This uses the [usermessage](https://wiki.facepunch.com/gmod/usermessage) internally, because of that, the combined length of the arguments of this function may not exceed 254 bytes/characters or the function will cease to function!

[wiki](https://wiki.facepunch.com/gmod/Weapon:CallOnClient)

---

### Weapon:Clip1 · Shared
`Weapon:Clip1() → number`

Returns how much primary ammo is in the magazine.

**Returns:**
- number — The amount of primary ammo in the magazine.

> **Note:** This is not shared between clients and will instead return the maximum primary clip size.

[wiki](https://wiki.facepunch.com/gmod/Weapon:Clip1)

---

### Weapon:Clip2 · Shared
`Weapon:Clip2() → number`

Returns how much secondary ammo is in the magazine.

**Returns:**
- number — The amount of secondary ammo in the magazine.

> **Note:** This is not shared between clients and will instead return the maximum secondary clip size.

[wiki](https://wiki.facepunch.com/gmod/Weapon:Clip2)

---

### Weapon:DefaultReload · Shared
`Weapon:DefaultReload(act: number) → boolean`

Forces the weapon to reload while playing given animation.

**Arguments:**
- `act` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — Sequence to use as reload animation.

**Returns:**
- boolean — Did reloading actually take place

> **Note:** This will stop the [Weapon:Think](https://wiki.facepunch.com/gmod/Weapon:Think) function from getting called while the weapon is reloading!

[wiki](https://wiki.facepunch.com/gmod/Weapon:DefaultReload)

---

### Weapon:GetActivity · Shared
`Weapon:GetActivity() → number`

Returns the sequence enumeration number that the weapon is playing.

**Returns:**
- number — Current activity, see ACT.

> **Bug** ([#2543](https://github.com/Facepunch/garrysmod/issues/2543)): This can return inconsistent results between the server and client.

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetActivity)

---

### Weapon:GetDeploySpeed · Shared
`Weapon:GetDeploySpeed() → number`

Returns the weapon deploy speed, as set by [Weapon:SetDeploySpeed](https://wiki.facepunch.com/gmod/Weapon:SetDeploySpeed). If not previously set, the value will be polled from the `sv_defaultdeployspeed` [ConVar](https://wiki.facepunch.com/gmod/ConVar).

**Returns:**
- `speed` (number) — The value to set deploy speed to.

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetDeploySpeed)

---

### Weapon:GetHoldType · Shared
`Weapon:GetHoldType() → string`

Returns the hold type of the weapon.

**Returns:**
- string — The hold type of the weapon.

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetHoldType)

---

### Weapon:GetMaxClip1 · Shared
`Weapon:GetMaxClip1() → number`

Returns maximum primary clip size

**Returns:**
- number — Maximum primary clip size

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetMaxClip1)

---

### Weapon:GetMaxClip2 · Shared
`Weapon:GetMaxClip2() → number`

Returns maximum secondary clip size

**Returns:**
- number — Maximum secondary clip size

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetMaxClip2)

---

### Weapon:GetNextPrimaryFire · Shared
`Weapon:GetNextPrimaryFire() → number`

Gets the next time the weapon can primary fire. ( Can call [WEAPON:PrimaryAttack](https://wiki.facepunch.com/gmod/WEAPON:PrimaryAttack) )

**Returns:**
- number — The time, relative to CurTime

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetNextPrimaryFire)

---

### Weapon:GetNextSecondaryFire · Shared
`Weapon:GetNextSecondaryFire() → number`

Gets the next time the weapon can secondary fire. ( Can call [WEAPON:SecondaryAttack](https://wiki.facepunch.com/gmod/WEAPON:SecondaryAttack) )

**Returns:**
- number — The time, relative to CurTime

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetNextSecondaryFire)

---

### Weapon:GetPrimaryAmmoType · Shared
`Weapon:GetPrimaryAmmoType() → number`

Gets the primary ammo type of the given weapon.

**Returns:**
- number — The ammo type ID, or -1 if not found.

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetPrimaryAmmoType)

---

### Weapon:GetPrintName · Shared
`Weapon:GetPrintName() → string`

Returns the non-internal name of the weapon, that should be for displaying.

**Returns:**
- string — The "nice" name of the weapon.

> **Note:** If SWEP.PrintName is not set in the Weapon or the Weapon Base then "<MISSING SWEP PRINT NAME>" will be returned.
> **Note:** If that returns an untranslated message (#HL2_XX), use [language.GetPhrase](https://wiki.facepunch.com/gmod/language.GetPhrase) to see the "nice" name.

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetPrintName)

---

### Weapon:GetSecondaryAmmoType · Shared
`Weapon:GetSecondaryAmmoType() → number`

Gets the ammo type of the given weapons secondary fire.

**Returns:**
- number — The secondary ammo type ID, or -1 if not found.

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetSecondaryAmmoType)

---

### Weapon:GetSlot · Shared
`Weapon:GetSlot() → number`

Returns the slot of the weapon.

**Returns:**
- number — The slot of the weapon.

> **Note:** The slot numbers start from 0.

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetSlot)

---

### Weapon:GetSlotPos · Shared
`Weapon:GetSlotPos() → number`

Returns slot position of the weapon

**Returns:**
- number — The slot position of the weapon

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetSlotPos)

---

### Weapon:GetWeaponViewModel · Shared
`Weapon:GetWeaponViewModel() → string`

Returns the view model of the weapon.

**Returns:**
- string — The view model of the weapon.

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetWeaponViewModel)

---

### Weapon:GetWeaponWorldModel · Shared
`Weapon:GetWeaponWorldModel() → string`

Returns the world model of the weapon.

**Returns:**
- string — The world model of the weapon.

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetWeaponWorldModel)

---

### Weapon:GetWeight · Shared
`Weapon:GetWeight() → number`

Returns the "weight" of the weapon, which is used when deciding which [Weapon](https://wiki.facepunch.com/gmod/Weapon) is better by the engine.

**Returns:**
- number — The weapon "weight".

[wiki](https://wiki.facepunch.com/gmod/Weapon:GetWeight)

---

### Weapon:HasAmmo · Shared
`Weapon:HasAmmo() → boolean`

Returns whether the weapon has ammo left or not. It will return false when there's no ammo left in the magazine **and** when there's no reserve ammo left.

**Returns:**
- boolean — Whether the weapon has ammo or not.

> **Note:** This will return true for weapons like crowbar, gravity gun, etc.

[wiki](https://wiki.facepunch.com/gmod/Weapon:HasAmmo)

---

### Weapon:IsCarriedByLocalPlayer · Client
`Weapon:IsCarriedByLocalPlayer() → boolean`

Returns whenever the weapon is carried by the local player.

**Returns:**
- boolean — Is the weapon is carried by the local player or not

[wiki](https://wiki.facepunch.com/gmod/Weapon:IsCarriedByLocalPlayer)

---

### Weapon:IsScripted · Shared
`Weapon:IsScripted() → boolean`

Checks if the weapon is a SWEP or a built-in weapon.

**Returns:**
- boolean — Returns true if weapon is scripted ( SWEP ), false if not ( A built-in HL2/HL:S weapon )

[wiki](https://wiki.facepunch.com/gmod/Weapon:IsScripted)

---

### Weapon:IsWeaponVisible · Shared
`Weapon:IsWeaponVisible() → boolean`

Returns whether the weapon is visible. The term visibility is not exactly what gets checked here, first it checks if the owner is a player, then checks if the active view model has EF_NODRAW flag NOT set.

**Returns:**
- boolean — Is visible or not

[wiki](https://wiki.facepunch.com/gmod/Weapon:IsWeaponVisible)

---

### Weapon:LastShootTime · Shared
`Weapon:LastShootTime() → number`

Returns the time since this weapon last fired a bullet with [Entity:FireBullets](https://wiki.facepunch.com/gmod/Entity:FireBullets) in seconds. It is not networked.

**Returns:**
- number — The time in seconds when the last bullet was fired.

[wiki](https://wiki.facepunch.com/gmod/Weapon:LastShootTime)

---

### Weapon:SendWeaponAnim · Shared
`Weapon:SendWeaponAnim(act: number)`

Forces weapon to play activity/animation.

**Arguments:**
- `act` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — Activity to play.

[wiki](https://wiki.facepunch.com/gmod/Weapon:SendWeaponAnim)

---

### Weapon:SetActivity · Shared
`Weapon:SetActivity(act: number)`

Sets the activity the weapon is playing.

See also [Weapon:GetActivity](https://wiki.facepunch.com/gmod/Weapon:GetActivity).

**Arguments:**
- `act` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The new activity to set, see ACT.

[wiki](https://wiki.facepunch.com/gmod/Weapon:SetActivity)

---

### Weapon:SetClip1 · Shared
`Weapon:SetClip1(ammo: number)`

Lets you change the number of bullets in the given weapons primary clip.

**Arguments:**
- `ammo` (number) — The amount of bullets the clip should contain

[wiki](https://wiki.facepunch.com/gmod/Weapon:SetClip1)

---

### Weapon:SetClip2 · Shared
`Weapon:SetClip2(ammo: number)`

Lets you change the number of bullets in the given weapons secondary clip.

**Arguments:**
- `ammo` (number) — The amount of bullets the clip should contain

[wiki](https://wiki.facepunch.com/gmod/Weapon:SetClip2)

---

### Weapon:SetDeploySpeed · Shared
`Weapon:SetDeploySpeed(speed: number)`

Sets the weapon deploy speed. This value needs to match on client and server.

**Arguments:**
- `speed` (number) — The value to set deploy speed to.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:SetDeploySpeed)

---

### Weapon:SetHoldType · Shared
`Weapon:SetHoldType(name: string)`

Sets the hold type of the weapon. This function also calls [WEAPON:SetWeaponHoldType](https://wiki.facepunch.com/gmod/WEAPON:SetWeaponHoldType) and properly networks it to all clients.

**Arguments:**
- `name` (string) — Name of the hold type.

> **Note:** This only works on scripted weapons.
> **Bug:** Using this function on weapons held by bots will not network holdtype changes to clients if the world model is set to an empty string (SWEP.WorldModel = "").

[wiki](https://wiki.facepunch.com/gmod/Weapon:SetHoldType)

---

### Weapon:SetLastShootTime · Shared
`Weapon:SetLastShootTime(time: number = CurTime())`

Sets the time since this weapon last fired in seconds. Used in conjunction with [Weapon:LastShootTime](https://wiki.facepunch.com/gmod/Weapon:LastShootTime).

This value is **not** networked to the client if set from server.

**Arguments:**
- `time` (number, default `CurTime()`) — The time in seconds when the last time the weapon was fired.

[wiki](https://wiki.facepunch.com/gmod/Weapon:SetLastShootTime)

---

### Weapon:SetNextPrimaryFire · Shared
`Weapon:SetNextPrimaryFire(time: number)`

Sets when the weapon can fire again. Time should be based on [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime).

**Arguments:**
- `time` (number) — Time when player should be able to use primary fire again

> **Note:** The standard HL2 Pistol (`weapon_pistol`) bypasses this function due to an [internal implementation](https://github.com/ValveSoftware/source-sdk-2013/blob/master/src/game/server/hl2/weapon_pistol.cpp#L313-L317).
> **Bug** ([#3786](https://github.com/Facepunch/garrysmod/issues/3786)): This will fire extra bullets if the time is set to less than [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime).

[wiki](https://wiki.facepunch.com/gmod/Weapon:SetNextPrimaryFire)

---

### Weapon:SetNextSecondaryFire · Shared
`Weapon:SetNextSecondaryFire(time: number)`

Sets when the weapon can alt-fire again. Time should be based on [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime).

**Arguments:**
- `time` (number) — Time when player should be able to use secondary fire again

[wiki](https://wiki.facepunch.com/gmod/Weapon:SetNextSecondaryFire)

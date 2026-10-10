# CTakeDamageInfo

**Realm:** Shared  ·  **Members:** 33

A class used to store and modify all the data concerning a damage event.
An empty CTakeDamageInfo object can be created with [DamageInfo](https://wiki.facepunch.com/gmod/Global.DamageInfo)

List of hooks that this object is passed to:
* [ENTITY:OnTakeDamage](https://wiki.facepunch.com/gmod/ENTITY:OnTakeDamage)
* [GM:DoPlayerDeath](https://wiki.facepunch.com/gmod/GM:DoPlayerDeath)
* [GM:EntityTakeDamage](https://wiki.facepunch.com/gmod/GM:EntityTakeDamage)
* [GM:PostEntityTakeDamage](https://wiki.facepunch.com/gmod/GM:PostEntityTakeDamage)
* [GM:OnDamagedByExplosion](https://wiki.facepunch.com/gmod/GM:OnDamagedByExplosion)
* [GM:ScaleNPCDamage](https://wiki.facepunch.com/gmod/GM:ScaleNPCDamage)
* [GM:ScalePlayerDamage](https://wiki.facepunch.com/gmod/GM:ScalePlayerDamage)
* [NEXTBOT:OnInjured](https://wiki.facepunch.com/gmod/NEXTBOT:OnInjured)
* [NEXTBOT:OnKilled](https://wiki.facepunch.com/gmod/NEXTBOT:OnKilled)
* [NEXTBOT:OnOtherKilled](https://wiki.facepunch.com/gmod/NEXTBOT:OnOtherKilled)

List of functions that use this object:
* [util.BlastDamageInfo](https://wiki.facepunch.com/gmod/util.BlastDamageInfo)
* [Entity:TakeDamageInfo](https://wiki.facepunch.com/gmod/Entity:TakeDamageInfo)
* [Entity:TakePhysicsDamage](https://wiki.facepunch.com/gmod/Entity:TakePhysicsDamage)
* [Entity:DispatchTraceAttack](https://wiki.facepunch.com/gmod/Entity:DispatchTraceAttack)

[wiki page](https://wiki.facepunch.com/gmod/CTakeDamageInfo)

### CTakeDamageInfo:AddDamage · Shared
`CTakeDamageInfo:AddDamage(damageIncrease: number)`

Increases the damage by damageIncrease.

**Arguments:**
- `damageIncrease` (number) — The damage to add.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:AddDamage)

---

### CTakeDamageInfo:GetAmmoType · Shared
`CTakeDamageInfo:GetAmmoType() → number`

Returns the ammo type used by the weapon that inflicted the damage.

**Returns:**
- number — Ammo type ID

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetAmmoType)

---

### CTakeDamageInfo:GetAttacker · Shared
`CTakeDamageInfo:GetAttacker() → Entity`

Returns the attacker ( character who originated the attack ), for example a player or an NPC that shot the weapon.

**Returns:**
- Entity — The attacker

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetAttacker)

---

### CTakeDamageInfo:GetBaseDamage · Shared
`CTakeDamageInfo:GetBaseDamage() → number`

Returns the initial unmodified by skill level ( [game.GetSkillLevel](https://wiki.facepunch.com/gmod/game.GetSkillLevel) ) damage.

**Returns:**
- number — baseDamage

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetBaseDamage)

---

### CTakeDamageInfo:GetDamage · Shared
`CTakeDamageInfo:GetDamage() → number`

Returns the total damage.

**Returns:**
- number — damage

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetDamage)

---

### CTakeDamageInfo:GetDamageBonus · Shared
`CTakeDamageInfo:GetDamageBonus() → number`

Gets the current bonus damage.

**Returns:**
- number — Bonus damage

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetDamageBonus)

---

### CTakeDamageInfo:GetDamageCustom · Shared
`CTakeDamageInfo:GetDamageCustom() → number`

Gets the custom damage type. This is used by Day of Defeat: Source and Team Fortress 2 for extended damage info, but isn't used in Garry's Mod by default.

**Returns:**
- number — The custom damage type

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetDamageCustom)

---

### CTakeDamageInfo:GetDamageForce · Shared
`CTakeDamageInfo:GetDamageForce() → Vector`

Returns a vector representing the damage force.

Can be set with [CTakeDamageInfo:SetDamageForce](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetDamageForce).

**Returns:**
- Vector — The damage force

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetDamageForce)

---

### CTakeDamageInfo:GetDamagePosition · Shared
`CTakeDamageInfo:GetDamagePosition() → Vector`

Returns the position where the damage was or is going to be applied to.

Can be set using [CTakeDamageInfo:SetDamagePosition](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetDamagePosition).

**Returns:**
- Vector — The damage position

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetDamagePosition)

---

### CTakeDamageInfo:GetDamageType · Shared
`CTakeDamageInfo:GetDamageType() → number{DMG}`

Returns a bitflag which indicates the damage type(s) of the damage.

Consider using [CTakeDamageInfo:IsDamageType](https://wiki.facepunch.com/gmod/CTakeDamageInfo:IsDamageType) instead. Value returned by this function can contain multiple damage types.

**Returns:**
- number{DMG} — Damage type(s), a combination of DMG

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetDamageType)

---

### CTakeDamageInfo:GetInflictor · Shared
`CTakeDamageInfo:GetInflictor() → Entity`

Returns the inflictor of the damage. This is not necessarily a weapon.

For hitscan weapons this is the weapon.

For projectile weapons this is the projectile.

For a more reliable method of getting the weapon that damaged an entity, use [CTakeDamageInfo:GetWeapon](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetWeapon) or [GetAttacker](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetAttacker) with [GetActiveWeapon](https://wiki.facepunch.com/gmod/Player:GetActiveWeapon).

**Returns:**
- Entity — The inflictor entity.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetInflictor)

---

### CTakeDamageInfo:GetMaxDamage · Shared
`CTakeDamageInfo:GetMaxDamage() → number`

Returns the maximum damage. See [CTakeDamageInfo:SetMaxDamage](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetMaxDamage).

This is only set by "multi damage" instances in the engine, and is only checked by the strider NPC when receiving explosive damage.

**Returns:**
- number — The maximum amount of damage in the "multi damage" instance.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetMaxDamage)

---

### CTakeDamageInfo:GetReportedPosition · Shared
`CTakeDamageInfo:GetReportedPosition() → Vector`

Returns the initial, unmodified position where the damage occured.

**Returns:**
- Vector — position

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetReportedPosition)

---

### CTakeDamageInfo:GetWeapon · Shared
`CTakeDamageInfo:GetWeapon() → Entity`

Returns the inflicting weapon of the damage event, if there is any.

This is not necessarily a [Weapon](https://wiki.facepunch.com/gmod/Weapon) entity, but it is very likely to be one.

See [CTakeDamageInfo:GetInflictor](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetInflictor) for the actual entity that did the damage.

**Returns:**
- Entity — The damage-inflicting weapon or NULL.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetWeapon)

---

### CTakeDamageInfo:IsBulletDamage · Shared
`CTakeDamageInfo:IsBulletDamage() → boolean`

Returns true if the damage was caused by a bullet.

**Returns:**
- boolean — isBulletDmg

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:IsBulletDamage)

---

### CTakeDamageInfo:IsDamageType · Shared
`CTakeDamageInfo:IsDamageType(dmgType: number{DMG}) → boolean`

Returns whenever the damageinfo contains the damage type specified.

**Arguments:**
- `dmgType` (number{DMG}) — Damage type to test.

**Returns:**
- boolean — Whether this damage contains specified damage type or not

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:IsDamageType)

---

### CTakeDamageInfo:IsExplosionDamage · Shared
`CTakeDamageInfo:IsExplosionDamage() → boolean`

Returns whenever the damageinfo contains explosion damage.

**Returns:**
- boolean — isExplDamage

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:IsExplosionDamage)

---

### CTakeDamageInfo:IsFallDamage · Shared
`CTakeDamageInfo:IsFallDamage() → boolean`

Returns whenever the damageinfo contains fall damage.

**Returns:**
- boolean — isFallDmg

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:IsFallDamage)

---

### CTakeDamageInfo:ScaleDamage · Shared
`CTakeDamageInfo:ScaleDamage(scale: number)`

Scales the damage by the given value.

**Arguments:**
- `scale` (number) — Value to scale the damage with.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:ScaleDamage)

---

### CTakeDamageInfo:SetAmmoType · Shared
`CTakeDamageInfo:SetAmmoType(ammoType: number)`

Changes the ammo type used by the weapon that inflicted the damage.

**Arguments:**
- `ammoType` (number) — Ammo type ID

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetAmmoType)

---

### CTakeDamageInfo:SetAttacker · Shared
`CTakeDamageInfo:SetAttacker(ent: Entity)`

Sets the attacker ( character who originated the attack ) of the damage, for example a player or an NPC.

**Arguments:**
- `ent` (Entity) — The entity to be set as the attacker.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetAttacker)

---

### CTakeDamageInfo:SetBaseDamage · Shared
`CTakeDamageInfo:SetBaseDamage(a1: number)`

Sets the initial damage, unmodified by the current skill level ([game.GetSkillLevel](https://wiki.facepunch.com/gmod/game.GetSkillLevel)). This is usually set automatically by the game when dealing damage.

This function will not modify the real damage that will be dealt ([CTakeDamageInfo:GetDamage](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetDamage)).

Use this only if you know what you are doing. Otherwise use [CTakeDamageInfo:SetDamage](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetDamage).

**Arguments:**
- `a1` (number) — The base damage.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetBaseDamage)

---

### CTakeDamageInfo:SetDamage · Shared
`CTakeDamageInfo:SetDamage(damage: number)`

Sets the amount of damage.

**Arguments:**
- `damage` (number) — The value to set the absolute damage to.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetDamage)

---

### CTakeDamageInfo:SetDamageBonus · Shared
`CTakeDamageInfo:SetDamageBonus(damage: number)`

Sets the bonus damage. Bonus damage isn't automatically applied, so this will have no outer effect by default.

**Arguments:**
- `damage` (number) — The extra damage to be added.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetDamageBonus)

---

### CTakeDamageInfo:SetDamageCustom · Shared
`CTakeDamageInfo:SetDamageCustom(DamageType: number)`

Sets the custom damage type. This is used by Day of Defeat: Source and Team Fortress 2 for extended damage info, but isn't used in Garry's Mod by default.

**Arguments:**
- `DamageType` (number) — Any integer - can be based on your own custom enums.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetDamageCustom)

---

### CTakeDamageInfo:SetDamageForce · Shared
`CTakeDamageInfo:SetDamageForce(force: Vector)`

Sets the directional force of the damage.

**Arguments:**
- `force` (Vector) — The vector to set the force to.

> **Note:** This function only affects entities using the VPHYSICS movetype. This means players and most NPCs won't receive the force vector you provide as knockback. 
> 
> If the entity taking damage is using the WALK or STEP movetypes, the damage force is instead automatically calculated. It will push the entity away from the inflictor's [Entity:WorldSpaceCenter](https://wiki.facepunch.com/gmod/Entity:WorldSpaceCenter), scaling the push by a calculated value involving the total amount of damage and the size of the entity. [Source](https://github.com/ValveSoftware/source-sdk-2013/blob/0565403b153dfcde602f6f58d8f4d13483696a13/src/game/server/baseentity.cpp#L1525)
> 
> To disable knockback entirely, see [EFL_NO_DAMAGE_FORCES](https://wiki.facepunch.com/gmod/Enums/EFL#EFL_NO_DAMAGE_FORCES) or use the workaround example below.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetDamageForce)

---

### CTakeDamageInfo:SetDamagePosition · Shared
`CTakeDamageInfo:SetDamagePosition(pos: Vector)`

Sets the position of where the damage gets applied to.

**Arguments:**
- `pos` (Vector) — The position where the damage will be applied.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetDamagePosition)

---

### CTakeDamageInfo:SetDamageType · Shared
`CTakeDamageInfo:SetDamageType(type: number{DMG})`

Sets the damage type.

**Arguments:**
- `type` (number{DMG}) — The damage type, see DMG.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetDamageType)

---

### CTakeDamageInfo:SetInflictor · Shared
`CTakeDamageInfo:SetInflictor(inflictor: Entity)`

Sets the inflictor of the damage for example a weapon.

For hitscan/bullet weapons this should the weapon.

For projectile (rocket launchers, grenades, etc) weapons this should be the projectile and [CTakeDamageInfo:SetWeapon](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetWeapon) should be the weapon.

**Arguments:**
- `inflictor` (Entity) — The new inflictor.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetInflictor)

---

### CTakeDamageInfo:SetMaxDamage · Shared
`CTakeDamageInfo:SetMaxDamage(maxDamage: number)`

Sets the "maximum damage" for this damage event. See [CTakeDamageInfo:GetMaxDamage](https://wiki.facepunch.com/gmod/CTakeDamageInfo:GetMaxDamage) for details.

**Arguments:**
- `maxDamage` (number) — Maximum damage value.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetMaxDamage)

---

### CTakeDamageInfo:SetReportedPosition · Shared
`CTakeDamageInfo:SetReportedPosition(pos: Vector)`

Sets the origin of the damage.

**Arguments:**
- `pos` (Vector) — The location of where the damage is originating

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetReportedPosition)

---

### CTakeDamageInfo:SetWeapon · Shared
`CTakeDamageInfo:SetWeapon(a1: Entity)`

Sets the damage-inflicting weapon of the damage event.

This should be a [Weapon](https://wiki.facepunch.com/gmod/Weapon) entity, not a projectile. See also [CTakeDamageInfo:SetInflictor](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetInflictor).

**Arguments:**
- `a1` (Entity) — The damage-inflicting weapon or NULL.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SetWeapon)

---

### CTakeDamageInfo:SubtractDamage · Shared
`CTakeDamageInfo:SubtractDamage(damage: number)`

Subtracts the specified amount from the damage.

**Arguments:**
- `damage` (number) — Value to subtract.

[wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo:SubtractDamage)

# SWEP

**Realm:** Shared  ·  **Members:** 59

Default weapon methods, that are available for use in SWEPs. These hooks **will not work** on non-scripted weapons, such as the Half-Life 2 weapons.

You can find all available SWEP fields here: [Structures/SWEP](https://wiki.facepunch.com/gmod/Structures/SWEP)

> **Using these hooks:** these are **method overrides**, not `hook.Add` events — define them as methods on your `SWEP` table: `function SWEP:<Name>(...) end`. The `SWEP:` prefix shown on each member below is the method form you write.

### SWEP:AcceptInput · Server · `hook`
`SWEP:AcceptInput(inputName: string, activator: Entity, called: Entity, data: string) → boolean`

Called when another entity fires an event to this entity.

**Arguments:**
- `inputName` (string) — The name of the input that was triggered.
- `activator` (Entity) — The initial cause for the input getting triggered.
- `called` (Entity) — The entity that directly trigger the input.
- `data` (string) — The data passed.

**Returns:**
- boolean — Should we suppress the default action for this input?

[wiki](https://wiki.facepunch.com/gmod/WEAPON:AcceptInput)

---

### SWEP:AdjustMouseSensitivity · Client · `hook`
`SWEP:AdjustMouseSensitivity(defaultSensitivity: number, localFOV: number, defaultFOV: number) → number`

Allows you to adjust the weapon's mouse sensitivity. This hook only works if you haven't overridden [GM:AdjustMouseSensitivity](https://wiki.facepunch.com/gmod/GM:AdjustMouseSensitivity).

**Arguments:**
- `defaultSensitivity` (number) — The old sensitivity In general this will be 0, which is equivalent to a sensitivity of 1.
- `localFOV` (number) — The player's current FOV.
- `defaultFOV` (number) — The player's default FOV.

**Returns:**
- number — A multiplier of the player's normal sensitivity (0.5 would be half as sensitive, 2 would be twice as sensitive).

[wiki](https://wiki.facepunch.com/gmod/WEAPON:AdjustMouseSensitivity)

---

### SWEP:Ammo1 · Shared · `hook`
`SWEP:Ammo1() → number`

Returns how much of primary ammo the player has.

**Returns:**
- number — The amount of primary ammo player has

[wiki](https://wiki.facepunch.com/gmod/WEAPON:Ammo1) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/shared.lua#L251-L257)

---

### SWEP:Ammo2 · Shared · `hook`
`SWEP:Ammo2() → number`

Returns how much of secondary ammo the player has.

**Returns:**
- number — The amount of secondary ammo player has

[wiki](https://wiki.facepunch.com/gmod/WEAPON:Ammo2) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/shared.lua#L262-L267)

---

### SWEP:CalcView · Client · `hook`
`SWEP:CalcView(ply: Player, pos: Vector, ang: Angle, fov: number) → Vector, Angle, number`

Allows you to adjust player view while this weapon in use.

This hook is called from the default implementation of [GM:CalcView](https://wiki.facepunch.com/gmod/GM:CalcView) which is [here](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L387-L395). Therefore, it will not be called if any other hook added to `CalcView` returns any value, or if the current gamemode overrides the default hook and does not call the SWEP function.

**Arguments:**
- `ply` (Player) — The owner of weapon
- `pos` (Vector) — Current position of players view
- `ang` (Angle) — Current angles of players view
- `fov` (number) — Current FOV of players view

**Returns:**
- Vector — New position of players view
- Angle — New angle of players view
- number — New FOV of players view

[wiki](https://wiki.facepunch.com/gmod/WEAPON:CalcView)

---

### SWEP:CalcViewModelView · Client · `hook`
`SWEP:CalcViewModelView(ViewModel: Entity, OldEyePos: Vector, OldEyeAng: Angle, EyePos: Vector, EyeAng: Angle) → Vector, Angle`

Allows overriding the position and angle of the viewmodel. This hook only works if you haven't overridden [GM:CalcViewModelView](https://wiki.facepunch.com/gmod/GM:CalcViewModelView).

**Arguments:**
- `ViewModel` (Entity) — The viewmodel entity
- `OldEyePos` (Vector) — Original position (before viewmodel bobbing and swaying)
- `OldEyeAng` (Angle) — Original angle (before viewmodel bobbing and swaying)
- `EyePos` (Vector) — Current position
- `EyeAng` (Angle) — Current angle

**Returns:**
- Vector — New position
- Angle — New angle

[wiki](https://wiki.facepunch.com/gmod/WEAPON:CalcViewModelView)

---

### SWEP:CanBePickedUpByNPCs · Server · `hook`
`SWEP:CanBePickedUpByNPCs() → boolean`

Called when a Citizen NPC is looking around to a (better) weapon to pickup.

**Returns:**
- boolean — Return true to allow this weapon to be picked up by NPCs.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:CanBePickedUpByNPCs)

---

### SWEP:CanPrimaryAttack · Shared · `hook`
`SWEP:CanPrimaryAttack() → boolean`

Helper function for checking for no ammo.

**Returns:**
- boolean — Can use primary attack

[wiki](https://wiki.facepunch.com/gmod/WEAPON:CanPrimaryAttack) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/shared.lua#L200-L213)

---

### SWEP:CanSecondaryAttack · Shared · `hook`
`SWEP:CanSecondaryAttack() → boolean`

Helper function for checking for no ammo.

**Returns:**
- boolean — Can use secondary attack

[wiki](https://wiki.facepunch.com/gmod/WEAPON:CanSecondaryAttack) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/shared.lua#L219-L231)

---

### SWEP:CustomAmmoDisplay · Client · `hook`
`SWEP:CustomAmmoDisplay() → table`

Allows you to use any numbers you want for the ammo display on the HUD.

Can be useful for weapons that don't use standard ammo.

**Returns:**
- table — The new ammo display settings.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:CustomAmmoDisplay)

---

### SWEP:Deploy · Shared · `hook` · `PREDICTED`
`SWEP:Deploy() → boolean`

Called when player has just switched to this weapon.

**Returns:**
- boolean — Return true to allow switching away from this weapon using `lastinv` command

> **Note:** Due to this hook being predicted, it is not called clientside in singleplayer at all, and in multiplayer it will not be called clientside if the weapon is switched with [Player:SelectWeapon](https://wiki.facepunch.com/gmod/Player:SelectWeapon) or the "use" console command, however it will be called clientside with the default weapon selection menu and when using [CUserCmd:SelectWeapon](https://wiki.facepunch.com/gmod/CUserCmd:SelectWeapon)

[wiki](https://wiki.facepunch.com/gmod/WEAPON:Deploy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/shared.lua#L114-L116)

---

### SWEP:DoDrawCrosshair · Client · `hook`
`SWEP:DoDrawCrosshair(x: number, y: number) → boolean`

Called when the crosshair is about to get drawn, and allows you to override it.

This function will **not** be called if `SWEP.DrawCrosshair` is set to false or if player is affected by [Player:CrosshairDisable](https://wiki.facepunch.com/gmod/Player:CrosshairDisable).

**Arguments:**
- `x` (number) — X coordinate of the crosshair.
- `y` (number) — Y coordinate of the crosshair.

**Returns:**
- boolean — Return true to override the default crosshair.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:DoDrawCrosshair)

---

### SWEP:DoImpactEffect · Shared · `hook`
`SWEP:DoImpactEffect(tr: table, damageType: number) → boolean`

Called so the weapon can override the impact effects it makes.

**Arguments:**
- `tr` (table) — A Structures/TraceResult from player's eyes to the impact point
- `damageType` (number, enum [DMG](https://wiki.facepunch.com/gmod/Enums/DMG)) — The damage type of bullet.

**Returns:**
- boolean — Return true to not do the default thing - which is to call `UTIL_ImpactTrace` in C++

> **Note:** If the bullet was fired in a predicted environment, the hook will not be called on the `CLIENT` realm.
> **Note:** This hook will also be called when `WEAPON:GetOwner():FireBullets` is called. While in `MULTIPLAYER`, this hook will be called on the respective state, but in `SINGLEPLAYER`, this hook will always be called on the `CLIENT` realm even if `FireBullets` was called on the `SERVER`.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:DoImpactEffect)

---

### SWEP:DrawHUD · Client · `hook`
`SWEP:DrawHUD()`

This hook allows you to draw on screen while this weapon is in use.

If you want to draw a custom crosshair, consider using [WEAPON:DoDrawCrosshair](https://wiki.facepunch.com/gmod/WEAPON:DoDrawCrosshair) instead.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:DrawHUD)

---

### SWEP:DrawHUDBackground · Client · `hook`
`SWEP:DrawHUDBackground()`

This hook allows you to draw on screen while this weapon is in use. This hook is called **before** [WEAPON:DrawHUD](https://wiki.facepunch.com/gmod/WEAPON:DrawHUD) and is equivalent of [GM:HUDPaintBackground](https://wiki.facepunch.com/gmod/GM:HUDPaintBackground).

[wiki](https://wiki.facepunch.com/gmod/WEAPON:DrawHUDBackground)

---

### SWEP:DrawWeaponSelection · Client · `hook`
`SWEP:DrawWeaponSelection(x: number, y: number, width: number, height: number, alpha: number)`

This hook draws the selection icon in the weapon selection menu.

**Arguments:**
- `x` (number) — X coordinate of the selection panel
- `y` (number) — Y coordinate of the selection panel
- `width` (number) — Width of the selection panel
- `height` (number) — Height of the selection panel
- `alpha` (number) — Alpha value of the selection panel

[wiki](https://wiki.facepunch.com/gmod/WEAPON:DrawWeaponSelection) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/cl_init.lua#L34-L58)

---

### SWEP:DrawWorldModel · Client · `hook`
`SWEP:DrawWorldModel(flags: number)`

Called when we are about to draw the opaque parts of the weapon's world model.

See [WEAPON:DrawWorldModelTranslucent](https://wiki.facepunch.com/gmod/WEAPON:DrawWorldModelTranslucent) for translucent pass callback.
See [WEAPON:ViewModelDrawn](https://wiki.facepunch.com/gmod/WEAPON:ViewModelDrawn) for view model rendering.

**Arguments:**
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The STUDIO_ flags for this render operation.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:DrawWorldModel)

---

### SWEP:DrawWorldModelTranslucent · Client · `hook`
`SWEP:DrawWorldModelTranslucent(flags: number)`

Called when we are about to draw the translucent parts of the weapon's world model.

See [WEAPON:DrawWorldModel](https://wiki.facepunch.com/gmod/WEAPON:DrawWorldModel) for opaque pass callback.
See [WEAPON:ViewModelDrawn](https://wiki.facepunch.com/gmod/WEAPON:ViewModelDrawn) for view model rendering.

**Arguments:**
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The STUDIO_ flags for this render operation.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:DrawWorldModelTranslucent)

---

### SWEP:Equip · Server · `hook`
`SWEP:Equip(NewOwner: Entity)`

Called when a player or NPC has picked the weapon up.

**Arguments:**
- `NewOwner` (Entity) — The one who picked the weapon up.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:Equip)

---

### SWEP:EquipAmmo · Server · `hook`
`SWEP:EquipAmmo(ply: Player)`

The player has picked up the weapon and has taken the ammo from it.
The weapon will be removed immediately after this call.

**Arguments:**
- `ply` (Player) — The player who picked up the weapon

[wiki](https://wiki.facepunch.com/gmod/WEAPON:EquipAmmo)

---

### SWEP:FireAnimationEvent · Shared · `hook`
`SWEP:FireAnimationEvent(pos: Vector, ang: Angle, event: number, options: string, source: Entity) → boolean`

Called before executing an animation event, such as a muzzle flash appearing or a shell ejecting.

This will only be called serverside for 3000-range events, and clientside for 5000-range and other events.

**Arguments:**
- `pos` (Vector) — Position of the effect.
- `ang` (Angle) — Angle of the effect.
- `event` (number) — The event ID of the happened event.
- `options` (string) — Name or options of the event.
- `source` (Entity) — The source entity.

**Returns:**
- boolean — Return true to disable the effect.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:FireAnimationEvent)

---

### SWEP:FreezeMovement · Client · `hook`
`SWEP:FreezeMovement() → boolean`

This hook allows you to freeze players screen.

**Returns:**
- boolean — Return true to freeze moving the view

> **Note:** Player will still be able to move or shoot

[wiki](https://wiki.facepunch.com/gmod/WEAPON:FreezeMovement)

---

### SWEP:GetCapabilities · Server · `hook`
`SWEP:GetCapabilities() → number{CAP}`

This hook is for NPCs, you return what they should try to do with it.

**Returns:**
- number{CAP} — A number defining what NPC should do with the weapon.

> **Warning:** Calling [NPC:CapabilitiesGet](https://wiki.facepunch.com/gmod/NPC:CapabilitiesGet) in this hook on the same entity can cause infinite loops since that function adds the result of [WEAPON:GetCapabilities](https://wiki.facepunch.com/gmod/WEAPON:GetCapabilities) on top of the return value.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:GetCapabilities) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/init.lua#L73-L77)

---

### SWEP:GetNPCBulletSpread · Server · `hook`
`SWEP:GetNPCBulletSpread(proficiency: number) → number`

Called when the weapon is used by NPCs to determine how accurate the bullets fired should be.

The inaccuracy is simulated by changing the [NPC:GetAimVector](https://wiki.facepunch.com/gmod/NPC:GetAimVector) based on the value returned from this hook.

**Arguments:**
- `proficiency` (number, enum [WEAPON_PROFICIENCY](https://wiki.facepunch.com/gmod/Enums/WEAPON_PROFICIENCY)) — How proficient the NPC is with this gun.

**Returns:**
- number — An amount of degrees the bullets should deviate from the NPC's NPC:GetAimVector.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:GetNPCBulletSpread)

---

### SWEP:GetNPCBurstSettings · Server · `hook`
`SWEP:GetNPCBurstSettings() → number, number, number`

Called when the weapon is used by NPCs to tell the NPC how to use this weapon. Controls how long the NPC can or should shoot continuously.

**Returns:**
- number — Minimum amount of bullets per burst.
- number — Maximum amount of bullets per burst.
- number — Delay between each shot, aka firerate.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:GetNPCBurstSettings)

---

### SWEP:GetNPCRestTimes · Server · `hook`
`SWEP:GetNPCRestTimes() → number, number`

Called when the weapon is used by NPCs to tell the NPC how to use this weapon. Controls amount of time the NPC can rest (not shoot) between bursts.

**Returns:**
- number — Minimum amount of time the NPC can rest (not shoot) between bursts in seconds.
- number — Maximum amount of time the NPC can rest (not shoot) between bursts in seconds.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:GetNPCRestTimes)

---

### SWEP:GetTracerOrigin · Client · `hook`
`SWEP:GetTracerOrigin() → Vector`

Allows you to override where the tracer effect comes from. ( Visual bullets )

**Returns:**
- Vector — The new position to start tracer effect from

[wiki](https://wiki.facepunch.com/gmod/WEAPON:GetTracerOrigin)

---

### SWEP:GetViewModelPosition · Client · `hook`
`SWEP:GetViewModelPosition(EyePos: Vector, EyeAng: Angle) → Vector, Angle`

This hook allows you to adjust view model position and angles.

**Arguments:**
- `EyePos` (Vector) — Current position
- `EyeAng` (Angle) — Current angle

**Returns:**
- Vector — New position
- Angle — New angle

[wiki](https://wiki.facepunch.com/gmod/WEAPON:GetViewModelPosition)

---

### SWEP:Holster · Shared · `hook` · `PREDICTED`
`SWEP:Holster(weapon: Entity) → boolean`

Called when weapon tries to holster.

**Arguments:**
- `weapon` (Entity) — The weapon we are trying switch to.

**Returns:**
- boolean — Return true to allow weapon to holster.

> **Note:** This will only be called serverside when using [Player:SelectWeapon](https://wiki.facepunch.com/gmod/Player:SelectWeapon) as that function immediately switches the weapon out of prediction.
> **Bug** ([#2854](https://github.com/Facepunch/garrysmod/issues/2854)): This is called twice for every holster clientside, one in [Prediction](https://wiki.facepunch.com/gmod/Prediction) and one not.
> **Bug** ([#3133](https://github.com/Facepunch/garrysmod/issues/3133)): Before [WEAPON:OnRemove](https://wiki.facepunch.com/gmod/WEAPON:OnRemove) is called, this function is only called serverside.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:Holster)

---

### SWEP:HUDShouldDraw · Client · `hook`
`SWEP:HUDShouldDraw(element: string) → boolean`

This hook determines which parts of the HUD to draw.

**Arguments:**
- `element` (string) — The HUD element in question

**Returns:**
- boolean — Return false to hide this HUD element

[wiki](https://wiki.facepunch.com/gmod/WEAPON:HUDShouldDraw)

---

### SWEP:Initialize · Shared · `hook`
`SWEP:Initialize()`

Called when the weapon entity is created.

> **Note:** [Entity:GetOwner](https://wiki.facepunch.com/gmod/Entity:GetOwner) will return NULL at this point because the weapon is not equpped by a player or NPC yet. Use [WEAPON:Equip](https://wiki.facepunch.com/gmod/WEAPON:Equip) or [WEAPON:Deploy](https://wiki.facepunch.com/gmod/WEAPON:Deploy) if you need the owner to be valid.
> **Bug** ([#3015](https://github.com/Facepunch/garrysmod/issues/3015)): This is not called serverside after a quicksave.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:Initialize)

---

### SWEP:KeyValue · Server · `hook`
`SWEP:KeyValue(key: string, value: string) → boolean`

Called when the engine sets a value for this scripted weapon.

See [GM:EntityKeyValue](https://wiki.facepunch.com/gmod/GM:EntityKeyValue) for a hook that works for all entities.


See [ENTITY:KeyValue](https://wiki.facepunch.com/gmod/ENTITY:KeyValue) for an  hook that works for scripted entities.

**Arguments:**
- `key` (string) — The key that was affected.
- `value` (string) — The new value.

**Returns:**
- boolean — Return true to suppress this KeyValue or return false or nothing to apply this key value.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:KeyValue)

---

### SWEP:NPCShoot_Primary · Server · `hook`
`SWEP:NPCShoot_Primary(shootPos: Vector = GetShootPos(), shootDir: Vector = GetAimVector())`

Called internally during `TASK_RANGE_ATTACK1 --> OnRangeAttack1`. This allows you to separate your SWEPs primary firing function from players and NPCs. 

To get the delay the NPC will fire again, you can call `self:GetOwner():GetInternalVariable("m_flNextAttack")`

**Arguments:**
- `shootPos` (Vector, default `GetShootPos()`) — The world position the NPC will use as attack starting position.
- `shootDir` (Vector, default `GetAimVector()`) — The direction the NPC wants to shoot at.

> **Note:** This hook is called internally only for NPCs that has `CAP_USE_SHOT_REGULATOR` set.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:NPCShoot_Primary) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/init.lua#L93)

---

### SWEP:NPCShoot_Secondary · Server · `hook`
`SWEP:NPCShoot_Secondary(shootPos: Vector = GetShootPos(), shootDir: Vector = GetAimVector())`

A utility function to seperate your SWEPs secondary firing from players. 

Unlike [WEAPON:NPCShoot_Primary](https://wiki.facepunch.com/gmod/WEAPON:NPCShoot_Primary), this won't be called by the engine for `TASK_RANGE_ATTACK2`.

**Arguments:**
- `shootPos` (Vector, default `GetShootPos()`) — The world position the NPC will use as attack starting position.
- `shootDir` (Vector, default `GetAimVector()`) — The direction the NPC wants to shoot at.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:NPCShoot_Secondary) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/init.lua#L83)

---

### SWEP:OnDrop · Server · `hook`
`SWEP:OnDrop(owner: Entity)`

Called when weapon is dropped by [Player:DropWeapon](https://wiki.facepunch.com/gmod/Player:DropWeapon).

See also [WEAPON:OwnerChanged](https://wiki.facepunch.com/gmod/WEAPON:OwnerChanged).

**Arguments:**
- `owner` (Entity) — The entity that dropped the weapon.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:OnDrop)

---

### SWEP:OnReloaded · Shared · `hook`
`SWEP:OnReloaded()`

Called whenever the weapons Lua script is reloaded.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:OnReloaded)

---

### SWEP:OnRemove · Shared · `hook`
`SWEP:OnRemove()`

Called when the [Scripted Weapon](https://wiki.facepunch.com/gmod/Scripted%20Entities) is about to be removed.

[Entity:GetOwner](https://wiki.facepunch.com/gmod/Entity:GetOwner) may be unset at this point, see [WEAPON:OnDrop](https://wiki.facepunch.com/gmod/WEAPON:OnDrop) and [WEAPON:OwnerChanged](https://wiki.facepunch.com/gmod/WEAPON:OwnerChanged).

[wiki](https://wiki.facepunch.com/gmod/WEAPON:OnRemove)

---

### SWEP:OnRestore · Shared · `hook`
`SWEP:OnRestore()`

Called when the weapon entity is reloaded from a Source Engine save (not the Sandbox saves or dupes) or on a changelevel (for example Half-Life 2 campaign level transitions).

For the [duplicator](https://wiki.facepunch.com/gmod/duplicator) callbacks, see [ENTITY:OnDuplicated](https://wiki.facepunch.com/gmod/ENTITY:OnDuplicated).

See also [saverestore](https://wiki.facepunch.com/gmod/saverestore) for relevant functions.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:OnRestore)

---

### SWEP:OwnerChanged · Shared · `hook`
`SWEP:OwnerChanged()`

Called when weapon is dropped or picked up by a new player. This can be called clientside for all players on the server if the weapon has no owner and is picked up.

See also [WEAPON:OnDrop](https://wiki.facepunch.com/gmod/WEAPON:OnDrop).

[wiki](https://wiki.facepunch.com/gmod/WEAPON:OwnerChanged)

---

### SWEP:PostDrawViewModel · Client · `hook`
`SWEP:PostDrawViewModel(vm: Entity, weapon: Weapon, ply: Player, flags: number)`

Called after the view model has been drawn while the weapon in use.

This hook relies on default implementation of [GM:PostDrawViewModel](https://wiki.facepunch.com/gmod/GM:PostDrawViewModel). If it appears to not work, it may have been overwritten/broken by the currently active gamemode or other addons.

[WEAPON:ViewModelDrawn](https://wiki.facepunch.com/gmod/WEAPON:ViewModelDrawn) is an alternative hook which is always called before [GM:PostDrawViewModel](https://wiki.facepunch.com/gmod/GM:PostDrawViewModel).

See also [WEAPON:PreDrawViewModel](https://wiki.facepunch.com/gmod/WEAPON:PreDrawViewModel).

**Arguments:**
- `vm` (Entity) — This is the view model entity after it is drawn
- `weapon` (Weapon) — This is the weapon that is from the view model (same as self)
- `ply` (Player) — The owner of the view model
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The STUDIO_ flags for this render operation.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:PostDrawViewModel)

---

### SWEP:PreDrawViewModel · Client · `hook`
`SWEP:PreDrawViewModel(vm: Entity, weapon: Weapon, ply: Player, flags: number) → boolean`

Allows you to modify viewmodel while the weapon in use before it is drawn.

This hook relies on default implementation of [GM:PreDrawViewModel](https://wiki.facepunch.com/gmod/GM:PreDrawViewModel). If it appears to not work, it may have been overwritten/broken by the currently active gamemode or other addons.

See also [WEAPON:ViewModelDrawn](https://wiki.facepunch.com/gmod/WEAPON:ViewModelDrawn) and [WEAPON:PostDrawViewModel](https://wiki.facepunch.com/gmod/WEAPON:PostDrawViewModel).

**Arguments:**
- `vm` (Entity) — This is the view model entity before it is drawn.
- `weapon` (Weapon) — This is the weapon that is from the view model.
- `ply` (Player) — The the owner of the view model.
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The STUDIO_ flags for this render operation.

**Returns:**
- boolean — Return `true` to prevent the default action of rendering the view model.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:PreDrawViewModel)

---

### SWEP:PrimaryAttack · Shared · `hook` · `PREDICTED`
`SWEP:PrimaryAttack()`

Called when primary attack button ( +attack ) is pressed.

When in singleplayer, this function is only called in the server realm. When in multiplayer, the hook will be called on both the server and the client in order to allow for [Prediction](https://wiki.facepunch.com/gmod/Prediction).

You can force the hook to always be called on client like this:

```lua
if ( game.SinglePlayer() ) then self:CallOnClient( "PrimaryAttack" ) end
```


Note that due to prediction, in multiplayer SWEP:PrimaryAttack is called multiple times per one "shot" with the gun. To work around that, use [IsFirstTimePredicted](https://wiki.facepunch.com/gmod/Global.IsFirstTimePredicted).

[wiki](https://wiki.facepunch.com/gmod/WEAPON:PrimaryAttack) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/shared.lua#L42-L60)

---

### SWEP:PrintWeaponInfo · Client · `hook`
`SWEP:PrintWeaponInfo(x: number, y: number, alpha: number)`

A convenience function that draws the weapon info box, used in [WEAPON:DrawWeaponSelection](https://wiki.facepunch.com/gmod/WEAPON:DrawWeaponSelection).

**Arguments:**
- `x` (number) — The x co-ordinate of box position
- `y` (number) — The y co-ordinate of box position
- `alpha` (number) — Alpha value for the box

[wiki](https://wiki.facepunch.com/gmod/WEAPON:PrintWeaponInfo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/cl_init.lua#L63-L89)

---

### SWEP:Reload · Shared · `hook` · `PREDICTED`
`SWEP:Reload()`

Called when the reload key ( +reload ) is pressed.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:Reload)

---

### SWEP:RenderScreen · Client · `hook`
`SWEP:RenderScreen()`

Called every frame just before [GM:RenderScene](https://wiki.facepunch.com/gmod/GM:RenderScene).

Used by the Tool Gun to render view model screens ([TOOL:DrawToolScreen](https://wiki.facepunch.com/gmod/TOOL:DrawToolScreen)).

> **Note:** Materials rendered in this hook require $ignorez parameter to draw properly.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:RenderScreen)

---

### SWEP:SecondaryAttack · Shared · `hook` · `PREDICTED`
`SWEP:SecondaryAttack()`

Called when secondary attack button ( +attack2 ) is pressed.

For issues with this hook being called rapidly on the client side, see the global function [IsFirstTimePredicted](https://wiki.facepunch.com/gmod/Global.IsFirstTimePredicted).

[wiki](https://wiki.facepunch.com/gmod/WEAPON:SecondaryAttack) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/shared.lua#L66-L84)

---

### SWEP:SetupDataTables · Shared · `hook`
`SWEP:SetupDataTables()`

Called when the SWEP should set up its [Data Tables](https://wiki.facepunch.com/gmod/Networking_Entities).

[wiki](https://wiki.facepunch.com/gmod/WEAPON:SetupDataTables)

---

### SWEP:SetWeaponHoldType · Shared · `hook`
`SWEP:SetWeaponHoldType(name: string)`

Sets the hold type of the weapon. This must be called on **both** the server and the client to work properly.

**Arguments:**
- `name` (string) — Name of the hold type.

> **Note:** You should avoid calling this function and call [Weapon:SetHoldType](https://wiki.facepunch.com/gmod/Weapon:SetHoldType) now.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:SetWeaponHoldType)

---

### SWEP:ShootBullet · Shared · `hook`
`SWEP:ShootBullet(damage: number, num_bullets: number, aimcone: number, ammo_type: string = self.Primary.Ammo, force: number = 1, tracer: number = 5)`

A convenient function to shoot bullets.

**Arguments:**
- `damage` (number) — The damage of the bullet
- `num_bullets` (number) — Amount of bullets to shoot
- `aimcone` (number) — Spread of bullets
- `ammo_type` (string, default `self.Primary.Ammo`) — Ammo type of the bullets
- `force` (number, default `1`) — Force of the bullets
- `tracer` (number, default `5`) — Show a tracer on every x bullets

[wiki](https://wiki.facepunch.com/gmod/WEAPON:ShootBullet) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/shared.lua#L132-L148)

---

### SWEP:ShootEffects · Shared · `hook`
`SWEP:ShootEffects()`

A convenience function to create shoot effects.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:ShootEffects) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/shared.lua#L122-L130)

---

### SWEP:ShouldDrawViewModel · Client · `hook`
`SWEP:ShouldDrawViewModel() → boolean`

Called to determine if the view model should be drawn or not.

**Returns:**
- boolean — Return true to draw the view model, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:ShouldDrawViewModel)

---

### SWEP:ShouldDropOnDie · Server · `hook`
`SWEP:ShouldDropOnDie() → boolean`

Should this weapon be dropped when its owner dies?

This only works if the player has [Player:ShouldDropWeapon](https://wiki.facepunch.com/gmod/Player:ShouldDropWeapon) set to true.

**Returns:**
- boolean — Return true to drop the weapon, false otherwise.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:ShouldDropOnDie)

---

### SWEP:TakePrimaryAmmo · Shared · `hook`
`SWEP:TakePrimaryAmmo(amount: number)`

A convenience function to remove primary ammo from clip.

**Arguments:**
- `amount` (number) — Amount of primary ammo to remove

[wiki](https://wiki.facepunch.com/gmod/WEAPON:TakePrimaryAmmo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/shared.lua#L162-L175)

---

### SWEP:TakeSecondaryAmmo · Shared · `hook`
`SWEP:TakeSecondaryAmmo(amount: number)`

A convenience function to remove secondary ammo from clip.

**Arguments:**
- `amount` (number) — How much of secondary ammo to remove

[wiki](https://wiki.facepunch.com/gmod/WEAPON:TakeSecondaryAmmo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/weapons/weapon_base/shared.lua#L181-L194)

---

### SWEP:Think · Shared · `hook` · `PREDICTED`
`SWEP:Think()`

Called when the weapon thinks.

This hook won't be called during the deploy animation and when using [Weapon:DefaultReload](https://wiki.facepunch.com/gmod/Weapon:DefaultReload). 



Despite being a predicted hook, this hook is called clientside in single player (for your convenience), however it will not be recognized as a predicted hook via [Player:GetCurrentCommand](https://wiki.facepunch.com/gmod/Player:GetCurrentCommand), and will run more often in this case.

This hook will be called before Player movement is processed on the client, and after on the server.

> **Note:** This hook only runs while the weapon is in players hands. It does not run while it is carried by an NPC.
> **Note:** If you wish for this hook to be called during the deploy animation, add the following to the model's **ACT_VM_DRAW** sequence: `node "Ready"`
> **Bug** ([#2855](https://github.com/Facepunch/garrysmod/issues/2855)): This will not be run during deploy animations after a serverside-only deploy. This usually happens after picking up and dropping an object with +use.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:Think)

---

### SWEP:Tick · Shared · `hook` · `DEPRECATED` · `PREDICTED`
`SWEP:Tick()`

Alias of [Weapon:Think](https://wiki.facepunch.com/gmod/Weapon:Think).

[wiki](https://wiki.facepunch.com/gmod/WEAPON:Tick)

---

### SWEP:TranslateActivity · Shared · `hook`
`SWEP:TranslateActivity(act: number{ACT}) → number{ACT}`

Translate a generic activity into a more specific activity, such as holdtype-specific activities.

The translated activity is then used to request animations from the owner's model via [Entity:SelectWeightedSequence](https://wiki.facepunch.com/gmod/Entity:SelectWeightedSequence) and similar functions.

For example, `ACT_MP_RUN` becomes `ACT_HL2MP_RUN_PISTOL`.

**Arguments:**
- `act` (number{ACT}) — The activity to translate

**Returns:**
- `act` (number{ACT}) — The translated activity

[wiki](https://wiki.facepunch.com/gmod/WEAPON:TranslateActivity)

---

### SWEP:TranslateFOV · Shared · `hook`
`SWEP:TranslateFOV(fov: number) → number`

Allows to change players field of view while player holds the weapon.

**Arguments:**
- `fov` (number) — The current/default FOV.

**Returns:**
- number — The target FOV.

> **Note:** This hook must be defined shared and return same value on both to properly affect Area Portals.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:TranslateFOV)

---

### SWEP:ViewModelDrawn · Client · `hook`
`SWEP:ViewModelDrawn(ViewModel: Entity, flags: number)`

Called straight after the view model has been drawn. This is called before [GM:PostDrawViewModel](https://wiki.facepunch.com/gmod/GM:PostDrawViewModel) and [WEAPON:PostDrawViewModel](https://wiki.facepunch.com/gmod/WEAPON:PostDrawViewModel).

See [WEAPON:DrawWorldModel](https://wiki.facepunch.com/gmod/WEAPON:DrawWorldModel) for world model rendering.

See also [WEAPON:PreDrawViewModel](https://wiki.facepunch.com/gmod/WEAPON:PreDrawViewModel) and [WEAPON:PostDrawViewModel](https://wiki.facepunch.com/gmod/WEAPON:PostDrawViewModel).

**Arguments:**
- `ViewModel` (Entity) — Players view model
- `flags` (number, enum [STUDIO](https://wiki.facepunch.com/gmod/Enums/STUDIO)) — The STUDIO_ flags for this render operation.

[wiki](https://wiki.facepunch.com/gmod/WEAPON:ViewModelDrawn)

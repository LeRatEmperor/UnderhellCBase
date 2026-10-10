# Vehicle

**Realm:** Shared  ·  **Members:** 49

This is a list of all methods only available for vehicles. It is also possible to call [Entity](https://wiki.facepunch.com/gmod/Entity) functions on vehicles.

[wiki page](https://wiki.facepunch.com/gmod/Vehicle)

### Vehicle:BoostTimeLeft · Server
`Vehicle:BoostTimeLeft() → number`

Returns the remaining boosting time left.

**Returns:**
- number — The remaining boosting time left

[wiki](https://wiki.facepunch.com/gmod/Vehicle:BoostTimeLeft)

---

### Vehicle:CheckExitPoint · Server
`Vehicle:CheckExitPoint(yaw: number, distance: number) → Vector`

Tries to find an Exit Point for leaving vehicle, if one is unobstructed in the direction given.

**Arguments:**
- `yaw` (number) — Yaw/roll from vehicle angle to check for exit
- `distance` (number) — Distance from origin to drop player

**Returns:**
- Vector — Returns the vector for exit position or nil if cannot exit that way.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:CheckExitPoint)

---

### Vehicle:EnableEngine · Server
`Vehicle:EnableEngine(enable: boolean)`

Sets whether the engine is enabled or disabled, i.e. can be started or not.

**Arguments:**
- `enable` (boolean) — Enable or disable the engine

[wiki](https://wiki.facepunch.com/gmod/Vehicle:EnableEngine)

---

### Vehicle:GetAmmo · Client
`Vehicle:GetAmmo() → number, number, number`

Returns information about the ammo of the vehicle

**Returns:**
- number — Ammo type of the vehicle ammo
- number — Clip size
- number — Count

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetAmmo)

---

### Vehicle:GetCameraDistance · Shared
`Vehicle:GetCameraDistance() → number`

Returns third person camera distance.

**Returns:**
- number — Camera distance

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetCameraDistance) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L683-L687)

---

### Vehicle:GetDriver · Shared
`Vehicle:GetDriver() → Entity`

Gets the driver of the vehicle, returns [NULL](https://wiki.facepunch.com/gmod/NULL) if no driver is present.

**Returns:**
- Entity — The driver of the vehicle.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetDriver)

---

### Vehicle:GetHLSpeed · Server
`Vehicle:GetHLSpeed() → number`

Returns the current speed of the vehicle in Half-Life Hammer Units (in/s). Same as [Entity:GetVelocity](https://wiki.facepunch.com/gmod/Entity:GetVelocity) + [Vector:Length](https://wiki.facepunch.com/gmod/Vector:Length).

**Returns:**
- number — The speed of the vehicle

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetHLSpeed)

---

### Vehicle:GetMaxSpeed · Server
`Vehicle:GetMaxSpeed() → number`

Returns the max speed of the vehicle in MPH.

**Returns:**
- number — The max speed of the vehicle in MPH

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetMaxSpeed)

---

### Vehicle:GetOperatingParams · Server
`Vehicle:GetOperatingParams() → table{OperatingParams}`

Returns some info about the vehicle.

**Returns:**
- table{OperatingParams} — The operating parameters.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetOperatingParams)

---

### Vehicle:GetPassenger · Shared
`Vehicle:GetPassenger(passenger: number) → Entity`

Gets the passenger of the vehicle, returns [NULL](https://wiki.facepunch.com/gmod/NULL) if no drivers is present.

**Arguments:**
- `passenger` (number) — The index of the passenger ( 0 is the driver )

**Returns:**
- Entity — The passenger

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetPassenger)

---

### Vehicle:GetPassengerSeatPoint · Server
`Vehicle:GetPassengerSeatPoint(role: number) → Vector, Angle`

Returns the seat position and angle of a given passenger seat.

**Arguments:**
- `role` (number) — The passenger role.

**Returns:**
- Vector — The seat position in worldspace coordinates.
- Angle — The seat angle in worldspace coordinates.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetPassengerSeatPoint)

---

### Vehicle:GetRPM · Server
`Vehicle:GetRPM() → number`

Returns the current RPM of the vehicle. This value is fake and doesn't actually affect the vehicle movement.

**Returns:**
- number — The RPM.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetRPM)

---

### Vehicle:GetSpeed · Server
`Vehicle:GetSpeed() → number`

Returns the current speed of the vehicle in MPH.

**Returns:**
- number — The speed of the vehicle in MPH

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetSpeed)

---

### Vehicle:GetSteering · Server
`Vehicle:GetSteering() → number`

Returns the current steering of the vehicle.

**Returns:**
- number — The current steering of the vehicle.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetSteering)

---

### Vehicle:GetSteeringDegrees · Server
`Vehicle:GetSteeringDegrees() → number`

Returns the maximum steering degree of the vehicle

**Returns:**
- number — The maximum steering degree of the vehicle

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetSteeringDegrees)

---

### Vehicle:GetThirdPersonMode · Shared
`Vehicle:GetThirdPersonMode() → boolean`

Returns if vehicle has thirdperson mode enabled or not.

**Returns:**
- boolean — Returns `true` if third person mode enabled, `false` otherwise

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetThirdPersonMode) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L696-L700)

---

### Vehicle:GetThrottle · Server
`Vehicle:GetThrottle() → number`

Returns the current throttle of the vehicle.

**Returns:**
- number — The current throttle of the vehicle

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetThrottle)

---

### Vehicle:GetVehicleClass · Shared
`Vehicle:GetVehicleClass() → string`

Returns the vehicle class name. This is only useful for Sandbox spawned vehicles or any vehicle that properly sets the vehicle class with [Vehicle:SetVehicleClass](https://wiki.facepunch.com/gmod/Vehicle:SetVehicleClass).

**Returns:**
- string — The class name of the vehicle.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetVehicleClass) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L684-L688)

---

### Vehicle:GetVehicleParams · Server
`Vehicle:GetVehicleParams() → table{VehicleParams}`

Returns the vehicle parameters of given vehicle.

**Returns:**
- table{VehicleParams} — The vehicle parameters.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetVehicleParams)

---

### Vehicle:GetVehicleViewPosition · Shared
`Vehicle:GetVehicleViewPosition(role: number = 0) → Vector, Angle, number`

Returns the view position and forward angle of a given passenger seat.

**Arguments:**
- `role` (number, default `0`) — The passenger role.

**Returns:**
- Vector — The view position, will be 0, 0, 0 on failure
- Angle — The view angles, will be 0, 0, 0 on failure
- number — The field of view, will be 0 on failure

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetVehicleViewPosition)

---

### Vehicle:GetWheel · Server
`Vehicle:GetWheel(wheel: number) → PhysObj`

Returns the [PhysObj](https://wiki.facepunch.com/gmod/PhysObj) of given wheel.

**Arguments:**
- `wheel` (number) — The wheel to retrieve

**Returns:**
- PhysObj — The wheel

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetWheel)

---

### Vehicle:GetWheelBaseHeight · Server
`Vehicle:GetWheelBaseHeight(wheel: number) → number`

Returns the base wheel height.

**Arguments:**
- `wheel` (number) — The wheel to get the base wheel height of.

**Returns:**
- number — The base wheel height.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetWheelBaseHeight)

---

### Vehicle:GetWheelContactPoint · Server
`Vehicle:GetWheelContactPoint(wheel: number) → Vector, number, boolean`

Returns the wheel contact point.

**Arguments:**
- `wheel` (number) — The wheel to check

**Returns:**
- Vector — The contact position
- number — The Surface Properties ID of hit surface.
- boolean — Whether the wheel is on ground or not

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetWheelContactPoint)

---

### Vehicle:GetWheelCount · Server
`Vehicle:GetWheelCount() → number`

Returns the wheel count of the vehicle

**Returns:**
- number — The amount of wheels

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetWheelCount)

---

### Vehicle:GetWheelTotalHeight · Server
`Vehicle:GetWheelTotalHeight(wheel: number) → number`

Returns the total wheel height.

**Arguments:**
- `wheel` (number) — The wheel to get the base wheel height of.

**Returns:**
- number — The total wheel height.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:GetWheelTotalHeight)

---

### Vehicle:HasBoost · Server
`Vehicle:HasBoost() → boolean`

Returns whether this vehicle has boost at all.

**Returns:**
- boolean — Whether this vehicle has boost at all.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:HasBoost)

---

### Vehicle:HasBrakePedal · Server
`Vehicle:HasBrakePedal() → boolean`

Returns whether this vehicle has a brake pedal. See [Vehicle:SetHasBrakePedal](https://wiki.facepunch.com/gmod/Vehicle:SetHasBrakePedal).

**Returns:**
- boolean — Whether this vehicle has a brake pedal or not.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:HasBrakePedal)

---

### Vehicle:IsBoosting · Server
`Vehicle:IsBoosting() → boolean`

Returns whether this vehicle is currently boosting or not.

**Returns:**
- boolean — Whether this vehicle is currently boosting or not.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:IsBoosting)

---

### Vehicle:IsEngineEnabled · Server
`Vehicle:IsEngineEnabled() → boolean`

Returns whether the engine is enabled or not, i.e. whether it can be started.

**Returns:**
- boolean — Whether the engine is enabled

[wiki](https://wiki.facepunch.com/gmod/Vehicle:IsEngineEnabled)

---

### Vehicle:IsEngineStarted · Server
`Vehicle:IsEngineStarted() → boolean`

Returns whether the engine is started or not.

**Returns:**
- boolean — Whether the engine is started or not.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:IsEngineStarted)

---

### Vehicle:IsValidVehicle · Shared
`Vehicle:IsValidVehicle() → boolean`

Determines whether a given [Vehicle](https://wiki.facepunch.com/gmod/Vehicle) is fully initialized.

It is possible, in uncommon circumstances, for a [valid](https://wiki.facepunch.com/gmod/Global.IsValid) [vehicle](https://wiki.facepunch.com/gmod/Entity:IsVehicle) entity to be in an invalid state, such as before [Entity:Spawn](https://wiki.facepunch.com/gmod/Entity:Spawn) is called on the vehicle after creation.

If this function returns `false`, then the [Vehicle](https://wiki.facepunch.com/gmod/Vehicle) functions are not usable on this vehicle, while [Entity](https://wiki.facepunch.com/gmod/Entity) functions are.

**Returns:**
- boolean — `true` if the Vehicle is in a valid state, or `false` if the Vehicle is in an invalid state.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:IsValidVehicle)

---

### Vehicle:IsVehicleBodyInWater · Server
`Vehicle:IsVehicleBodyInWater() → boolean`

Returns whether this vehicle's engine is underwater or not. ( Internally the attachment point "engine" or "vehicle_engine" is checked )

**Returns:**
- boolean — Whether this vehicle's engine is underwater or not.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:IsVehicleBodyInWater)

---

### Vehicle:ReleaseHandbrake · Server
`Vehicle:ReleaseHandbrake()`

Releases the vehicle's handbrake (Jeep) so it can roll without any passengers.

This will be overwritten if the vehicle has a driver. Same as [Vehicle:SetHandbrake](https://wiki.facepunch.com/gmod/Vehicle:SetHandbrake)( false )

[wiki](https://wiki.facepunch.com/gmod/Vehicle:ReleaseHandbrake)

---

### Vehicle:SetBoost · Server
`Vehicle:SetBoost(boost: number)`

Sets the boost. It is possible that this function does not work while the vehicle has a valid driver in it.

**Arguments:**
- `boost` (number) — The new boost value

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetBoost)

---

### Vehicle:SetCameraDistance · Shared
`Vehicle:SetCameraDistance(distance: number)`

Sets the third person camera distance of the vehicle.

**Arguments:**
- `distance` (number) — Camera distance to set to

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetCameraDistance) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L677-L681)

---

### Vehicle:SetHandbrake · Server
`Vehicle:SetHandbrake(handbrake: boolean)`

Turns on or off the Jeep handbrake so it can roll without a driver inside.

Does nothing while the vehicle has a driver in it.

**Arguments:**
- `handbrake` (boolean) — true to turn on, false to turn off.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetHandbrake)

---

### Vehicle:SetHasBrakePedal · Server
`Vehicle:SetHasBrakePedal(brakePedal: boolean)`

Sets whether this vehicle has a brake pedal.

**Arguments:**
- `brakePedal` (boolean) — Whether this vehicle has a brake pedal

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetHasBrakePedal)

---

### Vehicle:SetMaxReverseThrottle · Server
`Vehicle:SetMaxReverseThrottle(maxRevThrottle: number)`

Sets maximum reverse throttle

**Arguments:**
- `maxRevThrottle` (number) — The new maximum throttle.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetMaxReverseThrottle)

---

### Vehicle:SetMaxThrottle · Server
`Vehicle:SetMaxThrottle(maxThrottle: number)`

Sets maximum forward throttle

**Arguments:**
- `maxThrottle` (number) — The new maximum throttle.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetMaxThrottle)

---

### Vehicle:SetSpringLength · Server
`Vehicle:SetSpringLength(wheel: number, length: number)`

Sets spring length of given wheel

**Arguments:**
- `wheel` (number) — The wheel to change spring length of
- `length` (number) — The new spring length

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetSpringLength)

---

### Vehicle:SetSteering · Server
`Vehicle:SetSteering(front: number, rear: number)`

Sets the steering of the vehicle.

**Arguments:**
- `front` (number) — Angle of the front wheels (-1 to 1)
- `rear` (number) — Angle of the rear wheels (-1 to 1)

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetSteering)

---

### Vehicle:SetSteeringDegrees · Server
`Vehicle:SetSteeringDegrees(steeringDegrees: number)`

Sets the maximum steering degrees of the vehicle

**Arguments:**
- `steeringDegrees` (number) — The new maximum steering degree

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetSteeringDegrees)

---

### Vehicle:SetThirdPersonMode · Shared
`Vehicle:SetThirdPersonMode(enable: boolean)`

Sets the third person mode state.

**Arguments:**
- `enable` (boolean) — Enable or disable the third person mode for this vehicle

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetThirdPersonMode) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L665-L669)

---

### Vehicle:SetThrottle · Server
`Vehicle:SetThrottle(throttle: number)`

Sets the throttle of the vehicle. It is possible that this function does not work with a valid driver in it.

**Arguments:**
- `throttle` (number) — The new throttle.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetThrottle)

---

### Vehicle:SetVehicleClass · Shared · `INTERNAL`
`Vehicle:SetVehicleClass(class: string)`

Sets the vehicle class name.

**Arguments:**
- `class` (string) — The vehicle class name to set

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetVehicleClass) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity.lua#L678-L682)

---

### Vehicle:SetVehicleEntryAnim · Server
`Vehicle:SetVehicleEntryAnim(bOn: boolean)`

Sets whether the entry or exit camera animation should be played or not.

**Arguments:**
- `bOn` (boolean) — Whether the entry or exit camera animation should be played or not.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetVehicleEntryAnim)

---

### Vehicle:SetVehicleParams · Server
`Vehicle:SetVehicleParams(params: table)`

Sets the vehicle parameters for given vehicle.

**Arguments:**
- `params` (table) — The new new vehicle parameters.

> **Note:** Not all variables from the [Structures/VehicleParams](https://wiki.facepunch.com/gmod/Structures/VehicleParams) can be set.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetVehicleParams)

---

### Vehicle:SetWheelFriction · Server
`Vehicle:SetWheelFriction(wheel: number, friction: number)`

Sets friction of given wheel.  This function may be broken.

**Arguments:**
- `wheel` (number) — The wheel to change the friction of
- `friction` (number) — The new friction to set

[wiki](https://wiki.facepunch.com/gmod/Vehicle:SetWheelFriction)

---

### Vehicle:StartEngine · Server
`Vehicle:StartEngine(start: boolean)`

Starts or stops the engine.

**Arguments:**
- `start` (boolean) — True to start, false to stop.

[wiki](https://wiki.facepunch.com/gmod/Vehicle:StartEngine)

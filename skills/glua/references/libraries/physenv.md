# physenv

**Realm:** Shared  ·  **Members:** 10

The physenv library allows you to control the physics environment created by the engine, and lets you modify constants such as gravity and maximum velocity.

[wiki page](https://wiki.facepunch.com/gmod/physenv)

### physenv.AddSurfaceData · Shared
`physenv.AddSurfaceData(properties: string)`

Adds a [material surface property](https://developer.valvesoftware.com/wiki/Material_surface_properties) type to the game's physics environment.

See [util.GetSurfaceData](https://wiki.facepunch.com/gmod/util.GetSurfaceData) for the opposite function.

**Arguments:**
- `properties` (string) — The properties to add.

> **Bug** ([#2604](https://github.com/Facepunch/garrysmod/issues/2604)): The game has a limit of 128 surface properties - this includes properties loaded automatically from [surfaceproperties.txt](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/scripts/surfaceproperties.txt). Due to this, there's only a small amount of open slots that can be registered with GMod's provided surfaceproperties.txt.
> 
> Does nothing on `x86-64` beta.

[wiki](https://wiki.facepunch.com/gmod/physenv.AddSurfaceData)

---

### physenv.GetAirDensity · Shared
`physenv.GetAirDensity() → number`

Returns the air density used to calculate drag on physics objects.

**Returns:**
- `airDensity` (number) — Default value is 2.

[wiki](https://wiki.facepunch.com/gmod/physenv.GetAirDensity)

---

### physenv.GetGravity · Shared
`physenv.GetGravity() → Vector`

Gets the gravitational acceleration used for physics objects in `source_unit/s^2`.

**Returns:**
- Vector — Gravity direction and strength.

[wiki](https://wiki.facepunch.com/gmod/physenv.GetGravity)

---

### physenv.GetLastSimulationTime · Shared
`physenv.GetLastSimulationTime() → number`

Returns the last simulation duration of the in-game physics.

**Returns:**
- number — The last simulation duration of the in-game physics in seconds

[wiki](https://wiki.facepunch.com/gmod/physenv.GetLastSimulationTime)

---

### physenv.GetPerformanceSettings · Shared
`physenv.GetPerformanceSettings() → table`

Gets the current performance settings in table form.

**Returns:**
- table — Performance settings or nil if called too early.

[wiki](https://wiki.facepunch.com/gmod/physenv.GetPerformanceSettings)

---

### physenv.GetPhysicsPaused · Shared
`physenv.GetPhysicsPaused() → boolean`

Returns the pause status of global physics simulation. See [physenv.SetPhysicsPaused](https://wiki.facepunch.com/gmod/physenv.SetPhysicsPaused) for the setter.

**Returns:**
- boolean — `true` if paused.

[wiki](https://wiki.facepunch.com/gmod/physenv.GetPhysicsPaused)

---

### physenv.SetAirDensity · Shared
`physenv.SetAirDensity(airDensity: number)`

Sets the air density.

**Arguments:**
- `airDensity` (number) — The new air density.

[wiki](https://wiki.facepunch.com/gmod/physenv.SetAirDensity)

---

### physenv.SetGravity · Shared
`physenv.SetGravity(gravAccel: Vector)`

Sets the gravitational acceleration used for physics objects. Does not affect players.

**Arguments:**
- `gravAccel` (Vector) — The new gravity in `source_unit/s^2`.

[wiki](https://wiki.facepunch.com/gmod/physenv.SetGravity)

---

### physenv.SetPerformanceSettings · Shared
`physenv.SetPerformanceSettings(performanceSettings: table)`

Sets the performance settings.

**Arguments:**
- `performanceSettings` (table) — The new performance settings.

[wiki](https://wiki.facepunch.com/gmod/physenv.SetPerformanceSettings)

---

### physenv.SetPhysicsPaused · Shared
`physenv.SetPhysicsPaused(pause: boolean)`

Pauses or unpauses the physics simulation globally. See [physenv.GetPhysicsPaused](https://wiki.facepunch.com/gmod/physenv.GetPhysicsPaused) for the getter.

**Arguments:**
- `pause` (boolean) — `true` to pause, `false` to unpause.

[wiki](https://wiki.facepunch.com/gmod/physenv.SetPhysicsPaused)

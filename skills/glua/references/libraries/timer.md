# timer

**Realm:** Shared, Menu  ·  **Members:** 14

The timer library is a very useful set of functions which allow you to run a function periodically or after a given delay.

[wiki page](https://wiki.facepunch.com/gmod/timer)

### timer.Adjust · Shared, Menu
`timer.Adjust(identifier: any, delay: number, repetitions: number = nil, func: function = nil) → boolean`

Adjusts a previously created ([timer.Create](https://wiki.facepunch.com/gmod/timer.Create)) timer with the given identifier.

**Arguments:**
- `identifier` (any) — Identifier of the timer to adjust.
- `delay` (number) — The delay interval in seconds.
- `repetitions` (number, default `nil`) — Repetitions.
- `func` (function, default `nil`) — The new function.

**Returns:**
- boolean — `true` if succeeded.

[wiki](https://wiki.facepunch.com/gmod/timer.Adjust)

---

### timer.Check · Shared, Menu · `DEPRECATED`
`timer.Check()`

This function does nothing.

[wiki](https://wiki.facepunch.com/gmod/timer.Check)

---

### timer.Create · Shared, Menu
`timer.Create(identifier: string, delay: number, repetitions: number, func: function)`

Creates a new timer that will repeat its function given amount of times.
This function also requires the timer to be named, which allows you to control it after it was created via the [timer](https://wiki.facepunch.com/gmod/timer).

For a simple one-time timer with no identifiers, see [timer.Simple](https://wiki.facepunch.com/gmod/timer.Simple).

**Arguments:**
- `identifier` (string) — Identifier of the timer to create.
- `delay` (number) — The delay interval in seconds.
- `repetitions` (number) — The number of times to repeat the timer.
- `func` (function) — Function called when timer has finished the countdown.

> **Warning:** Timers use [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime) internally. Due to this, they won't advance while the client is timing out from the server or on an empty dedicated server due to hibernation. (unless `sv_hibernate_think` is set to `1` or `delay` is set to `0` ).

[wiki](https://wiki.facepunch.com/gmod/timer.Create)

---

### timer.Destroy · Shared, Menu · `DEPRECATED`
`timer.Destroy(identifier: string)`

Stops and destroys the given timer. Alias of [timer.Remove](https://wiki.facepunch.com/gmod/timer.Remove).

**Arguments:**
- `identifier` (string) — Identifier of the timer to destroy.

[wiki](https://wiki.facepunch.com/gmod/timer.Destroy)

---

### timer.Exists · Shared, Menu
`timer.Exists(identifier: string) → boolean`

Returns whenever the given timer exists or not.

For debugging purposes you can use the following commands:
* `lua_dumptimers_cl`
* `lua_dumptimers_sv`
* `lua_dumptimers_menu`

These will list all active timers in each realm.

**Arguments:**
- `identifier` (string) — Identifier of the timer.

**Returns:**
- boolean — Returns true if the timer exists, false if it doesn't

[wiki](https://wiki.facepunch.com/gmod/timer.Exists)

---

### timer.Pause · Shared, Menu
`timer.Pause(identifier: any) → boolean`

Pauses the given timer.

**Arguments:**
- `identifier` (any) — Identifier of the timer.

**Returns:**
- boolean — false if the timer didn't exist or was already paused, true otherwise.

[wiki](https://wiki.facepunch.com/gmod/timer.Pause)

---

### timer.Remove · Shared, Menu
`timer.Remove(identifier: string)`

Stops and removes a timer created by [timer.Create](https://wiki.facepunch.com/gmod/timer.Create).

**Arguments:**
- `identifier` (string) — Identifier of the timer to remove.

> **Warning:** The timers are removed in the next frame! Keep this in mind when storing identifiers in variables.

[wiki](https://wiki.facepunch.com/gmod/timer.Remove)

---

### timer.RepsLeft · Shared, Menu
`timer.RepsLeft(identifier: any) → number`

Returns amount of repetitions/executions left before the timer destroys itself.

**Arguments:**
- `identifier` (any) — Identifier of the timer.

**Returns:**
- number — The amount of executions left.

[wiki](https://wiki.facepunch.com/gmod/timer.RepsLeft)

---

### timer.Simple · Shared, Menu
`timer.Simple(delay: number, func: function)`

Creates a simple timer that runs the given function after a specified delay.

For a more advanced version that you can control after creation, see [timer.Create](https://wiki.facepunch.com/gmod/timer.Create).

**Arguments:**
- `delay` (number) — How long until the function should be ran (in seconds).
- `func` (function) — The function to run after the specified delay.

> **Warning:** Timers use [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime) internally. Due to this, they won't advance while the client is timing out from the server or on an empty dedicated server due to hibernation. (unless `sv_hibernate_think` is set to `1`).
> **Warning:** A previous message on this page stated that a delay of 0 would run the function on the next tick. This was partially an invalid assumption, and the true behavior is dependent on where `timer.Simple(0, func)` is called relative to `GarrysMod::Lua::Libraries::Timer::DoSimpleTimers`.
> 
> 
> 
> - If called *before* `DoSimpleTimers`, the callback will be executed on the same frame.
> 
> - If called *during* `DoSimpleTimers`, the callback will be executed on the same frame. **Note that calling timer.Simple(0, func) recursively (ie. a function that calls **`timer.simple(0, itself)`**) can lead to a hang!**
> 
> - If called *after* `DoSimpleTimers`, the callback will be executed on the next frame.
> 
> For more information on hook execution order, see [Lua Hooks Order](https://wiki.facepunch.com/gmod/Lua%20Hooks%20Order).
> 
> As of a commit on [2026.1.5](https://commits.facepunch.com/574654), simple timers are queued to the next frame.
> 
> As of a commit on [2026.1.8](https://commits.facepunch.com/575132), only timers with the same callback function are queued to the next frame. [Source](https://github.com/Facepunch/garrysmod-issues/issues/6668#issuecomment-3725044829)

[wiki](https://wiki.facepunch.com/gmod/timer.Simple)

---

### timer.Start · Shared, Menu
`timer.Start(identifier: any) → boolean`

Restarts the given timer.

**Arguments:**
- `identifier` (any) — Identifier of the timer.

**Returns:**
- boolean — true if the timer exists, false if it doesn't.

> **Note:** Timers use [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime) for timing.
> **Warning:** Timers won't advance while the client is timing out from the server.

[wiki](https://wiki.facepunch.com/gmod/timer.Start)

---

### timer.Stop · Shared, Menu
`timer.Stop(identifier: any) → boolean`

Stops the given timer and rewinds it.

**Arguments:**
- `identifier` (any) — Identifier of the timer.

**Returns:**
- boolean — false if the timer didn't exist or was already stopped, true otherwise.

[wiki](https://wiki.facepunch.com/gmod/timer.Stop)

---

### timer.TimeLeft · Shared, Menu
`timer.TimeLeft(identifier: any) → number`

Returns amount of time left (in seconds) before the timer executes its function.

**Arguments:**
- `identifier` (any) — Identifier of the timer.

**Returns:**
- number — The amount of time left (in seconds).

> **Note:** If the timer is paused, the amount will be negative.

[wiki](https://wiki.facepunch.com/gmod/timer.TimeLeft)

---

### timer.Toggle · Shared, Menu
`timer.Toggle(identifier: any) → boolean`

Runs either [timer.Pause](https://wiki.facepunch.com/gmod/timer.Pause) or [timer.UnPause](https://wiki.facepunch.com/gmod/timer.UnPause) based on the timer's current status.

**Arguments:**
- `identifier` (any) — Identifier of the timer.

**Returns:**
- boolean — status of the timer.

[wiki](https://wiki.facepunch.com/gmod/timer.Toggle)

---

### timer.UnPause · Shared, Menu
`timer.UnPause(identifier: any) → boolean`

Unpauses the timer.

**Arguments:**
- `identifier` (any) — Identifier of the timer.

**Returns:**
- boolean — false if the timer didn't exist or was already running, true otherwise.

[wiki](https://wiki.facepunch.com/gmod/timer.UnPause)

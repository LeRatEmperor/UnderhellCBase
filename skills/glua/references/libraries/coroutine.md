# coroutine

**Realm:** Shared, Menu  ·  **Members:** 8

Coroutines are similar to threads, however they do not run simultaneously. They offer a way to split up tasks and dynamically pause & resume functions.

[wiki page](https://wiki.facepunch.com/gmod/coroutine)

### coroutine.create · Shared, Menu
`coroutine.create(func: function) → thread`

Creates a coroutine of the given function.

**Arguments:**
- `func` (function) — The function for the coroutine to use.

**Returns:**
- thread — The created coroutine.

[wiki](https://wiki.facepunch.com/gmod/coroutine.create)

---

### coroutine.isyieldable · Shared, Menu
`coroutine.isyieldable() → boolean`

Returns whether the running coroutine can yield.  
		A running coroutine is yieldable if it is not in the main thread, and it is not inside a non-yieldable C function.

**Returns:**
- `canyield` (boolean) — Returns true when the running coroutine can yield.

> **Note:** This is only available on the x86-64 versions, because of the difference in the LuaJIT version. [See here](jit.version)

[wiki](https://wiki.facepunch.com/gmod/coroutine.isyieldable)

---

### coroutine.resume · Shared, Menu
`coroutine.resume(coroutine: thread, args: vararg) → boolean, vararg`

Resumes the given coroutine and passes the given vararg to either the function arguments or the [coroutine.yield](https://wiki.facepunch.com/gmod/coroutine.yield) that is inside that function and returns whatever yield is called with the next time or by the final return in the function.

**Arguments:**
- `coroutine` (thread) — Coroutine to resume.
- `args` (vararg) — Arguments to be returned by coroutine.yield.

**Returns:**
- boolean — If the executed thread code had no errors occur within it.
- vararg — If an error occurred, this will be a string containing the error message.

[wiki](https://wiki.facepunch.com/gmod/coroutine.resume)

---

### coroutine.running · Shared, Menu
`coroutine.running() → thread`

Returns the active coroutine or nil if we are not within a coroutine.

**Returns:**
- thread — The active coroutine.

[wiki](https://wiki.facepunch.com/gmod/coroutine.running)

---

### coroutine.status · Shared, Menu
`coroutine.status(coroutine: thread) → string`

Returns the status of the coroutine passed to it, the possible statuses are "suspended", "running", and "dead".

**Arguments:**
- `coroutine` (thread) — Coroutine to check the status of.

**Returns:**
- string — The coroutine's status.

[wiki](https://wiki.facepunch.com/gmod/coroutine.status)

---

### coroutine.wait · Shared
`coroutine.wait(duration: number)`

Repeatedly yields the coroutine for the given duration before continuing. 

Only works inside a coroutine. Only useful in nextbot coroutine think function. 

This function uses [CurTime](https://wiki.facepunch.com/gmod/Global.CurTime) instead of [RealTime](https://wiki.facepunch.com/gmod/Global.RealTime).

**Arguments:**
- `duration` (number) — The number of seconds to wait.

[wiki](https://wiki.facepunch.com/gmod/coroutine.wait) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/coroutine.lua#L15-L26)

---

### coroutine.wrap · Shared, Menu
`coroutine.wrap(coroutine: function) → function`

Returns a function which calling is equivalent with calling [coroutine.resume](https://wiki.facepunch.com/gmod/coroutine.resume) with the coroutine and all extra parameters.

The values returned by the returned function only contain the values passed to the inner [coroutine.yield](https://wiki.facepunch.com/gmod/coroutine.yield) call and do not include the *no error* status that [coroutine.resume](https://wiki.facepunch.com/gmod/coroutine.resume) provides. In case of failure, an error is thrown instead.

**Arguments:**
- `coroutine` (function) — Coroutine to resume.

**Returns:**
- function

[wiki](https://wiki.facepunch.com/gmod/coroutine.wrap)

---

### coroutine.yield · Shared, Menu
`coroutine.yield(returnValue: vararg) → vararg`

Pauses the active coroutine and passes all additional variables to the call of [coroutine.resume](https://wiki.facepunch.com/gmod/coroutine.resume) that resumed the coroutine last time, and returns all additional variables that were passed to the previous call of resume.

**Arguments:**
- `returnValue` (vararg) — Arguments to be returned by the last call of coroutine.resume.

**Returns:**
- vararg — Arguments that were set previously by coroutine.resume.

[wiki](https://wiki.facepunch.com/gmod/coroutine.yield)

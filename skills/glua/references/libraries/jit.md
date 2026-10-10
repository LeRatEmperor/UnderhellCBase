# jit

**Realm:** Shared, Menu  ·  **Members:** 21

Library to work with the [LuaJIT](http://luajit.org/) functionality of gmod.

[wiki page](https://wiki.facepunch.com/gmod/jit)

### jit.arch · Shared, Menu
`jit.arch()`

[wiki](https://wiki.facepunch.com/gmod/jit.arch)

---

### jit.attach · Shared, Menu · `DEPRECATED`
`jit.attach(callback: function, event: string)`

You can attach callbacks to a number of compiler events with jit.attach. The callback can be called:

* when a function has been compiled to bytecode (`"bc"`);
* when trace recording starts or stops (`"trace"`);
* as a trace is being recorded (`"record"`);
* or when a trace exits through a side exit (`"texit"`).

Set a callback with `jit.attach(callback, "event")` and clear the same callback with `jit.attach(callback)`.
Only one callback can be active per event.

**Arguments:**
- `callback` (function) — The callback function.
- `event` (string) — The event to hook into.

> **Warning:** This function isn't officially documented on LuaJIT wiki, use it at your own risk.

[wiki](https://wiki.facepunch.com/gmod/jit.attach)

---

### jit.flush · Shared, Menu
`jit.flush()`

Flushes the whole cache of compiled code.

[wiki](https://wiki.facepunch.com/gmod/jit.flush)

---

### jit.off · Shared, Menu
`jit.off()`

Disables LuaJIT Lua compilation.

[wiki](https://wiki.facepunch.com/gmod/jit.off)

---

### jit.on · Shared, Menu
`jit.on()`

Enables LuaJIT Lua compilation.

[wiki](https://wiki.facepunch.com/gmod/jit.on)

---

### jit.opt.start · Shared, Menu
`jit.opt.start(args: vararg)`

JIT compiler optimization control. The opt sub-module provides the backend for the -O command line LuaJIT option.
You can also use it programmatically, e.g.:

```lua
jit.opt.start(2) -- same as -O2
jit.opt.start("-dce")
jit.opt.start("hotloop=10", "hotexit=2")
```

	A list of LuaJIT -O command line options can be found here(a table of various optimization levels are displayed towards the bottom of the page along with exactly which optimization options are enabled for each level): http://luajit.org/running.html

**Arguments:**
- `args` (vararg)

[wiki](https://wiki.facepunch.com/gmod/jit.opt.start)

---

### jit.os · Shared, Menu
`jit.os()`

[wiki](https://wiki.facepunch.com/gmod/jit.os)

---

### jit.status · Shared, Menu
`jit.status() → boolean, any`

Returns the status of the JIT compiler and the current optimizations enabled.

**Returns:**
- boolean — Is JIT enabled
- any — Strings for CPU-specific features and enabled optimizations

[wiki](https://wiki.facepunch.com/gmod/jit.status)

---

### jit.util.funcbc · Shared, Menu
`jit.util.funcbc(func: function, pos: number) → number, number`

Returns bytecode of a function at a position.

**Arguments:**
- `func` (function) — Function to retrieve bytecode from.
- `pos` (number) — Position of the bytecode to retrieve.

**Returns:**
- number — bytecode instruction
- number — bytecode opcode

> **Note:** This function only works for Lua defined functions.

[wiki](https://wiki.facepunch.com/gmod/jit.util.funcbc)

---

### jit.util.funcinfo · Shared, Menu
`jit.util.funcinfo(func: function, pos: number = 0) → table`

Retrieves LuaJIT information about a given function, similarly to [debug.getinfo](https://wiki.facepunch.com/gmod/debug.getinfo). Possible table fields:
* linedefined: as for [debug.getinfo](https://wiki.facepunch.com/gmod/debug.getinfo)
* lastlinedefined: as for [debug.getinfo](https://wiki.facepunch.com/gmod/debug.getinfo)
* params: the number of parameters the function takes
* stackslots: the number of stack slots the function's local variable use
* upvalues: the number of upvalues the function uses
* bytecodes: the number of bytecodes it the compiled function
* gcconsts: the number of garbage collectable constants
* nconsts: the number of lua_Number (double) constants
* children: Boolean representing whether the function creates closures
* currentline: as for [debug.getinfo](https://wiki.facepunch.com/gmod/debug.getinfo)
* isvararg: if the function is a vararg function
* source: as for [debug.getinfo](https://wiki.facepunch.com/gmod/debug.getinfo)
* loc: a string describing the source and currentline, like "<source>:<line>"
* ffid: the fast function id of the function (if it is one). In this case only upvalues above and addr below are valid
* addr: the address of the function (if it is not a Lua function). If it's a C function rather than a fast function, only upvalues above is valid*

**Arguments:**
- `func` (function) — Function or Proto to retrieve info about.
- `pos` (number, default `0`)

**Returns:**
- table — Information about the supplied function/proto.

[wiki](https://wiki.facepunch.com/gmod/jit.util.funcinfo)

---

### jit.util.funck · Shared, Menu · `DEPRECATED`
`jit.util.funck(func: function, index: number) → any`

Gets a constant at a certain index in a function.

**Arguments:**
- `func` (function) — Function to get constant from
- `index` (number) — Constant index (counting down from the top of the function at -1)

**Returns:**
- any — The constant found.

> **Note:** This function only works for Lua defined functions.
> **Note:** Numbers constants goes from 0 (included) to n-1, n being the value of nconsts in [jit.util.funcinfo](https://wiki.facepunch.com/gmod/jit.util.funcinfo) in other words, the consts goes from (nconsts-1) to -n
> **Warning:** This function isn't officially documented on LuaJIT wiki, use it at your own risk.

[wiki](https://wiki.facepunch.com/gmod/jit.util.funck)

---

### jit.util.funcuvname · Shared, Menu · `DEPRECATED`
`jit.util.funcuvname(func: function, index: number) → string`

Does the exact same thing as [debug.getupvalue](https://wiki.facepunch.com/gmod/debug.getupvalue) except it only returns the name, not the name and the object. The upvalue indexes also start at 0 rather than 1, so doing `jit.util.funcuvname(func, 0)` will get you the same name as `debug.getupvalue(func, 1)`

**Arguments:**
- `func` (function) — Function to get the upvalue indexed from
- `index` (number) — The upvalue index, starting from 0

**Returns:**
- string — The function returns nil if there is no upvalue with the given index, otherwise the name of the upvalue is returned

> **Warning:** This function isn't officially documented on LuaJIT wiki, use it at your own risk.

[wiki](https://wiki.facepunch.com/gmod/jit.util.funcuvname)

---

### jit.util.ircalladdr · Shared, Menu · `DEPRECATED`
`jit.util.ircalladdr(index: number) → number`

Previously got the address of a function from a set list of functions, but now always returns `0` as it is deprecated.

**Arguments:**
- `index` (number) — This argument is ignored.

**Returns:**
- number — Always returns `0`

[wiki](https://wiki.facepunch.com/gmod/jit.util.ircalladdr)

---

### jit.util.traceexitstub · Shared, Menu · `DEPRECATED`
`jit.util.traceexitstub(exitno: number) → number`

Grabs the address of a function based on it's trace exit number. Grabbed via [jit.attach](https://wiki.facepunch.com/gmod/jit.attach) (with the texit event).

**Arguments:**
- `exitno` (number) — exit number to retrieve exit stub address from (gotten via jit.attach with the texit event)

**Returns:**
- number — exitstub trace address

[wiki](https://wiki.facepunch.com/gmod/jit.util.traceexitstub)

---

### jit.util.traceinfo · Shared, Menu · `DEPRECATED`
`jit.util.traceinfo(trace: number) → table`

Return table fields:
* link (number): the linked trace (0 for link types: none, return, interpreter)
* nk (number): the lowest IR constant (???)
* nins (number): the next IR instruction (???)
* linktype (string): the link type (none, root, loop, tail-recursion, up-recursion, down-recursion, interpreter, return)
* nexit (number): number of snapshots (for use with [jit.util.tracesnap](https://wiki.facepunch.com/gmod/jit.util.tracesnap))

**Arguments:**
- `trace` (number) — trace index to retrieve info for (gotten via jit.attach)

**Returns:**
- table — trace info

[wiki](https://wiki.facepunch.com/gmod/jit.util.traceinfo)

---

### jit.util.traceir · Shared, Menu · `DEPRECATED`
`jit.util.traceir(tr: number, index: number) → number, number, number, number, number`

**Arguments:**
- `tr` (number)
- `index` (number)

**Returns:**
- number — m
- number — ot
- number — op1
- number — op2
- number — prev

[wiki](https://wiki.facepunch.com/gmod/jit.util.traceir)

---

### jit.util.tracek · Shared, Menu · `DEPRECATED`
`jit.util.tracek(tr: number, index: number) → any, number, number`

**Arguments:**
- `tr` (number)
- `index` (number)

**Returns:**
- any — k
- number — t
- number — slot; optional

[wiki](https://wiki.facepunch.com/gmod/jit.util.tracek)

---

### jit.util.tracemc · Shared, Menu · `DEPRECATED`
`jit.util.tracemc(tr: number) → string, number, number`

**Arguments:**
- `tr` (number)

**Returns:**
- string — mcode
- number — address
- number — loop

[wiki](https://wiki.facepunch.com/gmod/jit.util.tracemc)

---

### jit.util.tracesnap · Shared, Menu · `DEPRECATED`
`jit.util.tracesnap(tr: number, sn: number) → table`

Return table fields:
* 0 (ref) (number): first IR ref for the snapshot
* 1 (nslots) (number): the number of valid slots 
* all indexes except first 2 and last (there might not be any of these): the snapshot map
* last index in table (number): -16777216 (255 << 24)

**Arguments:**
- `tr` (number) — trace index to retrieve snapshot for (gotten via jit.attach)
- `sn` (number) — snapshot index for trace (starting from 0 to nexit - 1, nexit gotten via jit.util.traceinfo)

**Returns:**
- table — snapshot

[wiki](https://wiki.facepunch.com/gmod/jit.util.tracesnap)

---

### jit.version · Shared, Menu
`jit.version()`

[wiki](https://wiki.facepunch.com/gmod/jit.version)

---

### jit.version_num · Shared, Menu
`jit.version_num()`

[wiki](https://wiki.facepunch.com/gmod/jit.version_num)

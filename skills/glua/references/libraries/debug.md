# debug

**Realm:** Shared, Menu  ·  **Members:** 17

The debug library is intended to help you debug your scripts, however it also has several other powerful uses. Some builtin debug function were removed in GMod due to security reasons

[wiki page](https://wiki.facepunch.com/gmod/debug)

### debug.debug · Shared, Menu · `DEPRECATED`
`debug.debug()`

Enters an interactive mode with the user, running each string that the user enters. Using simple commands and other debug facilities, the user can inspect global and local variables, change their values, evaluate expressions, and so on. A line containing only the word cont finishes this function, so that the caller continues its execution.

* Commands for debug.debug are not lexically nested within any function, and so have no direct access to local variables.
* To exit this interactive mode, you can press Ctrl + Z then Enter OR type the word 'cont' on a single line and press enter.

> **Note:** This only works on the source dedicated server.

[wiki](https://wiki.facepunch.com/gmod/debug.debug)

---

### debug.getfenv · Shared, Menu · `DEPRECATED`
`debug.getfenv(object: table) → table`

Returns the environment of the passed object. This can be set with [debug.setfenv](https://wiki.facepunch.com/gmod/debug.setfenv).

**Arguments:**
- `object` (table) — Object to get environment of.

**Returns:**
- table — The environment.

[wiki](https://wiki.facepunch.com/gmod/debug.getfenv)

---

### debug.gethook · Shared, Menu · `DEPRECATED`
`debug.gethook(thread: thread = nil) → function, string, number`

Returns the current hook settings of the passed thread. The thread argument can be omitted. This is completely different to gamemode hooks. More information on hooks can be found at http://www.lua.org/pil/23.2.html. This function will simply return the function, mask, and count of the last called [debug.sethook](https://wiki.facepunch.com/gmod/debug.sethook).

**Arguments:**
- `thread` (thread, default `nil`) — Which thread to retrieve it's hook from, doesn't seem to actually work.

**Returns:**
- function — Hook function.
- string — Hook mask.
- number — Hook count.

[wiki](https://wiki.facepunch.com/gmod/debug.gethook)

---

### debug.getinfo · Shared, Menu
`debug.getinfo(funcOrStackLevel: function, fields: string = >flnSu, function: function|nil) → table`

Returns debug information about a function.

**Arguments:**
- `funcOrStackLevel` (function) — Takes either a function or a number representing the stack level as an argument.
- `fields` (string, default `>flnSu`) — A string whose characters specify the information to be retrieved.
- `function` (function|nil) — Function to use.

**Returns:**
- table — A table as a Structures/DebugInfo containing information about the function you passed.

[wiki](https://wiki.facepunch.com/gmod/debug.getinfo)

---

### debug.getlocal · Shared, Menu · `DEPRECATED`
`debug.getlocal(thread: thread = Current thread, level: number, index: number) → string, any`

Gets the name and value of a local variable indexed from the level.

**Arguments:**
- `thread` (thread, default `Current thread`) — The thread.
- `level` (number) — The level above the thread.
- `index` (number) — The variable's index you want to get.

**Returns:**
- string — The name of the variable.
- any — The value of the local variable.

> **Warning:** When a function has a tailcall return, you cannot access the locals of this function.

[wiki](https://wiki.facepunch.com/gmod/debug.getlocal)

---

### debug.getmetatable · Shared, Menu · `DEPRECATED`
`debug.getmetatable(object: any) → table`

Returns the metatable of an object. This function ignores the metatable's __metatable field.

**Arguments:**
- `object` (any) — The object to retrieve the metatable from.

**Returns:**
- table — The metatable of the given object.

[wiki](https://wiki.facepunch.com/gmod/debug.getmetatable)

---

### debug.getregistry · Shared, Menu · `DEPRECATED`
`debug.getregistry() → table`

Returns the internal Lua registry table.

The Lua registry is used by the engine and binary modules to create references to Lua values. The registry contains every global ran and used in the Lua environment. Avoid creating entries into the registry with a number as the key, as they are reserved for the reference system.

**Returns:**
- table — The Lua registry.

> **Warning:** Improper editing of the registry can result in unintended side effects, including crashing the game.

[wiki](https://wiki.facepunch.com/gmod/debug.getregistry) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L2-L19)

---

### debug.getupvalue · Shared, Menu · `DEPRECATED`
`debug.getupvalue(func: function, index: number) → string, any`

Used for getting variable values in an index from the passed function. This does nothing for C functions.

**Arguments:**
- `func` (function) — Function to get the upvalue indexed from.
- `index` (number) — The index in the upvalue array.

**Returns:**
- string — Name of the upvalue.
- any — Value of the upvalue.

[wiki](https://wiki.facepunch.com/gmod/debug.getupvalue)

---

### debug.setfenv · Shared, Menu · `DEPRECATED`
`debug.setfenv(object: any, env: table) → table`

Sets the environment of the passed object.  

Unlike [setfenv](https://wiki.facepunch.com/gmod/Global.setfenv), this also works on **any** userdata, allowing you to save data stored to it which can be accessed using [debug.getfenv](https://wiki.facepunch.com/gmod/debug.getfenv).  
Userdata seem to intentionally support this & setting/changing it does not affect anything (though unused by gmod / Entities and such don't this)  
This can be useful when trying to store data on a [IGModAudioChannel](https://wiki.facepunch.com/gmod/IGModAudioChannel), [Vector](https://wiki.facepunch.com/gmod/Vector), [Angle](https://wiki.facepunch.com/gmod/Angle) or any other that doesn't already allow you to store data on it.

**Arguments:**
- `object` (any) — Object to set environment of.
- `env` (table) — Environment to set.

**Returns:**
- table — The object.

[wiki](https://wiki.facepunch.com/gmod/debug.setfenv)

---

### debug.sethook · Shared, Menu · `DEPRECATED`
`debug.sethook(thread: thread, hook: function, mask: string, count: number)`

Sets the given function as a Lua hook. This is completely different to gamemode hooks. The thread argument can be completely omitted and calling this function with no arguments will remove the current hook. This is used by default for infinite loop detection. More information on hooks can be found at http://www.lua.org/pil/23.2.html and https://www.gammon.com.au/scripts/doc.php?lua=debug.sethook

Hooks are not always ran when code that has been compiled by LuaJIT's JIT compiler is being executed, this is due to Intermediate Representation internally storing constantly running bytecode for performance reasons.

**Arguments:**
- `thread` (thread) — Thread to set the hook on.
- `hook` (function) — Function for the hook to call.
- `mask` (string) — The hook's mask.
- `count` (number) — How often to call the hook (in instructions).

[wiki](https://wiki.facepunch.com/gmod/debug.sethook)

---

### debug.setlocal · Shared, Menu · `DEPRECATED`
`debug.setlocal(thread: thread = Current Thread, level: number, index: number, value: any = nil) → string`

Sets a local variable's value.

**Arguments:**
- `thread` (thread, default `Current Thread`) — The thread.
- `level` (number) — The level above the thread.
- `index` (number) — The variable's index you want to get.
- `value` (any, default `nil`) — The value to set the local to.

**Returns:**
- string — The name of the local variable if the local at the index exists, otherwise nil is returned.

[wiki](https://wiki.facepunch.com/gmod/debug.setlocal)

---

### debug.setmetatable · Shared, Menu · `DEPRECATED`
`debug.setmetatable(object: any, metatable: table) → boolean`

Sets the object's metatable. Unlike [setmetatable](https://wiki.facepunch.com/gmod/Global.setmetatable), this function works regardless of whether the first object passed is a valid table or not; this function even works on primitive datatypes such as numbers, functions, and even nil.

**Arguments:**
- `object` (any) — Object to set the metatable for.
- `metatable` (table) — The metatable to set for the object.

**Returns:**
- boolean — true if the object's metatable was set successfully.

[wiki](https://wiki.facepunch.com/gmod/debug.setmetatable)

---

### debug.setupvalue · Shared, Menu · `DEPRECATED`
`debug.setupvalue(func: function, index: number, val: any = nil) → string`

Sets the variable indexed from func.

**Arguments:**
- `func` (function) — The function to index the upvalue from.
- `index` (number) — The index from func.
- `val` (any, default `nil`) — The value to set the upvalue to.

**Returns:**
- string — Returns nil if there is no upvalue with the given index, otherwise it returns the upvalue's name.

[wiki](https://wiki.facepunch.com/gmod/debug.setupvalue)

---

### debug.Trace · Shared, Menu
`debug.Trace()`

Prints out the lua function call stack to the console.

[wiki](https://wiki.facepunch.com/gmod/debug.Trace) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/debug.lua#L24-L51)

---

### debug.traceback · Shared, Menu · `DEPRECATED`
`debug.traceback(thread: thread = current thread, message: string = nil, level: number = 1) → string`

Returns a full execution stack trace.

**Arguments:**
- `thread` (thread, default `current thread`) — Thread (ie.
- `message` (string, default `nil`) — Appended at the beginning of the traceback.
- `level` (number, default `1`) — Which level to start the traceback.

**Returns:**
- string — A dump of the execution stack.

[wiki](https://wiki.facepunch.com/gmod/debug.traceback)

---

### debug.upvalueid · Shared, Menu · `DEPRECATED`
`debug.upvalueid(func: function, index: number) → number`

Returns an unique identifier for the upvalue indexed from func.

**Arguments:**
- `func` (function) — The function to index the upvalue from.
- `index` (number) — The index from func.

**Returns:**
- number — A unique identifier.

[wiki](https://wiki.facepunch.com/gmod/debug.upvalueid)

---

### debug.upvaluejoin · Shared, Menu · `DEPRECATED`
`debug.upvaluejoin(func1: function, upvalueIndex1: number, func2: function, upvalueIndex2: number)`

Makes an upvalue of `func1` refer to an upvalue of `func2`. Both functions provided must be Lua-defined, otherwise an error is thrown.

**Arguments:**
- `func1` (function)
- `upvalueIndex1` (number) — The index of the upvalue in `func1`.
- `func2` (function)
- `upvalueIndex2` (number) — The index of the upvalue in `func2`.

[wiki](https://wiki.facepunch.com/gmod/debug.upvaluejoin)

# Task

**Realm:** Server  ·  **Members:** 9

A single AI task. Returned by [ai_task.New](https://wiki.facepunch.com/gmod/ai_task.New).

[wiki page](https://wiki.facepunch.com/gmod/Task)

### Task:Init · Server · `INTERNAL`
`Task:Init()`

Initialises the AI task. Called by [ai_task.New](https://wiki.facepunch.com/gmod/ai_task.New).

[wiki](https://wiki.facepunch.com/gmod/Task:Init) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_task.lua#L29-L31)

---

### Task:InitEngine · Server
`Task:InitEngine(taskname: string, taskdata: number)`

Initialises the AI task as an engine task.

**Arguments:**
- `taskname` (string) — The name of the task.
- `taskdata` (number)

[wiki](https://wiki.facepunch.com/gmod/Task:InitEngine) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_task.lua#L36-L43)

---

### Task:InitFunctionName · Server
`Task:InitFunctionName(startname: string, runname: string, taskdata: number)`

Initialises the AI task as NPC method-based.

**Arguments:**
- `startname` (string) — The name of the NPC method to call on task start.
- `runname` (string) — The name of the NPC method to call on task run.
- `taskdata` (number)

[wiki](https://wiki.facepunch.com/gmod/Task:InitFunctionName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_task.lua#L56)

---

### Task:IsEngineType · Server
`Task:IsEngineType()`

Determines if the task is an engine task (`TYPE_ENGINE`, 1).

[wiki](https://wiki.facepunch.com/gmod/Task:IsEngineType) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_task.lua#L67)

---

### Task:IsFNameType · Server
`Task:IsFNameType()`

Determines if the task is an NPC method-based task (`TYPE_FNAME`, 2).

[wiki](https://wiki.facepunch.com/gmod/Task:IsFNameType) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_task.lua#L75)

---

### Task:Run · Server
`Task:Run(target: NPC)`

Runs the AI task.

**Arguments:**
- `target` (NPC) — The NPC to run the task on.

[wiki](https://wiki.facepunch.com/gmod/Task:Run) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_task.lua#L112)

---

### Task:Run_FName · Server · `INTERNAL`
`Task:Run_FName(target: NPC)`

Runs the AI task as an NPC method. This requires the task to be of type `TYPE_FNAME`.

**Arguments:**
- `target` (NPC) — The NPC to run the task on.

[wiki](https://wiki.facepunch.com/gmod/Task:Run_FName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_task.lua#L125)

---

### Task:Start · Server
`Task:Start(target: NPC)`

Starts the AI task.

**Arguments:**
- `target` (NPC) — The NPC to start the task on.

[wiki](https://wiki.facepunch.com/gmod/Task:Start) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_task.lua#L83)

---

### Task:Start_FName · Server · `INTERNAL`
`Task:Start_FName(target: NPC)`

Starts the AI task as an NPC method.

**Arguments:**
- `target` (NPC) — The NPC to start the task on.

[wiki](https://wiki.facepunch.com/gmod/Task:Start_FName) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_task.lua#L99)

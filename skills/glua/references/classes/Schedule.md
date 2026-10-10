# Schedule

**Realm:** Server  ·  **Members:** 6

The object returned by [ai_schedule.New](https://wiki.facepunch.com/gmod/ai_schedule.New).

[wiki page](https://wiki.facepunch.com/gmod/Schedule)

### Schedule:AddTask · Server
`Schedule:AddTask(taskname: string, taskdata: any)`

Adds a task to the schedule. See also [Schedule:AddTaskEx](https://wiki.facepunch.com/gmod/Schedule:AddTaskEx) if you wish to customize task start and run function names.

See also [ENTITY:StartSchedule](https://wiki.facepunch.com/gmod/ENTITY:StartSchedule), [NPC:StartEngineTask](https://wiki.facepunch.com/gmod/NPC:StartEngineTask), and [NPC:RunEngineTask](https://wiki.facepunch.com/gmod/NPC:RunEngineTask).

**Arguments:**
- `taskname` (string) — Custom task name
- `taskdata` (any) — Task data to be passed into the NPC's functions

[wiki](https://wiki.facepunch.com/gmod/Schedule:AddTask) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_schedule.lua#L56-L62)

---

### Schedule:AddTaskEx · Server
`Schedule:AddTaskEx(start: string, run: string, data: number)`

Adds a task to the schedule with completely custom function names.

See also [Schedule:AddTask](https://wiki.facepunch.com/gmod/Schedule:AddTask).

**Arguments:**
- `start` (string) — The full name of a function on the entity's table to be ran when the task is started.
- `run` (string) — The full name of a function on the entity's table to be ran when the task is continuously running.
- `data` (number) — Task data to be passed into the NPC's functions

[wiki](https://wiki.facepunch.com/gmod/Schedule:AddTaskEx) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_schedule.lua#L70-L76)

---

### Schedule:EngTask · Server
`Schedule:EngTask(taskname: string, taskdata: number)`

Adds an engine task to the schedule.

**Arguments:**
- `taskname` (string) — Task name, see ai_task.h
- `taskdata` (number) — Task data, can be a float.

[wiki](https://wiki.facepunch.com/gmod/Schedule:EngTask) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_schedule.lua#L36-L42)

---

### Schedule:GetTask · Server
`Schedule:GetTask(num: number)`

Returns the task at the given index.

**Arguments:**
- `num` (number) — Task index.

[wiki](https://wiki.facepunch.com/gmod/Schedule:GetTask) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_schedule.lua#L82-L84)

---

### Schedule:Init · Server · `INTERNAL`
`Schedule:Init(debugName: string)`

Initialises the Schedule. Called by [ai_schedule.New](https://wiki.facepunch.com/gmod/ai_schedule.New) when the Schedule is created.

**Arguments:**
- `debugName` (string) — The name passed from ai_schedule.New.

[wiki](https://wiki.facepunch.com/gmod/Schedule:Init) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_schedule.lua#L21-L27)

---

### Schedule:NumTasks · Server
`Schedule:NumTasks() → number`

Returns the number of tasks in the schedule.

**Returns:**
- number — The number of tasks in this schedule.

[wiki](https://wiki.facepunch.com/gmod/Schedule:NumTasks) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/ai_schedule.lua#L78-L80)

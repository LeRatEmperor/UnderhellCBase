# ai

**Realm:** Server  ·  **Members:** 6

The ai library.

[wiki page](https://wiki.facepunch.com/gmod/ai)

### ai.GetNodeCount · Server
`ai.GetNodeCount() → number`

Returns the number of AI nodes on the map, used by the base game [NPC](https://wiki.facepunch.com/gmod/NPC)s.

For [NextBot](https://wiki.facepunch.com/gmod/NextBot)s, see [navmesh](https://wiki.facepunch.com/gmod/navmesh).

**Returns:**
- number — The node count.

[wiki](https://wiki.facepunch.com/gmod/ai.GetNodeCount)

---

### ai.GetScheduleID · Server
`ai.GetScheduleID(sched: string) → number`

Translates a schedule name to its corresponding ID.

**Arguments:**
- `sched` (string) — Then schedule name.

**Returns:**
- number — The schedule ID, see SCHED.

[wiki](https://wiki.facepunch.com/gmod/ai.GetScheduleID)

---

### ai.GetSquadLeader · Server
`ai.GetSquadLeader(squad: string) → NPC`

Returns the squad leader of the given squad.

**Arguments:**
- `squad` (string) — The squad name.

**Returns:**
- NPC — The squad leader.

[wiki](https://wiki.facepunch.com/gmod/ai.GetSquadLeader)

---

### ai.GetSquadMemberCount · Server
`ai.GetSquadMemberCount(squad: string) → number`

Returns the amount of members a given squad has. See also [ai.GetSquadMembers](https://wiki.facepunch.com/gmod/ai.GetSquadMembers).

**Arguments:**
- `squad` (string) — The squad name.

**Returns:**
- number — The member count.

[wiki](https://wiki.facepunch.com/gmod/ai.GetSquadMemberCount)

---

### ai.GetSquadMembers · Server
`ai.GetSquadMembers(squad: string) → table`

Returns all members of a given squad. See also [ai.GetSquadMemberCount](https://wiki.facepunch.com/gmod/ai.GetSquadMemberCount) and [NPC:GetSquad](https://wiki.facepunch.com/gmod/NPC:GetSquad).

**Arguments:**
- `squad` (string) — The squad name.

**Returns:**
- table — A table of NPCs in the given squad.

[wiki](https://wiki.facepunch.com/gmod/ai.GetSquadMembers)

---

### ai.GetTaskID · Server
`ai.GetTaskID(task: string) → number`

Translates a task name to its corresponding ID.

**Arguments:**
- `task` (string) — The task name.

**Returns:**
- number — The task ID, see ai_task.h.

[wiki](https://wiki.facepunch.com/gmod/ai.GetTaskID)

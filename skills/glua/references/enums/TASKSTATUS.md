# TASKSTATUS enumeration

**Realm:** Server  ·  **Constants:** 5

Used by [NPC:GetTaskStatus](https://wiki.facepunch.com/gmod/NPC:GetTaskStatus) and [NPC:SetTaskStatus](https://wiki.facepunch.com/gmod/NPC:SetTaskStatus).

[wiki page](https://wiki.facepunch.com/gmod/Enums/TASKSTATUS)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `TASKSTATUS_COMPLETE` | `4` | Server | Completed, get next task. |
| `TASKSTATUS_NEW` | `0` | Server | Just started |
| `TASKSTATUS_RUN_MOVE` | `2` | Server | Just running movement. |
| `TASKSTATUS_RUN_MOVE_AND_TASK` | `1` | Server | Running task & movement. |
| `TASKSTATUS_RUN_TASK` | `3` | Server | Just running task. |

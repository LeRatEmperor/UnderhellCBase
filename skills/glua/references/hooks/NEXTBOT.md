# NEXTBOT

**Realm:** Server  ·  **Members:** 17

The list of hooks for nextbot NPCs.

> **Using these hooks:** these are **method overrides**, not `hook.Add` events — define them as methods on your `NEXTBOT` table: `function NEXTBOT:<Name>(...) end`. The `NEXTBOT:` prefix shown on each member below is the method form you write.

### NEXTBOT:BehaveStart · Server · `hook`
`NEXTBOT:BehaveStart()`

Called to initialize the behaviour.

		This is called automatically when the NextBot is created, you should not call it manually.

> **Note:** You shouldn't override this unless you know what you are doing - it's used to kick off the [coroutine](https://wiki.facepunch.com/gmod/coroutine) that runs the bot's behaviour. See [NEXTBOT:RunBehaviour](https://wiki.facepunch.com/gmod/NEXTBOT:RunBehaviour) instead.

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:BehaveStart) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L2)

---

### NEXTBOT:BehaveUpdate · Server · `hook`
`NEXTBOT:BehaveUpdate(interval: number)`

Called to update the bot's behaviour. 

If you override this hook you must call `coroutine.resume(self.BehaveThread)` to resume the [NEXTBOT:RunBehaviour](https://wiki.facepunch.com/gmod/NEXTBOT:RunBehaviour) Behavior

**Arguments:**
- `interval` (number) — How long since the last update

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:BehaveUpdate) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L23)

---

### NEXTBOT:BodyUpdate · Server · `hook`
`NEXTBOT:BodyUpdate()`

Called to update the bot's animation.

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:BodyUpdate) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L52)

---

### NEXTBOT:OnContact · Server · `hook`
`NEXTBOT:OnContact(ent: Entity)`

Called when the nextbot touches another entity.

**Arguments:**
- `ent` (Entity) — The entity the nextbot came in contact with.

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:OnContact)

---

### NEXTBOT:OnEntitySight · Server · `hook`
`NEXTBOT:OnEntitySight(ent: Entity)`

Called when the nextbot NPC sees another Nextbot NPC or a Player.

**Arguments:**
- `ent` (Entity) — the entity that was seen

> **Note:** This hook will only run after [NextBot:SetFOV](https://wiki.facepunch.com/gmod/NextBot:SetFOV) or other vision related function is called on the nextbot. See [NextBot:IsAbleToSee](https://wiki.facepunch.com/gmod/NextBot:IsAbleToSee) for more details.

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:OnEntitySight)

---

### NEXTBOT:OnEntitySightLost · Server · `hook`
`NEXTBOT:OnEntitySightLost(ent: Entity)`

Called when the nextbot NPC loses sight of another Nextbot NPC or a Player.

**Arguments:**
- `ent` (Entity) — the entity that we lost sight of

> **Note:** This hook will only run after [NextBot:SetFOV](https://wiki.facepunch.com/gmod/NextBot:SetFOV) or other vision related function is called on the nextbot. See [NextBot:IsAbleToSee](https://wiki.facepunch.com/gmod/NextBot:IsAbleToSee) for more details.

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:OnEntitySightLost)

---

### NEXTBOT:OnIgnite · Server · `hook`
`NEXTBOT:OnIgnite()`

Called when the bot is ignited.

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:OnIgnite)

---

### NEXTBOT:OnInjured · Server · `hook`
`NEXTBOT:OnInjured(info: CTakeDamageInfo)`

Called when the bot gets hurt. This is a good place to play hurt sounds or voice lines.

**Arguments:**
- `info` (CTakeDamageInfo) — The damage info

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:OnInjured) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L130)

---

### NEXTBOT:OnKilled · Server · `hook`
`NEXTBOT:OnKilled(info: CTakeDamageInfo)`

Called when the bot gets killed.

**Arguments:**
- `info` (CTakeDamageInfo) — The damage info

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:OnKilled) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L140)

---

### NEXTBOT:OnLandOnGround · Server · `hook`
`NEXTBOT:OnLandOnGround(ent: Entity)`

Called when the bot's feet return to the ground.

**Arguments:**
- `ent` (Entity) — The entity the nextbot has landed on.

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:OnLandOnGround) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L94)

---

### NEXTBOT:OnLeaveGround · Server · `hook`
`NEXTBOT:OnLeaveGround(ent: Entity)`

Called when the bot's feet leave the ground - for whatever reason.

**Arguments:**
- `ent` (Entity) — The entity the bot "jumped" from.

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:OnLeaveGround) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L82)

---

### NEXTBOT:OnNavAreaChanged · Server · `hook`
`NEXTBOT:OnNavAreaChanged(old: CNavArea, new: CNavArea)`

Called when the nextbot enters a new navigation area.

**Arguments:**
- `old` (CNavArea) — The navigation area the bot just left
- `new` (CNavArea) — The navigation area the bot just entered

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:OnNavAreaChanged)

---

### NEXTBOT:OnOtherKilled · Server · `hook`
`NEXTBOT:OnOtherKilled(victim: Entity, info: CTakeDamageInfo)`

Called when someone else or something else has been killed.

**Arguments:**
- `victim` (Entity) — The victim that was killed
- `info` (CTakeDamageInfo) — The damage info

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:OnOtherKilled)

---

### NEXTBOT:OnStuck · Server · `hook`
`NEXTBOT:OnStuck()`

Called when the bot thinks it is stuck.

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:OnStuck) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L106)

---

### NEXTBOT:OnTraceAttack · Server · `hook`
`NEXTBOT:OnTraceAttack(info: CTakeDamageInfo, dir: Vector, trace: table)`

Called when a trace attack is done against the nextbot, allowing override of the damage being dealt by altering the [CTakeDamageInfo](https://wiki.facepunch.com/gmod/CTakeDamageInfo).

This is called before [NEXTBOT:OnInjured](https://wiki.facepunch.com/gmod/NEXTBOT:OnInjured).

**Arguments:**
- `info` (CTakeDamageInfo) — The damage info
- `dir` (Vector) — The direction the damage goes in
- `trace` (table) — The Structures/TraceResult of the attack, containing the hitgroup.

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:OnTraceAttack)

---

### NEXTBOT:OnUnStuck · Server · `hook`
`NEXTBOT:OnUnStuck()`

Called when the bot thinks it is un-stuck.

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:OnUnStuck) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/entities/entities/base_nextbot/sv_nextbot.lua#L118)

---

### NEXTBOT:RunBehaviour · Server · `hook`
`NEXTBOT:RunBehaviour()`

A hook called to process nextbot logic.

This hook runs in a [coroutine](https://wiki.facepunch.com/gmod/coroutine) by default. It will only be called if [NEXTBOT:BehaveStart](https://wiki.facepunch.com/gmod/NEXTBOT:BehaveStart) is not overriden.

[wiki](https://wiki.facepunch.com/gmod/NEXTBOT:RunBehaviour)

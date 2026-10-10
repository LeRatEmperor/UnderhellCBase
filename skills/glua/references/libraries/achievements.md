# achievements

**Realm:** Client, Menu  ·  **Members:** 16

This library is used internally by Garry's Mod to help keep track of achievement progress and unlock the appropriate achievements once a certain number is reached.

[wiki page](https://wiki.facepunch.com/gmod/achievements)

### achievements.BalloonPopped · Client · `INTERNAL`
`achievements.BalloonPopped()`

Adds one to the count of balloons burst. Once this count reaches 1000, the 'Popper' achievement is unlocked.

[wiki](https://wiki.facepunch.com/gmod/achievements.BalloonPopped)

---

### achievements.Count · Client, Menu
`achievements.Count() → number`

Returns the amount of achievements currently in Garry's Mod.

**Returns:**
- number — The amount of achievements available.

[wiki](https://wiki.facepunch.com/gmod/achievements.Count)

---

### achievements.EatBall · Client · `INTERNAL`
`achievements.EatBall()`

Adds one to the count of balls eaten. Once this count reaches 200, the 'Ball Eater' achievement is unlocked.

[wiki](https://wiki.facepunch.com/gmod/achievements.EatBall)

---

### achievements.GetCount · Client, Menu
`achievements.GetCount(achievementID: number) → number`

Retrieves progress of given achievement.

**Arguments:**
- `achievementID` (number) — The ID of the achievement.

**Returns:**
- number — The numerical progress.

[wiki](https://wiki.facepunch.com/gmod/achievements.GetCount)

---

### achievements.GetDesc · Client, Menu
`achievements.GetDesc(achievementID: number) → string`

Retrieves the description of the given achievement.

**Arguments:**
- `achievementID` (number) — The ID of the achievement.

**Returns:**
- string — The description.

[wiki](https://wiki.facepunch.com/gmod/achievements.GetDesc)

---

### achievements.GetGoal · Client, Menu
`achievements.GetGoal(achievementID: number) → number`

Retrieves the end progress goal of the given achievement.

**Arguments:**
- `achievementID` (number) — The ID of the achievement.

**Returns:**
- number — The end progress goal.

[wiki](https://wiki.facepunch.com/gmod/achievements.GetGoal)

---

### achievements.GetName · Client, Menu
`achievements.GetName(achievementID: number) → string`

Retrieves the name of the given achievement.

**Arguments:**
- `achievementID` (number) — The ID of the achievement.

**Returns:**
- string — The name.

[wiki](https://wiki.facepunch.com/gmod/achievements.GetName)

---

### achievements.IncBaddies · Client · `INTERNAL`
`achievements.IncBaddies()`

Adds one to the count of baddies killed. Once this count reaches 1000, the 'War Zone' achievement is unlocked.

[wiki](https://wiki.facepunch.com/gmod/achievements.IncBaddies)

---

### achievements.IncBystander · Client · `INTERNAL`
`achievements.IncBystander()`

Adds one to the count of innocent animals killed. Once this count reaches 1000, the 'Innocent Bystander' achievement is unlocked.

[wiki](https://wiki.facepunch.com/gmod/achievements.IncBystander)

---

### achievements.IncGoodies · Client · `INTERNAL`
`achievements.IncGoodies()`

Adds one to the count of friendly NPCs killed. Once this count reaches 1000, the 'Bad Friend' achievement is unlocked.

[wiki](https://wiki.facepunch.com/gmod/achievements.IncGoodies)

---

### achievements.IsAchieved · Client, Menu
`achievements.IsAchieved(achievementID: number) → boolean`

Returns whether the given achievement is obtained or not.

**Arguments:**
- `achievementID` (number) — The ID of the achievement.

**Returns:**
- boolean — The state.

[wiki](https://wiki.facepunch.com/gmod/achievements.IsAchieved)

---

### achievements.Remover · Client · `INTERNAL`
`achievements.Remover()`

Adds one to the count of things removed. Once this count reaches 5000, the 'Destroyer' achievement is unlocked.

[wiki](https://wiki.facepunch.com/gmod/achievements.Remover)

---

### achievements.SpawnedNPC · Client · `INTERNAL`
`achievements.SpawnedNPC()`

Adds one to the count of NPCs spawned. Once this count reaches 1000, the 'Procreator' achievement is unlocked.

[wiki](https://wiki.facepunch.com/gmod/achievements.SpawnedNPC)

---

### achievements.SpawnedProp · Client · `INTERNAL`
`achievements.SpawnedProp()`

Adds one to the count of props spawned. Once this count reaches 5000, the 'Creator' achievement is unlocked.

[wiki](https://wiki.facepunch.com/gmod/achievements.SpawnedProp)

---

### achievements.SpawnedRagdoll · Client · `INTERNAL`
`achievements.SpawnedRagdoll()`

Adds one to the count of ragdolls spawned. Once this count reaches 2000, the 'Dollhouse' achievement is unlocked.

[wiki](https://wiki.facepunch.com/gmod/achievements.SpawnedRagdoll)

---

### achievements.SpawnMenuOpen · Client · `INTERNAL`
`achievements.SpawnMenuOpen()`

Adds one to the count of how many times the spawnmenu has been opened. Once this count reaches 100,000, the 'Menu User' achievement is unlocked.

[wiki](https://wiki.facepunch.com/gmod/achievements.SpawnMenuOpen)

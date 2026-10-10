# SCHED enumeration

**Realm:** Server  ·  **Constants:** 89

Enumerations for NPC schedules, used by [ENTITY:StartEngineSchedule](https://wiki.facepunch.com/gmod/ENTITY:StartEngineSchedule), [ENTITY:TranslateSchedule](https://wiki.facepunch.com/gmod/ENTITY:TranslateSchedule) and [NPC:SetSchedule](https://wiki.facepunch.com/gmod/NPC:SetSchedule). Serverside only.

[wiki page](https://wiki.facepunch.com/gmod/Enums/SCHED)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `LAST_SHARED_SCHEDULE` | `88` | Server | The schedule enum limit |
| `SCHED_AISCRIPT` | `56` | Server | Begins AI script based on NPC's `m_hCine` save value. |
| `SCHED_ALERT_FACE` | `5` | Server | Idle stance and face ideal yaw angles. |
| `SCHED_ALERT_FACE_BESTSOUND` | `6` | Server |  |
| `SCHED_ALERT_REACT_TO_COMBAT_SOUND` | `7` | Server |  |
| `SCHED_ALERT_SCAN` | `8` | Server | Rotate 180 degrees and back to check for enemies. |
| `SCHED_ALERT_STAND` | `9` | Server | Remain idle until an enemy is heard or found. |
| `SCHED_ALERT_WALK` | `10` | Server | Walk until an enemy is heard or found. |
| `SCHED_AMBUSH` | `52` | Server | Remain idle until provoked or an enemy is found. |
| `SCHED_ARM_WEAPON` | `48` | Server | Performs ACT_ARM. |
| `SCHED_BACK_AWAY_FROM_ENEMY` | `24` | Server | Back away from enemy. |
| `SCHED_BACK_AWAY_FROM_SAVE_POSITION` | `26` | Server | Requires valid enemy, backs away from SaveValue: m_vSavePosition |
| `SCHED_BIG_FLINCH` | `23` | Server | Heavy damage was taken for the first time in a while. |
| `SCHED_CHASE_ENEMY` | `17` | Server | Begin chasing an enemy. |
| `SCHED_CHASE_ENEMY_FAILED` | `18` | Server | Failed to chase enemy. |
| `SCHED_COMBAT_FACE` | `12` | Server | Face current enemy. |
| `SCHED_COMBAT_PATROL` | `75` | Server | Will walk around patrolling an area until an enemy is found. |
| `SCHED_COMBAT_STAND` | `15` | Server |  |
| `SCHED_COMBAT_SWEEP` | `13` | Server |  |
| `SCHED_COMBAT_WALK` | `16` | Server |  |
| `SCHED_COWER` | `40` | Server | When not moving, will perform ACT_COWER. |
| `SCHED_DIE` | `53` | Server | Regular NPC death. |
| `SCHED_DIE_RAGDOLL` | `54` | Server | Plays NPC death sound (doesn't kill NPC). |
| `SCHED_DISARM_WEAPON` | `49` | Server | Holsters active weapon. |
| `SCHED_DROPSHIP_DUSTOFF` | `79` | Server |  |
| `SCHED_DUCK_DODGE` | `84` | Server | Preform Ducking animation. |
| `SCHED_ESTABLISH_LINE_OF_FIRE` | `35` | Server | Search for a place to shoot current enemy. |
| `SCHED_ESTABLISH_LINE_OF_FIRE_FALLBACK` | `36` | Server | Fallback from an established line of fire. |
| `SCHED_FAIL` | `81` | Server | Failed doing current schedule. |
| `SCHED_FAIL_ESTABLISH_LINE_OF_FIRE` | `38` | Server | Failed to establish a line of fire. |
| `SCHED_FAIL_NOSTOP` | `82` | Server |  |
| `SCHED_FAIL_TAKE_COVER` | `31` | Server | Failed to take cover. |
| `SCHED_FALL_TO_GROUND` | `78` | Server | Fall to ground when in the air. |
| `SCHED_FEAR_FACE` | `14` | Server | Will express fear face. |
| `SCHED_FLEE_FROM_BEST_SOUND` | `29` | Server |  |
| `SCHED_FLINCH_PHYSICS` | `80` | Server | Plays ACT_FLINCH_PHYSICS. |
| `SCHED_FORCED_GO` | `71` | Server | Force walk to SaveValue: m_vecLastPosition (debug). |
| `SCHED_FORCED_GO_RUN` | `72` | Server | Force run to SaveValue: m_vecLastPosition (debug). |
| `SCHED_GET_HEALTHKIT` | `66` | Server | Pick up item if within a radius of 5 units. |
| `SCHED_HIDE_AND_RELOAD` | `50` | Server | Take cover and reload weapon. |
| `SCHED_IDLE_STAND` | `1` | Server | Idle stance |
| `SCHED_IDLE_WALK` | `2` | Server | Walk to position. |
| `SCHED_IDLE_WANDER` | `3` | Server | Walk to random position within a radius of 200 units. |
| `SCHED_INTERACTION_MOVE_TO_PARTNER` | `85` | Server |  |
| `SCHED_INTERACTION_WAIT_FOR_PARTNER` | `86` | Server |  |
| `SCHED_INVESTIGATE_SOUND` | `11` | Server |  |
| `SCHED_MELEE_ATTACK1` | `41` | Server |  |
| `SCHED_MELEE_ATTACK2` | `42` | Server |  |
| `SCHED_MOVE_AWAY` | `68` | Server | Move away from player. |
| `SCHED_MOVE_AWAY_END` | `70` | Server | Stop moving and continue enemy scan. |
| `SCHED_MOVE_AWAY_FAIL` | `69` | Server | Failed to move away; stop moving. |
| `SCHED_MOVE_AWAY_FROM_ENEMY` | `25` | Server | Move away from enemy while facing it and checking for new enemies. |
| `SCHED_MOVE_TO_WEAPON_RANGE` | `34` | Server | Move to the range the weapon is preferably used at. |
| `SCHED_NEW_WEAPON` | `63` | Server | Pick up a new weapon if within a radius of 5 units. |
| `SCHED_NEW_WEAPON_CHEAT` | `64` | Server | Fail safe: Create the weapon that the NPC went to pick up if it was removed during pick up schedule. |
| `SCHED_NONE` | `0` | Server | No schedule is being performed. |
| `SCHED_NPC_FREEZE` | `73` | Server | Prevents movement until COND.NPC_UNFREEZE(68) is set. |
| `SCHED_PATROL_RUN` | `76` | Server | Run to random position and stop if enemy is heard or found. |
| `SCHED_PATROL_WALK` | `74` | Server | Walk to random position and stop if enemy is heard or found. |
| `SCHED_PRE_FAIL_ESTABLISH_LINE_OF_FIRE` | `37` | Server |  |
| `SCHED_RANGE_ATTACK1` | `43` | Server |  |
| `SCHED_RANGE_ATTACK2` | `44` | Server |  |
| `SCHED_RELOAD` | `51` | Server | Stop moving and reload until danger is heard. |
| `SCHED_RUN_FROM_ENEMY` | `32` | Server | Retreat from the established enemy. |
| `SCHED_RUN_FROM_ENEMY_FALLBACK` | `33` | Server |  |
| `SCHED_RUN_FROM_ENEMY_MOB` | `83` | Server |  |
| `SCHED_RUN_RANDOM` | `77` | Server | Run to random position within a radius of 500 units. |
| `SCHED_SCENE_GENERIC` | `62` | Server |  |
| `SCHED_SCRIPTED_CUSTOM_MOVE` | `59` | Server |  |
| `SCHED_SCRIPTED_FACE` | `61` | Server |  |
| `SCHED_SCRIPTED_RUN` | `58` | Server |  |
| `SCHED_SCRIPTED_WAIT` | `60` | Server |  |
| `SCHED_SCRIPTED_WALK` | `57` | Server |  |
| `SCHED_SHOOT_ENEMY_COVER` | `39` | Server | Shoot cover that the enemy is behind. |
| `SCHED_SLEEP` | `87` | Server | Sets the NPC to a sleep-like state. |
| `SCHED_SMALL_FLINCH` | `22` | Server |  |
| `SCHED_SPECIAL_ATTACK1` | `45` | Server |  |
| `SCHED_SPECIAL_ATTACK2` | `46` | Server |  |
| `SCHED_STANDOFF` | `47` | Server |  |
| `SCHED_SWITCH_TO_PENDING_WEAPON` | `65` | Server |  |
| `SCHED_TAKE_COVER_FROM_BEST_SOUND` | `28` | Server |  |
| `SCHED_TAKE_COVER_FROM_ENEMY` | `27` | Server | Take cover from current enemy. |
| `SCHED_TAKE_COVER_FROM_ORIGIN` | `30` | Server | Flee from SaveValue: vLastKnownLocation |
| `SCHED_TARGET_CHASE` | `21` | Server | Chase set NPC target. |
| `SCHED_TARGET_FACE` | `20` | Server | Face NPC target. |
| `SCHED_VICTORY_DANCE` | `19` | Server | Human victory dance. |
| `SCHED_WAIT_FOR_SCRIPT` | `55` | Server |  |
| `SCHED_WAIT_FOR_SPEAK_FINISH` | `67` | Server |  |
| `SCHED_WAKE_ANGRY` | `4` | Server | Spot an enemy and go from an idle state to combat state. |

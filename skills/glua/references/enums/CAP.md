# CAP enumeration

**Realm:** Server  ·  **Constants:** 30

Enumerations used by [NPC:CapabilitiesAdd](https://wiki.facepunch.com/gmod/NPC:CapabilitiesAdd), [WEAPON:GetCapabilities](https://wiki.facepunch.com/gmod/WEAPON:GetCapabilities) and [NPC:CapabilitiesGet](https://wiki.facepunch.com/gmod/NPC:CapabilitiesGet). Serverside only.

[wiki page](https://wiki.facepunch.com/gmod/Enums/CAP)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `CAP_AIM_GUN` | `536870912` | Server | Use arms to aim gun, not just body |
| `CAP_ANIMATEDFACE` | `8388608` | Server | Has animated eyes/face |
| `CAP_AUTO_DOORS` | `1024` | Server | Can trigger auto doors |
| `CAP_DUCK` | `134217728` | Server | Cover and Reload ducking |
| `CAP_FRIENDLY_DMG_IMMUNE` | `33554432` | Server | Don't take damage from npc's that are D_LI |
| `CAP_INNATE_MELEE_ATTACK1` | `524288` | Server |  |
| `CAP_INNATE_MELEE_ATTACK2` | `1048576` | Server |  |
| `CAP_INNATE_RANGE_ATTACK1` | `131072` | Server |  |
| `CAP_INNATE_RANGE_ATTACK2` | `262144` | Server |  |
| `CAP_MOVE_CLIMB` | `8` | Server | climb ladders |
| `CAP_MOVE_CRAWL` | `32` | Server |  |
| `CAP_MOVE_FLY` | `4` | Server | Can fly move all around |
| `CAP_MOVE_GROUND` | `1` | Server | Walk/Run |
| `CAP_MOVE_JUMP` | `2` | Server | Jump/Leap |
| `CAP_MOVE_SHOOT` | `64` | Server | Tries to shoot weapon while moving |
| `CAP_MOVE_SWIM` | `16` | Server |  |
| `CAP_NO_HIT_PLAYER` | `268435456` | Server | Don't hit players |
| `CAP_NO_HIT_SQUADMATES` | `1073741824` | Server |  |
| `CAP_OPEN_DOORS` | `2048` | Server | Can open manual doors |
| `CAP_SIMPLE_RADIUS_DAMAGE` | `-2147483648` | Server | When hit by an explosion, we'll simply block it instead of spilling it to entities behind us, the sv_robust_explosions cvar can also enable this globally when set to 0 |
| `CAP_SKIP_NAV_GROUND_CHECK` | `128` | Server |  |
| `CAP_SQUAD` | `67108864` | Server | Can form squads |
| `CAP_TURN_HEAD` | `4096` | Server | Can turn head always bone controller 0 |
| `CAP_USE` | `256` | Server | Open doors/push buttons/pull levers |
| `CAP_USE_SHOT_REGULATOR` | `16777216` | Server |  |
| `CAP_USE_WEAPONS` | `2097152` | Server |  |
| `CAP_WEAPON_MELEE_ATTACK1` | `32768` | Server |  |
| `CAP_WEAPON_MELEE_ATTACK2` | `65536` | Server |  |
| `CAP_WEAPON_RANGE_ATTACK1` | `8192` | Server |  |
| `CAP_WEAPON_RANGE_ATTACK2` | `16384` | Server |  |

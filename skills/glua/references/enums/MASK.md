# MASK enumeration

**Realm:** Shared  ·  **Constants:** 21

Enumerations used as trace masks in [Structures/Trace](https://wiki.facepunch.com/gmod/Structures/Trace) and [Structures/HullTrace](https://wiki.facepunch.com/gmod/Structures/HullTrace). These enumerations are simply combinations of [CONTENTS](https://wiki.facepunch.com/gmod/Enums/CONTENTS).

[wiki page](https://wiki.facepunch.com/gmod/Enums/MASK)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `MASK_ALL` | `4294967295` | Shared | Anything that is not empty space |
| `MASK_BLOCKLOS` | `16449` | Shared | Anything that blocks line of sight for AI |
| `MASK_BLOCKLOS_AND_NPCS` | `33570881` | Shared | Anything that blocks line of sight for AI or NPCs |
| `MASK_CURRENT` | `16515072` | Shared | Water that is moving (may not work) |
| `MASK_DEADSOLID` | `65547` | Shared | Anything that blocks corpse movement |
| `MASK_NPCSOLID` | `33701899` | Shared | Anything that blocks NPC movement |
| `MASK_NPCSOLID_BRUSHONLY` | `147467` | Shared | Anything that blocks NPC movement, except other NPCs |
| `MASK_NPCWORLDSTATIC` | `131083` | Shared | The world entity |
| `MASK_OPAQUE` | `16513` | Shared | Anything that blocks lighting |
| `MASK_OPAQUE_AND_NPCS` | `33570945` | Shared | Anything that blocks lighting, including NPCs |
| `MASK_PLAYERSOLID` | `33636363` | Shared | Anything that blocks player movement |
| `MASK_PLAYERSOLID_BRUSHONLY` | `81931` | Shared | World + Brushes + Player Clips |
| `MASK_SHOT` | `1174421507` | Shared | Anything that stops a bullet (including hitboxes) |
| `MASK_SHOT_HULL` | `100679691` | Shared | Anything that stops a bullet (excluding hitboxes) |
| `MASK_SHOT_PORTAL` | `33570819` | Shared | Solids except for grates |
| `MASK_SOLID` | `33570827` | Shared | Anything that is (normally) solid |
| `MASK_SOLID_BRUSHONLY` | `16395` | Shared | World + Brushes |
| `MASK_SPLITAREAPORTAL` | `48` | Shared | Things that split area portals |
| `MASK_VISIBLE` | `24705` | Shared | Anything that blocks line of sight for players |
| `MASK_VISIBLE_AND_NPCS` | `33579137` | Shared | Anything that blocks line of sight for players, including NPCs |
| `MASK_WATER` | `16432` | Shared | Anything that has water-like physics |

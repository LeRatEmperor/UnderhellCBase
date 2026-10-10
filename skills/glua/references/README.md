# GLua API reference

Byte-accurate GMod API from the official wiki; open the unit file for exact signatures; do not guess.

## Start here

- [../SKILL.md](../SKILL.md) — realm model (client/server/shared) and navigation.
- [guide.md](guide.md) — realms in depth, the `net` library, `NetworkVar`, SWEP/ENT/gamemode/derma skeletons, and gotchas.

## Categories

| Area | Open | Contains | Count |
| --- | --- | --- | --- |
| Globals | [globals.md](globals.md), [globals-2.md](globals-2.md) | Global functions & values | 334 members |
| Classes | [classes/](classes/) | Meta-table classes & their methods | 45 classes, 2296 members |
| Libraries | [libraries/](libraries/) | Libraries & their functions | 88 libraries, 1295 members |
| Panels | [panels/](panels/) | VGUI/derma panels & methods | 130 panels, 1153 members |
| Hooks | [hooks/](hooks/) | Hook namespaces & events | 10 namespaces, 547 members |
| Enums | [enums/](enums/) | Enum families & constants | 100 families, 3002 members |
| Assets | [assets/](assets/) | `icon16` (1011), `flags16` (247), sound paths | see folder |
| Structs | [structs.md](structs.md) | Upstream-gap note (wiki ships 0 structs) | 0 |

## How to find something

- Global function (e.g. `Vector`, `IsValid`) -> [globals.md](globals.md)
- Method on an object (`Foo:Bar`) -> `classes/<Class>.md`
- Library call (`lib.Func`) -> `libraries/<lib>.md`
- D-panel / VGUI widget -> `panels/<Panel>.md`
- Overridable event/hook -> `hooks/<NS>.md`
- `CONSTANT_NAME` enum -> `enums/<FAMILY>.md`

# Hooks

This category covers GLua **hook namespaces** — the overridable event surfaces you implement to make your code react to the engine and gamemode. Unlike library functions you call, these are functions the engine calls on *you*: you define the named member and the game invokes it at the right moment. Two member styles appear here. **Object overrides** (`ENT`, `SWEP`, `PANEL`, `NEXTBOT`, `EFFECT`, `PLAYER`, `DRIVE`, `TOOL`) are methods you assign on a per-object table and that receive the object as `self` — e.g. `function ENT:Think() ... end` — they are **not** `hook.Add` events. **Gamemode hooks** (`GM`, `SANDBOX`) are registered with `hook.Add("Name", id, fn)` using the **bare event name** — the `GM:`/`SANDBOX:` prefix shown on each member below is only the method-override form, so write `hook.Add("PlayerSay", id, fn)`, **never** `hook.Add("GM:PlayerSay", …)` (the prefixed string silently never fires) — or define them directly as `function GM:Name()` inside the gamemode itself.

Choose the unit by what you are building: a scripted entity → `ENT`; a weapon → `SWEP`; a Derma/VGUI element → `PANEL`; an AI bot → `NEXTBOT`; a client effect → `EFFECT`; a player class (`player_manager`) → `PLAYER`; a toolgun tool → `TOOL`; broad gamemode/sandbox behavior → `GM` / `SANDBOX`; a drive mode → `DRIVE`. Many members return a value to alter or suppress default behavior — always confirm the return contract in the per-unit file.

## Most-used

- [GM](GM.md) — the core gamemode hook surface (267 members); player connect, spawn, damage, think, HUD, networking entry points.
- [ENT](ENT.md) — scripted entity overrides (`Initialize`, `Think`, `Draw`, `Use`, physics) for every custom entity.
- [SWEP](SWEP.md) — scripted weapon methods (`PrimaryAttack`, `Reload`, `Think`, `Deploy`) for custom guns and tools.
- [PANEL](PANEL.md) — Derma/VGUI panel overrides (`Paint`, `Think`, `PerformLayout`, `OnMousePressed`) for all UI.
- [SANDBOX](SANDBOX.md) — Sandbox-specific hooks (spawn menu, context menu, prop/tool spawning permissions).
- [PLAYER](PLAYER.md) — player class methods (`Loadout`, `Spawn`, `Death`) registered via `player_manager`.
- [NEXTBOT](NEXTBOT.md) — nextbot AI overrides (`RunBehaviour`, `OnInjured`, `BehaveUpdate`) for navmesh-driven bots.
- [TOOL](TOOL.md) — toolgun callbacks (`LeftClick`, `RightClick`, `Think`, `DrawHUD`) for custom toolgun tools.
- [EFFECT](EFFECT.md) — client-side Lua effect hooks (`Init`, `Think`, `Render`) for particle/visual effects.
- [DRIVE](DRIVE.md) — drive-mode definition registered with `drive.Register` for entity driving.

## Realm notes

- `EFFECT`, `DRIVE`, and the rendering side of `PANEL` are **CLIENT-only** — they run where `render`, `surface`, `cam`, and `draw` exist; do not expect them to fire on the server.
- `NEXTBOT` hooks are **SERVER-only** — bot AI, `RunBehaviour`, and navmesh logic execute serverside; mirror anything visual to the client yourself.
- `GM` spans **Shared and Menu**, and `PANEL` spans **Client and Menu** — guard menu-state code and remember Menu realm lacks most game globals.
- `ENT`, `SWEP`, `PLAYER`, `SANDBOX`, and `TOOL` are **Shared** — the same member can run on both realms, so branch with `SERVER`/`CLIENT` and keep authoritative state serverside, networking changes with `net.*`.

**Open the per-unit file for exact signatures — do not guess.**

| Unit | Realm | Members | Description |
|---|---|---|---|
| [DRIVE](DRIVE.md) | Client | 1 | Represents a drive mode or "method" to be registered with drive.Register. |
| [EFFECT](EFFECT.md) | Client | 8 | These hooks are used inside of a Lua effect. |
| [ENT](ENT.md) | Shared | 81 | A list of hooks only available for Scripted Entities. |
| [GM](GM.md) | Shared, Menu | 267 | Hooks that are available for all gamemodes based on base gamemode. |
| [NEXTBOT](NEXTBOT.md) | Server | 17 | The list of hooks for nextbot NPCs. |
| [PANEL](PANEL.md) | Client, Menu | 37 | This is a list of hooks that are available on all panels. |
| [PLAYER](PLAYER.md) | Shared | 14 | Represents a player class. |
| [SANDBOX](SANDBOX.md) | Shared | 53 | This is a list of hooks that are only available in Sandbox or Sandbox derived gamemodes. |
| [SWEP](SWEP.md) | Shared | 59 | Default weapon methods, that are available for use in SWEPs. |
| [TOOL](TOOL.md) | Shared | 10 | A list of hooks (or callbacks) that are available for you to override in a tool. |

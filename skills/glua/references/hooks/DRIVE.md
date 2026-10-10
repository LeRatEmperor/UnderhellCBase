# DRIVE

**Realm:** Client  ·  **Members:** 1

Represents a drive mode or "method" to be registered with [drive.Register](https://wiki.facepunch.com/gmod/drive.Register).

This page lists all possible fields and hooks a drive mode can have.

> **Using these hooks:** these are **method overrides**, not `hook.Add` events — define them as methods on your `DRIVE` table: `function DRIVE:<Name>(...) end`. The `DRIVE:` prefix shown on each member below is the method form you write.

### DRIVE:CalcView · Client · `hook`
`DRIVE:CalcView(view_in: table{CamData})`

Optionally alter the player's view if they are using this [drive](https://wiki.facepunch.com/gmod/drive) mode.

This hook is called from the default implementation of [GM:CalcView](https://wiki.facepunch.com/gmod/GM:CalcView) which is [here](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/base/gamemode/cl_init.lua#L387-L395). Therefore, it will not be called if any other hook added to `CalcView` returns any value, or if the current gamemode overrides the default hook and does not call [drive.CalcView](https://wiki.facepunch.com/gmod/drive.CalcView).

**Arguments:**
- `view_in` (table{CamData}) — The view, see Structures/CamData.

[wiki](https://wiki.facepunch.com/gmod/DRIVE:CalcView)

# IN enumeration

**Realm:** Shared  ·  **Constants:** 25

Unlike [BUTTON_CODE](https://wiki.facepunch.com/gmod/Enums/BUTTON_CODE), these enums are abstracted to allow the user to bind actions to any key they might prefer.

Keybinds using these actions work with two console commands, one starting with a plus and one with a minus symbol. A key press or release will call either the plus or minus command, adding or removing the corresponding enum in the current [CUserCmd](https://wiki.facepunch.com/gmod/CUserCmd).

Enumerations used by:
* [Player:KeyDown](https://wiki.facepunch.com/gmod/Player:KeyDown)
* [Player:KeyDownLast](https://wiki.facepunch.com/gmod/Player:KeyDownLast)
* [Player:KeyPressed](https://wiki.facepunch.com/gmod/Player:KeyPressed)
* [Player:KeyReleased](https://wiki.facepunch.com/gmod/Player:KeyReleased)
* [CMoveData:AddKey](https://wiki.facepunch.com/gmod/CMoveData:AddKey)
* [CMoveData:GetButtons](https://wiki.facepunch.com/gmod/CMoveData:GetButtons)
* [CMoveData:GetOldButtons](https://wiki.facepunch.com/gmod/CMoveData:GetOldButtons)
* [CMoveData:KeyDown](https://wiki.facepunch.com/gmod/CMoveData:KeyDown)
* [CMoveData:KeyPressed](https://wiki.facepunch.com/gmod/CMoveData:KeyPressed)
* [CMoveData:KeyReleased](https://wiki.facepunch.com/gmod/CMoveData:KeyReleased)
* [CMoveData:KeyWasDown](https://wiki.facepunch.com/gmod/CMoveData:KeyWasDown)
* [CMoveData:SetButtons](https://wiki.facepunch.com/gmod/CMoveData:SetButtons)
* [CMoveData:SetOldButtons](https://wiki.facepunch.com/gmod/CMoveData:SetOldButtons)
* [CUserCmd:GetButtons](https://wiki.facepunch.com/gmod/CUserCmd:GetButtons)
* [CUserCmd:KeyDown](https://wiki.facepunch.com/gmod/CUserCmd:KeyDown)
* [CUserCmd:RemoveKey](https://wiki.facepunch.com/gmod/CUserCmd:RemoveKey)
* [CUserCmd:SetButtons](https://wiki.facepunch.com/gmod/CUserCmd:SetButtons)
* [GM:KeyPress](https://wiki.facepunch.com/gmod/GM:KeyPress)
* [GM:KeyRelease](https://wiki.facepunch.com/gmod/GM:KeyRelease)

[wiki page](https://wiki.facepunch.com/gmod/Enums/IN)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `IN_ALT1` | `16384` | Shared | +alt1 bound key |
| `IN_ALT2` | `32768` | Shared | +alt2 bound key |
| `IN_ATTACK` | `1` | Shared | +attack bound key ( Default: Left Mouse Button ) |
| `IN_ATTACK2` | `2048` | Shared | +attack2 bound key ( Default: Right Mouse Button ) |
| `IN_BACK` | `16` | Shared | +back bound key ( Default: S ) |
| `IN_BULLRUSH` | `4194304` | Shared |  |
| `IN_CANCEL` | `64` | Shared |  |
| `IN_DUCK` | `4` | Shared | +duck bound key ( Default: CTRL ) |
| `IN_FORWARD` | `8` | Shared | +forward bound key ( Default: W ) |
| `IN_GRENADE1` | `8388608` | Shared | +grenade1 bound key |
| `IN_GRENADE2` | `16777216` | Shared | +grenade2 bound key |
| `IN_JUMP` | `2` | Shared | +jump bound key ( Default: Space ) |
| `IN_LEFT` | `128` | Shared | +left bound key ( Look left ) |
| `IN_MOVELEFT` | `512` | Shared | +moveleft bound key ( Default: A ) |
| `IN_MOVERIGHT` | `1024` | Shared | +moveright bound key ( Default: D ) |
| `IN_RELOAD` | `8192` | Shared | +reload bound key ( Default: R ) |
| `IN_RIGHT` | `256` | Shared | +right bound key ( Look right ) |
| `IN_RUN` | `4096` | Shared |  |
| `IN_SCORE` | `65536` | Shared | +showscores bound key ( Default: Tab ) |
| `IN_SPEED` | `131072` | Shared | +speed bound key ( Default: Shift ) |
| `IN_USE` | `32` | Shared | +use bound key ( Default: E ) |
| `IN_WALK` | `262144` | Shared | +walk bound key ( Slow walk ) |
| `IN_WEAPON1` | `1048576` | Shared | For use in weapons. |
| `IN_WEAPON2` | `2097152` | Shared | For use in weapons. |
| `IN_ZOOM` | `524288` | Shared | +zoom bound key ( Suit Zoom ) |

# OBS_MODE enumeration

**Realm:** Shared  ·  **Constants:** 7

Enumerations used by [Player:SetObserverMode](https://wiki.facepunch.com/gmod/Player:SetObserverMode), [Player:GetObserverMode](https://wiki.facepunch.com/gmod/Player:GetObserverMode) and [Player:Spectate](https://wiki.facepunch.com/gmod/Player:Spectate).

[wiki page](https://wiki.facepunch.com/gmod/Enums/OBS_MODE)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `OBS_MODE_CHASE` | `5` | Shared | Chase cam, 3rd person cam, free rotation around the spectated target |
| `OBS_MODE_DEATHCAM` | `1` | Shared | Camera doesn't move, but adjusts camera angles to follow the spectated target |
| `OBS_MODE_FIXED` | `3` | Shared | Same as OBS_MODE_CHASE, but you can't rotate the view |
| `OBS_MODE_FREEZECAM` | `2` | Shared | TF2-like freezecam |
| `OBS_MODE_IN_EYE` | `4` | Shared | First person cam |
| `OBS_MODE_NONE` | `0` | Shared | Not spectating |
| `OBS_MODE_ROAMING` | `6` | Shared | Free roam/noclip-alike. |

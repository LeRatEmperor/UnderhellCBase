# CtrlNumPad

**Realm:** Client  ·  **Members:** 6

CtrlNumPad is a [VGUI](https://wiki.facepunch.com/gmod/VGUI) element designed primarily for [SpawnMenu](https://wiki.facepunch.com/gmod/SpawnMenu) and [ControlPanel](https://wiki.facepunch.com/gmod/ControlPanel). It is used to create a [DBinder](https://wiki.facepunch.com/gmod/DBinder) with at least one [DLabel](https://wiki.facepunch.com/gmod/DLabel). Each change made by the player in the `CtrlNumPad` acts on a previously defined [ConVar](https://wiki.facepunch.com/gmod/ConVar).

To retrieve the panels associated with this panel:
* To retrieve the [DBinder](https://wiki.facepunch.com/gmod/DBinder) created, you can use this variable associated with the panel: `PANEL.NumPad1`
* To retrieve the first [DLabel](https://wiki.facepunch.com/gmod/DLabel) created, you can use this variable associated with the panel: `PANEL.Label1`
* To retrieve the second [DLabel](https://wiki.facepunch.com/gmod/DLabel) created, you can use this variable associated with the panel: `PANEL.Label2`

By default, the [DLabel:SetDark](https://wiki.facepunch.com/gmod/DLabel:SetDark) function is activated on both DLabels.

To retrieve the value of the `CtrlNumPad` you can use these functions : [Player:GetInfoNum](https://wiki.facepunch.com/gmod/Player:GetInfoNum), [CtrlNumPad:GetValue1](https://wiki.facepunch.com/gmod/CtrlNumPad:GetValue1) or [CtrlNumPad:GetValue2](https://wiki.facepunch.com/gmod/CtrlNumPad:GetValue2)

[wiki page](https://wiki.facepunch.com/gmod/CtrlNumPad)

### CtrlNumPad:GetValue1 · Client
`CtrlNumPad:GetValue1() → number{KEY}`

The value (key bind) of the first [DBinder](https://wiki.facepunch.com/gmod/DBinder).

**Returns:**
- `keyBind` (number{KEY}) — The key bind or `KEY_NONE`.

[wiki](https://wiki.facepunch.com/gmod/CtrlNumPad:GetValue1) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/ctrlnumpad.lua#L58-L64)

---

### CtrlNumPad:GetValue2 · Client
`CtrlNumPad:GetValue2() → number{KEY}`

The value (key bind) of the second [DBinder](https://wiki.facepunch.com/gmod/DBinder), if it's enabled.

**Returns:**
- `keyBind` (number{KEY}) — The key bind or `KEY_NONE`.

[wiki](https://wiki.facepunch.com/gmod/CtrlNumPad:GetValue2) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/ctrlnumpad.lua#L66-L72)

---

### CtrlNumPad:SetConVar1 · Client
`CtrlNumPad:SetConVar1(cvar: string)`

The name of the convar that will store the key code for player selected key of the left key binder.

**Arguments:**
- `cvar` (string) — The convar that will be used in the event of a key change by a player.

[wiki](https://wiki.facepunch.com/gmod/CtrlNumPad:SetConVar1) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/ctrlnumpad.lua#L45-L48)

---

### CtrlNumPad:SetConVar2 · Client
`CtrlNumPad:SetConVar2(cvar: string)`

If set and label2 is set, the name of the convar that will store the key code for player selected key of the right key binder.

**Arguments:**
- `cvar` (string) — The convar that will be used in the event of a key change by a player.

[wiki](https://wiki.facepunch.com/gmod/CtrlNumPad:SetConVar2) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/ctrlnumpad.lua#L53-L56)

---

### CtrlNumPad:SetLabel1 · Client
`CtrlNumPad:SetLabel1(txt: string)`

The label for the left key binder.

**Arguments:**
- `txt` (string) — The label for the left key binder.

[wiki](https://wiki.facepunch.com/gmod/CtrlNumPad:SetLabel1) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/ctrlnumpad.lua#L29-L32)

---

### CtrlNumPad:SetLabel2 · Client
`CtrlNumPad:SetLabel2(txt: string)`

If set and convar2 is set, the label for the right key binder.

**Arguments:**
- `txt` (string) — The label for the right key binder.

[wiki](https://wiki.facepunch.com/gmod/CtrlNumPad:SetLabel2) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/gamemodes/sandbox/gamemode/spawnmenu/controls/ctrlnumpad.lua#L37-L40)

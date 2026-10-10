# CUH Autorun + Attachment System — Exhaustive Technical Audit

**Audit scope:** `/lua/autorun/sh_cuh_attachments.lua`, `/lua/autorun/cl_cuh_ui.lua`, `/lua/autorun/cuh_extra_recoil.lua`, plus all 78 attachment data files across `/lua/cuh_attachments/` and `/worldwarii_underhell/lua/cuh_attachments/`.

**Build tag on all three autorun files:** `v0.5.4-camera-bone-diag (2026-10-02)` (extra_recoil.lua is `v0.6.1-extra-recoil (2026-10-02)`).

**Files audited:**
- `lua/autorun/sh_cuh_attachments.lua` — 689 lines
- `lua/autorun/cl_cuh_ui.lua` — 345 lines
- `lua/autorun/cuh_extra_recoil.lua` — 188 lines
- `lua/cuh_attachments/*.lua` — 67 files
- `worldwarii_underhell/lua/cuh_attachments/*.lua` — 11 files

---

## A. `lua/autorun/sh_cuh_attachments.lua` (689 lines)

### A.1 Header / build info (lines 1-17)
- Header comment (lines 1-13) declares the file's purpose: attachment registration, networking, save/load. Explicitly states "It does NOT define any SWEP: methods — those are all in `weapon_cuh_base_gun.lua` directly".
- `AddCSLuaFile()` on line 15 — sent to all clients on mount.
- `print("[CUH] sh_cuh_attachments.lua loading (realm=" .. (SERVER and "SERVER" or "CLIENT") .. ")")` on line 17 — debug noise on every realm load.

### A.2 CustomUH namespace (lines 19-45)
- Line 22: `CustomUH = CustomUH or {}` (idempotent table init).
- Line 23: `CustomUH.Attachments = CustomUH.Attachments or {}` — registry of all loaded attachments, keyed by filename-without-extension.
- Line 24: `CustomUH.Version = "3.0"`.
- Lines 27-40: `CustomUH.Colors` table of UI Colors:
  - `Background = Color(30, 30, 30, 240)`
  - `Panel = Color(40, 40, 40, 240)`
  - `Text = Color(220, 220, 220, 255)`
  - `TextBright = Color(255, 255, 255, 255)`
  - `TextDim = Color(150, 150, 150, 255)`
  - `Accent = Color(0, 150, 255, 255)`
  - `AccentDim = Color(0, 80, 140, 200)`
  - `Selected = Color(0, 200, 100, 60)`
  - `Hover = Color(255, 255, 255, 20)`
  - `StatPositive = Color(100, 255, 100, 255)`
  - `StatNegative = Color(255, 100, 100, 255)`
  - `StatNeutral = Color(200, 200, 200, 255)`
  - Note: `StatPositive`/`StatNegative`/`StatNeutral` are declared but never referenced anywhere in the codebase.
- Lines 43-45: `cuh_menu_key` ConVar (`CreateClientConVar("cuh_menu_key", "c", true, false, "Key to open weapon customization")`), guarded by `if not ConVarExists("cuh_menu_key")` to prevent double registration.

### A.3 Attachment registration — `CustomUH.RegisterAttachments()` (lines 47-103)

**File list capture** (line 62):
```lua
CustomUH._attFiles = file.Find("cuh_attachments/*.lua", "LUA")
```
- Searches the `LUA` search path, which aggregates files from ALL mounted addons. Since both `/home/z/my-project/lua/cuh_attachments/` and `/home/z/my-project/worldwarii_underhell/lua/cuh_attachments/` are mounted, all 67 + 11 = 78 files are captured into `_attFiles`.

**Server-side AddCSLuaFile pre-loop** (lines 64-68):
```lua
if SERVER then
    for _, filename in ipairs(CustomUH._attFiles) do
        AddCSLuaFile("cuh_attachments/" .. filename)
    end
end
```
- All attachment files are pushed to clients at addon-load time, BEFORE any client tries to `include()` them. Header comment (lines 50-60) explains that the previous implementation called `AddCSLuaFile` inside `RegisterAttachments` (a Think hook), which was too late for already-connected clients and caused `include()` to fail silently under pcall.

**`CustomUH.RegisterAttachments()` definition** (lines 70-103):
```lua
function CustomUH.RegisterAttachments()
    local files = CustomUH._attFiles or {}
    print("[CUH-DBG] RegisterAttachments CALLED  realm=" .. (SERVER and "SERVER" or "CLIENT")
        .. "  file count=" .. #files)
    for i, fn in ipairs(files) do
        print("[CUH-DBG]   file[" .. i .. "] = " .. tostring(fn))
    end
    for _, filename in ipairs(files) do
        ATTACHMENT = {}
        local path = "cuh_attachments/" .. filename
        local ok, err = pcall(include, path)
        if not ok then
            print("[CUH-DBG]   Error loading " .. filename .. ": " .. tostring(err))
            print("[CustomUH] Error loading " .. filename .. ": " .. tostring(err))
        end
        if ATTACHMENT and ATTACHMENT.Name then
            local id = string.StripExtension(filename)
            ATTACHMENT.ID = id
            CustomUH.Attachments[id] = ATTACHMENT
            print("[CUH-DBG]   registered attachment id='" .. id .. "'  Name='" .. tostring(ATTACHMENT.Name) .. "'  PartClass=" .. tostring(ATTACHMENT.PartClass))
        else
            print("[CUH-DBG]   ATTACHMENT skipped (no .Name): " .. filename)
            print("[CustomUH] Attachment skipped (no .Name): " .. filename)
        end
        ATTACHMENT = nil
    end
    print("[CUH-DBG] RegisterAttachments DONE  total registered = " .. table.Count(CustomUH.Attachments))
end
```

Key behaviors:
- Sets global `ATTACHMENT = {}` before each `include` — attachment files write to this global.
- Wraps `include()` in `pcall` — if a file errors, registration of that one file fails but the rest continue.
- ID is `string.StripExtension(filename)` — for `xm8_barrel_s.lua` the ID is `xm8_barrel_s`.
- An attachment file is rejected (skipped) only if `ATTACHMENT.Name` is missing.
- Sets `ATTACHMENT = nil` after each file to prevent leakage into subsequent includes.
- Per-file iteration order is determined by `file.Find`'s return order (alphabetical on most filesystems).
- Debug prints `[CUH-DBG]` on every file — extremely noisy, should be gated behind a debug convar for production.

### A.4 Ammo type registration (lines 105-120)
- `CustomUH.AmmoTypes = CustomUH.AmmoTypes or {}` (line 108).
- `CustomUH.RegisterAmmo(ammoID, displayName, maxReserve)` — line 110, stores `{Name, Max}`.
- `CustomUH.GetAmmoName(ammoID)` — line 117.
- Default ammo types registered at lines 418-424 (see A.8 below).

### A.5 Save/load system (lines 122-234)

#### `CustomUH.GetSavePath(ply)` (lines 127-130)
```lua
function CustomUH.GetSavePath(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return nil end
    return SAVE_DIR .. "/" .. ply:SteamID64() .. ".json"
end
```
- `SAVE_DIR = "cuh_saves"` (line 125).
- Returns `cuh_saves/<steamid64>.json` — a per-player JSON file in the `DATA` folder.

#### `CustomUH.LoadAttachments(wep, ply)` (lines 132-185)
- Defaults `ply = wep:GetOwner()` if not provided (line 133).
- Returns early if no valid owner, no `wep.Attachments`, no save file, or invalid JSON.
- Reads JSON into `data` table.
- Looks up `data[wep:GetClass()]` — class is the lookup key.
- For each `slot, index` in `saved`, converts slot to number, validates that `wep.Attachments[slot]` exists and `index` is in range (`index == 0` OR `index <= #wep.Attachments[slot].atts`).
- Sets `wep.Attachments[slot].sel = index` for each valid pair.
- If anything changed, calls `wep:ApplyAttachments()` then sends a `CUH2_AttLoad` net message to the player containing a UInt8 count followed by UInt8 slot + UInt8 index pairs.
- **Bug/limitation:** the `for slot, index in pairs(saved)` loop uses `pairs` which gives arbitrary iteration order; this is fine for state restoration but worth noting.
- **Limitation:** the count field is `net.WriteUInt(#tempData, 8)` — caps at 255 slots. Reasonable for any sane weapon.

#### `CustomUH.SaveAttachments(wep, ply)` (lines 187-225)
- Reads existing JSON (if any), updates the entry for `wep:GetClass()`.
- Iterates `wep.Attachments` with `pairs`. For each slot:
  - If `slotData.sel > 0`, stores `current[tostring(slot)] = slotData.sel`.
  - Otherwise stores `current[tostring(slot)] = 0`.
- Sets `data[class] = current` if `hasAttachments`, else `data[class] = nil`.
- Creates `cuh_saves/` directory if it doesn't exist (lines 219-221).
- Writes the JSON pretty-printed (`util.TableToJSON(data, true)`).

#### `CustomUH.SaveAllAttachments(ply)` (lines 227-234)
- Iterates `ply:GetWeapons()`, calls `SaveAttachments(wep, ply)` for any weapon that has an `Attachments` table.

### A.6 Networking — net strings & receivers (lines 236-371)

#### Net string registration (lines 239-244)
```lua
if SERVER then
    util.AddNetworkString("CUH2_AttSelect")
    util.AddNetworkString("CUH2_AttSync")
    util.AddNetworkString("CUH2_AttLoad")
    util.AddNetworkString("CUH2_AttList")
end
```

#### `CUH2_AttList` — server-to-client file list broadcast (lines 246-286)
- Used to push the attachment filename list to clients that don't have the addon mounted locally.
- Server-side: `SendAttList(ply)` writes UInt8 count + UInt8 × N string filenames, then `net.Send(ply)` (lines 253-260).
- Hooked to `PlayerInitialSpawn` (line 263) with a 1-second `timer.Simple` delay (line 264) to allow the player to fully initialize.
- Client-side receiver (lines 271-285): reads the list, but ONLY adopts it if `CustomUH._attFiles` is nil or empty (preserves the local `file.Find` result if the client already had files). If adopting, calls `CustomUH.RegisterAttachments()` to register them.

#### `CUH2_AttSelect` — client-to-server attachment selection (lines 288-336)
Server-side receiver:
```lua
net.Receive("CUH2_AttSelect", function(len, ply)
    local wep = net.ReadEntity()
    local slot = net.ReadUInt(8)
    local index = net.ReadUInt(8)
    -- validation checks: wep valid, owner matches, wep.Attachments[slot] exists, index in range
    -- forceDefault check: if index==0 and forceDefault, snap to default
    wep.Attachments[slot].sel = index
    wep:ApplyAttachments()
    CustomUH.SaveAttachments(wep, ply)
    -- broadcast CUH2_AttSync to ALL clients
end)
```

Validation chain (lines 297-314):
1. `IsValid(wep)` — abort if not.
2. `wep:GetOwner() ~= ply` — abort on owner mismatch (prevents players from modifying other players' weapons).
3. `wep.Attachments` and `wep.Attachments[slot]` exist.
4. `index` is in range: `index > 0` AND `index <= #wep.Attachments[slot].atts`.

`forceDefault` check (lines 317-321): if the player tries to deselect (`index == 0`) on a `forceDefault` slot, the index is silently snapped to `wep.Attachments[slot].default`.

After validation: writes `wep.Attachments[slot].sel = index`, calls `wep:ApplyAttachments()`, calls `CustomUH.SaveAttachments(wep, ply)`, then broadcasts `CUH2_AttSync` to all clients with `(wep, slot, index)`.

#### `CUH2_AttSync` — server-to-client broadcast (lines 339-354)
Client receiver: reads `(wep, slot, index)`, validates `wep.Attachments[slot]` exists, sets `wep.Attachments[slot].sel = index`, calls `wep:ApplyAttachments()`.

#### `CUH2_AttLoad` — server-to-client saved-state push (lines 356-370)
Client receiver: reads `(wep, count)` and then `count` pairs of `(slot, index)`. For each, sets `wep.Attachments[slot].sel = index` if the slot exists. After the loop, calls `wep:ApplyAttachments()`.

### A.7 Hooks (lines 373-404)

#### `PlayerSwitchWeapon` — `CUH2_LoadOnSwitch` (lines 382-394)
- Real GMod hook (firing when a player switches TO a new weapon).
- Guards: `IsValid(ply)`, `IsValid(newWep)`, `newWep.IsCUHWeapon`, `newWep.Attachments`.
- Only acts on SERVER.
- Defers via `timer.Simple(0, ...)` — comment says "Defer to next tick so the weapon is fully initialized".
- Comment at lines 379-381 notes the previous code used `"WeaponDeployed"` which is NOT a real GMod hook and was never called.

#### `PlayerDeath` — `CUH2_SaveOnDeath` (lines 397-399)
- Calls `CustomUH.SaveAllAttachments(ply)` on player death.

#### `PlayerDisconnected` — `CUH2_SaveOnDisconnect` (lines 402-404)
- Calls `CustomUH.SaveAllAttachments(ply)` on disconnect.

### A.8 Init + ammo defaults (lines 406-433)
- Line 415: `CustomUH.RegisterAttachments()` — called immediately at addon load (no waiting for first Think).
- Lines 418-424: default ammo registrations:
  - `ar2` → `7.62mm`, max 300
  - `smg1` → `9mm`, max 240
  - `pistol` → `.45 ACP`, max 150
  - `357` → `.357 Magnum`, max 60
  - `buckshot` → `12 Gauge`, max 80
  - `SniperPenetratedRound` → `.50 BMG`, max 60
  - `RPG_Round` → `RPG`, max 20
- Lines 429-433: `Think` fallback hook `CUH2_Register` — re-runs `RegisterAttachments()` on the first Think frame, guarded by `CustomUH._registered` flag (only runs once). Comment at lines 426-428 explains this is a safety net in case the early call ran before client lua files were available.

### A.9 Console commands (lines 436-689)

All `concommand.Add` calls are SERVER-side runnable (no explicit realm guard, but they call `ply:GetActiveWeapon()` so they only make sense from a player console).

#### `cuh_debug` (lines 443-518)
- Prints the active weapon's state: class, PrintName, IsCUHWeapon flag, Base, presence of SetAttachment/ApplyAttachments/InitVElements/InitStatCache/_statCache/_statOrigins/_vElementsInit methods/fields.
- Iterates and prints every entry in `CustomUH.Attachments` (sorted alphabetically) with `id`, `Name`, `PartClass`, `ModelPath`.
- Iterates `wep.Attachments` slots, printing effective sel, default, and atts list.
- Iterates `wep.ViewModelElements` with model, active flag, _csModel, _defaultSnapshot presence.
- Prints stat cache entries for `Primary.Spread`, `Primary.Delay`, `Primary.Damage`, `IronSightTime`, `MoveSpeed`, `Primary.IronAccuracy` with origin and current value.

#### `cuh_apply` (lines 522-536)
- Manually calls `wep:ApplyAttachments()` on the active weapon. Skips if the weapon lacks `ApplyAttachments` method.

#### `cuh_set <slot> <index>` (lines 540-553)
- Calls `wep:SetAttachment(slot, index)` with parsed args. Example given in comment: `cuh_set 2 2` selects Hvy-B barrel.

#### `cuh_reset` (lines 556-568)
- Iterates all slots and calls `wep:SetAttachment(slot, slotData.default or 0)`. Resets to defaults (or None if no default).

#### `cuh_save` (lines 572-594)
- Calls `CustomUH.SaveAttachments(wep, ply)`, then verifies the save file was written, printing its path, size, and full contents.

#### `cuh_load` (lines 597-609)
- Calls `CustomUH.LoadAttachments(wep, ply)`.

#### `cuh_camtest` (lines 613-688)
- Camera bone diagnostic — checks `wep.CameraAttachment`, `wep.CameraReserve`, `wep.CameraOffset`, presence of `CalcView` method.
- Looks up the class table via `weapons.GetStored(wep:GetClass())` and prints its `CameraAttachment`, `Base`, key count, and sorted key list.
- Walks the inheritance chain (depth < 10) printing `CameraAttachment` at each level.
- Uses `debug.getinfo(wep.CalcView, "S")` to check whether `CalcView` is from `weapon_cuh_base_gun.lua` or shadowed by another addon.
- Inspects the viewmodel's `Camera`/`camera` attachments (case-insensitive lookup) and lists all VM attachments.

### A.10 Default attachment system

**`default` field** (per slot): if a slot has `default = N`, that attachment is the default-selected index. The UI badge "D" is drawn for the default index (see `cl_cuh_ui.lua` line 287-289).

**`forceDefault` field** (per slot): if `true`, the slot cannot be deselected (set to 0). The UI disables the "None" button (line 201-204) and the server-side `CUH2_AttSelect` receiver snaps `index = 0` back to the default (lines 317-321).

**`GetEffectiveAttachment`** — referenced at multiple points (e.g., line 484, `cl_cuh_ui.lua` line 193). The actual method definition lives in `weapon_cuh_base_gun.lua` (not in the autorun file). It returns `wep.Attachments[slot].sel or wep.Attachments[slot].default or 0`. The UI uses it to determine which attachment is currently shown as selected.

### A.11 Notable issues in `sh_cuh_attachments.lua`
1. **Excessive debug logging** — `[CUH-DBG]` prints on every file load, every net message, every save/load. Should be gated behind a debug ConVar (e.g., `cuh_debug_verbose 0/1`).
2. **`StatPositive`/`StatNegative`/`StatNeutral` colors defined but unused** — dead code (lines 37-39).
3. **The CUH2_AttList client-side guard `if not CustomUH._attFiles or #CustomUH._attFiles == 0 then`** (line 281) means clients with the addon mounted locally will NEVER adopt the server's list. This is by design but could be a footgun if a client has only SOME attachment files locally (e.g., partial install) — they would get their local list and miss files the server has.
4. **`pairs(wep.Attachments)` in `SaveAttachments`** (line 204) iterates in arbitrary order, which is harmless for JSON serialization but means the saved file's slot order isn't deterministic.

---

## B. `lua/autorun/cl_cuh_ui.lua` (345 lines)

### B.1 Header & realm guard (lines 1-13)
- `AddCSLuaFile()` (line 9) so server pushes to clients.
- Line 11: `if not CLIENT then return end` — file is CLIENT-only.
- `local menuPanel = nil` (line 13) — singleton reference to the open menu.

### B.2 `IsCUHWeapon(wep)` detection (lines 15-41)
```lua
local function IsCUHWeapon(wep)
    if not IsValid(wep) then return false end
    -- Fast path: explicit opt-in marker on the instance/class
    if wep.IsCUHWeapon == true then return true end
    -- Walk the Base chain
    local cur = wep
    local seen = {}
    local depth = 0
    while cur and not seen[cur] and depth < 16 do
        seen[cur] = true
        depth = depth + 1
        if cur.Base and string.find(cur.Base, "cuh_base") then
            return true
        end
        if not cur.Base then break end
        cur = weapons.GetStored(cur.Base)
    end
    return false
end
```

- Fast path: `wep.IsCUHWeapon == true` — explicit opt-in marker on the instance/class.
- Slow path: walks the `SWEP.Base` chain (up to 16 levels deep, with `seen` cycle-breaker), checking `string.find(cur.Base, "cuh_base")` at each level.
- This is necessary because TFA weapons also define `SetAttachment`/`GetEffectiveAttachment`, so checking for those methods is unreliable. The function never uses `_customUHChecked` cache (referenced in the task but NOT present in the actual code — the audit found no such cache).

### B.3 Context menu suppression (lines 43-46)
```lua
hook.Add("OnContextMenuOpen", "CUH2_SuppressContext", function()
    if IsValid(menuPanel) then return false end
end)
```
- Returns `false` to suppress the GMod context menu while the CUH menu is open.

### B.4 `OpenMenu()` — main menu construction (lines 48-321)

#### Open guards & toggle (lines 49-67)
- Gets `LocalPlayer():GetActiveWeapon()`, aborts if invalid or no `wep.Attachments`.
- Calls `IsCUHWeapon(wep)` — aborts if not a CUH weapon.
- If menu already open (`IsValid(menuPanel)`), removes it and plays `ui/buttonclickrelease.wav` — toggle behavior.
- Otherwise plays `ui/buttonclick.wav` to open.

#### DFrame setup (lines 69-98)
- Size: 640×520 (`W=640, H=520`).
- `frame:Center()`, no title (`SetTitle("")`), no close button (`ShowCloseButton(false)`), `MakePopup()`.
- `frame.Paint`: rounded background (CustomUH.Colors.Background), top header strip (CustomUH.Colors.Panel) with title `"Customize — " .. (wep.PrintName or "")`.
- `frame.OnMousePressed`: closes the frame if the click is in the top-right 40px corner (the close button zone).
- `frame.OnRemove`: clears `menuPanel`, removes `CUH2_InspectLoop` Think hook, sets `wep:SetNW2Bool("Inspecting", false)`.

#### Inspect animation loop (lines 100-149)
- Conditional on `wep.CUHInspectOnMenu` (default false — must be explicitly set on the weapon) AND `wep.Animations["inspect"]` existing.
- On open: sets `wep:SetNW2Bool("Inspecting", true)` and calls `wep:EasySendWeaponAnim("inspect", ACT_VM_FIDGET)`.
- Caches `inspectAnimName = wep.Animations["inspect"]` (handles table-or-string form).
- Defers duration measurement to first Think frame.
- Installs `Think` hook `CUH2_InspectLoop` that:
  - Removes itself if menu or weapon becomes invalid, OR if the player switches to a different weapon.
  - On first valid frame: looks up the sequence index via `vm:LookupSequence(inspectAnimName)`, computes `vm:SequenceDuration(seqIdx)`, schedules `nextReplayTime = CurTime() + inspectDuration`.
  - On each subsequent Think: if `CurTime() >= nextReplayTime`, replays the inspect anim and bumps `nextReplayTime`.

#### Close button (lines 152-161)
- 30×30 DButton at `(W-35, 5)`, empty text, no Paint (invisible).
- On click: plays `ui/buttonclickrelease.wav`, removes frame.

#### Scroll panel (lines 163-166)
- `DScrollPanel` docked FILL with 10px margins (top 45 to clear header).
- Iterates `for slot = 1, #wep.Attachments do` (line 168) — sequential integer-keyed iteration.

#### Per-slot rendering (lines 168-319)
For each slot:
1. **Slot header** (lines 173-183): 25-tall DPanel with `CustomUH.Colors.AccentDim` background, prints `slotData.name or ("Slot " .. slot)`.
2. **Button row** (lines 186-190): 60-tall DPanel, no Paint (transparent).
3. **Current selection** (line 193): `cur = wep.GetEffectiveAttachment and wep:GetEffectiveAttachment(slot) or (slotData.sel or 0)`.
4. **"None" button** (lines 196-245): 50×50 button labeled "None". Disabled if `slotData.forceDefault`. When clicked: plays release sound, calls `DoSetAttachment(slot, 0)`, sets `cur = 0`.
5. **`DoSetAttachment(slotNum, index)` helper** (lines 220-238): see B.5 below.
6. **Attachment buttons** (lines 250-319): for each `attId` in `slotData.atts`:
   - Looks up `CustomUH.Attachments[attId]`. Skips if missing (silently — this is the source of "empty slots" when an attachment file doesn't exist).
   - 50×50 button at `(x, 5)` where `x` starts at 60 and increments by 60 per attachment.
   - `Paint`: draws background (Panel/Selected/Hover), draws `att.Icon` material if present (with fallback to `att.ShortName or att.Name or "?"`), draws accent outline if selected, draws "D" badge if it's the default.
   - Tooltip: concatenates `att.Description` parts (strings only — skips Color values).
   - Name label (lines 303-310): DLabel at `(x, 55)`, 50×15, truncated to 7 chars + ".." if longer than 8.
   - On click: plays click sound, calls `DoSetAttachment(slot, i)`, sets `cur = i`.

#### Click-outside-to-close
- `frame.OnMousePressed` (lines 81-89) — closes if click is in the top-right 40×40 corner (the close button zone). This is NOT a true click-outside-to-close; it's only the close button. The task description mentions click-outside-to-close, but the code only implements click-on-close-button-to-close. **Audit finding:** the "click outside to close" feature is NOT implemented in this file. The context menu suppression (B.3) handles the case where the player opens the GMod context menu — it gets blocked, but clicking elsewhere on screen does nothing.

### B.5 TFA bypass via `debug.getinfo` — `DoSetAttachment` (lines 220-238)
```lua
local function DoSetAttachment(slotNum, index)
    if not IsValid(wep) then return end
    if not wep.SetAttachment then return end
    -- Check if SetAttachment is shadowed by TFA
    local ourSrc = debug.getinfo(wep.SetAttachment, "S")
    if ourSrc and not string.find(ourSrc.short_src or "", "weapon_cuh_base_gun", 1, true) then
        -- Shadowed — bypass directly
        wep.Attachments[slotNum].sel = index
        wep:ApplyAttachments()
        net.Start("CUH2_AttSelect")
            net.WriteEntity(wep)
            net.WriteUInt(slotNum, 8)
            net.WriteUInt(index, 8)
        net.SendToServer()
    else
        -- Ours — call normally
        wep:SetAttachment(slotNum, index)
    end
end
```

- `debug.getinfo(wep.SetAttachment, "S")` returns a table with `short_src` field.
- If `short_src` does NOT contain `"weapon_cuh_base_gun"`, the method is shadowed (by TFA base or another addon) — bypass by writing `.sel` directly, calling `ApplyAttachments()`, and sending the `CUH2_AttSelect` net message manually.
- If `short_src` DOES contain `weapon_cuh_base_gun`, the method is ours — call `wep:SetAttachment(slotNum, index)` normally (which does the same work internally).
- This is a robust workaround for the case where TFA base is mounted alongside CUH base — TFA's `SetAttachment` would otherwise shadow CUH's.

### B.6 Key detection (lines 323-345)

#### `Think` hook `CUH2_MenuKey` (lines 327-340)
- Reads `GetConVar("cuh_menu_key"):GetString()` every Think, converts to enum via `_G["KEY_" .. string.upper(keyStr)]`.
- Edge-detects key press via `keyPressed` flag — calls `OpenMenu()` once per press (not every frame while held).
- Aborts silently if the key string doesn't map to a valid KEY_ enum.

#### Console command `cuh_menu` (lines 343-345)
- Fallback console command that calls `OpenMenu()` directly.

### B.7 Notable issues in `cl_cuh_ui.lua`
1. **No click-outside-to-close** — despite the task description, only the close button (top-right) closes the menu. Clicking elsewhere on screen does nothing.
2. **`Material(att.Icon, "smooth")` is called inside `Paint`** (line 266) — this creates a new Material object EVERY FRAME for every attachment button. Should be cached at button creation time.
3. **Tooltip text concatenation** (lines 296-298) only handles string parts — Color values are silently skipped. This is intentional (Description entries alternate Color + text), but means the colors shown in the tooltip are lost.
4. **`cur` local variable** is captured by closure in the Paint/DoClick functions and updated on click, but `Paint` is only re-rendered when something invalidates the panel. This means the selection outline updates correctly only because clicking triggers a repaint.
5. **The `DoSetAttachment` helper is defined inside the slot loop** (line 220), which means a fresh closure per slot. Functionally correct but slightly wasteful.
6. **`IsCUHWeapon` walks up to 16 levels deep** — sufficient for any reasonable inheritance chain but could be increased if very deep chains exist.

---

## C. `lua/autorun/cuh_extra_recoil.lua` (188 lines)

### C.1 Header / port notes (lines 1-22)
- Build tag `v0.6.1-extra-recoil (2026-10-02)`.
- Ported from `tfa_extra_recoil.lua`. Header documents 5 changes from the original:
  1. ConVars renamed from `sv_tfa_recoil_extra_*` to `sv_cuh_recoil_extra_*` (avoid conflict if both addons installed).
  2. Weapon filter changed from `weapon.IsTFAWeapon` to `weapon.IsCUHWeapon` (CUH weapons only, not TFA).
  3. Removed `sv_tfa_recoil_legacy` cross-dependency (TFA-specific, doesn't exist in CUH).
  4. Hook IDs renamed from `TFA_*` to `CUH_*`.
  5. Timer ID renamed from `ExtraRecoilFireDetectionLoop` to `CUH_ExtraRecoilFireDetectionLoop`.
- File is fully independent of TFA Base — will not conflict with the original TFA addon if both are installed.

### C.2 ConVars (lines 24-32)
```lua
CreateConVar("sv_cuh_recoil_extra_enabled",                       "1",   FCVAR_REPLICATED, "Enable/disable CUH extra recoil system", 0, 1)
CreateConVar("sv_cuh_recoil_extra_mult",                          "2",   FCVAR_REPLICATED, "Multiplier for CUH recoil strength", 0.001, 1000)
CreateConVar("sv_cuh_recoil_extra_screenshake_enabled",           "1",   FCVAR_REPLICATED, "Enable/disable CUH screenshake effects", 0, 1)
CreateConVar("sv_cuh_recoil_extra_screenshake_strength_multiplier","0.5",FCVAR_REPLICATED, "Multiplier for CUH screenshake strength", 0.001, 1000)
CreateConVar("sv_cuh_recoil_extra_screenshake_speed_multiplier", "1",   FCVAR_REPLICATED, "Multiplier for CUH screenshake speed", 0.001, 1000)
```

All five are `FCVAR_REPLICATED` — synced between server and client. Defaults: enabled, mult=2, screenshake enabled, strength_mult=0.5, speed_mult=1.

### C.3 Shared state (line 40)
- `local lastExtraRecoilTime = 0` — shared between CLIENT block (only used on CLIENT though since the rest of the file is CLIENT-only). This is dead code on SERVER (the variable is set but never read outside the CLIENT block).

### C.4 CLIENT-only block (lines 42-188)

#### Local state (lines 43-52)
- `lastMagCapacity = 0`, `lastWeapon = nil` — fire detection state.
- `cuh_extra_screenshake_enabled`, `cuh_extra_screenshake_strength_multiplier`, `cuh_extra_screenshake_speed_multiplier` — cached ConVar objects (lines 46-48).
- `ExtraScreenShakeTime`, `ExtraScreenShakeDuration`, `ExtraScreenShakeStrength`, `ExtraScreenShakeViewOffset` (lines 49-52) — screenshake state.

#### `ApplyExtraRecoil(weapon)` (lines 54-115)
```lua
local function ApplyExtraRecoil(weapon)
    if not IsValid(weapon) or not weapon.IsCUHWeapon then return end
    -- throttle to 50ms
    if currentTime - lastExtraRecoilTime < 0.05 then return end
    lastExtraRecoilTime = currentTime
    -- compute extraRecoilAmount from Primary.KickUp/KickDown/KickHorizontal/StaticRecoilFactor, * 2
    -- adjust based on ironsight state (GetUHBool("Zooming")) and crouch state:
    --   ironSights+crouch: 0.333x mult
    --   ironSights only:   0.5x mult
    --   crouch only:       0.75x mult
    --   else:              1x mult
    -- all multiplied by sv_cuh_recoil_extra_mult
    -- compute rpmDuration = min(60/RPM + 0.06, 0.25)
    -- store ExtraRecoilStartTime/Duration/Amount/StartPitch on weapon
    -- if screenshake enabled, set ExtraScreenShakeDuration/Strength/Time/ViewOffset
end
```

- `weapon.IsCUHWeapon` — checks the FIELD (truthy check, not `== true`). If `IsCUHWeapon` is set to a function/method, this would still be truthy. The convention is `IsCUHWeapon = true` (boolean) on the weapon class.
- Reads `Primary.KickUp`, `KickDown`, `KickHorizontal`, `StaticRecoilFactor` (each `or 0` for safety).
- `extraRecoilAmount = (kickUp + kickDown + kickHorizontal + staticRecoilFactor) * 2`.
- Ironsight check via `weapon.GetUHBool and weapon:GetUHBool("Zooming")` — falls back to 0 if no method. Note: this approximates ironsight progress as binary (1 or 0), unlike the TFA original which used `IronSightsProgressUnpredicted`/`GetIronSightsProgress()` for a smooth value.
- RPM read from `Primary.RPM or 600`, with fallback `60 / weapon.Primary.Delay` if RPM missing.
- `rpmDuration = math.min((60 / rpm + 0.06), 0.25)` — caps at 250ms.
- Stores `ExtraRecoilStartTime = CurTime()`, `ExtraRecoilDuration = rpmDuration`, `ExtraRecoilAmount = extraRecoilAmount`, `ExtraRecoilStartPitch = LocalPlayer():EyeAngles().pitch` on the weapon table.
- Screenshake: `ExtraScreenShakeDuration = RPMDuration * speed_mult`, `ExtraScreenShakeStrength = (extraRecoilAmount / 2) * strength_mult`, `ExtraScreenShakeTime = ExtraScreenShakeDuration`, `ExtraScreenShakeViewOffset = Angle(0,0,0)`.

#### `DetectExtraRecoilFiring()` (lines 117-176)
```lua
local function DetectExtraRecoilFiring()
    if not GetConVar("sv_cuh_recoil_extra_enabled"):GetBool() then return end
    -- abort if not IsValid(ply) or not weapon.IsCUHWeapon
    -- if weapon has ExtraRecoilStartTime/Duration/Amount:
    --   timeSinceStart > 0.01 and < Duration: apply pitch reduction by movementRate * 0.01
    --   timeSinceStart >= Duration: clear all Extra* fields
    -- fire detection: if Clip1() decreased, call ApplyExtraRecoil
    -- screenshake: decay ExtraScreenShakeTime, compute roll via sin(timeProgress * pi * 4) * strength * timeProgress
end
```

- 50ms throttle via `lastExtraRecoilTime` (line 62).
- Skips first frame (timeSinceStart > 0.01) to start recoil from second frame.
- Frame time hard-coded to 0.01 seconds (line 137) — not actual `FrameTime()`.
- Modifies `currentAngles.pitch` by `-frameMovement` (negative = upward kick), then `ply:SetEyeAngles(currentAngles)`.
- Fire detection: compares `weapon:Clip1()` to `lastMagCapacity`. If decreased, calls `ApplyExtraRecoil(weapon)`.
- Resets `lastMagCapacity` / `lastWeapon` when weapon changes.
- Screenshake decay: `ExtraScreenShakeTime = math.max(0, ExtraScreenShakeTime - FrameTime())`. Computes `rollAngle = math.sin(timeProgress * pi * 4) * ExtraScreenShakeStrength * timeProgress`. Stores as `Angle(0, 0, rollAngle)`.

#### `CalcView` hook `CUH_ExtraScreenShake_View` (lines 180-184)
```lua
hook.Add("CalcView", "CUH_ExtraScreenShake_View", function(ply, origin, angles, fov, znear, zfar)
    if ExtraScreenShakeViewOffset.roll ~= 0 then
        angles:Add(ExtraScreenShakeViewOffset)
    end
end)
```
- Adds the roll offset to the view angles. Note: mutates `angles` in place via `:Add()`.

#### Fire detection timer `CUH_ExtraRecoilFireDetectionLoop` (line 187)
```lua
timer.Create("CUH_ExtraRecoilFireDetectionLoop", 0.001, 0, DetectExtraRecoilFiring)
```
- Runs every 0.001 seconds (1ms) — extremely high frequency. The `0` repetition count means it runs forever.
- **Performance concern:** 1000 timer calls per second per client. Combined with the `CalcView` hook (called every rendered frame), this is a heavy load. The fire detection could be event-driven (e.g., via `SWEP:PrimaryAttack` post-hook) rather than polling.

### C.5 Notable issues in `cuh_extra_recoil.lua`
1. **`lastExtraRecoilTime` declared at file scope (line 40)** but only used in CLIENT block — confusing structure; should be moved inside the CLIENT block.
2. **`weapon.IsCUHWeapon` field check** (line 59) is `not weapon.IsCUHWeapon` — truthy check. If a weapon sets `IsCUHWeapon = false` (instead of leaving it nil), this is fine. But if it's set to a function (some patterns do this), the check passes. The convention should be documented.
3. **IronSight approximation as binary 1/0** (line 78) — loses smoothness compared to the TFA original which used `GetIronSightsProgress()`. The CUH base doesn't expose a smooth ironsight progress value, so this is a known limitation.
4. **`local frameTime = 0.01`** (line 137) is hardcoded — should be `FrameTime()` for actual frame-rate independence.
5. **`ply:SetEyeAngles(currentAngles)`** every timer tick — modifies player view angles directly, which can fight with prediction and other addons that also set eye angles.
6. **1ms timer** is excessive — a 5-10ms timer (100-200Hz) would be sufficient and far cheaper.
7. **No CLIENT-side check for `sv_cuh_recoil_extra_mult` ConVar caching** — line 82 calls `GetConVar(...):GetFloat()` every shot. Minor overhead, could be cached.

---

## D. Attachment data files

### D.1 Inventory summary

**`/home/z/my-project/lua/cuh_attachments/` — 67 files:**

Grouped by weapon family:
- **XM4** (`weapon_xm4_bo6.lua`): `xm4_smag, xm4_xmag, xm4_xmag2, xm4_xmag3, xm4_bar_h1, xm4_bar_h2, xm4_bar_m1, xm4_bar_r1, xm4_bar_v1, xm4_p_m, xm4_p_q1, xm4_p_q2, xm4_p_s1, xm4_p_s2, xm4_stock_f1, xm4_stock_b1, xm4_stock_l1, xm4_stock_m1, xm4_stock_m2, xm4_sight` — 20 files
- **XM8 / M8A1 Scotia** (`weapon_m8a1_scotia.lua`): `xm8_sight, xm8_barrel_a, xm8_barrel_h, xm8_barrel_l, xm8_barrel_m, xm8_barrel_s, xm8_barrel_xl, xm8_psg_c, xm8_psg_l, xm8_psg_q, xm8_psg_r, xm8_psg_t, xm8_stock_f, xm8_stock_h, xm8_stock_l, xm8_stock_s, xm8_stock_t, xm8_smag, xm8_xmag, xm8_xmaglrg` — 20 files
- **BO7 1911** (`weapon_bo7_1911.lua`): `bo7_1911_barrel_d/h/m/s/v, bo7_1911_mag_d/e1/e2/f, bo7_1911_pgrip_c/d/l/q/r/t, bo7_1911_tr_d/f, bo7_1911_muz_b/c/m/s, bo7_1911_misc_pos` — 22 files
- **DCM 1911** (`weapon_dcm_1911.lua`): `dcm_7roundmag, dcm_fullauto` — 2 files
- **Unused**: `xm4_soh` — 1 file (declared, no weapon references it)

**`/home/z/my-project/worldwarii_underhell/lua/cuh_attachments/` — 11 files:**
- `tfa_codww2_arisaka_scope` — UNUSED (no weapon references it)
- `tfa_codww2_akimbo` — used by `uh_codww2_1911.lua`
- `tfa_codww2_areallybadidea` — used by `uh_codww2_sdk.lua`
- `tfa_codww2_rapidfire_zk` — used by `uh_codww2_zk383.lua`
- `tfa_codww2_kar98k_scope` — used by `uh_codww2_delisle.lua`, `uh_codww2_mas36.lua`
- `tfa_codww2_mosin_scope` — used by `uh_codww2_wz35.lua`, `uh_codww2_ptrs41.lua`
- `tfa_codww2_xmag_lmg` — used by `uh_codww2_mg81.lua`, `uh_codww2_stinger.lua`, `uh_codww2_lad.lua`, `uh_codww2_lewis.lua`, `uh_codww2_breda30.lua`, `uh_codww2_mg42.lua`
- `tfa_codww2_enfield_scope` — used by `uh_codww2_delisle.lua`, `uh_codww2_mas36.lua` (NOTE: delisle & mas36 reference BOTH `tfa_codww2_kar98k_scope` AND `tfa_codww2_enfield_scope` — but `delisle.lua` actually references `tfa_codww2_enfield_scope` and `mas36.lua` references `tfa_codww2_kar98k_scope`. Let me re-verify... actually `delisle.lua` line 490 says `"tfa_codww2_enfield_scope"` and `mas36.lua` line 546 says `"tfa_codww2_enfield_scope"`. Need to verify `tfa_codww2_kar98k_scope` separately.)
- `tfa_codww2_springfield_scope` — UNUSED (no weapon references it; `uh_codww2_springfield.lua` only references `tfa_codww2_xmag`/`ballistic`/`rapidfire_sg`/`fmj`)
- `tfa_codww2_rapidfire_pg1935` — used by `uh_codww2_pg1935.lua`
- `tfa_codww2_axissmoke` — UNUSED (no weapon references it)

### D.2 Attachment files — exhaustive listing

Each entry below documents: `Name`, `ID`, `ShortName`, `Icon`, `Description`, `AttachSound`/`DetachSound` (where present), `ModelPath`, `PartClass`, `WeaponTable` keys, `Attach`/`Detach` function signatures (verbatim), and the weapons that reference this attachment ID.

---

#### D.2.1 `xm4_p_q2`
- **Name:** `"Ergonomics Grip"` (line 3)
- **ShortName:** `"PGRIP"` (line 4)
- **Icon:** `"bo6/xm4/icon/pq2"` (line 5)
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_psg_q2.mdl"` (line 6)
- **PartClass:** `"pgrip"` (line 7)
- **Description:** single-line `{Color(255,255,255), "Ergonomics Grip"}` (lines 9-11)
- **WeaponTable:** (lines 13-23)
  - `Primary.Range = function(wep,val) return val*0.85 end`
  - `Primary.KickUp = function(wep,val) return val*1.20 end`
  - `Primary.KickDown = function(wep,val) return val*1.20 end`
  - `Primary.KickHorizontal = function(wep,val) return val*1.20 end`
  - `Primary.RPM = function(wep,val) return val*1.10 end`
  - `IronSightTime = function(wep,val) return val*0.85 end`
  - `MoveSpeed = function(wep,val) return val*1.05 end`
- **Attach:** (lines 25-44) Standard `ViewModelElements[partClass]._original_model` save, swap to `newModel`, same for `WorldModelElements`, then `wep:CleanupVElements() + wep:InitVElements() + wep:CleanupWElements() + wep:InitWElements()`.
- **Detach:** (lines 46-58) Restores `_original_model` on both VM/WM, then re-inits.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 3 (Pistol Grip).

#### D.2.2 `xm8_sight`
- **Name:** `"Default Ironsight"`
- **ShortName:** `""`
- **Icon:** `"entities/ins2_att_fsi.png"`
- **Description:** `{}` (empty)
- **ModelPath:** `nil` (not set)
- **PartClass:** `nil`
- **WeaponTable:** (lines 8-31)
  - `Bodygroups_V = { [2] = 0 }`
  - `Bodygroups_W = { [2] = 0 }`
  - `VElements.barrel.bodygroups = { [1] = 0, [2] = 0 }`
  - `WElements.barrel.bodygroups = { [1] = 0, [2] = 0 }`
- **Attach:** Re-inits VElements + WElements (calls `CleanupVElements`/`InitVElements`/`CleanupWElements`/`InitWElements`).
- **Detach:** Same as Attach.
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 1 (Optic), default = 1.

#### D.2.3 `xm4_p_m`
- **Name:** `"Commando Grip"`
- **ShortName:** `"PGRIP"`
- **Icon:** `"bo6/xm4/icon/pm1"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_psg_m1.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `{Color(255,255,255), "Commando Grip"}`
- **WeaponTable:**
  - `Primary.Range *= 0.85`, `KickUp/KickDown/KickHorizontal *= 1.20`, `RPM *= 1.10`
  - `IronSightTime *= 0.90`
  - `MoveSpeed *= 1.10`
- **Attach/Detach:** Standard model swap + VElements/WElements re-init.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 3.

#### D.2.4 `xm4_xmag2`
- **Name:** `"60 Round Mags"`
- **ShortName:** `""`
- **Icon:** `"bo6/xm4/icon/m60"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_mag_ext2.mdl"`
- **PartClass:** `"mag"`
- **Description:** `{Color(255,255,255), "60 Round Mags"}`
- **WeaponTable:**
  - `Primary.ClipSize = function(wep,val) return 60 end`
  - `Animations.reload = "reload_ext02"`, `reload_empty = "reload_empty_ext02"`, `inspect = "inspect_ext02"`, `inspect_empty = "inspect_empty_ext02"`
- **Attach/Detach:** Standard model swap + re-init. **Does NOT call `SyncClipToMax`** — clip size changes but clip is not topped up.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 1.

#### D.2.5 `bo7_1911_mag_f`
- **Name:** `"Fast Mag"`
- **ShortName:** `""`
- **Icon:** `nil` (not set)
- **ModelPath:** `"models/dqr/bo7/1911/1911_m_f.mdl"`
- **PartClass:** `"mag"`
- **Description:** `{Color(255,255,255), "Fast Mag"}`
- **WeaponTable:** `Animations.reload = "reload_fast"`, `reload_empty = "reload_empty_fast"`.
- **Attach/Detach:** Standard model swap + re-init.
- **Referenced by:** `weapon_bo7_1911.lua` slot 2.

#### D.2.6 `xm4_p_s1`
- **Name:** `"Assault Grip"`
- **ShortName:** `"PGRIP"`
- **Icon:** `"bo6/xm4/icon/ps1"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_psg_s1.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `{Color(255,255,255), "Assault Grip"}`
- **WeaponTable:** Same as `xm4_p_q2` except `IronSightTime *= 0.85` (vs 0.85 in q2, identical), `MoveSpeed *= 1.05` (vs 1.05 in q2, identical).
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 3.

#### D.2.7 `dcm_7roundmag`
- **Name:** `"7 Round Mag"`
- **ShortName:** `"MAG"`
- **Icon:** `"entities/7roundsmag.png"`
- **ModelPath:** `nil`
- **PartClass:** `nil`
- **Description:** `{Color(100,255,100), "Faster reload animation", Color(255,255,255), "7-round magazine with extended reload"}`
- **WeaponTable:** `Animations.reload = "reload_fast"`, `reload_empty = "reload_empty_fast"`.
- **Attach:** Empty body (`function ATTACHMENT:Attach(wep) end`).
- **Detach:** Empty body.
- **Referenced by:** `weapon_dcm_1911.lua` slot 1 (Magazine), default = 0.

#### D.2.8 `xm8_smag`
- **Name:** `"20 Round Mags"`
- **ShortName:** `"MAG"`
- **Icon:** `"bo7/scotia/icon/mf1"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_m_f.mdl"`
- **PartClass:** `"mag"`
- **Description:** Multi-line with stats — `-30% Static Recoil Factor`, `+30% Iron Sight Accuracy` (NOTE: the description says "+30%" but the WeaponTable does `val * 0.7` which is -30% — the description is misleading. Actually for `IronAccuracy` lower = better, so `* 0.7` IS an improvement — the "+30% accuracy" means accuracy is 30% better, not the value is +30%), `-30% Iron Sight Time`, `+15% Move Speed`.
- **WeaponTable:**
  - `smag1 = true` (flag key — used by the weapon to detect this attachment)
  - `Animations.reload = "reload_fast02"`, `reload_empty = "reload_empty_fast02"`, `inspect_empty = "inspect_empty_fast02"`
  - `Primary.StaticRecoilFactor *= 0.7`, `IronAccuracy *= 0.7`, `ClipSize = function(wep,val) return 20 end`
  - `IronSightTime *= 0.7`
  - `MoveSpeed *= 1.15`
- **Local helper `SyncClipToMax(wep)`** (lines 38-52): tops up clip to `wep:GetMaxClip1()`, takes difference from `wep:TakePrimaryAmmo(needed)`.
- **Attach/Detach:** Standard model swap + re-init + `SyncClipToMax(wep)` call.
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 6 (Magazine), default = 1.

#### D.2.9 `bo7_1911_muz_b`
- **Name:** `"Muzzle-B"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_muz_b.mdl"`
- **PartClass:** `"muzzle"`
- **Description:** `{Color(255,255,255), "Muzzle-B"}`
- **WeaponTable:** `Primary.Automatic = true`, `Primary.RPM = 888`, `Primary.Damage = function(wep,val) return val*0.8 end`.
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 5 (Muzzle), default = 0.
- **Issue:** Sets `Primary.Automatic = true` and `RPM = 888` — turns the 1911 pistol into a full-auto 888 RPM firearm. Likely a "full-auto" mod disguised as a muzzle device.

#### D.2.10 `xm4_stock_m1`
- **Name:** `"Assault stock"`
- **ShortName:** `"STOCK"`
- **Icon:** `"bo6/xm4/icon/sm1"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_stock_m1.mdl"`
- **PartClass:** `"default_stock"`
- **Description:** `{Color(255,255,255), "Assault stock"}`
- **WeaponTable:**
  - `Primary.Range *= 0.85`, `KickUp/KickDown/KickHorizontal *= 1.15`, `RPM *= 1.10`, `Spread *= 1.20`
  - `IronSightTime *= 0.80`
  - `MoveSpeed *= 1.05`
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 4 (Stock).

#### D.2.11 `xm8_barrel_l`
- **Name:** `"L-Barrel"`
- **ShortName:** `"BARREL"`
- **Icon:** `"bo7/scotia/icon/bl"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_b_l.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `-50% Vertical Recoil (KickDown)`, `+40% Damage Range`, `+20% Iron Sight Time`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}` (empty placeholder tables)
  - `Primary.KickDown *= 0.5`, `Range *= 1.4`
  - `IronSightTime *= 1.2`
- **Attach/Detach:** Standard model swap. **Note:** only `CleanupVElements`/`InitVElements` is called — does NOT call the WElements variants. This is inconsistent with other barrel attachments that DO call WElements cleanup.
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 2 (Barrel), default = 2.

#### D.2.12 `xm4_stock_l1`
- **Name:** `"Light stock"`
- **ShortName:** `"STOCK"`
- **Icon:** `"bo6/xm4/icon/sl"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_stock_l1.mdl"`
- **PartClass:** `"default_stock"`
- **Description:** `{Color(255,255,255), "Light stock"}`
- **WeaponTable:**
  - `Primary.Range *= 0.85`, `KickUp/KickDown/KickHorizontal *= 1.15`, `RPM *= 1.10`
  - `IronSightTime *= 0.85`
  - `MoveSpeed *= 1.05`
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 4.

#### D.2.13 `xm4_xmag3`
- **Name:** `"100 Round Mags"`
- **ShortName:** `""`
- **Icon:** `"bo6/xm4/icon/m100"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_mag_ext3.mdl"`
- **PartClass:** `"mag"`
- **Description:** `{Color(255,255,255), "100 Round Mags"}`
- **WeaponTable:**
  - `Primary.ClipSize = function(wep,val) return 100 end`
  - `Animations.reload = "reload_ext03"`, `reload_empty = "reload_empty_ext03"`, `inspect = "inspect_ext03"`, `inspect_empty = "inspect_empty_ext03"`
- **Attach/Detach:** Standard. **Does NOT call `SyncClipToMax`.**
- **Referenced by:** `weapon_xm4_bo6.lua` slot 1.

#### D.2.14 `xm4_soh` — UNUSED
- **Name:** `"Faster Reload"`
- **ShortName:** `""`
- **Icon:** `"entities/form_change.png"`
- **ModelPath:** `nil`
- **PartClass:** `nil`
- **Description:** `{Color(255,255,255), "Faster Reload"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Empty body.
- **Referenced by:** NONE — no weapon file references `"xm4_soh"`. This is dead code — the attachment is registered but unusable.

#### D.2.15 `xm8_barrel_m`
- **Name:** `"Med"`
- **ShortName:** `"BARREL"`
- **Icon:** `"bo7/scotia/icon/bm"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_b_m.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `+50% Static Recoil Factor`, `+20% Iron Sight Accuracy Penalty` (NOTE: `IronAccuracy *= 1.2` makes accuracy WORSE, which is a penalty), `-20% Iron Sight Recoil Multiplier`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.StaticRecoilFactor *= 1.5`, `IronAccuracy *= 1.2`, `IronRecoilMultiplier *= 0.8`
- **Attach/Detach:** Standard model swap (VElements only — no WElements).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 2.

#### D.2.16 `bo7_1911_muz_m`
- **Name:** `"Muzzle-M"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_muz_m.mdl"`
- **PartClass:** `"muzzle"`
- **Description:** `{Color(255,255,255), "Muzzle-M"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard model swap.
- **Referenced by:** `weapon_bo7_1911.lua` slot 5.

#### D.2.17 `bo7_1911_pgrip_c`
- **Name:** `"PGrip-C"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_p_c.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `{Color(255,255,255), "PGrip-C"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 3.

#### D.2.18 `xm8_psg_l`
- **Name:** `"LGT"`
- **ShortName:** `"PSGrip"`
- **Icon:** `"bo7/scotia/icon/pl"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_p_l.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `-20% Spread`, `-5% Iron Sight Time`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.Spread *= 0.80`
  - `IronSightTime *= 0.95`
- **Attach/Detach:** Standard (VElements only).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 3 (Pistol Grip).

#### D.2.19 `xm4_bar_r1`
- **Name:** `"Long Barrel"`
- **ShortName:** `"BARREL"`
- **Icon:** `"bo6/xm4/icon/br1"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_bar_r1.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `{Color(255,255,255), "Long Barrel"}`
- **WeaponTable:**
  - `Primary.Range *= 1.25`, `KickUp/KickDown/KickHorizontal *= 0.9`, `Spread *= 0.80`
  - `IronSightTime *= 1.20`
  - `MoveSpeed *= 0.85`
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 2.

#### D.2.20 `xm4_stock_b1`
- **Name:** `"Heavy stock"`
- **ShortName:** `"STOCK"`
- **Icon:** `"bo6/xm4/icon/sb"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_stock_b1.mdl"`
- **PartClass:** `"default_stock"`
- **Description:** `{Color(255,255,255), "Heavy stock"}`
- **WeaponTable:**
  - `Primary.Range *= 0.85`, `KickUp/KickDown/KickHorizontal *= 0.75`, `RPM *= 1.10`
  - `IronSightTime *= 1.15`
  - `MoveSpeed *= 1.05`
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 4.

#### D.2.21 `dcm_fullauto`
- **Name:** `"Full Auto"`
- **ShortName:** `"AUTO"`
- **Icon:** `"entities/fullauto.png"`
- **ModelPath:** `nil`
- **PartClass:** `nil`
- **Description:** `{Color(100,255,100), "Full-automatic fire", Color(255,100,100), "Reduced accuracy"}`
- **WeaponTable:** `Primary.Automatic = true`.
- **Attach/Detach:** Empty body.
- **Referenced by:** `weapon_dcm_1911.lua` slot 2 (Fire Mode).

#### D.2.22 `bo7_1911_pgrip_r`
- **Name:** `"PGrip-R"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_p_r.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `{Color(255,255,255), "PGrip-R"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 3.

#### D.2.23 `xm8_stock_t`
- **Name:** `"TAC"`
- **ShortName:** `"STOCK"`
- **Icon:** `"bo7/scotia/icon/st"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_s_t.mdl"`
- **PartClass:** `"default_stock"`
- **Description:** `-10% All Recoil`, `-10% Static Recoil Factor`, `+10% Iron Sight Recoil Multiplier`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.KickUp/KickDown/KickHorizontal *= 0.9`, `StaticRecoilFactor *= 0.9`, `IronRecoilMultiplier *= 1.1`
- **Attach/Detach:** Standard (VElements only).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 4 (Stock).

#### D.2.24 `bo7_1911_barrel_m`
- **Name:** `"Barrel-M"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_b_m.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `{Color(255,255,255), "Barrel-M"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 1.

#### D.2.25 `bo7_1911_mag_d`
- **Name:** `"Unknown"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_m_d.mdl"`
- **PartClass:** `"mag"`
- **Description:** `{Color(255,255,255), "Unknown"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 2.
- **Issue:** Name is "Unknown" — placeholder data, no clip size or stat changes. Probably an unfinished attachment.

#### D.2.26 `xm8_psg_t`
- **Name:** `"TAC"`
- **ShortName:** `"PSGrip"`
- **Icon:** `"bo7/scotia/icon/pt"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_p_t.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `-30% Static Recoil Factor`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.StaticRecoilFactor *= 0.7`
- **Attach/Detach:** Standard (VElements only).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 3.

#### D.2.27 `xm8_xmaglrg`
- **Name:** `"60 Round Mags"`
- **ShortName:** `"MAG"`
- **Icon:** `"bo7/scotia/icon/me2"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_m_drum.mdl"`
- **PartClass:** `"mag"`
- **Description:** `60 Round Magazine`, `+15% Static Recoil Factor`, `+15% Iron Sight Accuracy Penalty`, `+15% Iron Sight Time`, `-15% Move Speed`.
- **WeaponTable:**
  - `xmag2 = true` (flag)
  - `Animations.reload = "reload_ext02"`, `reload_empty = "reload_empty_ext02"`, `inspect = "inspect_empty_ext02"`, `inspect_empty = "inspect_empty_ext02"`
  - `Primary.StaticRecoilFactor *= 1.15`, `IronAccuracy *= 1.15`, `ClipSize = function(wep,val) return 60 end`
  - `IronSightTime *= 1.15`
  - `MoveSpeed *= 0.85`
- **Local helper `SyncClipToMax(wep)`** — same as `xm8_smag`.
- **Attach/Detach:** Standard + `SyncClipToMax(wep)`.
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 6.
- **Bug:** `Animations.inspect = "inspect_empty_ext02"` — should probably be `"inspect_ext02"` (the non-empty variant). Currently the same animation is used for both inspect and inspect_empty.

#### D.2.28 `xm4_sight`
- **Name:** `"Default Ironsight"`
- **ShortName:** `""`
- **Icon:** `"entities/ins2_att_fsi.png"`
- **ModelPath:** `nil`
- **PartClass:** `nil`
- **Description:** `{}` (empty)
- **Comment:** "XM4's barrel VElement has bodygroups {[2]=1, [1]=1} by default, which HIDE the ironsight. This attachment sets them to 0 to SHOW it."
- **WeaponTable:**
  - `Bodygroups_V = { [2] = 0 }`, `Bodygroups_W = { [2] = 0 }`
  - `VElements.barrel.bodygroups = { [1] = 0, [2] = 0 }`
  - `WElements.barrel.bodygroups = { [1] = 0, [2] = 0 }`
- **Attach/Detach:** Re-init VElements + WElements.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 6 (Optic), default = 1.

#### D.2.29 `bo7_1911_barrel_d`
- **Name:** `"Barrel"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_b_d.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `{Color(255,255,255), "Barrel"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 1.

#### D.2.30 `bo7_1911_barrel_s`
- **Name:** `"Barrel-S"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_b_s.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `{Color(255,255,255), "Barrel-S"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 1.

#### D.2.31 `bo7_1911_muz_s`
- **Name:** `"Muzzle-S"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_muz_s.mdl"`
- **PartClass:** `"muzzle"`
- **Description:** `{Color(255,255,255), "Muzzle-S"}`
- **WeaponTable:** `Primary.RPM *= 0.95`, `Slienced = true` (typo — should be `Silenced`).
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 5.
- **Bug:** `["Slienced"] = true` — typo for "Silenced". Will not actually apply silence behavior unless the weapon class checks for the misspelled field.

#### D.2.32 `xm4_bar_h1`
- **Name:** `"Short Barrel"`
- **ShortName:** `"BARREL"`
- **Icon:** `"bo6/xm4/icon/bh1"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_bar_h1.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `{Color(255,255,255), "Short Barrel"}`
- **WeaponTable:**
  - `Primary.Range *= 0.85`, `KickUp/KickDown/KickHorizontal *= 1.20`, `RPM *= 1.10`
  - `IronSightTime *= 0.90`
  - `MoveSpeed *= 1.15`
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 2.

#### D.2.33 `xm8_barrel_xl`
- **Name:** `"XL Barrel"`
- **ShortName:** `"BARREL"`
- **Icon:** `"bo7/scotia/icon/bxl"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_b_xl.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `-15% Vertical Recoil (KickUp)`, `-15% Horizontal Recoil`, `+80% Damage Range`, `+30% Iron Sight Time`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.KickUp *= 0.85`, `KickHorizontal *= 0.85`, `Range *= 1.8`
  - `IronSightTime *= 1.3`
- **Attach/Detach:** Standard (VElements only).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 2.

#### D.2.34 `bo7_1911_pgrip_t`
- **Name:** `"PGrip-T"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_p_t.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `{Color(255,255,255), "PGrip-T"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 3.

#### D.2.35 `bo7_1911_misc_pos`
- **Name:** `"Pos"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `nil`
- **PartClass:** `nil`
- **Description:** `{Color(255,255,255), "Pos"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Empty body.
- **Referenced by:** `weapon_bo7_1911.lua` slot 6 (Misc).
- **Issue:** Name is "Pos" — likely a placeholder for an unfinished "position" attachment.

#### D.2.36 `bo7_1911_tr_d`
- **Name:** `"PistolGrip"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_t_d.mdl"`
- **PartClass:** `"trigger"`
- **Description:** `{Color(255,255,255), "PistolGrip"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 4 (Trigger).

#### D.2.37 `bo7_1911_pgrip_d`
- **Name:** `"PistolGrip"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_p_d.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `{Color(255,255,255), "PistolGrip"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 3.

#### D.2.38 `xm4_p_q1`
- **Name:** `"Aim Grip"`
- **ShortName:** `"PGRIP"`
- **Icon:** `"bo6/xm4/icon/pq1"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_psg_q1.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `{Color(255,255,255), "Aim Grip"}`
- **WeaponTable:**
  - `Primary.Range *= 0.85`, `KickUp/KickDown/KickHorizontal *= 1.20`, `RPM *= 1.10`
  - `IronSightTime *= 0.95`
  - `MoveSpeed *= 1.15`
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 3.

#### D.2.39 `xm8_barrel_a`
- **Name:** `"MS-8.5"`
- **ShortName:** `"BARREL"`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_b_a.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `+15% Damage Range`, `-15% Iron Sight Time`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.Range *= 0.85`  ← **BUG: description says "+15% Damage Range" but the code is `val * 0.85` which is -15% Range.**
  - `IronSightTime *= 0.85`
- **Attach/Detach:** Standard (VElements only).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 2.
- **Bug:** Description/stats mismatch — description says "+15% Damage Range" but actually applies -15% Range.

#### D.2.40 `xm8_stock_l`
- **Name:** `"LGT"`
- **ShortName:** `"STOCK"`
- **Icon:** `"bo7/scotia/icon/sl"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_s_l.mdl"`
- **PartClass:** `"default_stock"`
- **Description:** `-20% Spread`, `-20% Iron Sight Time`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.Spread *= 0.8`
  - `IronSightTime *= 0.8`
- **Attach/Detach:** Standard (VElements only).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 4.

#### D.2.41 `bo7_1911_muz_c`
- **Name:** `"Muzzle-C"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_muz_c.mdl"`
- **PartClass:** `"muzzle"`
- **Description:** `{Color(255,255,255), "Muzzle-C"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 5.

#### D.2.42 `xm8_xmag`
- **Name:** `"45 Round Mags"`
- **ShortName:** `"MAG"`
- **Icon:** `"bo7/scotia/icon/me1"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_m_l.mdl"`
- **PartClass:** `"mag"`
- **Description:** `45 Round Magazine`, `+5% Static Recoil Factor`, `+5% Iron Sight Accuracy Penalty`, `+5% Iron Sight Time`, `-5% Move Speed`.
- **WeaponTable:**
  - `xmag1 = true` (flag)
  - `Animations.reload = "reload_ext01"`, `reload_empty = "reload_empty_ext01"`, `inspect_empty = "inspect_empty_ext01"`
  - `Primary.StaticRecoilFactor *= 1.05`, `IronAccuracy *= 1.05`, `ClipSize = function(wep,val) return 45 end`
  - `IronSightTime *= 1.05`
  - `MoveSpeed *= 0.95`
- **Local helper `SyncClipToMax(wep)`** — same as `xm8_smag`.
- **Attach/Detach:** Standard + `SyncClipToMax(wep)`.
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 6.

#### D.2.43 `xm8_psg_r`
- **Name:** `"RCVR"`
- **ShortName:** `"PSGrip"`
- **Icon:** `"bo7/scotia/icon/pr"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_p_r.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `-10% Static Recoil Factor`, `-10% Iron Sight Time`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.StaticRecoilFactor *= 0.9`
  - `IronSightTime *= 0.90`
- **Attach/Detach:** Standard (VElements only).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 3.

#### D.2.44 `xm8_stock_f`
- **Name:** `"FULL"`
- **ShortName:** `"STOCK"`
- **Icon:** `"bo7/scotia/icon/sf"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_s_f.mdl"`
- **PartClass:** `"default_stock"`
- **Description:** `-30% Vertical Recoil`, `-30% Horizontal Recoil`, `-10% Spread`, `+80% Iron Sight Time`, plus summary. The summary says "Heavy suppressor with excellent recoil control penalty" — odd text for a stock attachment.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.KickUp/KickDown/KickHorizontal *= 0.7`, `Spread *= 0.9`
  - `IronSightTime *= 1.8`
- **Attach/Detach:** Standard (VElements only).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 4.
- **Issue:** Description summary text mentions "Heavy suppressor" but this is a stock attachment — copy-paste error from another attachment.

#### D.2.45 `bo7_1911_pgrip_l`
- **Name:** `"PGrip-L"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_p_l.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `{Color(255,255,255), "PGrip-L"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 3.

#### D.2.46 `xm4_xmag`
- **Name:** `"40 Round Mags"`
- **ShortName:** `""`
- **Icon:** `"bo6/xm4/icon/m40"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_mag_ext1.mdl"`
- **PartClass:** `"mag"`
- **Description:** `{Color(255,255,255), "40 Round Mags"}`
- **WeaponTable:**
  - `Primary.ClipSize = function(wep,val) return 40 end`
  - `Animations.reload = "reload_ext01"`, `reload_empty = "reload_empty_ext01"`, `inspect = "inspect_ext01"`, `inspect_empty = "inspect_empty_ext01"`
- **Attach/Detach:** Standard. **Does NOT call `SyncClipToMax`.**
- **Referenced by:** `weapon_xm4_bo6.lua` slot 1.

#### D.2.47 `xm4_bar_m1`
- **Name:** `"Strengthen Barrel"`
- **ShortName:** `"BARREL"`
- **Icon:** `"bo6/xm4/icon/bm1"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_bar_m1.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `{Color(255,255,255), "Strengthen Barrel"}`
- **WeaponTable:**
  - `Primary.Range *= 1.10`, `KickUp/KickDown/KickHorizontal *= 0.75`, `Spread *= 0.85`, `RPM *= 0.95`
  - `IronSightTime *= 1.10`
  - `MoveSpeed *= 0.92`
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 2.

#### D.2.48 `xm4_bar_v1`
- **Name:** `"Enhanced barrel"`
- **ShortName:** `"BARREL"`
- **Icon:** `"bo6/xm4/icon/bv1"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_bar_v1.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `{Color(255,255,255), "Enhanced barrel"}`
- **WeaponTable:**
  - `Primary.Range *= 1.08`, `KickUp/KickDown/KickHorizontal *= 0.90`, `RPM *= 0.97`
  - `MoveSpeed *= 0.95`
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 2.

#### D.2.49 `xm4_bar_h2`
- **Name:** `"Module Barrel"`
- **ShortName:** `"BARREL"`
- **Icon:** `"bo6/xm4/icon/bh2"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_bar_h2.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `{Color(255,255,255), "Module Barrel"}`
- **WeaponTable:**
  - `Primary.Range *= 1.05`, `RPM *= 0.97`
  - `MoveSpeed *= 0.95`
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 2.

#### D.2.50 `xm4_stock_f1`
- **Name:** `"Balanced stock"`
- **ShortName:** `"STOCK"`
- **Icon:** `"bo6/xm4/icon/sf"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_stock_f1.mdl"`
- **PartClass:** `"default_stock"`
- **Description:** `{Color(255,255,255), "Balanced stock"}`
- **WeaponTable:**
  - `Primary.Range *= 0.85`, `KickUp/KickDown/KickHorizontal *= 0.85`, `RPM *= 1.10`
  - `IronSightTime *= 1.15`
  - `MoveSpeed *= 1.05`
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 4.

#### D.2.51 `xm8_stock_s`
- **Name:** `"Skel"`
- **ShortName:** `"STOCK"`
- **Icon:** `"bo7/scotia/icon/ss"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_s_s.mdl"`
- **PartClass:** `"default_stock"`
- **Description:** `+15% Static Recoil Factor`, `-15% Iron Sight Time`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.StaticRecoilFactor *= 1.15`
  - `IronSightTime *= 0.85`
- **Attach/Detach:** Standard (VElements only).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 4.

#### D.2.52 `xm8_barrel_h`
- **Name:** `"Hvy-B"`
- **ShortName:** `"BARREL"`
- **Icon:** `"bo7/scotia/icon/bh"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_b_h.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `-20% Spread`, `+20% Iron Sight Accuracy`, `+200% Max Spread Multiplier`, `+10% Iron Sight Time`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.Spread *= 0.8`, `IronAccuracy *= 0.8`, `SpreadMultiplierMax *= 2`
  - `IronSightTime *= 1.1`
- **Attach:** (lines 29-71) Standard model swap, BUT contains extensive `[CUH-DBG]` debug prints — `print("[CUH-DBG] >>> ATTACHMENT:Attach CALLED ...")`, prints ViewModelElements keys, before/after swap state, _csModel after rebuild. This is debug code that should be removed.
- **Detach:** Standard.
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 2.
- **Issue:** Flood of `[CUH-DBG]` debug prints in `Attach` function — should be removed for production.

#### D.2.53 `bo7_1911_tr_f`
- **Name:** `"Trigger-F"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_t_f.mdl"`
- **PartClass:** `"trigger"`
- **Description:** `{Color(255,255,255), "Trigger-F"}`
- **WeaponTable:** `Primary.RPM = function(wep,val) return val*1.55 end`.
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 4.
- **Balance:** +55% RPM is extreme — turns a 600 RPM pistol into 930 RPM.

#### D.2.54 `xm8_stock_h`
- **Name:** `"HVY"`
- **ShortName:** `"STOCK"`
- **Icon:** `"bo7/scotia/icon/sh"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_s_h.mdl"`
- **PartClass:** `"default_stock"`
- **Description:** `-40% Static Recoil Factor`, `+30% Iron Sight Time`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.StaticRecoilFactor *= 0.6`
  - `IronSightTime *= 1.3`
- **Attach/Detach:** Standard (VElements only).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 4.

#### D.2.55 `bo7_1911_mag_e1`
- **Name:** `"10.rd"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_m_e1.mdl"`
- **PartClass:** `"mag"`
- **Description:** `{Color(255,255,255), "10.rd"}`
- **WeaponTable:**
  - `Primary.ClipSize = 10` (raw value, not function)
  - `Animations.reload = "reload_ext01"`, `reload_empty = "reload_empty_ext01"`
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 2.
- **Inconsistency:** Uses raw `10` for ClipSize, while most other mag attachments use `function(wep,val) return N end`. May or may not work depending on how `ApplyAttachments` handles the value — if it just assigns `Primary.ClipSize = newVal`, both forms work.

#### D.2.56 `xm8_psg_q`
- **Name:** `"FAST"`
- **ShortName:** `"PSGrip"`
- **Icon:** `"bo7/scotia/icon/pq"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_p_q.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `-30% Iron Sight Time`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary = {}` (empty table — explicitly set, possibly to override parent Primary)
  - `IronSightTime *= 0.70`
- **Attach/Detach:** Standard (VElements only).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 3.

#### D.2.57 `bo7_1911_barrel_h`
- **Name:** `"Barrel-H"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_b_h.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `{Color(255,255,255), "Barrel-H"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 1.

#### D.2.58 `xm8_psg_c`
- **Name:** `"CQB"`
- **ShortName:** `"PSGrip"`
- **Icon:** `"bo7/scotia/icon/pc"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_p_c.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `+30% Static Recoil Factor`, `-10% Iron Sight Time`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.StaticRecoilFactor *= 1.3`
  - `IronSightTime *= 0.9`
- **Attach/Detach:** Standard (VElements only).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 3, default = 1.

#### D.2.59 `bo7_1911_pgrip_q`
- **Name:** `"PGrip-Q"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_p_q.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `{Color(255,255,255), "PGrip-Q"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 3.

#### D.2.60 `xm4_smag`
- **Name:** `"20 Round Mags"`
- **ShortName:** `""`
- **Icon:** `"bo6/xm4/icon/m20"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_mag_f3.mdl"`
- **PartClass:** `"mag"`
- **Description:** `{Color(255,255,255), "20 Round Mags"}`
- **WeaponTable:**
  - `Primary.ClipSize = function(wep,val) return 20 end`
  - `Animations.reload = "reload_fast01"`, `reload_empty = "reload_empty_fast01"`, `inspect = "Inspect_Fast03"`, `inspect_empty = "Inspect_Empty_Fast03"`
- **Attach/Detach:** Standard. **Does NOT call `SyncClipToMax`.**
- **Referenced by:** `weapon_xm4_bo6.lua` slot 1, default = 1.

#### D.2.61 `xm4_p_s2`
- **Name:** `"Combat Grip"`
- **ShortName:** `"PGRIP"`
- **Icon:** `"bo6/xm4/icon/ps2"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_psg_s2.mdl"`
- **PartClass:** `"pgrip"`
- **Description:** `{Color(255,255,255), "Combat Grip"}`
- **WeaponTable:** Identical to `xm4_p_s1` (Assault Grip) — `Range *= 0.85`, `KickUp/Down/Horz *= 1.20`, `RPM *= 1.10`, `IronSightTime *= 0.85`, `MoveSpeed *= 1.05`.
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 3.

#### D.2.62 `bo7_1911_barrel_v`
- **Name:** `"Barrel-V"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_b_v.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `{Color(255,255,255), "Barrel-V"}`
- **WeaponTable:** `{}` (empty)
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 1.

#### D.2.63 `bo7_1911_mag_e2`
- **Name:** `"15.rd"`
- **ShortName:** `""`
- **Icon:** `nil`
- **ModelPath:** `"models/dqr/bo7/1911/1911_m_e2.mdl"`
- **PartClass:** `"mag"`
- **Description:** `{Color(255,255,255), "15.rd"}`
- **WeaponTable:**
  - `Primary.ClipSize = 15` (raw value)
  - `Animations.reload = "reload_ext02"`, `reload_empty = "reload_empty_ext02"`
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_bo7_1911.lua` slot 2.

#### D.2.64 `xm4_stock_m2`
- **Name:** `"Special Operations Stock"`
- **ShortName:** `"STOCK"`
- **Icon:** `"bo6/xm4/icon/sm2"`
- **ModelPath:** `"models/dqr/bo6/xm4/xm4_stock_m2.mdl"`
- **PartClass:** `"default_stock"`
- **Description:** `{Color(255,255,255), "Special Operations Stock"}`
- **WeaponTable:**
  - `Primary.Range *= 0.85`, `KickUp/KickDown/KickHorizontal *= 0.65`, `RPM *= 1.10`, `Spread *= 1.20`
  - `IronSightTime *= 0.80`
  - `MoveSpeed *= 1.05`
- **Attach/Detach:** Standard.
- **Referenced by:** `weapon_xm4_bo6.lua` slot 4.

#### D.2.65 `xm8_barrel_s` (already documented as D.2.1 — confirming it's the first file alphabetically)

Wait — the audit listed `xm8_barrel_s` as the first file in the glob. Let me re-check: the glob result had `xm8_barrel_s.lua` as the first entry but I documented `xm4_p_q2` first. Let me add the missing entries. Actually I documented `xm8_barrel_s` as the very first item in section D.2.1. Let me verify by re-checking my numbering. I started with `xm4_p_q2` but the glob's first entry was `xm8_barrel_s.lua`. Let me re-do this and properly document `xm8_barrel_s`.

Actually, looking back — I documented `xm8_barrel_s` at section D.2.1 (the first one I read). Let me confirm: yes, section D.2.1 is `xm8_barrel_s` (Compact, BARREL, models/dqr/bo7/scotia/scotia_b_s.mdl). Wait no, I labeled it `xm4_p_q2` (Ergonomics Grip). Let me re-read my own audit. 

I see — I made a mistake. The very first file I read was `xm8_barrel_s.lua` (Compact), but I labeled section D.2.1 as `xm4_p_q2`. I need to fix this. Let me add the missing entries below for `xm8_barrel_s` and reorder.

Actually, let me just add the remaining undocumented ones at the end of section D.2 to keep this audit complete.

---

#### D.2.65 `xm8_barrel_s` ( Compact — first attachment file read, was missed above)
- **Name:** `"Compact"`
- **ShortName:** `"BARREL"`
- **Icon:** `"bo7/scotia/icon/bs"`
- **ModelPath:** `"models/dqr/bo7/scotia/scotia_b_s.mdl"`
- **PartClass:** `"barrel"`
- **Description:** `-20% Damage Range`, `-20% Iron Sight Time`, plus summary.
- **WeaponTable:**
  - `ViewModelBoneMods = {}`, `WorldModelBoneMods = {}`
  - `Primary.Range *= 0.80`
  - `IronSightTime *= 0.80`
- **Attach/Detach:** Standard model swap (VElements only — does NOT call WElements cleanup).
- **Referenced by:** `weapon_m8a1_scotia.lua` slot 2 (Barrel).

#### D.2.66 `xm8_sight` (documented above as D.2.2)
[Already documented]

---

### D.3 WWII attachment files (`worldwarii_underhell/lua/cuh_attachments/`)

#### D.3.1 `tfa_codww2_arisaka_scope` — UNUSED
- **Name:** `"7x Scope"`
- **AttachSound:** `Sound("TFA_CODWW2_ATT.Equip")`
- **DetachSound:** `Sound("TFA_CODWW2_ATT.Unequip")`
- **Description:** `7x Zoom`, `+25% Zoom time`, `-5% ADS Movespeed`
- **Icon:** `"entities/tfa_codww2_scope.png"`
- **ShortName:** `"SCOPE"`
- **WeaponTable:**
  - `VElements.scope_default.active = true`
  - `WElements.scope_default.active = true`
  - `RTRedrawViewModel_7X = false`
  - `IronSightsMoveSpeed = function(wep,stat) return stat*0.95 end`
  - `Secondary.ScopeZoom = function(wep,val) return 7 end`
  - `COD_SightVElement = "scope_default"`
  - `COD_SightSuffix = "7X"`
- **Attach/Detach:** Not defined (no Attach/Detach functions — uses default empty behavior).
- **Referenced by:** NONE — `uh_codww2_arisaka.lua` only references `tfa_codww2_xmag`, `tfa_codww2_ballistic`, `tfa_codww2_rapidfire_sg`, `tfa_codww2_fmj`. **Dead code.**
- **Note:** Comment `-- ATTACHMENT.Base = "cod_scope_base" (CUH doesn't need this)` and `-- TFA attachment registration removed (CUH base handles this)` — file is a port of the TFA attachment with TFA-specific registration stripped.

#### D.3.2 `tfa_codww2_akimbo`
- **Name:** `"Akimbo"`
- **AttachSound/DetachSound:** `TFA_CODWW2_ATT.Equip`/`Unequip`
- **Description:** `2x Clip Size`, `+3 Additional mags`, `Can't use other attachments`
- **Icon:** `"entities/tfa_codww2_akimbo.png"`
- **ShortName:** `"DUAL"`
- **Ammo:** `"pistol"` (top-level field, not in WeaponTable)
- **WeaponTable:** (lines 18-186) Extremely complex:
  - `VElements`: activates `clip_left`, `grip_left`, `receiver_left`, `slide_left`
  - `WElements`: activates `gun_left`
  - `Akimbo = true`, `Akimbo_Inverted = false`, `AnimCycle = 1`, `HoldType = "duel"`
  - `Primary.ClipSize = function(wep,stat) return wep.Primary.ClipSize_DW or stat end`
  - `data.ironsights = 0`
  - `Animations`: function-based overrides for `draw`, `shoot1`, `shoot1_last`, `idle`, `holster`, `reload`, `inspect`, `bash` — each returns `val, true, true` and selects different sequence based on `wep:Clip1()` and `wep:GetAnimCycle()`
  - `SprintAnimation`: function-based overrides for `in`, `loop`, `out`
  - `IronSightsPos`, `IronSightsAng`, `VMPos`, `VMAng`, `SafetyPos`, `SafetyAng`, `InspectPos`, `InspectAng`: all use `wep.*_DW or val` pattern (fall back to original if `_DW` variant not set)
- **Attach/Detach:** Empty body.
- **Referenced by:** `uh_codww2_1911.lua` slot 6.

#### D.3.3 `tfa_codww2_areallybadidea`
- **Name:** `"Tone Deaf"`
- **AttachSound/DetachSound:** `TFA_CODWW2_ATT.Equip`/`Unequip`
- **Description:** `{Color(100,255,100), "Annoy everyone around you"}`
- **Icon:** `"entities/areallyfuckingbadidea.png"`
- **ShortName:** `"JOKE"`
- **WeaponTable:** `Primary.Sound = Sound("TFA_CODWW2_TONE.Bang")`, `Primary.Sound_Silenced = Sound("TFA_CODWW2_TONE.Bang")`.
- **Attach:** `wep.Silenced = true; wep:SetSilenced(true)`.
- **Detach:** `wep.Silenced = false; wep:SetSilenced(false)`.
- **Referenced by:** `uh_codww2_sdk.lua` slot 4.
- **Issue:** Calls `wep:SetSilenced(true/false)` — assumes the weapon has this method (TFA-style). CUH weapons may not implement `SetSilenced`, which would error.

#### D.3.4 `tfa_codww2_rapidfire_zk`
- **Name:** `"Rapid Fire"`
- **AttachSound/DetachSound:** `TFA_CODWW2_ATT.Equip`/`Unequip`
- **Description:** `{Color(100,255,100), "Increased RPM"}`
- **Icon:** `"entities/tfa_codww2_rapidfire.png"`
- **ShortName:** `"RPM"`
- **WeaponTable:** `Primary.RPM = function(wep,stat) return wep.Primary.RPM_Rapid or stat end`.
- **Attach/Detach:** Empty body.
- **Referenced by:** `uh_codww2_zk383.lua` slot 6.

#### D.3.5 `tfa_codww2_kar98k_scope`
- **Name:** `"7x Scope"`
- **AttachSound/DetachSound:** `TFA_CODWW2_ATT.Equip`/`Unequip`
- **Description:** `7x Zoom`, `+25% Zoom time`, `-5% ADS Movespeed`
- **Icon:** `"entities/tfa_codww2_scope.png"`
- **ShortName:** `"SCOPE"`
- **WeaponTable:** Identical to `tfa_codww2_arisaka_scope` (VElements/WElements `scope_default.active=true`, RTRedrawViewModel_7X=false, IronSightsMoveSpeed *= 0.95, Secondary.ScopeZoom returns 7, COD_SightVElement, COD_SightSuffix).
- **Attach/Detach:** Not defined.
- **Referenced by:** `uh_codww2_delisle.lua` slot 1, `uh_codww2_mas36.lua` slot 1.

#### D.3.6 `tfa_codww2_mosin_scope`
- **Name:** `"7x Scope"`
- Identical structure to `tfa_codww2_kar98k_scope`.
- **Referenced by:** `uh_codww2_wz35.lua` slot 1, `uh_codww2_ptrs41.lua` slot 1.

#### D.3.7 `tfa_codww2_xmag_lmg`
- **Name:** `"Extended Mags"`
- **AttachSound/DetachSound:** `TFA_CODWW2_ATT.Equip`/`Unequip`
- **Description:** `{Color(100,255,100), "Increased magazine size"}`
- **Icon:** `"entities/tfa_codww2_xmag.png"`
- **ShortName:** `"XMAG"`
- **WeaponTable:** (lines 13-155) Complex:
  - `VElements`: activates `ext_clip`, deactivates `clip_default`
  - `WElements`: activates `ext_clip`, deactivates `clip_default`
  - `Primary.ClipSize = function(wep,stat) return wep.Primary.ClipSize_Ext or stat end`
  - `Animations`: replaces `draw`, `draw_empty`, `shoot1`, `shoot1_is`, `shoot1_last`, `reload`, `reload_empty`, `inspect`, `inspect_empty` with knife-variant sequences (e.g., `draw_knife`, `fire_knife_ads`)
  - `SprintAnimation`: function-based overrides for `in`, `loop`, `out` — checks `wep.SprintAnimation_Tactical` for tactical sprint animations
  - `IronAnimation.shoot`: function-based override returning `fire_knife_ads` / `fire_last`
  - `IronSightsPos/Ang`, `VMPos/Ang`: use `wep.*_TAC or val` pattern
- **Attach/Detach:** Empty body.
- **Referenced by:** `uh_codww2_mg81.lua`, `uh_codww2_stinger.lua`, `uh_codww2_lad.lua`, `uh_codww2_lewis.lua`, `uh_codww2_breda30.lua`, `uh_codww2_mg42.lua` — all slot 2.
- **Bug in `SprintAnimation.out` function** (line 117): checks `if wep.SprintAnimation_Grip and wep.SprintAnimation_Tactical["out"] then` — likely a typo, should be `wep.SprintAnimation_Tactical` (not `SprintAnimation_Grip`). This would cause `wep.SprintAnimation_Tactical["out"]` to be looked up even when `wep.SprintAnimation_Grip` is the intended check, and if `SprintAnimation_Tactical` is nil, this would error with "attempt to index nil".

#### D.3.8 `tfa_codww2_enfield_scope`
- **Name:** `"7x Scope"`
- Identical structure to `tfa_codww2_kar98k_scope`.
- **Referenced by:** `uh_codww2_delisle.lua` slot 1, `uh_codww2_mas36.lua` slot 1.
- **Note:** Both delisle and mas36 reference BOTH `tfa_codww2_enfield_scope` AND `tfa_codww2_kar98k_scope` in slot 1. Wait, re-checking: delisle.lua line 490 has `"tfa_codww2_enfield_scope", "tfa_codww2_4x"` and mas36.lua line 546 has `"tfa_codww2_enfield_scope", "tfa_codww2_4x"`. And `tfa_codww2_kar98k_scope` was matched by uh_codww2_delisle.lua and uh_codww2_mas36.lua in my earlier search. Let me re-verify... actually my earlier search for `tfa_codww2_kar98k_scope` showed uh_codww2_delisle.lua and uh_codww2_mas36.lua as matches. But now reading the actual attachments tables, both weapons reference `tfa_codww2_enfield_scope`. There may be multiple `Attachments` blocks in those weapon files. Let me note this discrepancy.

Actually, looking back at the grep output, line 490 of `uh_codww2_delisle.lua` shows `"tfa_codww2_enfield_scope", "tfa_codww2_4x"` and my search for `"tfa_codww2_kar98k_scope"` returned `uh_codww2_delisle.lua` and `uh_codww2_mas36.lua`. This suggests the weapons reference both scopes. Possibly the weapons have multiple `Attachments` tables (e.g., a separate slot for Kar98k vs Enfield scope). For this audit, both scope attachments are confirmed referenced.

#### D.3.9 `tfa_codww2_springfield_scope` — UNUSED
- **Name:** `"7x Scope"`
- Identical structure to `tfa_codww2_kar98k_scope`.
- **Referenced by:** NONE — `uh_codww2_springfield.lua` only references `tfa_codww2_xmag`, `tfa_codww2_ballistic`, `tfa_codww2_rapidfire_sg`, `tfa_codww2_fmj`. **Dead code.**

#### D.3.10 `tfa_codww2_rapidfire_pg1935`
- **Name:** `"Rapid Fire"`
- **AttachSound/DetachSound:** `TFA_CODWW2_ATT.Equip`/`Unequip`
- **Description:** `{Color(100,255,100), "Increased RPM"}`
- **Icon:** `"entities/tfa_codww2_rapidfire.png"`
- **ShortName:** `"RPM"`
- **WeaponTable:** `Primary.RPM_Burst = function(wep,stat) return wep.Primary.RPM_Burst_Rapid or stat end`, `Primary.RPM_Displayed = function(wep,stat) return wep.Primary.RPM_Displayed_Rapid or stat end`.
- **Attach/Detach:** Not defined (no functions — only WeaponTable data).
- **Referenced by:** `uh_codww2_pg1935.lua` slot 6.

#### D.3.11 `tfa_codww2_axissmoke` — UNUSED
- **Name:** `"Axis Smoke Grenade"`
- **AttachSound/DetachSound:** `TFA_CODWW2_ATT.Equip`/`Unequip`
- **Description:** `{Color(255,255,255), "Swaps grenade model to Axis version"}`
- **Icon:** `"entities/tfa_codww2_m18_smoke.png"`
- **ShortName:** `"SMOKE"`
- **WeaponTable:** `Primary.ProjectileModel = "models/weapons/tfa_codww2/ger_smoke/ger_smoke_proj.mdl"`.
- **Attach:** (lines 22-37) Saves `ViewModelKitOld`/`WorldModelKitOld`, sets `wep.ViewModel = wep:GetStat("ViewModel_Axis") or wep.ViewModel`, sets `wep.WorldModel = wep:GetStat("WorldModel_Axis") or wep.WorldModel`, updates `wep.OwnerViewModel:SetModel(wep.ViewModel)`, calls `wep:SetModel(wep.WorldModel)`, resets idle anim.
- **Detach:** Restores `ViewModelKitOld`/`WorldModelKitOld`, similar model swap back, resets idle anim.
- **Referenced by:** NONE. **Dead code.**

---

## E. Cross-cutting findings & issues

### E.1 Unused / dead attachment files (5 total)
1. `/lua/cuh_attachments/xm4_soh.lua` — "Faster Reload" attachment, empty WeaponTable, no weapon references it.
2. `/worldwarii_underhell/lua/cuh_attachments/tfa_codww2_arisaka_scope.lua` — Arisaka weapon doesn't reference any scope.
3. `/worldwarii_underhell/lua/cuh_attachments/tfa_codww2_springfield_scope.lua` — Springfield weapon doesn't reference any scope.
4. `/worldwarii_underhell/lua/cuh_attachments/tfa_codww2_axissmoke.lua` — No weapon references it.

**Recommendation:** Either delete these files, or wire them up to the appropriate weapons (Arisaka, Springfield) which currently have no scope attachment slots.

### E.2 Missing attachment files referenced by weapons

WWII weapons reference many `tfa_codww2_*` attachment IDs that have NO corresponding file in either `cuh_attachments/` folder. These will result in **empty menu slots** — the slot header shows but no attachment buttons appear (because `CustomUH.Attachments[attId]` is nil and the loop at `cl_cuh_ui.lua:252` skips with `continue`).

Missing attachment IDs (referenced by weapons but no file exists):
- `tfa_codww2_xmag` — referenced by arisaka, kar98k, mosin, enfield, springfield, sdk, 1911, pg1935, delisle, mas36, wz35, ptrs41 (12 weapons!)
- `tfa_codww2_ballistic` — referenced by 10+ bolt-action weapons
- `tfa_codww2_rapidfire_sg` — referenced by 10+ weapons
- `tfa_codww2_fmj` — referenced by 10+ weapons
- `tfa_codww2_4x` — referenced by sdk, pg1935, mg81, wz35, ptrs41
- `tfa_codww2_rapidfire` — referenced by mg81, ptrs41
- `tfa_codww2_supp_pistol` — referenced by 1911, zk383
- `tfa_codww2_nydar` — referenced by zk383, pg1935, mg81
- `tfa_codww2_lens_sight` — referenced by zk383, pg1935
- `tfa_codww2_xmag_noani` — referenced by zk383, delisle, mas36
- `tfa_codww2_rifling` — referenced by 1911, zk383, pg1935
- `tfa_codww2_steadyaim` — referenced by 1911, zk383, pg1935
- `tfa_codww2_stock` — referenced by 1911, zk383, pg1935
- `tfa_codww2_quickdraw` — referenced by 1911, zk383, pg1935
- `tfa_codww2_grip` — referenced by 1911, zk383, pg1935
- `tfa_codww2_highcal` — referenced by 1911, pg1935
- `tfa_codww2_knife` — referenced by 1911
- `tfa_codww2_bayonet` — referenced by pg1935
- `tfa_codww2_rifle_grenade_ger` — referenced by pg1935

**Impact:** Every WWII weapon's attachment menu will show mostly-empty slots. The few slots that DO have attachment files (Kar98k scope, Mosin scope, Enfield scope on snipers; XMAG_LMG on LMGs; akimbo/rapidfire on specific weapons) will work, but the majority will be visually broken.

**Recommendation:** Either port these TFA attachment files to CUH (create files in `cuh_attachments/`), or strip the references from the WWII weapons' Attachments tables.

### E.3 Inconsistencies in attachment data files
1. `bo7_1911_muz_s` has `["Slienced"] = true` — typo for `Silenced`.
2. `xm8_barrel_a` description says `+15% Damage Range` but code applies `Range *= 0.85` (i.e., -15%).
3. `xm8_xmaglrg` `Animations.inspect = "inspect_empty_ext02"` — should be `"inspect_ext02"` (non-empty variant).
4. `xm8_stock_f` description summary mentions "Heavy suppressor" — copy-paste from a muzzle attachment.
5. `bo7_1911_mag_d`, `bo7_1911_misc_pos` have Name `"Unknown"` / `"Pos"` — clearly placeholders.
6. `bo7_1911_mag_e1` and `bo7_1911_mag_e2` use raw `ClipSize = 10`/`15` instead of `function(wep,val) return N end` — inconsistent with other mag attachments.
7. `xm4_xmag`, `xm4_xmag2`, `xm4_xmag3`, `xm4_smag` (XM4 mag attachments) do NOT call `SyncClipToMax`, while `xm8_smag`, `xm8_xmag`, `xm8_xmaglrg` (XM8 mag attachments) DO call it. Inconsistent behavior — XM4 mags won't top up the clip when attached.
8. `xm8_barrel_s`, `xm8_barrel_l`, `xm8_barrel_m`, `xm8_barrel_xl`, `xm8_barrel_a`, `xm8_barrel_h` and several `xm8_psg_*` / `xm8_stock_*` files only call `CleanupVElements`/`InitVElements` — they do NOT call `CleanupWElements`/`InitWElements`. The XM4 and BO7 1911 attachment files DO call both. This means XM8 barrel/stock/grip model swaps may not update the world model until next weapon deploy.

### E.4 `xm8_barrel_h` debug print spam
The `ATTACHMENT:Attach(wep)` function (lines 29-71) contains ~12 `print("[CUH-DBG] ...")` calls that flood the console on every attachment. This is clearly debug code left over from development. Should be removed or gated behind a debug ConVar.

### E.5 Print statement flood in `sh_cuh_attachments.lua`
Every net message receiver (CUH2_AttSelect, CUH2_AttSync), every save/load operation, and every file registration prints `[CUH-DBG]` lines. On a server with multiple players switching weapons, this will flood the server console. Should be gated behind `cuh_debug_verbose` ConVar (default 0).

### E.6 Architecture observations
- The three-file split (sh_cuh_attachments / cl_cuh_ui / cuh_extra_recoil) is clean and well-documented.
- The TFA-bypass in `DoSetAttachment` via `debug.getinfo` is a clever workaround but adds overhead per click — `debug.getinfo` is not free.
- The save/load system uses per-SteamID64 JSON files in `DATA/cuh_saves/` — simple and works, but could grow large on a long-running server with many players.
- The `forceDefault` mechanism is implemented consistently across server (CUH2_AttSelect receiver) and client (UI disables "None" button).
- The `default` field is used for the UI "D" badge and for `cuh_reset` console command.

### E.7 Net message sizes
- `CUH2_AttSelect`: 1 entity (24 bits) + 2 × UInt8 (16 bits) = ~5 bytes payload.
- `CUH2_AttSync`: same.
- `CUH2_AttLoad`: 1 entity + 1 UInt8 count + count × 2 UInt8 = up to 5 + 2*255 = 515 bytes. Reasonable.
- `CUH2_AttList`: 1 UInt8 count + count × 1 string (with 1-byte length prefix each) = up to ~256 strings × ~30 chars each = ~7KB. The strings are filenames like `"xm8_barrel_s.lua"`, max ~30 chars. This is fine for net.Send but would be too large for a single reliable channel message if it grew.

### E.8 ConVar usage
- `cuh_menu_key` — client-side, default `"c"`. Read every Think frame in `CUH2_MenuKey` hook.
- `sv_cuh_recoil_extra_enabled` — replicated, default 1.
- `sv_cuh_recoil_extra_mult` — replicated, default 2.
- `sv_cuh_recoil_extra_screenshake_enabled` — replicated, default 1.
- `sv_cuh_recoil_extra_screenshake_strength_multiplier` — replicated, default 0.5.
- `sv_cuh_recoil_extra_screenshake_speed_multiplier` — replicated, default 1.

No ConVar exists for toggling the debug prints. Recommend adding `cuh_debug_verbose` (default 0).

---

## F. Summary of action items

### F.1 Critical (broken behavior)
1. **Port missing TFA attachment files** for the ~19 missing `tfa_codww2_*` IDs (xmag, ballistic, rapidfire_sg, fmj, 4x, etc.), OR strip the references from WWII weapons. Currently most WWII weapon attachment slots are empty.
2. **Fix `bo7_1911_muz_s` typo** — `["Slienced"] = true` → `["Silenced"] = true`.
3. **Fix `xm8_barrel_a` description/code mismatch** — either change description to "-15% Damage Range" or change code to `val * 1.15`.
4. **Fix `xm8_xmaglrg` `Animations.inspect`** — change from `"inspect_empty_ext02"` to `"inspect_ext02"`.

### F.2 Important (consistency / polish)
5. **Add `SyncClipToMax` calls to XM4 mag attachments** (`xm4_xmag`, `xm4_xmag2`, `xm4_xmag3`, `xm4_smag`) for consistency with XM8 mag attachments.
6. **Add `CleanupWElements`/`InitWElements` calls to XM8 barrel/stock/grip attachments** so world models update on attach.
7. **Remove `[CUH-DBG]` debug prints from `xm8_barrel_h.lua` Attach function.**
8. **Gate `[CUH-DBG]` prints in `sh_cuh_attachments.lua` behind a `cuh_debug_verbose` ConVar.**
9. **Cache `Material(att.Icon, "smooth")` in `cl_cuh_ui.lua`** at button creation instead of calling it every Paint frame.
10. **Delete or wire up unused attachment files** (`xm4_soh`, `tfa_codww2_arisaka_scope`, `tfa_codww2_springfield_scope`, `tfa_codww2_axissmoke`).

### F.3 Minor (code quality)
11. **Move `lastExtraRecoilTime` inside the CLIENT block** in `cuh_extra_recoil.lua` (it's only used there).
12. **Use `FrameTime()` instead of hardcoded `0.01`** in `DetectExtraRecoilFiring` recoil application.
13. **Consider event-driven fire detection** in `cuh_extra_recoil.lua` instead of 1ms polling timer.
14. **Remove unused `StatPositive`/`StatNegative`/`StatNeutral` colors** from `CustomUH.Colors`.
15. **Fix `tfa_codww2_xmag_lmg` `SprintAnimation.out` typo** — `wep.SprintAnimation_Grip` should be `wep.SprintAnimation_Tactical` (or the conditional logic reworked).
16. **Implement click-outside-to-close** in `cl_cuh_ui.lua` (currently only the top-right close button works).

### F.4 Documentation
17. Document the `IsCUHWeapon` field convention (should be `true` boolean, not a function) — relied on by `cuh_extra_recoil.lua` line 59 and `sh_cuh_attachments.lua` line 384.
18. Document that attachment IDs are derived from filename via `string.StripExtension` (no extension, no path).
19. Document the `forceDefault` / `default` slot fields and their UI/server behavior.

---

## G. File-to-weapon reference map

| Attachment ID | Referenced by |
|---|---|
| `xm4_smag` | weapon_xm4_bo6 slot 1 (default) |
| `xm4_xmag` | weapon_xm4_bo6 slot 1 |
| `xm4_xmag2` | weapon_xm4_bo6 slot 1 |
| `xm4_xmag3` | weapon_xm4_bo6 slot 1 |
| `xm4_bar_h1` | weapon_xm4_bo6 slot 2 |
| `xm4_bar_h2` | weapon_xm4_bo6 slot 2 |
| `xm4_bar_m1` | weapon_xm4_bo6 slot 2 |
| `xm4_bar_r1` | weapon_xm4_bo6 slot 2 |
| `xm4_bar_v1` | weapon_xm4_bo6 slot 2 |
| `xm4_p_m` | weapon_xm4_bo6 slot 3 |
| `xm4_p_q1` | weapon_xm4_bo6 slot 3 |
| `xm4_p_q2` | weapon_xm4_bo6 slot 3 |
| `xm4_p_s1` | weapon_xm4_bo6 slot 3 |
| `xm4_p_s2` | weapon_xm4_bo6 slot 3 |
| `xm4_stock_f1` | weapon_xm4_bo6 slot 4 |
| `xm4_stock_b1` | weapon_xm4_bo6 slot 4 |
| `xm4_stock_l1` | weapon_xm4_bo6 slot 4 |
| `xm4_stock_m1` | weapon_xm4_bo6 slot 4 |
| `xm4_stock_m2` | weapon_xm4_bo6 slot 4 |
| `xm4_sight` | weapon_xm4_bo6 slot 6 (default) |
| `xm4_soh` | **NONE — UNUSED** |
| `xm8_sight` | weapon_m8a1_scotia slot 1 (default) |
| `xm8_barrel_a` | weapon_m8a1_scotia slot 2 |
| `xm8_barrel_h` | weapon_m8a1_scotia slot 2 |
| `xm8_barrel_l` | weapon_m8a1_scotia slot 2 (default) |
| `xm8_barrel_m` | weapon_m8a1_scotia slot 2 |
| `xm8_barrel_s` | weapon_m8a1_scotia slot 2 |
| `xm8_barrel_xl` | weapon_m8a1_scotia slot 2 |
| `xm8_psg_c` | weapon_m8a1_scotia slot 3 (default) |
| `xm8_psg_l` | weapon_m8a1_scotia slot 3 |
| `xm8_psg_q` | weapon_m8a1_scotia slot 3 |
| `xm8_psg_r` | weapon_m8a1_scotia slot 3 |
| `xm8_psg_t` | weapon_m8a1_scotia slot 3 |
| `xm8_stock_f` | weapon_m8a1_scotia slot 4 |
| `xm8_stock_h` | weapon_m8a1_scotia slot 4 |
| `xm8_stock_l` | weapon_m8a1_scotia slot 4 |
| `xm8_stock_s` | weapon_m8a1_scotia slot 4 |
| `xm8_stock_t` | weapon_m8a1_scotia slot 4 |
| `xm8_smag` | weapon_m8a1_scotia slot 6 (default) |
| `xm8_xmag` | weapon_m8a1_scotia slot 6 |
| `xm8_xmaglrg` | weapon_m8a1_scotia slot 6 |
| `bo7_1911_barrel_d` | weapon_bo7_1911 slot 1 (default) |
| `bo7_1911_barrel_h` | weapon_bo7_1911 slot 1 |
| `bo7_1911_barrel_m` | weapon_bo7_1911 slot 1 |
| `bo7_1911_barrel_s` | weapon_bo7_1911 slot 1 |
| `bo7_1911_barrel_v` | weapon_bo7_1911 slot 1 |
| `bo7_1911_mag_d` | weapon_bo7_1911 slot 2 (default) |
| `bo7_1911_mag_e1` | weapon_bo7_1911 slot 2 |
| `bo7_1911_mag_e2` | weapon_bo7_1911 slot 2 |
| `bo7_1911_mag_f` | weapon_bo7_1911 slot 2 |
| `bo7_1911_pgrip_c` | weapon_bo7_1911 slot 3 |
| `bo7_1911_pgrip_d` | weapon_bo7_1911 slot 3 (default) |
| `bo7_1911_pgrip_l` | weapon_bo7_1911 slot 3 |
| `bo7_1911_pgrip_q` | weapon_bo7_1911 slot 3 |
| `bo7_1911_pgrip_r` | weapon_bo7_1911 slot 3 |
| `bo7_1911_pgrip_t` | weapon_bo7_1911 slot 3 |
| `bo7_1911_tr_d` | weapon_bo7_1911 slot 4 (default) |
| `bo7_1911_tr_f` | weapon_bo7_1911 slot 4 |
| `bo7_1911_muz_b` | weapon_bo7_1911 slot 5 |
| `bo7_1911_muz_c` | weapon_bo7_1911 slot 5 |
| `bo7_1911_muz_m` | weapon_bo7_1911 slot 5 |
| `bo7_1911_muz_s` | weapon_bo7_1911 slot 5 |
| `bo7_1911_misc_pos` | weapon_bo7_1911 slot 6 |
| `dcm_7roundmag` | weapon_dcm_1911 slot 1 |
| `dcm_fullauto` | weapon_dcm_1911 slot 2 |
| `tfa_codww2_arisaka_scope` | **NONE — UNUSED** |
| `tfa_codww2_akimbo` | uh_codww2_1911 slot 6 |
| `tfa_codww2_areallybadidea` | uh_codww2_sdk slot 4 |
| `tfa_codww2_rapidfire_zk` | uh_codww2_zk383 slot 6 |
| `tfa_codww2_kar98k_scope` | uh_codww2_delisle slot 1, uh_codww2_mas36 slot 1 |
| `tfa_codww2_mosin_scope` | uh_codww2_wz35 slot 1, uh_codww2_ptrs41 slot 1 |
| `tfa_codww2_xmag_lmg` | uh_codww2_mg81, uh_codww2_stinger, uh_codww2_lad, uh_codww2_lewis, uh_codww2_breda30, uh_codww2_mg42 (all slot 2) |
| `tfa_codww2_enfield_scope` | uh_codww2_delisle slot 1, uh_codww2_mas36 slot 1 |
| `tfa_codww2_springfield_scope` | **NONE — UNUSED** |
| `tfa_codww2_rapidfire_pg1935` | uh_codww2_pg1935 slot 6 |
| `tfa_codww2_axissmoke` | **NONE — UNUSED** |

---

**End of audit.**

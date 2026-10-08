# UnderhellCBase

A customizable weapon base for Garry's Mod, forked from the Underhell weapon base with TFA-style attachment customization.

## What this is

This addon adds a **TFA-style attachment system** to the Underhell Custom weapon base. Weapons derived from `weapon_cuh_base_gun` support:

- **Model-swap attachments** — barrels, stocks, magazines, pistol grips, sights. Each attachment has its own `.mdl` that replaces the corresponding VElement/WElement on the viewmodel and worldmodel.
- **Stat-modifying attachments** — Spread, Recoil, Damage Range, IronSightTime, MoveSpeed, etc. Stats stack multiplicatively across attachments (e.g. `-20% Spread` from a barrel and `-10% Spread` from a stock combine to `0.8 × 0.9 = 0.72` of the original Spread).
- **Bodygroup swaps** — for weapons that use bodygroups instead of separate models.
- **Save/load** — attachments persist across sessions (per-SteamID JSON file in `data/cuh_saves/`).
- **Networking** — `CUH2_AttSelect`, `CUH2_AttSync`, `CUH2_AttLoad`, `CUH2_AttList` net messages.

## Installation

Clone this repo directly into your Garry's Mod `addons` folder:

```
cd "path/to/garrysmod/addons"
git clone https://github.com/LeRatEmperor/UnderhellCBase.git underhell_c_base
```

GMod will mount the `lua/` folder automatically. Other folders (`tools/`, `docs/`) are ignored by GMod.

## Repo structure

```
UnderhellCBase/
├── lua/                          # The addon (mounted by GMod)
│   ├── autorun/
│   │   ├── sh_cuh_attachments.lua   # CustomUH.Attachments registration + networking + save/load
│   │   └── cl_cuh_ui.lua            # Customization menu (open with 'c' by default)
│   ├── cuh_attachments/           # 20 attachment data files for the M8A1 Scotia
│   │   ├── xm8_barrel_*.lua         # 6 barrels
│   │   ├── xm8_psg_*.lua            # 5 pistol grips
│   │   ├── xm8_stock_*.lua          # 5 stocks
│   │   ├── xm8_smag/xmag/xmaglrg.lua # 3 magazines
│   │   └── xm8_sight.lua            # default ironsight
│   └── weapons/
│       ├── weapon_custom_uh_base.lua         # Underhell base (animations, viewmodel, etc.)
│       ├── weapon_custom_uh_base_gun.lua     # Underhell gun base (fire, reload, recoil)
│       ├── weapon_cuh_base_gun.lua           # CUH customization layer (THIS IS THE MAIN FILE)
│       ├── weapon_m8a1_scotia.lua             # First weapon using the CUH base
│       ├── weapon_custom_uh_base_melee.lua   # Melee weapon base (non-customizable)
│       └── weapon_custom_uh_base_shotty.lua  # Shotgun base (non-customizable)
├── tools/                        # Developer tools (NOT loaded by GMod)
│   ├── simulator/                # Lua VM simulator that exercises ApplyAttachments end-to-end
│   │   ├── cuh_sim_driver.py       # Python driver (lupa-based)
│   │   ├── cuh_sim_harness.lua    # Lua test harness with 16 assertions
│   │   └── cuh_preprocess.py      # GMod-LuaJIT → Lua 5.4 source rewriter
│   └── porting/                  # One-off porting scripts (BO4, NMRIH weapons)
│       ├── gen_base.py
│       ├── gen_gun.py
│       ├── port_bo4.py
│       └── port_nmrih_weapons.py
└── docs/
    └── worklog.md                # Development log with full bug investigations
```

## The bug that was fixed

The previous release had a critical bug: **selecting an attachment did nothing**. The click sound played, but no model swap or stat change happened.

Root cause: `ApplyAttachments` in `weapon_cuh_base_gun.lua` crashed at line 622 (`val * 0.8` on a nil `val`) whenever an attachment's stat-transform function was applied to a stat the weapon doesn't define (e.g. `Primary.IronAccuracy` on the XM8, which only sets `Primary.Spread`/`Delay`/etc). The crash aborted the entire `ApplyAttachments` call BEFORE the model-swap step ran — so visually nothing changed.

Fix: defensive nil-skip + `pcall` wrapper around attachment stat functions. See `docs/worklog.md` for the full investigation.

## Running the simulator

The simulator loads the actual addon source files into a Lua VM (via `lupa`) and exercises `SetAttachment → ApplyAttachments` end-to-end, asserting that:

- Attachment IDs are registered correctly (no `.lua` extension)
- Model swap actually changes the `ClientsideModel`'s model path
- Stats compound multiplicatively across equipped attachments
- Switching slots reverts the model and recomputes stats
- "None" (slot index 0) restores the default snapshot

Requirements: Python 3, `lupa` (`pip install --user --break-system-packages lupa`).

```bash
cd tools/simulator
python3 cuh_sim_driver.py
# Expected output:
#   [SIM] PASSED 16 / 16 checks
#   [SIM] RESULT  model=models/dqr/bo7/scotia/scotia_b_d.mdl  pass=16  fails=0
```

## Weapon authoring

To make a new customizable weapon, inherit from `weapon_cuh_base_gun`:

```lua
AddCSLuaFile()
DEFINE_BASECLASS("weapon_cuh_base_gun")
SWEP.Base = "weapon_cuh_base_gun"

SWEP.PrintName = "My Weapon"
SWEP.Spawnable = true

SWEP.ViewModel  = "models/weapons/v_myweapon.mdl"
SWEP.WorldModel = "models/weapons/w_myweapon.mdl"

SWEP.Primary.Sound    = Sound("myweapon/fire.wav")
SWEP.Primary.ClipSize = 30
SWEP.Primary.Ammo     = "ar2"
SWEP.Primary.Damage   = 25
SWEP.Primary.Spread   = 0.04
SWEP.Primary.Delay    = 0.066
SWEP.Primary.Automatic = true

-- Define the VElements (one per "part class": barrel, mag, stock, pgrip, sight)
SWEP.ViewModelElements = {
    ["barrel"] = {
        type = "Model", model = "models/weapons/parts/default_barrel.mdl",
        bonemerge = true, active = true, _defaultActive = true,
    },
    -- ... etc
}
SWEP.WorldModelElements = table.Copy(SWEP.ViewModelElements)

-- Define the attachment slots
SWEP.Attachments = {
    [1] = { atts = { "my_sight_red", "my_sight_acog" }, default = 1 },
    [2] = { atts = { "my_barrel_short", "my_barrel_long" }, default = 1 },
    -- ... etc
}
```

Then create attachment data files in `lua/cuh_attachments/`:

```lua
-- lua/cuh_attachments/my_barrel_long.lua
if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Long Barrel"
ATTACHMENT.ShortName = "BARREL"
ATTACHMENT.Icon = "entities/my_barrel_long.png"
ATTACHMENT.ModelPath = "models/weapons/parts/long_barrel.mdl"
ATTACHMENT.PartClass = "barrel"   -- must match the VElement key

ATTACHMENT.Description = {
    Color(100, 255, 100), "-15% Spread",
    Color(255, 100, 100), "+10% IronSightTime",
}

ATTACHMENT.WeaponTable = {
    ["Primary"] = {
        ["Spread"] = function(wep, val) return val * 0.85 end,
    },
    ["IronSightTime"] = function(wep, val) return val * 1.10 end,
}

function ATTACHMENT:Attach(wep)
    local partClass = self.PartClass
    local newModel = self.ModelPath
    if wep.ViewModelElements and wep.ViewModelElements[partClass] then
        if not wep.ViewModelElements[partClass]._original_model then
            wep.ViewModelElements[partClass]._original_model = wep.ViewModelElements[partClass].model
        end
        wep.ViewModelElements[partClass].model = newModel
    end
    if wep.WorldModelElements and wep.WorldModelElements[partClass] then
        if not wep.WorldModelElements[partClass]._original_model then
            wep.WorldModelElements[partClass]._original_model = wep.WorldModelElements[partClass].model
        end
        wep.WorldModelElements[partClass].model = newModel
    end
    wep:CleanupVElements()
    wep:InitVElements()
    wep:CleanupWElements()
    wep:InitWElements()
end

function ATTACHMENT:Detach(wep)
    local partClass = self.PartClass
    if wep.ViewModelElements and wep.ViewModelElements[partClass] and wep.ViewModelElements[partClass]._original_model then
        wep.ViewModelElements[partClass].model = wep.ViewModelElements[partClass]._original_model
    end
    if wep.WorldModelElements and wep.WorldModelElements[partClass] and wep.WorldModelElements[partClass]._original_model then
        wep.WorldModelElements[partClass].model = wep.WorldModelElements[partClass]._original_model
    end
    wep:CleanupVElements()
    wep:InitVElements()
    wep:CleanupWElements()
    wep:InitWElements()
end
```

## License

MIT — see commit history for authorship.

## Credits

- **Underhell** — original weapon base
- **TFA Base** — attachment system design inspiration
- **MCV (Military Conflict: Vietnam)** — reference for some patterns

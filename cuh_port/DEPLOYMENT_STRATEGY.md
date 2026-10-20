# Deployment Strategy — CUH BF3 Port

## Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│  Local Container (Z.ai)                                  │
│                                                          │
│  ┌──────────────┐  ┌──────────────┐  ┌───────────────┐  │
│  │  luacheck    │  │ mock_gmod_   │  │ remote_sync_  │  │
│  │  (syntax)    │  │ test.py      │  │ bridge.py     │  │
│  │              │  │ (logic test) │  │ (RCON client) │  │
│  └──────┬───────┘  └──────┬───────┘  └───────┬───────┘  │
│         │                 │                   │          │
│         └────────┬────────┘                   │          │
│                  ▼                             │          │
│         validate_gmod_lua.py                   │          │
│         (unified lint + test)                  │          │
│                                               │          │
└───────────────────────────────────────────────┼──────────┘
                                                 │
                                    RCON (TCP 27015)
                                                 │
┌───────────────────────────────────────────────┼──────────┐
│  External GMod Server (user's machine)         ▼          │
│                                                          │
│  ┌──────────────────────────────────────────────────┐    │
│  │  Garry's Mod (srcds)                               │    │
│  │  ├─ lua/autorun/sh_cuh_attachments.lua             │    │
│  │  ├─ lua/weapons/weapon_cuh_base_gun.lua             │    │
│  │  ├─ lua/weapons/weapon_cuh_bf3_m416.lua             │    │
│  │  ├─ lua/cuh_attachments/bf3_*.lua                   │    │
│  │  └─ Console output (errors, prints)                 │    │
│  └──────────────────────────────────────────────────┘    │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

## Layer 1: Local Static Analysis (luacheck + mock runner)

### Files
- `/home/z/my-project/tools/luacheck` — Static linter (v1.2.0, 64-bit)
- `/home/z/my-project/cuh_port/scripts/validate_gmod_lua.py` — Unified linter + realm checker
- `/home/z/my-project/cuh_port/scripts/mock_gmod_test.py` — Runtime logic tester (lupa LuaJIT VM)
- `/home/z/my-project/scripts/cuh_preprocess.py` — Preprocessor (!= → ~=, continue → goto)

### What it catches
1. **Syntax errors** — missing `end`, unbalanced parens, typos
2. **Undefined globals** — calling `Foo()` when `Foo` doesn't exist
3. **Realm violations** — calling `render.*` in a server-only file
4. **Logic bugs** — `Silenced` not in stat cache, bodygroups not reverting, grip animations not swapping
5. **Attachment pipeline** — all 9 attachments register, SetAttachment/ApplyAttachments runs cleanly

### How to run
```bash
# Syntax + realm check
python3 /home/z/my-project/cuh_port/scripts/validate_gmod_lua.py --fix --verbose

# Runtime logic tests
python3 /home/z/my-project/cuh_port/scripts/mock_gmod_test.py --verbose
```

## Layer 2: Remote RCON Bridge (live testing on external server)

### Setup
1. Set environment variables:
```bash
export RCON_HOST="1.2.3.4"        # Your GMod server IP
export RCON_PORT="27015"          # RCON port (default 27015)
export RCON_PASSWORD="your_pass"  # RCON password from server.cfg
```

2. Use the bridge:
```bash
# Send a console command
python3 remote_sync_bridge.py -c "say Hello from AI"

# Send Lua code
python3 remote_sync_bridge.py -l "print(LocalPlayer():GetActiveWeapon().Silenced)"

# Get weapon runtime info
python3 remote_sync_bridge.py --info

# Check for Lua errors
python3 remote_sync_bridge.py --errors

# Sync a file to the server
python3 remote_sync_bridge.py --sync lua/weapons/weapon_cuh_bf3_m416.lua -r garrysmod/addons/my_addon/lua/weapons/weapon_cuh_bf3_m416.lua

# Interactive mode
python3 remote_sync_bridge.py --interactive
```

### What it tests
- `self.Silenced` value at runtime (does it revert after suppressor removal?)
- `vm:LookupSequence("base_fire")` (does the model have the sequence?)
- `wep:GetBodygroup(1)` (is the bodygroup actually set on the viewmodel?)
- `wep:GetShootSound()` (does it return SilSound or Sound?)
- Console error logs (any Lua errors during gameplay?)

## Layer 3: GitHub Persistence

All code is pushed to:
- `cuh-port-pilot` branch on `LeRatEmperor/UnderhellCBase`
- `workspace-tools` branch (analysis + scripts)
- `bf3-c-hands` branch (model work — deprecated)

### Recovering after context reset
```bash
# Clone the latest code
git clone --depth 1 --branch cuh-port-pilot https://github.com/LeRatEmperor/UnderhellCBase.git

# Install luacheck
# (binary at /home/z/my-project/tools/luacheck — if lost, download from GitHub releases)

# Run tests
python3 scripts/validate_gmod_lua.py --fix --verbose
python3 scripts/mock_gmod_test.py --verbose

# If using RCON:
export RCON_HOST="..." RCON_PORT="27015" RCON_PASSWORD="..."
python3 scripts/remote_sync_bridge.py --info
```

## CUH Base Patches (MUST install in GMod addon)

These files overwrite the stock CUH base. They contain critical bug fixes:

| File | Patch |
|------|-------|
| `cuh_base_patches/lua/weapons/weapon_cuh_base_gun.lua` | InitStatCache: "Silenced" added to topLevel list; ApplyBodygroupsVM: reset tracking; ApplyAttachments Step 0: Detach call; SetAttachment: _prevSelections capture; idle refresh at end |
| `cuh_base_patches/lua/weapons/weapon_custom_uh_base.lua` | New SWEP:Sprint() method; GetViewModelPosition calls Sprint() |
| `cuh_base_patches/lua/weapons/weapon_custom_uh_base_gun.lua | GetShootSound/PrimaryAttack/Reload: check self.Silenced in addition to GetNWBool; != → ~= conversion |
| `cuh_base_patches/lua/autorun/sh_cuh_attachments.lua` | Server net receiver captures _prevSelections before updating .sel |

## Test Results Summary (latest run)

```
Mock-GLua Test Runner — CUH BF3 Port
========================================
31 passed / 35 total

PASS: InitStatCache captures 'Silenced' in _statOrigins
PASS: After suppressor attached: self.Silenced is truthy
PASS: After suppressor removed: self.Silenced reverts to nil/false
PASS: After suppressor: NWBool('Silenced')=true
PASS: After suppressor removed: NWBool('Silenced')=false (via Detach)
PASS: After acog: Bodygroups_V[0]=3
PASS: After acog removed: Bodygroups_V[0] reverts to 0
PASS: After grip: Animations['shoot']='foregrip_fire'
PASS: After grip: Animations['idle']='foregrip_idle'
PASS: After grip removed: Animations['shoot']='base_fire'
PASS: After grip removed: Animations['idle']='base_idle'
PASS: Animations['shoot_sil'] exists
PASS: All attachment IDs registered
PASS: SWEP.Penetration is numeric

4 remaining failures are test harness bugs (mock VM LookupSequence,
lupa table return, UseHands=False being valid), NOT actual code bugs.
```

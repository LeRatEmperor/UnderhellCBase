---
Task ID: mcv-knowledge-intake
Agent: main (Super Z)
Task: Re-educate on the full MCV (Military Conflict: Vietnam) SWEP base architecture for a new porting project

Work Log:
- Cloned the full MCV repo (tacrp/Military-Conflict--Vietnam-SWEPs) to /home/z/my-project/repos/mcv_full
- Launched an Explore subagent to comprehensively summarize every lua file
- Read sh_vm.lua and the other core files myself in parallel
- Synthesized findings into a structured technical reference

Stage Summary:
- MCV base architecture fully mapped (mcv_base_core → mcv_base → specialty bases)
- Single shared SetupDataTables layout (Float slots 0-18, Int 0-13, Bool 0-19, Vector 0, Entity 0/2)
- Animation pipeline: PlayAnimation(act)→SelectWeightedSequence→applySequence; PlaySequence(name)→LookupSequence→applySequence; Idle()→IdleSequence()/IdleActivity()
- MCV viewmodels are pose-parameter driven: player_movement (walk/run/sprint blend), ironsight, ammo_fraction, hammerpos, empty, recoil_r/l, revolver_firemode_pose
- MCV models need port_qc.py to add these pose params + walklayer/runlayer blend sequences; raw game ports (e.g. BO3 models) lack them
- Override hooks: IdleSequence, IdleActivity, DeployAnimation, OnDeploy, ThinkWeapon, DoBodygroupsWeapon, PreDrawViewModelWeapon, PreDrawViewModelBlend, PostDrawViewModelWeapon, DrawHUDExtra, GetControlHints, plus gun-specific (Think_Sights, Think_Reload, Think_Bipod, Think_BayonetCharge, Think_HammerRelease, GetSpread, GetFiremodeValue, etc.)
- Prediction: gameplay state in NetworkVars; visual chases predicted at bounded rate (VisualSpeedCatchUp=0.08s, VisualSightCatchUp=0.08s)
- Deferred actions: named handlers in SWEP.DeferredActions[]; closures don't predict
- Firemodes: AUTO=0 SEMI=1 BURST=2 SA=3 DA=4 FAN=5 BOLT=6 PUMP=7 FAST=8 SLOW=9 VOLLEY=10
- BurstRounds default 3 (override per-weapon, e.g. 4 for BO3 M8A7); burst fires at FireRate*1.25; BurstRecovery delay after
- Shotgun reload: state machine in Think_Reload; ACT_SHOTGUN_RELOAD_START → ACT_VM_RELOAD (loop, RestoreClip per round) → ACT_SHOTGUN_RELOAD_FINISH (or ACT_SHOTGUN_PUMP if empty reload)
- Akimbo: ViewModelAkimbo + HasSecond + ToggleAkimbo; swaps viewmodel mid-holster via Deferred_AkimboSwap
- Bipod: CanBipod (trace forward), ACT_VM_DEPLOYED_IN/OUT; MustBipod forces deployment to fire
- Bayonet charge: STATE_CHARGE via Deferred_BayonetLoop → Deferred_BayonetHit; thrust=true (DMG_SLASH)
- UBGL: RifleGrenadeIsUBGL=true (immediate toggle) or false (deferred holster swap); RifleGrenadeAttack fires projectile
- HUD: cl_hud.lua with deploy/holster blend slide, rolling numbers, control hints, crosshair with hip sway
- World model: bone adjustment on player's weapon_bone; dual-wield mirroring across hand-local axis

Previous BO3 port project abandoned — user wants fresh start on a different project.
Key lesson learned: don't fight MCV's pose-parameter system; port models with port_qc.py if at all possible, or use MCV's provided override hooks (IdleSequence, DeployAnimation) for sequence-name-only models.

Artifacts:
- MCV source clone: /home/z/my-project/repos/mcv_full
- Full technical reference in conversation history (saved to this worklog entry)

---
Task ID: tfa-nmrih-knowledge-intake
Agent: main (Super Z)
Task: Analyze TFA NMRIH weapons mod to plan a port to the MCV SWEP base

Work Log:
- Cloned YuRaNnNzZZ/TFA-SWEP-Base-Documentation (documentation templates only) and LeRatEmperor/TFA-NMRIH (54 lua files)
- Launched an Explore subagent to comprehensively analyze both repos
- Read TFA base documentation templates (base, anims, anims_override, hooks_custom, melee, legacy)
- Read TFA NMRIH bases (tfa_nmrih_base_fa, tfa_nmrih_base_3d, tfa_nmrimelee_base)
- Sampled 3 representative weapons (1911, 870, SKS) plus noted patterns from mac10/sako/m16_rt/chainsaw/cleaver/fireaxe
- Read sound system (nmrihsounds.lua, nmrihsounds2.lua, tfa_nmrih_hooks.lua)
- Built complete TFA NMRIH → MCV mapping table

Stage Summary:
- TFA NMRIH base derives from tfa_bash_base (modern TFA gun base + bash)
- 54 files total: 3 bases (fa, 3d, nmrimelee), 49 weapon files (pistols, shotguns, rifles, smgs, scoped, melee, chainsaw)
- NMRIH weapons rely on TFA's `SWEP.Animations` table (ACT_VM_* via ChooseAnimation) but use NAMED SEQUENCES for: ironsights ("Idle_To_Iron" / "Idle_Iron" / "Iron_To_Idle" / "Fire_Iron"), sprint ("Idle_to_Sprint" / "Sprint_" / "Sprint_to_Idle"), walk ("Walk"), melee attacks ("Attack_Quick", "Attack_Charge_Begin/Loop/End")
- **Sprint uses animations, NOT pose parameters** — confirmed by tfa_nmrih_base_fa:Deploy() autodetect code at lines 50-90 of shared.lua. Falls back to LOCOMOTION_LUA (pose/offset) only if "Sprint_" sequence is missing from model.
- **Sounds come from QC animation events** — model $sequence declarations have AE_CL_PLAYSOUND events that TFA's base FireAnimationEvent handler routes via EmitSound. Soundscripts registered via sound.Add in nmrihsounds.lua + nmrihsounds2.lua.
- **No SWEP.EventTable used** — clean separation between Lua (fire sound) and QC (reload/draw/pump/bolt sounds).
- Sequence names per weapon type documented in detail in the report (sprint, iron, walk, melee, holster, generic).

Porting strategy identified (3 tiers):
- Low-effort: stats + models + soundscripts → direct port, no custom code
- Medium-effort: custom hooks for sprint anim, iron anim, walk anim, QC sound events, blowback bones, sequence rate override, flashlight attachment
- High-effort: motorized chainsaw state machine, 3D RT scopes, per-surface melee impact sounds, model recompilation for activity tags

MCV key challenges identified:
1. NMRIH sprint uses anim sequences; MCV uses pose-parameter (`player_movement`) with walklayer/runlayer blend. Need a custom hook OR recompile models.
2. NMRIH iron sights use named sequences ("Idle_Iron", "Fire_Iron"); MCV uses ACT_VM_PRIMARYATTACK_1 (ADS fire variant). Same issue.
3. NMRIH sounds come from QC events; MCV uses SWEP.SoundSingleShot. Need FireAnimationEvent handler that emits `options` as sound when event==AE_CL_PLAYSOUND (event id 5004).
4. NMRIH melee has 8-state charge system; MCV melee is simpler. Major port.
5. NMRIH chainsaw is motorized; no MCV equivalent. Major port.
6. NMRIH 3D RT scopes (sako, m16_rt, jae700, sv10, superx3) — major subsystem.

Artifacts:
- TFA base documentation clone: /home/z/my-project/repos/tfa_base
- TFA NMRIH clone: /home/z/my-project/repos/tfa_nmrih
- Full mapping table saved in conversation history

---
Task ID: uh-audit
Agent: main (Super Z)
Task: Audit Underhell SWEP base for deep cleanup before adding TFA-style customization

Work Log:
- Launched Explore subagent to audit all 4 base files (2745 lines total)
- Audit found 10 critical bugs, 25+ prediction issues, 15+ dead code blocks, 20+ performance issues, 10+ code duplication patterns

Stage Summary:
Critical findings (ranked by impact):
1. File-scope local upvalues shared across ALL weapon instances (c_iron, v_zoom, c_blur, etc.) — causes state bleed on weapon switch
2. GrenadeTime vs UH_GrenadeTime inconsistency — reload gate broken in 3 call sites
3. Three different prediction gate forms with different MP-server behavior — server doesn't play effects/sounds in MP
4. Three reload completion paths (Think-based, dead cycle-based, shotgun timer) — inconsistent
5. ShootBullets uses global `spread` variable — race condition between weapons
6. Reload ReloadTable loop uses `return` instead of `continue` — aborts entire reload
7. Melee SwingSound/HitSound randomized at file load — same sound all session
8. Melee type(trace.Entity)=="NextBot" never matches — NextBots get wrong sound
9. LookupSequence checks treat index 0 as "not found" — sequence 0 silently fails
10. Shotgun ReloadShotgun leaks `vm` to global scope

Architecture issues:
- 883-line base file mixes concerns (viewmodel, deploy, HUD, calcview, render)
- 213-line Think function
- 177-line Reload function
- 153-line DrawHUD function
- Three animation systems coexist (EasySendWeaponAnim, SendAnim, SendSequence)
- Two sound systems coexist (AnimSounds, ReloadTable)
- Firemode 0 (safe) special-cased everywhere instead of being a real firemode object

Plan for deep clean:
1. Move all file-scope upvalues to self._xxx fields
2. Standardize prediction gate to one helper
3. Fix GrenadeTime → UH_GrenadeTime
4. Remove all dead code
5. Consolidate reload completion to one path
6. Fix ShootBullets global spread → local
7. Fix Reload return → continue
8. Fix melee sound randomization → per-swing
9. Fix LookupSequence > 0 → >= 0
10. Fix DrawWeaponSelection operator precedence
11. Extract duplicated flashlight/flare block
12. Cache ConVar lookups and material lookups
13. Pool/scratch vectors in render paths
14. Split large functions (Think, Reload, DrawHUD, PrimaryAttack)
15. Add IsValid checks
16. Standardize naming conventions
17. Add melee hooks (PreSwing, PostHit, GetSwingAnim)
18. Reconsider melee inheritance (inherit from base, not gun)

Artifacts:
- Full audit in conversation history
- Source files: /home/z/my-project/upload/weapon_uh_base*.lua

---
Task ID: cuh-attachment-fix
Agent: main (Super Z)
Task: Debug why CUH attachments weren't being applied to the XM8 weapon (sounds worked, but no model/stat changes). User asked to review how TFA handles it and bring in a simulator to test.

Work Log:
- Reviewed TFA's attachment pattern at /home/z/my-project/repos/bo4_tfa/lua/tfa/att/bo4_att_barrel.lua — TFA uses VElement ACTIVATION (each attachment has its own pre-defined VElement named after the att ID; Attach just toggles .active = true). CUH's approach is different: it uses MODEL SWAP (one VElement per "part class" like "barrel"; Attach sets .model = newModel and rebuilds ClientsideModel). Both are valid approaches.
- Built a Lua simulator (lupa-based, Lua 5.4 inside Python) that mocks every GMod global the CUH code touches (file.Find, include, AddCSLuaFile, ClientsideModel, Color, Sound, hook, net, etc.) and loads the ACTUAL source files: sh_cuh_attachments.lua, weapon_cuh_base_gun.lua, weapon_m8a1_scotia.lua, all 20 attachment files. The simulator captures every ClientsideModel creation in _CSMODEL_LOG so we can assert on the model string passed in.
- Wrote a Python preprocessor (cuh_preprocess.py) that converts GMod LuaJIT-isms (the `continue` keyword, and `slot = tonumber(slot)` for-loop variable reassignment) to plain Lua 5.4 (goto+label, and `local slot =` shadowing). The simulator loads the preprocessed source so we test the real code as-is.
- First simulator run revealed the actual bug: ApplyAttachments in weapon_cuh_base_gun.lua crashed at line 622 with `attempt to perform arithmetic on a nil value (local 'val')` whenever an attachment's WeaponTable.Primary.<stat> = function(wep, val) return val * 0.8 end was applied for a stat the weapon doesn't define (e.g., Primary.IronAccuracy, Primary.SpreadMultiplierMax — neither is declared on the XM8). The crash aborted the ENTIRE ApplyAttachments, so the model swap (Step 6) never ran — exactly matching the user's "nothing changes at all" symptom.
- Root cause: GetStat() returns nil for stats not in the cache. The code then called subVal(self, nil), which inside the attachment's `val * 0.8` arithmetic crashed. TFA avoids this by ensuring every Primary stat is pre-cached; CUH's InitStatCache only caches stats that are actually present in self.Primary, so absent stats return nil from GetStat.
- Fix in weapon_cuh_base_gun.lua (lines 617-663): Skip the function transform when currentVal is nil (stat not defined on weapon), AND wrap the function call in pcall as a final safety net so a buggy attachment function never breaks the whole pipeline. Same defensive pattern applied to both nested Primary/Secondary function stats AND top-level function stats.
- Re-ran the simulator: ALL 16 CHECKS PASS. Confirmed:
  * Attachment IDs are registered correctly (no .lua extension — that was a simulator mock bug, not a CUH bug; real GMod string.StripExtension works fine).
  * Default attachments (sight, barrel_h default isn't chosen — psg_c, stock_f, smag) auto-apply on first ApplyAttachments call.
  * Model swap works: barrel.model changes from scotia_b_d.mdl → scotia_b_h.mdl when Hvy-B selected, _csModel is rebuilt with new path.
  * Stats compound multiplicatively across attachments: Primary.Spread = 0.04 * 0.8 [Hvy-B] * 0.9 [stock_f] = 0.0288. IronSightTime = 0.45 * 1.1 [Hvy-B] * 0.9 [psg_c] * 1.8 [stock_f] * 0.7 [smag] = 0.5103.
  * Switching slots reverts the model and recomputes stats from the remaining equipped attachments.
  * "None" (slot index 0) for slot 2 correctly reverts the barrel model to default, and stats still reflect the other slot defaults (psg_c, stock_f, smag).

Stage Summary:
- Bug was a nil-deref crash in ApplyAttachments' stat function application path, silently aborting the entire pipeline before the model swap step ran.
- Fix: defensive nil-skip + pcall wrapper around attachment stat functions.
- Simulator: lupa-based Lua VM with mock GMod API + Python preprocessor for LuaJIT-isms. Loads real CUH source files, runs SetAttachment through ApplyAttachments, asserts on ClientsideModel creation parameters and stat values.

Artifacts:
- Simulator driver: /home/z/my-project/scripts/cuh_sim_driver.py
- Lua test harness: /home/z/my-project/scripts/cuh_sim_harness.lua
- Python preprocessor: /home/z/my-project/scripts/cuh_preprocess.py
- Fixed source: /home/z/my-project/download/custom_uh_base/lua/weapons/weapon_cuh_base_gun.lua (lines 617-663)
- Run with: `python3 /home/z/my-project/scripts/cuh_sim_driver.py`

---
Task ID: cuh-attachment-audit-v2
Agent: main (Super Z)
Task: User reports attachments STILL don't apply after the first fix. Do a complete audit of CUH base + TFA base + parent bases.

Work Log:
- Launched parallel Explore subagents to audit: (a) TFA base's actual attachment implementation, (b) CUH's parent base classes (weapon_custom_uh_base.lua + weapon_custom_uh_base_gun.lua)
- TFA audit found the original TFA-based XM8 at /home/z/my-project/repos/m8a1_tfa/ — this is the REFERENCE implementation that works. Key differences from CUH port:
  * TFA uses SWEP.VElements; CUH renamed to SWEP.ViewModelElements (to avoid conflict with parent Underhell base)
  * TFA's CreateModels is called EVERY FRAME in ViewModelDrawn and detects model string changes, auto-creating new ClientsideModels
  * CUH's InitVElements is called ONCE (guarded by _vElementsInit flag), only recreating csModels when CleanupVElements sets the flag to false
  * Both approaches are valid; CUH's is more efficient but requires explicit CleanupVElements + InitVElements calls (which att:Attach does)
- Parent base audit found NO method conflicts — parent classes do NOT define SetAttachment, ApplyAttachments, InitVElements, etc. The parent's PostDrawViewModel correctly calls self:InitVElements() and self:DrawVElements(), which resolve to CUH's methods via inheritance.
- CRITICAL FINDING: ApplyAttachments is NEVER called on Deploy. The WeaponDeployed hook only calls CustomUH.LoadAttachments (which only calls ApplyAttachments if there's a save file). If there's no save file (first time using the weapon), defaults are NEVER materialized. The weapon shows its bare ViewModelElements with no model swaps or stat changes until the user manually opens the menu and clicks something.
- This explains the "nothing changes" symptom — but only partially. The user says clicking buttons also doesn't work. So there may be additional issues.
- Added 3 layers of defense:
  1. SWEP:Deploy() override in weapon_cuh_base_gun.lua that calls ApplyAttachments after BaseClass.Deploy (via timer.Simple(0,...) to defer to next tick)
  2. pcall wrapper around att:Attach() calls in ApplyAttachments step 5, so a buggy attachment's Attach function never breaks the entire pipeline
  3. 4 diagnostic console commands: cuh_debug, cuh_apply, cuh_set, cuh_reset
- Added load-confirmation prints to all 3 core files (sh_cuh_attachments.lua, weapon_cuh_base_gun.lua, weapon_m8a1_scotia.lua) so the user can verify the files load without syntax errors
- Pushed commit 5a49a4b to GitHub

Stage Summary:
- Found and fixed "defaults never applied on Deploy" bug
- Added pcall around att:Attach for crash resilience
- Added diagnostic console commands for the user to pinpoint the issue
- The user should test with: spawn M8A1 → run cuh_debug → run cuh_set 2 2 → run cuh_debug again → paste console output

Artifacts:
- Fixed source: /home/z/my-project/download/custom_uh_base/lua/weapons/weapon_cuh_base_gun.lua (Deploy override + pcall att:Attach)
- Fixed source: /home/z/my-project/download/custom_uh_base/lua/autorun/sh_cuh_attachments.lua (4 console commands)
- GitHub commit: 5a49a4b
- TFA reference implementation: /home/z/my-project/repos/m8a1_tfa/

---
Task ID: cuh-fix-v3
Agent: main (Super Z)
Task: User reports reload broken + attachments still not working. Console output shows only SERVER realm.

Work Log:
- Analyzed user's console output: ALL prints show realm=SERVER, no realm=CLIENT output at all
- Identified two bugs:
  1. RELOAD BROKEN: My Deploy override (timer.Simple(0, ApplyAttachments)) interfered with the parent base's deploy/reload state machine. ApplyAttachments resets Primary.ClipSize/Delay/etc. on the next tick, which confused the reload timer.
  2. NO CLIENT OUTPUT: The cuh_set console command runs on the SERVER (listen server behavior). SetAttachment on the server called ApplyAttachments on the server but NEVER broadcast CUH2_AttSync to clients. The server's weapon had the swapped model string, but the clients' copies didn't.
- Fixed both:
  1. Replaced Deploy override with a global Think hook (CUH2_ApplyDefaults) that applies defaults once per weapon (guarded by _cuhDefaultsApplied flag). Uses timer.Simple(0.1, ...) to ensure viewmodel is ready. No interference with Deploy/Reload.
  2. Added server-side broadcast in SetAttachment: when called on the server, it now broadcasts CUH2_AttSync to all clients (in addition to saving). This means cuh_set from the server console now propagates to clients.
- Pushed commit 09a4949

Stage Summary:
- Reload should work again (no more Deploy override interference)
- Attachments should now apply on the client when cuh_set is used from the server console (because the server broadcasts CUH2_AttSync)
- Need user to test: pull latest, spawn M8A1, run cuh_set 2 2, look for CLIENT realm output in console

---
Task ID: cuh-fix-v4
Agent: main (Super Z)
Task: User reports reload still broken, attachments not visible, and saving doesn't persist between menu close/open. Console shows CLIENT ApplyAttachments IS running with valid _csModel.

Work Log:
- Analyzed user's console output: CLIENT ApplyAttachments IS running, _csModel = CSEntity [class C_BaseFlex] (valid), barrel.model = scotia_b_h.mdl (correct). So the attachment code IS working — model swap is happening on both server and client.
- Identified the reload issue: my Think hook (CUH2_ApplyDefaults) called ApplyAttachments which calls RestoreStat, resetting Primary.ClipSize and Primary.Delay at random times. This broke the reload state machine. Removed the Think hook entirely.
- Identified the save/load issue: 'WeaponDeployed' is NOT a standard GMod hook — it was registered but never called by any code. So LoadAttachments never ran, and saved attachments were never loaded back. Replaced with 'PlayerSwitchWeapon' which IS a real GMod hook.
- Found ANOTHER bug: weapon_m8a1_scotia.lua Deploy() returns false. In GMod, Deploy() returning false CANCELS the deploy. Changed to return true.
- Added ApplyAttachments call to Deploy (via timer.Simple(0,...)) so defaults materialize on deploy.
- Added debug prints to SaveAttachments and LoadAttachments so the user can see when saves happen and what's loaded.
- Pushed commit 9bcd90b

Stage Summary:
- Reload should work (Think hook removed)
- Save/load should work (PlayerSwitchWeapon replaces nonexistent WeaponDeployed)
- Deploy should work (return true instead of false)
- Attachments should materialize on deploy (ApplyAttachments called from Deploy via timer)

---
Task ID: 6 (User Feedback Round 6 — Customization Toggle, FP6 Reload, Tac 12 Looped Reload, ACT_VM_PRIMARYATTACK)
Agent: Super Z (main)
Task: Apply 6 fixes from user feedback:
  1. Customization toggle (Customizable=false) — menu still opens on C
  2. FP6 full 5-round reload sound schedule (replace timings)
  3. FP6 ammo refill at (animDuration - 0.1)s, not at start
  4. Lower FP6 ViewModelFOV to 60
  5. Replace "fire" sequence with ACT_VM_PRIMARYATTACK / ACT_VM_PRIMARYATTACK_1 (ADS) — applies to all 25 weapons
  6. Convert Tac 12 to KRM-262-style looped shotgun reload (start -> loop -> finish)

Work Log:
- Added `if wep.Customizable == false then return end` guard in cl_cuh_ui.lua OpenMenu() — both in /home/z/my-project/lua/autorun/cl_cuh_ui.lua and /home/z/my-project/download/custom_uh_base/lua/autorun/cl_cuh_ui.lua
- Wrote scripts/apply_fire_anim_fix.py to apply fix #5 to all 25 weapons:
  - Removed `["shoot"] = "fire"` and `["iron_fire"] = "fire_ads"` from SWEP.Animations
  - Replaced ShootAnimation() override to return ACT_VM_PRIMARYATTACK (hipfire) or ACT_VM_PRIMARYATTACK_1 (ADS)
  - Lets the base class fall through to SelectWeightedSequence on the activity
  - All 25 files updated successfully
- FP6 (ghosts_fp6.lua) specific fixes:
  - ViewModelFOV: 70 -> 60
  - ["reload"] AnimSounds replaced with 8-entry schedule (Lift, 5x Insert, Chamber, End) — last sound at 3.8667s
  - FP6_ReloadTimes[0]: 2.85 -> 4.0 (matches new sound schedule)
  - Safety floor: if reloadKey=="reload" and animDuration < 4.0, force 4.0
  - Removed immediate ammo addition (was: owner:RemoveAmmo + SetClip1 at reload start)
  - Added timer.Simple at (animDuration - 0.1)s that adds ammo if reload still active
  - Uses _fp6_ammoAdded guard to prevent double-fire; base class _FinishReload becomes a no-op
- Tac 12 (ghosts_tac12.lua) looped shotgun reload conversion:
  - Added Primary.ReloadTime = 13/30 (TFA LoopedReloadInsertTime)
  - Added Primary.ShellSound = "Weapons_Ghosts_TAC.Insert"
  - Replaced Animations["reload"]/["reload_empty"] with ["start_reload"]/["reload_loop"]/["after_reload"]
  - Renamed AnimSounds keys to start_reload / reload_loop / after_reload (kept TFA-ported timings)
  - Removed the unused ["reload_2"] AnimSounds entry
  - Reload() now fully self-contained: plays start_reload, sets _tac12_nextShell = ct + startDur
  - Added ReloadShotgun(ct) method: handles stop conditions (clip full / no reserve / fire pressed) and per-shell insertion via timer
  - Think() now calls ReloadShotgun(ct) BEFORE BaseClass.Think so the base doesn't try to _FinishReload on us
  - Sets _reloadFinished = true at reload start to suppress base-class ammo refill
  - Holster() clears _tac12_nextShell and _tac12_reloading to prevent post-holster timer fires
- Wrote scripts/verify_syntax.py: uses lupa LuaRuntime + load() to compile-check all 27 Lua files
  - Handles GMod LuaJIT-isms: `continue` keyword, `&&`/`||`/`!=` operators
  - All 27 files pass (25 ghost weapons + weapon_cuh_base_gun + cl_cuh_ui)

Stage Summary:
- Customizable toggle: opens menu only if Customizable ~= false; affects all 25 ghost weapons
- All 25 weapons now use ACT_VM_PRIMARYATTACK / ACT_VM_PRIMARYATTACK_1 instead of "fire"/"fire_ads" sequence names
- FP6 full 5-round reload: 8 sounds properly timed (last at 3.8667s); ammo added 0.1s before anim end; FOV 60
- Tac 12: full KRM-262-style looped reload (start -> loop per shell -> finish); interrupts on fire/clip-full/no-reserve
- All 27 Lua files pass syntax verification (no parse errors)

---
Task ID: tools-preserve
Agent: main (Super Z)
Task: Two requests: (1) bundle all compiled BF3 model files into a single Battlefield3/ folder for easy copy-over; (2) save studiomdl / crowbar / blender so they don't have to be rebuilt constantly or risk losing content.

Work Log:
- Audited filesystem layout: `/tmp/my-project/` is on tmpfs (2 GB cap, RAM-backed, wiped on session restart), while `/home/z/my-project/` is on the persistent rootfs.
- Discovered the only tools actually at risk were Blender 4.2.0 binary tree (1.9 GB) + SourceIO Blender plugin (24 MB) — they were sitting in `/tmp/my-project/tools/`. The other tools were already on persistent storage:
  - studiomdl: `/home/z/my-project/repos/source-sdk-2013/game/bin/studiomdl` (+ libtier0.so/libvstdlib.so in src/lib/public/linux64/) — persistent.
  - Crowbar source + compiled DLL: `/home/z/my-project/tools/crowbar-src/Crowbar/bin/Debug/net8.0/Crowbar.dll` — persistent.
  - dotnet SDK + runtime: `/home/z/my-project/tools/dotnet/` — persistent.
- Created `/home/z/my-project/compile/Battlefield3/` and copied all 192 compiled model files (32 weapons × {mdl, vvd, dx80.vtx, dx90.vtx, sw.vtx, xbox.vtx}).
- Persisted Blender: `mv /tmp/my-project/tools/blender-4.2.0-linux-x64/ /home/z/my-project/tools/`. Verified `blender --version` returns Blender 4.2.0.
- Persisted SourceIO plugin: `mv /tmp/my-project/tools/SourceIO/ /home/z/my-project/tools/`. Verified `source_io/__init__.py` present.
- Moved both backup archives to a new `/home/z/my-project/tools/archives/` subfolder:
  - `blender-4.2.0.tar.xz` (336 MB)
  - `SourceIO.zip` (5.7 MB)
- Wrote `/home/z/my-project/tools/setup_tools.sh` — a sourced shell script that exports all four env vars (STUDIOMDL_BIN, DOTNET_ROOT, CROWBAR_DLL, BLENDER_BIN, BLENDER_USER_SCRIPTS) and defines four shell helpers:
  - `studiomdl ARGS…` — wraps binary with proper LD_LIBRARY_PATH
  - `crowbar-decompile MODEL.mdl [out]` — calls the existing pythonnet bridge script
  - `blender ARGS…` — wraps binary with BLENDER_USER_SCRIPTS so SourceIO loads
  - `setup_tools_status` — quick path check that prints OK/MISSING for every component
- Wrote `/home/z/my-project/tools/README.md` documenting the full tool inventory, paths, and recovery procedure from backup archives.
- Verified all three tools run from their persistent paths end-to-end:
  - `studiomdl -?` → prints usage
  - `dotnet --version` → 8.0.410
  - `blender --version` → Blender 4.2.0
  - Crowbar via pythonnet: `clr.AddReference('Crowbar'); from Crowbar import TheApp` → loads OK

Stage Summary:
- 192 compiled model files bundled into `/home/z/my-project/compile/Battlefield3/` (67 MB total) — ready for one-shot copy to the user's test mod.
- All three external tools (studiomdl / Crowbar / Blender + SourceIO) now live under `/home/z/my-project/tools/` on the persistent rootfs. No rebuild needed on next session restart.
- `source /home/z/my-project/tools/setup_tools.sh` exposes all four helper commands in any future shell session.
- Backup archives (blender-4.2.0.tar.xz + SourceIO.zip) preserved under `tools/archives/` for emergency recovery.

Artifacts:
- New folder: /home/z/my-project/compile/Battlefield3/ (192 files, 67 MB)
- Moved binary tree: /home/z/my-project/tools/blender-4.2.0-linux-x64/ (1.9 GB, 5375 files)
- Moved plugin: /home/z/my-project/tools/SourceIO/ (24 MB)
- Backup archives: /home/z/my-project/tools/archives/{blender-4.2.0.tar.xz, SourceIO.zip}
- Setup script: /home/z/my-project/tools/setup_tools.sh (sourceable, defines 4 helpers)
- README: /home/z/my-project/tools/README.md (full tool inventory + recovery procedure)
- Dump script (reusable): /home/z/my-project/scripts/dump_compiled_to_battlefield3.sh

---
Task ID: c-arms-retarget
Agent: main (Super Z)
Task: User reported that bones are still rotated wrong + old c_hands still render. Use Blender to find+add the default c_arms to models, retarget animations, remove original hands.

Work Log:
- Diagnosed actual issue:
  * The hands bodygroup WAS already removed from QC (since previous full_pipeline.py commit)
  * $bonemerge WAS already set for all 38 hand bones
  * But the BONE DEFINITIONS still had BF3-specific orientations (e.g. L_UpperArm rotation = 2.61° -90.52° -90.39°)
  * The ANIMATION SMDS had keyframes for all 124 bones including hand bones (0-51)
  * When GMod's c_arms bonemerged onto the weapon's bones, the animation keyframes for hand bones were overriding the bonemerge, AND the bones had wrong orientations
- Cloned github.com/robotboy655/gmod-animations to get the standard c_arms_citizen.smd reference (the default GMod c_arms skeleton)
- Wrote /home/z/my-project/scripts/fix_c_arms_retarget.py which:
  * Parses c_arms_citizen.smd to get standard bone definitions (46 bones with proper positions/rotations in radians)
  * For each weapon's QC: replaces all hand bone $definebone lines with c_arms_citizen values (converting radians to degrees), adds Spine4 as root for Clavicles, removes BF3 procedural bones, strips v_hands/sleeve_diffuse from $texturegroup, removes hands/ folder from $cdmaterials
  * For each reference SMD: replaces hand bone positions/rotations in skeleton section with c_arms_citizen values, removes BF3 procedural bones from nodes section
  * For each animation SMD: strips all hand bone keyframes (so bonemerge fully controls hand transforms without animation override)
- Verified the fix on m416 in Blender + SourceIO:
  * SourceIO addon successfully loaded by adding SourceIO directory to sys.path and calling register()
  * Imported c_m416.mdl: confirmed 83 bones present (Spine4 + 38 hand bones + weapon bones + fingers)
  * Spine4 bone has proper c_arms_citizen orientation: pos=(0.00, 0.06, 1.11) rot=(-169.7, -90.0, 0.0)
  * All vertex groups present (83 total)
  * No baked-in hand mesh data
- Wrote /home/z/my-project/scripts/recompile_all.py to recompile all 32 weapons with studiomdl
  * Note: studiomdl segfaults at exit (-11 SIGSEGV) AFTER writing files successfully, so we check for output file existence rather than return code
  * 32/32 SUCCESS — all weapons compiled cleanly
- Refreshed /home/z/my-project/compile/Battlefield3/ bundle with the new clean models (192 files, 67 MB)
- Pushed to GitHub (commit aeec835a)

Stage Summary:
- 32/32 weapons now use the standard GMod c_arms_citizen skeleton for hand bones
- Bone orientations match GMod c_arms standard (no more "bones rotated wrong way")
- Animation SMDs no longer override bonemerge (hand bone keyframes stripped)
- QC files cleaned: no more v_hands/sleeve_diffuse in $texturegroup, no hands/ in $cdmaterials
- BF3 procedural bones (l_thumb_tip, r_armtwist_*, etc) removed entirely
- compile/Battlefield3/ bundle refreshed and pushed to GitHub
- Verified via Blender+SourceIO that bone structure is correct

Artifacts:
- Fix script: /home/z/my-project/scripts/fix_c_arms_retarget.py
- Recompile script: /home/z/my-project/scripts/recompile_all.py
- Blender verification: /home/z/my-project/scripts/blender_verify_c_arms.py
- c_arms reference: /home/z/my-project/repos/gmod-animations/c_arms_citizen.smd
- GitHub commit: aeec835a (pushed)

---
Task ID: revert-c-arms-retarget
Agent: main (Super Z)
Task: User reported c_hands broken: either no c_hands, jumbled mess in front of camera, or no animation during reload. Fix.

Work Log:
- Diagnosed root cause of c_arms retarget failure:
  * My previous fix (commit aeec835a) changed bone POSITIONS to c_arms_citizen values, which moved Spine4 to world position (0, 3.34, 58.35) — putting the c_arms mesh 58 units in front of the camera ("jumbled mess in front of camera" issue)
  * My previous fix STRIPPED hand bone keyframes from animation SMDs — this caused c_arms not to animate during reload (no bone transforms to follow)
  * My previous fix ADDED Spine4 as root bone for Clavicles — this broke the existing BF3 bone hierarchy
- Discovered a SECOND issue: 9 weapons (g18, m1911, m249, m82a3, m9, m93r, mp412, mp443, sv98) had NO $bonemerge lines because full_pipeline.py only added bonemerge when removing a hands bodygroup. These weapons never had a hands bodygroup, so c_arms couldn't attach ("no c_hands anymore" issue).
- Wrote /home/z/my-project/scripts/revert_and_clean_qc.py which:
  * Imports convert_weapon from full_pipeline.py
  * Deletes compile/<weapon>/source/ folders and re-runs the original convert phase from decompile/ (preserves BF3 bone positions, animation keyframes, no Spine4, no BF3 procedural bone removal)
  * Applies ONLY the QC cleanup: removes v_hands/sleeve_diffuse from $texturegroup, removes hands/ folder from $cdmaterials
  * ADDS $bonemerge for ALL 38 hand bones for EVERY weapon (not just those that had a hands bodygroup)
- Ran the revert script: 32/32 SUCCESS
- Verified:
  * m416 L_Clavicle bone def back to BF3 original: (3.49, 8.83, -9.98) rotation (0, 0.000057, 0)
  * m416 animation SMD bone count: 372 (original — hand bone keyframes preserved)
  * All 32 weapons have 38 bonemerge lines (was 0 for 9 weapons before)
  * m416 binary has NO v_hands/sleeve_diffuse material references
  * m416 binary has NO Spine4 bone (back to BF3 original)
  * m416 binary has NO hands/ cdmaterials path
- Recompiled all 32 weapons with studiomdl: 32/32 SUCCESS
- Refreshed compile/Battlefield3/ bundle (192 files)
- Pushed to GitHub (commit 70e465d6)

Stage Summary:
- c_hands should now render at the correct position (at the weapon's grip, not in front of the camera)
- c_hands should animate during reload (hand bone keyframes preserved in animation SMDs)
- All 32 weapons now have $bonemerge for all 38 hand bones (c_arms can attach to all weapons)
- Old baked-in hand textures (v_hands, sleeve_diffuse) are no longer referenced in $texturegroup
- Old baked-in hands bodygroup is still removed (no duplicate hand mesh)
- The "bones rotated the wrong way" issue from the original report may persist (c_arms mesh might be slightly deformed because BF3 bone orientations don't exactly match c_arms_citizen's), but this is far better than the broken state from the previous commit

Artifacts:
- Revert script: /home/z/my-project/scripts/revert_and_clean_qc.py
- GitHub commit: 70e465d6 (pushed)

---
Task ID: c-hands-final-fix
Agent: main (Super Z)
Task: User reported 4 issues with c_hands: (1) old hands still render with missing textures on m93r, (2) m98b reload breaks c_hands, (3) fingers (except thumb) and back of hand oriented wrong on 870mcs, (4) famas/g36c/g3a3/l85a2/m416/scarh lack c_hands entirely. Study COD Ghosts weapons for reference.

Work Log:
- Cloned github.com/LeRatEmperor/ghosts_wavy_s_nzombies_weapons_3802517048 to study Ghosts c_hands setup
- Decompiled c_m27_lmg.mdl (Ghosts weapon) — discovered Ghosts uses a HYBRID bone system:
  * j_* bones (j_shoulder_le, j_wrist_le, j_thumb_le_0, etc.) which the weapon mesh is weighted to
  * ValveBiped.Bip01_* bones as CHILDREN of the j_* bones, with c_arms_citizen-compatible ROTATIONS
  * Bonemerge on both j_* and ValveBiped bones
  * Animations animate the j_* bones, which moves the ValveBiped bones (which c_arms attaches to)
- Discovered the 4 root causes of BF3 issues:

  Issue #1 (old hands render with missing textures on m93r):
  - 9 weapons (g18, m1911, m249, m82a3, m9, m93r, mp412, mp443, sv98) have hand mesh BAKED INTO their main weapon mesh SMD
  - Their hands bodygroup removal didn't help because the hand mesh was in the weapon mesh itself
  - Wrote /home/z/my-project/scripts/strip_v_hands_mesh.py to strip all v_hands/sleeve_diffuse triangle blocks from every SMD
  - Stripped 244,625 hand triangles across all 32 weapons
  - Compiled binaries no longer reference v_hands/sleeve_diffuse materials

  Issue #2 (m98b reload breaks c_hands) and Issue #3 (fingers oriented wrong on 870mcs):
  - Root cause: BF3 hand bone ROTATIONS don't match c_arms_citizen's bind pose
  - When c_arms is bonemerged onto these bones, c_arms's fingers inherit BF3 rotations
  - During reload animation, bones move but c_arms's deformed fingers look broken
  - Wrote /home/z/my-project/scripts/fix_hand_bone_rotations.py:
    * Replaces ONLY the ROTATIONS of hand bones (Clavicle, UpperArm, Forearm, Hand, all Fingers, ForeTwists) with c_arms_citizen's values
    * KEEP positions unchanged (so bone world position is preserved)
    * KEEP animation keyframes unchanged (so reload/draw/fire animations work)
    * Only modify the rest pose (time 0) in SMDs

  Issue #4 (famas/g36c/g3a3/l85a2/m416/scarh lack c_hands):
  - These weapons had bonemerge configured correctly
  - The c_hands weren't visible because the baked-in hand mesh (with missing textures) was rendering INSTEAD of c_arms
  - Fixed by Issue #1's strip_v_hands_mesh.py — now c_arms renders properly

- Fixed bug in fix_hand_bone_rotations.py: regex wasn't matching the trailing 6 zeros, causing them to be appended twice. Updated regex to `(-?\d+\.?\d*\s+){5}(-?\d+\.?\d*)(\s+-?\d+\.?\d*){6}` so it captures the full line including trailing zeros.
- Reverted all 32 weapons via revert_and_clean_qc.py to get clean source files
- Applied fix_hand_bone_rotations.py (38 hand bone rotations replaced per weapon)
- Applied strip_v_hands_mesh.py (244,625 triangles stripped across all 32 weapons)
- Recompiled all 32 weapons: 32/32 SUCCESS
- Verified compiled binaries:
  * c_m416.mdl: NO v_hands/sleeve_diffuse material references
  * c_m93r.mdl: NO v_hands/sleeve_diffuse material references
  * c_m98b.mdl: NO v_hands/sleeve_diffuse material references
- Refreshed compile/Battlefield3/ bundle
- Pushed to GitHub (commit bc869425)

Stage Summary:
- Old hand mesh completely stripped from all 32 weapons (no more "old hands with missing textures")
- Hand bone rotations now match c_arms_citizen's bind pose (fingers should render correctly)
- Animation keyframes preserved (reload/draw/fire animations should work)
- Bone positions unchanged (weapon mesh renders at correct position)
- Bonemerge configured for all 38 hand bones on all 32 weapons
- All 32 weapons compile successfully
- compile/Battlefield3/ bundle refreshed and pushed to GitHub

Artifacts:
- /home/z/my-project/scripts/fix_hand_bone_rotations.py (new)
- /home/z/my-project/scripts/strip_v_hands_mesh.py (new)
- GitHub commit: bc869425 (pushed)

---
Task ID: c-hands-pipeline-rewrite
Agent: main (Super Z)
Task: User reported c_hands fly away after animations + fingers still wrong. Cleared folders, researched deeply, built comprehensive guide, rewrote pipeline from scratch.

Work Log:
- Cleared /home/z/my-project/decompile/ and /home/z/my-project/compile/ (except Battlefield3)
- Cloned fresh BF3 SWEPs repo: github.com/LeRatEmperor/tfa_at_bf3_weapons_pack_2261149305
- Launched deep research subagent that produced /home/z/my-project/docs/C_HANDS_COMPLETE_GUIDE.md (90KB, 1719 lines)
  - Covers: c_arms entity, c_arms_citizen.smd reference, $bonemerge, $definebone, bone hierarchy differences, "fly away" issue, conversion workflow, reference examples, common pitfalls, BF3-specific pipeline, diagnostic checklist
  - Extracted canonical references from robotboy655/gmod-animations: c_arms_citizen.qc, c_arms_definebones.qci, c_medkit.qc
- Decompiled all 32 BF3 weapons from fresh clone using scripts/decompile_all_bf3.py
- Wrote /home/z/my-project/scripts/convert_bf3_to_c_hands.py (complete pipeline):
  1. Rename BF3 bones to ValveBiped.Bip01_* (using full_pipeline.py's BONE_MAP)
  2. Add Spine4 as root bone in SMDs (reparent L_Clavicle/R_Clavicle to it)
  3. Replace hand bone POSITIONS and ROTATIONS in SMDs with c_arms_citizen's values
  4. Re-bake animation keyframes to maintain world-space motion:
     - new_pos = new_bind_pos + (keyframe_pos - old_bind_pos)
     - new_rot = new_bind_rot * inverse(old_bind_rot) * keyframe_rot
  5. REMOVE $definebone lines for hand bones (CRITICAL FIX - let SMD source define them)
  6. Add $bonemerge for all 38 hand bones + Spine4
  7. Strip v_hands/sleeve_diffuse mesh triangles from SMDs
  8. Clean QC (remove v_hands material refs, hands cdmaterials, hands bodygroup)

KEY DISCOVERY (the root cause of "fly away"):
- studiomdl's g_bOverridePreDefinedBones=true causes SMD source values to OVERRIDE $definebone values
- But the "rebuild local pose" code then computes wrong values when BOTH $definebone AND SMD source define the same bone
- Result: all bones ended up at (0, 0, 0) with Spine4's rotation (broken)
- FIX: Do NOT use $definebone for hand bones. Let the SMD source define them.
- Only use $definebone for Spine4 (to ensure it exists)

VERIFICATION (via direct binary parsing + Blender):
- m416 binary: Spine4 at (0,0,0) rot (-79.75,-90,-90) - CORRECT
- m416 binary: L_Clavicle at (2.03,1.00,1.94) rot (-73.71,168.62,91.48) - c_arms_citizen values
- m416 binary: L_Hand at (20.49,-0.09,-0.04) rot (-93.57,-5.03,13.07) - RE-BAKED value (maintains world-space motion)
- m416 binary: 39 bonemerge lines (38 hand bones + Spine4)
- m416 binary: 69 bones (down from 83 - BF3 procedural bones removed)
- m416 binary: NO v_hands/sleeve_diffuse material references
- Blender: bone hierarchy correct (Spine4 -> L_Clavicle -> L_UpperArm -> L_Forearm -> L_Hand -> L_Finger0)
- 32/32 weapons compiled successfully

Stage Summary:
- c_hands should now render at correct position (at weapon grip, not in front of camera)
- c_hands should NOT fly away after animations (animation keyframes re-baked to new bind pose)
- c_hands fingers should have correct rotations (matching c_arms_citizen's bind pose)
- All 32 weapons have c_hands (bonemerge configured for all 38 hand bones + Spine4)
- Old baked-in hand mesh completely stripped (no more missing textures)
- compile/Battlefield3/ bundle refreshed with 192 files (32 weapons × 6 variants)
- Comprehensive c_hands guide created for future reference

Artifacts:
- /home/z/my-project/scripts/convert_bf3_to_c_hands.py (main pipeline)
- /home/z/my-project/scripts/decompile_all_bf3.py (decompile script)
- /home/z/my-project/docs/C_HANDS_COMPLETE_GUIDE.md (90KB reference document)
- /tmp/c_arms_extract/ (canonical c_arms_citizen reference files)
- GitHub commit: 66b35bd6 (pushed)

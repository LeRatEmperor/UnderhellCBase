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

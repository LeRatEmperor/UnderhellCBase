# Z.ai Coding Workspace

Persistent workspace for the GMod BF3 weapon porting + CUH base Lua development project.
This repo collects all analysis, scripts, and tool configs that have been built up
across sessions, so the work survives context resets.

## What's here

```
workspace/
├── README.md                    (this file)
├── analysis/                    (reports and architecture docs)
│   ├── cuh_base_analysis.md     — 1529-line exhaustive CUH weapon base reference
│   ├── CUH_PORTING_GUIDE.md     — original porting guide for the WWII weapons pack
│   └── PIPELINE_README.md       — decompile/convert/compile pipeline docs
├── scripts/                     (reusable scripts)
│   ├── cuh_sim_driver.py        — Python+LuaJIT harness that loads real CUH source
│   ├── cuh_sim_harness.lua      — asserts on SetAttachment/ApplyAttachments pipeline
│   ├── cuh_preprocess.py        — preprocessor for GMod LuaJIT-isms (continue, etc.)
│   └── mesh_extract/
│       └── extract_mesh.py      — extracts mesh from .mdl/.vvd/.vtx into SMD
├── worklog/
│   └── worklog.md               — full multi-task worklog across the project
└── configs/
    ├── installed-tools.md       — what's installed where (binaries, plugins, paths)
    └── zcode-cli-config.json    — snapshot of ~/.zcode/cli/config.json
```

## What is the CUH base?

The CUH (Custom UnderHell) base is a 3-layer SWEP chain for Garry's Mod weapons
modeled after TFA Base. It lives at `/home/z/my-project/download/custom_uh_base/`
(outside this repo — too big to track here, but the analysis is the next-best thing).

```
weapon_base (engine)
  └─ weapon_custom_uh_base      (lua/weapons/weapon_custom_uh_base.lua, 1134 lines)
                                — viewmodel positioning, deploy/holster, bones, hands,
                                  CalcView, FOV zoom, PreDrawViewModel/PostDrawViewModel
       └─ weapon_custom_uh_base_gun  (1124 lines)
                                    — PrimaryAttack hitscan with penetration,
                                      anim-driven Reload, AnimSounds timeline,
                                      firemode cycling on RMB+USE, DrawHUD with
                                      crosshair/2D-scope/ammo, RT scope via RenderScene hook
            └─ weapon_cuh_base_gun  (1203 lines)
                                  — per-instance stat cache, ApplyAttachments 6-stage
                                    pipeline, VElements/WElements lifecycle, bodygroup
                                    swap, melee state machine
```

See `analysis/cuh_base_analysis.md` for the full API reference — every method, every
table field, every footgun, with file:line citations.

## Tooling installed

This project depends on several Z.ai / Claude Code plugins and tools:

- **billion-context** (`bili plugin install zcode`) — context-compression proxy that
  keeps long sessions alive by incrementally summarizing older message ranges.
  Wired into `~/.zcode/cli/config.json` via hooks + a stdio MCP server.
- **zai-coding-plugins marketplace** — added to Claude Code via
  `claude plugin marketplace add zai-org/zai-coding-plugins`. Plugins installed:
  - `glm-plan-usage@zai-coding-plugins` — query quota and usage stats
  - `glm-plan-bug@zai-coding-plugins` — submit case feedback / bug reports
- **@z_ai/coding-helper** (`chelper` CLI) — manages GLM Coding Plan auth and
  Claude Code config. Health check via `chelper doctor`.
- **Claude Code CLI** (`@anthropic-ai/claude-code` v2.1.303) — required by the
  z.ai coding plugins above.

See `configs/installed-tools.md` for exact install paths and version numbers.

## Simulator

The CUH simulator at `scripts/cuh_sim_driver.py` is a real-world GMod Lua test
harness. It uses `lupa` (Python wrapper for LuaJIT) to load the actual CUH source
files into a Lua VM, mocks every GMod global they touch, then runs the
`cuh_sim_harness.lua` test driver which exercises the
`SetAttachment → ApplyAttachments` pipeline and asserts on stat compounds and
`_csModel` rebuilds.

Status: **16/16 checks passing** as of the last run.

To run:
```bash
python3 /home/z/my-project/workspace/scripts/cuh_sim_driver.py
```

(Requires `lupa` Python package — `pip install lupa`.)

## Main project repos

This workspace is a *scratchpad* for analysis and scripts. The actual deliverables
live elsewhere on disk:

- `/home/z/my-project/repos/bf3_sweps_fresh/` — the user's main GitHub repo
  (origin: `https://github.com/LeRatEmperor/tfa_at_bf3_weapons_pack_2261149305.git`)
  containing the BF3 weapon pack Lua + models + materials.
- `/home/z/my-project/download/custom_uh_base/` — the CUH weapon base addon
  (analysis in this repo; source files not committed here because they're large).
- `/home/z/my-project/repos/garrysmod/` — Facepunch's GMod source repo, used as
  API reference when writing Lua.
- `/home/z/my-project/repos/source-sdk-2013/` — Valve's Source SDK with
  studiomdl bugfixes (kalloc/ALIGN/materialsys) that allow models to compile.

## How to push this to GitHub

The repo is initialized locally with `git init` but has no remote yet.
To publish:

```bash
cd /home/z/my-project/workspace
# Create an empty repo on GitHub first (via web UI or `gh repo create`)
# Then:
git remote add origin https://github.com/<your-user>/cuh-workspace.git
git add -A
git commit -m "Initial commit: CUH base analysis + simulator + mesh extractor"
git branch -M main
git push -u origin main
```

Alternatively, push to the existing bf3 weapon pack repo as a subdirectory:
the existing remote at `LeRatEmperor/tfa_at_bf3_weapons_pack_2261149305` is the
user's, but mixing analysis files in with the addon is not recommended.

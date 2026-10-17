# Tools — Persistent Pipeline Binaries

This folder holds the three external tools used by the BF3 SWEP porting pipeline.
All paths below are on the **persistent rootfs** at `/home/z/my-project/` — they
survive session restarts and are not subject to `/tmp` tmpfs cleanup.

## Quick start

```bash
source /home/z/my-project/tools/setup_tools.sh
```

This exports the env vars (`STUDIOMDL_BIN`, `DOTNET_ROOT`, `CROWBAR_DLL`,
`BLENDER_BIN`, `BLENDER_USER_SCRIPTS`) and defines four shell helpers:

| Helper             | Tool       | Action                                       |
|--------------------|------------|----------------------------------------------|
| `studiomdl ARGS…`  | studiomdl  | Compiles `.qc` → `.mdl`/`.vvd`/`.vtx`        |
| `crowbar-decompile MODEL.mdl [out]` | Crowbar | Decompiles via pythonnet |
| `blender ARGS…`    | Blender    | Launches Blender 4.2.0 with SourceIO loaded   |
| `setup_tools_status` | —        | Prints a path check for all three tools      |

## Tool inventory

### 1. studiomdl (compiler)
- **Binary**: `/home/z/my-project/repos/source-sdk-2013/game/bin/studiomdl`
- **Required libs**: `/home/z/my-project/repos/source-sdk-2013/src/lib/public/linux64/`
  - `libtier0.so`
  - `libvstdlib.so`
- Set via `LD_LIBRARY_PATH` (handled by the `studiomdl` shell function).

### 2. Crowbar (decompiler) — .NET 8 VB.NET app
- **Source**: `/home/z/my-project/tools/crowbar-src/`
- **Compiled DLL**: `/home/z/my-project/tools/crowbar-src/Crowbar/bin/Debug/net8.0/Crowbar.dll`
- **Runtime**: `/home/z/my-project/tools/dotnet/dotnet` (DOTNET_ROOT)
- **Python bridge**: `pythonnet` package in `/home/z/.venv/` — call Crowbar from Python:
  ```python
  import pythonnet
  pythonnet.set_runtime_from_env()   # requires PYTHONNET_RUNTIME=coreclr
  import clr
  clr.AddReference("Crowbar")
  from Crowbar import TheApp, Decompiler, AppEnums
  ```
- See `scripts/test_crowbar_decompile.py` for a working end-to-end example.

### 3. Blender 4.2.0 + SourceIO plugin
- **Binary**: `/home/z/my-project/tools/blender-4.2.0-linux-x64/blender` (1.9 GB)
- **Plugin**: `/home/z/my-project/tools/SourceIO/source_io/`
- Plugin is loaded via `BLENDER_USER_SCRIPTS=/home/z/my-project/tools/SourceIO`.
- **Backup archive**: `/home/z/my-project/tools/archives/blender-4.2.0.tar.xz` (336 MB)
- **Backup zip**: `/home/z/my-project/tools/archives/SourceIO.zip` (5.7 MB)

## Layout

```
/home/z/my-project/tools/
├── README.md                  ← this file
├── setup_tools.sh             ← source this to get all helpers
├── archives/                  ← backup tarballs/zips
│   ├── blender-4.2.0.tar.xz
│   └── SourceIO.zip
├── blender-4.2.0-linux-x64/   ← Blender 4.2.0 binary tree
│   ├── blender
│   └── …
├── SourceIO/                  ← Blender addon (SourceIO plugin)
│   └── source_io/
├── crowbar-src/               ← Crowbar VB.NET source + compiled DLL
│   └── Crowbar/bin/Debug/net8.0/Crowbar.dll
├── dotnet/                    ← .NET 8 SDK + runtime
│   └── dotnet
├── porting/                   ← Python porting scripts (gen_gun.py, etc.)
└── simulator/                 ← GMod Lua sim harness (cuh_sim_*)
```

## Notes

- The `.gitignore` for `/home/z/my-project/` excludes `tools/blender-4.2.0-linux-x64/`,
  `tools/dotnet/`, and `tools/archives/` from version control — these are too large
  to commit. They are committed on disk only; the persistent filesystem preserves them.
- If any tool goes missing in a future session (rare), restore from the backup archives:
  ```bash
  tar xf /home/z/my-project/tools/archives/blender-4.2.0.tar.xz -C /home/z/my-project/tools/
  unzip /home/z/my-project/tools/archives/SourceIO.zip -d /home/z/my-project/tools/SourceIO_restore
  ```
- The previous `/tmp/my-project/tools/` location was on tmpfs (RAM, 2 GB cap) and got
  wiped on every session restart. **Do not place tool binaries under `/tmp/`.**

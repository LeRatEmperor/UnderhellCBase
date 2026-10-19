# Workflow: container <-> GitHub sync

## Repos

- **Source / read-only**: `LeRatEmperor/tfa_at_bf3_weapons_pack_2261149305`
  - Pull files/info from here. Don't push to this repo.
  - HTTPS clone URL: https://github.com/LeRatEmperor/tfa_at_bf3_weapons_pack_2261149305.git
- **Work repo (push target)**: `LeRatEmperor/UnderhellCBase`
  - All my work goes here.
  - SSH clone URL: git@github.com:LeRatEmperor/UnderhellCBase.git
  - Deploy key registered: SHA256:6u1tTiKvZOGtXFfaBoBydzRmgKSYX2Hz4D6UIWADNBk

## SSH setup

Container has no `ssh` binary and no `ssh-keygen`. We use a paramiko-based
wrapper instead:

- Private key: `/home/z/.ssh/id_ed25519_underhellcbase` (mode 0600)
- Public key: `/home/z/.ssh/id_ed25519_underhellcbase.pub`
- Wrapper: `/home/z/.ssh/git-ssh-wrapper.py` (also saved at `scripts/git-ssh-wrapper.py`)

Usage:

```bash
export GIT_SSH_COMMAND="/home/z/.venv/bin/python3 /home/z/.ssh/git-ssh-wrapper.py"
git clone git@github.com:LeRatEmperor/UnderhellCBase.git
# or for fetch/push:
git fetch origin
git push origin <branch>
```

## Branches on UnderhellCBase

- `main` — the user's existing working state (full container filesystem mirror)
- `workspace-tools` — my analysis/scripts/configs (orphan branch, 3 commits)
- `bf3-c-hands` — BF3 SWEPs + c_acwr model + v_hands_invisible.vmt (orphan branch, 1 commit)

Both new branches are orphan branches (no shared history with main). They can be
merged via PR on GitHub, or cherry-picked file-by-file.

## Files in `workspace-tools` branch

```
README.md
requirements.txt
.gitignore
analysis/cuh_base_analysis.md             (1529-line CUH base reference)
analysis/CUH_PORTING_GUIDE.md
analysis/PIPELINE_README.md
scripts/cuh_sim_driver.py                (GMod Lua simulator, 16/16 passing)
scripts/cuh_sim_harness.lua
scripts/cuh_preprocess.py
scripts/mesh_extract/extract_mesh.py     (extracts mesh from .mdl/.vvd/.vtx)
scripts/verify_acwr.py                   (Blender verify script)
scripts/make_hands_invisible.py          (Blender make-hands-invisible script)
scripts/git-ssh-wrapper.py               (paramiko SSH wrapper)
configs/installed-tools.md               (what's installed where)
configs/zcode-cli-config.json            (snapshot of ~/.zcode/cli/config.json)
configs/id_ed25519_underhellcbase.pub    (deploy public key for reference)
worklog/worklog.md                       (full multi-task worklog)
```

## Files in `bf3-c-hands` branch

```
lua/weapons/bf3_mp412.lua                (modified: ViewModel + UseHands=true)
lua/weapons/bf3_sv98.lua                 (modified: ViewModel + UseHands=true)
lua/weapons/bf3_acwr.lua                 (modified: ViewModel + UseHands=true)
models/weapons/c_acwr.mdl                (53 KB, 125 bones, 53 ValveBiped)
models/weapons/c_acwr.vvd                (7.8 MB, 121,935 vertices with full mesh)
models/weapons/c_acwr.dx80.vtx           (1.94 MB)
models/weapons/c_acwr.dx90.vtx            (1.94 MB)
models/weapons/c_acwr.sw.vtx             (1.94 MB)
models/weapons/c_acwr.xbox.vtx           (1.94 MB)
materials/models/weapons/v_hands_invisible.vmt
```

## Deploy key rotation

The previous deploy key expired. New one was generated with OpenSSL + Python's
`cryptography` library (since `ssh-keygen` is not available in this container):

```bash
openssl genpkey -algorithm Ed25519 -out /home/z/.ssh/id_ed25519_underhellcbase
openssl pkey -in /home/z/.ssh/id_ed25519_underhellcbase -pubout -out /tmp/pub.pem
# Then convert PEM to OpenSSH format using Python's cryptography library
```

If this key also expires, regenerate and add the new public key at:
https://github.com/LeRatEmperor/UnderhellCBase/settings/keys

---
name: glua
description: Expert Garry's Mod Lua (GLua) development with accurate GMod API signatures, client/server/menu realms, hooks, VGUI/derma panels, meta-table classes, enumerations and asset paths sourced from the official wiki. Use when writing, reviewing, debugging, or answering questions about Garry's Mod addons, gamemodes, SWEPs, scripted entities (ENT/SENT), effects, derma panels, the net library, NetworkVars, hooks, or any GLua code. Consult the bundled references for exact signatures and realms instead of recalling them.
---

# GLua — Garry's Mod Lua expert

You are writing Lua for Garry's Mod (the Source-engine sandbox game). GLua is
Lua 5.1 (LuaJIT) plus a large GMod-specific API and three execution **realms**.
The single most common source of broken GMod code is calling the right function
in the wrong realm, or guessing a signature that doesn't exist. This skill gives
you the exact API, byte-accurate from the wiki, plus the realm model to use it.

**Two rules that override habit:**

1. **Never guess a signature, realm, enum value, hook name, or panel method.**
   The exact answer is in `references/`. Open the file and read it. The API is
   large and full of near-misses where both names are real and easy to confuse —
   `Entity:GetPhysicsObject` vs `Entity:GetPhysicsObjectNum`, `Entity:SetNWInt`
   vs `Entity:SetNW2Int`, `net.WriteInt` vs `net.WriteUInt`. Recall is not
   reliable here; confirm the exact name and realm in the reference file.
2. **Decide the realm before you write the call.** Every function has a realm.
   `render.*`, `surface.*`, `cam.*`, `vgui.*`, `Derma*`, derma panels are
   **client**; `ents.Create`, `util.AddNetworkString`, dealing damage and
   spawning are **server**; `hook.Add`, `net.*`, `math.*`, `string.*`,
   `table.*`, `timer.*` are **shared** (and many getters like `player.GetAll`
   work in any realm). Get it wrong and the code errors or is a no-op on the
   machine it runs on.

## The realm model (read this first)

GMod runs Lua in three **separate states** that never share memory:

| Realm | Global | Runs on | Examples |
|---|---|---|---|
| **Server** | `SERVER == true` | the listen/dedicated server | spawning entities, damage, gamelogic, AI |
| **Client** | `CLIENT == true` | each connected player's game | rendering, HUD, VGUI, sounds, input |
| **Menu** | `MENU == true` | the main-menu Lua state (no map loaded) | server browser, main menu UI |

- **`CLIENT` and `SERVER` are mutually exclusive at runtime.** A given Lua state
  is *either* the server *or* a client — never both at once. There is no fourth
  "shared" state.
- **"Shared" is not a realm — it is a file that is loaded into *both* the server
  state and every client state.** The same code runs twice, in two separate
  states, with separate variables. Inside shared code you branch with
  `if SERVER then … end` / `if CLIENT then … end` for the parts that differ.
- In the references, a member's **Realm** is derived from its flags:
  `CLIENT && SERVER` → **Shared**; `CLIENT` only → **Client**; `SERVER` only →
  **Server**; `MENU` → **Menu** (combinations are joined, e.g. "Client, Menu").
  "Shared" means *callable in both the client and server states* — it does **not**
  mean a single shared state exists.

### Getting code into each realm

The server decides which files clients download. Use these three primitives:

```lua
-- On the SERVER:
AddCSLuaFile("myaddon/cl_hud.lua")   -- mark a file to be sent to clients
AddCSLuaFile("myaddon/sh_util.lua")
include("myaddon/sh_util.lua")       -- run a file in THIS (server) state
include("myaddon/sv_logic.lua")

-- On the CLIENT (after the file has been AddCSLuaFile'd & downloaded):
include("myaddon/cl_hud.lua")
include("myaddon/sh_util.lua")
```

- `AddCSLuaFile(path)` — **server-only effect**: queues `path` for download to
  clients. Calling it does nothing harmful elsewhere. A client file that is never
  `AddCSLuaFile`'d simply won't exist on clients → "couldn't include file" errors.
- `include(path)` — executes `path` in the **current** realm. Server `include`s
  run server-side; client `include`s run client-side.
- Naming convention (by prefix, enforced only by habit): `sv_` server, `cl_`
  client, `sh_` shared. The prefix is documentation; what actually decides the
  realm is *where you `include`* the file.

### Auto-run entry points

Files placed here load automatically (no manual include needed):

| Path | Realm |
|---|---|
| `lua/autorun/foo.lua` | **Shared** (runs on server and every client) |
| `lua/autorun/server/foo.lua` | **Server** only |
| `lua/autorun/client/foo.lua` | **Client** only |
| `lua/entities/<class>/` (`init.lua`/`cl_init.lua`/`shared.lua`) | scripted entity |
| `lua/weapons/<class>/` | scripted weapon (SWEP) |
| `lua/effects/<class>/` | client effect |
| `lua/vgui/` | derma panel registration |

Modern GMod auto-sends `lua/autorun` (and the standard entity/weapon folders) to
clients, so the autorun split usually "just works" — but for files you `include`
yourself, you must `AddCSLuaFile` them on the server first.

## How to navigate the references — don't recall, read

`references/` is the byte-accurate API, one file per natural unit. **Open the
unit file for exact signatures, arguments, returns, per-member realm, and
notes/warnings/bugs.** Category `README.md` files are terse indexes for finding
the right unit.

| You need… | Go to |
|---|---|
| A global function (`Vector`, `IsValid`, `ents.Create`, `Material`, `print`…) | `references/globals.md` (+ `globals-2.md`) |
| A method on an object (`Entity:`, `Player:`, `Vector:`, `IMaterial:`, `CMoveData:`…) | `references/classes/<Class>.md` |
| A library function (`net.*`, `render.*`, `surface.*`, `string.*`, `table.*`, `util.*`, `hook.*`…) | `references/libraries/<lib>.md` |
| A VGUI/derma panel (`DFrame`, `DButton`, `DTextEntry`, `DScrollPanel`…) and its methods | `references/panels/<Panel>.md` |
| A hook/override (`GM:PlayerSpawn`, `ENT:Think`, `SWEP:PrimaryAttack`, `PANEL:Paint`…) | `references/hooks/<NAMESPACE>.md` |
| An enum constant or value (`KEY_*`, `ACT_*`, `FCVAR_*`, `MASK_*`, `RENDERMODE_*`…) | `references/enums/<FAMILY>.md` |
| Built-in icon / flag material paths, or engine sound paths | `references/assets/` |
| Struct field tables (`TraceResult`, `SWEP`, `ENT`, …) | `references/structs.md` (see note below) |
| Addon folder structure, `addon.json`, realm model, net messages, NetworkVar, SWEP/ENT/gamemode skeletons, gotchas | **`references/guide.md`** |

Workflow when writing or reviewing GLua:

1. **Realm first.** What machine must this run on? Pick server / client / shared.
2. **Find the exact API.** Identify whether it's a global, a class method, a
   library function, a panel method, a hook, or an enum, and open that reference
   file. Copy the signature and respect its realm (a member used outside its
   realm is the #1 bug).
3. **Wire realms correctly.** Use `AddCSLuaFile`/`include`, `if SERVER/CLIENT`,
   and the `net` library to cross between server and client. See `guide.md`.
4. **Validate.** Check arguments/returns against the reference; `IsValid()`
   entities and panels before use; read the **Note/Warning/Bug** callouts — they
   document real footguns and engine bugs.

## Idiomatic essentials (full patterns in `guide.md`)

- **Validity:** always `if IsValid(ent) then … end` before touching an Entity or
  Panel — they can be removed/`NULL` at any time. `IsValid` is nil-safe.
- **Hooks:** `hook.Add("EventName", "unique_id", function(...) end)` — pass the
  **bare event name**. The reference files list gamemode hooks as `GM:PlayerSay`,
  but that `GM:` prefix is the *method-override* form, **not** the `hook.Add`
  string: write `hook.Add("PlayerSay", ...)`, never `hook.Add("GM:PlayerSay", ...)`.
  Inside your own gamemode you may instead define `function GM:PlayerSay(...)`.
  Object hooks (`ENT:`, `SWEP:`, `PANEL:`, `NEXTBOT:`, …) are **method overrides**
  on your table, not `hook.Add` events. The string ID lets you replace/remove a
  hook; reusing it overwrites. See `references/hooks/`.
- **Server→client data:** the `net` library (`util.AddNetworkString` +
  `net.Start`/`net.Write*`/`net.Send`/`net.Receive`) or `Entity:SetNW2*` /
  `NetworkVar`. Never trust client input on the server.
- **Don't run client API on the server:** `surface`, `render`, `cam`, `draw`,
  `vgui`, `Derma*`, `mesh`, `markup`, most `input.*`, and `Panel:` methods are
  client-only. `ents.Create`, `Entity:Remove`-side effects on gamestate,
  `util.AddNetworkString`, `Player:Kill`/`SetHealth` are server-authoritative.

## Notes

- **Structs are not yet populated** (`references/structs.md` explains why and how
  to backfill). For struct field tables, that file links the wiki Structs index.
- The references are generated from the official Facepunch wiki dump; every member
  links back to its **[wiki]** page and, where available, its engine **[source]**.
  If something here conflicts with newer wiki content, trust the wiki link.

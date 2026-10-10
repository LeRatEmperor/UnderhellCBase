# Writing GLua — realms, networking, and entity/weapon/gamemode skeletons

Deeper companion to `SKILL.md`. Patterns here are idiomatic, modern GLua. For
exact signatures of any function used below, open the matching reference file
(`classes/`, `libraries/`, `panels/`, `hooks/`, `enums/`, or `globals.md`).

---

## 1. Realms in depth

GMod runs three independent Lua states (see SKILL.md for the summary table):

- **Server** (`SERVER`): authoritative gamestate. Spawns/removes entities, deals
  damage, runs AI, owns the "real" world. One server state.
- **Client** (`CLIENT`): one state *per player*, on their machine. Renders the
  world, HUD and menus, plays sounds, reads input. Cannot be trusted by the
  server.
- **Menu** (`MENU`): the main-menu state (before/between servers). Rarely touched
  by addons; used for custom main menus and server-browser tooling.

`CLIENT` and `SERVER` are **never both true in the same state**. "Shared" code is
a *file loaded into both* the server state and each client state — it runs twice,
independently. Use it for things both sides must agree on: entity class
definitions, shared constants, hook registrations, helper functions.

```lua
-- sh_example.lua  (shared: AddCSLuaFile'd on server, included on both)
MyAddon = MyAddon or {}

function MyAddon.Format(n)            -- exists identically on server and client
    return string.Comma(math.Round(n))
end

if SERVER then
    -- only compiled/run in the server state
    util.AddNetworkString("MyAddon_Update")
elseif CLIENT then
    -- only compiled/run in client states
    surface.CreateFont("MyAddonFont", { font = "Tahoma", size = 22, weight = 700 })
end
```

### Addon folder structure

A GMod addon is a folder whose **top-level subfolders mount into the game's
shared virtual filesystem**. The outer addon folder name is cosmetic — contents
merge into a common root shared by every mounted addon — so you namespace your
own files (especially under `lua/`) to avoid collisions. Workshop addons are the
same tree packed into a read-only `.gma` (via `gmad`); a folder under
`garrysmod/addons/<name>/` is mounted automatically while developing.

The tree below is the **conventional** layout — it is *not* enforced. GMod only
auto-loads a handful of special folders (`lua/autorun/`, `lua/entities/`,
`lua/weapons/`, `lua/effects/`, `lua/vgui/`); organise everything else under
`lua/` however you like and pull it in with `include`/`AddCSLuaFile`. Many addons
don't hardcode an include list at all — they use the recursive autoloader at the
end of this section.

```
garrysmod/addons/myaddon/
  addon.json                      -- Workshop metadata (title, type, tags, ignore)
  lua/                            -- ALL Lua lives here (mounts to the lua/ search path)
    autorun/myaddon_init.lua      -- shared auto-run: bootstraps everything
    autorun/server/myaddon_sv.lua -- server-only auto-run
    autorun/client/myaddon_cl.lua -- client-only auto-run
    myaddon/sh_config.lua         -- YOUR namespaced files (avoids collisions)
    myaddon/sv_logic.lua
    myaddon/cl_hud.lua
    entities/ent_myprop/{init,cl_init,shared}.lua   -- scripted entities (auto-loaded)
    weapons/weapon_mygun/{init,cl_init,shared}.lua  -- scripted weapons  (auto-loaded)
    effects/eff_myfx/init.lua     -- client effects (auto-loaded)
    vgui/dmy_panel.lua            -- derma panel registrations (auto-loaded)
  materials/                      -- .vmt/.vtf/.png/.jpg  -> Material("path") relative to here
    icon16/...  vgui/...
  models/                         -- .mdl + .vtx/.vvd/.phy
  sound/                          -- .wav/.mp3/.ogg -> EmitSound("path") relative to here
  resource/
    fonts/myfont.ttf              -- custom fonts (auto-loaded)
    localization/en/myaddon.properties  -- language strings
  gamemodes/mygamemode/...        -- full gamemodes (their own lua/ tree, see §6)
  maps/  particles/  scenes/  scripts/   -- maps, .pcf particles, choreo, weapon/vehicle scripts
```

Key path rules: `include`/`AddCSLuaFile` paths are relative to `lua/`;
`Material("icon16/x.png")` is relative to `materials/`; `EmitSound("npc/x.wav")`
is relative to `sound/`; `file.Read("myaddon/save.txt", "DATA")` reads the
writable `garrysmod/data/` folder (not shipped in the addon — use `data_static/`
for read-only shipped data).

A typical bootstrap in `lua/autorun/myaddon_init.lua`:

```lua
-- This file is shared (autorun). On the server, send the client/shared files.
if SERVER then
    AddCSLuaFile()                              -- send THIS file too
    AddCSLuaFile("myaddon/sh_config.lua")
    AddCSLuaFile("myaddon/cl_hud.lua")
    include("myaddon/sh_config.lua")
    include("myaddon/sv_logic.lua")
elseif CLIENT then
    include("myaddon/sh_config.lua")
    include("myaddon/cl_hud.lua")
end
```

`AddCSLuaFile()` with no argument sends the *current* file. Forgetting to
`AddCSLuaFile` a client/shared file is the classic "tried to include file that
doesn't exist" client error.

### `addon.json`

Lives at the addon root; consumed by `gmad`/`gmpublish` when packing for the
Workshop (ignored when running a loose `addons/` folder, but conventional to
include):

```json
{
    "title": "My Addon",
    "type": "tool",
    "tags": ["fun", "build"],
    "ignore": ["*.psd", "*.vcproj", ".git/*", "*.md"]
}
```

- `type` — exactly one of: `gamemode`, `map`, `weapon`, `vehicle`, `npc`,
  `entity`, `tool`, `effects`, `model`, `servercontent`.
- `tags` — up to **2**, from the Workshop's allowed set (e.g. `fun`, `roleplay`,
  `realism`, `cartoon`, `water`, `movie`, `build`).
- `ignore` — glob patterns excluded from the packed `.gma`.

(Legacy addons used `addon.txt`/`info.txt`; modern GMod uses `addon.json`.)

### Convention-based autoloader

Hardcoding `include`/`AddCSLuaFile` for every file gets tedious. The common idiom
is a **recursive autoloader**: point it at a folder under `lua/` and it walks the
tree, routing each file into the correct realm by its `sv_`/`sh_`/`cl_` prefix.
Then simply *adding* a correctly-named file loads it — no manifest to edit. (This
is the main practical reason the `sv_`/`sh_`/`cl_` naming convention matters.)

```lua
-- lua/autorun/myaddon_loader.lua  (shared autorun)
local rootDirectory = "your_directory"   -- a folder under lua/, e.g. "myaddon"

local function AddFile( File, directory )
    local prefix = string.lower( string.Left( File, 3 ) )

    if SERVER and prefix == "sv_" then
        include( directory .. File )                          -- server only
        print( "[AUTOLOAD] SERVER INCLUDE: " .. File )
    elseif prefix == "sh_" then
        if SERVER then
            AddCSLuaFile( directory .. File )                 -- send to clients
            print( "[AUTOLOAD] SHARED ADDCS: " .. File )
        end
        include( directory .. File )                          -- run on both realms
        print( "[AUTOLOAD] SHARED INCLUDE: " .. File )
    elseif prefix == "cl_" then
        if SERVER then
            AddCSLuaFile( directory .. File )                 -- send, don't run on server
            print( "[AUTOLOAD] CLIENT ADDCS: " .. File )
        elseif CLIENT then
            include( directory .. File )                      -- run on client
            print( "[AUTOLOAD] CLIENT INCLUDE: " .. File )
        end
    end
end

local function IncludeDir( directory )
    directory = directory .. "/"

    local files, directories = file.Find( directory .. "*", "LUA" )

    for _, v in ipairs( files ) do
        if string.EndsWith( v, ".lua" ) then
            AddFile( v, directory )
        end
    end

    for _, v in ipairs( directories ) do          -- recurse into subfolders
        IncludeDir( directory .. v )
    end
end

IncludeDir( rootDirectory )
```

Functions used: [`include`](globals.md) and [`AddCSLuaFile`](globals.md)
(globals); [`file.Find`](libraries/file.md) — the `"LUA"` path searches the merged
`lua/` folder of every mounted addon; and [`string.Left`](libraries/string.md) /
[`string.EndsWith`](libraries/string.md). Note this loader **skips** files without
an `sv_`/`sh_`/`cl_` prefix — drop the `print` calls in production, and add an
`else`/default branch if you want unprefixed files treated as shared.

---

## 2. Hooks

Two kinds:

**Gamemode/library hooks** — react to engine events with `hook.Add`:

```lua
hook.Add("PlayerSay", "myaddon_chatcmds", function(ply, text, teamChat)
    if text == "!ping" then
        ply:ChatPrint("pong")
        return ""        -- returning "" suppresses the original message
    end
end)
```

- 2nd arg is a **unique identifier** (string, or a table/entity for auto-cleanup).
  Re-adding the same event+id replaces the previous one. Remove with
  `hook.Remove("PlayerSay", "myaddon_chatcmds")`.
- The available events are the `GM` namespace (and `SANDBOX` for sandbox-derived
  modes) — see `references/hooks/GM.md` and `SANDBOX.md`.
- **Pass the bare event name to `hook.Add`.** The reference files list these as
  `GM:PlayerSay` because that is the *method-override* form — but the `hook.Add`
  string drops the prefix: `hook.Add("PlayerSay", id, fn)`, **not**
  `hook.Add("GM:PlayerSay", …)` (the prefixed string silently never fires). The
  two valid ways to handle a gamemode hook:
  ```lua
  hook.Add("PlayerSay", "my_id", function(ply, text) end)  -- from anywhere
  function GM:PlayerSay(ply, text) end                     -- inside the gamemode itself
  ```
- Returning a value from a hook often overrides default behaviour (documented per
  hook). Return `nil`/nothing to let other hooks and the engine continue.

**Object method hooks** — override methods on a SWEP/ENT/PANEL/NEXTBOT/EFFECT/
TOOL/DRIVE/PLAYER table (see skeletons below). e.g. `function ENT:Think()`,
`function SWEP:PrimaryAttack()`, `function PANEL:Paint(w, h)`. These are **not**
`hook.Add` events — you define them directly on your object's table and the
engine calls them on that object (`self`). The `references/hooks/<NS>.md` file
for each namespace states which style it uses at the top.

---

## 3. Networking server ↔ client

### 3a. The `net` library (events / RPC-style messages)

Order of `net.Write*` must match `net.Read*` exactly. Strings used as message
names must be registered server-side with `util.AddNetworkString`.

```lua
-- SHARED or SERVER: register the message name once, server-side.
if SERVER then util.AddNetworkString("MyAddon_Notify") end

-- SERVER → CLIENT
if SERVER then
    local function NotifyPlayer(ply, msg, level)
        net.Start("MyAddon_Notify")
            net.WriteString(msg)
            net.WriteUInt(level, 4)       -- 4-bit unsigned (0..15)
        net.Send(ply)                     -- or net.Broadcast() for everyone
    end
end

-- CLIENT receives
if CLIENT then
    net.Receive("MyAddon_Notify", function(len)
        local msg   = net.ReadString()
        local level = net.ReadUInt(4)
        notification.AddLegacy(msg, level, 4)
    end)
end

-- CLIENT → SERVER
if CLIENT then
    net.Start("MyAddon_Buy")
        net.WriteString("medkit")
    net.SendToServer()
end
if SERVER then
    util.AddNetworkString("MyAddon_Buy")
    net.Receive("MyAddon_Buy", function(len, ply)   -- ply = sender, ALWAYS validate
        local item = net.ReadString()
        if not IsValid(ply) then return end
        -- never trust `item`; check the player can afford/own it server-side
    end)
end
```

Common writers (see `references/libraries/net.md` for all): `WriteString`,
`WriteUInt(v, bits)`, `WriteInt(v, bits)`, `WriteBool`, `WriteFloat`,
`WriteDouble`, `WriteEntity`, `WriteVector`, `WriteAngle`, `WriteTable`,
`WriteColor`, `WriteData`. Keep payloads small; prefer `WriteUInt` with the
minimum bit count over `WriteInt`/`WriteString` when you can.

### 3b. NetworkVars / DataTables (auto-synced entity state)

For per-entity state that should auto-replicate server→client, use NetworkVars
inside `SetupDataTables` (a method called on ENTs/SWEPs/players). The server sets,
clients read; accessors are generated for you.

```lua
-- shared.lua of a scripted entity
function ENT:SetupDataTables()
    self:NetworkVar("Int",    0, "Health")        -- -> self:GetHealth()/SetHealth()
    self:NetworkVar("Bool",   0, "Active")        -- -> GetActive/SetActive
    self:NetworkVar("Entity", 0, "Owner")         -- -> GetOwner/SetOwner
    self:NetworkVar("String", 0, "Label")
    self:NetworkVar("Vector", 0, "TargetPos")
end

-- SERVER sets, replicates automatically:
if SERVER then self:SetHealth(100) self:SetActive(true) end
-- CLIENT just reads:
if CLIENT then local hp = self:GetHealth() end
```

Slot numbers must be unique *per type* on the entity. Types: `Int`, `Float`,
`Bool`, `String`, `Entity`, `Vector`, `Angle`. (`NetworkVarElement` exists for
packing.) For arbitrary entities outside a class definition, use the `Entity:`
`SetNW2*`/`GetNW2*` family instead (see `references/classes/Entity.md`).

---

## 4. Scripted Entity (ENT / SENT) skeleton

`lua/entities/ent_myprop/` with three files.

```lua
-- shared.lua  (runs on both)
ENT.Type      = "anim"            -- "anim" | "ai" | "brush" | "point" | ...
ENT.Base      = "base_gmodentity"
ENT.PrintName = "My Prop"
ENT.Author    = "you"
ENT.Spawnable = true              -- appears in the spawn menu (Sandbox)

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "On")
end
```

```lua
-- init.lua  (SERVER)
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_junk/wood_crate001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)      -- SOLID_* enum: references/enums/SOLID.md
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then phys:Wake() end
    self:SetOn(true)
end

function ENT:Think()
    -- server logic; call self:NextThink(CurTime() + 0.1) and return true to keep ticking
end

function ENT:Use(activator, caller)
    self:SetOn(not self:GetOn())
end
```

```lua
-- cl_init.lua  (CLIENT)
include("shared.lua")

function ENT:Draw()
    self:DrawModel()                       -- render.* / surface.* are valid here
    -- draw extra clientside effects...
end
```

Entity hooks/overrides (`ENT:Initialize`, `ENT:Think`, `ENT:Draw`, `ENT:Use`,
`ENT:OnRemove`, `ENT:PhysicsCollide`, …) are in `references/hooks/ENT.md`.
`Entity:` methods you call on `self` are in `references/classes/Entity.md`.

---

## 5. Scripted Weapon (SWEP) skeleton

`lua/weapons/weapon_mygun/` with `shared.lua`, `init.lua`, `cl_init.lua` (or a
single shared file using realm branches).

```lua
-- shared.lua
SWEP.Base          = "weapon_base"
SWEP.PrintName     = "My Gun"
SWEP.Spawnable     = true
SWEP.Slot          = 2
SWEP.ViewModel     = "models/weapons/c_pistol.mdl"
SWEP.WorldModel    = "models/weapons/w_pistol.mdl"
SWEP.UseHands      = true

SWEP.Primary   = { ClipSize = 12, DefaultClip = 24, Automatic = false, Ammo = "Pistol" }
SWEP.Secondary = { ClipSize = -1, DefaultClip = -1, Automatic = false, Ammo = "none" }

function SWEP:Initialize()
    self:SetHoldType("pistol")
end

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then return end
    self:SetNextPrimaryFire(CurTime() + 0.4)
    self:EmitSound("Weapon_Pistol.Single")
    self:ShootEffects()

    local owner = self:GetOwner()
    if not IsValid(owner) then return end

    -- bullets are server-authoritative; ShootBullet works in a predicted context
    local bullet = {
        Num       = 1,
        Src       = owner:GetShootPos(),
        Dir       = owner:GetAimVector(),
        Spread    = Vector(0.02, 0.02, 0),
        Damage    = 15,
        Force     = 5,
        Tracer    = 1,
        AmmoType  = self.Primary.Ammo,
    }
    owner:LagCompensation(true)
    owner:FireBullets(bullet)
    owner:LagCompensation(false)

    self:TakePrimaryAmmo(1)
end

function SWEP:SecondaryAttack() end
```

SWEP hooks (`SWEP:PrimaryAttack`, `SWEP:Think`, `SWEP:Reload`, `SWEP:Deploy`,
`SWEP:ViewModelDrawn`, `SWEP:DrawHUD`, …) are in `references/hooks/SWEP.md`;
`Weapon:` methods are in `references/classes/Weapon.md`.

> Predicted SWEP methods run on both client (prediction) and server. Side effects
> that must happen once (sounds done via `EmitSound`, `ShootEffects`) are handled
> by the prediction system — read the per-hook notes before networking manually.

---

## 6. Gamemode skeleton

`gamemodes/mygamemode/gamemode/` with `init.lua` (server), `cl_init.lua`
(client), `shared.lua`.

```lua
-- shared.lua
GM.Name   = "My Gamemode"
GM.Author = "you"
DeriveGamemode("base")                 -- inherit base gamemode

function GM:Initialize()               -- runs in whichever realm included it
end
```

```lua
-- init.lua  (SERVER)
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function GM:PlayerInitialSpawn(ply, transition)
    ply:SetTeam(1)
end

function GM:PlayerSpawn(ply)
    ply:SetModel("models/player/group01/male_07.mdl")
    ply:Give("weapon_pistol")
end
```

```lua
-- cl_init.lua  (CLIENT)
include("shared.lua")

function GM:HUDPaint()                 -- 2D screen drawing, client only
    draw.SimpleText("Hello", "DermaLarge", 20, 20, color_white)
end
```

Override any gamemode event by defining it as a `function GM:Event()` method here
(inside the gamemode) — or, from outside the gamemode, with
`hook.Add("Event", id, fn)` using the **bare** name (not `"GM:Event"`). Both reach
the same event. Full list: `references/hooks/GM.md` (and `SANDBOX.md` for
sandbox-derived modes).

---

## 7. Derma / VGUI (client only)

Panels live entirely in the client realm. Create, configure, and paint.

```lua
-- CLIENT
local frame = vgui.Create("DFrame")
frame:SetSize(400, 300)
frame:Center()
frame:SetTitle("My Window")
frame:MakePopup()                      -- grabs mouse focus

local btn = vgui.Create("DButton", frame)   -- parent to the frame
btn:Dock(BOTTOM)                            -- DOCK enum: references/enums/DOCK.md
btn:SetText("Close")
btn.DoClick = function() frame:Close() end

-- custom painting: override Paint(self, w, h)
local panel = vgui.Create("DPanel", frame)
panel:Dock(FILL)
panel.Paint = function(self, w, h)
    surface.SetDrawColor(40, 40, 40, 255)
    surface.DrawRect(0, 0, w, h)
end
```

Panel classes and their methods are in `references/panels/<Panel>.md` (e.g.
`DFrame.md`, `DButton.md`, `DScrollPanel.md`, `DTextEntry.md`). Drawing helpers:
`references/libraries/surface.md`, `draw.md`, `render.md`. Built-in icon paths:
`references/assets/materials-icon16.md`.

---

## 8. Common gotchas

- **`IsValid` everything.** Entities, players, panels, physics objects become
  invalid/`NULL` constantly (disconnect, removal, async). `if IsValid(x) then`
  before every use. `IsValid(nil)` is safely `false`.
- **Realm mismatch is silent or fatal.** `surface`/`render`/`cam`/`vgui`/`draw`/
  `mesh`/`input` are **client**. `ents.Create`, `util.AddNetworkString`,
  authoritative damage/spawning are **server**. Check the reference's Realm.
- **`Entity:GetOwner()` vs `:CPPIGetOwner()`** — the latter is the prop-protection
  (CPPI) owner from a separate addon API; don't assume it exists.
- **Don't trust the client.** Anything from `net.Receive`'s sender, or any client
  request, must be re-validated server-side. Clients can send arbitrary data.
- **Floats and `net`** — `net.WriteFloat` loses precision; use `WriteDouble` or
  fixed-point `WriteUInt` for money/IDs. Read in the exact write order.
- **`hook.Add` IDs** must be stable & unique; libraries colliding on `"id"`
  silently overwrite each other.
- **`timer.Create`/`timer.Simple`** for delays; never busy-loop. `CurTime()` is
  the gameplay clock (shared, prediction-aware); `RealTime()`/`SysTime()` are
  wall clocks (client UI/profiling).
- **Color & Vector are objects.** `Color(r,g,b,a)`, `Vector(x,y,z)`,
  `Angle(p,y,r)` — construct via globals (`references/globals.md`); operate via
  their classes (`references/classes/Vector.md`, `Angle.md`).
- **Enums are plain numbers/flags.** Bitwise flags combine with `bit.bor(...)`
  (e.g. `MASK_*`, `FCVAR_*`, `RT_*`). Exact values: `references/enums/`.
- **Read the Note/Warning/Bug callouts** in each reference member — they document
  engine bugs (with issue numbers), prediction caveats, and singleplayer quirks
  that are not obvious from the signature.

---

See `references/README.md` for the full category map, and each category's
`README.md` for an indexed, scannable list of its units.

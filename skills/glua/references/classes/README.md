# Classes (meta tables)

This category covers GMod's meta-table classes: live objects you obtain at runtime (from a constructor, accessor, or hook argument) and then act on. Members are **colon methods** — you call them on an instance with `:`, where the instance is the implicit `self`, e.g. `ent:GetPos()`, `vec:Length()`, `ply:Health()`, `mat:SetTexture(...)`. This is different from library tables (dot functions like `ents.Create()`), hook overrides, or string-path assets — those live in other categories. The colon objects here are produced by such functions/hooks and then manipulated through their methods.

To pick the right unit, start from the object you are holding: an `Entity` covers everything (props, ragdolls, the world); `Player`, `NPC`, `Weapon`, and `Vehicle` are specialized entities that add their own methods on top of `Entity`'s. Math types (`Vector`, `Angle`, `VMatrix`, `Color`) are value-like objects; physics is `PhysObj`; movement/input prediction is `CMoveData`/`CUserCmd`; UI is `Panel`. When in doubt, open the per-unit file and match the constructor that handed you the object.

## Most-used
- [Entity](Entity.md) — the base class for every prop, NPC, weapon, vehicle, and the world; 557 methods cover position, parenting, networking, models, and more.
- [Player](Player.md) — per-player methods: health, team, weapons, input, money/score; subclass of Entity.
- [Vector](Vector.md) — 3D positions, directions, and velocities; the workhorse math type used everywhere.
- [Angle](Angle.md) — pitch/yaw/roll orientation, paired constantly with Vector for aim and placement.
- [NPC](NPC.md) — AI entity control: scheduling, enemies, capabilities, movement.
- [Weapon](Weapon.md) — SWEP instance methods: ammo, clips, deploy/holster state, primary/secondary fire.
- [Vehicle](Vehicle.md) — driver/seat access and vehicle-specific control for cars, pods, and seats.
- [PhysObj](PhysObj.md) — the VPhysics body behind an entity: mass, velocity, forces, freezing, collisions.
- [IMaterial](IMaterial.md) — material objects (from `Material()`) for rendering, surface draws, and shader params.
- [CMoveData](CMoveData.md) — read/write the player's movement simulation in prediction hooks.
- [CTakeDamageInfo](CTakeDamageInfo.md) — the damage event object: attacker, inflictor, amount, type, force.
- [Panel](Panel.md) — the VGUI base for every UI element; layout, paint, input, and child management.
- [ConVar](ConVar.md) — console-variable objects for reading/writing config and replicated settings.
- [Color](Color.md) — RGBA color objects used by rendering, surface, and UI code.
- [VMatrix](VMatrix.md) — 4x4 transform matrices for advanced positioning and rendering math.

## Realm notes
- Many classes are **shared** (Entity, Player, NPC, Weapon, Vehicle, Vector, Angle, PhysObj, CMoveData, CTakeDamageInfo), but individual methods may still be server- or client-only — confirm per method in the per-unit file.
- **Client-only** classes include `Panel` (VGUI), `ProjectedTexture`, `IMesh`, `CLuaParticle`, `CLuaEmitter`, `CNewParticleEffect`, `IGModAudioChannel`, and `bf_read`; do not touch these on the server.
- **Server-only** classes drive AI and navigation: `NPC`/NextBot logic via `CLuaLocomotion`, `CNavArea`, `CNavLadder`, `PathFollower`, `Schedule`, and `Task`.
- Several classes are usable in the **Menu** realm too (Angle, Color, Vector, ConVar, File, IMaterial, ITexture, Panel, Stack, WorkshopFileBase) — useful for menu/derma tooling.
- Getting an instance is realm-bound even when the class is shared: e.g. `ents.Create` is server-side, so client code must obtain its entities another way before calling these methods.

**Open the per-unit file for exact signatures — do not guess.**

| Unit | Realm | Members | Description |
|---|---|---|---|
| [Angle](Angle.md) | Shared, Menu | 18 | List of all possible functions to manipulate angles. · [wiki](https://wiki.facepunch.com/gmod/Angle) |
| [bf_read](bf_read.md) | Client | 11 | This is the object passed to usermessage.Hook when a message is received. · [wiki](https://wiki.facepunch.com/gmod/bf_read) |
| [CEffectData](CEffectData.md) | Shared | 32 | List of all possible functions available for effect data. · [wiki](https://wiki.facepunch.com/gmod/CEffectData) |
| [CLuaEmitter](CLuaEmitter.md) | Client | 12 | List of all possible functions available for LuaEmitters. · [wiki](https://wiki.facepunch.com/gmod/CLuaEmitter) |
| [CLuaLocomotion](CLuaLocomotion.md) | Server | 40 | This class is essentially what controls a NextBot NPC. · [wiki](https://wiki.facepunch.com/gmod/CLuaLocomotion) |
| [CLuaParticle](CLuaParticle.md) | Client | 44 | List of all possible functions available for Lua particles. · [wiki](https://wiki.facepunch.com/gmod/CLuaParticle) |
| [CMoveData](CMoveData.md) | Shared | 47 | A class used to store the inputs from CUserCmd and other information related to the current movement simulation, such as velocity, position… · [wiki](https://wiki.facepunch.com/gmod/CMoveData) |
| [CNavArea](CNavArea.md) | Server | 77 | An object returned by navmesh functions. · [wiki](https://wiki.facepunch.com/gmod/CNavArea) |
| [CNavLadder](CNavLadder.md) | Server | 22 | An object that represents a ladder for Nextbots. · [wiki](https://wiki.facepunch.com/gmod/CNavLadder) |
| [CNewParticleEffect](CNewParticleEffect.md) | Client | 26 | This object represents a .pcf ( Orange Box ) particle system. · [wiki](https://wiki.facepunch.com/gmod/CNewParticleEffect) |
| [Color](Color.md) | Shared, Menu | 28 | List of all possible functions to manipulate colors. · [wiki](https://wiki.facepunch.com/gmod/Color) |
| [ConVar](ConVar.md) | Shared, Menu | 16 | An object returned by CreateConVar, CreateClientConVar (which uses CreateConVar internally), and GetConVar. · [wiki](https://wiki.facepunch.com/gmod/ConVar) |
| [CRecipientFilter](CRecipientFilter.md) | Server | 16 | List of all possible functions to manipulate Recipient Filters. · [wiki](https://wiki.facepunch.com/gmod/CRecipientFilter) |
| [CSEnt](CSEnt.md) | Client | 1 | CSEnt is a client-side only entity which can be created with ClientsideModel, ClientsideRagdoll and ClientsideScene. · [wiki](https://wiki.facepunch.com/gmod/CSEnt) |
| [CSoundPatch](CSoundPatch.md) | Shared | 13 | CSoundPatch class. · [wiki](https://wiki.facepunch.com/gmod/CSoundPatch) |
| [CTakeDamageInfo](CTakeDamageInfo.md) | Shared | 33 | A class used to store and modify all the data concerning a damage event. · [wiki](https://wiki.facepunch.com/gmod/CTakeDamageInfo) |
| [CUserCmd](CUserCmd.md) | Shared | 27 | A class used to store the player inputs, such as mouse movement, view angles, IN buttons pressed and analog movement, the data from this cl… · [wiki](https://wiki.facepunch.com/gmod/CUserCmd) |
| [Entity](Entity.md) | Shared | 557 | This is a list of all available methods for all entities, which includes Players, Weapons, NPCs and Vehicles. · [wiki](https://wiki.facepunch.com/gmod/Entity) |
| [File](File.md) | Shared, Menu | 28 | This is the file object. · [wiki](https://wiki.facepunch.com/gmod/File) |
| [IGModAudioChannel](IGModAudioChannel.md) | Client | 41 | A sound channel returned by a callback of sound.PlayURL and sound.PlayFile. · [wiki](https://wiki.facepunch.com/gmod/IGModAudioChannel) |
| [IMaterial](IMaterial.md) | Shared, Menu | 26 | A Material object. · [wiki](https://wiki.facepunch.com/gmod/IMaterial) |
| [IMesh](IMesh.md) | Client | 5 | Renderable mesh object, can be used to create models on the fly. · [wiki](https://wiki.facepunch.com/gmod/IMesh) |
| [IRestore](IRestore.md) | Shared | 9 | The object used in the saverestore, mainly in saverestore.AddRestoreHook. · [wiki](https://wiki.facepunch.com/gmod/IRestore) |
| [ISave](ISave.md) | Shared | 9 | The object used in the saverestore, mainly in saverestore.AddSaveHook. · [wiki](https://wiki.facepunch.com/gmod/ISave) |
| [ITexture](ITexture.md) | Shared, Menu | 10 | An object representing game texture, such as those loaded from a `.vtf` file. · [wiki](https://wiki.facepunch.com/gmod/ITexture) |
| [IVideoWriter](IVideoWriter.md) | Client, Menu | 5 | This is returned from video.Record. · [wiki](https://wiki.facepunch.com/gmod/IVideoWriter) |
| [MarkupObject](MarkupObject.md) | Client, Menu | 5 | Object containing parsed markup for later rendering. · [wiki](https://wiki.facepunch.com/gmod/MarkupObject) |
| [NextBot](NextBot.md) | Server | 20 | NextBots are a new system to create NPCs in the Source Engine, utilizing the more powerful navmesh system for navigation over the old node… · [wiki](https://wiki.facepunch.com/gmod/NextBot) |
| [NPC](NPC.md) | Shared | 182 | This is a list of all methods only available for NPCs. · [wiki](https://wiki.facepunch.com/gmod/NPC) |
| [Panel](Panel.md) | Client, Menu | 290 | This is the base panel for every other VGUI panel. · [wiki](https://wiki.facepunch.com/gmod/Panel) |
| [PathFollower](PathFollower.md) | Server | 31 | Path object for a NextBot NPC and bots created by player.CreateNextbot. · [wiki](https://wiki.facepunch.com/gmod/PathFollower) |
| [PhysCollide](PhysCollide.md) | Shared | 3 | A PhysCollide holds collision data from VPhysics. · [wiki](https://wiki.facepunch.com/gmod/PhysCollide) |
| [PhysObj](PhysObj.md) | Shared | 78 | This is the object returned by Entity:GetPhysicsObject, Entity:GetPhysicsObjectNum and Vehicle:GetWheel. · [wiki](https://wiki.facepunch.com/gmod/PhysObj) |
| [Player](Player.md) | Shared | 270 | This is a list of all methods only available for players. · [wiki](https://wiki.facepunch.com/gmod/Player) |
| [ProjectedTexture](ProjectedTexture.md) | Client | 48 | A client side projected texture, created by ProjectedTexture. · [wiki](https://wiki.facepunch.com/gmod/ProjectedTexture) |
| [Schedule](Schedule.md) | Server | 6 | The object returned by ai_schedule.New. · [wiki](https://wiki.facepunch.com/gmod/Schedule) |
| [Stack](Stack.md) | Shared, Menu | 5 | An object returned by util.Stack. · [wiki](https://wiki.facepunch.com/gmod/Stack) |
| [SurfaceInfo](SurfaceInfo.md) | Shared | 5 | A brush surface object returned by Entity:GetBrushSurfaces. · [wiki](https://wiki.facepunch.com/gmod/SurfaceInfo) |
| [Task](Task.md) | Server | 9 | A single AI task. · [wiki](https://wiki.facepunch.com/gmod/Task) |
| [Tool](Tool.md) | Shared | 33 | A list of functions available inside a Sandbox Toolgun tool. · [wiki](https://wiki.facepunch.com/gmod/Tool) |
| [Vector](Vector.md) | Shared, Menu | 34 | List of all possible functions to manipulate vectors. · [wiki](https://wiki.facepunch.com/gmod/Vector) |
| [Vehicle](Vehicle.md) | Shared | 49 | This is a list of all methods only available for vehicles. · [wiki](https://wiki.facepunch.com/gmod/Vehicle) |
| [VMatrix](VMatrix.md) | Shared | 35 | A 4x4 matrix. · [wiki](https://wiki.facepunch.com/gmod/VMatrix) |
| [Weapon](Weapon.md) | Shared | 35 | This is a list of all methods only available for weapons. · [wiki](https://wiki.facepunch.com/gmod/Weapon) |
| [WorkshopFileBase](WorkshopFileBase.md) | Shared, Menu | 5 | This object is created by WorkshopFileBase which is used internally to fetch data of the specific namespace or to publish saves and dupes. · [wiki](https://wiki.facepunch.com/gmod/WorkshopFileBase) |

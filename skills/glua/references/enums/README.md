# Enumerations

This category collects GMod's enumeration families — named numeric constants and bit-flag sets that are passed into and returned from engine functions. Members are plain Lua globals (e.g. `KEY_W`, `IN_JUMP`, `MASK_SOLID`, `FL_ONGROUND`): you reference them directly, never call them. There are no colon methods or dot functions here — the *consumers* of these values are the methods, hooks, and functions documented in their own units. Some families are single-value selectors (pick one, like `MOVETYPE_*` or `RENDERMODE_*`); others are bit-flags meant to be combined with `bit.bor` / tested with `bit.band` (like `FL_*`, `EFL_*`, `FCVAR_*`, `DMG_*`, `MASK_*`).

To choose the right unit, match the function you are calling: the Description column names the API that consumes each family (e.g. `Entity:SetMoveType` takes `MOVETYPE_*`, `Entity:AddFlags` takes `FL_*`, trace tables take `MASK_*`). Open that family's file to see every constant and its exact numeric meaning.

## Most-used

- [KEY](KEY.md) — keyboard codes for `input.IsKeyDown` and key-trap/binding lookups.
- [IN](IN.md) — abstracted action buttons (`IN_JUMP`, `IN_ATTACK`) tested against player buttons, the backbone of movement/weapon input.
- [FCVAR](FCVAR.md) — ConVar/concommand flags (`FCVAR_ARCHIVE`, `FCVAR_REPLICATED`) for `CreateConVar` and `concommand.Add`.
- [MASK](MASK.md) — trace masks (`MASK_SOLID`, `MASK_SHOT`) controlling what traces collide with.
- [FL](FL.md) — entity flags (`FL_ONGROUND`, `FL_DUCKING`) read/written via `Entity:AddFlags` / `IsFlagSet`.
- [EFL](EFL.md) — engine entity flags used by `Entity:AddEFlags`, `RemoveEFlags`, `IsEFlagSet`.
- [COLLISION_GROUP](COLLISION_GROUP.md) — collision groups for `Entity:SetCollisionGroup` and trace filtering.
- [MOVETYPE](MOVETYPE.md) — movement modes (`MOVETYPE_WALK`, `MOVETYPE_NOCLIP`) for `Entity:SetMoveType`.
- [RENDERMODE](RENDERMODE.md) — render/transparency modes for `Entity:SetRenderMode`.
- [DMG](DMG.md) — damage-type bit-flags used by `CTakeDamageInfo` damage-type methods.
- [HITGROUP](HITGROUP.md) — hit groups (`HITGROUP_HEAD`, etc.) for damage scaling hooks and `Player:LastHitGroup`.
- [TYPE](TYPE.md) — Lua/engine type IDs returned by `TypeID` and used by `net.ReadType`.

## Realm notes

- Enums are plain numbers and bit-flags — they exist in every realm with no realm cost; the realm constraint comes from the *consuming* API, not the constant.
- Client-only families gate render/UI/audio APIs: `BLEND`, `STENCIL*`, `MATERIAL_*`, `VIEW`, `RT_SIZE`, `IMAGE_FORMAT`, `TEXTUREFLAGS`, `FFT`, `NOTIFY`, `DOCK` are consumed by client-side `render.*`, `surface`/draw, panel, and audio functions.
- Server-only families gate NPC/AI and spawn logic: `SCHED`, `COND`, `CAP`, `CLASS`, `HULL`, `NPC_STATE`, `NAV*`, `SF`, `SOUND` are used only in serverside NPC methods and hooks.
- Shared families (`KEY`, `IN`, `FL`, `EFL`, `MASK`, `DMG`, `MOVETYPE`, `COLLISION_GROUP`, `TYPE`) are safe everywhere, but the function you pass them to may still be realm-restricted — check that unit, not the enum.
- A few families carry the Menu realm (`FCVAR`, `MOUSE`, `KEY`, `BUTTON_CODE`, `TYPE`, ...); use them inside menu-state code only when the table marks them Menu.

**Open the per-unit file for exact signatures — do not guess.**

| Family | Constants | Realm | Description |
|---|---|---|---|
| [_USE](_USE.md) | 4 | Shared | Enumerations used by Entity:SetUseType. |
| [ACT](ACT.md) | 1597 | Shared | Enumerations used by functions like Weapon:SendWeaponAnim & Entity:SelectWeightedSequence. |
| [AIMR](AIMR.md) | 6 | Server | Used by NPC:MoveClimbExec, NPC:MoveJumpExec and NPC:MoveJumpStop. |
| [AMMO](AMMO.md) | 2 | Shared | Used by game.AddAmmoType's input structure - the Structures/AmmoData. |
| [ANALOG](ANALOG.md) | 9 | Client | The analog axis to get the value of via input.GetAnalogValue. |
| [BLEND](BLEND.md) | 11 | Client | These enums are used by render.OverrideBlend to determine what the Source and Destination color and alpha channel values for a given pixel… |
| [BLENDFUNC](BLENDFUNC.md) | 5 | Shared, Menu | These enums are used by render.OverrideBlend to combine the Source and Destination color and alpha into a final pixel color after they have… |
| [BLOOD_COLOR](BLOOD_COLOR.md) | 8 | Shared | Enumerations used by Entity:GetBloodColor and Entity:SetBloodColor. |
| [BONE](BONE.md) | 20 | Shared | Used by Entity:BoneHasFlag. |
| [BOUNDS](BOUNDS.md) | 2 | Shared | Enumerations used by Entity:SetSurroundingBoundsType. |
| [BOX](BOX.md) | 6 | Shared, Menu | Enumerations used by render.SetModelLighting. |
| [BUTTON_CODE](BUTTON_CODE.md) | 4 | Shared, Menu | Encompasses the range of KEY, MOUSE and JOYSTICK, all of which can be used by: * input.IsButtonDown * input.LookupKeyBinding * input.GetKey… |
| [CAP](CAP.md) | 30 | Server | Enumerations used by NPC:CapabilitiesAdd, WEAPON:GetCapabilities and NPC:CapabilitiesGet. |
| [CHAN](CHAN.md) | 11 | Shared | Enumerations used by EmitSound and sound.Add. |
| [CLASS](CLASS.md) | 37 | Server | Enumerations used by NPC:Classify. |
| [COLLISION_GROUP](COLLISION_GROUP.md) | 23 | Shared | Enumerations used by Entity:SetCollisionGroup, Entity:GetCollisionGroup and Traces. |
| [COND](COND.md) | 71 | Server | Enumerations for NPC conditions, used by NPC:SetCondition. |
| [CONTENTS](CONTENTS.md) | 34 | Shared | Enumerations used by util.PointContents and PhysObj:SetContents as tracer masks, and by ENT.PhysicsSolidMask for collision masking. |
| [CREATERENDERTARGETFLAGS](CREATERENDERTARGETFLAGS.md) | 3 | Client | Enumerations used by GetRenderTargetEx. |
| [CT](CT.md) | 5 | Server | Citizen type, a KeyValue for npc_citizen( citizentype ), serverside only. |
| [D](D.md) | 5 | Server | Enumerations used by NPC:Disposition and ENTITY:GetRelationship. |
| [DEATH_NOTICE](DEATH_NOTICE.md) | 2 | Shared | Enumerations used internally by death notice system. |
| [DISPSURF](DISPSURF.md) | 5 | Shared | Displacement surface flags, used by the Structures/TraceResult. |
| [DMG](DMG.md) | 33 | Shared | Enumerations used by CTakeDamageInfo:GetDamageType, CTakeDamageInfo:SetDamageType and CTakeDamageInfo:IsDamageType. |
| [DOCK](DOCK.md) | 6 | Client, Menu | Enumerations used by Panel:Dock. |
| [DOF](DOF.md) | 2 | Client | Internal globals for SimpleDoF. |
| [EF](EF.md) | 12 | Shared | Enumerations used by Entity:AddEffects, Entity:RemoveEffects and Entity:IsEffectActive. |
| [EFL](EFL.md) | 32 | Shared | Enumerations used by Entity:AddEFlags, Entity:RemoveEFlags and Entity:IsEFlagSet. |
| [FCVAR](FCVAR.md) | 23 | Shared, Menu | Enumerations used by AddConsoleCommand, concommand.Add, CreateClientConVar and CreateConVar. |
| [FFT](FFT.md) | 8 | Client | Enumerations used by IGModAudioChannel:FFT. |
| [FL](FL.md) | 32 | Shared | Enumerations used by Entity:AddFlags, Entity:RemoveFlags and Entity:IsFlagSet. |
| [FORCE](FORCE.md) | 6 | Shared, Menu | Enumerations used by AccessorFunc. |
| [FSASYNC](FSASYNC.md) | 13 | Shared | Used by file.AsyncRead. |
| [FSOLID](FSOLID.md) | 11 | Shared | Enumerations used by Entity:SetSolidFlags and Entity:GetSolidFlags. |
| [FVPHYSICS](FVPHYSICS.md) | 13 | Shared | Enumerations used by PhysObj:AddGameFlag, PhysObj:HasGameFlag and PhysObj:ClearGameFlag. |
| [GESTURE_SLOT](GESTURE_SLOT.md) | 7 | Shared | Enumerations used by Player:AddVCDSequenceToGestureSlot, Player:AnimResetGestureSlot and Player:AnimRestartGesture. |
| [GLOBAL](GLOBAL.md) | 3 | Server | Enumerations used by game.SetGlobalState and game.GetGlobalState. |
| [GMOD_CHANNEL](GMOD_CHANNEL.md) | 4 | Client | Enumerations used by IGModAudioChannel:GetState. |
| [GOALTYPE](GOALTYPE.md) | 9 | Server | Used by NPC:GetCurGoalType. |
| [HITGROUP](HITGROUP.md) | 9 | Shared | Enumerations used by GM:ScalePlayerDamage and GM:ScaleNPCDamage and returned by Player:LastHitGroup. |
| [HUD](HUD.md) | 4 | Shared | Enumerations used by Player:PrintMessage and PrintMessage. |
| [HULL](HULL.md) | 10 | Server | Enumerations used by NPC:SetHullType and NPC:GetHullType. |
| [IMAGE_FORMAT](IMAGE_FORMAT.md) | 10 | Client | Enumerations used by GetRenderTargetEx to determine the byte format of each pixel in the Render Target. |
| [IN](IN.md) | 25 | Shared | Unlike BUTTON_CODE, these enums are abstracted to allow the user to bind actions to any key they might prefer. |
| [JOYSTICK](JOYSTICK.md) | 8 | Shared, Menu | Enumerations used by input.IsButtonDown. |
| [KEY](KEY.md) | 134 | Shared, Menu | Enumerations used by: * input.IsKeyDown * input.WasKeyPressed * input.WasKeyReleased * input.WasKeyTyped * input.IsKeyTrapping * input.GetK… |
| [kRenderFx](kRenderFx.md) | 25 | Shared | Used by Entity:SetRenderFX and returned by Entity:GetRenderFX. |
| [MASK](MASK.md) | 21 | Shared | Enumerations used as trace masks in Structures/Trace and Structures/HullTrace. |
| [MAT](MAT.md) | 23 | Shared | Enumerations used in Structures/TraceResult and Structures/SurfacePropertyData, and by Entity:GetMaterialType. |
| [MATERIAL](MATERIAL.md) | 8 | Client | Enumerations used by mesh.Begin to control what type of vertex information it should expect. |
| [MATERIAL_CULLMODE](MATERIAL_CULLMODE.md) | 3 | Client | Enumerations used by render.CullMode. |
| [MATERIAL_FOG](MATERIAL_FOG.md) | 3 | Client | Enumerations used by render.GetFogMode and render.FogMode. |
| [MATERIAL_LIGHT](MATERIAL_LIGHT.md) | 4 | Client | Enumerations used by render.SetLocalModelLights. |
| [MATERIAL_RT_DEPTH](MATERIAL_RT_DEPTH.md) | 4 | Client | Enumerations used by GetRenderTargetEx. |
| [MOUSE](MOUSE.md) | 10 | Shared, Menu | Enumerations used by: * input.IsMouseDown * input.WasMousePressed * input.WasMouseDoublePressed It's also part of the BUTTON_CODE. |
| [MOVECOLLIDE](MOVECOLLIDE.md) | 5 | Shared | Enumerations used by Entity:SetMoveCollide and Entity:GetMoveCollide. |
| [MOVETYPE](MOVETYPE.md) | 12 | Shared | Enumerations used by Entity:SetMoveType and Entity:GetMoveType. |
| [NAV](NAV.md) | 5 | Server | Used by NPC:SetNavType and NPC:GetNavType. |
| [NAV_MESH](NAV_MESH.md) | 22 | Server | Enumerations used by CNavArea:GetAttributes and CNavArea:HasAttributes. |
| [NavCorner](NavCorner.md) | 5 | Server | Enumerations used by CNavArea methods. |
| [NavDir](NavDir.md) | 4 | Server | Enumerations used by CNavArea methods. |
| [NavTraverseType](NavTraverseType.md) | 9 | Server | Enumerations used by CNavArea:GetParentHow. |
| [NOTIFY](NOTIFY.md) | 5 | Client, Menu | Enumerations used by notification.AddLegacy. |
| [NPC_STATE](NPC_STATE.md) | 9 | Server | Enumerations used by NPC:SetNPCState. |
| [NUM](NUM.md) | 2 | Server | Various count enums. |
| [OBS_MODE](OBS_MODE.md) | 7 | Shared | Enumerations used by Player:SetObserverMode, Player:GetObserverMode and Player:Spectate. |
| [PATTACH](PATTACH.md) | 6 | Shared | Enumerations used by ParticleEffectAttach. |
| [PLAYER](PLAYER.md) | 10 | Shared | Enumerations used by Entity:SetAnimation |
| [PLAYERANIMEVENT](PLAYERANIMEVENT.md) | 24 | Shared | Used by GM:DoAnimationEvent and Player:DoCustomAnimEvent. |
| [RENDERGROUP](RENDERGROUP.md) | 10 | Shared | Enumerations used by ClientsideModel, `ENT.RenderGroup` in Structures/ENT and Entity:GetRenderGroup. |
| [RENDERMODE](RENDERMODE.md) | 11 | Shared | Enumerations used by Entity:SetRenderMode and Entity:GetRenderMode. |
| [RT_SIZE](RT_SIZE.md) | 10 | Client | Enumerations used by GetRenderTargetEx. |
| [SCHED](SCHED.md) | 89 | Server | Enumerations for NPC schedules, used by ENTITY:StartEngineSchedule, ENTITY:TranslateSchedule and NPC:SetSchedule. |
| [SCREENFADE](SCREENFADE.md) | 5 | Shared | Bitflags used by Player:ScreenFade. |
| [SENSORBONE](SENSORBONE.md) | 20 | Shared | Enumerations used by Kinect SDK bindings. |
| [SF](SF.md) | 34 | Server | Enumerations describing certain spawnflags. |
| [SIGNONSTATE](SIGNONSTATE.md) | 8 | Shared | Used by GM:ClientSignOnStateChanged. |
| [SIM](SIM.md) | 5 | Shared | Enumerations used by ENTITY:PhysicsSimulate. |
| [SND](SND.md) | 11 | Shared | Sound flags used by EmitSound and Entity:EmitSound. |
| [SNDLVL](SNDLVL.md) | 30 | Shared | The sound's attenuation, or how fast it drops away. |
| [SOLID](SOLID.md) | 7 | Shared | For use with Entity:PhysicsInit, Entity:SetSolid and Entity:GetSolid. |
| [SOUND](SOUND.md) | 28 | Server | Enumerations used by sound.EmitHint. |
| [STENCIL](STENCIL.md) | 16 | Client | Enumerations for use with render.SetStencilCompareFunction. |
| [STENCILCOMPARISONFUNCTION](STENCILCOMPARISONFUNCTION.md) | 8 | Client | Enumerations for use with render.SetStencilCompareFunction. |
| [STENCILOPERATION](STENCILOPERATION.md) | 8 | Client | Enumerations for use with render.SetStencilPassOperation, render.SetStencilFailOperation and render.SetStencilZFailOperation. |
| [STEPSOUNDTIME](STEPSOUNDTIME.md) | 4 | Shared | Enumerations used in GM:PlayerStepSoundTime hook. |
| [STUDIO](STUDIO.md) | 15 | Client | Used by: * Entity:DrawModel * ENTITY:Draw * ENTITY:DrawTranslucent * WEAPON:PreDrawViewModel * WEAPON:PostDrawViewModel * WEAPON:ViewModelD… |
| [SURF](SURF.md) | 16 | Shared | Surface flags, used by the Structures/TraceResult. |
| [TASKSTATUS](TASKSTATUS.md) | 5 | Server | Used by NPC:GetTaskStatus and NPC:SetTaskStatus. |
| [TEAM](TEAM.md) | 3 | Shared | Default defined teams in Garry's Mod. |
| [TEXFILTER](TEXFILTER.md) | 4 | Shared, Menu | Enumerations used by render.PushFilterMin and render.PushFilterMag. |
| [TEXT_ALIGN](TEXT_ALIGN.md) | 5 | Shared | Enumerations used by draw.SimpleText, draw.DrawText and in Structures/TextData. |
| [TEXT_FILTER](TEXT_FILTER.md) | 4 | Client | Used by util.FilterText. |
| [TEXTUREFLAGS](TEXTUREFLAGS.md) | 32 | Client | Bit flags used by GetRenderTargetEx. |
| [TRACER](TRACER.md) | 5 | Shared | Enumerations used by Structures/AmmoData. |
| [TRANSMIT](TRANSMIT.md) | 3 | Shared | Enumerations used in ENTITY:UpdateTransmitState hook. |
| [TYPE](TYPE.md) | 48 | Shared, Menu | Enumerations used by net.ReadType and returned by TypeID |
| [USE](USE.md) | 4 | Shared | Enumerations used by ENTITY:Use. |
| [VIEW](VIEW.md) | 9 | Client | Enumerations used by render.RenderView inside of Structures/ViewData. |
| [WEAPON_PROFICIENCY](WEAPON_PROFICIENCY.md) | 5 | Shared | Enumerations used by NPC:SetCurrentWeaponProficiency and NPC:GetCurrentWeaponProficiency. |

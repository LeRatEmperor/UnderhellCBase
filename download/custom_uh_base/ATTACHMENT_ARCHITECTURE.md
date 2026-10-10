# CustomUH Attachment System — Architecture Plan

## Goal
TFA-adjacent architecture, NOT TFA-compatible. Our own namespace, our own
folder, our own networking. Uses TFA icon assets temporarily.

## File Structure
```
custom_uh_base/
  lua/
    autorun/
      sh_customuh.lua              -- Core: registry, stats, networking, init
    customuh/                       -- System modules
      sh_att_save.lua              -- Save/load persistence (server)
      cl_att_ui.lua                -- Customization UI (client)
      cl_att_scope.lua             -- RT scope rendering (client)
      sh_att_ammo.lua              -- Custom ammo type registry
    customuh_attachments/           -- Attachment definitions (port from TFA format)
      bo4_att_optic_base.lua
      bo4_att_acog.lua
      ... (all 14 attachments)
    weapons/
      weapon_custom_uh_base.lua     -- Root base (add attachment hooks)
      weapon_custom_uh_base_gun.lua -- Gun base (add GetStat calls)
      weapon_custom_uh_base_shotty.lua
```

## Data Flow Simulation

### 1. Server Start → Attachment Registration
```
sh_customuh.lua loads
  → CustomUH = {}
  → CustomUH.Attachments = {}
  → file.Find("customuh_attachments/*.lua", "LUA")
  → For each file:
      ATTACHMENT = {}
      include(file)
      CustomUH.Attachments[id] = ATTACHMENT
  → CustomUH.AmmoTypes = {}
  → Register custom ammo types
```

### 2. Weapon Deploy → Load + Apply
```
SWEP:Deploy()
  → CustomUH.LoadAttachments(self)
    → Read customuh_saves/<steamid64>.json
    → Find entry for wep:GetClass()
    → Set self.Attachments[slot].sel = savedIndex
  → self:ApplyAttachments()
    → Restore all stats from _statOrigins
    → Deactivate all VElements/WElements
    → For each equipped attachment:
      → Apply WeaponTable stats (direct value or function(wep, oldVal))
      → Activate VElements/WElements
      → Call att:Attach(wep) — bodygroups, scope setup, etc.
  → self:InitVElements() — create ClientsideModels
  → self:InitWElements() — create world model elements
```

### 3. Player Opens Menu (C key)
```
cl_att_ui.lua detects key press
  → Check weapon has .Attachments and inherits from custom_uh_base
  → Create DFrame
    → For each slot (sorted):
      → Category header with icon
      → "None" button (index 0)
      → For each attachment in slot.atts:
        → DImageButton with att.Icon
        → Highlight if currently selected
        → Tooltip with att.Description
    → On click:
      → wep:SetAttachment(slot, index)
        → Store selection
        → ApplyAttachments() (rebuild stats, activate elements)
        → InitVElements() (create new csModels)
        → Network to server
        → Save to file
```

### 4. Stat System
```
Weapon defines:
  SWEP.Primary.Damage = 40

Attachment defines:
  ATTACHMENT.WeaponTable = {
    ["Primary.Damage"] = 60,                                    -- direct
    ["Primary.Spread"] = function(wep, val) return val * 0.5 end, -- multiplicative
    ["IronSightsPos"] = Vector(...),                            -- top-level
    ["VElements"] = { ["att_id"] = { active = true } },        -- element toggle
  }

ApplyAttachments():
  1. Copy _statOrigins → _statCache (full reset)
  2. Reset all VElements to default active state
  3. For each equipped attachment (in slot order):
     For each path, value in att.WeaponTable:
       if path == "VElements" or "WElements":
         Merge into ViewModelElements/WorldModelElements
       else if isfunction(value):
         _statCache[path] = value(wep, _statCache[path])
       else:
         _statCache[path] = value
  4. Write _statCache back to self.Primary, self.IronSightsPos, etc.
  5. Call att:Attach(wep) for side effects (bodygroups, scope)
```

### 5. VElement Rendering
```
InitVElements():
  For each VElement with type == "Model" and not already init:
    Create ClientsideModel(model, RENDERGROUP_VIEWMODEL)
    SetNoDraw(true)

DrawVElements(vm) — called in PostDrawViewModel:
  For each active VElement:
    If bonemerge:
      csModel:SetParent(vm)
      csModel:AddEffects(EF_BONEMERGE)
    Else:
      bonePos, boneAng = vm:GetBonePosition(boneId)
      Apply pos/ang offsets
      csModel:SetPos(pos), csModel:SetAngles(ang)
    Set material, skin, bodygroups, scale
    SuppressEngineLighting if surpresslightning
    csModel:DrawModel()

CleanupVElements() — called on Holster:
  For each VElement:
    if IsValid(csModel): csModel:Remove()
  _vElementsInit = false
```

### 6. WElement Rendering
```
InitWElements():
  For each WElement with type == "Model":
    Create ClientsideModel(model, RENDERGROUP_OPAQUE)
    SetNoDraw(true)

DrawWElements() — called in DrawWorldModel:
  For each active WElement:
    Get bone matrix from owner (ValveBiped.Bip01_R_Hand)
    Apply pos/ang offsets
    Draw model

CleanupWElements() — called on Holster:
  Remove all csModels
```

### 7. Save/Load System
```
File: customuh_saves/<steamid64>.json
Format:
{
  "weapon_bo4_kn57": { "1": 2, "2": 0, "3": 1 },
  "weapon_bo4_sdm": { "1": 0, "2": 1 }
}

LoadAttachments(wep):
  if CLIENT: return (server handles saves)
  Read file → parse JSON
  entry = data[wep:GetClass()]
  if entry:
    for slot, index in pairs(entry):
      if wep.Attachments[slot] and index <= #wep.Attachments[slot].atts:
        wep.Attachments[slot].sel = index
  → Network saved state to client

SaveAttachments(wep, ply):
  Read file → parse JSON (or {})
  data[wep:GetClass()] = current selections
  Write file

Triggers:
  - On SetAttachment (server receives net msg → apply → save)
  - On Deploy (load)
  - On Holster (save, in case of unsaved changes)
  - On Player Death (save all weapons)
```

### 8. Scope/RT System
```
Attachment defines:
  ATTACHMENT.RTScope = {
    MaterialIndex = 1,   -- VM material slot for RT texture
    ScopeFOV = 8,       -- FOV when scoped
    Reticle = "path/to/reticle.png",
    ReticleColor = Color(255, 0, 0),
  }

On Attach:
  Save old RTMaterialOverride, RTCode
  Set RTMaterialOverride = att.MaterialIndex
  Set RTCode = function that renders scope view

PreDrawViewModel:
  If RTCode and Zooming:
    PushRenderTarget(rtTexture)
    RenderView({ fov = ScopeFOV, drawviewmodel = false })
    PopRenderTarget()
    Apply rtTexture to VM material[MaterialIndex]
    Draw reticle overlay

On Detach:
  Restore old RTMaterialOverride, RTCode
```

### 9. Custom Ammo System
```
Registration:
  CustomUH.RegisterAmmo("uh_556", "5.56mm", 240)
  CustomUH.RegisterAmmo("uh_9mm", "9mm", 120)

Weapon uses:
  SWEP.Primary.Ammo = "uh_556"

HUD:
  CustomUH.GetAmmoName("uh_556") → "5.56mm"
  CustomUH.GetAmmoMax("uh_556") → 240

Fallback:
  If ammo type not registered, use GMod default name
```

### 10. Bodygroup System
```
Weapon defines:
  SWEP.SightBGs = { main = 1, regular = 0, acog = 1, reddot = 2 }
  SWEP.MagBGs = { main = 2, regular = 0, fast = 1, ext = 2 }

Attachment on Attach:
  wep:SetSightBodygroup(wep.SightBGs.acog)
  → Sets self.Bodygroups_V[main] = value
  → Applied in HandleBones()

Attachment on Detach:
  wep:SetSightBodygroup(wep.SightBGs.regular)
```

## Edge Cases
1. Weapon switch mid-reload → cancel reload, save attachments
2. Invalid bone name → skip VElement, console warning
3. Missing model file → skip, don't crash
4. RT scope on weapon without scope material → skip RT, use irons
5. Save file corruption → fallback to no attachments
6. Attachment ID in save file but attachment removed from code → skip
7. Bodygroup index out of range → clamp

## Implementation Order
1. Core registry + stat system (improve existing)
2. VElement system (add bonemerge, bodygroups, cleanup)
3. WElement system (new)
4. Bodygroup swap system (new)
5. Save/load system (new)
6. UI redesign (TFA-adjacent)
7. Scope/RT system (new)
8. Custom ammo system (new)
9. Port attachment files from TFA format
10. Testing + polish

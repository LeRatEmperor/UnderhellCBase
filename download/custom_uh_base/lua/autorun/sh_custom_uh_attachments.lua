-- sh_custom_uh_attachments.lua
-- Custom attachment system for the Custom Underhell base.
-- v1.1 — uses customuh_attachments/ folder (NOT TFA's attachments/ folder)
--
-- Features:
--   1. Registers attachments from lua/customuh_attachments/*.lua
--   2. Stat cache (GetStat/SetStat) so attachments can modify weapon stats
--   3. ApplyAttachments/RemoveAttachment
--   4. VElements (viewmodel models/sprites on bones)
--   5. Customization menu opened with C key (rebindable via customuh_menu_key convar)
--
-- Attachment file format (lua/customuh_attachments/att_name.lua):
--   ATTACHMENT.Name = "Display Name"
--   ATTACHMENT.Icon = "path/to/icon.png" (optional)
--   ATTACHMENT.Description = { Color(0,255,0), "+10% damage" }
--   ATTACHMENT.WeaponTable = {
--       ["Primary.Damage"] = 60,        -- direct value
--       ["Primary.Spread"] = 0.01,     -- direct value
--       ["IronSightsPos"] = Vector(...),-- top-level field
--       ["ViewModelElements"] = { ["sight"] = { active = true } },
--   }
--   function ATTACHMENT:Attach(wep) ... end
--   function ATTACHMENT:Detach(wep) ... end
--
-- This system is completely self-contained and does NOT conflict with TFA.
-- It uses its own namespace (CustomUH), its own attachment folder
-- (customuh_attachments/), and its own networking channels.

AddCSLuaFile()

CustomUH = CustomUH or {}
CustomUH.Attachments = CustomUH.Attachments or {}

CreateClientConVar("customuh_menu_key", "c", true, false, "Key to open weapon customization")

-- ============================================================
-- REGISTER ATTACHMENTS
-- ============================================================
function CustomUH.RegisterAttachments()
    -- Uses customuh_attachments/ folder — completely separate from TFA's attachments/
    local files = file.Find("customuh_attachments/*.lua", "LUA")
    for _, filename in ipairs(files) do
        ATTACHMENT = {}
        local path = "customuh_attachments/" .. filename
        AddCSLuaFile(path)
        include(path)
        if ATTACHMENT.Name then
            local id = string.StripExtension(filename)
            CustomUH.Attachments[id] = ATTACHMENT
        end
    end
end

-- ============================================================
-- STAT CACHE
-- ============================================================
function SWEP:InitStatCache()
    if self._statCache then return end
    self._statCache = {}
    self._statOrigins = {}

    for k, v in pairs(self.Primary or {}) do
        self._statCache["Primary." .. k] = v
        self._statOrigins["Primary." .. k] = v
    end
    for k, v in pairs(self.Secondary or {}) do
        self._statCache["Secondary." .. k] = v
        self._statOrigins["Secondary." .. k] = v
    end

    local topLevel = {
        "DamageGeneric", "Num", "FireRate", "Spread", "SpreadIronsighted",
        "ViewSlideRecoilUp", "ViewSlideRecoilRight", "ZoomFov",
    }
    for _, key in ipairs(topLevel) do
        if self[key] ~= nil then
            self._statCache[key] = self[key]
            self._statOrigins[key] = self[key]
        end
    end
    if self.IronSightsPos then
        self._statCache["IronSightsPos"] = self.IronSightsPos
        self._statOrigins["IronSightsPos"] = self.IronSightsPos
    end
    if self.IronSightsAng then
        self._statCache["IronSightsAng"] = self.IronSightsAng
        self._statOrigins["IronSightsAng"] = self.IronSightsAng
    end
end

function SWEP:GetStat(path)
    if not self._statCache then self:InitStatCache() end
    return self._statCache[path]
end

function SWEP:SetStat(path, value)
    if not self._statCache then self:InitStatCache() end
    self._statCache[path] = value
    if string.find(path, "%.") then
        local tbl, field = string.match(path, "(.+)%.(.+)")
        if self[tbl] then self[tbl][field] = value end
    else
        self[path] = value
    end
end

function SWEP:RestoreStat(path)
    if not self._statOrigins then return end
    local origin = self._statOrigins[path]
    if origin ~= nil then self:SetStat(path, origin) end
end

-- ============================================================
-- APPLY / REMOVE
-- ============================================================
function SWEP:ApplyAttachments()
    if not self.Attachments then return end
    if not self._statOrigins then self:InitStatCache() end

    for path, _ in pairs(self._statCache) do
        self:RestoreStat(path)
    end

    if self.ViewModelElements then
        for name, elem in pairs(self.ViewModelElements) do
            elem.active = elem._defaultActive or false
        end
    end

    for slot, slotData in pairs(self.Attachments) do
        local sel = slotData.sel
        if sel and sel > 0 then
            local attId = slotData.atts[sel]
            if attId and CustomUH.Attachments[attId] then
                local att = CustomUH.Attachments[attId]
                if att.WeaponTable then
                    for path, value in pairs(att.WeaponTable) do
                        if isfunction(value) then
                            self:SetStat(path, value(self, self:GetStat(path)))
                        else
                            self:SetStat(path, value)
                        end
                    end
                end
                if att.ViewModelElements then
                    if not self.ViewModelElements then self.ViewModelElements = {} end
                    for name, override in pairs(att.ViewModelElements) do
                        if self.ViewModelElements[name] then
                            for k, v in pairs(override) do self.ViewModelElements[name][k] = v end
                        else
                            self.ViewModelElements[name] = table.Copy(override)
                        end
                    end
                end
                if att.Attach then att:Attach(self) end
            end
        end
    end
end

function SWEP:SetAttachment(slot, index)
    if not self.Attachments or not self.Attachments[slot] then return end
    self.Attachments[slot].sel = index
    self:ApplyAttachments()
    if CLIENT then
        net.Start("CustomUH_AttSelect")
            net.WriteEntity(self)
            net.WriteUInt(slot, 8)
            net.WriteUInt(index, 8)
        net.SendToServer()
    end
end

-- ============================================================
-- VELEMENTS
-- ============================================================
function SWEP:InitVElements()
    if not self.ViewModelElements then return end
    if self._vElementsInit then return end
    self._vElementsInit = true
    for name, elem in pairs(self.ViewModelElements) do
        if elem.type == "Model" and CLIENT and elem.model and elem.model ~= "" then
            elem._csModel = ClientsideModel(elem.model, RENDERGROUP_VIEWMODEL)
            if IsValid(elem._csModel) then elem._csModel:SetNoDraw(true) end
        end
    end
end

function SWEP:DrawVElements(vm)
    if not self.ViewModelElements then return end
    for name, elem in pairs(self.ViewModelElements) do
        if elem.active and elem.type == "Model" and IsValid(elem._csModel) then
            local boneId = vm:LookupBone(elem.bone or "")
            if boneId then
                local bPos, bAng = vm:GetBonePosition(boneId)
                if bPos then
                    local pos = bPos
                    pos = pos + bAng:Right() * (elem.pos and elem.pos.x or 0)
                    pos = pos + bAng:Forward() * (elem.pos and elem.pos.y or 0)
                    pos = pos + bAng:Up() * (elem.pos and elem.pos.z or 0)
                    local ang = Angle(bAng)
                    ang:RotateAroundAxis(ang:Right(), (elem.ang and elem.ang.p) or 0)
                    ang:RotateAroundAxis(ang:Up(), (elem.ang and elem.ang.y) or 0)
                    ang:RotateAroundAxis(ang:Forward(), (elem.ang and elem.ang.r) or 0)
                    elem._csModel:SetPos(pos)
                    elem._csModel:SetAngles(ang)
                    elem._csModel:SetModelScale(elem.scale and elem.scale.x or 1, 0)
                    if elem.material then elem._csModel:SetMaterial(elem.material) end
                    elem._csModel:DrawModel()
                end
            end
        end
    end
end

-- ============================================================
-- NETWORKING
-- ============================================================
if SERVER then
    util.AddNetworkString("CustomUH_AttSelect")
    util.AddNetworkString("CustomUH_AttSync")
    net.Receive("CustomUH_AttSelect", function(len, ply)
        local wep = net.ReadEntity()
        local slot = net.ReadUInt(8)
        local index = net.ReadUInt(8)
        if IsValid(wep) and wep.Owner == ply then
            wep.Attachments[slot].sel = index
            wep:ApplyAttachments()
            net.Start("CustomUH_AttSync")
                net.WriteEntity(wep)
                net.WriteUInt(slot, 8)
                net.WriteUInt(index, 8)
            net.Broadcast()
        end
    end)
end

if CLIENT then
    net.Receive("CustomUH_AttSync", function()
        local wep = net.ReadEntity()
        local slot = net.ReadUInt(8)
        local index = net.ReadUInt(8)
        if IsValid(wep) and wep.Attachments and wep.Attachments[slot] then
            wep.Attachments[slot].sel = index
            wep:ApplyAttachments()
        end
    end)
end

-- ============================================================
-- CUSTOMIZATION MENU (C key)
-- ============================================================
if CLIENT then
    local menuPanel = nil

    concommand.Add("customuh_menu", function()
        -- If menu is already open, close it (toggle behavior)
        if IsValid(menuPanel) then
            menuPanel:Remove()
            menuPanel = nil
            return
        end

        local wep = LocalPlayer():GetActiveWeapon()
        -- Only open if the weapon has our custom base AND has attachments
        if not IsValid(wep) then return end
        if not wep.Base or not string.find(wep.Base, "custom_uh_base") then return end
        if not wep.Attachments then return end

        local frame = vgui.Create("DFrame")
        frame:SetSize(500, 450)
        frame:Center()
        frame:SetTitle("Customize — " .. (wep.PrintName or ""))
        frame:MakePopup()
        frame.OnClose = function() menuPanel = nil end
        menuPanel = frame

        local scroll = vgui.Create("DScrollPanel", frame)
        scroll:Dock(FILL)
        scroll:DockMargin(10, 30, 10, 10)

        for slot, sd in SortedPairs(wep.Attachments) do
            local lbl = vgui.Create("DLabel", scroll)
            lbl:Dock(TOP)
            lbl:DockMargin(0, 10, 0, 5)
            lbl:SetText("Slot " .. slot)
            lbl:SetFont("DermaDefaultBold")
            lbl:SizeToContents()

            local cur = sd.sel or 0
            local nb = vgui.Create("DButton", scroll)
            nb:Dock(TOP)
            nb:DockMargin(15, 0, 0, 2)
            nb:SetText("None")
            nb:SetTall(28)
            if cur == 0 then nb:SetDisabled(true) end
            nb.DoClick = function() wep:SetAttachment(slot, 0) end

            for i, attId in ipairs(sd.atts or {}) do
                local att = CustomUH.Attachments[attId]
                if att then
                    local btn = vgui.Create("DButton", scroll)
                    btn:Dock(TOP)
                    btn:DockMargin(15, 0, 0, 2)
                    btn:SetText(att.Name or attId)
                    btn:SetTall(28)
                    if cur == i then btn:SetDisabled(true) end
                    btn.DoClick = function() wep:SetAttachment(slot, i) end
                    if att.Description then
                        local desc = ""
                        for _, part in ipairs(att.Description) do
                            if isstring(part) then desc = desc .. part .. "\n" end
                        end
                        btn:SetTooltip(desc)
                    end
                end
            end
        end
    end)

    -- Key detection: toggle on key press, only for custom_uh weapons
    local keyPressed = false
    hook.Add("Think", "CustomUH_MenuKey", function()
        local key = GetConVar("customuh_menu_key"):GetString()
        local keyEnum = _G["KEY_" .. string.upper(key)]
        if not keyEnum then return end

        if input.IsKeyDown(keyEnum) then
            if not keyPressed then
                keyPressed = true
                RunConsoleCommand("customuh_menu")
            end
        else
            keyPressed = false
        end
    end)
end

-- ============================================================
-- INIT
-- ============================================================
hook.Add("Think", "CustomUH_RegisterAtts", function()
    if not CustomUH._registered then
        CustomUH._registered = true
        CustomUH.RegisterAttachments()
    end
end)

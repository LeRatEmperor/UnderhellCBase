-- cl_cuh_ui.lua
-- CustomUH Customization UI — Client-side menu
-- CUH BUILD: v0.5.4-camera-bone-diag (2026-10-02)
-- ============================================================
-- This file MUST only run on CLIENT. The autorun folder runs
-- shared by default, so we guard with CLIENT.
-- ============================================================

AddCSLuaFile()

if not CLIENT then return end

local menuPanel = nil

-- ============================================================
-- IsCUHWeapon — reliably detects weapons derived from weapon_cuh_base_gun
-- ============================================================
-- TFA weapons also define SetAttachment/GetEffectiveAttachment, so checking
-- for those methods is unreliable. Instead we walk the SWEP inheritance
-- chain (via SWEP.Base) looking for the "cuh_base" marker. We also accept
-- an explicit self.IsCUHWeapon marker for fast-path opt-in.
-- ============================================================
local function IsCUHWeapon(wep)
    if not IsValid(wep) then return false end
    -- Fast path: explicit opt-in marker on the instance/class
    if wep.IsCUHWeapon == true then return true end
    -- Walk the Base chain
    local cur = wep
    local seen = {}
    local depth = 0
    while cur and not seen[cur] and depth < 16 do
        seen[cur] = true
        depth = depth + 1
        if cur.Base and string.find(cur.Base, "cuh_base") then
            return true
        end
        if not cur.Base then break end
        cur = weapons.GetStored(cur.Base)
    end
    return false
end

-- Suppress the context menu while our menu is open
hook.Add("OnContextMenuOpen", "CUH2_SuppressContext", function()
    if IsValid(menuPanel) then return false end
end)

local function OpenMenu()
    local wep = LocalPlayer():GetActiveWeapon()
    if not IsValid(wep) then return end
    if not wep.Attachments then return end
    -- Only open for weapons that inherit from weapon_cuh_base_gun.
    -- The method-presence check (SetAttachment/GetEffectiveAttachment)
    -- used previously also matched TFA weapons, which define their own
    -- SetAttachment. Use the Base-chain walk instead.
    if not IsCUHWeapon(wep) then return end

    -- Toggle if already open
    if IsValid(menuPanel) then
        menuPanel:Remove()
        menuPanel = nil
        surface.PlaySound("ui/buttonclickrelease.wav")
        return
    end

    -- Menu open sound
    surface.PlaySound("ui/buttonclick.wav")

    local W, H = 640, 520
    local frame = vgui.Create("DFrame")
    frame:SetSize(W, H)
    frame:Center()
    frame:SetTitle("")
    frame:ShowCloseButton(false)
    frame:MakePopup()
    frame.Paint = function(self, w, h)
        draw.RoundedBox(6, 0, 0, w, h, CustomUH.Colors.Background)
        draw.RoundedBoxEx(6, 0, 0, w, 40, CustomUH.Colors.Panel, true, true, false, false)
        draw.SimpleText("Customize — " .. (wep.PrintName or ""), "DermaLarge", 15, 20, CustomUH.Colors.TextBright, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
    frame.OnMousePressed = function(self, key)
        if key == MOUSE_LEFT then
            local mx, my = self:CursorPos()
            if mx > W - 40 and my < 40 then
                self:Remove()
                menuPanel = nil
            end
        end
    end
    frame.OnRemove = function()
        menuPanel = nil
        -- Stop inspect loop
        hook.Remove("Think", "CUH2_InspectLoop")
        if IsValid(wep) then
            wep:SetNW2Bool("Inspecting", false)
        end
    end
    menuPanel = frame

    -- Play inspect animation in a loop while menu is open
    -- Only if the weapon has SWEP.CUHInspectOnMenu (default: false)
    -- and the weapon has an inspect animation
    if wep.CUHInspectOnMenu and wep.Animations and wep.Animations["inspect"] then
        wep:SetNW2Bool("Inspecting", true)
        wep:EasySendWeaponAnim("inspect", ACT_VM_FIDGET)

        -- Loop the inspect animation
        hook.Add("Think", "CUH2_InspectLoop", function()
            if not IsValid(menuPanel) or not IsValid(wep) then
                hook.Remove("Think", "CUH2_InspectLoop")
                return
            end
            -- Check if the weapon is still the active weapon
            if LocalPlayer():GetActiveWeapon() ~= wep then
                hook.Remove("Think", "CUH2_InspectLoop")
                return
            end
            -- Replay inspect when current animation finishes
            local vm = wep.Owner and wep.Owner:GetViewModel() or nil
            if IsValid(vm) and vm:GetCycle() >= 1 then
                wep:EasySendWeaponAnim("inspect", ACT_VM_FIDGET)
            end
        end)
    end

    -- Close button
    local closeBtn = vgui.Create("DButton", frame)
    closeBtn:SetSize(30, 30)
    closeBtn:SetPos(W - 35, 5)
    closeBtn:SetText("")
    closeBtn.Paint = function() end
    closeBtn.DoClick = function()
        surface.PlaySound("ui/buttonclickrelease.wav")
        frame:Remove()
        menuPanel = nil
    end

    -- Scroll panel
    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock(FILL)
    scroll:DockMargin(10, 45, 10, 10)

    for slot = 1, #wep.Attachments do
        local slotData = wep.Attachments[slot]
        if not slotData then continue end

        -- Slot header
        local header = vgui.Create("DPanel", scroll)
        header:Dock(TOP)
        header:DockMargin(0, 10, 0, 5)
        header:SetTall(25)
        header.Paint = function(self, w, h)
            draw.RoundedBox(4, 0, 0, w, h, CustomUH.Colors.AccentDim)
            -- Show slot name if defined, otherwise fall back to "Slot N"
            local headerText = slotData.name or ("Slot " .. slot)
            draw.SimpleText(headerText,
                "DermaDefaultBold", 10, h / 2, CustomUH.Colors.TextBright, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        -- Attachment button row
        local row = vgui.Create("DPanel", scroll)
        row:Dock(TOP)
        row:DockMargin(0, 0, 0, 5)
        row:SetTall(60)
        row.Paint = function() end

        -- Get effective attachment (respects defaults)
        local cur = wep.GetEffectiveAttachment and wep:GetEffectiveAttachment(slot) or (slotData.sel or 0)

        -- "None" button
        local noneBtn = vgui.Create("DButton", row)
        noneBtn:SetSize(50, 50)
        noneBtn:SetPos(5, 5)
        noneBtn:SetText("None")
        noneBtn:SetFont("DermaDefault")
        if slotData.forceDefault then
            noneBtn:SetDisabled(true)
            noneBtn:SetTooltip("This slot requires an attachment")
        end
        noneBtn.Paint = function(self, w, h)
            local bg = CustomUH.Colors.Panel
            local isDisabled = slotData.forceDefault == true
            if cur == 0 and not isDisabled then bg = CustomUH.Colors.Selected end
            if self:IsHovered() and not isDisabled then bg = CustomUH.Colors.Hover end
            draw.RoundedBox(4, 0, 0, w, h, bg)
            if cur == 0 and not isDisabled then
                surface.SetDrawColor(CustomUH.Colors.Accent.r, CustomUH.Colors.Accent.g, CustomUH.Colors.Accent.b, 255)
                surface.DrawOutlinedRect(0, 0, w, h, 2)
            end
            if isDisabled then
                draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
            end
        end
        noneBtn.DoClick = function()
            if slotData.forceDefault then return end
            surface.PlaySound("ui/buttonclickrelease.wav")
            wep:SetAttachment(slot, 0)
            cur = 0
        end

        local x = 60

        -- Attachment buttons
        for i, attId in ipairs(slotData.atts or {}) do
            local att = CustomUH.Attachments and CustomUH.Attachments[attId]
            if not att then continue end

            local btn = vgui.Create("DButton", row)
            btn:SetSize(50, 50)
            btn:SetPos(x, 5)
            btn:SetText("")
            btn.Paint = function(self, w, h)
                local bg = CustomUH.Colors.Panel
                if cur == i then bg = CustomUH.Colors.Selected end
                if self:IsHovered() then bg = CustomUH.Colors.Hover end
                draw.RoundedBox(4, 0, 0, w, h, bg)

                -- Draw icon
                if att.Icon then
                    local mat = Material(att.Icon, "smooth")
                    if mat and not mat:IsError() then
                        surface.SetMaterial(mat)
                        surface.SetDrawColor(255, 255, 255, 255)
                        surface.DrawTexturedRect(5, 5, w - 10, h - 15)
                    else
                        draw.SimpleText(att.ShortName or att.Name or "?", "DermaDefault",
                            w / 2, h / 2, CustomUH.Colors.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                else
                    draw.SimpleText(att.ShortName or att.Name or "?", "DermaDefault",
                        w / 2, h / 2, CustomUH.Colors.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end

                -- Selected outline
                if cur == i then
                    surface.SetDrawColor(CustomUH.Colors.Accent.r, CustomUH.Colors.Accent.g, CustomUH.Colors.Accent.b, 255)
                    surface.DrawOutlinedRect(0, 0, w, h, 2)
                end

                -- Default badge
                if slotData.default == i then
                    draw.SimpleText("D", "DermaDefault", w - 8, 4,
                        CustomUH.Colors.Accent, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
                end
            end

            -- Tooltip
            if att.Description then
                local desc = ""
                for _, part in ipairs(att.Description) do
                    if isstring(part) then desc = desc .. part .. "\n" end
                end
                btn:SetTooltip(desc)
            end

            -- Name label
            local nameLabel = vgui.Create("DLabel", row)
            nameLabel:SetPos(x, 55)
            nameLabel:SetSize(50, 15)
            nameLabel:SetFont("DermaDefault")
            nameLabel:SetTextColor(CustomUH.Colors.TextDim)
            local shortName = att.ShortName or att.Name or ""
            nameLabel:SetText(string.len(shortName) > 8 and string.sub(shortName, 1, 7) .. ".." or shortName)
            nameLabel:SetContentAlignment(5)

            btn.DoClick = function()
                print("[CUH-DBG] btn.DoClick CALLED  slot=" .. slot .. "  i=" .. i .. "  wep=" .. tostring(wep) .. "  IsValid=" .. tostring(IsValid(wep)))
                surface.PlaySound("ui/buttonclick.wav")
                if not IsValid(wep) then
                    print("[CUH-DBG]   ERROR: wep is not valid!")
                    return
                end
                if not wep.SetAttachment then
                    print("[CUH-DBG]   ERROR: wep.SetAttachment is nil!")
                    return
                end
                -- Check if SetAttachment is OURS or has been shadowed by
                -- another addon (e.g. TFA Base patches the weapon metatable)
                local ourSrc = debug.getinfo(wep.SetAttachment, "S")
                if ourSrc then
                    print("[CUH-DBG]   SetAttachment source: " .. tostring(ourSrc.short_src) .. ":" .. tostring(ourSrc.linedefined))
                    if not string.find(ourSrc.short_src or "", "weapon_cuh_base_gun", 1, true) then
                        print("[CUH-DBG]   WARNING: SetAttachment is NOT from weapon_cuh_base_gun.lua!")
                        print("[CUH-DBG]   Another addon (probably TFA Base) is shadowing it.")
                        print("[CUH-DBG]   Calling ApplyAttachments directly instead...")
                        -- Bypass the shadowed SetAttachment: set sel directly
                        -- and call ApplyAttachments
                        wep.Attachments[slot].sel = i
                        wep:ApplyAttachments()
                        -- Network to server
                        net.Start("CUH2_AttSelect")
                            net.WriteEntity(wep)
                            net.WriteUInt(slot, 8)
                            net.WriteUInt(i, 8)
                        net.SendToServer()
                        cur = i
                        return
                    end
                end
                print("[CUH-DBG]   calling wep:SetAttachment(" .. slot .. ", " .. i .. ") ...")
                wep:SetAttachment(slot, i)
                print("[CUH-DBG]   SetAttachment returned")
                cur = i
            end

            x = x + 60
        end
    end
end

-- ============================================================
-- KEY DETECTION
-- ============================================================
local keyPressed = false
hook.Add("Think", "CUH2_MenuKey", function()
    local keyStr = GetConVar("cuh_menu_key"):GetString()
    local keyEnum = _G["KEY_" .. string.upper(keyStr)]
    if not keyEnum then return end

    if input.IsKeyDown(keyEnum) then
        if not keyPressed then
            keyPressed = true
            OpenMenu()
        end
    else
        keyPressed = false
    end
end)

-- Console command fallback
concommand.Add("cuh_menu", function()
    OpenMenu()
end)

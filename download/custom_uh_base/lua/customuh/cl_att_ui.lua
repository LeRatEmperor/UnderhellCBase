AddCSLuaFile()
-- cl_att_ui.lua
-- CustomUH Customization UI — TFA-adjacent icon grid
-- ============================================================
-- Opens with C key (rebindable via customuh_menu_key convar).
-- Shows a panel with attachment slots, each with icon buttons.
-- Uses TFA icon assets temporarily (swappable later).
-- ============================================================

local menuPanel = nil
local KEY_BIND = "customuh_menu_key"

-- ============================================================
-- OPEN MENU
-- ============================================================
local function OpenMenu()
    local wep = LocalPlayer():GetActiveWeapon()
    if not IsValid(wep) then return end
    if not wep.Base or not string.find(wep.Base, "custom_uh_base") then return end
    if not wep.Attachments then return end

    -- Toggle if already open
    if IsValid(menuPanel) then
        menuPanel:Remove()
        menuPanel = nil
        return
    end

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
        draw.SimpleText("Customize — " .. (wep.PrintName or ""), "TFAInspectorHeaderFont", 15, 20, CustomUH.Colors.TextBright, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        -- Close button
        local cx, cy = w - 30, 20
        draw.SimpleText("X", "DermaDefault", cx, cy, CustomUH.Colors.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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
    menuPanel = frame

    -- Close button (actual clickable area)
    local closeBtn = vgui.Create("DButton", frame)
    closeBtn:SetSize(30, 30)
    closeBtn:SetPos(W - 35, 5)
    closeBtn:SetText("")
    closeBtn.Paint = function() end
    closeBtn.DoClick = function()
        frame:Remove()
        menuPanel = nil
    end

    -- Scroll panel for attachment slots
    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock(FILL)
    scroll:DockMargin(10, 45, 10, 10)

    local y = 0

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
            draw.SimpleText("Slot " .. slot .. (slotData.name and " — " .. slotData.name or ""), "DermaDefaultBold", 10, h / 2, CustomUH.Colors.TextBright, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        -- Attachment button row
        local row = vgui.Create("DPanel", scroll)
        row:Dock(TOP)
        row:DockMargin(0, 0, 0, 5)
        row:SetTall(60)
        row.Paint = function() end

        -- "None" button (disabled if forceDefault is on)
        local cur = wep:GetEffectiveAttachment(slot) or 0
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
            if cur == 0 and not slotData.forceDefault then bg = CustomUH.Colors.Selected end
            if self:IsHovered() and not self:IsDisabled() then bg = CustomUH.Colors.Hover end
            draw.RoundedBox(4, 0, 0, w, h, bg)
            if cur == 0 and not slotData.forceDefault then
                surface.SetDrawColor(CustomUH.Colors.Accent.r, CustomUH.Colors.Accent.g, CustomUH.Colors.Accent.b, 255)
                surface.DrawOutlinedRect(0, 0, w, h, 2)
            end
            -- Dim if forceDefault
            if slotData.forceDefault then
                draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
            end
        end
        noneBtn.DoClick = function()
            if slotData.forceDefault then return end
            wep:SetAttachment(slot, 0)
            cur = 0
        end

        local x = 60

        -- Attachment buttons
        for i, attId in ipairs(slotData.atts or {}) do
            local att = CustomUH.Attachments[attId]
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
                        -- Fallback: draw name text
                        draw.SimpleText(att.ShortName or att.Name or "?", "DermaDefaultSmall", w / 2, h / 2, CustomUH.Colors.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    end
                else
                    draw.SimpleText(att.ShortName or att.Name or "?", "DermaDefaultSmall", w / 2, h / 2, CustomUH.Colors.Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end

                -- Selected outline
                if cur == i then
                    surface.SetDrawColor(CustomUH.Colors.Accent.r, CustomUH.Colors.Accent.g, CustomUH.Colors.Accent.b, 255)
                    surface.DrawOutlinedRect(0, 0, w, h, 2)
                end

                -- Default badge (small "D" in corner)
                if slotData.default == i then
                    draw.SimpleText("D", "DermaDefaultSmall", w - 8, 4, CustomUH.Colors.Accent, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
                end
            end

            -- Tooltip with description
            if att.Description then
                local desc = ""
                for _, part in ipairs(att.Description) do
                    if isstring(part) then
                        desc = desc .. part .. "\n"
                    end
                end
                btn:SetTooltip(desc)
            end

            -- Attachment name label below icon
            local nameLabel = vgui.Create("DLabel", row)
            nameLabel:SetPos(x, 55)
            nameLabel:SetSize(50, 15)
            nameLabel:SetFont("DermaDefaultSmall")
            nameLabel:SetTextColor(CustomUH.Colors.TextDim)
            nameLabel:SetText(string.len(att.ShortName or att.Name or "") > 8 and string.sub(att.ShortName or att.Name or "", 1, 7) .. ".." or (att.ShortName or att.Name or ""))
            nameLabel:SetContentAlignment(5)

            btn.DoClick = function()
                wep:SetAttachment(slot, i)
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
    local keyStr = GetConVar(KEY_BIND):GetString()
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
concommand.Add("customuh_menu", function()
    OpenMenu()
end)

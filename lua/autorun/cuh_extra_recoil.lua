-- cuh_extra_recoil.lua
-- CUH Extra Recoil System — ported from tfa_extra_recoil.lua
-- CUH BUILD: v0.6.1-extra-recoil (2026-10-02)
-- ============================================================
-- Ported from the TFA Extra Recoil addon to the CUH base.
-- Changes from the original:
--   1. ConVars renamed from sv_tfa_recoil_extra_* to sv_cuh_recoil_extra_*
--      so they don't conflict with the original TFA addon if both are
--      installed.
--   2. Weapon filter changed from weapon.IsTFAWeapon to weapon.IsCUHWeapon.
--      This means the extra recoil ONLY applies to CUH-base weapons,
--      NOT to TFA weapons. If the original TFA addon is also installed,
--      it will handle TFA weapons independently with its own ConVars.
--   3. Removed the cross-dependency on sv_tfa_recoil_legacy ConVar
--      (TFA-specific, doesn't exist in CUH base).
--   4. Hook IDs renamed from TFA_* to CUH_* to avoid hook collisions.
--   5. The timer ID renamed from ExtraRecoilFireDetectionLoop to
--      CUH_ExtraRecoilFireDetectionLoop.
--
-- This file is fully independent of TFA Base. It will NOT conflict
-- with the original tfa_extra_recoil.lua addon if both are installed.
-- ============================================================

CreateConVar("sv_cuh_recoil_extra_enabled", "1", FCVAR_REPLICATED,
    "Enable/disable CUH extra recoil system", 0, 1)
CreateConVar("sv_cuh_recoil_extra_mult", "2", FCVAR_REPLICATED,
    "Multiplier for CUH recoil strength", 0.001, 1000)
CreateConVar("sv_cuh_recoil_extra_screenshake_enabled", "1", FCVAR_REPLICATED,
    "Enable/disable CUH screenshake effects", 0, 1)
CreateConVar("sv_cuh_recoil_extra_screenshake_strength_multiplier", "0.5", FCVAR_REPLICATED,
    "Multiplier for CUH screenshake strength", 0.001, 1000)
CreateConVar("sv_cuh_recoil_extra_screenshake_speed_multiplier", "1", FCVAR_REPLICATED,
    "Multiplier for CUH screenshake speed", 0.001, 1000)

-- NOTE: No sv_tfa_recoil_legacy cross-dependency.
-- The original addon forced sv_tfa_recoil_legacy = 1 when its own
-- ConVar was enabled, because TFA Base needed legacy recoil mode.
-- CUH Base doesn't have a legacy recoil mode, so this is unnecessary.

local lastExtraRecoilTime = 0

if CLIENT then
    local lastMagCapacity = 0
    local lastWeapon = nil

    local cuh_extra_screenshake_enabled = GetConVar("sv_cuh_recoil_extra_screenshake_enabled")
    local cuh_extra_screenshake_strength_multiplier = GetConVar("sv_cuh_recoil_extra_screenshake_strength_multiplier")
    local cuh_extra_screenshake_speed_multiplier = GetConVar("sv_cuh_recoil_extra_screenshake_speed_multiplier")
    local ExtraScreenShakeTime = 0
    local ExtraScreenShakeDuration = 0
    local ExtraScreenShakeStrength = 0
    local ExtraScreenShakeViewOffset = Angle(0, 0, 0)

    local function ApplyExtraRecoil(weapon)
        -- Changed: weapon.IsTFAWeapon → weapon.IsCUHWeapon
        -- This ensures the extra recoil ONLY applies to CUH-base weapons,
        -- NOT to TFA weapons. If the original TFA addon is installed,
        -- it will handle TFA weapons with its own system + ConVars.
        if not IsValid(weapon) or not weapon.IsCUHWeapon then return end

        local currentTime = CurTime()
        if currentTime - lastExtraRecoilTime < 0.05 then
            return
        end
        lastExtraRecoilTime = currentTime

        local kickUp = weapon.Primary.KickUp or 0
        local kickDown = weapon.Primary.KickDown or 0
        local kickHorizontal = weapon.Primary.KickHorizontal or 0
        local staticRecoilFactor = weapon.Primary.StaticRecoilFactor or 0
        local extraRecoilAmount = (kickUp + kickDown + kickHorizontal + staticRecoilFactor) * 2

        local ply = LocalPlayer()
        if IsValid(ply) then
            -- Changed: weapon.IronSightsProgressUnpredicted / weapon:GetIronSightsProgress()
            -- to weapon:GetUHBool("Zooming") since CUH uses UH bools for ironsight state.
            -- We approximate ironsight progress as 1 when zooming, 0 when not.
            local ironSightsProgress = (weapon.GetUHBool and weapon:GetUHBool("Zooming")) and 1 or 0

            if ironSightsProgress > 0.5 then
                if ply:Crouching() then
                    extraRecoilAmount = (extraRecoilAmount * 0.333) * GetConVar("sv_cuh_recoil_extra_mult"):GetFloat()
                else
                    extraRecoilAmount = (extraRecoilAmount * 0.5) * GetConVar("sv_cuh_recoil_extra_mult"):GetFloat()
                end
            elseif ply:Crouching() then
                extraRecoilAmount = (extraRecoilAmount * 0.75) * GetConVar("sv_cuh_recoil_extra_mult"):GetFloat()
            else
                -- Standing and not using iron sights - apply base multiplier
                extraRecoilAmount = extraRecoilAmount * GetConVar("sv_cuh_recoil_extra_mult"):GetFloat()
            end
        end

        local rpm = weapon.Primary.RPM or 600
        -- Fallback: if the weapon uses Primary.Delay instead of RPM, compute RPM from delay
        if not weapon.Primary.RPM and weapon.Primary.Delay then
            rpm = 60 / weapon.Primary.Delay
        end
        local rpmDuration = math.min((60 / rpm + 0.06), 0.25)

        weapon.ExtraRecoilStartTime = CurTime()
        weapon.ExtraRecoilDuration = rpmDuration
        weapon.ExtraRecoilAmount = extraRecoilAmount
        weapon.ExtraRecoilStartPitch = LocalPlayer():EyeAngles().pitch

        if cuh_extra_screenshake_enabled:GetBool() then
            local RPMDuration = math.min((60 / rpm) + 0.1, 0.2)

            ExtraScreenShakeDuration = RPMDuration * cuh_extra_screenshake_speed_multiplier:GetFloat()
            ExtraScreenShakeStrength = (extraRecoilAmount / 2) * cuh_extra_screenshake_strength_multiplier:GetFloat()

            ExtraScreenShakeTime = ExtraScreenShakeDuration
            ExtraScreenShakeViewOffset = Angle(0, 0, 0)
        end
    end

    local function DetectExtraRecoilFiring()
        if not GetConVar("sv_cuh_recoil_extra_enabled"):GetBool() then return end

        local ply = LocalPlayer()
        if not IsValid(ply) then return end

        local weapon = ply:GetActiveWeapon()
        -- Changed: weapon.IsTFAWeapon → weapon.IsCUHWeapon
        if not IsValid(weapon) or not weapon.IsCUHWeapon then
            lastMagCapacity = 0
            lastWeapon = nil
            return
        end

        if weapon.ExtraRecoilStartTime and weapon.ExtraRecoilDuration and weapon.ExtraRecoilAmount then
            local timeSinceStart = CurTime() - weapon.ExtraRecoilStartTime

            -- Skip first frame (0.001 seconds) to start recoil from second frame
            if timeSinceStart > 0.01 and timeSinceStart < weapon.ExtraRecoilDuration then
                local movementRate = weapon.ExtraRecoilAmount / weapon.ExtraRecoilDuration
                local frameTime = 0.01
                local frameMovement = movementRate * frameTime

                local currentAngles = ply:EyeAngles()
                currentAngles.pitch = currentAngles.pitch - frameMovement
                ply:SetEyeAngles(currentAngles)
            elseif timeSinceStart >= weapon.ExtraRecoilDuration then
                weapon.ExtraRecoilStartTime = nil
                weapon.ExtraRecoilDuration = nil
                weapon.ExtraRecoilAmount = nil
                weapon.ExtraRecoilStartPitch = nil
            end
        end

        local currentMagCapacity = weapon:Clip1() or 0

        if weapon != lastWeapon then
            lastMagCapacity = currentMagCapacity
            lastWeapon = weapon
            return
        end

        if currentMagCapacity < lastMagCapacity then
            ApplyExtraRecoil(weapon)
            lastMagCapacity = currentMagCapacity
        else
            lastMagCapacity = currentMagCapacity
        end

        if ExtraScreenShakeTime > 0 then
            ExtraScreenShakeTime = math.max(0, ExtraScreenShakeTime - FrameTime())

            local timeProgress = ExtraScreenShakeTime / ExtraScreenShakeDuration
            local rollAngle = math.sin(timeProgress * math.pi * 4) * ExtraScreenShakeStrength * timeProgress

            ExtraScreenShakeViewOffset = Angle(0, 0, rollAngle)
        else
            ExtraScreenShakeViewOffset = Angle(0, 0, 0)
        end
    end

    -- Changed: hook ID from TFA_ExtraScreenShake_View to CUH_ExtraScreenShake_View
    -- to avoid collision with the original TFA addon's hook.
    hook.Add("CalcView", "CUH_ExtraScreenShake_View", function(ply, origin, angles, fov, znear, zfar)
        if ExtraScreenShakeViewOffset.roll ~= 0 then
            angles:Add(ExtraScreenShakeViewOffset)
        end
    end)

    -- Changed: timer ID from ExtraRecoilFireDetectionLoop to CUH_ExtraRecoilFireDetectionLoop
    timer.Create("CUH_ExtraRecoilFireDetectionLoop", 0.001, 0, DetectExtraRecoilFiring)
end

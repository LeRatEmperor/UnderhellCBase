AddCSLuaFile()
CreateConVar("uh_sv_deploy", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether to use a first-time deploy animation")
CreateConVar("uh_sv_heavyweapons", "0", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether to drop heavy weapons when holstered")
CreateConVar("uh_sv_penetration", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether to shoot through objects")
CreateConVar("uh_sv_ammo", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Spawn with 5 magazines of ammo")
CreateConVar("uh_sv_running", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether running should make you unable to shoot")
CreateConVar("uh_sv_realpump", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether to use realistic pumping when reloading shotguns")
CreateConVar("uh_sv_grenades", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether to enable grenade-throwing")
CreateConVar("uh_sv_flashlight", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether to use a custom flashlight or default")
CreateConVar("uh_sv_batteries", "0", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether the flashlight should use batteries")
CreateConVar("uh_sv_flare", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether to enable flares")
CreateConVar("uh_sv_gasmask", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether to enable gasmask")
CreateConVar("uh_sv_nightvision", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether to enable nightvision")
CreateConVar("uh_sv_voices", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether to use voices when doing specific actions")
CreateConVar("uh_sv_kick", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether kicking should be enabled")
CreateConVar("uh_sv_kick_unlockdoors", "0", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Whether kicking should open locked doors")

game.AddAmmoType({ -- Arrow
	name = "UH_Arrow",
	dmgtype = DMG_BULLET,
	force = 2000
})
game.AddAmmoType({ -- MGL Grenade
	name = "UH_MGL",
	dmgtype = DMG_BLAST
})
game.AddAmmoType({ -- RPG Rocket
	name = "UH_Rocket",
	dmgtype = DMG_BLAST
})
game.AddAmmoType({ -- Grenade
	name = "UH_Grenade",
	dmgtype = DMG_BLAST
})


-- Flare
sound.Add({
	name = "UH.Flare.Burn",
	channel = CHAN_USER_BASE,
	volume = 0.3,
	level = 80,
	pitch = 100,
	sound = "weapons/flaregun/burn.wav"
})
-- Battery
sound.Add({
	name = "UH.Battery",
	channel = CHAN_USER_BASE,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = "uh/pickup/battery.wav"
})
-- Armor
sound.Add({
	name = "UH.Armor",
	channel = CHAN_USER_BASE,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = "uh/pickup/armor.wav"
})
-- Bandage
sound.Add({
	name = "UH.Bandage",
	channel = CHAN_USER_BASE,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = "uh/pickup/bandage.wav"
})
-- Medspray
sound.Add({
	name = "UH.Medspray",
	channel = CHAN_USER_BASE,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = "uh/pickup/medspray.wav"
})
-- Medkit
sound.Add({
	name = "UH.Medkit",
	channel = CHAN_USER_BASE,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = "uh/pickup/medkit.wav"
})


-- Ammo
sound.Add({
	name = "UH.Ammo.Pistol",
	channel = CHAN_USER_BASE,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = "uh/pickup/pistol.wav"
})
sound.Add({
	name = "UH.Ammo.Revolver",
	channel = CHAN_USER_BASE,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = "uh/pickup/revolver.wav"
})
sound.Add({
	name = "UH.Ammo.SMG",
	channel = CHAN_USER_BASE,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = "uh/pickup/smg.wav"
})
sound.Add({
	name = "UH.Ammo.Shotgun",
	channel = CHAN_USER_BASE,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = "uh/pickup/shotgun.wav"
})
sound.Add({
	name = "UH.Ammo.Rifle",
	channel = CHAN_USER_BASE,
	volume = 1,
	level = 75,
	pitch = 100,
	sound = "uh/pickup/rifle.wav"
})


local ent = FindMetaTable("Entity")
function ent:SetUHBool(name, bool)
	self:SetNWBool("UH_"..name, bool)
	if !game.SinglePlayer() and CLIENT then
		self.pd_data = self.pd_data or {}
		self.pd_data[name] = bool
	end
end

function ent:GetUHBool(name, def)
	if game.SinglePlayer() or SERVER then return self:GetNWBool("UH_"..name, def) end
	local data = self.pd_data or {}
	return data[name] or def
end


UHFlareTranslate = {}
UHFlareTranslate[ ACT_MP_STAND_IDLE ] 					= ACT_HL2MP_IDLE_DUEL
UHFlareTranslate[ ACT_MP_WALK ] 						= ACT_HL2MP_WALK_DUEL
UHFlareTranslate[ ACT_MP_RUN ] 							= ACT_HL2MP_RUN_DUEL
UHFlareTranslate[ ACT_MP_CROUCH_IDLE ] 					= ACT_HL2MP_IDLE_CROUCH_DUEL
UHFlareTranslate[ ACT_MP_CROUCHWALK ] 					= ACT_HL2MP_WALK_CROUCH_DUEL
UHFlareTranslate[ ACT_MP_JUMP ] 						= ACT_HL2MP_JUMP_DUEL

hook.Add("TranslateActivity", "UHTranslateActivity", function(ply, act)
	if ply:GetNWBool("UH_Flare") and UHFlareTranslate[ act ] then
		return UHFlareTranslate[ act ]
	end
end)

if SERVER then
	util.AddNetworkString("UH_Grenade")
	util.AddNetworkString("UH_Flashlight")
	util.AddNetworkString("UH_Flare")
	util.AddNetworkString("UH_Silencer")
	util.AddNetworkString("UH_Gasmask")
	util.AddNetworkString("UH_Nightvision")
	util.AddNetworkString("UH_Kick")
	util.AddNetworkString("UH_Select_Fire")
	util.AddNetworkString("UH_Deploy")
	
	local gasenums = {
		[DMG_POISON] = true,
		[DMG_NERVEGAS] = true,
		[DMG_RADIATION] = true,
		[DMG_ACID] = true,
		[DMG_PARALYZE] = true
	}
	
	local gasentities = {
		["cup_smoke"] = true,
	}
	
	function UHThrowFlare( ply, delay )
		timer.Simple(0.4, function()
			if !IsValid(ply) then return end
			local flare = ents.Create("sent_uh_flare")
			flare:SetPos(ply:EyePos() + ply:GetAimVector()*32)
			flare:SetAngles(ply:EyeAngles())
			flare:Spawn()
			flare:Throw(ply)
			
			undo.Create( "Flare" )
				undo.AddEntity( flare )
				undo.SetPlayer( ply )
			undo.Finish()
			
			ply:SetNWFloat("UH_FlareTime", 0)
			ply:StopSound("UH.Flare.Burn")
		end)
		ply:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_GMOD_GESTURE_ITEM_THROW, true )
		
		ply:SetNWBool("UH_Flare", false)
		
		net.Start("UH_Flare")
			net.WriteEntity(ply)
			net.WriteBool(false)
		net.Broadcast()
	end
	
	function UHKickHit(ply)
		local pos = ply:GetShootPos()
		local ang = ply:EyeAngles()
		ang.p = math.Clamp(ang.p, 0, 90) -- Why would you kick the roof anyway?
		local aim = ang:Forward()
		
		local tr = {}
		tr.start = pos
		tr.endpos = pos + aim*85
		tr.filter = ply
		tr.mask = MASK_SHOT_HULL
		
		local trace = util.TraceLine( tr )
		local ent = trace.Entity
		
		local vel = ply:GetVelocity()
		local speed = vel:Length()
		local dot = (aim:Dot(vel:GetNormalized()) + 1)/2 -- Apply no extra force if we're back-pedalling
		local damage = math.Round(32 + math.Clamp(speed / ply:GetRunSpeed(), 0, 1) * 68 * dot) -- Apply our forward-velocity as damage
		
		ply:ViewPunch( Angle( -10, math.random( -5, 5 ), 0 ) )
		
		if IsValid(ent) then
			if ent:IsPlayer() or ent:IsNPC() or type(ent) == "NextBot" then
				ent:EmitSound("uh/kick/foot_kickbody.wav", 100, math.random(80, 110))
				local dmginfo = DamageInfo()
				dmginfo:SetAttacker(ply)
				dmginfo:SetInflictor(ply)
				dmginfo:SetDamage(damage)
				dmginfo:SetDamageForce( aim * 100 )
				dmginfo:SetDamagePosition(trace.HitPos)
				dmginfo:SetDamageType(DMG_CRUSH)
				ent:TakeDamageInfo(dmginfo)
			elseif ent:GetClass() == "func_door_rotating" or ent:GetClass() == "prop_door_rotating" then
				ply:EmitSound("ambient/materials/door_hit1.wav", 100, math.random(80, 120))
				
				local fx = EffectData()
				fx:SetOrigin(trace.HitPos)
				fx:SetNormal(trace.HitNormal)
				util.Effect("uh_kick", fx)
				
				local stbl = ent:GetSaveTable()
				
				local state = stbl.m_toggle_state or stbl.m_eDoorState -- func_door uses toggle, prop_door uses DoorState
				
				if GetConVar("uh_sv_kick_unlockdoors"):GetBool() then
					ent:Fire( "unlock", "", .01 )
				end
				
				ent:SetKeyValue( "Speed", "500" )
				ent:SetKeyValue( "Open Direction", "Both directions" )
				
				local pos = ent:LocalToWorld(ent:OBBCenter())
				local dot = aim:Dot( ent:GetForward() )
				local dir = dot > 0 and 1 or -1
				
				if state != 0 then -- Door is open...
					local bang = stbl.m_angRotationOpenBack or Angle(0, 0, 0)
					local fang = stbl.m_angRotationOpenForward or Angle(0, 0, 0)
					local cang = ent:GetAngles()
					
					if (math.Round(cang.y) == math.Round(bang.y) and dot > 0) or (math.Round(cang.y) == math.Round(fang.y) and dot < 0) then
						ent:Fire( "Close", "", 0 )
						
						for k,npc in pairs(ents.FindInSphere(pos + ent:GetForward()*32*dir, 72)) do
							if npc:IsNPC() or type(npc) == "NextBot" or ( npc:IsPlayer() and npc != ply ) then
								local dmginfo = DamageInfo()
								dmginfo:SetAttacker(ply)
								dmginfo:SetInflictor(ent)
								dmginfo:SetDamage(100)
								dmginfo:SetDamageForce( aim * 1000 )
								dmginfo:SetDamagePosition(pos)
								dmginfo:SetDamageType(DMG_CRUSH)
								npc:TakeDamageInfo(dmginfo)
							end
						end
					end
				else -- Door is closed!
					ply.oldname = ply:GetName()
					
					ply:SetName( "kickingply"..ply:EntIndex() )
					
					ent:Fire( "openawayfrom", "kickingply"..ply:EntIndex(), .01 )
					
					for k,npc in pairs(ents.FindInSphere(pos + ent:GetForward()*32*dir, 72)) do
						if npc:IsNPC() or type(npc) == "NextBot" or ( npc:IsPlayer() and npc != ply ) then
							local dmginfo = DamageInfo()
							dmginfo:SetAttacker(ply)
							dmginfo:SetInflictor(ent)
							dmginfo:SetDamage(100)
							dmginfo:SetDamageForce( aim * 1000 )
							dmginfo:SetDamagePosition(pos)
							dmginfo:SetDamageType(DMG_CRUSH)
							npc:TakeDamageInfo(dmginfo)
						end
					end
					
					timer.Simple(0.02, function()
						if IsValid(ply) then
							ply:SetName(ply.oldname)
						end
					end)
				end
				
				timer.Simple(0.3, function()
					if IsValid(ent) then
						ent:SetKeyValue( "Speed", "100" )
					end
				end)
			else
				ent:EmitSound("uh/kick/foot_kickwall.wav", 100, math.random(80, 110))
				local dmginfo = DamageInfo()
				dmginfo:SetAttacker(ply)
				dmginfo:SetInflictor(ply)
				dmginfo:SetDamage(damage)
				dmginfo:SetDamageForce( aim * 1000 )
				dmginfo:SetDamagePosition(trace.HitPos)
				dmginfo:SetDamageType(DMG_CRUSH)
				ent:TakeDamageInfo(dmginfo)
				local phys = ent:GetPhysicsObject()
				if IsValid(phys) then
					phys:Wake()
					phys:ApplyForceOffset(aim * 300, trace.HitPos)
				end
			end
		elseif trace.HitWorld then
			ply:EmitSound("uh/kick/foot_kickwall.wav", 100, math.random(70, 140))
			util.Decal("Impact.Sand", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal)
			local fx 	= EffectData()
			fx:SetOrigin(trace.HitPos)
			fx:SetNormal(trace.HitNormal)
			util.Effect("uh_kick", fx)
		else
			ply:EmitSound("uh/kick/foot_fire.wav", 100, math.random(70, 140))
		end
	end
	
	hook.Add("Think", "UHWeaponThink", function()
		local ct = CurTime()
		
		for k,ply in pairs(player.GetAll()) do
			if GetConVar("uh_sv_batteries"):GetBool() and (ply:GetNWBool("UH_Flashlight") or ply:GetNWBool("UH_Nightvision")) then
				if ply:GetNWFloat("UH_Battery") > 0 and (ply.f_lastbattery or 0) < ct then
					ply.f_lastbattery = ct + 1
					
					local amount = (ply:GetNWBool("UH_Nightvision") and 0.02 or 0) + (ply:GetNWBool("UH_Flashlight") and 0.01 or 0)
					
					ply:SetNWFloat("UH_Battery", math.max(ply:GetNWFloat("UH_Battery") - amount, 0))
				elseif ply:GetNWFloat("UH_Battery") <= 0 then
					ply:SetNWBool("UH_ArmGone", false)
					ply:SetNWBool("UH_Flashlight", false)
					ply:SetNWBool("UH_Nightvision", false)
					net.Start("UH_Flashlight")
						net.WriteEntity(ply)
						net.WriteBool(false)
					net.Broadcast()
				end
			end
			
			if (ply:GetNWBool("UH_Flashlight") or ply:GetNWBool("UH_Flare")) and ply:Alive() then
				local wep = ply:GetActiveWeapon()
				if ply:GetNWBool("UH_Flare") and ply:GetNWFloat("UH_FlareTime") < ct then
					ply:SetNWBool("UH_Flare", false)
					ply:SetNWBool("UH_ArmGone", false)
					ply:SetNWFloat("UH_ArmTime", ct + 0.6)
					ply:SetNWFloat("UH_FlareTime", 0)
					ply:StopSound("UH.Flare.Burn")
					net.Start("UH_Flare")
						net.WriteEntity(ply)
						net.WriteBool(false)
					net.Broadcast()
				end
				
				if IsValid(wep) and string.find(wep.Base or "", "weapon_uh_base") then
					if ply:GetNWFloat("UH_GrenadeTime") > ct then return end
					
					if ply:GetNWBool("UH_Flashlight") then
						if !wep.IsBolt and !wep.IsPump and !wep.TwoHanded and GetConVar("uh_sv_flashlight"):GetBool() then
							ply:SetNWBool("UH_ArmGone", true)
						else
							ply:SetNWBool("UH_ArmGone", false)
						end
					end
					if ply:GetNWBool("UH_Flare") and (wep.IsBolt or wep.IsPump or wep.TwoHanded) then
						UHThrowFlare( ply )
						ply:SetNWBool("UH_ArmGone", false)
						ply:SetNWFloat("UH_ArmTime", ct + 0.6)
					end
				elseif !IsValid(wep) or !string.find(wep.Base or "", "weapon_uh_base") then
					ply:SetNWBool("UH_ArmGone", false)
					if ply:GetNWBool("UH_Flashlight") then
						ply:SetNWBool("UH_Flashlight", false)
						net.Start("UH_Flashlight")
							net.WriteEntity(ply)
							net.WriteBool(false)
						net.Broadcast()
					end
					if ply:GetNWBool("UH_Flare") then
						UHThrowFlare( ply )
					end
				end
			end
		end
	end)
	
	hook.Add("EntityTakeDamage", "UHGasDamage", function(ply, dmginfo)
		if ply:IsPlayer() and ply:GetNWBool("UH_Gasmask") then
			local dtype = dmginfo:GetDamageType()
			local attacker = IsValid(dmginfo:GetAttacker()) and dmginfo:GetAttacker():GetClass() or "nil"
			local inflictor = IsValid(dmginfo:GetInflictor()) and dmginfo:GetInflictor():GetClass() or "nil"
			if gasenums[dtype] or gasentities[attacker] or gasentities[inflictor] then
				dmginfo:ScaleDamage(0) -- Just in case
				dmginfo:SetDamage(0)
				ply.b_uh_gassed = true
			else
				ply.b_uh_gassed = nil
			end
		elseif ply.b_uh_gassed then
			ply.b_uh_gassed = nil
		end
	end)
	
	hook.Add("PlayerShouldTakeDamage", "UHShouldTakeDamage", function(ply,ent)
		if ply.b_uh_gassed then
			return false
		end
	end)
	
	hook.Add("PlayerSwitchFlashlight", "UHFlashlight", function(ply, status)
		if !ply:Alive() then return end
		local wep = ply:GetActiveWeapon()
		if IsValid(wep) and string.find(wep.Base or "", "weapon_uh_base") and GetConVar("uh_sv_flashlight"):GetBool() then
			if (!GetConVar("uh_sv_batteries"):GetBool() or ply:GetNWFloat("UH_Battery") > 0) then
				if (ply.b_nextflashlight or 0) < CurTime() and !wep:GetUHBool("Reloading") then
					local bool = !ply:GetNWBool("UH_Flashlight")
					ply.b_nextflashlight = CurTime() + 0.6
					wep:SetUHBool("Zooming", false)
					wep.NextReload = CurTime() + 0.25
					
					ply:SetNWBool("UH_Flashlight", bool)
					if !wep.IsBolt and !wep.IsPump and !wep.TwoHanded then
						ply:SetNWBool("UH_ArmGone", bool)
						ply:SetNWFloat("UH_ArmTime", CurTime() + 0.25)
					end
					if bool then
						if ply:GetNWBool("UH_Flare") then
							UHThrowFlare( ply )
							
							ply.b_nextflashlight = CurTime() + 1.1
							
							timer.Simple(1, function()
								if !IsValid(ply) then return end
								ply:EmitSound("uh/flashlight.wav")
							end)
						else
							timer.Simple(0.45, function()
								if !IsValid(ply) then return end
								ply:EmitSound("uh/flashlight.wav")
							end)
						end
					else
						ply:EmitSound("uh/flashlight.wav")
					end
					
					net.Start("UH_Flashlight")
						net.WriteEntity(ply)
						net.WriteBool(bool)
					net.Broadcast()
				elseif wep:GetUHBool("Reloading") then
					wep.b_reflashlight = !wep.b_reflashlight
				end
			end
			if ply:FlashlightIsOn() then
				return true
			end
			return false
		elseif ply:GetNWBool("UH_Flashlight") then
			ply:SetNWBool("UH_Flashlight", false)
			ply:SetNWBool("UH_ArmGone", false)
			ply:SetNWFloat("UH_ArmTime", CurTime() + 0.25)
			ply:EmitSound("uh/flashlight.wav")
			
			net.Start("UH_Flashlight")
				net.WriteEntity(ply)
				net.WriteBool(false)
			net.Broadcast()
		end
	end)
	
	hook.Add("PlayerButtonDown", "UHButtonDown", function(ply, key)
		if !ply:Alive() or ply:InVehicle() then return end
		local ct = CurTime()
		local wep = ply:GetActiveWeapon()
		local mask = ply:GetInfoNum("uh_key_gasmask", 0)
		local nvg = ply:GetInfoNum("uh_key_nightvision", 0)
		local gren = ply:GetInfoNum("uh_key_grenade", 0)
		local sil = ply:GetInfoNum("uh_key_silencer", 0)
		local kick = ply:GetInfoNum("uh_key_kick", 0)
		
		-- Kick
		if key == kick and GetConVar("uh_sv_kick"):GetBool() then
			if ply:GetNWFloat("UH_KickTime") < ct then
				ply:SetNWFloat("UH_KickTime", ct + 0.7)
				
				net.Start("UH_Kick")
				net.Send(ply)
				
				if GetConVar("uh_sv_voices"):GetBool() then
					ply:EmitSound("uh/voice/kick/kick"..math.random(1,8)..".wav", 100, math.random(80, 110))
				end
				
				timer.Simple(0.2, function()
					UHKickHit(ply)
				end)
			end
		end
		
		-- Gasmask
		if key == mask and GetConVar("uh_sv_gasmask"):GetBool() then
			if ply:GetNWFloat("UH_MaskTime") < ct then
				local bool = !ply:GetNWBool("UH_Gasmask")
				ply:SetNWFloat("UH_MaskTime", ct + 0.6)
				ply:EmitSound("uh/gasmask.wav")
				ply:SetNWBool("UH_Gasmask", bool)
				ply:SetNWBool("UH_Nightvision", false)
			end
		end
		
		-- Nightvision
		if key == nvg and GetConVar("uh_sv_nightvision"):GetBool() and (!GetConVar("uh_sv_batteries"):GetBool() or ply:GetNWFloat("UH_Battery") > 0) then
			if ply:GetNWFloat("UH_MaskTime") < ct then
				local bool = !ply:GetNWBool("UH_Nightvision")
				ply:SetNWFloat("UH_MaskTime", ct + 0.6)
				if bool then
					ply:EmitSound("uh/nvg_on.wav")
				else
					ply:EmitSound("uh/nvg_off.wav")
				end
				ply:SetNWBool("UH_Nightvision", bool)
				ply:SetNWBool("UH_Gasmask", false)
			end
		end
		
		-- Grenade
		if key == gren and GetConVar("uh_sv_grenades"):GetBool() then
			if ply:GetNWFloat("UH_GrenadeTime") < ct then
				if ply:GetNWBool("UH_Flare") then
					UHThrowFlare( ply )
					
					ply:SetNWFloat("UH_GrenadeTime", ct + 1.25)
					ply.b_nextflashlight = ct + 0.8
					
					ply:SetNWBool("UH_ArmGone", false)
					ply:SetNWFloat("UH_ArmTime", ct + 0.6)
					return
				end
				
				if !IsValid(wep) or !string.find(wep.Base or "", "weapon_uh_base") then return end
				if wep:GetUHBool("Reloading") or wep:GetNWFloat("DeployTime") > ct then return end
				if ply:GetAmmoCount( "UH_Grenade" ) <= 0 then return end
				ply:RemoveAmmo( 1, "UH_Grenade" )
				
				net.Start("UH_Grenade")
				net.Send(ply)
				
				wep:SetNextPrimaryFire( ct + 1 )
				wep:SetNextSecondaryFire( ct + 1 )
				wep:SetUHBool("Zooming", false)
				ply:SetNWFloat("UH_GrenadeTime", ct + 1.25)
				ply:SetNWFloat("UH_ArmTime", ct + 1)
				
				ply:RestartGesture( ACT_GMOD_GESTURE_ITEM_THROW )
				
				timer.Create("UH_Gren_"..ply:SteamID(), 0.35, 1, function()
					if !IsValid(ply) then return end
					
					local tr = {}
					tr.start = ply:EyePos()
					tr.endpos = ply:EyePos() + ply:GetAimVector() * 32
					tr.filter = ply
					
					local trace = util.TraceLine( tr )
					
					local gren = ents.Create( "sent_uh_grenade" )
					gren:SetPos( trace.HitPos )
					gren:Spawn()
					gren:Activate()
					gren.Owner = ply
					gren:SetAngles( ply:GetAngles() )
					local phys = gren:GetPhysicsObject()
					if phys != nil and (phys:IsValid()) then
						phys:ApplyForceCenter(ply:GetAimVector() * 5000)
					end
				end)
			end
		end
		
		-- Silencer
		if key == sil and IsValid(wep) and string.find(wep.Base or "", "weapon_uh_base") and wep.HasSilencer then
			if wep:GetNWFloat("SilenceTime") < CurTime() and !wep:GetUHBool("Reloading") and wep:GetNWFloat("DeployTime") < CurTime() then
				wep:SetNWFloat("SilenceTime", ct + 2.1)
				local bool = !wep:GetNWBool("Silenced")
				wep:SetNWBool("Silenced", bool)
				wep:SetUHBool("Zooming", false)
				wep:SetNextPrimaryFire(ct + 2.1)
				wep:SetNextSecondaryFire(ct + 2.1)
				wep.NextReload = ct + 2.1
				ply.b_nextflashlight = ct + 2.1
				
				if ply:GetNWBool("UH_Flashlight") then
					ply:SetNWBool("UH_Flashlight", false)
					ply:SetNWBool("UH_ArmGone", false)
					if !wep.IsBolt and !wep.IsPump and !wep.TwoHanded then
						ply:SetNWFloat("UH_ArmTime", ct + 0.25)
					end
					ply:EmitSound("uh/flashlight.wav")
					
					net.Start("UH_Flashlight")
						net.WriteEntity(ply)
						net.WriteBool(false)
					net.Broadcast()
				elseif ply:GetNWBool("UH_Flare") then
					UHThrowFlare( ply )
					
					ply:SetNWBool("UH_ArmGone", false)
					if !wep.IsBolt and !wep.IsPump and !wep.TwoHanded then
						ply:SetNWFloat("UH_ArmTime", CurTime() + 0.25)
					end
				end
				
				if bool then
					wep:SendWeaponAnim(ACT_VM_ATTACH_SILENCER)
					wep:SetBodygroup(1, 1)
				else
					wep:SendWeaponAnim(ACT_VM_DETACH_SILENCER)
					wep:SetBodygroup(1, 0)
				end
			end
		end
	end)
	
	hook.Add("PlayerDeath", "UHPlayerDeath", function(ply)
		ply:SetNWBool("UH_Gasmask", false)
		ply:SetNWBool("UH_Nightvision", false)
		ply:SetNWFloat("UH_Battery", 0)
		if ply:GetNWBool("UH_Flashlight") then
			ply:SetNWBool("UH_Flashlight", false)
			ply:SetNWBool("UH_ArmGone", false)
			ply:SetNWFloat("UH_ArmTime", 0)
			
			net.Start("UH_Flashlight")
				net.WriteEntity(ply)
				net.WriteBool(false)
			net.Broadcast()
		end
		
		if ply:GetNWBool("UH_Flare") then
			ply:SetNWBool("UH_Flare", false)
			ply:SetNWFloat("UH_FlareTime", 0)
			ply:StopSound("UH.Flare.Burn")
			ply:SetNWBool("UH_ArmGone", false)
			ply:SetNWFloat("UH_ArmTime", 0)
			
			net.Start("UH_Flare")
				net.WriteEntity(ply)
				net.WriteBool(false)
			net.Broadcast()
		end
	end)
else
	language.Add("UH_Arrow_ammo", "Arrow")
	language.Add("UH_Grenade_ammo", "Grenade")
	language.Add("UH_MGL_ammo", "Grenade")
	language.Add("UH_Rocket_ammo", "RPG Rocket")
	
        -- ============================================
        -- Engine Bob Manager
        -- The Source Engine has its own viewmodel bob (cl_viewbob)
        -- that stacks with UH's custom bob system, causing doubled
        -- bobbing in multiplayer. This hook automatically disables
        -- the engine bob when a UH/BO3 weapon is active and restores
        -- it when switching to a non-UH weapon.
        -- ============================================
    local _uhSavedViewBob = nil
    local _uhLastViewBobCheck = 0
    
    hook.Add("Think", "UH_ManageEngineBob", function()
            local ply = LocalPlayer()
            if not IsValid(ply) or not ply:Alive() then return end
            
            local ct = CurTime()
            if ct - _uhLastViewBobCheck < 0.5 then return end
            _uhLastViewBobCheck = ct
            
            local wep = ply:GetActiveWeapon()
            local isUHWep = IsValid(wep) and (
                    string.find(wep:GetClass() or "", "weapon_uh_") or
                    string.find(wep:GetClass() or "", "weapon_bo3_") or
                    string.find(wep.Base or "", "weapon_uh_base") or
                    string.find(wep.Base or "", "weapon_bo3_base")
            )
            
            if isUHWep then
                    if _uhSavedViewBob == nil then
                            _uhSavedViewBob = GetConVar("cl_viewbob"):GetInt()
                    end
                    if GetConVar("cl_viewbob"):GetInt() != 0 then
                            RunConsoleCommand("cl_viewbob", "0")
                    end
            else
                    if _uhSavedViewBob != nil then
                            RunConsoleCommand("cl_viewbob", tostring(_uhSavedViewBob))
                            _uhSavedViewBob = nil
                    end
            end
    end)
	
	-- Muzzle
	if GetConVar("uh_dynamiclight") == nil then
		CreateClientConVar("uh_dynamiclight", "1", true, false, "Whether to use dynamic lights for bullets")
	end
	if GetConVar("uh_hiteffect") == nil then
		CreateClientConVar("uh_hiteffect", "1", true, false, "Use a custom hit-effect on hard materials")
	end
	if GetConVar("uh_muzzlegas") == nil then
		CreateClientConVar("uh_muzzlegas", "0", true, false, "Whether to use a gas-effect in the muzzle")
	end
	if GetConVar("uh_shellheat") == nil then
		CreateClientConVar("uh_shellheat", "1", true, false, "Whether to visually heat shells as they eject")
	end
	if GetConVar("uh_smoke") == nil then
		CreateClientConVar("uh_smoke", "1", true, false, "Whether to use a smoke-trail after shooting")
	end
	if GetConVar("uh_smoketime") == nil then
		CreateClientConVar("uh_smoketime", "1", true, false, "Average lifetime or smoke-trails")
	end
	if GetConVar("uh_rt_quality") == nil then
		CreateClientConVar("uh_rt_quality", "2", true, false, "The quality of sniper scopes")
	end
	--Viewbobbing switch
	if GetConVar("uh_viewbob_legacy") == nil then
		CreateClientConVar("uh_viewbob_legacy", "0", true, false, "Use legacy viewmodel bobbing (0 = new advanced, 1 = classic)")
	end
	
	-- Blur
	if GetConVar("uh_blur") == nil then
		CreateClientConVar("uh_blur", "1", true, false, "Use blur when reloading or deploying")
	end
	if GetConVar("uh_blur_amount") == nil then
		CreateClientConVar("uh_blur_amount", "3", true, false, "Amount of blur when scoped or reloading")
	end
	-- Scope
	if GetConVar("uh_scope_blur") == nil then
		CreateClientConVar("uh_scope_blur", "1", true, false, "Use blur when scoped")
	end
	if GetConVar("uh_scope_blur_amount") == nil then
		CreateClientConVar("uh_scope_blur_amount", "4", true, false, "Blur intensity when scoped")
	end
	
	-- Sway, bob & fov
	if GetConVar("uh_vmsway") == nil then
		CreateClientConVar("uh_vmsway", "1.2", true, false, "Viewmodel-Sway, preferably less than 5")
	end
	if GetConVar("uh_vmbob") == nil then
		CreateClientConVar("uh_vmbob", "1", true, false, "Viewmodel-Bob, preferably less than 5")
	end
	if GetConVar("uh_vmidle") == nil then
		CreateClientConVar("uh_vmidle", "1", true, false, "Viewmodel-Idle animation, preferably less than 5")
	end
	if GetConVar("uh_viewbob") == nil then
		CreateClientConVar("uh_viewbob", "1", true, false, "View-Bob, preferably less than 5")
	end
	
	-- Misc
	if GetConVar("uh_hands") == nil then
		CreateClientConVar("uh_hands", "3", true, true, "Hand skin and leg skin")
	end
	if GetConVar("uh_equipmentfov") == nil then
		CreateClientConVar("uh_equipmentfov", "80", true, false, "Equipment FOV")
	end
	
	-- HUD
	if GetConVar("uh_hud") == nil then
		CreateClientConVar("uh_hud", "1", true, false, "Enable custom HUD")
	end
	if GetConVar("uh_crosshair") == nil then
		CreateClientConVar("uh_crosshair", "1", true, false, "Enable crosshair")
	end
	if GetConVar("uh_hud_r") == nil then
		CreateClientConVar("uh_hud_r", "46", true, false, "Red color channel for HUD")
	end
	if GetConVar("uh_hud_g") == nil then
		CreateClientConVar("uh_hud_g", "158", true, false, "Green color channel for HUD")
	end
	if GetConVar("uh_hud_b") == nil then
		CreateClientConVar("uh_hud_b", "246", true, false, "Blue color channel for HUD")
	end
	
	-- Keys
	if GetConVar("uh_key_grenade") == nil then
		CreateClientConVar("uh_key_grenade", "17", true, true, "The key to throw grenades with")
	end
	if GetConVar("uh_key_gasmask") == nil then
		CreateClientConVar("uh_key_gasmask", "23", true, true, "The key to toggle gasmask if equipped")
	end
	if GetConVar("uh_key_nightvision") == nil then
		CreateClientConVar("uh_key_nightvision", "24", true, true, "The key to toggle nightvision if equipped")
	end
	if GetConVar("uh_key_silencer") == nil then
		CreateClientConVar("uh_key_silencer", "30", true, true, "The key to toggle silencer, if available")
	end
	if GetConVar("uh_key_kick") == nil then
		CreateClientConVar("uh_key_kick", "12", true, true, "The key to kick with")
	end
	
	local c_uh_anims = {}
	local cs_matcache = {}
	
	function getUHCacheMat( str )
		if cs_matcache[str] then return cs_matcache[str] end
		return Material( str )
	end
	
	surface.CreateFont("UH_AmmoLarge", { size = 24, weight = 500, antialias = true, font = "RussellSquare"})
	surface.CreateFont("UH_AmmoSmall", { size = 18, weight = 500, antialias = true, font = "RussellSquare"})
	
	hook.Add("PreRender", "UHEquipmentThink", function()
		local ply = LocalPlayer()
		local ct = CurTime()
		if IsValid(ply) then
			if ply:GetNWBool("UH_Flashlight") then
				local old = ply.c_oldwep or ply:GetActiveWeapon()
				local new = ply:GetActiveWeapon()
				ply.c_oldwep = new
				
				if old != new then
					if IsValid(old) and string.find(old.Base or "", "weapon_uh_base") and ( old.IsBolt or old.IsPump or old.TwoHanded ) then
						DoFlashlightAnimation(true)
					elseif IsValid(new) and string.find(new.Base or "", "weapon_uh_base") and ( new.IsBolt or new.IsPump or new.TwoHanded ) then
						DoFlashlightAnimation(false)
					end
				end
			end
			
			if ply:Alive() and !ply:ShouldDrawLocalPlayer() and ply:GetNWBool("UH_Gasmask") then
				if !b_mask_sound then
					ply:SetDSP( 30 )
					b_mask_sound = CreateSound(ply, "uh/voice/gasmask/breath_normal.wav")
					b_mask_sound:PlayEx( 0.4, 90 )
				end
			elseif b_mask_sound then
				ply:SetDSP( 0 )
				if b_mask_sound:IsPlaying() then
					b_mask_sound:FadeOut( 0.5 )
					b_mask_sound = nil
				end
			end
			
			if ply:Alive() and !ply:ShouldDrawLocalPlayer() and ply:GetNWBool("UH_Nightvision") then
				local dlight = DynamicLight( ply:EntIndex() )
				if dlight then
					dlight.Pos = ply:EyePos() - Vector(0,0,8) - LocalPlayer():GetAimVector()*16
					dlight.r = 150
					dlight.g = 150
					dlight.b = 150
					dlight.Brightness = 3
					dlight.Decay = 1000
					dlight.size = 814
					dlight.DieTime = ct + 1
				end
			end
		end
	end)
	
	local uh_nv_col = {}
	uh_nv_col["$pp_colour_brightness"]	= 0
	uh_nv_col["$pp_colour_colour"]		= 1
	uh_nv_col["$pp_colour_contrast"]	= 1
	uh_nv_col["$pp_colour_mulg"]		= 0.75
	
	hook.Add("HUDPaintBackground", "UHDrawGasmask", function()
		local ply = LocalPlayer()
		if ply:ShouldDrawLocalPlayer() then return end
		
		if ply:GetNWBool("UH_Gasmask") and GetConVar("uh_sv_gasmask"):GetBool() then
			surface.SetTexture( surface.GetTextureID("overlays/gasmask") )
			surface.SetDrawColor(255,255,255,255)
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		end
		if ply:GetNWBool("UH_Nightvision") and GetConVar("uh_sv_nightvision"):GetBool() then
			surface.SetTexture( surface.GetTextureID("overlays/nightvision") )
			surface.SetDrawColor(45,255,125,255)
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		end
	end)
	
	local i_keyids = {}
	function GetKeyIDs()
		if (i_lastinputcheck or 0) < CurTime() or table.Count(i_keyids) <= 0 then
			i_lastinputcheck = CurTime() + 10 -- Inputs don't change that often... And I don't know how expensive it is to call
			i_keyids = {}
			for i = 1, 159 do
				local key = input.GetKeyName( i )
				if key then
					i_keyids[key] = i
				end
			end
		end
		
		return i_keyids
	end
	
	hook.Add("HUDPaint", "UHDrawHUD", function()
		if !GetConVar("uh_sv_batteries"):GetBool() then return end
		local wep = LocalPlayer():GetActiveWeapon()
		if IsValid(wep) and string.find(wep.Base or "", "weapon_uh_base") and input.IsKeyDown( GetKeyIDs()[input.LookupBinding("impulse 100")] ) then
			c_flash = 1
		else
			c_flash = math.Approach(c_flash or 0, (LocalPlayer():GetNWBool("UH_Nightvision") or LocalPlayer():GetNWBool("UH_Flashlight")) and 1 or 0, FrameTime())
		end
		
		if c_flash > 0 then
			local bats = LocalPlayer():GetNWFloat("UH_Battery")
			local amount = math.ceil( bats )
			
			local w,h = 128,256
			local x,y = 0,ScrH()/2 - h/2
			local col = Color(255, 0, 0, 255*c_flash)
			if bats > 0 then
				col = Color(GetConVar("uh_hud_r"):GetInt(), GetConVar("uh_hud_g"):GetInt(), GetConVar("uh_hud_b"):GetInt(), 255*c_flash)
			end
			
			surface.SetTexture( surface.GetTextureID("vgui/uh/battery_outline") )
			surface.SetDrawColor(0, 0, 0, col.a)
			surface.DrawTexturedRect( x + 1, y + 1, w, h )
			surface.SetDrawColor(col.r, col.g, col.b, col.a)
			surface.DrawTexturedRect( x, y, w, h )
			
			if amount > 0 then
				local p = math.Clamp(amount - bats, 0, 1)
				local s = 0.325 + 0.44 * p
				
				surface.SetTexture( surface.GetTextureID("vgui/uh/battery_fill") )
				surface.SetDrawColor(0, 0, 0, col.a)
				surface.DrawTexturedRectUV( x + 1, y + h * s + 1, w, h * 0.44 * (1-p), 0, s, 1, 0.75 )
				surface.SetDrawColor(col.r, col.g, col.b, col.a)
				surface.DrawTexturedRectUV( x, y + h * s, w, h * 0.44 * (1-p), 0, s, 1, 0.75 )
			end
			
			draw.SimpleText("x"..amount, "UH_AmmoLarge", x + w/2 + 1, y + h * 0.1 + 1, Color(0, 0, 0, col.a), TEXT_ALIGN_CENTER)
			draw.SimpleText("x"..amount, "UH_AmmoLarge", x + w/2, y + h * 0.1, col, TEXT_ALIGN_CENTER)
		end
	end)
	
	net.Receive("UH_Select_Fire", function(len)
		local num = net.ReadFloat()
		local equip = net.ReadBool()
		local wep = LocalPlayer():GetActiveWeapon()
		if wep.FireModes and wep.FireModes[num] then
			local mode = wep.FireModes[num]
			if equip then
				mode.equip(LocalPlayer(), wep)
			else
				mode.holster(LocalPlayer(), wep)
			end
		end
	end)
	
	net.Receive("UH_Kick", function(len)
		DoKickAnimation()
	end)
	
	net.Receive("UH_Grenade", function(len)
		local wep = LocalPlayer():GetActiveWeapon()
		if IsValid(wep) then
			wep.b_zooming = false
		end
		if !LocalPlayer():GetNWBool("UH_Flare") then
			DoGrenadeAnimation( 0.25 )
		end
	end)
	
	net.Receive("UH_Flare", function(len)
		local ent = net.ReadEntity()
		local status = net.ReadBool()
		if IsValid(ent) and ent:IsPlayer() then
			if ent == LocalPlayer() then
				if status then
					timer.Simple(0.25, function()
						DoFlareAnimation( true )
					end)
				else
					DoFlareAnimation( false )
				end
			end
			if !status then
				ent:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_GMOD_GESTURE_ITEM_THROW, true )
			end
		end
	end)
	
	net.Receive("UH_Flashlight", function(len)
		local ent = net.ReadEntity()
		local status = net.ReadBool()
		if IsValid(ent) and ent:IsPlayer() then
			if ent == LocalPlayer() then
				if status then
					timer.Simple(0.25, function()
						DoFlashlightAnimation( true )
					end)
				else
					DoFlashlightAnimation( false )
				end
			end
			if status then
				if IsValid(ent.UH_FlashEnt) or timer.Exists("UH_Flashlight_"..ent:SteamID()) then return end
				timer.Create("UH_Flashlight_"..ent:SteamID(), 0.5, 1, function()
					if !IsValid(ent) then return end
					ent.UH_FlashEnt = ProjectedTexture()
					ent.UH_FlashEnt:SetPos( ent:GetShootPos() + ent:GetForward()*20 )
					ent.UH_FlashEnt:SetAngles( ent:EyeAngles() )
					
					ent.UH_FlashEnt:SetEnableShadows( true )
					ent.UH_FlashEnt:SetFarZ( 800 )
					ent.UH_FlashEnt:SetNearZ( 32 )
					ent.UH_FlashEnt:SetFOV( 70 )
					ent.UH_FlashEnt:SetBrightness( 2 )
					ent.UH_FlashEnt:SetColor( Color(255,255,255) )
					ent.UH_FlashEnt:SetTexture( "effects/uh_flashlight" )
					
					ent.UH_FlashEnt:Update()
				end)
			else
				if IsValid(ent.UH_FlashEnt) then
					ent.UH_FlashEnt:Remove()
					ent.UH_FlashEnt = nil
				end
			end
		end
	end)
	
	local gmmodel = {
		model = "models/items/gasmask.mdl",
		bone = "ValveBiped.Bip01_Head1",
		pos = Vector(3.2,4.4,0),
		ang = Angle(0,-80,-90)
	}
	
	local nvmodel = {
		model = "models/items/nightvision.mdl",
		bone = "ValveBiped.Bip01_Head1",
		pos = Vector(3.1,6.1,-0.25),
		ang = Angle(0,-70,-90)
	}
	
	local laserbeam = Material("effects/lamp_beam")
	local lasersprite = Material("sprites/glow04_noz")
	
	hook.Add("PostPlayerDraw", "UHMaskDraw", function(ply)
		if !ply:Alive() then return end
		
		if GetConVar("uh_sv_gasmask"):GetBool() and gmmodel and ply:GetNWBool("UH_Gasmask") then
			if !IsValid(ply.UH_Gasmask) then
				ply.UH_Gasmask = ClientsideModel(gmmodel.model, RENDERGROUP_OPAQUE)
				ply.UH_Gasmask:SetNoDraw(true)
			end
			
			local pos = Vector()
			local ang = Angle()
			
			local bone_id = ply:LookupBone(gmmodel.bone)
			if !bone_id then return end
			
			pos,ang = ply:GetBonePosition(bone_id)
			
			pos = pos + ang:Forward() * gmmodel.pos.x + ang:Right() * gmmodel.pos.y + ang:Up() * gmmodel.pos.z
			
			ang:RotateAroundAxis(ang:Up(), gmmodel.ang.y)
			ang:RotateAroundAxis(ang:Right(), gmmodel.ang.p)
			ang:RotateAroundAxis(ang:Forward(), gmmodel.ang.r)
			
			ply.UH_Gasmask:SetRenderOrigin(pos)
			ply.UH_Gasmask:SetRenderAngles(ang)
			ply.UH_Gasmask:SetupBones()
			ply.UH_Gasmask:DrawModel()
			ply.UH_Gasmask:SetRenderOrigin()
			ply.UH_Gasmask:SetRenderAngles()
		elseif GetConVar("uh_sv_nightvision"):GetBool() and nvmodel and ply:GetNWBool("UH_Nightvision") then
			if !IsValid(ply.UH_NVGoggles) then
				ply.UH_NVGoggles = ClientsideModel(nvmodel.model, RENDERGROUP_OPAQUE)
				ply.UH_NVGoggles:SetNoDraw(true)
			end
			
			local pos = Vector()
			local ang = Angle()
			
			local bone_id = ply:LookupBone(nvmodel.bone)
			if !bone_id then return end
			
			pos,ang = ply:GetBonePosition(bone_id)
			
			pos = pos + ang:Forward() * nvmodel.pos.x + ang:Right() * nvmodel.pos.y + ang:Up() * nvmodel.pos.z
			
			ang:RotateAroundAxis(ang:Up(), nvmodel.ang.y)
			ang:RotateAroundAxis(ang:Right(), nvmodel.ang.p)
			ang:RotateAroundAxis(ang:Forward(), nvmodel.ang.r)
			
			ply.UH_NVGoggles:SetRenderOrigin(pos)
			ply.UH_NVGoggles:SetRenderAngles(ang)
			
			render.EnableClipping(true)
			
			ang:RotateAroundAxis(ang:Right(), -15)
			
			local normal = ang:Up()
			local origin = pos + normal*0.4
			local distance = normal:Dot( origin )
			
			render.PushCustomClipPlane( normal, distance )
			
			ply.UH_NVGoggles:SetupBones()
			ply.UH_NVGoggles:DrawModel()
			ply.UH_NVGoggles:SetRenderOrigin()
			ply.UH_NVGoggles:SetRenderAngles()
			
			render.PopCustomClipPlane()
			
			render.EnableClipping(false)
		end
		
		local wep = ply:GetActiveWeapon()
		
		local p = ply.m_flash_weight or 0
		if p > 0 and IsValid(wep) and !wep.IsBolt and !wep.IsPump and !wep.TwoHanded and GetConVar("uh_sv_flashlight"):GetBool() then
			if !IsValid(UH_WorldFlash) then
				UH_WorldFlash = ClientsideModel("models/pg_props/pg_obj/pg_flashlight.mdl", RENDERGROUP_BOTH)
				UH_WorldFlash:SetNoDraw(true)
			end
			
			local attach_id = ply:LookupAttachment("anim_attachment_LH")
			if !attach_id then return end
			local attach = ply:GetAttachment(attach_id)
			if !attach then return end
			
			local eang = ply:EyeAngles()
			eang:RotateAroundAxis(eang:Right(), 180)
			
			local pos,ang = attach.Pos,attach.Ang
			ang:RotateAroundAxis(ang:Right(), 70)
			
			ang = LerpAngle(p, ang, eang)
			
			UH_WorldFlash:SetSkin( p >= 1 and 1 or 0 )
			
			UH_WorldFlash:SetRenderOrigin(pos)
			UH_WorldFlash:SetRenderAngles(ang)
			UH_WorldFlash:SetupBones()
			UH_WorldFlash:DrawModel()
			UH_WorldFlash:SetRenderOrigin()
			UH_WorldFlash:SetRenderAngles()
			
			if p >= 1 then
				local tr = util.TraceLine({start = pos - ang:Forward()*6, endpos = pos - ang:Forward()*200, filter = {ply, wep}})
				
				local dir1 = EyeAngles():Forward():Dot( ( pos - EyePos() ):GetNormalized() )
				local dir2 = ply:EyeAngles():Forward():Dot( ( EyePos() - pos ):GetNormalized() )
				local dir = (dir1+dir2)/2
				
				local p = math.Clamp((dir-0.6)/0.4, 0, 1)
				
				render.SetMaterial(laserbeam)
				render.DrawBeam(pos - ang:Forward()*6, tr.HitPos, 30, 0, 1, Color(255,255,255,50*(1-p)))
				
				render.SetMaterial(lasersprite)
				render.DrawSprite(pos - ang:Forward()*6, 48*p, 48*p, Color(255,255,255,255))
				render.DrawSprite(pos - ang:Forward()*6, 96*p, 96*p, Color(255,255,255,40))
			end
		elseif ply:GetNWBool("UH_Flare") then
			if !IsValid(UH_WorldFlare) then
				UH_WorldFlare = ClientsideModel("models/pg_props/pg_obj/pg_flare.mdl", RENDERGROUP_BOTH)
				UH_WorldFlare:SetNoDraw(true)
			end
			
			local attach_id = ply:LookupAttachment("anim_attachment_LH")
			if !attach_id then return end
			local attach = ply:GetAttachment(attach_id)
			if !attach then return end
			
			local pos,ang = attach.Pos,attach.Ang
			
			local dlight = DynamicLight( ply:EntIndex() )
			if dlight then
				dlight.Pos = pos + ang:Up()*8
				dlight.r = 200
				dlight.g = 25
				dlight.b = 0
				dlight.Brightness = 3
				dlight.Decay = 1000
				dlight.size = 256
				dlight.DieTime = CurTime() + 1
			end
			
			if (ply.c_nextflare or 0) < CurTime() then
				ply.c_nextflare = CurTime() + 0.1
				local fx = EffectData()
				fx:SetOrigin(pos + ang:Up()*8)
				fx:SetScale(2)
				util.Effect("uh_flare",fx)
			end
			
			UH_WorldFlare:SetSkin( 1 )
			
			UH_WorldFlare:SetRenderOrigin(pos)
			UH_WorldFlare:SetRenderAngles(ang)
			UH_WorldFlare:SetupBones()
			UH_WorldFlare:DrawModel()
			UH_WorldFlare:SetRenderOrigin()
			UH_WorldFlare:SetRenderAngles()
		end
	end)
	
	hook.Add("UpdateAnimation", "UpdateUHFlashlightPos", function(ply)
		local flash = ply.UH_FlashEnt
		
		if !GetConVar("uh_sv_flashlight"):GetBool() then
			if IsValid(flash) then
				DoFlashlightAnimation( false )
				flash:Remove()
				ply.UH_FlashEnt = nil
			end
		else
			if !IsValid(flash) then
				ply.m_flash_weight = math.Approach( ply.m_flash_weight or 0, 0, FrameTime()*4 )
			else
				local wep = ply:GetActiveWeapon()
				if !IsValid(wep) or wep.IsBolt or wep.IsPump or wep.TwoHanded then
					ply.m_flash_weight = math.Approach( ply.m_flash_weight or 0, 0, FrameTime()*4 )
				else
					ply.m_flash_weight = math.Approach( ply.m_flash_weight or 0, 1, FrameTime()*4 )
				end
				
				local wep = ply:GetActiveWeapon()
				if IsValid(wep) and string.find(wep.Base or "", "weapon_uh_base") then
					if ply == LocalPlayer() and GetViewEntity() == LocalPlayer() and !ply:ShouldDrawLocalPlayer() then
						local pos = ply:GetShootPos()
						local ang = ply:EyeAngles()
						
						local tr = {
							start = pos,
							endpos = pos + ang:Forward()*80,
							filter = ply
						}
						local trace = util.TraceLine(tr)
						
						pos = pos - ang:Forward()*(80*(1-trace.Fraction) - 20)
						
						flash:SetPos( pos )
						flash:SetAngles( ang )
						flash:Update()
					else
						local attach_id = ply:LookupAttachment("anim_attachment_LH")
						if !attach_id then return end
						local attach = ply:GetAttachment(attach_id)
						if !attach then return end
						
						local pos,ang = attach.Pos,attach.Ang
						
						pos = pos + ang:Forward() * 2
						
						flash:SetPos( pos )
						flash:SetAngles( ply:EyeAngles() )
						flash:Update()
					end
				end
			end
			
			if ply.m_flash_weight > 0 then
				ply:AnimRestartGesture( GESTURE_SLOT_VCD, ACT_GMOD_IN_CHAT, true )
				ply:AnimSetGestureWeight( GESTURE_SLOT_VCD, ply.m_flash_weight )
			end
		end
	end)
	
	function DoUHAnim( data )
		local ent = (c_uh_anims[data.name] and c_uh_anims[data.name].ent) or ClientsideModel(data.mdl, RENDERGROUP_BOTH)
		if ent:GetModel() != data.mdl then
			ent:SetModel( data.mdl )
		end
		
		ent:SetNoDraw(true)
		ent:ResetSequence( ent:LookupSequence(data.seq) )
		ent:SetCycle( 0 )
		ent:SetPlaybackRate( 1 )
		
		data.mdl = nil
		data.ent = ent
		data.time = (data.time and CurTime() + data.time)
		
		c_uh_anims[data.name] = data
		
		return ent
	end
	
	local jake_legs = {
		"models/weapons/v_kick_jake_casual.mdl",
		"models/weapons/v_kick_jake_inmate.mdl",
		"models/weapons/v_kick_jake_guard.mdl",
		"models/weapons/v_kick_jake_pmc.mdl"
	}
	
	function DoKickAnimation( delay )
		if !GetConVar("uh_sv_kick"):GetBool() then return end
		timer.Simple(delay or 0, function()
			local skin = GetConVar("uh_hands"):GetInt()
			local leg = jake_legs[skin + 1] or "models/weapons/v_kick_jake_casual.mdl"
			
			local data = {
				name = "kick",
				mdl = leg,
				seq = "attack",
				time = 0.7,
				predraw = (function(mdl, pos, ang)
					ang.p = math.Clamp(ang.p, 0, 90)
				end)
			}
			
			DoUHAnim( data )
		end)
	end
	
	function DoFlashlightAnimation( status, delay )
		if !GetConVar("uh_sv_flashlight"):GetBool() then return end
		local wep = LocalPlayer():GetActiveWeapon()
		if !c_uh_anims["flashlight"] and ( !IsValid(wep) or !string.find(wep.Base or "", "weapon_uh_base") or wep.IsBolt or wep.IsPump or wep.TwoHanded ) then return end
		timer.Simple(delay or 0, function()
			local data = {
				name = "flashlight",
				mdl = "models/weapons/v_flashlight_pg.mdl",
				seq = (status and "flashlight_draw" or "flashlight_holster"),
				ignorez = true,
				time = (!status and 0.5)
			}
			
			DoUHAnim( data )
		end)
	end
	
	function DoFlareAnimation( status, delay )
		if !GetConVar("uh_sv_flare"):GetBool() then return end
		timer.Simple(delay or 0, function()
			local data = {
				name = "flare",
				mdl = "models/weapons/v_flare_pg.mdl",
				seq = (status and "flare_draw" or "flare_throw"),
				ignorez = true,
				time = (!status and 0.8),
				postdraw = (function(mdl, pos, ang)
					local dlight = DynamicLight( LocalPlayer():EntIndex() )
					if dlight then
						dlight.Pos = pos + ang:Up()*8 + ang:Forward()*8 - ang:Right()*4
						dlight.r = 200
						dlight.g = 25
						dlight.b = 0
						dlight.Brightness = 3
						dlight.Decay = 1000
						dlight.size = 256
						dlight.DieTime = CurTime() + 1
					end
					
					if (c_nextflare or 0) < CurTime() then
						c_nextflare = CurTime() + 0.1
						local fx = EffectData()
						fx:SetOrigin(pos + ang:Up()*4 + ang:Forward()*8 - ang:Right()*4)
						fx:SetScale(2)
						util.Effect("uh_flare",fx)
					end
				end)
			}
			
			DoUHAnim( data )
		end)
	end
	
	function DoGrenadeAnimation( delay )
		if !GetConVar("uh_sv_grenades"):GetBool() then return end
		if LocalPlayer():GetNWBool("UH_Flashlight") then
			DoFlashlightAnimation( false )
			DoFlashlightAnimation( true, 0.5 )
		end
		timer.Simple(delay or 0, function()
			local data = {
				name = "grenade",
				mdl = "models/weapons/v_uh_frag.mdl",
				seq = "lob",
				ignorez = true,
				time = 0.5
			}
			
			DoUHAnim( data )
		end)
	end
	
	-- Movement
	local ec_jump = 0
	local ec_look = 0
	local ec_move = 0

	-- Sway
	local ec_oang = Angle( 0, 0, 0 )
	local ec_dang = Angle( 0, 0, 0 )
	
	local function EquipmentPosition(ply, pos,ang)
		local sway = GetConVar("uh_vmsway"):GetFloat() or 1.2
		local ct,ft = CurTime(),FrameTime() -- Save some frames
		local bob = GetConVar("uh_vmbob"):GetFloat()
		local idle = GetConVar("uh_vmidle"):GetFloat()
		
		if sway != 0 then
			local angdelta = ply:EyeAngles() - ec_oang
			
			if angdelta.y >= 180 then
				angdelta.y = angdelta.y-360
			elseif angdelta.y <= -180 then
				angdelta.y = angdelta.y+360
			end
			
			angdelta.p = math.Clamp(angdelta.p, -5, 5)
			angdelta.y = math.Clamp(angdelta.y, -5, 5)
			angdelta.r = math.Clamp(angdelta.r, -5, 5)
			
			local newang = LerpAngle( math.Clamp(FrameTime() * 10, 0, 1), ec_dang, angdelta )
			
			ec_dang = newang
			ec_oang = ply:EyeAngles()
			
			local psway = sway/2
			
			ang:RotateAroundAxis( ang:Right(), -newang.p*sway )
			ang:RotateAroundAxis( ang:Up(), newang.y*sway )
			ang:RotateAroundAxis( ang:Forward(), newang.y*sway )
			
			pos = pos + ang:Right()*newang.y*psway + ang:Up()*newang.p*psway
		end
		
		if bob == 0 and idle == 0 then return pos,ang end -- No need for a calculator
		
		local move = Vector(ply:GetVelocity().x, ply:GetVelocity().y, 0)
		local movement = move:LengthSqr()
		local movepercent = math.Clamp(movement/ply:GetRunSpeed()^2, 0, 1)
		
		local vel = move:GetNormalized()
		
		if ply:OnGround() then
			ec_move = Lerp(ft*8, ec_move or 0, movepercent)
		else
			ec_move = Lerp(ft*8, ec_move or 0, 0)
		end
		
		ec_jump = Lerp(ft*8, ec_jump or 0, ply:GetMoveType() == MOVETYPE_NOCLIP and 0 or math.Clamp(ply:GetVelocity().z/120, -1.5, 1))
		ang.p = ang.p + (ec_jump or 0)*2
		pos = pos + ang:Up()*ec_jump
		
		if ply:GetRight():Dot( vel ) > 0.5 then
			ec_look = Lerp(ft * 5, ec_look, 5*ec_move)
		elseif ply:GetRight():Dot( vel ) < -0.5 then
			ec_look = Lerp(ft * 5, ec_look, -5*ec_move)
		else
			ec_look = Lerp(ft * 5, ec_look, 0)
		end
		
		ang.r = ang.r + ec_look
		
		if ec_move > 0 and bob != 0 then
			pos = pos - ang:Forward()*ec_move
			pos = pos - ang:Up()*1.4*ec_move
			ang.y = ang.y - math.sin(ct*8.4)*1.3*ec_move*bob
			ang.p = ang.p - math.sin(ct*16.8)*0.8*ec_move*bob
			ang.r = ang.r - math.cos(ct*8.4)*0.2*ec_move*bob
		end
		
		if idle != 0 then
			ang.p = ang.p + math.sin(ct*0.5)*1*(1-ec_move)*idle
			ang.y = ang.y - math.sin(ct*1)*0.5*(1-ec_move)*idle
			ang.r = ang.r - math.sin(ct*2)*0.25*(1-ec_move)*idle
		end
		
		return pos,ang
	end
	
	hook.Add("RenderScreenspaceEffects", "UHRenderEquipment", function()
		local ply = LocalPlayer()
		if ply:ShouldDrawLocalPlayer() then return end
		
		if ply:GetNWBool("UH_Nightvision") and GetConVar("uh_sv_nightvision"):GetBool() then
			if render.SupportsPixelShaders_2_0() then
				DrawColorModify(uh_nv_col)
			end
		end
		
		if !ply:Alive() then
			for name,data in pairs(c_uh_anims) do
				if IsValid(data.ent) then
					data.ent:Remove()
				end
			end
			c_uh_anims = {}
		end
		
		if table.Count(c_uh_anims) > 0 then
			local fov = GetConVar("uh_equipmentfov"):GetInt() or 80
			
			local skin = GetConVar("uh_hands"):GetInt()
			local opos,oang = LocalPlayer():EyePos(),EyeAngles()
			
			local ct,ft = CurTime(),FrameTime()
			cam.Start3D( opos, oang, fov )
				for name,data in pairs(c_uh_anims) do
					local opos,oang = LocalPlayer():EyePos(),EyeAngles()
					local pos,ang = EquipmentPosition(ply, opos, oang)
					local mdl = data.ent
					local time = data.time
					
					if IsValid(mdl) and (time or ct) >= ct then
						if data.ignorez then
							cam.IgnoreZ(true)
						end
						mdl:SetSkin( skin != -1 and skin or 0 )
						mdl:FrameAdvance( ft )
						if data.predraw then
							data.predraw(mdl, pos, ang)
						end
						mdl:SetPos(pos)
						mdl:SetAngles(ang)
						mdl:SetupBones()
						mdl:DrawModel()
						if data.postdraw then
							data.postdraw(mdl, pos, ang)
						end
						if data.ignorez then
							cam.IgnoreZ(false)
						end
					else
						if IsValid(mdl) then
							mdl:Remove()
						end
						c_uh_anims[name] = nil
					end
				end
			cam.End3D()
		end
	end)
end


local function UHAdminSettingsPanel(panel)
	panel:ClearControls()
	
	panel:AddControl("CheckBox", {
		Label = "Enable first-time deploy animation",
		Command = "uh_sv_deploy"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Drop heavy weapons when holstering",
		Command = "uh_sv_heavyweapons"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Enable bullet-penetration",
		Command = "uh_sv_penetration"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Enable grenade-throwing",
		Command = "uh_sv_grenades"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Spawn with 5 magazines",
		Command = "uh_sv_ammo"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Use realistic pumping",
		Command = "uh_sv_realpump"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Enable custom flashlight",
		Command = "uh_sv_flashlight"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Enable batteries",
		Command = "uh_sv_batteries"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Enable flare-pickup",
		Command = "uh_sv_flare"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Enable gasmask",
		Command = "uh_sv_gasmask"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Enable nightvision",
		Command = "uh_sv_nightvision"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Enable action voices",
		Command = "uh_sv_voices"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Enable run animations",
		Command = "uh_sv_running"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Enable kicking",
		Command = "uh_sv_kick"
	})
	
	panel:AddControl("CheckBox", {
		Label = "Unlock doors when kicking",
		Command = "uh_sv_kick_unlockdoors"
	})
end

local function UHSettingsPanel(panel)
	panel:ClearControls()
	
	-- Keys
	panel:AddControl("Numpad", {
		Label = "Gasmask button",
		Command = "uh_key_gasmask"
	})
	panel:AddControl("Numpad", {
		Label = "Nightvision button",
		Command = "uh_key_nightvision"
	})
	panel:AddControl("Numpad", {
		Label = "Grenade button",
		Command = "uh_key_grenade"
	})
	panel:AddControl("Numpad", {
		Label = "Kick button",
		Command = "uh_key_kick"
	})
	panel:AddControl("Numpad", {
		Label = "Silencer button",
		Command = "uh_key_silencer"
	})
	
	-- Misc
	panel:AddControl( "ComboBox", {
		Label = "Hand Model",
		MenuButton = "0",
		Options = {
			["None"]				= { uh_hands = "-1" },
			["Casual"]				= { uh_hands = "0" },
			["Inmate"]				= { uh_hands = "1" },
			["Guard"]				= { uh_hands = "2" },
			["PMC"]					= { uh_hands = "3" }
		}
	})
	panel:AddControl( "Slider", {
		Label = "Equipment FOV",
		Command = "uh_equipmentfov",
		Min = 0,
		Max = 128
	})
	
	-- Muzzle & Shells
	panel:AddControl("CheckBox", {
		Label = "Enable hit-effect on hard materials",
		Command = "uh_hiteffect"
	})
	panel:AddControl("CheckBox", {
		Label = "Enable dynamic lights for bullets",
		Command = "uh_dynamiclight"
	})
	panel:AddControl("CheckBox", {
		Label = "Enable muzzle gas refract effect",
		Command = "uh_muzzlegas"
	})
	panel:AddControl("CheckBox", {
		Label = "Enable heat as shells eject",
		Command = "uh_shellheat"
	})
	panel:AddControl("CheckBox", {
		Label = "Enable smoke trails when shooting (May cause FPS drops)",
		Command = "uh_smoke"
	})
	panel:AddControl( "Slider", {
		Label = "Smoke-trail time",
		Command = "uh_smoketime",
		Type = "Float",
		Min = 0,
		Max = 4
	})
	
	panel:AddControl( "ComboBox", {
		Label = "Sniper scope Quality",
		MenuButton = "0",
		Options = {
			["Low"]					= { uh_rt_quality = "1" },
			["Normal"]				= { uh_rt_quality = "2" },
			["High"]				= { uh_rt_quality = "3" },
			["Ultra"]				= { uh_rt_quality = "4" }
		}
	})
	
	-- HUD
	
	panel:AddControl("CheckBox", {
		Label = "Enable custom HUD",
		Command = "uh_hud"
	})	
	panel:AddControl("CheckBox", {
		Label = "Enable Legacy Viewbobbing",
		Command = "uh_viewbob_legacy"
	})
	panel:AddControl("CheckBox", {
		Label = "Enable crosshair",
		Command = "uh_crosshair"
	})
	panel:AddControl("Color", {
		Label = "HUD color",
		Red = "uh_hud_r",
		Green = "uh_hud_g",
		Blue = "uh_hud_b"
	})
	
	-- Blur
	panel:AddControl("CheckBox", {
		Label = "Enable blur when deploying or reloading",
		Command = "uh_blur"
	})
	panel:AddControl( "Slider", {
		Label = "Blur amount",
		Command = "uh_blur_amount",
		Min = 0,
		Max = 5
	})
	
	-- Sway and bob
	panel:AddControl( "Slider", {
		Label = "Viewmodel-Sway",
		Command = "uh_vmsway",
		Type = "Float",
		Min = 0,
		Max = 4
	})
	panel:AddControl( "Slider", {
		Label = "Viewmodel-Bob",
		Command = "uh_vmbob",
		Type = "Float",
		Min = 0,
		Max = 4
	})
	panel:AddControl( "Slider", {
		Label = "Viewmodel-Idle",
		Command = "uh_vmidle",
		Type = "Float",
		Min = 0,
		Max = 4
	})
	panel:AddControl( "Slider", {
		Label = "View-Bob",
		Command = "uh_viewbob",
		Type = "Float",
		Min = 0,
		Max = 4
	})
end

local function PopulateUHMenu()
	spawnmenu.AddToolMenuOption("Options", "UH SWEPs", "UH_SWEPs_Admin", "Admin Settings", "", "", UHAdminSettingsPanel)
	spawnmenu.AddToolMenuOption("Options", "UH SWEPs", "UH_SWEPs", "Settings", "", "", UHSettingsPanel)
end
hook.Add("PopulateToolMenu", "UH Cvars", PopulateUHMenu)
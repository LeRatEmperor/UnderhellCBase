-- Lead Pipe (ported from weapon_uh_melee_pipe to MCV melee base)
-- Source: Underhell melee base, ported to mcv_melee

AddCSLuaFile()

SWEP.Base        = "mcv_melee"
SWEP.Spawnable   = true
SWEP.PrintName   = "Lead Pipe"
SWEP.Category    = "Black Ops 3 (MCV Port)"
SWEP.SubCategory = "Melee"
SWEP.Country     = ""
SWEP.Caliber     = ""

SWEP.Slot        = 0
SWEP.HoldType    = "melee"
SWEP.AimHoldType = "melee"

SWEP.ViewModel    = "models/weapons/v_pipe_pg.mdl"
SWEP.WorldModel   = "models/weapons/w_pipe_pg.mdl"
SWEP.ViewModelFOV = 64
SWEP.UseHands    = true
SWEP.ViewModelFlip = false

-- Damage: UH MinDamage 35 / MaxDamage 45 -> average 40 for primary (slash)
SWEP.DamageGeneric    = 40   -- slash
SWEP.DamageGenericAlt = 60   -- stab (1.5x default)
SWEP.MeleeRange       = 64
SWEP.MeleeRangeAlt    = 72

-- Swing rate: UH Primary.Delay 0.8 -> 60/0.8 = 75 swings/min
SWEP.SlashRate = 75
SWEP.StabRate  = 75
SWEP.HitDelay  = 0.25   -- UH Primary.HurtTime
SWEP.StabHitDelay = 0.25

SWEP.CanThrow = false
SWEP.CanRepair = false

-- Sounds (UH Primary.SwingSound / HitSound / HitWorldSound)
SWEP.SoundSwing     = "weapons/uh_pipe/pipe_swing.wav"
SWEP.SoundHitFlesh  = "weapons/uh_pipe/pipe_hitbod1.wav"
SWEP.SoundHitWorld  = "weapons/uh_pipe/pipe_hitworld1.wav"

-- Sequences (auto-detected from model if names match; otherwise falls back to ACT_VM_MISSCENTER)
-- Replace with the actual BO3 sequence names if your model has different ones.
SWEP.SequencesSlash = {"swing_a", "swing_b"}
SWEP.SequencesMiss  = {"miss"}
SWEP.SequencesStab  = {"stab"}

SWEP.Primary.Automatic = true

SWEP.WeaponWeight = 2.0

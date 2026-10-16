-- ghosts_sounds.lua
-- Converted from TFA AddFireSound/AddWeaponSound to sound.Add()

if SERVER then AddCSLuaFile() end


--GHOSTS CHAINSAW/CHAIN SAW
sound.Add({ name = "TFA_GHOSTS.CHAINSAW.FIRE", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {95, 105}, sound = "weapons/ghosts/chain_saw/wpn_iw6_chainsaw_shot_plr.mp3" })
sound.Add({ name = "TFA_GHOSTS.CHAINSAW.OPEN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/chain_saw/wpn_iw6_chainsaw_lid_open.mp3" })
sound.Add({ name = "TFA_GHOSTS.CHAINSAW.OUT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/chain_saw/wpn_iw6_chainsaw_mag_out.mp3" })
sound.Add({ name = "TFA_GHOSTS.CHAINSAW.LIFT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/chain_saw/wpn_iw6_chainsaw_lift.mp3" })
sound.Add({ name = "TFA_GHOSTS.CHAINSAW.IN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/chain_saw/wpn_iw6_chainsaw_mag_in.mp3" })
sound.Add({ name = "TFA_GHOSTS.CHAINSAW.CLOSE", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/chain_saw/wpn_iw6_chainsaw_lid_close.mp3" })
sound.Add({ name = "TFA_GHOSTS.CHAINSAW.END", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/chain_saw/wpn_iw6_chainsaw_end.mp3" })
sound.Add({ name = "TFA_GHOSTS.CHAINSAW.CHARGE", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/chain_saw/wpn_iw6_chainsaw_charge.mp3" })

--GHOSTS 44 MAGNUM
sound.Add({ name = "TFA_GHOSTS.44.FIRE", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {95, 105}, sound = "weapons/ghosts/44/wpn_iw6_magnum_shot_plr.mp3" })
sound.Add({ name = "TFA_GHOSTS.44.OPEN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/44/wpn_iw6_magnum_open.mp3" })
sound.Add({ name = "TFA_GHOSTS.44.OUT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/44/wpn_iw6_magnum_clip_out.mp3" })
sound.Add({ name = "TFA_GHOSTS.44.IN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/44/wpn_iw6_magnum_clip_in.mp3" })
sound.Add({ name = "TFA_GHOSTS.44.CLOSE", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/44/wpn_iw6_magnum_close.mp3" })
sound.Add({ name = "TFA_GHOSTS.44.COCK", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/44/wpn_iw6_magnum_cock.mp3" })
sound.Add({ name = "TFA_GHOSTS.44.START", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/44/wpn_iw6_magnum_start.mp3" })
sound.Add({ name = "TFA_GHOSTS.44.END", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/44/wpn_iw6_magnum_end.mp3" })

--GHOSTS MTS225
sound.Add({ name = "TFA_GHOSTS.MTS225.FIRE", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {95, 105}, sound = "weapons/ghosts/mts225/fire.mp3" })
sound.Add({ name = "TFA_GHOSTS.MTS225.OPEN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mts225/reload_chamber_open.mp3" })
sound.Add({ name = "TFA_GHOSTS.MTS225.EJECT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mts225/reload_eject.mp3" })
sound.Add({ name = "TFA_GHOSTS.MTS225.INSERT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mts225/reload_insert.mp3" })
sound.Add({ name = "TFA_GHOSTS.MTS225.CLOSE", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mts225/reload_chamber_close.mp3" })
sound.Add({ name = "TFA_GHOSTS.MTS225.END", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mts225/reload_end.mp3" })
sound.Add({ name = "TFA_GHOSTS.MTS225.LIFT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mts225/reload_lift.mp3" })

--GHOSTS SA805
sound.Add({ name = "TFA_GHOSTS.SA805.FIRE", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {95, 105}, sound = "weapons/ghosts/sa805/fire.mp3" })
sound.Add({ name = "TFA_GHOSTS.SA805.OUT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/sa805/reload_clipout.mp3" })
sound.Add({ name = "TFA_GHOSTS.SA805.IN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/sa805/reload_clipin.mp3" })
sound.Add({ name = "TFA_GHOSTS.SA805.CHAMBER", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/sa805/reload_chamber.mp3" })
sound.Add({ name = "TFA_GHOSTS.SA805.END", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/sa805/reload_end.mp3" })
sound.Add({ name = "TFA_GHOSTS.SA805.LIFT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/sa805/reload_lift.mp3" })

--GHOSTS MK14
sound.Add({ name = "TFA_GHOSTS.MK14.FIRE", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {95, 105}, sound = "weapons/ghosts/mk14/weap_mk14ebr_slst_03d.mp3" })
sound.Add({ name = "TFA_GHOSTS.MK14.OUT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mk14/wpfoly_mk14_reload_clipout_v1.mp3" })
sound.Add({ name = "TFA_GHOSTS.MK14.IN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mk14/wpfoly_mk14_reload_clipin_v1.mp3" })
sound.Add({ name = "TFA_GHOSTS.MK14.CHAMBER", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mk14/wpfoly_mk14_reload_chamber_v1.mp3" })
sound.Add({ name = "TFA_GHOSTS.MK14.GRAB", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mk14/wpfoly_mk14_reload_grab_v1.mp3" })
sound.Add({ name = "TFA_GHOSTS.MK14.LIFT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mk14/wpfoly_mk14_reload_lift_v1.mp3" })

--GHOSTS M27 LMG
sound.Add({ name = "TFA_GHOSTS.M27_LMG.FIRE", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {95, 105}, sound = "weapons/ghosts/m27_lmg/iw6_m27iar_fire.mp3" })
sound.Add({ name = "TFA_GHOSTS.M27_LMG.OUT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/m27_lmg/iw6_m27iar_clipout.mp3" })
sound.Add({ name = "TFA_GHOSTS.M27_LMG.IN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/m27_lmg/iw6_m27iar_clipin.mp3" })
sound.Add({ name = "TFA_GHOSTS.M27_LMG.CHAMBER", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/m27_lmg/iw6_m27iar_hit.mp3" })
sound.Add({ name = "TFA_GHOSTS.M27_LMG.FIRST_RAISE", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/m27_lmg/iw6_m27iar_first_raise.mp3" })

--GHOSTS MAVERICK
sound.Add({ name = "TFA_GHOSTS.MAVERICK.FIRE", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {95, 105}, sound = "weapons/ghosts/maverick/weap_dlcar_slst_01.mp3" })
sound.Add({ name = "TFA_GHOSTS.MAVERICK.OUT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/maverick/wpfoly_rm22_reload_clipout.mp3" })
sound.Add({ name = "TFA_GHOSTS.MAVERICK.IN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/maverick/wpfoly_rm22_reload_clipin.mp3" })
sound.Add({ name = "TFA_GHOSTS.MAVERICK.CHAMBER", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/maverick/wpfoly_rm22_reload_chamber.mp3" })
sound.Add({ name = "TFA_GHOSTS.MAVERICK.LIFT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/maverick/wpfoly_rm22_reload_lift.mp3" })
sound.Add({ name = "TFA_GHOSTS.MAVERICK.END", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/maverick/wpfoly_rm22_reload_end.mp3" })
sound.Add({ name = "TFA_GHOSTS.MAVERICK.CLAP", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/maverick/wpfoly_rm22_reload_clap.mp3" })

--GHOSTS CBJ
sound.Add({ name = "TFA_GHOSTS.CBJ.FIRE", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {95, 105}, sound = "weapons/ghosts/cbj/weap_cbjms_rlst_02.mp3" })
sound.Add({ name = "TFA_GHOSTS.CBJ.OUT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/cbj/wpfoly_cbj_reload_clipout_v2.mp3" })
sound.Add({ name = "TFA_GHOSTS.CBJ.IN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/cbj/wpfoly_cbj_reload_clipin_v2.mp3" })
sound.Add({ name = "TFA_GHOSTS.CBJ.CHAMBER", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/cbj/wpfoly_cbj_reload_chamber_v3.mp3" })
sound.Add({ name = "TFA_GHOSTS.CBJ.LIFT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/cbj/wpfoly_cbj_firstraise_lift_v2.mp3" })
sound.Add({ name = "TFA_GHOSTS.CBJ.END", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/cbj/wpfoly_cbj_reload_end_v2.mp3" })

--GHOSTS SC2010
sound.Add({ name = "TFA_GHOSTS.SC2010.FIRE", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {95, 105}, sound = "weapons/ghosts/sc2010/sc2010_fire.mp3" })
sound.Add({ name = "TFA_GHOSTS.SC2010.OUT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/sc2010/weap_sc2010_clipout.mp3" })
sound.Add({ name = "TFA_GHOSTS.SC2010.IN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/sc2010/weap_sc2010_clipin.mp3" })
sound.Add({ name = "TFA_GHOSTS.SC2010.CHAMBER", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/sc2010/weap_sc2010_chamber.mp3" })

--GHOSTS MR28
sound.Add({ name = "TFA_GHOSTS.MR28.FIRE", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {95, 105}, sound = "weapons/ghosts/mr28/weap_mr28_fire.mp3" })
sound.Add({ name = "TFA_GHOSTS.MR28.OUT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mr28/weap_mr28_clipout.mp3" })
sound.Add({ name = "TFA_GHOSTS.MR28.IN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mr28/weap_mr28_clipin.mp3" })
sound.Add({ name = "TFA_GHOSTS.MR28.CHAMBER", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mr28/weap_mr28_chamber.mp3" })
sound.Add({ name = "TFA_GHOSTS.MR28.CLIP_HIT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mr28/weap_mr28_clip_hit.mp3" })
sound.Add({ name = "TFA_GHOSTS.MR28.HIT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/mr28/weap_mr28_hit.mp3" })

--GHOSTS PANZERFAUST
sound.Add({ name = "TFA_GHOSTS.PANZERFAUST.FIRE", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {95, 105}, sound = "weapons/ghosts/panzerfaust/wpn_iw6_panzerfaust3_shot.mp3" })
sound.Add({ name = "TFA_GHOSTS.PANZERFAUST.RELOAD", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/panzerfaust/weap_panzerfaust_reload.mp3" })

--GHOSTS K7
sound.Add({ name = "TFA_GHOSTS.K7.FIRE", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {95, 105}, sound = "weapons/ghosts/k7/k7_fire.mp3" })
sound.Add({ name = "TFA_GHOSTS.K7.OUT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/k7/weap_k7_clipout.mp3" })
sound.Add({ name = "TFA_GHOSTS.K7.IN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/k7/weap_k7_clipin.mp3" })

--GHOSTS MINIGUN
sound.Add({ name = "TFA_GHOSTS.MINIGUN.FIRE", channel = CHAN_WEAPON, volume = 1.0, level = 140, pitch = {95, 105}, sound = "weapons/ghosts/minigun/wpn_iw6_minigun_fire.mp3" })
sound.Add({ name = "TFA_GHOSTS.MINIGUN.START", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/minigun/wpn_iw6_minigun_fire_start.mp3" })
sound.Add({ name = "TFA_GHOSTS.MINIGUN.STOP", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/minigun/wpn_iw6_minigun_fire_stop.mp3" })
sound.Add({ name = "TFA_GHOSTS.MINIGUN.IN", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/minigun/wpn_iw6_minigun_mag_in.mp3" })
sound.Add({ name = "TFA_GHOSTS.MINIGUN.OUT", channel = CHAN_USER_BASE, volume = 1.0, level = 75, pitch = {95, 105}, sound = "weapons/ghosts/minigun/wpn_iw6_minigun_mag_out.mp3" })

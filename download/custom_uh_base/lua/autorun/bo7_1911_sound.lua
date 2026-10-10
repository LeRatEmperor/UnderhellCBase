sound.Add({
	name = "1911_fire",
	channel = CHAN_WEAPON,
	level = 140,
	volume = 1,
	pitch = {100},
	sound = {
		"1911/fire/wpn_pi_alcor_fire_plr_01.wav",
		"1911/fire/wpn_pi_alcor_fire_plr_02.wav",
		"1911/fire/wpn_pi_alcor_fire_plr_03.wav"
		}
})

sound.Add({
	name = "1911_fire_ads",
	channel = CHAN_WEAPON,
	level = 140,
	volume = 1,
	pitch = {110},
	sound = {
		"1911/fire/wpn_pi_alcor_fire_plr_01.wav",
		"1911/fire/wpn_pi_alcor_fire_plr_02.wav",
		"1911/fire/wpn_pi_alcor_fire_plr_03.wav"
		}
})

sound.Add({
	name = "1911_fire_s",
	channel = CHAN_WEAPON,
	level = 140,
	volume = 1,
	pitch = {100},
	sound = {
		"1911/fire/wpn_pi_alcor_sup_plr_01.wav",
		"1911/fire/wpn_pi_alcor_sup_plr_02.wav",
		"1911/fire/wpn_pi_alcor_sup_plr_03.wav"
		}
})

sound.Add({
	name = "1911_fire_s_ads",
	channel = CHAN_WEAPON,
	level = 140,
	volume = 1,
	pitch = {110},
	sound = {
		"1911/fire/wpn_pi_alcor_sup_plr_01.wav",
		"1911/fire/wpn_pi_alcor_sup_plr_02.wav",
		"1911/fire/wpn_pi_alcor_sup_plr_03.wav"
		}
})

----混响
local CHAN_ATMO = CHAN_WEAPON
local CHAN_WPNFOLEY = CHAN_WEAPON
sound.Add({
	name = "1911_fire_atom",
    channel =        CHAN_ATMO,
    volume =      0.35,
	sound = {
		"1911/fire/weap_pistol_fire_plr_atmo_ext5_01.ogg",
		"1911/fire/weap_pistol_fire_plr_atmo_ext5_03.ogg",		
		"1911/fire/weap_pistol_fire_plr_atmo_ext5_02.ogg"
		}
})

---混响

sound.Add({
    name =           "wfoly_ar_akilo47_ads_up",
    channel =        CHAN_WPNFOLEY +1,
    volume =         1,
    sound = {"1911/wfoly_ar_akilo47_ads_up.ogg"}
})

sound.Add({
    name =           "wfoly_ar_akilo47_ads_down",
    channel =        CHAN_WPNFOLEY +1,
    volume =         1,
    sound = {"1911/wfoly_ar_akilo47_ads_down.ogg"}
})

sound.Add({
    name =           "wpn_br_hcharlie36_plr_last_mech_01",
    channel =        CHAN_WPNFOLEY +1,
    volume =         1,
    sound = {"1911/wpn_br_hcharlie36_plr_last_mech_01.ogg"}
})

----------------

sound.Add({
    name =           "fly_plr_pi_alcor_raise_first_lift",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_raise_first_lift.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_raise_first_slideback",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_raise_first_slideback.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_raise_first_end",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_raise_first_end.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_01",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_raise.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_02",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_magrelease.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_03",
    channel =        CHAN_WPNFOLEY + 3,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_magout.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_04",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_maggrab.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_05",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_mvmnt1.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_06",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_06.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_07",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_grabslide.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_08",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_slideback.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_09",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_sliderelease.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_10",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_rotate.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_11",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_11.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_12",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_maghit1.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_13",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_maghit2.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_14",
    channel =        CHAN_WPNFOLEY + 3,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_maghin.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_15",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_end.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_empty_01",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_empty_raise.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_empty_02",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_empty_rotate.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_empty_03",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_empty_magrelease.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_empty_04",
    channel =        CHAN_WPNFOLEY + 3,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_empty_magout.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_empty_05",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_empty_mvmnt.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_empty_06",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_empty_maghit1.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_empty_07",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_empty_maghit2.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_empty_08",
    channel =        CHAN_WPNFOLEY + 3,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_empty_magin.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_empty_09",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_empty_lower.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_inspect_empty_10",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_inspect_empty_charge.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_01",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_lift.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_02",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_magout.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_03",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_maghit1.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_04",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_maghit2.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_05",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_maghit3.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_06",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_magin.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_07",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_end.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_01",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_raise.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_02",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_magout.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_03",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_maghit.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_04",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_magin.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_05",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_rotate.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_06",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_charge.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_07",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_end.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext01_01",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext01_raise.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext01_02",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext01_magrelease.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext01_03",
    channel =        CHAN_WPNFOLEY + 3,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext01_magout.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext01_04",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext01_maggrab.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext01_05",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext01_maghit1.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext01_06",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext01_maghit2.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext01_07",
    channel =        CHAN_WPNFOLEY + 3,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext01_magin.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext01_08",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext01_end.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext01_01",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext01_raise.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext01_02",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext01_magout.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext01_03",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext01_maghit1.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext01_04",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext01_maghit2.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext01_05",
    channel =        CHAN_WPNFOLEY + 3,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext01_magin.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext01_06",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext01_rotate.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext01_07",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext01_charge.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext01_08",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext01_end.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext02_01",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext02_raise.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext02_02",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext02_magout.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext02_03",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext02_mvmnt.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext02_04",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext02_maghit1.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext02_05",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext02_maghit2.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext02_06",
    channel =        CHAN_WPNFOLEY + 3,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext02_magin.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_ext02_07",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_ext02_end.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext02_01",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext02_raise.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext02_02",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext02_magrelease.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext02_03",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext02_maggrab.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext02_04",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext02_magout.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext02_05",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext02_maghit1.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext02_06",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext02_maghit2.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext02_07",
    channel =        CHAN_WPNFOLEY + 3,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext02_magin.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext02_08",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext02_mvmnt.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext02_09",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext02_sliderelease.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_ext02_10",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_ext02_end.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_fast_01",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_fast_raise.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_fast_02",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_fast_magrelease.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_fast_03",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_fast_magout.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_fast_04",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_fast_mvmnt.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_fast_05",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_fast_maghit1.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_fast_06",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_fast_maghit2.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_fast_07",
    channel =        CHAN_WPNFOLEY + 3,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_fast_magin.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_fast_08",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_fast_end.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_fast_01",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_fast_raise.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_fast_02",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_fast_magrelease.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_fast_03",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_fast_mvmnt.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_fast_04",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_fast_magout.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_fast_05",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_fast_maghit.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_fast_06",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_fast_magin.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_fast_07",
    channel =        CHAN_WPNFOLEY + 2,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_fast_charge.ogg"}
})

sound.Add({
    name =           "fly_plr_pi_alcor_reload_empty_fast_08",
    channel =        CHAN_WPNFOLEY + 1,
    volume =         1,
    sound =          {"1911/fly_plr_pi_alcor_reload_empty_fast_end.ogg"}
})


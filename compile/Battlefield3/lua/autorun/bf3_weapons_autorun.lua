//Kill icons


local icol = Color( 255, 255, 255, 255 ) 
if CLIENT then

	killicon.Add(  "bf3_870mcs",		"entities/killicons/bf3_870mcs.png", 	icol  )
	killicon.Add(  "bf3_acwr",			"entities/killicons/bf3_acwr", 			icol  )
	killicon.Add(  "bf3_aek971",		"entities/killicons/bf3_aek971", 		icol  )
	killicon.Add(  "bf3_ak74",			"entities/killicons/bf3_ak74", 			icol  )
	killicon.Add(  "bf3_aks74u",		"entities/killicons/bf3_aks74u", 		icol  )
	killicon.Add(  "bf3_asval",			"entities/killicons/bf3_asval", 		icol  )
	killicon.Add(  "bf3_famas",			"entities/killicons/bf3_famas", 		icol  )
	killicon.Add(  "bf3_g18",			"entities/killicons/bf3_g18", 			icol  )
	killicon.Add(  "bf3_g36c",			"entities/killicons/bf3_g36c", 			icol  )
	killicon.Add(  "bf3_g3a3",			"entities/killicons/bf3_g3a3", 			icol  )
	killicon.Add(  "bf3_l85a2",			"entities/killicons/bf3_l85a2", 		icol  )
	killicon.Add(  "bf3_m1014",			"entities/killicons/bf3_m1014", 		icol  )
	killicon.Add(  "bf3_m16a3",			"entities/killicons/bf3_m16a3", 		icol  )
	killicon.Add(  "bf3_m1911",			"entities/killicons/bf3_m1911", 		icol  )
	killicon.Add(  "bf3_m249",			"entities/killicons/bf3_m249", 			icol  )
	killicon.Add(  "bf3_m416",			"entities/killicons/bf3_m416", 			icol  )
	killicon.Add(  "bf3_m4a1",			"entities/killicons/bf3_m4a1", 			icol  )
	killicon.Add(  "bf3_m82a3",			"entities/killicons/bf3_m82a3", 		icol  )
	killicon.Add(  "bf3_m9",			"entities/killicons/bf3_m9", 			icol  )
	killicon.Add(  "bf3_m93r",			"entities/killicons/bf3_m93r", 			icol  )
	killicon.Add(  "bf3_m98b",			"entities/killicons/bf3_m98b", 			icol  )
	killicon.Add(  "bf3_magnum44",		"entities/killicons/bf3_magnum44", 		icol  )
	killicon.Add(  "bf3_mk11",			"entities/killicons/bf3_mk11", 			icol  )
	killicon.Add(  "bf3_mp412",			"entities/killicons/bf3_mp412", 		icol  )
	killicon.Add(  "bf3_mp443",			"entities/killicons/bf3_mp443", 		icol  )
	killicon.Add(  "bf3_mp7",			"entities/killicons/bf3_mp7", 			icol  )
	killicon.Add(  "bf3_pp19",			"entities/killicons/bf3_pp19", 			icol  )
	killicon.Add(  "bf3_saiga12",		"entities/killicons/bf3_saiga12", 		icol  )
	killicon.Add(  "bf3_scarh",			"entities/killicons/bf3_scarh", 		icol  )
	killicon.Add(  "bf3_spas12",		"entities/killicons/bf3_spas12", 		icol  )
	killicon.Add(  "bf3_sv98",			"entities/killicons/bf3_sv98", 			icol  )
	killicon.Add(  "bf3_ump45",			"entities/killicons/bf3_ump45", 		icol  )

end


//Sound


//Shared
sound.Add({
	name 	= 		"bf3.draw",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/draw.wav"
})
sound.Add({
	name 	= 		"bf3.empty",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/empty.wav"
})
sound.Add({
	name 	= 		"bf3.draw_knife",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/knife_draw.wav"
})
sound.Add({
	name 	= 		"bf3.insert",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/insert.wav"
})

//ACW-R
sound.Add({
	name 	= 		"bf3_acwr.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/acwr_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_acwr.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/acwr_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_acwr.boltcatch",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/acwr_boltcatch.wav"
})


//M4A1
sound.Add({
	name 	= 		"bf3_m4a1.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m4a1_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_m4a1.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m4a1_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_m4a1.boltcatch",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m4a1_boltcatch.wav"
})

//M416
sound.Add({
	name 	= 		"bf3_m416.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m416_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_m416.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m416_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_m416.boltcatch",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m416_boltcatch.wav"
})

//M16A3
sound.Add({
	name 	= 		"bf3_m16a3.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m16a3_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_m16a3.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m16a3_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_m16a3.boltcatch",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m16a3_boltcatch.wav"
})

//AK-74M
sound.Add({
	name 	= 		"bf3_ak74.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/ak74_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_ak74.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/ak74_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_ak74.boltpull",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/ak74_boltpull.wav"
})

//AEK-971
sound.Add({
	name 	= 		"bf3_aek971.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/aek971_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_aek971.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/aek971_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_aek971.boltpull",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/aek971_boltpull.wav"
})

//M9
sound.Add({
	name 	= 		"bf3_m9.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m9_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_m9.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m9_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_m9.slide",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m9_slide.wav"
})

//MP443
sound.Add({
	name 	= 		"bf3_mp443.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp443_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_mp443.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp443_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_mp443.slide",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp443_slide.wav"
})

//G18
sound.Add({
	name 	= 		"bf3_g18.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/g18_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_g18.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/g18_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_g18.slide",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/g18_slide.wav"
})

//M1911
sound.Add({
	name 	= 		"bf3_m1911.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m1911_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_m1911.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m1911_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_m1911.slide",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m1911_slide.wav"
})

//Magnum .44
sound.Add({
	name 	= 		"bf3_magnum44.close",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/magnum44_close.wav"
})
sound.Add({
	name 	= 		"bf3_magnum44.open",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/magnum44_open.wav"
})
sound.Add({
	name 	= 		"bf3_magnum44.shellin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/magnum44_shellin.wav"
})

//MP-412
sound.Add({
	name 	= 		"bf3_mp412.close",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp412_close.wav"
})
sound.Add({
	name 	= 		"bf3_mp412.open",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp412_open.wav"
})
sound.Add({
	name 	= 		"bf3_mp412.shellin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp412_shellin.wav"
})

//Famas
sound.Add({
	name 	= 		"bf3_famas.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/famas_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_famas.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/famas_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_famas.boltpull",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/famas_boltpull.wav"
})

//G3A3
sound.Add({
	name 	= 		"bf3_g3a3.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/g3a3_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_g3a3.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/g3a3_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_g3a3.boltback",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/g3a3_boltback.wav"
})
sound.Add({
	name 	= 		"bf3_g3a3.boltforward",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/g3a3_boltforward.wav"
})

//L85A2
sound.Add({
	name 	= 		"bf3_l85a2.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/l85a2_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_l85a2.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/l85a2_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_l85a2.boltpull",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/l85a2_boltpull.wav"
})

//SCAR-H
sound.Add({
	name 	= 		"bf3_scarh.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/scarh_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_scarh.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/scarh_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_scarh.boltcatch",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/scarh_boltcatch.wav"
})

//G36C
sound.Add({
	name 	= 		"bf3_g36c.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/g36c_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_g36c.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/g36c_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_g36c.boltpull",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/g36c_boltpull.wav"
})

//AKS-74U
sound.Add({
	name 	= 		"bf3_aks74u.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/aks74u_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_aks74u.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/aks74u_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_aks74u.boltpull",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/aks74u_boltpull.wav"
})

//M5K
sound.Add({
	name 	= 		"bf3_mp5k.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp5k_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_mp5k.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp5k_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_mp5k.boltback",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp5k_boltback.wav"
})
sound.Add({
	name 	= 		"bf3_mp5k.boltforward",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp5k_boltforward.wav"
})

//UMP-45
sound.Add({
	name 	= 		"bf3_ump45.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/ump45_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_ump45.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/ump45_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_ump45.boltback",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/ump45_boltback.wav"
})
sound.Add({
	name 	= 		"bf3_ump45.boltforward",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/ump45_boltforward.wav"
})

//AS-VAL
sound.Add({
	name 	= 		"bf3_asval.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/asval_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_asval.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/asval_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_asval.boltpull",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/asval_boltpull.wav"
})

//MP7
sound.Add({
	name 	= 		"bf3_mp7.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp7_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_mp7.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp7_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_mp7.boltcatch",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp7_boltcatch.wav"
})
sound.Add({
	name 	= 		"bf3_mp7.grip",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mp7_grip.wav"
})

//870MCS
sound.Add({
	name 	= 		"bf3_870mcs.pump",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/870mcs_pump.wav"
})
sound.Add({
	name 	= 		"bf3_870mcs.pumpback",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/870mcs_pumpback.wav"
})

//Saiga-12K
sound.Add({
	name 	= 		"bf3_saiga12.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/saiga12_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_saiga12.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/saiga12_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_saiga12.boltpull",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/saiga12_boltpull.wav"
})

//M249
sound.Add({
	name 	= 		"bf3_m249.boxin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m249_boxin.wav"
})
sound.Add({
	name 	= 		"bf3_m249.boxout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m249_boxout.wav"
})
sound.Add({
	name 	= 		"bf3_m249.coverup",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m249_coverup.wav"
})
sound.Add({
	name 	= 		"bf3_m249.coverdown",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m249_coverdown.wav"
})
sound.Add({
	name 	= 		"bf3_m249.chain",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m249_chain.wav"
})
sound.Add({
	name 	= 		"bf3_m249.boltpull",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m249_boltpull.wav"
})

//M82A3
sound.Add({
	name 	= 		"bf3_m82a3.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m82a3_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_m82a3.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m82a3_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_m82a3.boltpull",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m82a3_boltpull.wav"
})

//MK11
sound.Add({
	name 	= 		"bf3_mk11.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mk11_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_mk11.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mk11_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_mk11.boltcatch",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/mk11_boltcatch.wav"
})

//SV-98
sound.Add({
	name 	= 		"bf3_sv98.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/sv98_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_sv98.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/sv98_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_sv98.boltback",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/sv98_boltback.wav"
})
sound.Add({
	name 	= 		"bf3_sv98.boltforward",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/sv98_boltforward.wav"
})

//M98B
sound.Add({
	name 	= 		"bf3_m98b.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m98b_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_m98b.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m98b_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_m98b.boltback",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m98b_boltback.wav"
})
sound.Add({
	name 	= 		"bf3_m98b.boltforward",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/m98b_boltforward.wav"
})

//PP-19
sound.Add({
	name 	= 		"bf3_pp19.clipin",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/pp19_clipin.wav"
})
sound.Add({
	name 	= 		"bf3_pp19.clipout",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/pp19_clipout.wav"
})
sound.Add({
	name 	= 		"bf3_pp19.boltpull",
	channel = 		CHAN_STATIC,
	volume 	= 		1.0,
	sound 	= 		"bf3/weapons/pp19_boltpull.wav"
})
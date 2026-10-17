// 

$modelname "weapons/c_ak74.mdl"

$bodygroup "sight"
{
	blank
	studio "reflex.smd"
	studio "kobra.smd"
	studio "acog.smd"
	studio "eotech.smd"
}
$bodygroup "barrel"
{
	studio "default.smd"
	studio "muzzle.smd"
	studio "suppressor.smd"
}
$bodygroup "grip"
{
	blank
	studio "grip.smd"
}
$bodygroup "laser"
{
	blank
	studio "laser.smd"
}
$bodygroup "ak74"
{
	studio "ak74.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition -3.27 -7.049 -11.762

$cdmaterials "models\bf3\weapons\rifles\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"reticle"
		"reflex"
		"lens"
		"kobra"
		"acog"
		"reticle_acog"
		"eotech"
		"reticle_eotech"
		"lens_eotech"
		"ak74"
		"muzzle"
		"suppressor"
		"grip"
		"laser"
		"ak74_tape"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 -0 0
$attachment "muzzle_gl" "A_GLMuzzle" 0 0 0 rotate -0 -0 0
$attachment "muzzle_supp" "A_Muzzle_Supp" 0 0 0 rotate -0 -0 0
$attachment "2" "A_Eject" 0 0 -0 rotate -0 -0 0
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 0 0 0 rotate 0 0 0
$attachment "Suppressor" "A_Suppressor" 0 0 0 rotate -0 0 0
$attachment "Modkit" "A_Modkit" 0 0 0 rotate -0 -0 -0
$attachment "Laser" "A_Underbarrel" 0 0 -0 rotate -0 -0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 -0
$attachment "Foregrip" "A_Foregrips" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -15.569 -15.376 -25.946 29.666 8.836 2.422

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -79.749939 -89.999874 -90.000099 0 0 0 0 0 0
$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "(null)" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 3.24214 -0.005069 0.000005 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 6.363438 -0.005069 0 -0 -0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 6.363436 -0.002058 0 -0 -0 0 0 0 0 0 0 0
$definebone "Weapon" "" -2.249564 -11.152735 -2.826391 0 0.010027 0.000115 0 0 0 0 0 0
$definebone "Magazine" "Weapon" 0.008195 0.181844 -2.444005 -0 0 -0 0 0 0 0 0 0
$definebone "Bullets" "Magazine" 0.112215 0.559316 2.399464 -0 0 -0 0 0 0 0 0 0
$definebone "Safety" "Weapon" -0.718951 4.68434 0.03232 -0 0 -0 0 0 0 0 0 0
$definebone "Trigger" "Weapon" -0.001748 3.534093 -0.807314 -0 0 -0 0 0 0 0 0 0
$definebone "Bolt" "Weapon" -0.800971 -1.456638 0.700426 -0 0 -0 0 0 0 0 0 0
$definebone "Magazine Release" "Weapon" 0.002608 1.938277 -1.137029 -0 0 -0 0 0 0 0 0 0
$definebone "A_Eject" "Weapon" -0.5604 0.330936 0.970054 -14.389434 -168.262871 4.06697 0 0 0 0 0 0
$definebone "A_Muzzle" "Weapon" -0.0047 -17.398869 0.33522 -0.000036 -90.000016 90.000016 0 0 0 0 0 0
$definebone "A_Underbarrel" "Weapon" 0.005541 -9.114821 1.174847 -0 -89.999982 -89.999982 0 0 0 0 0 0
$definebone "A_Suppressor" "Weapon" -0.006525 -15.68419 0.287403 -0 179.999964 0 0 0 0 0 0 0
$definebone "A_Optic" "Weapon" 0.006863 2.456758 1.82524 -0 -179.999978 -89.999982 0 0 0 0 0 0
$definebone "A_Modkit" "Weapon" 0.003085 2.456742 1.416514 -0 -179.999964 -89.999982 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "Weapon" -0.0047 -25.968014 0.335223 -0.000036 -90.000016 90.000016 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "Weapon" 0.005541 -9.114821 1.174847 -0.000019 -90.000016 -180.000005 0 0 0 0 0 0
$definebone "A_Foregrips" "Weapon" 0.005373 -4.913064 -0.19399 -0 179.999964 0 0 0 0 0 0 0
$definebone "A_Muzzle_Ironsight" "Weapon" 2.249564 -18.513626 2.82642 -0.000115 -90.000098 0 0 0 0 0 0 0
$definebone "A_GL" "Weapon" 0.000663 -9.800418 0.204282 0 89.999982 89.999982 0 0 0 0 0 0
$definebone "GL_Base" "A_GL" 0 0 -0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Trigger" "GL_Base" 4.033323 -1.616606 -0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Round" "GL_Base" 0.413366 -1.794379 -0 -0 -0 0 0 0 0 0 0 0
$definebone "A_GLMuzzle" "GL_Base" -2.572542 -1.780955 -0 -0.000019 -180.000005 -180.000005 0 0 0 0 0 0

$BoneMerge "ValveBiped.Bip01_Spine4"
$BoneMerge "ValveBiped.Bip01_L_Clavicle"
$BoneMerge "ValveBiped.Bip01_L_UpperArm"
$BoneMerge "ValveBiped.Bip01_L_Forearm"
$BoneMerge "ValveBiped.Bip01_L_Hand"
$BoneMerge "ValveBiped.Bip01_L_Finger4"
$BoneMerge "ValveBiped.Bip01_L_Finger41"
$BoneMerge "ValveBiped.Bip01_L_Finger42"
$BoneMerge "ValveBiped.Bip01_L_Finger3"
$BoneMerge "ValveBiped.Bip01_L_Finger31"
$BoneMerge "ValveBiped.Bip01_L_Finger32"
$BoneMerge "ValveBiped.Bip01_L_Finger2"
$BoneMerge "ValveBiped.Bip01_L_Finger21"
$BoneMerge "ValveBiped.Bip01_L_Finger22"
$BoneMerge "ValveBiped.Bip01_L_Finger1"
$BoneMerge "ValveBiped.Bip01_L_Finger11"
$BoneMerge "ValveBiped.Bip01_L_Finger12"
$BoneMerge "ValveBiped.Bip01_L_Finger0"
$BoneMerge "ValveBiped.Bip01_L_Finger01"
$BoneMerge "ValveBiped.Bip01_L_Finger02"
$BoneMerge "ValveBiped.Bip01_R_Clavicle"
$BoneMerge "ValveBiped.Bip01_R_UpperArm"
$BoneMerge "ValveBiped.Bip01_R_Forearm"
$BoneMerge "ValveBiped.Bip01_R_Hand"
$BoneMerge "ValveBiped.Bip01_R_Finger4"
$BoneMerge "ValveBiped.Bip01_R_Finger41"
$BoneMerge "ValveBiped.Bip01_R_Finger42"
$BoneMerge "ValveBiped.Bip01_R_Finger3"
$BoneMerge "ValveBiped.Bip01_R_Finger31"
$BoneMerge "ValveBiped.Bip01_R_Finger32"
$BoneMerge "ValveBiped.Bip01_R_Finger2"
$BoneMerge "ValveBiped.Bip01_R_Finger21"
$BoneMerge "ValveBiped.Bip01_R_Finger22"
$BoneMerge "ValveBiped.Bip01_R_Finger1"
$BoneMerge "ValveBiped.Bip01_R_Finger11"
$BoneMerge "ValveBiped.Bip01_R_Finger12"
$BoneMerge "ValveBiped.Bip01_R_Finger0"
$BoneMerge "ValveBiped.Bip01_R_Finger01"
$BoneMerge "ValveBiped.Bip01_R_Finger02"
$BoneMerge "ValveBiped.Bip01_L_Ulna"
$BoneMerge "ValveBiped.Bip01_R_Ulna"
$BoneMerge "ValveBiped.Bip01_R_Wrist"
$BoneMerge "ValveBiped.Bip01_L_Wrist"




$sequence "base_idle" {
	"ak74_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "base_draw" {
	"ak74_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "base_fire" {
	"ak74_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "base_reload" {
	"ak74_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 19 "bf3_ak74.clipout" }
	{ event 5004 60 "bf3_ak74.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "base_reloadempty" {
	"ak74_anims/base_reloadempty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 19 "bf3_ak74.clipout" }
	{ event 5004 60 "bf3_ak74.clipin" }
	{ event 5004 104 "bf3_ak74.boltpull" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "foregrip_idle" {
	"ak74_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"ak74_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "foregrip_fire" {
	"ak74_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_reload" {
	"ak74_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 19 "bf3_ak74.clipout" }
	{ event 5004 60 "bf3_ak74.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "foregrip_reload_empty" {
	"ak74_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 19 "bf3_ak74.clipout" }
	{ event 5004 60 "bf3_ak74.clipin" }
	{ event 5004 104 "bf3_ak74.boltpull" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

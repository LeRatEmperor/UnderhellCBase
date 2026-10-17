// 

$modelname "weapons/c_g36c.mdl"

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
$bodygroup "g36c"
{
	studio "g36c.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition -15.245 29.189 -4.52

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
		"g36c"
		"muzzle"
		"suppressor"
		"grip"
		"laser"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 0 0
$attachment "muzzle_supp" "A_Muzzle_Supp" 0 0 0 rotate -0 0 0
$attachment "2" "A_Eject" 0 0 -0 rotate 0 -0 0
$attachment "Suppressor" "A_Suppressor" 0 0 0 rotate -0 -0 -0
$attachment "Laser" "A_Underbarrel" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate 0 0 0
$attachment "Foregrip" "A_Foregrip" -0 0 0 rotate -0 -0 0

$cbox 0 0 0 0 0 0

$bbox -37.732 2.803 -12.341 29.336 73.652 3.147

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -79.749939 -89.999874 -90.000099 0 0 0 0 0 0
$definebone "acr_main" "" -31.07818 57.51207 -3.295033 0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "acr_bolt_release" "acr_main" -0.384193 -2.067762 -0.000006 -0 0 0 0 0 0 0 0 0
$definebone "acr_trigger" "acr_main" -1.921764 -0.937333 -0.00001 -0 0 0 0 0 0 0 0 0
$definebone "A_Optic" "acr_main" -0.028477 2.424619 0.000006 -89.999982 179.999978 0 0 0 0 0 0 0
$definebone "A_Foregrip" "acr_main" 5.834476 -0.939685 0.00001 89.999921 91.548236 0 0 0 0 0 0 0
$definebone "A_Muzzle" "acr_main" 11.438957 0.366893 0.000027 -0 0 0 0 0 0 0 0 0
$definebone "A_Suppressor" "acr_main" 9.623878 0.333447 0.000021 -89.999873 -92.292392 0 0 0 0 0 0 0
$definebone "A_Underbarrel" "acr_main" 7.941658 0.426127 -0.873259 0.002905 179.601272 90.398681 0 0 0 0 0 0
$definebone "A_Eject" "acr_main" 0.493866 0.303905 0.7143 -79.035746 -25.957453 -61.870845 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "acr_main" 16.05632 0.366893 0.000038 -0 0 0 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "acr_main" 7.943981 -0.111292 -0.758898 0.002636 0.398779 -90.398763 0 0 0 0 0 0
$definebone "Magazine" "" -31.065052 56.315331 -5.005428 0 -52.999741 0 0 0 0 0 0 0
$definebone "bullet" "" -31.08181 56.510086 -4.993142 0 -52.999741 0 0 0 0 0 0 0
$definebone "bullet2" "" -30.914131 56.510086 -5.122903 0 -52.999741 0 0 0 0 0 0 0
$definebone "G36_Bolt" "" -31.080494 54.8899 -1.994407 0 -52.999741 0 0 0 0 0 0 0
$definebone "G36_Bolt_End" "" -31.080494 54.628365 -1.994407 0 -52.999741 0 0 0 0 0 0 0

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
	"g36c_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "base_draw" {
	"g36c_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "base_fire" {
	"g36c_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "base_reload" {
	"g36c_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 25 "bf3_g36c.clipout" }
	{ event 5004 91 "bf3_g36c.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

$sequence "base_reloadempty" {
	"g36c_anims/base_reloadempty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 28 "bf3_g36c.clipout" }
	{ event 5004 84 "bf3_g36c.clipin" }
	{ event 5004 109 "bf3_g36c.boltpull" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

$sequence "foregrip_idle" {
	"g36c_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"g36c_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_fire" {
	"g36c_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_reload" {
	"g36c_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 25 "bf3_g36c.clipout" }
	{ event 5004 91 "bf3_g36c.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

$sequence "foregrip_reload_empty" {
	"g36c_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 28 "bf3_g36c.clipout" }
	{ event 5004 84 "bf3_g36c.clipin" }
	{ event 5004 109 "bf3_g36c.boltpull" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

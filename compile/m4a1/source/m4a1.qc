// 

$modelname "weapons/c_m4a1.mdl"

$bodygroup "sight"
{
	studio "sight.smd"
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
$bodygroup "acwr"
{
	studio "acwr.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition 0.398 -13.379 -7.488

$cdmaterials "models\bf3\weapons\rifles\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"m4a1"
		"reticle"
		"reflex"
		"lens"
		"kobra"
		"acog"
		"reticle_acog"
		"eotech"
		"reticle_eotech"
		"lens_eotech"
		"muzzle"
		"suppressor"
		"grip"
		"laser"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 0 0
$attachment "shell" "A_Eject" -0 0 -0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -18.131 -25.058 -17.273 27.956 9.57 4.074

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -79.749939 -89.999874 -90.000099 0 0 0 0 0 0
$definebone "Weapon" "" -2.387503 -15.270334 -5.074594 0 0 0 0 0 0 0 0 0
$definebone "Charging_Handle" "Weapon" 0.066779 8.881084 3.401956 -0 0 0.000057 0 0 0 0 0 0
$definebone "Bolt" "Charging_Handle" -0.095912 -5.251013 -0.854032 -0 -89.999982 0 0 0 0 0 0 0
$definebone "DustCover" "Weapon" -0.665847 3.477695 2.269095 -0 0 0.000057 0 0 0 0 0 0
$definebone "Magazine_Release" "Weapon" -0.006288 4.178158 1.057485 -0 0 0.000057 0 0 0 0 0 0
$definebone "Magazine" "Weapon" 0.037367 2.635598 -1.334266 -0 0 0.000057 0 0 0 0 0 0
$definebone "Bullet" "Magazine" -0.174255 0.505857 3.360352 -0 0 0 0 0 0 0 0 0
$definebone "Bullet_2" "Magazine" 0.014291 0.505857 3.121574 -0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Weapon" 0.040949 6.055264 0.892183 -0 0 0.000057 0 0 0 0 0 0
$definebone "A_Suppressor" "Weapon" 0.016964 -18.515348 2.541246 -0 179.999964 -0.000057 0 0 0 0 0 0
$definebone "A_Muzzle" "Weapon" 0.022494 -19.748304 2.539137 -0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "A_UnderBarrel" "Weapon" -0.91062 -13.172815 2.531399 0.000057 -90.000037 -90.000037 0 0 0 0 0 0
$definebone "Bipod" "A_UnderBarrel" -3.480284 2.046947 0.93866 89.999982 -90.000037 0 0 0 0 0 0 0
$definebone "Bipod_Left" "Bipod" 0.782162 -0.000002 -0.319805 -65.000001 -179.999909 89.999921 0 0 0 0 0 0
$definebone "Bipod_Right" "Bipod" -0.782096 -0.000004 -0.319805 64.999939 179.999841 -90.000153 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "Weapon" -0.950814 -7.898512 2.485385 0.000115 -90.000037 179.999978 0 0 0 0 0 0
$definebone "A_GL" "Weapon" 0.02472 -2.024908 1.422118 0.000057 -90.000037 90.000037 0 0 0 0 0 0
$definebone "GL_Base" "A_GL" 0 -0 -0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Slide" "GL_Base" 1.891411 -1.591587 0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Trigger" "GL_Base" -2.772263 -2.006649 -0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Round" "GL_Base" 3.309917 -1.59422 0.001201 89.999982 89.999982 0 0 0 0 0 0 0
$definebone "GL_Casing" "GL_Base" 4.085115 -1.594219 0.001201 89.999982 89.999982 0 0 0 0 0 0 0
$definebone "M203_Slide_Release" "GL_Base" 4.013391 -0.151551 -0.688799 89.999982 89.999982 0 0 0 0 0 0 0
$definebone "A_Eject" "Weapon" -0.496131 2.887262 2.652126 -24.317246 179.999841 0 0 0 0 0 0 0
$definebone "A_Optic" "Weapon" 0.031988 4.874125 3.698847 -0 179.999964 -90.000037 0 0 0 0 0 0
$definebone "Trigger_m16" "Weapon" 0.040949 5.989647 0.389903 -0 0 0 0 0 0 0 0 0
$definebone "Bipod_Main" "" 8.098196 -21.222406 -0.376701 -26.18136 -38.337234 81.044081 0 0 0 0 0 0
$definebone "A_Bipod" "Bipod_Main" -0.000004 -9.774027 -0.000003 0.000003 0.000005 0 0 0 0 0 0 0
$definebone "Bipod_RightLeg" "Bipod_Main" 0 -1.188227 1.002607 24.963368 93.309441 -88.60202 0 0 0 0 0 0
$definebone "Bipod_LeftLeg" "Bipod_Main" 0.000002 -1.188228 -1.002702 24.963372 -86.69053 -88.601965 0 0 0 0 0 0

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
	"m4a1_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 1
	loop
}

$sequence "base_draw" {
	"m4a1_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "base_fire" {
	"m4a1_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 28
}

$sequence "base_reload" {
	"m4a1_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 15 "bf3_m4a1.clipout" }
	{ event 5004 58 "bf3_m4a1.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "base_reload_empty" {
	"m4a1_anims/base_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 15 "bf3_m4a1.clipout" }
	{ event 5004 62 "bf3_m4a1.clipin" }
	{ event 5004 89 "bf3_m4a1.boltcatch" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "foregrip_idle" {
	"m4a1_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"m4a1_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "foregrip_fire" {
	"m4a1_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 28
}

$sequence "foregrip_reload" {
	"m4a1_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 15 "bf3_m4a1.clipout" }
	{ event 5004 58 "bf3_m4a1.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "foregrip_reload_empty" {
	"m4a1_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 15 "bf3_m4a1.clipout" }
	{ event 5004 62 "bf3_m4a1.clipin" }
	{ event 5004 85 "bf3_m4a1.boltcatch" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

// 

$modelname "weapons/c_l85a2.mdl"

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
$bodygroup "l85"
{
	studio "l85.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition -3.27 165.403 -11.765

$cdmaterials "models\bf3\weapons\rifles\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"l85a2_ironsight"
		"reticle"
		"reflex"
		"lens"
		"kobra"
		"acog"
		"reticle_acog"
		"eotech"
		"reticle_eotech"
		"lens_eotech"
		"l85a2"
		"muzzle"
		"suppressor"
		"grip"
		"laser"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 0 0
$attachment "muzzle_gl" "A_GLMuzzle" 0 0 0 rotate -0 0 0
$attachment "muzzle_supp" "A_Muzzle_Supp" 0 0 0 rotate -0 0 0
$attachment "2" "A_Eject" 0 -0 0 rotate -0 -0 -90
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 0 0 0 rotate -0 0 0
$attachment "camera" "camera" 0 0 0 rotate -0 0 0
$attachment "Suppressor" "A_Suppressor" 0 0 0 rotate -0 0 0
$attachment "Laser" "A_Underbarrel" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 -0
$attachment "Foregrip" "A_Foregrip" 0 0 0 rotate -0 0 0
$attachment "GL" "A_M320" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -359.631 -15.376 -25.946 28.825 8.836 2.416

$definebone "ValveBiped.Bip01_L_Clavicle" "" 3.491543 8.830969 -9.976974 0 0.000057 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853647 -0.000001 0 2.606709 -90.52118 -90.385901 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390535 -0.000002 0.000001 -0 -6.123426 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525425 -0.000002 0 2.753062 3.862882 -91.214711 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555143 0.315172 -0.822494 36.110722 33.914171 115.151566 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556972 0.000002 -0.000002 -0.000005 9.52932 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.22109 -0.000002 0.000001 -0.000012 13.764626 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828093 -0.209482 -1.286462 1.166311 -3.007112 7.059473 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382519 0.000001 0.000004 -0.000003 5.705115 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865905 -0.000001 -0.000003 -0.000003 1.676707 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813033 -0.266274 -0.544265 -0.523171 -4.898962 4.980264 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445751 0 0 -0.000003 8.18986 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053753 -0.000002 0.000002 -0.000003 -1.49399 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.689438 -0.34286 0.236189 -0.363545 -3.72474 7.4665 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439796 -0.000002 -0.000001 -0.000003 3.307803 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.98299 0.000001 -0.000001 -0.000003 -5.220043 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426952 -0.353602 1.013784 -0.774241 -8.678418 5.197188 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104664 0.000001 0 -0.000003 4.531697 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908442 0.000001 -0.000001 -0.000003 -3.232686 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_Forearm" -0 0 0 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217918 -0.000003 0 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217918 -0.000001 -0.000003 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.217917 -0.000001 -0.000004 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217916 0.000002 -0.000001 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.217918 0 -0.000003 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217916 -0.000002 0.000001 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" 0.47538 8.830965 -9.976974 -0.000019 -179.999937 180.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000001 0 -2.606709 -90.52118 90.385901 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.390536 -0.000002 0 -0 -6.123426 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525427 0.000001 0 -2.753062 3.862882 91.214711 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.55514 0.315171 0.822496 -36.110712 33.914171 -115.151566 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556972 0 0 -0.000002 9.529332 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221088 -0.000002 0 -0.000005 13.764635 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828091 -0.209481 1.286462 -1.166311 -3.007112 -7.059472 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382519 0 -0.000002 0.000002 5.70511 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.86591 -0 0.000003 0.000002 1.6767 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813031 -0.266276 0.544264 0.523168 -4.89896 -4.980265 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445755 -0 0 0.000001 8.18986 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.05375 -0 -0.000003 0.000002 -1.493987 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.689442 -0.34286 -0.236188 0.363542 -3.72474 -7.4665 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439795 -0 0.000001 0.000001 3.307801 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.982989 0 0.000002 0.000001 -5.220044 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426953 -0.353604 -1.013783 0.774238 -8.678418 -5.197187 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104666 0 0.000001 -0 4.531694 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908442 -0 0.000002 -0 -3.232686 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_Forearm" 0 0 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217917 0.000002 -0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.217918 -0.000001 -0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217918 0.000002 0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.217916 -0.000001 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.217918 0.000001 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.217916 0 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "(null)" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 3.24214 -0.005069 0.000005 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 6.363438 -0.005069 0 -0 -0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 6.363436 -0.002058 0 -0 -0 0 0 0 0 0 0 0
$definebone "camera" "" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "Weapon" "" -2.71397 -11.7488 -6.30779 0 0 0 0 0 0 0 0 0
$definebone "A_Foregrip" "Weapon" -0.135258 -4.912109 1.37765 -0 0 0 0 0 0 0 0 0
$definebone "Magazine_Release" "Weapon" 0.498615 6.26854 1.64196 -0 0 0 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "Weapon" -0.893094 -7.21595 2.16281 -0 -90.000207 179.999841 0 0 0 0 0 0
$definebone "A_Optic" "Weapon" -0.131894 3.14623 4.27838 -0 179.999841 -90.000207 0 0 0 0 0 0
$definebone "A_Suppressor" "Weapon" -0.129447 -10.783499 2.98325 -0 179.999841 0 0 0 0 0 0 0
$definebone "A_Underbarrel" "Weapon" 0.530026 -6.22208 1.76911 -0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Weapon" 0.040948 -0.153584 1.59313 -0 0 0 0 0 0 0 0 0
$definebone "Magazine" "Weapon" 0 6.3215 0.346421 -0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Weapon" -0.131772 5.50729 3.04994 -0 -90.000207 0 0 0 0 0 0 0
$definebone "A_M320" "Weapon" -0.129112 -6.619169 1.04889 -0 0 0 0 0 0 0 0 0
$definebone "M320_Main" "A_M320" 0 3.600861 -0.705424 -0 0 0 0 0 0 0 0 0
$definebone "M320_Trigger" "M320_Main" 0 -1.401131 -1.11153 -0 0 0 0 0 0 0 0 0
$definebone "M320_Tube_Release" "M320_Main" 0 -2.24341 -1.00813 -0 0 0 0 0 0 0 0 0
$definebone "M320_Tube" "M320_Main" -0.966658 -7.977211 0.071462 -0 0 0 0 0 0 0 0 0
$definebone "M320_Casing" "M320_Tube" 0.966658 6.538799 0.011545 -0 0 0 0 0 0 0 0 0
$definebone "M320_Warhead" "M320_Casing" 0 -1.404539 0 -0 0 0 0 0 0 0 0 0
$definebone "Dust_Cover" "Weapon" -0.749347 8.67001 2.82498 -0 -90.000207 154.999983 0 0 0 0 0 0
$definebone "A_Muzzle_Ironsight" "Weapon" 2.71396 -15.2761 6.30779 -0 -90.000207 0 0 0 0 0 0 0
$definebone "A_Muzzle" "Weapon" -0.127744 -12.9494 2.983 -0 -90.000207 90.000207 0 0 0 0 0 0
$definebone "A_Eject" "Weapon" -0.658979 6.38676 3.01652 -19.683509 -169.372613 86.383704 0 0 0 0 0 0
$definebone "A_GLMuzzle" "Weapon" -0.127744 -12.912199 0.479061 -0 -90.000207 90.000207 0 0 0 0 0 0
$definebone "A_GL" "Weapon" -0.129057 361.431 -20.4314 -0 0 0 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "Weapon" -0.127745 -19.400101 2.983 -0 -90.000207 90.000207 0 0 0 0 0 0
$definebone "FireSelect" "Weapon" 0.458045 9.51827 1.68099 -0 0 0 0 0 0 0 0 0

$BoneMerge "ValveBiped.Bip01_L_Clavicle"
$BoneMerge "ValveBiped.Bip01_L_UpperArm"
$BoneMerge "ValveBiped.Bip01_L_Forearm"
$BoneMerge "ValveBiped.Bip01_L_Hand"
$BoneMerge "ValveBiped.Bip01_L_Finger0"
$BoneMerge "ValveBiped.Bip01_L_Finger01"
$BoneMerge "ValveBiped.Bip01_L_Finger02"
$BoneMerge "ValveBiped.Bip01_L_Finger1"
$BoneMerge "ValveBiped.Bip01_L_Finger11"
$BoneMerge "ValveBiped.Bip01_L_Finger12"
$BoneMerge "ValveBiped.Bip01_L_Finger2"
$BoneMerge "ValveBiped.Bip01_L_Finger21"
$BoneMerge "ValveBiped.Bip01_L_Finger22"
$BoneMerge "ValveBiped.Bip01_L_Finger3"
$BoneMerge "ValveBiped.Bip01_L_Finger31"
$BoneMerge "ValveBiped.Bip01_L_Finger32"
$BoneMerge "ValveBiped.Bip01_L_Finger4"
$BoneMerge "ValveBiped.Bip01_L_Finger41"
$BoneMerge "ValveBiped.Bip01_L_Finger42"
$BoneMerge "ValveBiped.Bip01_R_Clavicle"
$BoneMerge "ValveBiped.Bip01_R_UpperArm"
$BoneMerge "ValveBiped.Bip01_R_Forearm"
$BoneMerge "ValveBiped.Bip01_R_Hand"
$BoneMerge "ValveBiped.Bip01_R_Finger0"
$BoneMerge "ValveBiped.Bip01_R_Finger01"
$BoneMerge "ValveBiped.Bip01_R_Finger02"
$BoneMerge "ValveBiped.Bip01_R_Finger1"
$BoneMerge "ValveBiped.Bip01_R_Finger11"
$BoneMerge "ValveBiped.Bip01_R_Finger12"
$BoneMerge "ValveBiped.Bip01_R_Finger2"
$BoneMerge "ValveBiped.Bip01_R_Finger21"
$BoneMerge "ValveBiped.Bip01_R_Finger22"
$BoneMerge "ValveBiped.Bip01_R_Finger3"
$BoneMerge "ValveBiped.Bip01_R_Finger31"
$BoneMerge "ValveBiped.Bip01_R_Finger32"
$BoneMerge "ValveBiped.Bip01_R_Finger4"
$BoneMerge "ValveBiped.Bip01_R_Finger41"
$BoneMerge "ValveBiped.Bip01_R_Finger42"




$sequence "base_idle" {
	"l85a2_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "base_draw" {
	"l85a2_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "base_fire" {
	"l85a2_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "base_reload" {
	"l85a2_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 22 "bf3_l85a2.clipout" }
	{ event 5004 68 "bf3_l85a2.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "base_reload_empty" {
	"l85a2_anims/base_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 22 "bf3_l85a2.clipout" }
	{ event 5004 73 "bf3_l85a2.clipin" }
	{ event 5004 104 "bf3_l85a2.boltpull" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "foregrip_idle" {
	"l85a2_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"l85a2_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "foregrip_fire" {
	"l85a2_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_reload" {
	"l85a2_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 22 "bf3_l85a2.clipout" }
	{ event 5004 68 "bf3_l85a2.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_reload_empty" {
	"l85a2_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOADEMPTY_FOREGRIP" 1
	{ event 5004 22 "bf3_l85a2.clipout" }
	{ event 5004 73 "bf3_l85a2.clipin" }
	{ event 5004 104 "bf3_l85a2.boltpull" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

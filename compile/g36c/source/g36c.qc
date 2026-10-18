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
// REMOVED: hands bodygroup


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

$definebone "L Clavicle" "" -27.570877 67.798546 -8.338637 6.954563 -0.565452 0 0 0 0 0 0 0
$definebone "L UpperArm" "L Clavicle" 5.853643 -0.000023 -0.000001 19.546799 -97.615103 -38.683818 0 0 0 0 0 0
$definebone "L Forearm" "L UpperArm" 10.39053 0.000044 0.000011 -0.000861 -95.228396 -0.00011 0 0 0 0 0 0
$definebone "L Hand" "L Forearm" 8.525422 0.000004 -0.000061 -19.96959 70.637967 -133.37712 0 0 0 0 0 0
$definebone "L Finger0" "L Hand" 0.555138 0.315182 -0.822497 33.221524 -3.239227 97.515362 0 0 0 0 0 0
$definebone "L Finger01" "L Finger0" 1.556969 0.000011 -0.000008 -2.834376 12.556429 -5.300202 0 0 0 0 0 0
$definebone "L Finger02" "L Finger01" 1.221096 -0.000004 0 0.813881 59.418247 1.803604 0 0 0 0 0 0
$definebone "L Finger1" "L Hand" 2.828079 -0.209492 -1.286466 -19.506004 46.726608 -10.26866 0 0 0 0 0 0
$definebone "L Finger11" "L Finger1" 1.382514 0.000008 -0.000002 2.683671 51.670719 -0.240811 0 0 0 0 0 0
$definebone "L Finger12" "L Finger11" 0.865917 0.000011 0.000003 -0.000004 66.711755 -0.000118 0 0 0 0 0 0
$definebone "L Finger2" "L Hand" 2.813034 -0.266285 -0.544267 -14.897416 57.255973 -15.045122 0 0 0 0 0 0
$definebone "L Finger21" "L Finger2" 1.445755 -0.000008 0.000002 -0.000009 70.987795 -0.000055 0 0 0 0 0 0
$definebone "L Finger22" "L Finger21" 1.053734 0.000002 0.000003 -0.000123 44.019603 0.00011 0 0 0 0 0 0
$definebone "L Finger3" "L Hand" 2.689438 -0.342869 0.236182 -11.272716 57.925298 -17.370013 0 0 0 0 0 0
$definebone "L Finger31" "L Finger3" 1.439797 -0.000004 -0.000003 0.000044 67.471559 -0.000112 0 0 0 0 0 0
$definebone "L Finger32" "L Finger31" 0.982979 -0.000004 0.000002 -0.000182 50.926819 0.000106 0 0 0 0 0 0
$definebone "L Finger4" "L Hand" 2.426952 -0.353611 1.013784 -7.401184 59.206887 -26.365106 0 0 0 0 0 0
$definebone "L Finger41" "L Finger4" 1.104669 0.000011 0.000004 -0.000067 28.815936 0.000176 0 0 0 0 0 0
$definebone "L Finger42" "L Finger41" 0.908451 0 -0.000006 0.00011 77.838038 0.000107 0 0 0 0 0 0
$definebone "L ForeTwist" "L UpperArm" 10.39053 0.000044 0.000011 -0.001491 -95.228396 -6.799002 0 0 0 0 0 0
$definebone "L ForeTwist1" "L ForeTwist" 1.217921 0.000004 -0.000031 0.000801 0.00023 -6.799345 0 0 0 0 0 0
$definebone "L ForeTwist2" "L ForeTwist1" 1.217916 0.000008 -0.000027 0.000454 0.000109 -6.798889 0 0 0 0 0 0
$definebone "L ForeTwist3" "L ForeTwist2" 1.217911 -0.000011 0.000011 -0.000178 -0.000065 -6.79873 0 0 0 0 0 0
$definebone "L ForeTwist4" "L ForeTwist3" 1.217916 0 -0.000004 0.000572 0.000166 -6.799543 0 0 0 0 0 0
$definebone "L ForeTwist5" "L ForeTwist4" 1.217918 0.000003 0.000015 -0.000688 -0.000231 -6.798851 0 0 0 0 0 0
$definebone "L ForeTwist6" "L ForeTwist5" 1.217913 0.000001 0 0.000458 0.000224 -6.799311 0 0 0 0 0 0
$definebone "R Clavicle" "" -30.58704 67.798538 -8.338637 0.218397 90.000016 -180.000005 0 0 0 0 0 0
$definebone "R UpperArm" "R Clavicle" 5.853676 -0.000019 -0.000002 -17.29525 -133.932947 37.453103 0 0 0 0 0 0
$definebone "R Forearm" "R UpperArm" 10.390526 0.000122 -0.000004 0.000063 -115.585816 0.000746 0 0 0 0 0 0
$definebone "R Hand" "R Forearm" 8.525414 0.000088 0.00005 -22.35705 70.598475 142.663677 0 0 0 0 0 0
$definebone "R Finger0" "R Hand" 0.555141 0.315166 0.822495 -8.796623 48.349335 -119.379303 0 0 0 0 0 0
$definebone "R Finger01" "R Finger0" 1.556969 -0.00001 0 28.598388 16.125259 5.747523 0 0 0 0 0 0
$definebone "R Finger02" "R Finger01" 1.2211 -0.000002 -0.000013 -5.455195 71.314401 10.120264 0 0 0 0 0 0
$definebone "R Finger1" "R Hand" 2.828098 -0.20948 1.286459 0.002349 -4.358314 -1.334936 0 0 0 0 0 0
$definebone "R Finger11" "R Finger1" 1.382526 0.000008 -0.000004 0.000001 39.23123 -0.000003 0 0 0 0 0 0
$definebone "R Finger12" "R Finger11" 0.865906 0.000003 -0.000003 1.268933 55.22362 0.424618 0 0 0 0 0 0
$definebone "R Finger2" "R Hand" 2.813026 -0.266277 0.544263 27.061898 58.488904 38.620564 0 0 0 0 0 0
$definebone "R Finger21" "R Finger2" 1.445763 -0.000002 -0.000008 19.550631 70.18824 -12.744111 0 0 0 0 0 0
$definebone "R Finger22" "R Finger21" 1.053739 0.000015 -0.000008 8.337385 67.542634 -9.492363 0 0 0 0 0 0
$definebone "R Finger3" "R Hand" 2.689442 -0.342855 -0.236189 16.749794 62.072069 16.085099 0 0 0 0 0 0
$definebone "R Finger31" "R Finger3" 1.439804 -0.000002 -0.000004 0.075798 56.536829 0.324989 0 0 0 0 0 0
$definebone "R Finger32" "R Finger31" 0.98299 0.000008 0 1.755019 80.244484 -1.377279 0 0 0 0 0 0
$definebone "R Finger4" "R Hand" 2.426968 -0.353603 -1.013785 13.627752 54.920472 21.573458 0 0 0 0 0 0
$definebone "R Finger41" "R Finger4" 1.104668 0.000004 -0.000015 1.690345 31.501044 -0.281551 0 0 0 0 0 0
$definebone "R Finger42" "R Finger41" 0.908447 -0.000011 0.000004 -3.114536 78.89738 -3.947216 0 0 0 0 0 0
$definebone "R ForeTwist" "R UpperArm" 10.390526 0.000122 -0.000004 -0.000569 -115.584614 12.062656 0 0 0 0 0 0
$definebone "R ForeTwist1" "R ForeTwist" 1.217915 -0.000011 -0.000008 -0.001834 -0.000748 12.062429 0 0 0 0 0 0
$definebone "R ForeTwist2" "R ForeTwist1" 1.21793 0.000004 -0.000034 0.000229 -0.000689 12.062258 0 0 0 0 0 0
$definebone "R ForeTwist3" "R ForeTwist2" 1.217911 0.000011 -0.00004 0.001661 -0.000514 12.062489 0 0 0 0 0 0
$definebone "R ForeTwist4" "R ForeTwist3" 1.217915 0.000023 -0.000011 0.0004 0.00086 12.064209 0 0 0 0 0 0
$definebone "R ForeTwist5" "R ForeTwist4" 1.21793 -0.000011 0 -0.001149 -0.000287 12.06123 0 0 0 0 0 0
$definebone "R ForeTwist6" "R ForeTwist5" 1.217926 0.000008 -0.000017 0.001545 -0.000294 12.063984 0 0 0 0 0 0
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



$include "c_arms_definebones.qci"

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

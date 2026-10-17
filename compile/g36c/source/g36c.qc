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

$definebone "ValveBiped.Bip01_L_Clavicle" "" -27.570877 67.798546 -8.338637 91.480562 -73.711880 168.619302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853643 -0.000023 -0.000001 -90.505158 2.738853 -33.527943 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390530 0.000044 0.000011 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525422 0.000004 -0.000061 90.136746 -6.108475 2.532072 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555138 0.315182 -0.822497 -70.054232 -38.916038 -45.195999 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556969 0.000011 -0.000008 0.000000 0.000000 13.093403 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.221096 -0.000004 0.000000 0.000000 0.000000 20.790347 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828079 -0.209492 -1.286466 20.308432 -2.449395 -30.465197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382514 0.000008 -0.000002 0.000000 0.233423 -20.798884 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865917 0.000011 0.000003 0.000000 0.148740 -13.999135 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813034 -0.266285 -0.544267 4.921822 1.250767 -33.682298 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445755 -0.000008 0.000002 0.000000 0.316044 -20.997643 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053734 0.000002 0.000003 0.000000 0.176700 -12.398807 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.689438 -0.342869 0.236182 -8.696353 4.194395 -46.466018 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439797 -0.000004 -0.000003 0.000000 0.000000 -14.197722 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.982979 -0.000004 0.000002 -0.000000 0.000000 -24.683136 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426952 -0.353611 1.013784 -26.822045 8.682201 -50.431573 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104669 0.000011 0.000004 0.000000 0.000000 -25.194100 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908451 0.000000 -0.000006 0.000000 0.000000 -13.997302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_UpperArm" 10.39053 0.000044 0.000011 -0.001491 -95.228396 -6.799002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217921 0.000004 -0.000031 0.000801 0.00023 -6.799345 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217916 0.000008 -0.000027 0.000454 0.000109 -6.798889 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.217911 -0.000011 0.000011 -0.000178 -0.000065 -6.79873 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217916 0 -0.000004 0.000572 0.000166 -6.799543 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.217918 0.000003 0.000015 -0.000688 -0.000231 -6.798851 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217913 0.000001 0 0.000458 0.000224 -6.799311 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" -30.587040 67.798538 -8.338637 -95.596576 73.712052 168.618786 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853676 -0.000019 -0.000002 93.935227 -0.462090 -33.623799 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.390526 0.000122 -0.000004 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525414 0.000088 0.000050 -89.664285 6.108074 2.532072 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.555141 0.315166 0.822495 70.000030 38.596442 -45.467524 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556969 -0.000010 0.000000 0.000000 -0.000000 13.000011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221100 -0.000002 -0.000013 0.000000 0.000000 20.792925 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828098 -0.209480 1.286459 -20.306713 2.209726 -30.481412 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382526 0.000008 -0.000004 0.000000 -0.378897 -20.796649 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.865906 0.000003 -0.000003 0.000000 -0.241273 -13.998046 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813026 -0.266277 0.544263 -4.921994 -1.512838 -33.672443 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445763 -0.000002 -0.000008 0.000000 -0.456877 -20.995236 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053739 0.000015 -0.000008 0.000000 -0.255596 -12.397432 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.689442 -0.342855 -0.236189 8.598836 -4.537310 -46.421327 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439804 -0.000002 -0.000004 0.000000 0.000000 -14.196233 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.982990 0.000008 0.000000 0.000000 0.000000 -24.680787 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426968 -0.353603 -1.013785 26.713355 -9.056515 -50.352963 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104668 0.000004 -0.000015 0.000000 0.000000 -25.191350 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908447 -0.000011 0.000004 -0.000000 0.000000 -13.995697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_UpperArm" 10.390526 0.000122 -0.000004 -0.000569 -115.584614 12.062656 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217915 -0.000011 -0.000008 -0.001834 -0.000748 12.062429 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.21793 0.000004 -0.000034 0.000229 -0.000689 12.062258 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217911 0.000011 -0.00004 0.001661 -0.000514 12.062489 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.217915 0.000023 -0.000011 0.0004 0.00086 12.064209 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.21793 -0.000011 0 -0.001149 -0.000287 12.06123 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.217926 0.000008 -0.000017 0.001545 -0.000294 12.063984 0 0 0 0 0 0
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

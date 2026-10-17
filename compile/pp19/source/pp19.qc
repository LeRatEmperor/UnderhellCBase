// 

$modelname "weapons/c_pp19.mdl"

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
$bodygroup "pp19"
{
	studio "pp19.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition -0.024 -3.1 -6.694

$cdmaterials "models\bf3\weapons\smg\"
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
		"pp19"
		"muzzle"
		"suppressor"
		"pp19_tape"
		"V_hands"
	}
}

$attachment "1" "Muzzle_Flash" 0 0 0 rotate -0 0 0
$attachment "2" "Shell_Eject" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -12.947 -11.067 -13.651 19.148 11.018 0.264

$definebone "BIZON_Body" "" -2.012597 -14.537454 -1.876409 0 0 0 0 0 0 0 0 0
$definebone "BIZON_Magazine" "" -2.012596 -16.605995 -3.392382 0 0 0 0 0 0 0 0 0
$definebone "BIZON_MagRelease" "" -2.012597 -4.368316 -2.462387 0 0 0 0 0 0 0 0 0
$definebone "BIZON_FireSelector" "" -2.012597 -4.402978 -1.853887 0 0 17.999985 0 0 0 0 0 0
$definebone "BIZON_Bolt" "" -2.012597 -4.368316 -2.462387 0 0 0 0 0 0 0 0 0
$definebone "BIZON_Trigger" "" -2.012597 -4.368316 -2.462387 0 0 0 0 0 0 0 0 0
$definebone "BIZON_Bullet" "" -2.012597 -16.605995 -3.392382 0 0 0 0 0 0 0 0 0
$definebone "BIZON_Bullet2" "" -2.012597 -16.605995 -3.733645 0 0 0 0 0 0 0 0 0
$definebone "Muzzle_Flash" "" -2.011627 -18.794914 -2.044978 0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "Shell_Eject" "" -2.111937 -9.65472 -1.634943 -24.999908 179.999937 90.000016 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "" 1.510186 2.670961 -6.828427 91.480562 -73.711880 168.619302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853648 -0.000000 0.000000 -90.505158 2.738853 -33.527943 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 9.961163 0.000000 0.000000 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.503067 0.000000 0.000000 90.136746 -6.108475 2.532072 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.756619 0.677738 -1.164276 -70.054232 -38.916038 -45.195999 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.815094 0.000001 -0.000002 0.000000 0.000000 13.093403 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.031527 -0.000002 0.000000 0.000000 0.000000 20.790347 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.560264 0.118227 -1.221193 20.308432 -2.449395 -30.465197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.161263 0.000001 0.000000 0.000000 0.233423 -20.798884 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.705673 -0.000003 -0.000000 0.000000 0.148740 -13.999135 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.535867 -0.001417 -0.449378 4.921822 1.250767 -33.682298 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.259420 0.000001 0.000000 0.000000 0.316044 -20.997643 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 0.945207 0.000002 -0.000000 0.000000 0.176700 -12.398807 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.379947 -0.050748 0.292731 -8.696353 4.194395 -46.466018 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.267427 -0.000002 0.000000 0.000000 0.000000 -14.197722 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.855790 0.000000 -0.000001 -0.000000 0.000000 -24.683136 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.272117 0.110096 1.013747 -26.822045 8.682201 -50.431573 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 0.753933 0.000000 -0.000000 0.000000 0.000000 -25.194100 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.703494 0.000002 -0.000001 0.000000 0.000000 -13.997302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_UpperArm" 9.961163 0 0 0 -0.729261 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.417176 0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.417181 -0 0 0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.417176 0 0.000001 -0 0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.417179 0 0 0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.417176 -0 0 0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" -1.505977 2.670953 -6.827188 -95.596576 73.712052 168.618786 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000000 0.000000 93.935227 -0.462090 -33.623799 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 9.961161 0.000001 0.000000 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.503067 0.000000 0.000000 -89.664285 6.108074 2.532072 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.756622 0.677738 1.164277 70.000030 38.596442 -45.467524 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.815093 0.000001 0.000000 0.000000 -0.000000 13.000011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.031525 -0.000002 -0.000001 0.000000 0.000000 20.792925 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.560265 0.118225 1.221195 -20.306713 2.209726 -30.481412 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.161268 0.000001 -0.000002 0.000000 -0.378897 -20.796649 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.705667 0.000002 -0.000000 0.000000 -0.241273 -13.998046 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.535858 -0.001417 0.449380 -4.921994 -1.512838 -33.672443 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.259430 0.000002 -0.000000 0.000000 -0.456877 -20.995236 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 0.945208 0.000000 0.000000 0.000000 -0.255596 -12.397432 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.379944 -0.050749 -0.292730 8.598836 -4.537310 -46.421327 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.267437 -0.000002 0.000000 0.000000 0.000000 -14.196233 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.855783 0.000000 -0.000001 0.000000 0.000000 -24.680787 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.272116 0.110096 -1.013745 26.713355 -9.056515 -50.352963 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 0.753940 -0.000001 -0.000000 0.000000 0.000000 -25.191350 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.703498 0.000002 0.000000 -0.000000 0.000000 -13.995697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_UpperArm" 9.961161 0.000001 0 -0 -0.729261 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.417179 0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.41718 0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.417177 -0 0.000001 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.41718 0 -0 0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.417176 0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "BIZON_Rail" "" -2.012597 -8.036591 -1.31326 0 0 0 0 0 0 0 0 0

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




$sequence "idle" {
	"pp19_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 100
	fadeout 0.2
	fps 30
}

$sequence "draw" {
	"pp19_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 100
	snap
	fps 40
}

$sequence "fire" {
	"pp19_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 100
	snap
	fps 30
}

$sequence "reload" {
	"pp19_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 25 "bf3_pp19.clipout" }
	{ event 5004 91 "bf3_pp19.clipin" }
	fadein 0.2
	fadeout 100
	snap
	fps 40
}

$sequence "reload_empty" {
	"pp19_anims/reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 25 "bf3_pp19.clipout" }
	{ event 5004 91 "bf3_pp19.clipin" }
	{ event 5004 133 "bf3_pp19.boltpull" }
	fadein 0.2
	fadeout 100
	snap
	fps 40
}

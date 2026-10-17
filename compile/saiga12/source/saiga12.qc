// 

$modelname "weapons/c_saiga12.mdl"

$bodygroup "saiga12"
{
	studio "saiga12.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition -3.334 5.962 -8.123

$cdmaterials "models\bf3\weapons\shotguns\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"saiga12"
	}
}

$attachment "1" "Muzzle_Flash" 0 0 0 rotate -0 0 0
$attachment "2" "Shell_Ejection" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -6.784 -9.75 -28.585 26.424 8.251 6.986

$hboxset "default"

$definebone "Saiga12k" "" -1.912251 -7.946754 -2.472074 0 0 0 0 0 0 0 0 0
$definebone "Saiga_Bolt" "" -2.02549 -12.156538 -3.311307 0 0 0 0 0 0 0 0 0
$definebone "Saiga_magazine" "" -2.025491 -9.323847 -3.311307 0 0 0 0 0 0 0 0 0
$definebone "Saiga_Shell" "" -4.416613 -10.012898 6.93011 0 0 1.04307 0 0 0 0 0 0
$definebone "Saiga_FireSelector" "" -2.709427 -6.149755 -2.743764 0 0 0 0 0 0 0 0 0
$definebone "Saiga_MagRelease" "" -2.025375 -8.57704 -4.093821 0 0 0 0 0 0 0 0 0
$definebone "Saiga_Trigger" "" -2.025375 -7.35779 -3.32872 0 0 0 0 0 0 0 0 0
$definebone "Muzzle_Flash" "" -2.017735 -24.424179 -2.38531 0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "Shell_Ejection" "" -2.017735 -10.593838 -2.077611 -26.422865 -159.168324 80.389933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01" "" 0 0.000001 -19.912289 0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "ValveBiped.Bip01" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 4.019418 -0.003332 0.000006 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 4.183875 -0.004077 0 -0.023549 -0.039076 0.000057 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 5.120475 -0.002087 0 -0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Neck1" 0.000001 0.002084 1.508082 91.480562 -73.711880 168.619302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853648 -0.000000 0.000000 -90.505158 2.738853 -33.527943 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 9.961164 -0.000000 0.000000 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.503072 0.000000 0.000000 90.136746 -6.108475 2.532072 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.756620 0.677738 -1.164278 -70.054232 -38.916038 -45.195999 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.815094 0.000000 0.000001 0.000000 0.000000 13.093403 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.031525 -0.000002 -0.000003 0.000000 0.000000 20.790347 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.560257 0.118226 -1.221193 20.308432 -2.449395 -30.465197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.161261 0.000000 0.000000 0.000000 0.233423 -20.798884 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.705673 -0.000002 0.000000 0.000000 0.148740 -13.999135 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.535858 -0.001417 -0.449380 4.921822 1.250767 -33.682298 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.259424 0.000001 0.000001 0.000000 0.316044 -20.997643 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 0.945203 -0.000002 -0.000000 0.000000 0.176700 -12.398807 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.379938 -0.050748 0.292730 -8.696353 4.194395 -46.466018 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.267426 0.000000 0.000000 0.000000 0.000000 -14.197722 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.855784 0.000000 -0.000000 -0.000000 0.000000 -24.683136 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.272118 0.110096 1.013748 -26.822045 8.682201 -50.431573 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 0.753933 0.000001 0.000000 0.000000 0.000000 -25.194100 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.703491 -0.000004 0.000000 0.000000 0.000000 -13.997302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_UpperArm" 9.961164 -0 0 -0 -0.726854 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.417176 -0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.417181 -0 0.000001 -0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.417178 0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.417179 -0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.417178 0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Neck1" 0.000001 0.002092 -1.508082 -95.596576 73.712052 168.618786 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000000 0.000000 93.935227 -0.462090 -33.623799 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 9.961167 0.000000 0.000000 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.503076 -0.000000 0.000000 -89.664285 6.108074 2.532072 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.756618 0.677738 1.164277 70.000030 38.596442 -45.467524 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.815093 0.000004 -0.000004 0.000000 -0.000000 13.000011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.031528 -0.000001 0.000001 0.000000 0.000000 20.792925 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.560268 0.118225 1.221195 -20.306713 2.209726 -30.481412 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.161263 0.000000 0.000000 0.000000 -0.378897 -20.796649 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.705671 0.000000 0.000000 0.000000 -0.241273 -13.998046 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.535862 -0.001417 0.449379 -4.921994 -1.512838 -33.672443 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.259428 0.000000 0.000000 0.000000 -0.456877 -20.995236 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 0.945210 0.000000 0.000000 0.000000 -0.255596 -12.397432 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.379951 -0.050748 -0.292730 8.598836 -4.537310 -46.421327 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.267431 0.000000 0.000001 0.000000 0.000000 -14.196233 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.855788 -0.000002 0.000000 0.000000 0.000000 -24.680787 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.272118 0.110096 -1.013746 26.713355 -9.056515 -50.352963 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 0.753937 0.000000 0.000000 0.000000 0.000000 -25.191350 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.703492 0.000000 0.000001 -0.000000 0.000000 -13.995697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_UpperArm" 9.961167 0 0 -0 -0.724963 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.417179 0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.417178 0 0 -0 -0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.417181 0 0 -0 -0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.417179 0 -0 -0 -0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.417177 0 -0 -0 0 -0.006933 0 0 0 0 0 0

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




$sequence "idle1" {
	"saiga12_anims/idle1.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "draw" {
	"saiga12_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 1 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "fire" {
	"saiga12_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload" {
	"saiga12_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 21 "bf3_saiga12.clipout" }
	{ event 5004 75 "bf3_saiga12.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 37
}

$sequence "reload_empty" {
	"saiga12_anims/reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 21 "bf3_saiga12.clipout" }
	{ event 5004 75 "bf3_saiga12.clipin" }
	{ event 5004 103 "bf3_saiga12.boltpull" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 37
}

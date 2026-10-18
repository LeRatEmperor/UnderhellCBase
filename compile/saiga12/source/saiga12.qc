// 

$modelname "weapons/c_saiga12.mdl"

$bodygroup "saiga12"
{
	studio "saiga12.smd"
}
// REMOVED: hands bodygroup


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
$definebone "Bip01" "" 0 0.000001 -19.912289 0 -89.999921 0 0 0 0 0 0 0
$definebone "Bip01 Pelvis" "Bip01" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "Bip01 Spine" "Bip01 Pelvis" 4.019418 -0.003332 0.000006 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "Bip01 Spine1" "Bip01 Spine" 4.183875 -0.004077 0 -0.023549 -0.039076 0.000057 0 0 0 0 0 0
$definebone "Bip01 Neck" "Bip01 Spine1" 5.120475 -0.002087 0 -0 0 0 0 0 0 0 0 0
$definebone "Bip01 L Clavicle" "Bip01 Neck" 0.000001 0.002084 1.508082 -89.999982 179.954366 0 0 0 0 0 0 0
$definebone "Bip01 L UpperArm" "Bip01 L Clavicle" 5.853648 -0 0 -0.106398 -89.622805 -89.845224 0 0 0 0 0 0
$definebone "Bip01 L Forearm" "Bip01 L UpperArm" 9.961164 -0 0 -0 -0.726854 -0 0 0 0 0 0 0
$definebone "Bip01 L Hand" "Bip01 L Forearm" 8.503072 0 0 -0.48266 0.98629 -89.951454 0 0 0 0 0 0
$definebone "Bip01 L Finger0" "Bip01 L Hand" 0.75662 0.677738 -1.164278 26.757083 24.397465 99.663313 0 0 0 0 0 0
$definebone "Bip01 L Finger01" "Bip01 L Finger0" 1.815094 0 0.000001 -0.000002 12.472142 -0.000006 0 0 0 0 0 0
$definebone "Bip01 L Finger02" "Bip01 L Finger01" 1.031525 -0.000002 -0.000003 -0.000002 11.714236 -0.000005 0 0 0 0 0 0
$definebone "Bip01 L Finger1" "Bip01 L Hand" 3.560257 0.118226 -1.221193 3.125714 5.505953 9.66929 0 0 0 0 0 0
$definebone "Bip01 L Finger11" "Bip01 L Finger1" 1.161261 0 0 -0.000001 19.247888 0.000004 0 0 0 0 0 0
$definebone "Bip01 L Finger12" "Bip01 L Finger11" 0.705673 -0.000002 0 -0.000003 24.755392 0.000003 0 0 0 0 0 0
$definebone "Bip01 L Finger2" "Bip01 L Hand" 3.535858 -0.001417 -0.44938 0.556915 9.3195 5.599801 0 0 0 0 0 0
$definebone "Bip01 L Finger21" "Bip01 L Finger2" 1.259424 0.000001 0.000001 -0.000001 30.239928 0.000001 0 0 0 0 0 0
$definebone "Bip01 L Finger22" "Bip01 L Finger21" 0.945203 -0.000002 -0 -0.000001 23.883305 0.000001 0 0 0 0 0 0
$definebone "Bip01 L Finger3" "Bip01 L Hand" 3.379938 -0.050748 0.29273 -3.079077 16.275381 -7.944231 0 0 0 0 0 0
$definebone "Bip01 L Finger31" "Bip01 L Finger3" 1.267426 0 0 0.000003 30.133606 -0.000006 0 0 0 0 0 0
$definebone "Bip01 L Finger32" "Bip01 L Finger31" 0.855784 0 -0 0.000005 25.611948 -0.000003 0 0 0 0 0 0
$definebone "Bip01 L Finger4" "Bip01 L Hand" 3.272118 0.110096 1.013748 -3.90809 22.484523 -10.975865 0 0 0 0 0 0
$definebone "Bip01 L Finger41" "Bip01 L Finger4" 0.753933 0.000001 0 -0.000002 21.277877 -0.000002 0 0 0 0 0 0
$definebone "Bip01 L Finger42" "Bip01 L Finger41" 0.703491 -0.000004 0 -0.000002 17.192298 -0.000003 0 0 0 0 0 0
$definebone "Bip01 L ForeTwist" "Bip01 L UpperArm" 9.961164 -0 0 -0 -0.726854 0.006933 0 0 0 0 0 0
$definebone "Bip01 L ForeTwist1" "Bip01 L ForeTwist" 1.417176 -0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "Bip01 L ForeTwist2" "Bip01 L ForeTwist1" 1.417181 -0 0.000001 -0 -0 0.006933 0 0 0 0 0 0
$definebone "Bip01 L ForeTwist3" "Bip01 L ForeTwist2" 1.417178 0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "Bip01 L ForeTwist4" "Bip01 L ForeTwist3" 1.417179 -0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "Bip01 L ForeTwist5" "Bip01 L ForeTwist4" 1.417178 0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "Bip01 R Clavicle" "Bip01 Neck" 0.000001 0.002092 -1.508082 89.999982 179.954366 0 0 0 0 0 0 0
$definebone "Bip01 R UpperArm" "Bip01 R Clavicle" 5.853648 0 0 0.10743 -89.622573 89.892325 0 0 0 0 0 0
$definebone "Bip01 R Forearm" "Bip01 R UpperArm" 9.961167 0 0 -0 -0.724963 0 0 0 0 0 0 0
$definebone "Bip01 R Hand" "Bip01 R Forearm" 8.503076 -0 0 0.48266 0.985774 89.951454 0 0 0 0 0 0
$definebone "Bip01 R Finger0" "Bip01 R Hand" 0.756618 0.677738 1.164277 -26.757075 24.397453 -99.663313 0 0 0 0 0 0
$definebone "Bip01 R Finger01" "Bip01 R Finger0" 1.815093 0.000004 -0.000004 0.000009 12.472147 0.000002 0 0 0 0 0 0
$definebone "Bip01 R Finger02" "Bip01 R Finger01" 1.031528 -0.000001 0.000001 0.000009 11.71424 0.000003 0 0 0 0 0 0
$definebone "Bip01 R Finger1" "Bip01 R Hand" 3.560268 0.118225 1.221195 -3.125714 5.50595 -9.66929 0 0 0 0 0 0
$definebone "Bip01 R Finger11" "Bip01 R Finger1" 1.161263 0 0 0.000002 19.247879 -0.000001 0 0 0 0 0 0
$definebone "Bip01 R Finger12" "Bip01 R Finger11" 0.705671 0 0 0.000002 24.755384 -0.000002 0 0 0 0 0 0
$definebone "Bip01 R Finger2" "Bip01 R Hand" 3.535862 -0.001417 0.449379 -0.556915 9.319496 -5.599803 0 0 0 0 0 0
$definebone "Bip01 R Finger21" "Bip01 R Finger2" 1.259428 0 0 0 30.239918 -0.000001 0 0 0 0 0 0
$definebone "Bip01 R Finger22" "Bip01 R Finger21" 0.94521 0 0 0 23.883298 -0.000001 0 0 0 0 0 0
$definebone "Bip01 R Finger3" "Bip01 R Hand" 3.379951 -0.050748 -0.29273 3.079076 16.275373 7.944231 0 0 0 0 0 0
$definebone "Bip01 R Finger31" "Bip01 R Finger3" 1.267431 0 0.000001 -0.000003 30.133599 0.000002 0 0 0 0 0 0
$definebone "Bip01 R Finger32" "Bip01 R Finger31" 0.855788 -0.000002 0 -0.000003 25.611939 0.000001 0 0 0 0 0 0
$definebone "Bip01 R Finger4" "Bip01 R Hand" 3.272118 0.110096 -1.013746 3.908089 22.484517 10.975866 0 0 0 0 0 0
$definebone "Bip01 R Finger41" "Bip01 R Finger4" 0.753937 0 0 -0 21.277877 0.000001 0 0 0 0 0 0
$definebone "Bip01 R Finger42" "Bip01 R Finger41" 0.703492 0 0.000001 -0.000003 17.192286 0.000001 0 0 0 0 0 0
$definebone "Bip01 R ForeTwist" "Bip01 R UpperArm" 9.961167 0 0 -0 -0.724963 -0.006933 0 0 0 0 0 0
$definebone "Bip01 R ForeTwist1" "Bip01 R ForeTwist" 1.417179 0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "Bip01 R ForeTwist2" "Bip01 R ForeTwist1" 1.417178 0 0 -0 -0 -0.006933 0 0 0 0 0 0
$definebone "Bip01 R ForeTwist3" "Bip01 R ForeTwist2" 1.417181 0 0 -0 -0 -0.006933 0 0 0 0 0 0
$definebone "Bip01 R ForeTwist4" "Bip01 R ForeTwist3" 1.417179 0 -0 -0 -0 -0.006933 0 0 0 0 0 0
$definebone "Bip01 R ForeTwist5" "Bip01 R ForeTwist4" 1.417177 0 -0 -0 0 -0.006933 0 0 0 0 0 0



$include "c_arms_definebones.qci"

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

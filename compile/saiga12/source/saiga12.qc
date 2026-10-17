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

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -79.749939 -89.999874 -90.000099 0 0 0 0 0 0
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

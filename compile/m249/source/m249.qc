// 

$modelname "weapons/c_m249.mdl"

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
$bodygroup "m249"
{
	studio "m249.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 1.553 -9.278 -8.124

$cdmaterials "models\bf3\weapons\lmg\"
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
		"m249"
		"muzzle"
		"suppressor"
		"m249_bullets"
		"m249_misc"
	}
}

$attachment "1" "a" 0 0 -0 rotate -0 0 0
$attachment "2" "s" 0 0 0 rotate -0 0 -0
$attachment "3" "a" -19 2 -0 rotate 90 -0 -0
$attachment "4" "a" 8 0 -0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -13.187 -12.125 -16.347 31.743 15.23 0.099

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -79.749939 -89.999874 -90.000099 0 0 0 0 0 0
$definebone "body" "" -2.958619 -9.459352 -6.840805 0 -90.000037 89.999982 0 0 0 0 0 0
$definebone "box" "body" 5.435676 0.447883 -0.000001 -0 0 0 0 0 0 0 0 0
$definebone "1" "box" 0.999733 0.774824 -1.723059 11.929357 90.000016 -90.000016 0 0 0 0 0 0
$definebone "2" "1" 0.522316 0 0.000003 0 -0.948532 0.000057 0 0 0 0 0 0
$definebone "3" "2" 0.491262 0.000004 -0.000003 0 -10.174585 0 0 0 0 0 0 0
$definebone "4" "3" 0.511077 0 0 0 -7.931228 0 0 0 0 0 0 0
$definebone "5" "4" 0.464242 0 0 0 -15.160575 0 0 0 0 0 0 0
$definebone "6" "5" 0.474506 0 -0.000003 0 -15.508361 -0 0 0 0 0 0 0
$definebone "7" "6" 0.446314 0.000007 -0.000002 0 -21.084104 -0 0 0 0 0 0 0
$definebone "8" "7" 0.445628 0 -0.000003 0 -15.788653 -0 0 0 0 0 0 0
$definebone "9" "8" 0.462731 -0.000003 -0.000001 0 -6.039547 -0 0 0 0 0 0 0
$definebone "10" "9" 0.401141 0 0 0 -4.19153 -0 0 0 0 0 0 0
$definebone "11" "10" 0.404678 0 0 0 -2.141258 -0 0 0 0 0 0 0
$definebone "bolt" "body" 6.51915 3.386316 2.063232 -0 0 0 0 0 0 0 0 0
$definebone "cover" "body" 7.00328 4.620227 1.473876 -0 0 0 0 0 0 0 0 0
$definebone "a" "body" 21.991043 3.578003 0.446293 -0 0 0 0 0 0 0 0 0
$definebone "s" "body" 4.431913 3.879596 1.795678 -52.140937 52.926576 133.740951 0 0 0 0 0 0
$definebone "handle" "body" 8.509753 4.092883 0.563612 -0 0 0 0 0 0 0 0 0
$definebone "Dummy01" "" -5.566715 7.677234 -6.998626 0 14.371614 0 0 0 0 0 0 0
$definebone "Dummy02" "" 8.390234 -10.286664 -11.630341 61.773617 -86.674418 -43.080066 0 0 0 0 0 0

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
	"m249_anims/idle1.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 35
}

$sequence "draw" {
	"m249_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 32
}

$sequence "fire" {
	"m249_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 38
}

$sequence "reload" {
	"m249_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 23 "bf3_m249.boltpull" }
	{ event 5004 83 "bf3_m249.coverup" }
	{ event 5004 108 "bf3_m249.boxout" }
	{ event 5004 132 "bf3_m249.boxin" }
	{ event 5004 157 "bf3_m249.chain" }
	{ event 5004 190 "bf3_m249.coverdown" }
	fadein 0.2
	fadeout 0.2
	fps 39
}

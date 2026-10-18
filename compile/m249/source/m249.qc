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
$definebone "anim_ValveBiped.Bip01_R_UpperArm" "Dummy01" 0 0 0 0.879548 -130.048414 89.523221 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Forearm" "anim_ValveBiped.Bip01_R_UpperArm" 8.403359 -0.000001 -0.000006 57.996857 0 -0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Hand" "anim_ValveBiped.Bip01_R_Forearm" 8.136633 0.00001 0.000007 -15.230989 0.664173 -90.414233 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger0" "anim_ValveBiped.Bip01_R_Hand" 1.369798 0.361444 1.237273 -3.994946 41.732285 47.434373 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger01" "anim_ValveBiped.Bip01_R_Finger0" 1.320667 -0.000004 0.000002 -3.233035 -23.687432 13.617829 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger02" "anim_ValveBiped.Bip01_R_Finger01" 1.066024 0.000001 -0 -3.220655 -56.748978 5.731305 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger1" "anim_ValveBiped.Bip01_R_Hand" 3.525413 -0.419239 0.94513 -1.253918 -2.589241 90.020718 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger11" "anim_ValveBiped.Bip01_R_Finger1" 1.209884 0 0.000001 24.181101 -1.066332 0.225917 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger12" "anim_ValveBiped.Bip01_R_Finger11" 0.743917 -0 0 65.147704 -10.752242 -6.602988 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger2" "anim_ValveBiped.Bip01_R_Hand" 3.914318 -1.008661 0.216022 0.204775 84.815172 90.988734 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger21" "anim_ValveBiped.Bip01_R_Finger2" 1.491587 -0.000724 0.197241 47.021392 -1.039689 -0.294443 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger22" "anim_ValveBiped.Bip01_R_Finger21" 0.906343 0 0 4.691493 2.610971 0.347327 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger3" "anim_ValveBiped.Bip01_R_Hand" 3.766824 -0.795713 -0.528269 0.892414 93.970269 93.921282 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger31" "anim_ValveBiped.Bip01_R_Finger3" 1.336411 -0.014436 0.211799 29.337507 5.705058 5.630977 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger32" "anim_ValveBiped.Bip01_R_Finger31" 0.919429 0 -0.000001 25.050414 -1.447637 -3.185066 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger4" "anim_ValveBiped.Bip01_R_Hand" 3.438739 -0.444397 -1.217639 1.798801 74.97623 94.641225 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger41" "anim_ValveBiped.Bip01_R_Finger4" 0.919743 -0.008903 0.139835 50.067578 3.572332 5.203717 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger42" "anim_ValveBiped.Bip01_R_Finger41" 0.708997 -0 -0 10.099593 4.014369 -2.248685 0 0 0 0 0 0
$definebone "Dummy02" "" 8.390234 -10.286664 -11.630341 61.773617 -86.674418 -43.080066 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_UpperArm" "Dummy02" 0 0 0 2.671138 -59.599302 -88.011598 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Forearm" "anim_ValveBiped.Bip01_L_UpperArm" 8.403361 0.000003 -0.000006 74.686882 0.000006 0.000006 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Hand" "anim_ValveBiped.Bip01_L_Forearm" 8.136637 -0.000009 0.000004 -41.548369 -4.002613 92.442567 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger0" "anim_ValveBiped.Bip01_L_Hand" 1.369792 -0.361444 1.237273 -34.312712 -19.318997 -83.198869 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger01" "anim_ValveBiped.Bip01_L_Finger0" 1.320669 0 0.000002 -15.337675 1.135949 -12.145445 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger02" "anim_ValveBiped.Bip01_L_Finger01" 1.066031 -0.000001 -0.000002 -6.571588 -4.073442 0.006991 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger3" "anim_ValveBiped.Bip01_L_Hand" 3.289558 0.311003 -0.505976 4.007441 -11.993904 -89.66533 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger31" "anim_ValveBiped.Bip01_L_Finger3" 1.262956 0 -0.000004 4.702156 -3.34401 -4.92348 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger32" "anim_ValveBiped.Bip01_L_Finger31" 0.919428 0.000002 0 25.050294 1.447642 3.185082 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger4" "anim_ValveBiped.Bip01_L_Hand" 3.167419 0.097636 -1.197365 4.976666 -5.526986 -89.948933 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger41" "anim_ValveBiped.Bip01_L_Finger4" 0.817883 -0.000001 0.000001 21.860804 -0.918153 -3.5964 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger42" "anim_ValveBiped.Bip01_L_Finger41" 0.708995 -0.000003 0.000006 10.099584 -4.014428 2.248689 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger2" "anim_ValveBiped.Bip01_L_Hand" 3.414732 0.449904 0.223657 1.008586 -9.195523 -90.047192 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger21" "anim_ValveBiped.Bip01_L_Finger2" 1.390924 0 -0.000002 12.895623 1.039636 0.294457 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger22" "anim_ValveBiped.Bip01_L_Finger21" 0.906347 -0.000002 -0.000004 4.691491 -2.610967 -0.347316 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger1" "anim_ValveBiped.Bip01_L_Hand" 3.525411 0.419243 0.945131 -1.252485 -6.982695 -90.062553 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger11" "anim_ValveBiped.Bip01_L_Finger1" 1.209881 -0.000001 -0.000004 9.297677 1.066277 -0.225902 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger12" "anim_ValveBiped.Bip01_L_Finger11" 0.743919 -0.000002 0.000004 2.941626 5.319517 0.09489 0 0 0 0 0 0

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -90.000153 -79.749996 -89.999924 0 0 0 0 0 0
$BoneMerge "ValveBiped.Bip01_Spine4"
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

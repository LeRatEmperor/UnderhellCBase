// 

$modelname "weapons/c_m82a3.mdl"

$bodygroup "m82a3"
{
	studio "m82a3.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 10.715 3.377 -6.046

$cdmaterials "models\bf3\weapons\sniper\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"m82a3"
		"scope_ballistic"
		"lens"
	}
}

$attachment "1" "1" -37.5 43 0 rotate -0 0 0
$attachment "2" "2" -14 -8 0 rotate -0 90 0

$cbox 0 0 0 0 0 0

$bbox -11.619 -40.188 -11.35 42.258 5.788 1.192

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -79.749939 -89.999874 -90.000099 0 0 0 0 0 0
$definebone "Dummy01" "" -1.860503 11.619324 -8.794808 0 0 0 0 0 0 0 0 0
$definebone "Bone22" "ValveBiped.Bip01_R_Hand" 1.369794 0.361443 1.237272 -2.724472 31.509367 77.632627 0 0 0 0 0 0
$definebone "Bone23" "Bone22" 1.320668 0 -0.000001 -4.683244 -32.535364 13.581211 0 0 0 0 0 0
$definebone "Bone24" "Bone23" 1.066025 0 0 -5.98959 -20.378175 2.708828 0 0 0 0 0 0
$definebone "Bone06" "ValveBiped.Bip01_R_Hand" 3.52541 -0.419245 0.945131 -1.733255 20.622925 88.364138 0 0 0 0 0 0
$definebone "Bone07" "Bone06" 1.209883 -0.000001 0 55.291136 0.629966 2.067576 0 0 0 0 0 0
$definebone "Bone08" "Bone07" 0.743917 0 0 2.941579 -5.31951 -0.094881 0 0 0 0 0 0
$definebone "Bone10" "ValveBiped.Bip01_R_Hand" 3.414729 -0.449904 0.223652 9.885238 68.262898 104.605706 0 0 0 0 0 0
$definebone "Bone11" "Bone10" 1.390921 -0 0 76.82618 -74.856312 -73.774833 0 0 0 0 0 0
$definebone "Bone12" "Bone11" 0.906346 0 0 14.408433 2.610964 0.347329 0 0 0 0 0 0
$definebone "Bone14" "ValveBiped.Bip01_R_Hand" 3.289557 -0.311002 -0.505976 6.86134 68.614817 93.921071 0 0 0 0 0 0
$definebone "Bone15" "Bone14" 1.262953 0 0 78.88975 28.862904 26.352345 0 0 0 0 0 0
$definebone "Bone16" "Bone15" 0.919429 0 0 38.933157 -2.431291 -3.710134 0 0 0 0 0 0
$definebone "Bone18" "ValveBiped.Bip01_R_Hand" 3.167419 -0.097637 -1.197363 -3.533944 70.290843 89.948933 0 0 0 0 0 0
$definebone "Bone19" "Bone18" 0.817884 0.000003 0 71.399027 28.059928 39.795233 0 0 0 0 0 0
$definebone "Bone20" "Bone19" 0.708994 0 0 13.489243 3.877597 -2.276652 0 0 0 0 0 0
$definebone "Dummy02" "" 5.788082 -3.351341 -4.73017 84.499194 -46.066265 -10.451841 0 0 0 0 0 0
$definebone "DrawCall_16" "" -2.544528 -10.799613 -5.260982 0 179.999978 0 0 0 0 0 0 0
$definebone "DrawCall_17" "" -2.550545 -31.909271 -3.806831 0 179.999978 0 0 0 0 0 0 0
$definebone "DrawCall_18" "" -2.54194 -10.996353 -6.6211 0 179.999978 0 0 0 0 0 0 0
$definebone "DrawCall_19" "" -3.727182 -9.918962 -3.679594 0 179.999978 0 0 0 0 0 0 0
$definebone "DrawCall_22" "" -1.135903 -15.039557 -2.588725 0 179.999978 0 0 0 0 0 0 0
$definebone "DrawCall_23" "" -2.550053 -39.608047 -3.737469 0 179.999978 0 0 0 0 0 0 0
$definebone "DrawCall_24" "" -2.48893 -12.358231 -0.822105 0 179.999978 0 0 0 0 0 0 0
$definebone "DrawCall_25" "" -4.732877 -19.088589 -0.127783 0 179.999978 0 0 0 0 0 0 0
$definebone "DrawCall_26" "" -3.638262 -5.91215 -1.239775 0 179.999978 0 0 0 0 0 0 0
$definebone "1" "" -2.515076 -40.187519 -3.865643 0 -89.999982 0 0 0 0 0 0 0
$definebone "2" "" -3.398694 -11.6934 -3.419555 0 179.999964 0 0 0 0 0 0 0

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



$sequence "idle" {
	"m82a3_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire" {
	"m82a3_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

$sequence "draw" {
	"m82a3_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 1 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "reload" {
	"m82a3_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 17 "bf3_m82a3.clipout" }
	{ event 5004 54 "bf3_m82a3.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "reload_empty" {
	"m82a3_anims/reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 17 "bf3_m82a3.clipout" }
	{ event 5004 54 "bf3_m82a3.clipin" }
	{ event 5004 87 "bf3_m82a3.boltpull" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

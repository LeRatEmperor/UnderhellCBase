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
$cdmaterials "models\weapons\v_models\hands\"

$texturegroup "skinfamilies"
{
	{
		"v_hands"
		"m82a3"
		"scope_ballistic"
		"lens"
	}
}

$attachment "1" "1" -37.5 43 0 rotate -0 0 0
$attachment "2" "2" -14 -8 0 rotate -0 90 0

$cbox 0 0 0 0 0 0

$bbox -11.619 -40.188 -11.35 42.258 5.788 1.192

$definebone "Dummy01" "" -1.860503 11.619324 -8.794808 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "Dummy01" 0 0 0 -5.986231 -123.05109 93.094215 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 8.403362 0 -0.000002 55.447131 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.136638 0.000008 0.000005 -19.622153 -7.425992 -86.500528 0 0 0 0 0 0
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
$definebone "ValveBiped.Bip01_L_UpperArm" "Dummy02" 0 -0 0 -4.888702 -49.344558 -93.335505 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 8.40336 0.000001 -0.000002 69.737556 0.000005 -0.000025 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.136637 -0.000008 0.000003 -14.532443 16.563463 76.780479 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 1.369794 -0.361441 1.237271 -26.992085 -23.758663 -83.821605 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.320667 0.000002 -0.000001 -5.53472 -9.664758 3.243804 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.066024 0 0 -6.068833 -6.513718 3.381943 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.289558 0.311003 -0.505977 6.47717 -30.608082 -106.889694 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.262953 -0.000004 -0.000002 64.837217 3.014226 -12.585721 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.919429 0.000002 -0.000001 31.492329 1.867223 3.384102 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.167421 0.097637 -1.197364 3.296741 -45.685482 -113.360206 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 0.817881 0.000001 -0.000002 52.983051 2.985008 -2.490954 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.708995 0.000002 0 19.598692 -3.620217 2.350029 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.414729 0.449903 0.223653 6.343212 -18.887269 -92.241172 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.390923 0.000002 -0.000001 74.791453 -14.353509 -25.144991 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 0.906348 0 0.000001 15.630053 -2.610966 -0.34732 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.525411 0.419244 0.94513 6.883226 -18.176062 -99.951629 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.209885 -0.000003 0.000002 43.169784 15.724357 7.514059 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.743921 -0.000001 0 31.673616 1.015903 1.068509 0 0 0 0 0 0
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

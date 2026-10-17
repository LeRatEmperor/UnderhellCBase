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

$definebone "ValveBiped.Bip01_Spine4" "" 0.000006 3.336140 58.352139 -90.000153 -79.749996 -89.999924 0 0 0 0 0 0
$definebone "Dummy01" "" -1.860503 11.619324 -8.794808 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 6.028143 0.000004 0.000000 93.935227 -0.462090 -33.623799 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.692549 -0.000000 0.000004 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 11.481703 0.000000 -0.000004 -89.664285 6.108074 2.532072 0 0 0 0 0 0
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
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 6.028141 0.000000 0.000000 -90.505158 2.738853 -33.527943 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.692558 -0.000000 0.000000 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 11.481672 -0.000000 -0.000038 90.136746 -6.108475 2.532072 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.806047 -0.348923 1.321258 -70.054232 -38.916038 -45.195999 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.789783 -0.000001 0.000000 0.000000 0.000000 13.093403 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.207001 0.000001 0.000000 0.000000 0.000000 20.790347 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.942322 0.046772 -0.431443 -8.696353 4.194395 -46.466018 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.539089 0.000002 0.000000 0.000000 0.000000 -14.197722 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 1.196323 0.000000 -0.000000 -0.000000 0.000000 -24.683136 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.859701 -0.142406 -1.191974 -26.822045 8.682201 -50.431573 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.312565 -0.000002 0.000000 0.000000 0.000000 -25.194100 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.729362 0.000003 0.000001 0.000000 0.000000 -13.997302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.883686 -0.046768 0.431443 4.921822 1.250767 -33.682298 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.719576 0.000000 0.000000 0.000000 0.316044 -20.997643 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.209183 -0.000004 -0.000000 0.000000 0.176700 -12.398807 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.859858 -0.137947 1.332466 20.308432 -2.449395 -30.465197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.719429 0.000000 0.000001 0.000000 0.233423 -20.798884 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 1.099663 0.000002 0.000000 0.000000 0.148740 -13.999135 0 0 0 0 0 0
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

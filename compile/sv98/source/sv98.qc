// Decompiled from sv98.mdl
$modelname "weapons/c_sv98.mdl"

$bodygroup "sight"
{
	studio "sv98.smd"
}
$bodygroup "barrel"
{
	studio "sv98.smd"
}
$bodygroup "sv98"
{
	studio "sv98.smd"
}

$surfaceprop "default"
$contents "solid"
$illumposition 11.874000 -3.253000 -6.016000

$cdmaterials ""
$cdmaterials ""
$cdmaterials ""



$bbox -7.477000 -28.874001 -11.906000 31.225000 4.231000 1.061000
$cbox 0 0 0 0 0 0

$attachment "muzzle" "Base" -0.000000 1.000000 0.000000 rotate 0.000000 -1.000000 -0.000000
$attachment "ejectbrass" "Base" -0.707107 0.000000 0.707107 rotate 0.000000 -0.000000 -1.000000

$definebone "Base" "" -2.762827 -10.694886 -1.985199 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bolt2" "Base" -0.007069 4.169496 -0.010798 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bolt1" "Bolt2" 0.012820 -1.271972 0.010798 0.000000 -0.029785 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Mag" "Base" 0.005037 0.777761 -1.158804 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-forearm-twist" "ValveBiped.Bip01_L_Forearm" 7.988212 0.070387 -0.005725 0.406260 0.593897 0.354527 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-rist" "ValveBiped.Bip01_R_Forearm" 9.267326 0.012918 -0.047794 -0.288122 -0.158430 0.397488 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-forearm-twist" "ValveBiped.Bip01_R_Forearm" 7.988214 -0.070377 -0.005723 -0.625777 0.353935 -0.582525 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SV" "" -2.726657 -13.699903 -4.063514 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Mesh_0011" "SV" -0.078963 17.931120 0.662951 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

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


$definebone "ValveBiped.Bip01_Spine4" "" 0.000006 3.336140 58.352139 -1.570799 -1.391900 -1.570795 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 2.033348 1.000767 1.937660 1.596637 -1.286515 2.942962 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 6.028141 0.000000 0.000000 -1.579613 0.047802 -0.585173 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.692558 0.000000 0.000000 0.000000 0.000000 -0.060372 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 11.481672 0.000000 0.000000 1.573183 -0.106613 0.044193 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 2.033360 1.000772 -1.937610 -1.668475 1.286518 2.942953 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 6.028143 0.000000 0.000000 1.639479 -0.008065 -0.586846 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.692549 0.000000 0.000000 0.000000 0.000000 -0.060372 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 11.481703 0.000000 0.000000 -1.564937 0.106606 0.044193 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

$sequence "idle" {
	"sv98_anims/idle.smd"
	fps 30
}

$sequence "draw" {
	"sv98_anims/draw.smd"
	fps 30
}

$sequence "fire" {
	"sv98_anims/fire.smd"
	fps 30
}

$sequence "reload" {
	"sv98_anims/reload.smd"
	fps 30
}

$sequence "reload_empty" {
	"sv98_anims/reload_empty.smd"
	fps 30
}


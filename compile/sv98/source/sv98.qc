// 

$modelname "weapons/c_sv98.mdl"

$bodygroup "sight"
{
	blank
	studio "reflex.smd"
	studio "kobra.smd"
	studio "acog.smd"
	studio "eotech.smd"
	studio "scope.smd"
}
$bodygroup "barrel"
{
	studio "default.smd"
	blank
	studio "suppressor.smd"
}
$bodygroup "sv98"
{
	studio "sv98.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -3.253 -11.874 -6.016

$cdmaterials "models\bf3\weapons\sniper\"
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
		"scope_ballistic"
		"sv98"
		"suppressor"
	}
}

$attachment "muzzle" "Base" 0 -20.5 0 rotate -0 -90 0
$attachment "ejectbrass" "Base" 0 0 0 rotate -45 -180 0

$cbox 0 0 0 0 0 0

$bbox -7.477 -28.874 -11.906 31.225 4.231 1.061

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -79.749939 -89.999874 -90.000099 0 0 0 0 0 0
$definebone "Base" "" -2.762827 -10.694886 -1.985199 0 0 0 0 0 0 0 0 0
$definebone "Bolt2" "Base" -0.007069 4.169496 -0.010798 -0 0 0 0 0 0 0 0 0
$definebone "Bolt1" "Bolt2" 0.01282 -1.271972 0.010798 -3.413568 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" 0.005037 0.777761 -1.158804 -0 0 0 0 0 0 0 0 0
$definebone "l-upperarm-movement" "" 2.442776 -0.684586 -5.344038 -0.581953 -89.899141 -60.09393 0 0 0 0 0 0
$definebone "lwrist" "ValveBiped.Bip01_L_Forearm" 9.267328 -0.012908 -0.047794 -15.152834 -36.397593 -20.801234 0 0 0 0 0 0
$definebone "l-forearm-twist" "ValveBiped.Bip01_L_Forearm" 7.988212 0.070387 -0.005725 24.909903 87.270297 92.244608 0 0 0 0 0 0
$definebone "r-upperarm-movement" "" -3.0789 7.479184 -4.11096 -0.633347 -90.622731 21.494798 0 0 0 0 0 0
$definebone "r-rist" "ValveBiped.Bip01_R_Forearm" 9.267326 0.012918 -0.047794 -2.429797 50.626158 -38.327668 0 0 0 0 0 0
$definebone "r-forearm-twist" "ValveBiped.Bip01_R_Forearm" 7.988214 -0.070377 -0.005723 -27.427832 -85.425538 -92.178027 0 0 0 0 0 0
$definebone "SV" "" -2.726657 -13.699903 -4.063514 0 0 0 0 0 0 0 0 0
$definebone "Mesh_0011" "SV" -0.078963 17.93112 0.662951 -0 0 0 0 0 0 0 0 0

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
	"sv98_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "draw" {
	"sv98_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire" {
	"sv98_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event 5004 16 "bf3_sv98.boltback" }
	{ event 5004 25 "bf3_sv98.boltforward" }
	fadein 0
	fadeout 0.2
	fps 30
}

$sequence "reload" {
	"sv98_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 23 "bf3_sv98.clipout" }
	{ event 5004 62 "bf3_sv98.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "reload_empty" {
	"sv98_anims/reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 23 "bf3_sv98.clipout" }
	{ event 5004 62 "bf3_sv98.clipin" }
	{ event 5004 89 "bf3_sv98.boltback" }
	{ event 5004 96 "bf3_sv98.boltforward" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

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

$definebone "ValveBiped.Bip01_Spine4" "" 0.000006 3.336140 58.352139 -90.000153 -79.749996 -89.999924 0 0 0 0 0 0
$definebone "Base" "" -2.762827 -10.694886 -1.985199 0 0 0 0 0 0 0 0 0
$definebone "Bolt2" "Base" -0.007069 4.169496 -0.010798 -0 0 0 0 0 0 0 0 0
$definebone "Bolt1" "Bolt2" 0.01282 -1.271972 0.010798 -3.413568 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" 0.005037 0.777761 -1.158804 -0 0 0 0 0 0 0 0 0
$definebone "l-upperarm-movement" "" 2.442776 -0.684586 -5.344038 -0.581953 -89.899141 -60.09393 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 6.028141 0.000000 0.000000 -90.505158 2.738853 -33.527943 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.692558 -0.000000 0.000000 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "lwrist" "ValveBiped.Bip01_L_Forearm" 9.267328 -0.012908 -0.047794 -15.152834 -36.397593 -20.801234 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.859858 -0.137947 1.332466 20.308432 -2.449395 -30.465197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.719429 0.000000 0.000001 0.000000 0.233423 -20.798884 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 1.099663 0.000002 0.000000 0.000000 0.148740 -13.999135 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.883686 -0.046768 0.431443 4.921822 1.250767 -33.682298 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.719576 0.000000 0.000000 0.000000 0.316044 -20.997643 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.209183 -0.000004 -0.000000 0.000000 0.176700 -12.398807 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.942322 0.046772 -0.431443 -8.696353 4.194395 -46.466018 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.539089 0.000002 0.000000 0.000000 0.000000 -14.197722 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 1.196323 0.000000 -0.000000 -0.000000 0.000000 -24.683136 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.859701 -0.142406 -1.191974 -26.822045 8.682201 -50.431573 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.312565 -0.000002 0.000000 0.000000 0.000000 -25.194100 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.729362 0.000003 0.000001 0.000000 0.000000 -13.997302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.806047 -0.348923 1.321258 -70.054232 -38.916038 -45.195999 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.789783 -0.000001 0.000000 0.000000 0.000000 13.093403 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.207001 0.000001 0.000000 0.000000 0.000000 20.790347 0 0 0 0 0 0
$definebone "l-forearm-twist" "ValveBiped.Bip01_L_Forearm" 7.988212 0.070387 -0.005725 24.909903 87.270297 92.244608 0 0 0 0 0 0
$definebone "r-upperarm-movement" "" -3.0789 7.479184 -4.11096 -0.633347 -90.622731 21.494798 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 6.028143 0.000004 0.000000 93.935227 -0.462090 -33.623799 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.692549 -0.000000 0.000004 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "r-rist" "ValveBiped.Bip01_R_Forearm" 9.267326 0.012918 -0.047794 -2.429797 50.626158 -38.327668 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.859829 -0.148937 -1.331282 -20.306713 2.209726 -30.481412 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.719431 -0.000008 0.000000 0.000000 -0.378897 -20.796649 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 1.099663 0.000000 0.000000 0.000000 -0.241273 -13.998046 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.859674 -0.132568 1.193107 26.713355 -9.056515 -50.352963 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.312565 -0.000004 0.000001 0.000000 0.000000 -25.191350 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.729370 0.000004 -0.000001 -0.000000 0.000000 -13.995697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.883656 -0.050331 -0.431043 -4.921994 -1.512838 -33.672443 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.719574 -0.000008 0.000000 0.000000 -0.456877 -20.995236 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.209179 0.000000 -0.000000 0.000000 -0.255596 -12.397432 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.942293 0.050327 0.431043 8.598836 -4.537310 -46.421327 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.539097 0.000004 -0.000001 0.000000 0.000000 -14.196233 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 1.196323 0.000000 0.000000 0.000000 0.000000 -24.680787 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.806017 -0.359833 -1.318334 70.000030 38.596442 -45.467524 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.789783 0.000000 0.000000 0.000000 -0.000000 13.000011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.207001 0.000002 -0.000002 0.000000 0.000000 20.792925 0 0 0 0 0 0
$definebone "r-forearm-twist" "ValveBiped.Bip01_R_Forearm" 7.988214 -0.070377 -0.005723 -27.427832 -85.425538 -92.178027 0 0 0 0 0 0
$definebone "SV" "" -2.726657 -13.699903 -4.063514 0 0 0 0 0 0 0 0 0
$definebone "Mesh_0011" "SV" -0.078963 17.93112 0.662951 -0 0 0 0 0 0 0 0 0



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

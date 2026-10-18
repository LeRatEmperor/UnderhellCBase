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

$definebone "Base" "" -2.762827 -10.694886 -1.985199 0 0 0 0 0 0 0 0 0
$definebone "Bolt2" "Base" -0.007069 4.169496 -0.010798 -0 0 0 0 0 0 0 0 0
$definebone "Bolt1" "Bolt2" 0.01282 -1.271972 0.010798 -3.413568 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" 0.005037 0.777761 -1.158804 -0 0 0 0 0 0 0 0 0
$definebone "l-upperarm-movement" "" 2.442776 -0.684586 -5.344038 -0.581953 -89.899141 -60.09393 0 0 0 0 0 0
$definebone "l-upperarm" "l-upperarm-movement" 0 0 0 15.173748 43.845655 -169.436735 0 0 0 0 0 0
$definebone "l-forearm" "l-upperarm" 9.051079 -0.000001 -0.000007 0.511012 103.048813 15.758582 0 0 0 0 0 0
$definebone "lwrist" "l-forearm" 9.267328 -0.012908 -0.047794 -15.152834 -36.397593 -20.801234 0 0 0 0 0 0
$definebone "l-index-low" "lwrist" 3.720291 0.080502 -0.994914 -10.192334 -1.866798 86.231712 0 0 0 0 0 0
$definebone "l-index-mid" "l-index-low" 1.279286 0.000002 -0 45.427827 0.610255 0.466708 0 0 0 0 0 0
$definebone "l-index-tip" "l-index-mid" 0.769876 0.000001 0.000003 73.089636 0.331837 0.311768 0 0 0 0 0 0
$definebone "l-middle-low" "lwrist" 3.819602 -0.171115 -0.271817 -6.547531 33.313322 55.20496 0 0 0 0 0 0
$definebone "l-middle-mid" "l-middle-low" 1.425531 0.000004 -0.000003 82.264417 6.233639 6.127528 0 0 0 0 0 0
$definebone "l-middle-tip" "l-middle-mid" 0.831717 0.000002 0 -21.295712 -1.692222 1.931107 0 0 0 0 0 0
$definebone "l-ring-low" "lwrist" 3.610806 -0.040065 0.504235 4.104832 44.437402 46.654826 0 0 0 0 0 0
$definebone "l-ring-mid" "l-ring-low" 1.310056 -0.000002 0 70.20188 5.799244 5.112058 0 0 0 0 0 0
$definebone "l-ring-tip" "l-ring-mid" 0.866592 0.000007 0.000001 -18.593257 1.48576 0.765829 0 0 0 0 0 0
$definebone "l-pinky-low" "lwrist" 3.227354 0.282462 1.200264 19.513265 49.702375 36.885955 0 0 0 0 0 0
$definebone "l-pinky-mid" "l-pinky-low" 0.998019 0.000001 -0.000017 59.397791 10.957425 9.492059 0 0 0 0 0 0
$definebone "l-pinky-tip" "l-pinky-mid" 0.721984 0 0.000001 -11.981471 1.510099 0.38715 0 0 0 0 0 0
$definebone "l-thumb-low" "lwrist" 0.992898 0.88623 -0.993035 17.234283 -1.818452 -177.547762 0 0 0 0 0 0
$definebone "l-thumb-mid" "l-thumb-low" 1.656128 -0.000001 0 -2.568566 -6.233666 -1.829608 0 0 0 0 0 0
$definebone "l-thumb-tip" "l-thumb-mid" 1.015349 0.000003 0.000001 -9.983779 0.3581 -1.619906 0 0 0 0 0 0
$definebone "l-forearm-twist" "l-forearm" 7.988212 0.070387 -0.005725 24.909903 87.270297 92.244608 0 0 0 0 0 0
$definebone "r-upperarm-movement" "" -3.0789 7.479184 -4.11096 -0.633347 -90.622731 21.494798 0 0 0 0 0 0
$definebone "r-upperarm" "r-upperarm-movement" 0 -0 0 11.162991 -68.086877 178.513783 0 0 0 0 0 0
$definebone "r-forearm" "r-upperarm" 9.051083 0.000005 -0.000006 0.431257 -118.466872 -15.969022 0 0 0 0 0 0
$definebone "r-rist" "r-forearm" 9.267326 0.012918 -0.047794 -2.429797 50.626158 -38.327668 0 0 0 0 0 0
$definebone "r-index-low" "r-rist" 3.720295 -0.080503 -0.994916 -0.250619 -13.871529 -80.209391 0 0 0 0 0 0
$definebone "r-index-mid" "r-index-low" 1.279294 0 0 33.276917 -0.432986 -0.096779 0 0 0 0 0 0
$definebone "r-index-tip" "r-index-mid" 0.769872 0 0.000003 44.977629 -0.097741 -0.009634 0 0 0 0 0 0
$definebone "r-pinky-low" "r-rist" 3.227356 -0.282463 1.200263 18.802647 -69.633799 -63.251725 0 0 0 0 0 0
$definebone "r-pinky-mid" "r-pinky-low" 0.998023 0 -0.000012 32.010532 -5.788301 -5.685702 0 0 0 0 0 0
$definebone "r-pinky-tip" "r-pinky-mid" 0.721982 -0.000002 -0.000001 46.317453 -1.707113 -0.396217 0 0 0 0 0 0
$definebone "r-middle-low" "r-rist" 3.819603 0.171115 -0.271819 1.19869 -80.653497 -62.165178 0 0 0 0 0 0
$definebone "r-middle-mid" "r-middle-low" 1.425537 0.000001 -0.000001 58.433607 -1.511621 -1.585618 0 0 0 0 0 0
$definebone "r-middle-tip" "r-middle-mid" 0.831716 0 0 48.64153 -1.054638 -2.72379 0 0 0 0 0 0
$definebone "r-ring-low" "r-rist" 3.610808 0.040063 0.504234 9.866797 -83.728796 -61.803855 0 0 0 0 0 0
$definebone "r-ring-mid" "r-ring-low" 1.310058 0.000002 0.000001 44.997631 -2.723949 -2.455529 0 0 0 0 0 0
$definebone "r-ring-tip" "r-ring-mid" 0.8666 -0.000008 0 61.619583 -1.877968 -0.740903 0 0 0 0 0 0
$definebone "r-thumb-low" "r-rist" 0.992896 -0.88623 -0.993032 24.452921 -19.75478 167.541248 0 0 0 0 0 0
$definebone "r-thumb-mid" "r-thumb-low" 1.656127 0.000004 0 29.215639 7.338488 2.0944 0 0 0 0 0 0
$definebone "r-thumb-tip" "r-thumb-mid" 1.015355 -0.000005 0.000001 39.502061 1.238328 2.067805 0 0 0 0 0 0
$definebone "r-forearm-twist" "r-forearm" 7.988214 -0.070377 -0.005723 -27.427832 -85.425538 -92.178027 0 0 0 0 0 0
$definebone "SV" "" -2.726657 -13.699903 -4.063514 0 0 0 0 0 0 0 0 0
$definebone "Mesh_0011" "SV" -0.078963 17.93112 0.662951 -0 0 0 0 0 0 0 0 0



$include "c_arms_definebones.qci"

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

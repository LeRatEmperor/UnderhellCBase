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

$cdmaterials "models/bf3/weapons/sniper/"
$cdmaterials "models/bf3/weapons/att/"

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
$attachment "ejectbrass" "Base" 0 0 0 rotate -45 180 0

$cbox 0 0 0 0 0 0

$bbox -7.477 -28.874 -11.906 31.225 4.231 1.061

$definebone "Base" "" -2.762827 -10.694886 -1.985199 -0 0 0 0 0 0 0 0 0
$definebone "Bolt2" "Base" -0.007069 4.169496 -0.010798 -0 0 0 0 0 0 0 0 0
$definebone "Bolt1" "Bolt2" 0.01282 -1.271972 0.010798 -3.413568 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" 0.005037 0.777761 -1.158804 -0 0 0 0 0 0 0 0 0
$definebone "l-upperarm-movement" "" 2.442776 -0.684586 -5.344038 -0.581953 -89.899141 -60.093924 0 0 0 0 0 0
$definebone "lwrist" "" 9.267328 -0.012908 -0.047794 -15.152843 -36.397603 -20.801234 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "lwrist" 3.720291 0.080503 -0.994914 -10.192343 -1.866812 86.231698 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.279287 0.000002 0.000001 45.427827 0.610256 0.466715 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.769876 0.000001 0.000003 73.089615 0.331935 0.311659 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "lwrist" 3.819602 -0.171114 -0.271817 -6.547531 33.313309 55.204936 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.42553 0.000004 -0.000003 82.264403 6.233849 6.127396 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 0.831717 0.000002 -0.000002 -21.295703 -1.692198 1.931095 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "lwrist" 3.610806 -0.040065 0.504235 4.104838 44.437405 46.654809 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.310056 -0.000002 -0 70.201859 5.799325 5.111975 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.866592 0.000008 -0.000001 -18.593307 1.485776 0.765816 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "lwrist" 3.227355 0.282463 1.200264 19.51327 49.702375 36.885938 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 0.998019 0.000001 -0.000017 59.397763 10.957438 9.492068 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.721984 0 0.000003 -11.981496 1.510114 0.387168 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "lwrist" 0.992899 0.886231 -0.993035 17.234282 -1.818452 -177.547762 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.656128 -0.000001 -0 -2.568571 -6.233673 -1.829614 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.015348 0.000003 0.000001 -9.983789 0.358098 -1.619902 0 0 0 0 0 0
$definebone "l-forearm-twist" "" 7.988212 0.070387 -0.005725 24.909903 87.270297 92.244608 0 0 0 0 0 0
$definebone "r-upperarm-movement" "" -3.0789 7.479184 -4.11096 -0.633347 -90.622725 21.494797 0 0 0 0 0 0
$definebone "r-rist" "" 9.267326 0.012918 -0.047794 -2.429799 50.626148 -38.327668 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "r-rist" 3.720295 -0.080504 -0.994917 -0.250612 -13.871535 -80.209398 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.279293 -0 0 33.276897 -0.432993 -0.096757 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.769872 -0 0.000003 44.977632 -0.097775 -0.009603 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "r-rist" 3.227356 -0.282463 1.200263 18.80263 -69.633772 -63.251725 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 0.998024 0 -0.000011 32.010525 -5.788319 -5.685686 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.721982 -0.000002 0 46.317463 -1.707138 -0.396217 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "r-rist" 3.819603 0.171116 -0.27182 1.198685 -80.65349 -62.165178 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.425538 0.000001 -0 58.4336 -1.511651 -1.585591 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 0.831716 0 0.000001 48.641534 -1.054645 -2.723795 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "r-rist" 3.610808 0.040063 0.504234 9.866785 -83.728776 -61.803861 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.310057 0.000004 0.000001 44.997645 -2.723966 -2.455514 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.8666 -0.000009 0.000001 61.619576 -1.877999 -0.740898 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "r-rist" 0.992896 -0.88623 -0.993032 24.452917 -19.75478 167.541194 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.656125 0.000003 -0 29.215632 7.338487 2.094387 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.015353 -0.000005 0.000001 39.502047 1.238321 2.067795 0 0 0 0 0 0
$definebone "r-forearm-twist" "" 7.988214 -0.070377 -0.005723 -27.42783 -85.425531 -92.178027 0 0 0 0 0 0
$definebone "SV" "" -2.726657 -13.699903 -4.063514 0 0 0 0 0 0 0 0 0
$definebone "Mesh_0011" "SV" -0.078963 17.93112 0.662951 -0 0 0 0 0 0 0 0 0
$definebone "" "" 0 0 0 0 0 0 0 0 0 0 0 0

$bonemerge "lwrist"
$bonemerge "ValveBiped.Bip01_L_Finger1"
$bonemerge "ValveBiped.Bip01_L_Finger11"
$bonemerge "ValveBiped.Bip01_L_Finger12"
$bonemerge "ValveBiped.Bip01_L_Finger2"
$bonemerge "ValveBiped.Bip01_L_Finger21"
$bonemerge "ValveBiped.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger3"
$bonemerge "ValveBiped.Bip01_L_Finger31"
$bonemerge "ValveBiped.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger4"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "ValveBiped.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger02"
$bonemerge "r-rist"
$bonemerge "ValveBiped.Bip01_R_Finger1"
$bonemerge "ValveBiped.Bip01_R_Finger11"
$bonemerge "ValveBiped.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger4"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "ValveBiped.Bip01_R_Finger42"
$bonemerge "ValveBiped.Bip01_R_Finger2"
$bonemerge "ValveBiped.Bip01_R_Finger21"
$bonemerge "ValveBiped.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger3"
$bonemerge "ValveBiped.Bip01_R_Finger31"
$bonemerge "ValveBiped.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_R_Finger0"
$bonemerge "ValveBiped.Bip01_R_Finger01"
$bonemerge "ValveBiped.Bip01_R_Finger02"


$sequence "idle" {
	"c_sv98_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "draw" {
	"c_sv98_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire" {
	"c_sv98_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event 5004 16 "bf3_sv98.boltback" }
	{ event 5004 25 "bf3_sv98.boltforward" }
	fadein 0
	fadeout 0.2
	fps 30
}

$sequence "reload" {
	"c_sv98_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 23 "bf3_sv98.clipout" }
	{ event 5004 62 "bf3_sv98.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "reload_empty" {
	"c_sv98_anims/reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 23 "bf3_sv98.clipout" }
	{ event 5004 62 "bf3_sv98.clipin" }
	{ event 5004 89 "bf3_sv98.boltback" }
	{ event 5004 96 "bf3_sv98.boltforward" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

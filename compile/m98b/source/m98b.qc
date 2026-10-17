// 

$modelname "weapons/c_m98b.mdl"

$bodygroup "sight"
{
	studio "sight.smd"
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
$bodygroup "m98b"
{
	studio "m98b.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition -0.836 -14.927 -5.726

$cdmaterials "models\bf3\weapons\sniper\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"m98b_sight"
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
		"m98b"
		"suppressor"
	}
}

$attachment "1" "Muzzle_Flash_1" 0 0 0 rotate -0 0 0
$attachment "2" "Shell_Ejection" 0 0 0 rotate 0 180 -180

$cbox 0 0 0 0 0 0

$bbox -9.198 -9.953 -12.186 39.052 8.282 0.733

$hboxset "default"

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -79.749939 -89.999874 -90.000099 0 0 0 0 0 0
$definebone "M98_Body" "" -2.190128 -20.547756 -2.763069 0 0 0 0 0 0 0 0 0
$definebone "M98_Magazine" "" -2.195648 -11.891459 -4.929236 0 0 0 0 0 0 0 0 0
$definebone "M98_Trigger" "" -2.190128 -20.547756 -2.763069 0 0 0 0 0 0 0 0 0
$definebone "M98_BoltHandle" "" -2.190128 -20.547756 -2.763069 0 0 0 0 0 0 0 0 0
$definebone "Muzzle_Flash_1" "" -2.18981 -37.075294 -2.70611 0 -90.000037 89.999982 0 0 0 0 0 0
$definebone "Shell_Ejection" "" -2.625289 -11.769227 -2.538591 18.826194 5.713078 -89.999982 0 0 0 0 0 0
$definebone "Bip01 L Arm" "" 1.510186 2.670961 -6.828427 0.004125 0 -0.039076 0 0 0 0 0 0
$definebone "Bip01 L Arm1" "Bip01 L Arm" 5.853648 -0 0 -0.104221 -89.622805 -89.845224 0 0 0 0 0 0
$definebone "Bip01 L Arm2" "Bip01 L Arm1" 9.961161 0 0 0 -0.729261 0 0 0 0 0 0 0
$definebone "Bip01 R Arm" "" -1.505977 2.670953 -6.827188 -0.042972 -179.999677 -179.96095 0 0 0 0 0 0
$definebone "Bip01 R Arm1" "Bip01 R Arm" 5.853648 0 0 0.103935 -89.622518 89.892325 0 0 0 0 0 0
$definebone "Bip01 R Arm2" "Bip01 R Arm1" 9.961164 0.000001 0 -0 -0.729261 -0 0 0 0 0 0 0

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
	"m98b_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "draw" {
	"m98b_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "fire" {
	"m98b_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event 5004 30 "bf3_m98b.boltback" }
	{ event 5004 42 "bf3_m98b.boltforward" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload" {
	"m98b_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 40 "bf3_m98b.clipout" }
	{ event 5004 78 "bf3_m98b.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload_empty" {
	"m98b_anims/reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 40 "bf3_m98b.clipout" }
	{ event 5004 78 "bf3_m98b.clipin" }
	{ event 5004 129 "bf3_m98b.boltback" }
	{ event 5004 150 "bf3_m98b.boltforward" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

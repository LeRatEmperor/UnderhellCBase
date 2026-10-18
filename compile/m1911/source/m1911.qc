// 

$modelname "weapons/c_m1911.mdl"

$bodygroup "m9"
{
	studio "m9.smd"
}
$bodygroup "suppressor"
{
	blank
	blank
	studio "suppressor.smd"
}


$surfaceprop "default"

$include "c_arms_definebones.qci"

$contents "solid"

$illumposition 0.611 -4.412 -13.339

$cdmaterials "models\bf3\weapons\pistols\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"m1911"
		"suppressor_pistol"
	}
}

$attachment "1" "muzzle_flash" 0.2 -0.04 -0.01 rotate -0 -0 0
$attachment "2" "shell_ejection" -0 0 0 rotate -0 30 0

$cbox 0 0 0 0 0 0

$bbox -8.894 -7.609 -25.946 17.717 8.831 -0.732

$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "(null)" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 5.461617 6.827055 -1.983477 0.044404 0.000115 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 6.236319 -0.006065 0 0.017475 -0.003495 -22.620775 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 6.363842 -0.001061 0.000014 -0 -0 0.000005 0 0 0 0 0 0
$definebone "usp_main" "" -2.536746 -12.163893 -2.335202 0 -90.002502 90.000037 0 0 0 0 0 0
$definebone "usp_barrel" "usp_main" 2.083984 0.616699 0 -0 3.430012 0 0 0 0 0 0 0
$definebone "muzzle_flash" "usp_barrel" 3.267395 0.333982 0.007761 -0 -0 0 0 0 0 0 0 0
$definebone "shell_ejection" "usp_main" 0.223548 1.289429 0.520273 -72.014605 47.970147 -49.393374 0 0 0 0 0 0
$definebone "usp_trigger" "usp_main" 1.398664 -0.091955 0 -0 0 0 0 0 0 0 0 0
$definebone "usp_slide" "usp_main" 3.804338 0.860844 0 -0 0 0 0 0 0 0 0 0
$definebone "usp_hammer" "usp_main" -1.696121 0.240685 0 -0 58.733043 0 0 0 0 0 0 0
$definebone "usp_magazine" "usp_main" -0.392484 -0.832852 0.000001 -0 -17.079872 0 0 0 0 0 0 0
$definebone "usp_bullets" "usp_magazine" -0.018716 1.546493 -0.000074 -0 24.948302 0 0 0 0 0 0 0


$sequence "idle" {
	"m1911_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 15
}

$sequence "draw" {
	"m1911_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 1 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire" {
	"m1911_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 18
}

$sequence "shoot_empty" {
	"m1911_anims/shoot_empty.smd"
	activity "ACT_VM_DRYFIRE" 1
	{ event 5004 0 "bf3.empty" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload" {
	"m1911_anims/reload.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 12 "bf3_m1911.clipout" }
	{ event 5004 49 "bf3_m1911.clipin" }
	{ event 5004 59 "bf3_m1911.slide" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "reload_full" {
	"m1911_anims/reload_full.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 14 "bf3_m1911.clipout" }
	{ event 5004 49 "bf3_m1911.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire_empty" {
	"m1911_anims/fire_empty.smd"
	activity "ACT_VM_DRYFIRE" 1
	{ event 5004 0 "bf3.empty" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 120
}

// 

$modelname "weapons/c_pp19.mdl"

$bodygroup "sight"
{
	blank
	studio "reflex.smd"
	studio "kobra.smd"
	studio "acog.smd"
	studio "eotech.smd"
}
$bodygroup "barrel"
{
	studio "default.smd"
	studio "muzzle.smd"
	studio "suppressor.smd"
}
$bodygroup "pp19"
{
	studio "pp19.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$include "c_arms_definebones.qci"

$contents "solid"

$illumposition -0.024 -3.1 -6.694

$cdmaterials "models\bf3\weapons\smg\"
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
		"pp19"
		"muzzle"
		"suppressor"
		"pp19_tape"
		"V_hands"
	}
}

$attachment "1" "Muzzle_Flash" 0 0 0 rotate -0 0 0
$attachment "2" "Shell_Eject" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -12.947 -11.067 -13.651 19.148 11.018 0.264

$definebone "BIZON_Body" "" -2.012597 -14.537454 -1.876409 0 0 0 0 0 0 0 0 0
$definebone "BIZON_Magazine" "" -2.012596 -16.605995 -3.392382 0 0 0 0 0 0 0 0 0
$definebone "BIZON_MagRelease" "" -2.012597 -4.368316 -2.462387 0 0 0 0 0 0 0 0 0
$definebone "BIZON_FireSelector" "" -2.012597 -4.402978 -1.853887 0 0 17.999985 0 0 0 0 0 0
$definebone "BIZON_Bolt" "" -2.012597 -4.368316 -2.462387 0 0 0 0 0 0 0 0 0
$definebone "BIZON_Trigger" "" -2.012597 -4.368316 -2.462387 0 0 0 0 0 0 0 0 0
$definebone "BIZON_Bullet" "" -2.012597 -16.605995 -3.392382 0 0 0 0 0 0 0 0 0
$definebone "BIZON_Bullet2" "" -2.012597 -16.605995 -3.733645 0 0 0 0 0 0 0 0 0
$definebone "Muzzle_Flash" "" -2.011627 -18.794914 -2.044978 0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "Shell_Eject" "" -2.111937 -9.65472 -1.634943 -24.999908 179.999937 90.000016 0 0 0 0 0 0
$definebone "BIZON_Rail" "" -2.012597 -8.036591 -1.31326 0 0 0 0 0 0 0 0 0



$sequence "idle" {
	"pp19_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 100
	fadeout 0.2
	fps 30
}

$sequence "draw" {
	"pp19_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 100
	snap
	fps 40
}

$sequence "fire" {
	"pp19_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 100
	snap
	fps 30
}

$sequence "reload" {
	"pp19_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 25 "bf3_pp19.clipout" }
	{ event 5004 91 "bf3_pp19.clipin" }
	fadein 0.2
	fadeout 100
	snap
	fps 40
}

$sequence "reload_empty" {
	"pp19_anims/reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 25 "bf3_pp19.clipout" }
	{ event 5004 91 "bf3_pp19.clipin" }
	{ event 5004 133 "bf3_pp19.boltpull" }
	fadein 0.2
	fadeout 100
	snap
	fps 40
}

// 

$modelname "weapons/c_mp7.mdl"

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
$bodygroup "blank"
{
	blank
}
$bodygroup "laser"
{
	blank
	studio "laser.smd"
}
$bodygroup "mp7"
{
	studio "mp7.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$include "c_arms_definebones.qci"

$contents "solid"

$illumposition 1.042 51.031 -13.86

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
		"mp7"
		"muzzle"
		"suppressor"
		"laser"
	}
}

$attachment "1" "muzzle_flash" 0 0.08 -0.1 rotate -0 0 0
$attachment "2" "shell_ejection" 0 0 0 rotate 15 -50 0

$cbox 0 0 0 0 0 0

$bbox -8.595 -9.768 -12.275 19.381 8.26 0.588

$hboxset "default"

$definebone "Mp7_Body" "" 1.312189 1.72819 0.482725 0 0 -179.999964 0 0 0 0 0 0
$definebone "Mp7_Magazine" "" 1.312189 1.728192 0.482723 0 0 -179.999964 0 0 0 0 0 0
$definebone "Mp7_Trigger" "" 1.312189 1.728192 0.482723 0 0 -179.999964 0 0 0 0 0 0
$definebone "Mp7_BoltRelease" "" 1.312188 1.72819 0.482723 0 0 -179.999964 0 0 0 0 0 0
$definebone "Mp7_Foregrip" "" 1.312189 1.728189 0.482722 0 0 -179.999964 0 0 0 0 0 0
$definebone "shell_ejection" "" -2.743761 -10.212969 -3.251182 -22.071481 -150.113447 0 0 0 0 0 0 0
$definebone "muzzle_flash" "" -2.525776 -19.332973 -2.973041 0 -89.999982 0 0 0 0 0 0 0



$sequence "idle" {
	"mp7_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "reload" {
	"mp7_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 10 "bf3_mp7.clipout" }
	{ event 5004 49 "bf3_mp7.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "reload_empty" {
	"mp7_anims/reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 10 "bf3_mp7.clipout" }
	{ event 5004 49 "bf3_mp7.clipin" }
	{ event 5004 68 "bf3_mp7.boltcatch" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "draw" {
	"mp7_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	{ event 5004 14 "bf3_mp7.grip" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire" {
	"mp7_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

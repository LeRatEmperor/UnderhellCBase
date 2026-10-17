// 

$modelname "weapons/c_ump45.mdl"

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
	blank
	studio "muzzle.smd"
	studio "suppressor.smd"
}
$bodygroup "grip"
{
	blank
	studio "grip.smd"
}
$bodygroup "laser"
{
	blank
	studio "laser.smd"
}
$bodygroup "mp5k"
{
	studio "mp5k.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition 0.632 1.471 -7.332

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
		"muzzle"
		"suppressor"
		"grip"
		"laser"
		"ump45"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 0 0
$attachment "muzzle_supp" "A_Muzzle_Supp" 0 0 0 rotate -0 0 0
$attachment "2" "A_Eject" 0 0 0 rotate -0 0 0
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 0 0 0 rotate 0 0 0
$attachment "Suppressor" "A_Suppressor" 0 0 0 rotate -0 0 -0
$attachment "Modkit" "A_Modkit" 0 0 0 rotate -0 0 0
$attachment "Laser" "A_Underbarrel" 0 0 0 rotate -0 -0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -17.077 -8.127 -18.665 14.136 9.392 4.001

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -79.749939 -89.999874 -90.000099 0 0 0 0 0 0
$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "(null)" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 3.24214 -0.005069 0.000005 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 6.363438 -0.005069 0 -0 -0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 6.363436 -0.002058 0 -0 -0 0 0 0 0 0 0 0
$definebone "Weapon" "" -2.298738 -13.281845 -2.1298 0 0 0 0 0 0 0 0 0
$definebone "Mag" "Weapon" 0.019234 -0.041479 -4.462178 -0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Weapon" 0.023044 -2.547249 0.621049 -0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Weapon" -0.021224 3.457716 -2.593818 -0 0 0 0 0 0 0 0 0
$definebone "A_Muzzle" "Weapon" 0.005319 -4.134012 -0.336203 -0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "A_Eject" "Weapon" -0.349484 1.587097 0.312025 -18.903887 179.999841 0 0 0 0 0 0 0
$definebone "Eject_Port" "Weapon" -0.405838 1.555586 0.317452 -0 0 0 0 0 0 0 0 0
$definebone "Mag_Rel" "Weapon" 0.032412 1.399686 -2.497452 8.564115 -90.000037 89.999982 0 0 0 0 0 0
$definebone "A_Optic" "Weapon" -0.015144 2.885787 1.158291 -0 -179.999978 -88.585805 0 0 0 0 0 0
$definebone "A_Underbarrel" "Weapon" -1.10667 -4.44986 -0.326284 -1.332757 -90.000037 -89.999982 0 0 0 0 0 0
$definebone "A_Modkit" "Weapon" -0.004948 1.979355 0.842694 -0 179.999964 -88.667221 0 0 0 0 0 0
$definebone "A_Suppressor" "Weapon" -0.006518 -4.304943 -0.378902 -0 179.999964 1.082203 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "Weapon" 0.005317 -11.735769 -0.246849 -0.000057 -90.000037 89.999982 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "Weapon" -0.096618 -3.712847 -0.338035 0.000036 -90.000016 -180.000005 0 0 0 0 0 0
$definebone "Ringswing" "Weapon" 0.019403 7.194278 -0.321872 -0 0 -0.559608 0 0 0 0 0 0
$definebone "A_Muzzle_Ironsight" "Weapon" 2.298738 -12.412628 2.129801 -0.20002 -90.000098 0 0 0 0 0 0 0

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




$sequence "base_idle" {
	"ump45_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "base_draw" {
	"ump45_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "base_fire" {
	"ump45_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "base_reload" {
	"ump45_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 21 "bf3_ump45.clipout" }
	{ event 5004 67 "bf3_ump45.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "base_reload_empty" {
	"ump45_anims/base_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 12 "bf3_ump45.boltback" }
	{ event 5004 44 "bf3_ump45.clipout" }
	{ event 5004 91 "bf3_ump45.clipin" }
	{ event 5004 111 "bf3_ump45.boltforward" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "foregrip_idle" {
	"ump45_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"ump45_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "foregrip_fire" {
	"ump45_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_reload" {
	"ump45_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 21 "bf3_ump45.clipout" }
	{ event 5004 67 "bf3_ump45.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "foregrip_reload_empty" {
	"ump45_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 12 "bf3_ump45.boltback" }
	{ event 5004 44 "bf3_ump45.clipout" }
	{ event 5004 91 "bf3_ump45.clipin" }
	{ event 5004 111 "bf3_ump45.boltforward" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

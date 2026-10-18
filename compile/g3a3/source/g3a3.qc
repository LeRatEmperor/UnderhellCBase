// 

$modelname "weapons/c_g3a3.mdl"

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
$bodygroup "g3a3"
{
	studio "g3a3.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$include "c_arms_definebones.qci"

$contents "solid"

$illumposition 0.707 7.613 -9.11

$cdmaterials "models\bf3\weapons\rifles\"
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
		"g3a3"
		"muzzle"
		"suppressor"
		"grip"
		"laser"
	}
}

$attachment "muzzle" "b_wpn_muzzle" 0 0 0 rotate -0 0 0
$attachment "muzzle_supp" "b_wpn_muzzle" 8.07 0 0 rotate -0 0 0
$attachment "2" "b_wpn_eject" 0 0 0 rotate 0 -0 0
$attachment "Suppressor" "a_suppressor" 0 0 0 rotate -0 0 0
$attachment "Laser" "a_laserflashlight" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 -0
$attachment "Foregrip" "b_wpn_foregrip" 0 0 0 rotate -0 0 0
$attachment "Magazine" "b_wpn_mag" 0 0 0 rotate -0 0 0
$attachment "camera" "b_camera" 0 0 0 rotate -0 -90 0

$cbox 0 0 0 0 0 0

$bbox -33.201 -5.851 -20.721 17.975 7.265 2.501

$definebone "ValveBiped.Bip01" "" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "b_ch_middle" "ValveBiped.Bip01" -0.000002 0.000007 -20.720551 -0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "b_ch_middle" -0.005068 -0 3.242138 -89.949391 -89.998664 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine2" "ValveBiped.Bip01_Spine1" 6.363434 -0.004122 0.000548 0.048759 -0.00848 -35.782651 0 0 0 0 0 0
$definebone "b_camera" "ValveBiped.Bip01" 0 0 0 -0 0 0.000057 0 0 0 0 0 0
$definebone "ik_hand_root" "ValveBiped.Bip01" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "ik_hand_r" "ik_hand_root" -3.990748 -5.973761 -6.666942 2.796435 -73.169972 7.609854 0 0 0 0 0 0
$definebone "ik_hand_l" "ik_hand_root" -1.277242 -16.02747 -4.548577 -11.971893 -118.791852 114.914531 0 0 0 0 0 0
$definebone "b_wpn" "ValveBiped.Bip01" -2.579667 -11.947805 -4.859893 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_eject" "b_wpn" -0.54111 -1.045988 2.423685 -22.618942 -157.226146 -4.243383 0 0 0 0 0 0
$definebone "b_wpn_fireselect" "b_wpn" 0.497737 2.452932 0.580558 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_magrelease" "b_wpn" 0 0.004086 -0.007531 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_muzzle" "b_wpn" 0.023565 -20.688456 1.852278 -0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "b_wpn_spec_1" "b_wpn" 0.057624 -0.345571 0.590815 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_trigger" "b_wpn" 0 1.658607 -0.0555 -0 0 0 0 0 0 0 0 0
$definebone "ik_hand_wpn_l" "b_wpn" 1.302424 -4.079666 0.311316 -11.971896 -118.791975 114.914477 0 0 0 0 0 0
$definebone "ik_hand_wpn_r" "b_wpn" -1.411081 5.974045 -1.807053 2.796263 -73.17015 7.609857 0 0 0 0 0 0
$definebone "b_wpn_chargehandle" "b_wpn" -0.000987 -9.751673 2.693876 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_spec_2" "b_wpn" -0.000987 -8.743616 2.693876 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_bolt" "b_wpn" -0.000001 -4.161116 2.223405 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_mag" "b_wpn" -0.000001 -1.751438 -0.712535 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_mag_b1" "b_wpn_mag" -0.139335 0.070539 2.106509 -0.000057 0 -2.603004 0 0 0 0 0 0
$definebone "b_wpn_mag_b2" "b_wpn_mag" 0.003623 0.063092 1.613393 -0.000057 0 -0.000172 0 0 0 0 0 0
$definebone "b_wpn_mag_follow" "b_wpn_mag" 0.004323 0.018379 0.941049 -0 0 -0.000172 0 0 0 0 0 0
$definebone "b_wpn_foregrip" "b_wpn" -0.004371 -6.654654 0.768527 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_optic" "b_wpn" -0.000987 0.722011 3.407384 -0 -0.000057 0 0 0 0 0 0 0
$definebone "b_wpn_bipod" "b_wpn" -0.000001 -11.086353 0.894633 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_bipod_base" "b_wpn_bipod" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_bipod_spring_l" "b_wpn_bipod_base" 0.690645 1.589273 -0.662467 -0.579776 -88.600189 22.492839 0 0 0 0 0 0
$definebone "b_wpn_bipod_spring_r" "b_wpn_bipod_base" -0.691 1.589275 -0.662467 -0.595418 -91.385909 -22.493063 0 0 0 0 0 0
$definebone "b_wpn_bipod_base_l" "b_wpn_bipod_base" 0.750996 0.339142 -1.16316 0.000057 89.999982 -22.511342 0 0 0 0 0 0
$definebone "b_wpn_bipod_spring_base_l" "b_wpn_bipod_base_l" -4.468534 -0.28717 0.340499 -1.453365 1.514614 0.011284 0 0 0 0 0 0
$definebone "b_wpn_bipod_base_r" "b_wpn_bipod_base" -0.602622 0.339144 -1.224393 -0 89.999982 22.500168 0 0 0 0 0 0
$definebone "b_wpn_bipod_spring_base_r" "b_wpn_bipod_base_r" -4.466202 0.447207 0.342232 -1.433598 -1.508884 0.000056 0 0 0 0 0 0
$definebone "b_wpn_mag_2" "b_wpn" 4.545642 29.042681 -1.492936 -0 0 0 0 0 0 0 0 0
$definebone "a_suppressor" "b_wpn" 0.01 -19.200001 1.8 -0 180.000005 0 0 0 0 0 0 0
$definebone "a_laserflashlight" "b_wpn" 0 -16.85 1.84 -0 -90.000003 180.000005 0 0 0 0 0 0
$definebone "A_Optic" "b_wpn_optic" 0 0.5 0.1 -0 180.000005 -90.000003 0 0 0 0 0 0
$definebone "A_Foregrip" "b_wpn_foregrip" 0 0 0 -0 180.000005 0 0 0 0 0 0 0
$definebone "A_Modkit" "b_wpn_optic" 0 0 0 -0 0 0 0 0 0 0 0 0



$sequence "base_idle" {
	"g3a3_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "base_draw" {
	"g3a3_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 301
}

$sequence "base_fire" {
	"g3a3_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "base_reload" {
	"g3a3_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 25 "bf3_g3a3.clipout" }
	{ event 5004 82 "bf3_g3a3.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 40
}

$sequence "base_reload_empty" {
	"g3a3_anims/base_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 24 "bf3_g3a3.boltback" }
	{ event 5004 62 "bf3_g3a3.clipout" }
	{ event 5004 117 "bf3_g3a3.clipin" }
	{ event 5004 149 "bf3_g3a3.boltforward" }
	fadein 0.2
	fadeout 0.2
	fps 40
}

$sequence "foregrip_idle" {
	"g3a3_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"g3a3_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "foregrip_fire" {
	"g3a3_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "foregrip_reload" {
	"g3a3_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 25 "bf3_g3a3.clipout" }
	{ event 5004 82 "bf3_g3a3.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 38
}

$sequence "foregrip_reload_empty" {
	"g3a3_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 24 "bf3_g3a3.boltback" }
	{ event 5004 62 "bf3_g3a3.clipout" }
	{ event 5004 117 "bf3_g3a3.clipin" }
	{ event 5004 149 "bf3_g3a3.boltforward" }
	fadein 0.2
	fadeout 0.2
	fps 32
}

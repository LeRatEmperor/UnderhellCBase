// 

$modelname "bf3\weapons\aek971.mdl"

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
$bodygroup "ak74"
{
	studio "ak74.smd"
}
$bodygroup "hands"
{
	studio "hands.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -3.27 -7.049 -11.762

$cdmaterials "models\bf3\weapons\rifles\"
$cdmaterials "models\bf3\weapons\att\"
$cdmaterials "models\weapons\v_models\hands\"

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
		"aek971"
		"muzzle"
		"suppressor"
		"grip"
		"laser"
		"v_hands"
		"sleeve_diffuse"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 -0 0
$attachment "muzzle_gl" "A_GLMuzzle" 0 0 0 rotate -0 -0 0
$attachment "muzzle_supp" "A_Muzzle_Supp" 0 0 0 rotate -0 -0 0
$attachment "2" "A_Eject" 0 0 -0 rotate -0 -0 0
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 0 0 0 rotate 0 0 0
$attachment "Suppressor" "A_Suppressor" 0 0 0 rotate -0 0 0
$attachment "Modkit" "A_Modkit" 0 0 0 rotate -0 -0 -0
$attachment "Laser" "A_Underbarrel" 0 0 -0 rotate -0 -0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 -0
$attachment "Foregrip" "A_Foregrips" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -15.569 -15.376 -25.946 29.666 8.836 2.422

$definebone "ValveBiped.Bip01_L_Clavicle" "" 3.491543 8.830969 -9.976974 0 0.000057 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853647 -0.000001 0 2.606709 -90.52118 -90.385901 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390535 -0.000002 0.000001 -0 -6.123426 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525425 -0.000002 0 2.753062 3.862882 -91.214711 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555143 0.315172 -0.822494 36.110722 33.914171 115.151566 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556972 0.000002 -0.000002 -0.000005 9.52932 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.22109 -0.000002 0.000001 -0.000012 13.764626 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828093 -0.209482 -1.286462 1.166311 -3.007112 7.059473 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382519 0.000001 0.000004 -0.000003 5.705115 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865905 -0.000001 -0.000003 -0.000003 1.676707 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813033 -0.266274 -0.544265 -0.523171 -4.898962 4.980264 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445751 0 0 -0.000003 8.18986 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053753 -0.000002 0.000002 -0.000003 -1.49399 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.689438 -0.34286 0.236189 -0.363545 -3.72474 7.4665 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439796 -0.000002 -0.000001 -0.000003 3.307803 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.98299 0.000001 -0.000001 -0.000003 -5.220043 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426952 -0.353602 1.013784 -0.774241 -8.678418 5.197188 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104664 0.000001 0 -0.000003 4.531697 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908442 0.000001 -0.000001 -0.000003 -3.232686 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_Forearm" -0 0 0 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217918 -0.000003 0 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217918 -0.000001 -0.000003 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.217917 -0.000001 -0.000004 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217916 0.000002 -0.000001 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.217918 0 -0.000003 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217916 -0.000002 0.000001 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" 0.47538 8.830965 -9.976974 -0.000019 -179.999937 180.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000001 0 -2.606709 -90.52118 90.385901 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.390536 -0.000002 0 -0 -6.123426 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525427 0.000001 0 -2.753062 3.862882 91.214711 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.55514 0.315171 0.822496 -36.110712 33.914171 -115.151566 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556972 0 0 -0.000002 9.529332 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221088 -0.000002 0 -0.000005 13.764635 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828091 -0.209481 1.286462 -1.166311 -3.007112 -7.059472 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382519 0 -0.000002 0.000002 5.70511 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.86591 -0 0.000003 0.000002 1.6767 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813031 -0.266276 0.544264 0.523168 -4.89896 -4.980265 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445755 -0 0 0.000001 8.18986 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.05375 -0 -0.000003 0.000002 -1.493987 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.689442 -0.34286 -0.236188 0.363542 -3.72474 -7.4665 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439795 -0 0.000001 0.000001 3.307801 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.982989 0 0.000002 0.000001 -5.220044 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426953 -0.353604 -1.013783 0.774238 -8.678418 -5.197187 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104666 0 0.000001 -0 4.531694 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908442 -0 0.000002 -0 -3.232686 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_Forearm" 0 0 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217917 0.000002 -0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.217918 -0.000001 -0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217918 0.000002 0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.217916 -0.000001 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.217918 0.000001 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.217916 0 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "Pelvis" "(null)" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "Spine" "Pelvis" 3.24214 -0.005069 0.000005 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "Spine1" "Spine" 6.363438 -0.005069 0 -0 -0 0 0 0 0 0 0 0
$definebone "Neck" "Spine1" 6.363436 -0.002058 0 -0 -0 0 0 0 0 0 0 0
$definebone "Weapon" "" -2.249564 -11.152735 -2.826391 0 0.010027 0.000115 0 0 0 0 0 0
$definebone "Magazine" "Weapon" 0.008195 0.181844 -2.444005 -0 0 -0 0 0 0 0 0 0
$definebone "Bullets" "Magazine" 0.112215 0.559316 2.399464 -0 0 -0 0 0 0 0 0 0
$definebone "Safety" "Weapon" -0.718951 4.68434 0.03232 -0 0 -0 0 0 0 0 0 0
$definebone "Trigger" "Weapon" -0.001748 3.534093 -0.807314 -0 0 -0 0 0 0 0 0 0
$definebone "Bolt" "Weapon" -0.800971 -1.456638 0.700426 -0 0 -0 0 0 0 0 0 0
$definebone "Magazine Release" "Weapon" 0.002608 1.938277 -1.137029 -0 0 -0 0 0 0 0 0 0
$definebone "A_Eject" "Weapon" -0.5604 0.330936 0.970054 -14.389434 -168.262871 4.06697 0 0 0 0 0 0
$definebone "A_Muzzle" "Weapon" -0.0047 -17.398869 0.33522 -0.000036 -90.000016 90.000016 0 0 0 0 0 0
$definebone "A_Underbarrel" "Weapon" 0.005541 -9.114821 1.174847 -0 -89.999982 -89.999982 0 0 0 0 0 0
$definebone "A_Suppressor" "Weapon" -0.006525 -15.68419 0.287403 -0 179.999964 0 0 0 0 0 0 0
$definebone "A_Optic" "Weapon" 0.006863 2.456758 1.82524 -0 -179.999978 -89.999982 0 0 0 0 0 0
$definebone "A_Modkit" "Weapon" 0.003085 2.456742 1.416514 -0 -179.999964 -89.999982 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "Weapon" -0.0047 -25.968014 0.335223 -0.000036 -90.000016 90.000016 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "Weapon" 0.005541 -9.114821 1.174847 -0.000019 -90.000016 -180.000005 0 0 0 0 0 0
$definebone "A_Foregrips" "Weapon" 0.005373 -4.913064 -0.19399 -0 179.999964 0 0 0 0 0 0 0
$definebone "A_Muzzle_Ironsight" "Weapon" 2.249564 -18.513626 2.82642 -0.000115 -90.000098 0 0 0 0 0 0 0
$definebone "A_GL" "Weapon" 0.000663 -9.800418 0.204282 0 89.999982 89.999982 0 0 0 0 0 0
$definebone "GL_Base" "A_GL" 0 0 -0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Trigger" "GL_Base" 4.033323 -1.616606 -0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Round" "GL_Base" 0.413366 -1.794379 -0 -0 -0 0 0 0 0 0 0 0
$definebone "A_GLMuzzle" "GL_Base" -2.572542 -1.780955 -0 -0.000019 -180.000005 -180.000005 0 0 0 0 0 0


$sectionframes 30 134

$sequence "base_idle" {
	"aek971_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "base_draw" {
	"aek971_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "base_fire" {
	"aek971_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "base_reload" {
	"aek971_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 19 "bf3_aek971.clipout" }
	{ event 5004 60 "bf3_aek971.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "base_reloadempty" {
	"aek971_anims/base_reloadempty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 19 "bf3_aek971.clipout" }
	{ event 5004 60 "bf3_aek971.clipin" }
	{ event 5004 104 "bf3_aek971.boltpull" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "foregrip_idle" {
	"aek971_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"aek971_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "foregrip_fire" {
	"aek971_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_reload" {
	"aek971_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 19 "bf3_aek971.clipout" }
	{ event 5004 60 "bf3_aek971.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "foregrip_reload_empty" {
	"aek971_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 19 "bf3_aek971.clipout" }
	{ event 5004 60 "bf3_aek971.clipin" }
	{ event 5004 104 "bf3_aek971.boltpull" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

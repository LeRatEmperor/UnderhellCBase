// 

$modelname "weapons/c_asval.mdl"

$bodygroup "sight"
{
	blank
	studio "reflex.smd"
	studio "kobra.smd"
	studio "acog.smd"
	studio "eotech.smd"
}
$bodygroup "blank"
{
	blank
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
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"


$contents "solid"

$illumposition -3.27 -7.049 -11.762

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
		"grip"
		"laser"
		"asval"
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

$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "(null)" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 3.24214 -0.005069 0.000005 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 6.363438 -0.005069 0 -0 -0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 6.363436 -0.002058 0 -0 -0 0 0 0 0 0 0 0
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


$definebone "ValveBiped.Bip01_Spine4" "" 0.000006 0.000000 0.000000 -79.749939 -89.999874 -90.000099 0.000000 0.000000 0.000000 -0.000000 0.000000 -0.000000
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 2.033349 1.000767 1.937660 -73.711860 168.619273 91.480543 0.000000 0.000000 0.000000 -0.000000 0.000002 0.000001
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 6.028141 0.000000 0.000000 2.738853 -33.527944 -90.505158 0.000000 0.000000 0.000000 -0.000000 0.000000 -0.000001
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.692556 0.000001 0.000003 -0.000003 -3.459061 -0.000001 0.000000 0.000000 0.000000 -0.000003 -0.000000 -0.000001
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 11.481674 0.000001 -0.000032 -6.108477 2.532073 90.136744 0.000000 0.000000 0.000000 0.000000 0.000002 0.000001
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.859707 -0.142403 -1.191975 8.682203 -50.431563 -26.822042 0.000002 0.000000 0.000000 -0.000001 0.000007 0.000003
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.312557 0.000000 0.000002 -0.000001 -25.194099 0.000003 0.000001 0.000000 0.000000 -0.000001 0.000000 0.000003
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.729364 -0.000002 -0.000001 -0.000002 -13.997301 0.000005 -0.000001 0.000000 0.000000 -0.000002 -0.000002 0.000005
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.942333 0.046767 -0.431443 4.194397 -46.466010 -8.696352 0.000000 0.000000 0.000000 0.000001 0.000007 -0.000001
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.539097 0.000000 0.000000 0.000000 -14.197715 -0.000001 0.000000 0.000000 0.000000 0.000000 0.000007 -0.000001
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 1.196325 -0.000002 -0.000001 0.000000 -24.683134 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.883694 -0.046766 0.431443 1.250768 -33.682286 4.921822 0.000000 -0.000002 0.000000 0.000002 0.000013 0.000002
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.719572 -0.000004 -0.000001 0.316047 -20.997629 0.000001 0.000000 0.000000 0.000000 0.000004 0.000013 0.000001
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.209173 -0.000002 -0.000000 0.176703 -12.398796 0.000000 0.000000 0.000004 0.000000 0.000003 0.000010 0.000000
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.859863 -0.137946 1.332466 -2.449394 -30.465192 20.308434 0.000000 0.000000 0.000000 0.000004 0.000011 0.000002
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.719429 0.000002 -0.000002 0.233428 -20.798876 0.000000 -0.000002 0.000002 0.000000 0.000005 0.000009 0.000000
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 1.099663 0.000000 0.000000 0.148745 -13.999132 -0.000002 0.000000 -0.000002 0.000000 0.000004 0.000005 -0.000002
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.806053 -0.348924 1.321258 -38.916041 -45.195987 -70.054232 0.000000 0.000000 0.000002 -0.000011 -0.000000 0.000002
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.789782 -0.000002 0.000002 -0.000009 13.093406 0.000000 0.000000 0.000000 0.000000 -0.000009 0.000003 0.000000
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.207006 0.000000 0.000000 -0.000009 20.790348 -0.000003 0.000000 0.000000 0.000000 -0.000009 0.000004 -0.000003
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 2.033356 1.000772 -1.937610 73.712038 168.618781 -95.596497 0.000000 0.000000 0.000000 0.000000 0.000000 0.000002
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 6.028143 0.000000 -0.000000 -0.462090 -33.623802 93.935244 0.000000 0.000000 0.000000 -0.000003 -0.000001 -0.000000
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.692554 0.000001 0.000004 -0.000003 -3.459062 -0.000000 0.000000 0.000000 0.000000 -0.000003 -0.000001 -0.000000
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 11.481697 0.000001 0.000003 6.108071 2.532072 -89.664286 0.000000 0.000000 0.000000 0.000001 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.859676 -0.132571 1.193109 -9.056514 -50.352978 26.713357 0.000000 0.000002 0.000000 -0.000003 -0.000006 0.000000
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.312559 -0.000002 0.000001 -0.000003 -25.191357 0.000000 0.000000 0.000000 0.000000 -0.000003 -0.000009 0.000000
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.729364 0.000000 -0.000001 -0.000002 -13.995702 0.000002 0.000000 0.000000 -0.000001 -0.000002 -0.000005 0.000002
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.942303 0.050328 0.431044 -4.537309 -46.421337 8.598836 0.000000 0.000000 0.000000 -0.000001 -0.000007 0.000002
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.539099 -0.000002 0.000000 -0.000001 -14.196238 0.000000 0.000000 0.000000 0.000000 -0.000001 -0.000007 0.000000
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 1.196321 0.000004 -0.000000 -0.000000 -24.680792 0.000001 0.000000 0.000000 0.000000 -0.000000 -0.000003 0.000001
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.883659 -0.050324 -0.431042 -1.512837 -33.672457 -4.921995 0.000000 0.000000 0.000000 0.000001 -0.000012 -0.000001
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.719578 0.000002 -0.000000 -0.456875 -20.995249 -0.000001 0.000000 0.000000 0.000000 0.000001 -0.000010 -0.000001
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.209183 0.000002 -0.000000 -0.255595 -12.397439 -0.000001 0.000000 0.000000 0.000000 0.000001 -0.000007 -0.000001
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.859837 -0.148935 -1.331282 2.209727 -30.481417 -20.306713 0.000000 0.000000 0.000000 0.000003 -0.000003 0.000003
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.719425 0.000000 0.000000 -0.378893 -20.796658 0.000002 0.000002 0.000000 0.000000 0.000004 -0.000006 0.000000
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 1.099665 0.000002 0.000000 -0.241269 -13.998056 -0.000002 0.000001 0.000002 0.000000 0.000003 -0.000007 -0.000002
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.806021 -0.359836 -1.318334 38.596443 -45.467528 69.981641 0.000000 0.000000 0.000000 -0.000003 -0.000004 0.000005
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.789782 0.000000 -0.000004 -0.000004 13.095237 0.000003 -0.000002 0.000000 0.000000 -0.000004 -0.000002 0.000003
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.206999 0.000001 0.000002 -0.000003 20.792925 0.000002 0.000000 0.000000 0.000000 -0.000003 -0.000000 0.000002


$bonemerge "ValveBiped.Bip01_Spine4"
$bonemerge "ValveBiped.Bip01_R_Clavicle"
$bonemerge "ValveBiped.Bip01_R_UpperArm"
$bonemerge "ValveBiped.Bip01_R_Forearm"
$bonemerge "ValveBiped.Bip01_R_Hand"
$bonemerge "ValveBiped.Bip01_Neck1"
$bonemerge "ValveBiped.Bip01_Head1"
$bonemerge "ValveBiped.Bip01_L_Clavicle"
$bonemerge "ValveBiped.Bip01_L_UpperArm"
$bonemerge "ValveBiped.Bip01_L_Forearm"
$bonemerge "ValveBiped.Bip01_L_Hand"
$bonemerge "ValveBiped.Bip01_L_Finger4"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "ValveBiped.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger3"
$bonemerge "ValveBiped.Bip01_L_Finger31"
$bonemerge "ValveBiped.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger2"
$bonemerge "ValveBiped.Bip01_L_Finger21"
$bonemerge "ValveBiped.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger1"
$bonemerge "ValveBiped.Bip01_L_Finger11"
$bonemerge "ValveBiped.Bip01_L_Finger12"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger02"
$bonemerge "ValveBiped.Bip01_R_Finger4"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "ValveBiped.Bip01_R_Finger42"
$bonemerge "ValveBiped.Bip01_R_Finger3"
$bonemerge "ValveBiped.Bip01_R_Finger31"
$bonemerge "ValveBiped.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_R_Finger2"
$bonemerge "ValveBiped.Bip01_R_Finger21"
$bonemerge "ValveBiped.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger1"
$bonemerge "ValveBiped.Bip01_R_Finger11"
$bonemerge "ValveBiped.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger0"
$bonemerge "ValveBiped.Bip01_R_Finger01"
$bonemerge "ValveBiped.Bip01_R_Finger02"



$sequence "base_idle" {
	"asval_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "base_draw" {
	"asval_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "base_fire" {
	"asval_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "base_reload" {
	"asval_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 19 "bf3_asval.clipout" }
	{ event 5004 60 "bf3_asval.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "base_reloadempty" {
	"asval_anims/base_reloadempty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 19 "bf3_asval.clipout" }
	{ event 5004 60 "bf3_asval.clipin" }
	{ event 5004 104 "bf3_asval.boltpull" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "foregrip_idle" {
	"asval_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"asval_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "foregrip_fire" {
	"asval_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_reload" {
	"asval_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 19 "bf3_asval.clipout" }
	{ event 5004 60 "bf3_asval.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "foregrip_reload_empty" {
	"asval_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 19 "bf3_asval.clipout" }
	{ event 5004 60 "bf3_asval.clipin" }
	{ event 5004 104 "bf3_asval.boltpull" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

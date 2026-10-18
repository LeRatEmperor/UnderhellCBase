// 

$modelname "weapons/c_mk11.mdl"

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
$bodygroup "acwr"
{
	studio "acwr.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"


$contents "solid"

$illumposition 0.398 -13.379 -7.488

$cdmaterials "models\bf3\weapons\sniper\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"mk11_sight"
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
		"muzzle"
		"suppressor"
		"grip"
		"laser"
		"mk11"
		"mk11_tape"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 0 0
$attachment "shell" "A_Eject" -0 0 -0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -18.131 -25.058 -17.273 27.956 9.57 4.074

$definebone "Weapon" "" -2.387503 -15.270334 -5.074594 0 0 0 0 0 0 0 0 0
$definebone "Charging_Handle" "Weapon" 0.066779 8.881084 3.401956 -0 0 0.000057 0 0 0 0 0 0
$definebone "Bolt" "Charging_Handle" -0.095912 -5.251013 -0.854032 -0 -89.999982 0 0 0 0 0 0 0
$definebone "DustCover" "Weapon" -0.665847 3.477695 2.269095 -0 0 0.000057 0 0 0 0 0 0
$definebone "Magazine_Release" "Weapon" -0.006288 4.178158 1.057485 -0 0 0.000057 0 0 0 0 0 0
$definebone "Magazine" "Weapon" 0.037367 2.635598 -1.334266 -0 0 0.000057 0 0 0 0 0 0
$definebone "Bullet" "Magazine" -0.174255 0.505857 3.360352 -0 0 0 0 0 0 0 0 0
$definebone "Bullet_2" "Magazine" 0.014291 0.505857 3.121574 -0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Weapon" 0.040949 6.055264 0.892183 -0 0 0.000057 0 0 0 0 0 0
$definebone "A_Suppressor" "Weapon" 0.016964 -18.515348 2.541246 -0 179.999964 -0.000057 0 0 0 0 0 0
$definebone "A_Muzzle" "Weapon" 0.022494 -19.748304 2.539137 -0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "A_UnderBarrel" "Weapon" -0.91062 -13.172815 2.531399 0.000057 -90.000037 -90.000037 0 0 0 0 0 0
$definebone "Bipod" "A_UnderBarrel" -3.480284 2.046947 0.93866 89.999982 -90.000037 0 0 0 0 0 0 0
$definebone "Bipod_Left" "Bipod" 0.782162 -0.000002 -0.319805 -65.000001 -179.999909 89.999921 0 0 0 0 0 0
$definebone "Bipod_Right" "Bipod" -0.782096 -0.000004 -0.319805 64.999939 179.999841 -90.000153 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "Weapon" -0.950814 -7.898512 2.485385 0.000115 -90.000037 179.999978 0 0 0 0 0 0
$definebone "A_GL" "Weapon" 0.02472 -2.024908 1.422118 0.000057 -90.000037 90.000037 0 0 0 0 0 0
$definebone "GL_Base" "A_GL" 0 -0 -0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Slide" "GL_Base" 1.891411 -1.591587 0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Trigger" "GL_Base" -2.772263 -2.006649 -0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Round" "GL_Base" 3.309917 -1.59422 0.001201 89.999982 89.999982 0 0 0 0 0 0 0
$definebone "GL_Casing" "GL_Base" 4.085115 -1.594219 0.001201 89.999982 89.999982 0 0 0 0 0 0 0
$definebone "M203_Slide_Release" "GL_Base" 4.013391 -0.151551 -0.688799 89.999982 89.999982 0 0 0 0 0 0 0
$definebone "A_Eject" "Weapon" -0.496131 2.887262 2.652126 -24.317246 179.999841 0 0 0 0 0 0 0
$definebone "A_Optic" "Weapon" 0.031988 4.874125 3.698847 -0 179.999964 -90.000037 0 0 0 0 0 0
$definebone "Trigger_m16" "Weapon" 0.040949 5.989647 0.389903 -0 0 0 0 0 0 0 0 0
$definebone "Bipod_Main" "" 8.098196 -21.222406 -0.376701 -26.18136 -38.337234 81.044081 0 0 0 0 0 0
$definebone "A_Bipod" "Bipod_Main" -0.000004 -9.774027 -0.000003 0.000003 0.000005 0 0 0 0 0 0 0
$definebone "Bipod_RightLeg" "Bipod_Main" 0 -1.188227 1.002607 24.963368 93.309441 -88.60202 0 0 0 0 0 0
$definebone "Bipod_LeftLeg" "Bipod_Main" 0.000002 -1.188228 -1.002702 24.963372 -86.69053 -88.601965 0 0 0 0 0 0


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
	"mk11_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 1
	loop
}

$sequence "base_draw" {
	"mk11_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "base_fire" {
	"mk11_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 28
}

$sequence "base_reload" {
	"mk11_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 15 "bf3_mk11.clipout" }
	{ event 5004 58 "bf3_mk11.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "base_reload_empty" {
	"mk11_anims/base_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 15 "bf3_mk11.clipout" }
	{ event 5004 62 "bf3_mk11.clipin" }
	{ event 5004 89 "bf3_mk11.boltcatch" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "foregrip_idle" {
	"mk11_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"mk11_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "foregrip_fire" {
	"mk11_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 28
}

$sequence "foregrip_reload" {
	"mk11_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 15 "bf3_mk11.clipout" }
	{ event 5004 58 "bf3_mk11.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "foregrip_reload_empty" {
	"mk11_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 15 "bf3_mk11.clipout" }
	{ event 5004 62 "bf3_mk11.clipin" }
	{ event 5004 85 "bf3_mk11.boltcatch" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

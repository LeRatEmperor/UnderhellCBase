// 

$modelname "weapons/c_m416.mdl"

$bodygroup "sight"
{
	studio "sight.smd"
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
$bodygroup "acwr"
{
	studio "acwr.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 0.398 -13.379 -7.488

$cdmaterials "models/bf3/weapons/rifles/"
$cdmaterials "models/bf3/weapons/att/"

$texturegroup "skinfamilies"
{
	{
		"m416"
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
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 -0 rotate -0 0 0
$attachment "shell" "A_Eject" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -18.131 -25.058 -17.273 27.956 9.57 4.074

$definebone "ValveBiped.Bip01_L_Clavicle" "" 3.491543 8.830969 -9.976974 -0 0.000057 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853647 -0.000001 0 2.606728 -90.521187 -90.385915 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390539 -0.000002 0.000002 0 -6.123426 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525428 0 -0.000004 2.75306 3.862882 -91.214697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555142 0.315172 -0.822494 36.110694 33.914147 115.151539 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556974 0.000001 0 -0.00002 9.529354 0.000014 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.22109 0 0.000002 -0.000031 13.764658 0.000007 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828096 -0.209478 -1.286461 1.166311 -3.007111 7.05947 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.38252 0.000001 0.000005 -0.000002 5.705103 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865904 0 -0.000003 -0.000002 1.676688 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813037 -0.266273 -0.544264 -0.523168 -4.898958 4.980263 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445752 0 0 -0.000001 8.189848 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053756 -0.000003 0.000004 -0.000001 -1.493994 0.000007 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.689444 -0.342857 0.236192 -0.363542 -3.72474 7.466499 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439796 -0.000002 0.000001 0 3.307798 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.982989 0.000003 -0.000001 0 -5.220037 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426953 -0.353602 1.013784 -0.774237 -8.67841 5.197185 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104663 0 0.000002 0.000001 4.531697 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908442 0 -0.000002 0.000002 -3.232676 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_Forearm" -0 0 -0.000002 0 0.000005 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217918 -0.000004 -0.000001 0 0.000004 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217919 0.000001 -0.000001 0 0.000004 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.217916 0 -0.000006 -0 0.000004 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217917 0.000002 -0.000002 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.21792 0 -0.000004 0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217916 -0.000003 0.000004 0 0.000004 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" 0.47538 8.830965 -9.976974 -0 -179.999909 -179.999909 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000003 0 -2.606728 -90.521187 90.385915 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.390543 0.000001 0 -0 -6.123427 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525431 0.000001 0 -2.753061 3.862883 91.214697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.55514 0.31517 0.822494 -36.110701 33.914171 -115.151539 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556972 0.000001 0 -0.000003 9.52934 -0.000012 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221089 -0.000002 -0.000001 0.000002 13.764651 -0.000014 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828094 -0.209482 1.286461 -1.166308 -3.007111 -7.05947 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382516 0 -0.000002 0.000005 5.70511 0.000004 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.86591 0 0.000004 0.000007 1.676698 0.000006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813033 -0.266278 0.544266 0.52317 -4.898959 -4.980263 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445754 0 -0.000002 0.000004 8.189855 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053752 0 -0.000007 0.000006 -1.493989 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.689446 -0.342861 -0.236189 0.363545 -3.72474 -7.4665 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439795 0.000001 0.000003 0.000004 3.3078 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.982989 -0 0.000005 0.000005 -5.220042 -0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426956 -0.353604 -1.013783 0.77424 -8.678415 -5.197187 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104666 -0 0.000001 0.000003 4.531693 0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908442 0 0.000002 0.000004 -3.232686 0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_Forearm" -0 0 0 -0 0.000005 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217918 0.000002 0 -0 0.000005 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.217918 0.000001 0 -0 0.000005 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217918 0.000002 0 -0 0.000005 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.217916 -0.000003 0 -0 0.000005 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.217919 0.000001 -0 -0 0.000005 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.217916 -0.000003 0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "Weapon" "" -2.387503 -15.270334 -5.074594 -0 0 0 0 0 0 0 0 0
$definebone "Charging_Handle" "Weapon" 0.066779 8.881084 3.401956 -0 0 0.000057 0 0 0 0 0 0
$definebone "Bolt" "Charging_Handle" -0.095912 -5.251013 -0.854032 -0 -89.999975 0 0 0 0 0 0 0
$definebone "DustCover" "Weapon" -0.665847 3.477695 2.269095 -0 0 0.000057 0 0 0 0 0 0
$definebone "Magazine_Release" "Weapon" -0.006288 4.178158 1.057485 -0 0 0.000057 0 0 0 0 0 0
$definebone "Magazine" "Weapon" 0.037367 2.635598 -1.334266 -0 0 0.000057 0 0 0 0 0 0
$definebone "Bullet" "Magazine" -0.174255 0.505857 3.360352 -0 0 0 0 0 0 0 0 0
$definebone "Bullet_2" "Magazine" 0.014291 0.505857 3.121574 -0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Weapon" 0.040949 6.055264 0.892183 -0 0 0.000057 0 0 0 0 0 0
$definebone "A_Suppressor" "Weapon" 0.016964 -18.515348 2.541246 -0 179.99995 -0.000057 0 0 0 0 0 0
$definebone "A_Muzzle" "Weapon" 0.022494 -19.748304 2.539137 -0 -89.999968 89.999968 0 0 0 0 0 0
$definebone "A_UnderBarrel" "Weapon" -0.91062 -13.172815 2.531399 0.000057 -90.00003 -90.00003 0 0 0 0 0 0
$definebone "Bipod" "A_UnderBarrel" -3.480284 2.046947 0.93866 89.999975 -90.00003 0 0 0 0 0 0 0
$definebone "Bipod_Left" "Bipod" 0.782162 -0.000002 -0.319805 -65.000001 -179.999896 89.999914 0 0 0 0 0 0
$definebone "Bipod_Right" "Bipod" -0.782096 -0.000004 -0.319805 64.999939 179.999827 -90.000146 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "Weapon" -0.950814 -7.898512 2.485385 0.000115 -90.00003 179.999964 0 0 0 0 0 0
$definebone "A_GL" "Weapon" 0.02472 -2.024908 1.422118 0.000057 -90.00003 90.00003 0 0 0 0 0 0
$definebone "GL_Base" "A_GL" 0 -0 -0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Slide" "GL_Base" 1.891411 -1.591587 0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Trigger" "GL_Base" -2.772263 -2.006649 -0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Round" "GL_Base" 3.309917 -1.59422 0.001201 89.999975 89.999975 0 0 0 0 0 0 0
$definebone "GL_Casing" "GL_Base" 4.085115 -1.594219 0.001201 89.999975 89.999975 0 0 0 0 0 0 0
$definebone "M203_Slide_Release" "GL_Base" 4.013391 -0.151551 -0.688799 89.999975 89.999975 0 0 0 0 0 0 0
$definebone "A_Eject" "Weapon" -0.496131 2.887262 2.652126 -24.317246 179.999827 0 0 0 0 0 0 0
$definebone "A_Optic" "Weapon" 0.031988 4.874125 3.698847 -0 179.99995 -90.00003 0 0 0 0 0 0
$definebone "Trigger_m16" "Weapon" 0.040949 5.989647 0.389903 -0 0 0 0 0 0 0 0 0
$definebone "Bipod_Main" "" 8.098196 -21.222406 -0.376701 -26.181358 -38.33723 81.044074 0 0 0 0 0 0
$definebone "A_Bipod" "Bipod_Main" -0.000004 -9.774025 -0.000003 0.000007 0.000006 -0.000002 0 0 0 0 0 0
$definebone "Bipod_RightLeg" "Bipod_Main" 0 -1.188226 1.002605 24.963365 93.309434 -88.602013 0 0 0 0 0 0
$definebone "Bipod_LeftLeg" "Bipod_Main" 0.000004 -1.188228 -1.002703 24.963372 -86.69053 -88.601958 0 0 0 0 0 0
$definebone "l_armtwist_4" "ValveBiped.Bip01_L_ForeTwist6" -1.229098 -0.098783 -0.063416 -0.002693 3.063892 -0.120092 0 0 0 0 0 0
$definebone "l_armtwist_3" "ValveBiped.Bip01_L_ForeTwist4" -0.687423 -0.200492 -0.062453 0.013522 3.06372 -0.132926 0 0 0 0 0 0
$definebone "l_armtwist_2" "ValveBiped.Bip01_L_ForeTwist2" -0.386811 -0.315084 -0.060287 0.029679 3.063549 -0.14576 0 0 0 0 0 0
$definebone "l_armtwist_1" "ValveBiped.Bip01_L_ForeTwist1" -1.473238 -0.438566 -0.05792 0.037815 3.063435 -0.158423 0 0 0 0 0 0
$definebone "r_armtwist_1" "ValveBiped.Bip01_R_ForeTwist1" -1.389067 -0.414085 0.026888 0.114993 1.926689 -175.820448 0 0 0 0 0 0
$definebone "r_armtwist_4" "ValveBiped.Bip01_R_ForeTwist6" -1.139463 -0.200615 0.01682 0.140604 1.924798 -175.821077 0 0 0 0 0 0
$definebone "r_armtwist_3" "ValveBiped.Bip01_R_ForeTwist5" -1.817344 -0.264396 0.020776 0.135447 1.925314 -175.820804 0 0 0 0 0 0
$definebone "r_armtwist_2" "ValveBiped.Bip01_R_ForeTwist3" -1.518572 -0.33637 0.024041 0.125191 1.926115 -175.82053 0 0 0 0 0 0

$bonemerge "ValveBiped.Bip01_L_Clavicle"
$bonemerge "ValveBiped.Bip01_L_UpperArm"
$bonemerge "ValveBiped.Bip01_L_Forearm"
$bonemerge "ValveBiped.Bip01_L_Hand"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger02"
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
$bonemerge "ValveBiped.Bip01_R_Clavicle"
$bonemerge "ValveBiped.Bip01_R_UpperArm"
$bonemerge "ValveBiped.Bip01_R_Forearm"
$bonemerge "ValveBiped.Bip01_R_Hand"
$bonemerge "ValveBiped.Bip01_R_Finger0"
$bonemerge "ValveBiped.Bip01_R_Finger01"
$bonemerge "ValveBiped.Bip01_R_Finger02"
$bonemerge "ValveBiped.Bip01_R_Finger1"
$bonemerge "ValveBiped.Bip01_R_Finger11"
$bonemerge "ValveBiped.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger2"
$bonemerge "ValveBiped.Bip01_R_Finger21"
$bonemerge "ValveBiped.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger3"
$bonemerge "ValveBiped.Bip01_R_Finger31"
$bonemerge "ValveBiped.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_R_Finger4"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "ValveBiped.Bip01_R_Finger42"


$sequence "base_idle" {
	"c_m416_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 1
	loop
}

$sequence "base_draw" {
	"c_m416_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "base_fire" {
	"c_m416_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 28
}

$sequence "base_reload" {
	"c_m416_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 15 "bf3_m416.clipout" }
	{ event 5004 58 "bf3_m416.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "base_reload_empty" {
	"c_m416_anims/base_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 15 "bf3_m416.clipout" }
	{ event 5004 62 "bf3_m416.clipin" }
	{ event 5004 89 "bf3_m416.boltcatch" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "foregrip_idle" {
	"c_m416_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"c_m416_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "foregrip_fire" {
	"c_m416_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 28
}

$sequence "foregrip_reload" {
	"c_m416_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 15 "bf3_m416.clipout" }
	{ event 5004 58 "bf3_m416.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "foregrip_reload_empty" {
	"c_m416_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 15 "bf3_m416.clipout" }
	{ event 5004 62 "bf3_m416.clipin" }
	{ event 5004 85 "bf3_m416.boltcatch" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

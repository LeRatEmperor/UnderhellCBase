// 

$modelname "weapons/c_870mcs.mdl"

$bodygroup "870mcs"
{
	studio "870mcs.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition -3.27 -6.451 -11.676

$cdmaterials "models/bf3/weapons/shotguns/"
$cdmaterials "models/bf3/weapons/att/"

$texturegroup "skinfamilies"
{
	{
		"shell"
		"870mcs"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 0 0
$attachment "muzzle_supp" "A_Muzzle_Supp" 0 0 0 rotate -0 0 0
$attachment "2" "A_Eject" 0 0 0 rotate 0 -0 0
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 0 0 0 rotate 0 0 0
$attachment "Suppressor" "A_Suppressor" 0 0 0 rotate -0 0 0
$attachment "Laser" "A_Underbarrel" 0 0 0 rotate -0 0 0
$attachment "Modkit" "A_Modkit" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 0
$attachment "Foregrip" "A_Foregrip" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -17.925 -15.376 -25.946 30.827 8.836 2.593

$definebone "ValveBiped.Bip01_L_Clavicle" "" 3.491543 8.830969 -9.976974 -0 0.000057 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853647 -0.000001 0 2.606728 -90.521187 -90.385915 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390537 -0.000002 0.000003 0 -6.123426 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525429 -0.000002 -0.000002 2.75306 3.862882 -91.214697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555143 0.315173 -0.822493 36.110694 33.914147 115.151539 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556972 0.000005 -0.000001 -0.00002 9.529354 0.000014 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.221089 -0.000002 0.000003 -0.000031 13.764658 0.000007 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828095 -0.20948 -1.286462 1.166311 -3.007111 7.05947 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.38252 0.000001 0.000005 -0.000002 5.705103 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865905 -0.000001 -0.000003 -0.000002 1.676688 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813036 -0.266272 -0.544265 -0.523168 -4.898958 4.980263 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445752 0.000002 0.000003 -0.000001 8.189848 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053756 -0.000002 0.000003 -0.000001 -1.493994 0.000007 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.689442 -0.342859 0.236191 -0.363542 -3.72474 7.466499 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439797 -0.000003 0 0 3.307798 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.98299 0 -0.000001 0 -5.220037 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426954 -0.353601 1.013784 -0.774237 -8.67841 5.197185 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104664 0.000001 0.000001 0.000001 4.531697 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908442 0.000002 -0.000003 0.000002 -3.232676 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_Forearm" 0 0 0 0 0.000005 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217918 -0.000003 -0.000001 0 0.000005 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217918 -0.000001 -0.000003 0 0.000005 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.217917 0 -0.000005 0 0.000005 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217917 0.000003 -0.000001 0 0.000004 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.217918 0 -0.000004 0 0.000004 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217916 -0.000001 0.000002 0 0.000005 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" 0.47538 8.830965 -9.976974 -0 -179.999909 -179.999937 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000003 0 -2.606728 -90.521187 90.385915 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.39054 -0.000002 0 -0 -6.123427 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525432 0 0 -2.75306 3.862882 91.214697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.555141 0.31517 0.822497 -36.110718 33.914157 -115.151539 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556973 -0.000001 -0.000001 0.000019 9.529332 -0.000006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221089 -0.000003 -0.000001 0.000022 13.764633 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828094 -0.209482 1.286462 -1.166311 -3.00711 -7.05947 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382519 0 -0.000003 0.000002 5.705106 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.865911 -0 0.000003 0.000002 1.676693 -0.000004 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813035 -0.266277 0.544266 0.523168 -4.898957 -4.980263 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445758 0 0.000001 0.000001 8.189853 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053752 0 -0.000003 0.000002 -1.493993 -0.000006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.689445 -0.342861 -0.236184 0.363542 -3.724739 -7.466499 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439795 0.000001 0.000001 0.000001 3.3078 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.98299 -0 0 0 -5.220037 -0.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426956 -0.353605 -1.013782 0.774238 -8.678414 -5.197187 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104669 -0 0.000001 -0 4.531693 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908442 -0.000001 0.000001 -0.000001 -3.232681 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_Forearm" -0 0 0 -0 0.000005 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217917 0.000002 -0 -0 0.000006 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.217919 0 0 -0 0.000005 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217918 0.000002 0 -0 0.000005 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.217917 -0.000001 0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.217918 0.000001 0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.217916 0 0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999914 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "(null)" 0 0 0 -89.999975 -89.999914 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 3.24214 -0.005069 0.000005 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 6.363438 -0.005069 0 -0 -0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 6.363435 -0.002059 0 -0 -0 0 0 0 0 0 0 0
$definebone "Weapon" "" -2.006258 -11.175688 -2.336329 -0 0 0 0 0 0 0 0 0
$definebone "Shell" "Weapon" -4.706641 10.038044 -6.763193 -0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Weapon" -0.000262 4.94468 -0.918392 -0 0 0 0 0 0 0 0 0
$definebone "Pump" "Weapon" -0.000262 -5.844028 -0.621645 -0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Pump" -0.301779 7.450962 0.930556 -0 0 0 0 0 0 0 0 0
$definebone "A_Foregrip" "Pump" 0.003436 -1.40336 -1.006513 -0 179.999937 0 0 0 0 0 0 0
$definebone "Shell_2" "Weapon" 0.004375 -0.547402 -0.651955 -0 0 0 0 0 0 0 0 0
$definebone "A_Modkit" "Weapon" -0.009132 1.080424 0.989291 -0 179.999937 -89.999968 0 0 0 0 0 0
$definebone "A_Optic" "Weapon" -0.005354 1.542797 1.321645 -0 179.999937 -89.999914 0 0 0 0 0 0
$definebone "A_Underbarrel" "Weapon" -1.232874 -15.750898 -0.527484 -0 -90.000023 -90.000023 0 0 0 0 0 0
$definebone "A_Suppressor" "Weapon" 0.000793 -19.229965 0.464693 -0 179.999937 0 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "Weapon" -0.001309 -16.437506 -0.573479 0.000057 -89.999975 -89.999975 0 0 0 0 0 0
$definebone "A_Muzzle" "Weapon" 0.001232 -19.172737 0.469255 -0 -90.000023 90.000023 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "Weapon" 0.001232 -30.411051 0.469257 -0 -90.000023 90.000023 0 0 0 0 0 0
$definebone "A_Eject" "Weapon" -0.504499 1.405825 0.331594 6.464452 171.11009 -1.244636 0 0 0 0 0 0
$definebone "A_Muzzle_Ironsight" "Weapon" 2.006258 -19.597813 2.336333 -0.000057 -90.000084 0 0 0 0 0 0 0
$definebone "Shell_3" "Weapon" 0.004375 -0.547402 -0.651955 -0 0 0 0 0 0 0 0 0

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


$sequence "idle" {
	"c_870mcs_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "draw" {
	"c_870mcs_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

$sequence "fire1" {
	"c_870mcs_anims/fire1.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event 5004 3 "bf3_870mcs.pump" }
	fadein 0.2
	fadeout 0.2
	fps 25
}

$sequence "fire2" {
	"c_870mcs_anims/fire2.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event AE_CL_CREATE_PARTICLE_BRASS 4 "" }
	{ event 5004 3 "bf3_870mcs.pump" }
	fadein 0.2
	fadeout 0.2
	fps 25
}

$sequence "reload_insert" {
	"c_870mcs_anims/reload_insert.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 5 "bf3.insert" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 50
}

$sequence "reload_start" {
	"c_870mcs_anims/reload_start.smd"
	activity "ACT_SHOTGUN_RELOAD_START" 1
	fadein 0.2
	fadeout 0.2
	fps 50
}

$sequence "reload_end" {
	"c_870mcs_anims/reload_end.smd"
	activity "ACT_SHOTGUN_RELOAD_FINISH" 1
	fadein 0.2
	fadeout 0.2
	fps 50
}

// 

$modelname "weapons/c_m1014.mdl"

$bodygroup "870mcs"
{
	studio "870mcs.smd"
}
// REMOVED: hands bodygroup


$surfaceprop "default"

$contents "solid"

$illumposition -3.27 -6.451 -11.676

$cdmaterials "models\bf3\weapons\shotguns\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"shell"
		"m1014"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 -0 0
$attachment "muzzle_supp" "A_Muzzle_Supp" 0 0 0 rotate -0 -0 0
$attachment "2" "A_Eject" 0 0 0 rotate 0 -0 0
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 0 0 0 rotate 0 0 0
$attachment "Suppressor" "A_Suppressor" 0 0 0 rotate -0 0 0
$attachment "Laser" "A_Underbarrel" 0 0 0 rotate -0 -0 0
$attachment "Modkit" "A_Modkit" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 0
$attachment "Foregrip" "A_Foregrip" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -17.925 -15.376 -25.946 30.827 8.836 2.593

$definebone "L Clavicle" "" 3.491543 8.830969 -9.976974 0 0.000057 0 0 0 0 0 0 0
$definebone "L UpperArm" "L Clavicle" 5.853647 -0.000001 0 2.606709 -90.52118 -90.385901 0 0 0 0 0 0
$definebone "L Forearm" "L UpperArm" 10.390535 -0.000002 0.000001 -0 -6.123426 0 0 0 0 0 0 0
$definebone "L Hand" "L Forearm" 8.525425 -0.000002 0 2.753062 3.862882 -91.214711 0 0 0 0 0 0
$definebone "L Finger0" "L Hand" 0.555143 0.315172 -0.822494 36.110722 33.914171 115.151566 0 0 0 0 0 0
$definebone "L Finger01" "L Finger0" 1.556972 0.000002 -0.000002 -0.000005 9.52932 0 0 0 0 0 0 0
$definebone "L Finger02" "L Finger01" 1.22109 -0.000002 0.000001 -0.000012 13.764626 -0.000003 0 0 0 0 0 0
$definebone "L Finger1" "L Hand" 2.828093 -0.209482 -1.286462 1.166311 -3.007112 7.059473 0 0 0 0 0 0
$definebone "L Finger11" "L Finger1" 1.382519 0.000001 0.000004 -0.000003 5.705115 0 0 0 0 0 0 0
$definebone "L Finger12" "L Finger11" 0.865905 -0.000001 -0.000003 -0.000003 1.676707 0 0 0 0 0 0 0
$definebone "L Finger2" "L Hand" 2.813033 -0.266274 -0.544265 -0.523171 -4.898962 4.980264 0 0 0 0 0 0
$definebone "L Finger21" "L Finger2" 1.445751 0 0 -0.000003 8.18986 0.000003 0 0 0 0 0 0
$definebone "L Finger22" "L Finger21" 1.053753 -0.000002 0.000002 -0.000003 -1.49399 0.000003 0 0 0 0 0 0
$definebone "L Finger3" "L Hand" 2.689438 -0.34286 0.236189 -0.363545 -3.72474 7.4665 0 0 0 0 0 0
$definebone "L Finger31" "L Finger3" 1.439796 -0.000002 -0.000001 -0.000003 3.307803 0 0 0 0 0 0 0
$definebone "L Finger32" "L Finger31" 0.98299 0.000001 -0.000001 -0.000003 -5.220043 0.000003 0 0 0 0 0 0
$definebone "L Finger4" "L Hand" 2.426952 -0.353602 1.013784 -0.774241 -8.678418 5.197188 0 0 0 0 0 0
$definebone "L Finger41" "L Finger4" 1.104664 0.000001 0 -0.000003 4.531697 -0.000001 0 0 0 0 0 0
$definebone "L Finger42" "L Finger41" 0.908442 0.000001 -0.000001 -0.000003 -3.232686 -0.000001 0 0 0 0 0 0
$definebone "L ForeTwist" "L Forearm" -0 0 0 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "L ForeTwist1" "L ForeTwist" 1.217918 -0.000003 0 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "L ForeTwist2" "L ForeTwist1" 1.217918 -0.000001 -0.000003 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "L ForeTwist3" "L ForeTwist2" 1.217917 -0.000001 -0.000004 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "L ForeTwist4" "L ForeTwist3" 1.217916 0.000002 -0.000001 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "L ForeTwist5" "L ForeTwist4" 1.217918 0 -0.000003 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "L ForeTwist6" "L ForeTwist5" 1.217916 -0.000002 0.000001 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "R Clavicle" "" 0.47538 8.830965 -9.976974 -0.000019 -179.999937 180.000005 0 0 0 0 0 0
$definebone "R UpperArm" "R Clavicle" 5.853648 0.000001 0 -2.606709 -90.52118 90.385901 0 0 0 0 0 0
$definebone "R Forearm" "R UpperArm" 10.390536 -0.000002 0 -0 -6.123426 0 0 0 0 0 0 0
$definebone "R Hand" "R Forearm" 8.525427 0.000001 0 -2.753062 3.862882 91.214711 0 0 0 0 0 0
$definebone "R Finger0" "R Hand" 0.55514 0.315171 0.822496 -36.110712 33.914171 -115.151566 0 0 0 0 0 0
$definebone "R Finger01" "R Finger0" 1.556972 0 0 -0.000002 9.529332 -0.000003 0 0 0 0 0 0
$definebone "R Finger02" "R Finger01" 1.221088 -0.000002 0 -0.000005 13.764635 -0.000003 0 0 0 0 0 0
$definebone "R Finger1" "R Hand" 2.828091 -0.209481 1.286462 -1.166311 -3.007112 -7.059472 0 0 0 0 0 0
$definebone "R Finger11" "R Finger1" 1.382519 0 -0.000002 0.000002 5.70511 0.000003 0 0 0 0 0 0
$definebone "R Finger12" "R Finger11" 0.86591 -0 0.000003 0.000002 1.6767 0.000003 0 0 0 0 0 0
$definebone "R Finger2" "R Hand" 2.813031 -0.266276 0.544264 0.523168 -4.89896 -4.980265 0 0 0 0 0 0
$definebone "R Finger21" "R Finger2" 1.445755 -0 0 0.000001 8.18986 -0.000003 0 0 0 0 0 0
$definebone "R Finger22" "R Finger21" 1.05375 -0 -0.000003 0.000002 -1.493987 -0.000003 0 0 0 0 0 0
$definebone "R Finger3" "R Hand" 2.689442 -0.34286 -0.236188 0.363542 -3.72474 -7.4665 0 0 0 0 0 0
$definebone "R Finger31" "R Finger3" 1.439795 -0 0.000001 0.000001 3.307801 0.000001 0 0 0 0 0 0
$definebone "R Finger32" "R Finger31" 0.982989 0 0.000002 0.000001 -5.220044 -0.000001 0 0 0 0 0 0
$definebone "R Finger4" "R Hand" 2.426953 -0.353604 -1.013783 0.774238 -8.678418 -5.197187 0 0 0 0 0 0
$definebone "R Finger41" "R Finger4" 1.104666 0 0.000001 -0 4.531694 0 0 0 0 0 0 0
$definebone "R Finger42" "R Finger41" 0.908442 -0 0.000002 -0 -3.232686 0.000001 0 0 0 0 0 0
$definebone "R ForeTwist" "R Forearm" 0 0 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "R ForeTwist1" "R ForeTwist" 1.217917 0.000002 -0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "R ForeTwist2" "R ForeTwist1" 1.217918 -0.000001 -0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "R ForeTwist3" "R ForeTwist2" 1.217918 0.000002 0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "R ForeTwist4" "R ForeTwist3" 1.217916 -0.000001 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "R ForeTwist5" "R ForeTwist4" 1.217918 0.000001 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "R ForeTwist6" "R ForeTwist5" 1.217916 0 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "Pelvis" "(null)" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "Spine" "Pelvis" 3.24214 -0.005069 0.000005 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "Spine1" "Spine" 6.363438 -0.005069 0 -0 -0 0 0 0 0 0 0 0
$definebone "Neck" "Spine1" 6.363436 -0.002058 0 -0 -0 0 0 0 0 0 0 0
$definebone "Weapon" "" -2.006258 -11.175688 -2.336329 0 0 0 0 0 0 0 0 0
$definebone "Shell" "Weapon" -4.706641 10.038044 -6.763193 -0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Weapon" -0.000262 4.94468 -0.918392 -0 0 0 0 0 0 0 0 0
$definebone "Pump" "Weapon" -0.000262 -5.844028 -0.621645 -0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Pump" -0.301779 7.450962 0.930556 -0 0 0 0 0 0 0 0 0
$definebone "A_Foregrip" "Pump" 0.003436 -1.40336 -1.006513 -0 179.999964 0 0 0 0 0 0 0
$definebone "Shell_2" "Weapon" 0.004375 -0.547402 -0.651955 -0 0 0 0 0 0 0 0 0
$definebone "A_Modkit" "Weapon" -0.009132 1.080424 0.989291 -0 179.999964 -89.999982 0 0 0 0 0 0
$definebone "A_Optic" "Weapon" -0.005354 1.542797 1.321645 -0 179.999964 -89.999921 0 0 0 0 0 0
$definebone "A_Underbarrel" "Weapon" -1.232874 -15.750898 -0.527484 -0.000019 -90.000016 -90.000016 0 0 0 0 0 0
$definebone "A_Suppressor" "Weapon" 0.000793 -19.229965 0.464693 -0 179.999978 0 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "Weapon" -0.001309 -16.437506 -0.573479 0.000057 -89.999982 -89.999982 0 0 0 0 0 0
$definebone "A_Muzzle" "Weapon" 0.001232 -19.172737 0.469255 0.000019 -90.000016 90.000016 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "Weapon" 0.001232 -30.411051 0.469257 0.000019 -90.000016 90.000016 0 0 0 0 0 0
$definebone "A_Eject" "Weapon" -0.504499 1.405825 0.331594 6.464453 171.110118 -1.244636 0 0 0 0 0 0
$definebone "A_Muzzle_Ironsight" "Weapon" 2.006258 -19.597813 2.336333 -0.000057 -90.000098 0 0 0 0 0 0 0
$definebone "Shell_3" "Weapon" 0.004375 -0.547402 -0.651955 -0 0 0 0 0 0 0 0 0


$include "c_arms_definebones.qci"

$sequence "idle" {
	"m1014_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "draw" {
	"m1014_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

$sequence "fire1" {
	"m1014_anims/fire1.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	fps 25
}

$sequence "fire2" {
	"m1014_anims/fire2.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	fps 25
}

$sequence "reload_insert" {
	"m1014_anims/reload_insert.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 5 "bf3.insert" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 50
}

$sequence "reload_start" {
	"m1014_anims/reload_start.smd"
	activity "ACT_SHOTGUN_RELOAD_START" 1
	fadein 0.2
	fadeout 0.2
	fps 50
}

$sequence "reload_end" {
	"m1014_anims/reload_end.smd"
	activity "ACT_SHOTGUN_RELOAD_FINISH" 1
	fadein 0.2
	fadeout 0.2
	fps 50
}

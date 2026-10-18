<<<<<<< HEAD
// Decompiled from ump45.mdl
$modelname "weapons/c_ump45.mdl"

$bodygroup "sight"
{
	studio "ump45.smd"
}
$bodygroup "barrel"
{
	studio "ump45.smd"
}
$bodygroup "grip"
{
	studio "ump45.smd"
}
$bodygroup "laser"
{
	studio "ump45.smd"
}
$bodygroup "mp5k"
{
	studio "ump45.smd"
}
$bodygroup "hands"
{
	blank
}

$surfaceprop "default"
$contents "solid"
$illumposition -1.471000 0.632000 -7.332000

$cdmaterials ""
$cdmaterials ""
$cdmaterials ""
=======
// 

$modelname "bf3\weapons\ump45.mdl"

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
$bodygroup "hands"
{
	studio "hands.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 0.632 1.471 -7.332

$cdmaterials "models\bf3\weapons\smg\"
$cdmaterials "models\bf3\weapons\att\"
$cdmaterials "models\weapons\v_models\hands\"
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3

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
		"v_hands"
		"sleeve_diffuse"
	}
}

<<<<<<< HEAD
$bbox -17.077000 -8.127000 -18.665001 14.136000 9.392000 4.001000
$cbox 0 0 0 0 0 0

$attachment "muzzle" "A_Muzzle" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "muzzle_supp" "A_Muzzle_Supp" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "2" "A_Eject" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 1.000000 0.000000 -0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Suppressor" "A_Suppressor" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Modkit" "A_Modkit" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Laser" "A_Underbarrel" 1.000000 -0.000000 0.000000 rotate 0.000000 -0.000000 1.000000
$attachment "Optic" "A_Optic" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000

$definebone "L Clavicle" "" 3.491543 8.830969 -9.976974 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L UpperArm" "L Clavicle" 5.853647 -0.000001 0.000000 -0.487879 0.515110 -0.489086 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Forearm" "L UpperArm" 10.390535 -0.000002 0.000001 0.000000 -0.000000 -0.053412 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Hand" "L Forearm" 8.525425 -0.000002 0.000000 -0.714517 -0.007280 0.040727 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger0" "L Hand" 0.555143 0.315172 -0.822494 0.719176 0.393021 -0.101563 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger01" "L Finger0" 1.556972 0.000002 -0.000002 0.000000 -0.000000 0.083063 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger02" "L Finger01" 1.221090 -0.000002 0.000001 -0.000000 -0.000000 0.119830 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger1" "L Hand" 2.828093 -0.209482 -1.286462 0.061809 0.008540 -0.026814 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger11" "L Finger1" 1.382519 0.000001 0.000004 0.000000 -0.000000 0.049766 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger12" "L Finger11" 0.865905 -0.000001 -0.000003 0.000000 -0.000000 0.014632 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger2" "L Hand" 2.813033 -0.266274 -0.544265 0.043212 -0.006414 -0.042500 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger21" "L Finger2" 1.445751 0.000000 0.000000 0.000000 -0.000000 0.071409 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger22" "L Finger21" 1.053753 -0.000002 0.000002 0.000000 -0.000000 -0.013037 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger3" "L Hand" 2.689438 -0.342860 0.236189 0.064974 -0.005280 -0.032223 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger31" "L Finger3" 1.439796 -0.000002 -0.000001 0.000000 -0.000000 0.028862 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger32" "L Finger31" 0.982990 0.000001 -0.000001 0.000000 -0.000000 -0.045538 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger4" "L Hand" 2.426952 -0.353602 1.013784 0.044697 -0.010160 -0.075276 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger41" "L Finger4" 1.104664 0.000001 0.000000 -0.000000 -0.000000 0.039536 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L Finger42" "L Finger41" 0.908442 0.000001 -0.000001 -0.000000 -0.000000 -0.028207 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist" "L UpperArm" 10.390535 -0.000002 0.000001 -0.001325 0.000071 -0.053411 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist1" "L ForeTwist" 1.217918 -0.000003 0.000000 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist2" "L ForeTwist1" 1.217918 -0.000002 -0.000003 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist3" "L ForeTwist2" 1.217917 -0.000002 -0.000004 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist4" "L ForeTwist3" 1.217916 0.000003 -0.000001 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist5" "L ForeTwist4" 1.217918 0.000000 -0.000003 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist6" "L ForeTwist5" 1.217916 0.000000 0.000001 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Clavicle" "" 0.475380 8.830965 -9.976974 0.000001 -1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R UpperArm" "R Clavicle" 5.853648 0.000001 0.000000 0.487879 -0.515110 -0.489086 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Forearm" "R UpperArm" 10.390536 -0.000002 0.000000 0.000000 -0.000000 -0.053412 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Hand" "R Forearm" 8.525427 0.000001 0.000000 0.714517 0.007280 0.040727 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger0" "R Hand" 0.555140 0.315171 0.822496 -0.719176 -0.393021 -0.101563 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger01" "R Finger0" 1.556972 0.000000 0.000000 -0.000000 -0.000000 0.083063 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger02" "R Finger01" 1.221088 -0.000002 0.000000 -0.000000 -0.000000 0.119830 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger1" "R Hand" 2.828091 -0.209481 1.286462 -0.061809 -0.008540 -0.026814 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger11" "R Finger1" 1.382519 0.000000 -0.000002 0.000000 0.000000 0.049766 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger12" "R Finger11" 0.865910 -0.000000 0.000003 0.000000 0.000000 0.014631 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger2" "R Hand" 2.813031 -0.266276 0.544264 -0.043212 0.006414 -0.042499 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger21" "R Finger2" 1.445755 -0.000000 0.000000 -0.000000 0.000000 0.071409 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger22" "R Finger21" 1.053750 -0.000000 -0.000003 -0.000000 0.000000 -0.013037 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger3" "R Hand" 2.689442 -0.342860 -0.236188 -0.064974 0.005280 -0.032223 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger31" "R Finger3" 1.439795 -0.000000 0.000001 0.000000 0.000000 0.028862 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger32" "R Finger31" 0.982989 0.000000 0.000002 -0.000000 0.000000 -0.045538 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger4" "R Hand" 2.426953 -0.353604 -1.013783 -0.044697 0.010160 -0.075276 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger41" "R Finger4" 1.104666 0.000000 0.000001 0.000000 -0.000000 0.039536 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R Finger42" "R Finger41" 0.908442 -0.000000 0.000002 0.000000 -0.000000 -0.028207 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist" "R UpperArm" 10.390536 -0.000002 0.000000 0.001325 -0.000071 -0.053411 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist1" "R ForeTwist" 1.217917 0.000002 -0.000000 0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist2" "R ForeTwist1" 1.217918 -0.000002 -0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist3" "R ForeTwist2" 1.217918 0.000002 0.000000 0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist4" "R ForeTwist3" 1.217916 0.000001 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist5" "R ForeTwist4" 1.217918 0.000001 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist6" "R ForeTwist5" 1.217916 0.000001 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "(null)" "" 1.983461 8.830967 -25.945992 0.000000 0.000000 -0.707106 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Pelvis" "(null)" 0.000000 0.000000 0.000000 -0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Spine" "Pelvis" 3.242140 -0.005069 0.000005 -0.000002 -0.000000 0.000398 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Spine1" "Spine" 6.363438 -0.005069 0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Neck" "Spine1" 6.363436 -0.002058 0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Weapon" "" -2.298738 -13.281845 -2.129800 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Mag" "Weapon" 0.019234 -0.041479 -4.462178 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bolt" "Weapon" 0.023044 -2.547249 0.621049 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Trigger" "Weapon" -0.021224 3.457716 -2.593818 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle" "Weapon" 0.005319 -4.134012 -0.336203 0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Eject" "Weapon" -0.349484 1.587097 0.312025 0.164220 -0.000000 0.986424 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Eject_Port" "Weapon" -0.405838 1.555586 0.317452 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Mag_Rel" "Weapon" 0.032412 1.399686 -2.497452 0.535937 -0.461271 -0.535938 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Optic" "Weapon" -0.015144 2.885787 1.158291 -0.000000 0.698327 -0.715779 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Underbarrel" "Weapon" -1.106670 -4.449860 -0.326284 -0.505781 0.494151 -0.505781 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Modkit" "Weapon" -0.004948 1.979355 0.842694 -0.000000 -0.698835 0.715283 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Suppressor" "Weapon" -0.006518 -4.304943 -0.378902 0.000000 0.009444 0.999955 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle_Supp" "Weapon" 0.005317 -11.735769 -0.246849 0.499999 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_LaserFlashlight" "Weapon" -0.096618 -3.712847 -0.338035 -0.707107 0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Ringswing" "Weapon" 0.019403 7.194278 -0.321872 -0.004883 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle_Ironsight" "Weapon" 2.298738 -12.412628 2.129801 -0.001234 -0.001234 -0.707106 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

$sequence "base_idle" {
	"ump45_anims/base_idle.smd"
	fps 30
=======
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
$definebone "L ForeTwist" "L UpperArm" 10.390535 -0.000002 0.000001 -0 -6.123426 -0.152006 0 0 0 0 0 0
$definebone "L ForeTwist1" "L ForeTwist" 1.217918 -0.000003 0 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "L ForeTwist2" "L ForeTwist1" 1.217918 -0.000002 -0.000003 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "L ForeTwist3" "L ForeTwist2" 1.217917 -0.000002 -0.000004 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "L ForeTwist4" "L ForeTwist3" 1.217916 0.000003 -0.000001 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "L ForeTwist5" "L ForeTwist4" 1.217918 0 -0.000003 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "L ForeTwist6" "L ForeTwist5" 1.217916 0 0.000001 -0 0.000003 -0.152006 0 0 0 0 0 0
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
$definebone "R ForeTwist" "R UpperArm" 10.390536 -0.000002 0 -0 -6.123426 0.152006 0 0 0 0 0 0
$definebone "R ForeTwist1" "R ForeTwist" 1.217917 0.000002 -0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "R ForeTwist2" "R ForeTwist1" 1.217918 -0.000002 -0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "R ForeTwist3" "R ForeTwist2" 1.217918 0.000002 0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "R ForeTwist4" "R ForeTwist3" 1.217916 0.000001 0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "R ForeTwist5" "R ForeTwist4" 1.217918 0.000001 0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "R ForeTwist6" "R ForeTwist5" 1.217916 0.000001 0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "Pelvis" "(null)" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "Spine" "Pelvis" 3.24214 -0.005069 0.000005 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "Spine1" "Spine" 6.363438 -0.005069 0 -0 -0 0 0 0 0 0 0 0
$definebone "Neck" "Spine1" 6.363436 -0.002058 0 -0 -0 0 0 0 0 0 0 0
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


$sectionframes 30 120

$sequence "base_idle" {
	"ump45_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "base_draw" {
	"ump45_anims/base_draw.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "base_fire" {
	"ump45_anims/base_fire.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "base_reload" {
	"ump45_anims/base_reload.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_RELOAD" 1
	{ event 5004 21 "bf3_ump45.clipout" }
	{ event 5004 67 "bf3_ump45.clipin" }
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "base_reload_empty" {
	"ump45_anims/base_reload_empty.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 12 "bf3_ump45.boltback" }
	{ event 5004 44 "bf3_ump45.clipout" }
	{ event 5004 91 "bf3_ump45.clipin" }
	{ event 5004 111 "bf3_ump45.boltforward" }
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "foregrip_idle" {
	"ump45_anims/foregrip_idle.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "foregrip_draw" {
	"ump45_anims/foregrip_draw.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "foregrip_fire" {
	"ump45_anims/foregrip_fire.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "foregrip_reload" {
	"ump45_anims/foregrip_reload.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 21 "bf3_ump45.clipout" }
	{ event 5004 67 "bf3_ump45.clipin" }
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "foregrip_reload_empty" {
	"ump45_anims/foregrip_reload_empty.smd"
<<<<<<< HEAD
	fps 30
}

=======
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 12 "bf3_ump45.boltback" }
	{ event 5004 44 "bf3_ump45.clipout" }
	{ event 5004 91 "bf3_ump45.clipin" }
	{ event 5004 111 "bf3_ump45.boltforward" }
	fadein 0.2
	fadeout 0.2
	fps 30
}
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3

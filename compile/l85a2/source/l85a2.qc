<<<<<<< HEAD
// Decompiled from l85a2.mdl
=======
// 

>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
$modelname "weapons/c_l85a2.mdl"

$bodygroup "sight"
{
<<<<<<< HEAD
	studio "l85a2.smd"
}
$bodygroup "barrel"
{
	studio "l85a2.smd"
}
$bodygroup "grip"
{
	studio "l85a2.smd"
}
$bodygroup "laser"
{
	studio "l85a2.smd"
}
$bodygroup "l85"
{
	studio "l85a2.smd"
}
// REMOVED: hands bodygroup

$surfaceprop "default"
$contents "solid"
$illumposition -165.403000 -3.270000 -11.765000

$cdmaterials ""
$cdmaterials ""
$cdmaterials ""

$bbox -359.631012 -15.376000 -25.945999 28.825001 8.836000 2.416000
$cbox 0 0 0 0 0 0

$attachment "muzzle" "A_Muzzle" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "muzzle_gl" "A_GLMuzzle" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "muzzle_supp" "A_Muzzle_Supp" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "2" "A_Eject" 1.000000 0.000000 -0.000000 rotate 0.000000 -0.000000 -0.000000
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "camera" "camera" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Suppressor" "A_Suppressor" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Laser" "A_Underbarrel" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Optic" "A_Optic" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Foregrip" "A_Foregrip" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "GL" "A_M320" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000

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
$definebone "L ForeTwist" "L Forearm" -0.000000 0.000000 0.000000 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist1" "L ForeTwist" 1.217918 -0.000003 0.000000 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist2" "L ForeTwist1" 1.217918 -0.000001 -0.000003 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist3" "L ForeTwist2" 1.217917 -0.000001 -0.000004 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist4" "L ForeTwist3" 1.217916 0.000002 -0.000001 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist5" "L ForeTwist4" 1.217918 0.000000 -0.000003 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist6" "L ForeTwist5" 1.217916 -0.000002 0.000001 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
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
$definebone "R ForeTwist" "R Forearm" 0.000000 0.000000 0.000000 0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist1" "R ForeTwist" 1.217917 0.000002 -0.000000 0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist2" "R ForeTwist1" 1.217918 -0.000001 -0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist3" "R ForeTwist2" 1.217918 0.000002 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist4" "R ForeTwist3" 1.217916 -0.000001 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist5" "R ForeTwist4" 1.217918 0.000001 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist6" "R ForeTwist5" 1.217916 0.000000 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "(null)" "" 1.983461 8.830967 -25.945992 0.000000 0.000000 -0.707106 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Pelvis" "(null)" 0.000000 0.000000 0.000000 -0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Spine" "Pelvis" 3.242140 -0.005069 0.000005 -0.000002 -0.000000 0.000398 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Spine1" "Spine" 6.363438 -0.005069 0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Neck" "Spine1" 6.363436 -0.002058 0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "camera" "" 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Weapon" "" -2.713970 -11.748800 -6.307790 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Foregrip" "Weapon" -0.135258 -4.912109 1.377650 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Magazine_Release" "Weapon" 0.498615 6.268540 1.641960 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_LaserFlashlight" "Weapon" -0.893094 -7.215950 2.162810 0.707106 -0.707108 -0.000001 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Optic" "Weapon" -0.131894 3.146230 4.278380 -0.000001 -0.707108 0.707106 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Suppressor" "Weapon" -0.129447 -10.783499 2.983250 0.000000 0.000000 1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Underbarrel" "Weapon" 0.530026 -6.222080 1.769110 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Trigger" "Weapon" 0.040948 -0.153584 1.593130 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Magazine" "Weapon" 0.000000 6.321500 0.346421 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bolt" "Weapon" -0.131772 5.507290 3.049940 0.000000 -0.000000 -0.707108 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_M320" "Weapon" -0.129112 -6.619169 1.048890 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "M320_Main" "A_M320" 0.000000 3.600861 -0.705424 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "M320_Trigger" "M320_Main" 0.000000 -1.401131 -1.111530 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "M320_Tube_Release" "M320_Main" 0.000000 -2.243410 -1.008130 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "M320_Tube" "M320_Main" -0.966658 -7.977211 0.071462 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "M320_Casing" "M320_Tube" 0.966658 6.538799 0.011545 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "M320_Warhead" "M320_Casing" 0.000000 -1.404539 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Dust_Cover" "Weapon" -0.749347 8.670010 2.824980 0.690344 -0.690347 -0.153046 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle_Ironsight" "Weapon" 2.713960 -15.276100 6.307790 0.000000 -0.000000 -0.707108 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle" "Weapon" -0.127744 -12.949400 2.983000 0.500000 -0.500002 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Eject" "Weapon" -0.658979 6.386760 3.016520 -0.061629 -0.683013 -0.704416 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_GLMuzzle" "Weapon" -0.127744 -12.912199 0.479061 0.500000 -0.500002 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_GL" "Weapon" -0.129057 361.431000 -20.431400 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle_Supp" "Weapon" -0.127745 -19.400101 2.983000 0.500000 -0.500002 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "FireSelect" "Weapon" 0.458045 9.518270 1.680990 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

$BoneMerge "ValveBiped.Bip01_Spine4"
=======
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
$bodygroup "l85"
{
	studio "l85.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition -3.27 165.403 -11.765

$cdmaterials "models\bf3\weapons\rifles\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"l85a2_ironsight"
		"reticle"
		"reflex"
		"lens"
		"kobra"
		"acog"
		"reticle_acog"
		"eotech"
		"reticle_eotech"
		"lens_eotech"
		"l85a2"
		"muzzle"
		"suppressor"
		"grip"
		"laser"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 0 0
$attachment "muzzle_gl" "A_GLMuzzle" 0 0 0 rotate -0 0 0
$attachment "muzzle_supp" "A_Muzzle_Supp" 0 0 0 rotate -0 0 0
$attachment "2" "A_Eject" 0 -0 0 rotate -0 -0 -90
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 0 0 0 rotate -0 0 0
$attachment "camera" "camera" 0 0 0 rotate -0 0 0
$attachment "Suppressor" "A_Suppressor" 0 0 0 rotate -0 0 0
$attachment "Laser" "A_Underbarrel" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 -0
$attachment "Foregrip" "A_Foregrip" 0 0 0 rotate -0 0 0
$attachment "GL" "A_M320" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -359.631 -15.376 -25.946 28.825 8.836 2.416

$definebone "ValveBiped.Bip01_L_Clavicle" "" 3.491543 8.830969 -9.976974 1.596637 -1.286515 2.942962 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853647 -0.000001 0.000000 -1.579613 0.047802 -0.585173 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390535 -0.000002 0.000001 0.000000 0.000000 -0.060372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525425 -0.000002 0.000000 1.573183 -0.106613 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555143 0.315172 -0.822494 -1.222677 -0.679213 -0.788819 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556972 0.000002 -0.000002 0.000000 0.000000 0.228523 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.221090 -0.000002 0.000001 0.000000 0.000000 0.362860 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828093 -0.209482 -1.286462 0.354449 -0.042750 -0.531718 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382519 0.000001 0.000004 -0.000000 0.004074 -0.363009 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865905 -0.000001 -0.000003 0.000000 0.002596 -0.244331 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813033 -0.266274 -0.544265 0.085902 0.021830 -0.587867 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445751 0.000000 0.000000 -0.000000 0.005516 -0.366478 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053753 -0.000002 0.000002 0.000000 0.003084 -0.216400 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.689438 -0.342860 0.236189 -0.151780 0.073206 -0.810985 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439796 -0.000002 -0.000001 0.000000 0.000000 -0.247797 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.982990 0.000001 -0.000001 0.000000 0.000000 -0.430802 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426952 -0.353602 1.013784 -0.468133 0.151533 -0.880197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104664 0.000001 0.000000 0.000000 0.000000 -0.439720 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908442 0.000001 -0.000001 0.000000 0.000000 -0.244299 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_Forearm" -0 0 0 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217918 -0.000003 0 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217918 -0.000001 -0.000003 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.217917 -0.000001 -0.000004 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217916 0.000002 -0.000001 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.217918 0 -0.000003 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217916 -0.000002 0.000001 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" 0.475380 8.830965 -9.976974 -1.668475 1.286518 2.942953 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000001 0.000000 1.639479 -0.008065 -0.586846 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.390536 -0.000002 0.000000 0.000000 0.000000 -0.060372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525427 0.000001 0.000000 -1.564937 0.106606 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.555140 0.315171 0.822496 1.221731 0.673635 -0.793558 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556972 0.000000 0.000000 0.000000 0.000000 0.226893 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221088 -0.000002 0.000000 0.000000 0.000000 0.362905 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828091 -0.209481 1.286462 -0.354419 0.038567 -0.532001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382519 0.000000 -0.000002 0.000000 -0.006613 -0.362970 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.865910 -0.000000 0.000003 0.000000 -0.004211 -0.244312 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813031 -0.266276 0.544264 -0.085905 -0.026404 -0.587695 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445755 -0.000000 0.000000 -0.000000 -0.007974 -0.366436 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053750 -0.000000 -0.000003 0.000000 -0.004461 -0.216376 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.689442 -0.342860 -0.236188 0.150078 -0.079191 -0.810205 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439795 -0.000000 0.000001 0.000000 0.000000 -0.247771 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.982989 0.000000 0.000002 0.000000 0.000000 -0.430761 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426953 -0.353604 -1.013783 0.466236 -0.158066 -0.878825 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104666 0.000000 0.000001 0.000000 0.000000 -0.439672 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908442 -0.000000 0.000002 0.000000 0.000000 -0.244271 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_Forearm" 0 0 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217917 0.000002 -0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.217918 -0.000001 -0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217918 0.000002 0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.217916 -0.000001 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.217918 0.000001 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.217916 0 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Root" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "ValveBiped.Bip01_Root" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 3.24214 -0.005069 0.000005 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 6.363438 -0.005069 0 -0 -0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 6.363436 -0.002058 0 -0 -0 0 0 0 0 0 0 0
$definebone "camera" "" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "Weapon" "" -2.71397 -11.7488 -6.30779 0 0 0 0 0 0 0 0 0
$definebone "A_Foregrip" "Weapon" -0.135258 -4.912109 1.37765 -0 0 0 0 0 0 0 0 0
$definebone "Magazine_Release" "Weapon" 0.498615 6.26854 1.64196 -0 0 0 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "Weapon" -0.893094 -7.21595 2.16281 -0 -90.000207 179.999841 0 0 0 0 0 0
$definebone "A_Optic" "Weapon" -0.131894 3.14623 4.27838 -0 179.999841 -90.000207 0 0 0 0 0 0
$definebone "A_Suppressor" "Weapon" -0.129447 -10.783499 2.98325 -0 179.999841 0 0 0 0 0 0 0
$definebone "A_Underbarrel" "Weapon" 0.530026 -6.22208 1.76911 -0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Weapon" 0.040948 -0.153584 1.59313 -0 0 0 0 0 0 0 0 0
$definebone "Magazine" "Weapon" 0 6.3215 0.346421 -0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Weapon" -0.131772 5.50729 3.04994 -0 -90.000207 0 0 0 0 0 0 0
$definebone "A_M320" "Weapon" -0.129112 -6.619169 1.04889 -0 0 0 0 0 0 0 0 0
$definebone "M320_Main" "A_M320" 0 3.600861 -0.705424 -0 0 0 0 0 0 0 0 0
$definebone "M320_Trigger" "M320_Main" 0 -1.401131 -1.11153 -0 0 0 0 0 0 0 0 0
$definebone "M320_Tube_Release" "M320_Main" 0 -2.24341 -1.00813 -0 0 0 0 0 0 0 0 0
$definebone "M320_Tube" "M320_Main" -0.966658 -7.977211 0.071462 -0 0 0 0 0 0 0 0 0
$definebone "M320_Casing" "M320_Tube" 0.966658 6.538799 0.011545 -0 0 0 0 0 0 0 0 0
$definebone "M320_Warhead" "M320_Casing" 0 -1.404539 0 -0 0 0 0 0 0 0 0 0
$definebone "Dust_Cover" "Weapon" -0.749347 8.67001 2.82498 -0 -90.000207 154.999983 0 0 0 0 0 0
$definebone "A_Muzzle_Ironsight" "Weapon" 2.71396 -15.2761 6.30779 -0 -90.000207 0 0 0 0 0 0 0
$definebone "A_Muzzle" "Weapon" -0.127744 -12.9494 2.983 -0 -90.000207 90.000207 0 0 0 0 0 0
$definebone "A_Eject" "Weapon" -0.658979 6.38676 3.01652 -19.683509 -169.372613 86.383704 0 0 0 0 0 0
$definebone "A_GLMuzzle" "Weapon" -0.127744 -12.912199 0.479061 -0 -90.000207 90.000207 0 0 0 0 0 0
$definebone "A_GL" "Weapon" -0.129057 361.431 -20.4314 -0 0 0 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "Weapon" -0.127745 -19.400101 2.983 -0 -90.000207 90.000207 0 0 0 0 0 0
$definebone "FireSelect" "Weapon" 0.458045 9.51827 1.68099 -0 0 0 0 0 0 0 0 0

>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
$BoneMerge "ValveBiped.Bip01_L_Clavicle"
$BoneMerge "ValveBiped.Bip01_L_UpperArm"
$BoneMerge "ValveBiped.Bip01_L_Forearm"
$BoneMerge "ValveBiped.Bip01_L_Hand"
$BoneMerge "ValveBiped.Bip01_L_Finger0"
$BoneMerge "ValveBiped.Bip01_L_Finger01"
$BoneMerge "ValveBiped.Bip01_L_Finger02"
$BoneMerge "ValveBiped.Bip01_L_Finger1"
$BoneMerge "ValveBiped.Bip01_L_Finger11"
$BoneMerge "ValveBiped.Bip01_L_Finger12"
$BoneMerge "ValveBiped.Bip01_L_Finger2"
$BoneMerge "ValveBiped.Bip01_L_Finger21"
$BoneMerge "ValveBiped.Bip01_L_Finger22"
$BoneMerge "ValveBiped.Bip01_L_Finger3"
$BoneMerge "ValveBiped.Bip01_L_Finger31"
$BoneMerge "ValveBiped.Bip01_L_Finger32"
$BoneMerge "ValveBiped.Bip01_L_Finger4"
$BoneMerge "ValveBiped.Bip01_L_Finger41"
$BoneMerge "ValveBiped.Bip01_L_Finger42"
$BoneMerge "ValveBiped.Bip01_R_Clavicle"
$BoneMerge "ValveBiped.Bip01_R_UpperArm"
$BoneMerge "ValveBiped.Bip01_R_Forearm"
$BoneMerge "ValveBiped.Bip01_R_Hand"
$BoneMerge "ValveBiped.Bip01_R_Finger0"
$BoneMerge "ValveBiped.Bip01_R_Finger01"
$BoneMerge "ValveBiped.Bip01_R_Finger02"
$BoneMerge "ValveBiped.Bip01_R_Finger1"
$BoneMerge "ValveBiped.Bip01_R_Finger11"
$BoneMerge "ValveBiped.Bip01_R_Finger12"
$BoneMerge "ValveBiped.Bip01_R_Finger2"
$BoneMerge "ValveBiped.Bip01_R_Finger21"
$BoneMerge "ValveBiped.Bip01_R_Finger22"
$BoneMerge "ValveBiped.Bip01_R_Finger3"
$BoneMerge "ValveBiped.Bip01_R_Finger31"
$BoneMerge "ValveBiped.Bip01_R_Finger32"
$BoneMerge "ValveBiped.Bip01_R_Finger4"
$BoneMerge "ValveBiped.Bip01_R_Finger41"
$BoneMerge "ValveBiped.Bip01_R_Finger42"

<<<<<<< HEAD
$include "c_arms_definebones.qci"

$sequence "base_idle" {
	"l85a2_anims/base_idle.smd"
	fps 30
=======



$sequence "base_idle" {
	"l85a2_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "base_draw" {
	"l85a2_anims/base_draw.smd"
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
	"l85a2_anims/base_fire.smd"
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
	"l85a2_anims/base_reload.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_RELOAD" 1
	{ event 5004 22 "bf3_l85a2.clipout" }
	{ event 5004 68 "bf3_l85a2.clipin" }
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "base_reload_empty" {
	"l85a2_anims/base_reload_empty.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 22 "bf3_l85a2.clipout" }
	{ event 5004 73 "bf3_l85a2.clipin" }
	{ event 5004 104 "bf3_l85a2.boltpull" }
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "foregrip_idle" {
	"l85a2_anims/foregrip_idle.smd"
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
	"l85a2_anims/foregrip_draw.smd"
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
	"l85a2_anims/foregrip_fire.smd"
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
	"l85a2_anims/foregrip_reload.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 22 "bf3_l85a2.clipout" }
	{ event 5004 68 "bf3_l85a2.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "foregrip_reload_empty" {
	"l85a2_anims/foregrip_reload_empty.smd"
<<<<<<< HEAD
	fps 30
}

=======
	activity "ACT_VM_RELOADEMPTY_FOREGRIP" 1
	{ event 5004 22 "bf3_l85a2.clipout" }
	{ event 5004 73 "bf3_l85a2.clipin" }
	{ event 5004 104 "bf3_l85a2.boltpull" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3

<<<<<<< HEAD
// Decompiled from acwr.mdl
=======
// 

>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
$modelname "weapons/c_acwr.mdl"

$bodygroup "sight"
{
<<<<<<< HEAD
	studio "acwr.smd"
}
$bodygroup "barrel"
{
	studio "acwr.smd"
}
$bodygroup "grip"
{
	studio "acwr.smd"
}
$bodygroup "laser"
{
	studio "acwr.smd"
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
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}
$bodygroup "acwr"
{
	studio "acwr.smd"
}
<<<<<<< HEAD
// REMOVED: hands bodygroup

$surfaceprop "default"
$contents "solid"
$illumposition 13.379000 0.398000 -7.488000

$cdmaterials ""
$cdmaterials ""
$cdmaterials ""

$bbox -18.131001 -25.058001 -17.273001 27.955999 9.570000 4.074000
$cbox 0 0 0 0 0 0

$attachment "muzzle" "A_Muzzle" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "shell" "A_Eject" 1.000000 0.000000 0.000000 rotate -0.000000 0.000000 1.000000

$definebone "ValveBiped.Bip01_L_Clavicle" "" 3.491543 8.830969 -9.976974 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853647 -0.000001 0.000000 -0.487879 0.515110 -0.489086 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390537 -0.000002 0.000001 0.000000 -0.000000 -0.053412 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525425 0.000000 -0.000002 -0.714517 -0.007280 0.040727 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555143 0.315171 -0.822495 0.719176 0.393021 -0.101563 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556973 0.000002 0.000000 0.000000 -0.000000 0.083063 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.221090 0.000000 0.000000 0.000000 -0.000000 0.119830 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828094 -0.209480 -1.286461 0.061809 0.008540 -0.026814 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382519 0.000001 0.000004 0.000000 -0.000000 0.049766 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865904 -0.000001 -0.000002 0.000000 -0.000000 0.014631 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813034 -0.266274 -0.544264 0.043212 -0.006414 -0.042499 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445751 0.000000 -0.000001 0.000000 -0.000000 0.071409 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053756 -0.000003 0.000004 0.000000 -0.000000 -0.013037 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.689441 -0.342860 0.236190 0.064974 -0.005280 -0.032223 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439795 -0.000002 -0.000001 -0.000000 -0.000000 0.028862 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.982989 0.000002 0.000000 -0.000000 -0.000000 -0.045538 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426952 -0.353604 1.013784 0.044697 -0.010160 -0.075276 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104663 0.000000 0.000001 0.000000 0.000000 0.039536 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908442 0.000000 -0.000001 0.000000 0.000000 -0.028207 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_Forearm" 0.000000 0.000000 -0.000002 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217918 -0.000005 0.000000 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217918 0.000001 -0.000001 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.217916 0.000000 -0.000005 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217916 0.000001 -0.000002 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.217920 0.000000 -0.000003 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217916 -0.000003 0.000003 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Clavicle" "" 0.475380 8.830965 -9.976974 -0.000000 1.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000001 0.000000 0.487879 -0.515110 -0.489086 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.390539 -0.000001 0.000000 -0.000000 0.000000 -0.053412 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525430 0.000001 0.000000 0.714517 0.007280 0.040727 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.555141 0.315171 0.822494 -0.719176 -0.393021 -0.101563 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556972 0.000001 0.000000 -0.000000 0.000000 0.083063 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221089 -0.000002 -0.000001 0.000000 0.000000 0.119830 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828093 -0.209481 1.286462 -0.061809 -0.008540 -0.026814 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382517 -0.000000 0.000000 0.000000 0.000000 0.049766 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.865909 0.000000 0.000005 -0.000000 0.000000 0.014631 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813032 -0.266277 0.544264 -0.043212 0.006414 -0.042499 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445753 0.000000 0.000000 -0.000000 0.000000 0.071409 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053751 0.000000 -0.000005 -0.000000 0.000000 -0.013037 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.689445 -0.342860 -0.236189 -0.064974 0.005280 -0.032223 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439795 0.000000 0.000002 -0.000000 0.000000 0.028862 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.982989 0.000000 0.000004 -0.000000 0.000000 -0.045538 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426955 -0.353604 -1.013783 -0.044697 0.010160 -0.075276 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104665 -0.000000 -0.000001 -0.000000 0.000000 0.039536 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908442 0.000000 0.000003 0.000000 0.000000 -0.028207 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_Forearm" 0.000000 0.000000 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217917 0.000002 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.217918 0.000001 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217918 0.000002 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.217916 -0.000002 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.217918 0.000000 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.217916 -0.000002 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Weapon" "" -2.387503 -15.270334 -5.074594 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Charging_Handle" "Weapon" 0.066779 8.881084 3.401956 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bolt" "Charging_Handle" -0.095912 -5.251013 -0.854032 0.000000 -0.000000 -0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "DustCover" "Weapon" -0.665847 3.477695 2.269095 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Magazine_Release" "Weapon" -0.006288 4.178158 1.057485 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Magazine" "Weapon" 0.037367 2.635598 -1.334266 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bullet" "Magazine" -0.174255 0.505857 3.360352 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bullet_2" "Magazine" 0.014291 0.505857 3.121574 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Trigger" "Weapon" 0.040949 6.055264 0.892183 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Suppressor" "Weapon" 0.016964 -18.515348 2.541246 -0.000000 -0.000000 1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle" "Weapon" 0.022494 -19.748304 2.539137 0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_UnderBarrel" "Weapon" -0.910620 -13.172815 2.531399 -0.500000 0.500001 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bipod" "A_UnderBarrel" -3.480284 2.046947 0.938660 0.500000 0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bipod_Left" "Bipod" 0.782162 -0.000002 -0.319805 -0.379928 -0.596368 -0.596368 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bipod_Right" "Bipod" -0.782096 -0.000004 -0.319805 -0.379928 -0.596368 0.596368 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_LaserFlashlight" "Weapon" -0.950814 -7.898512 2.485385 0.707107 -0.707107 -0.000001 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_GL" "Weapon" 0.024720 -2.024908 1.422118 0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "GL_Base" "A_GL" 0.000000 -0.000000 -0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "GL_Slide" "GL_Base" 1.891411 -1.591587 0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "GL_Trigger" "GL_Base" -2.772263 -2.006649 -0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "GL_Round" "GL_Base" 3.309917 -1.594220 0.001201 -0.500000 0.500000 0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "GL_Casing" "GL_Base" 4.085115 -1.594219 0.001201 -0.500000 0.500000 0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "M203_Slide_Release" "GL_Base" 4.013391 -0.151551 -0.688799 -0.500000 0.500000 0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Eject" "Weapon" -0.496131 2.887262 2.652126 0.210619 -0.000000 0.977568 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Optic" "Weapon" 0.031988 4.874125 3.698847 -0.000000 -0.707107 0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Trigger_m16" "Weapon" 0.040949 5.989647 0.389903 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bipod_Main" "" 8.098196 -21.222406 -0.376701 0.541236 -0.370422 -0.104108 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Bipod" "Bipod_Main" -0.000004 -9.774027 -0.000003 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bipod_RightLeg" "Bipod_Main" 0.000000 -1.188227 1.002607 -0.580552 -0.389743 0.611774 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bipod_LeftLeg" "Bipod_Main" 0.000002 -1.188228 -1.002702 -0.389743 0.580552 -0.369853 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_thumb_tip" "ValveBiped.Bip01_L_Finger02" 0.185302 0.061439 0.053308 -0.037622 -0.027832 0.034722 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_thumb_mid" "ValveBiped.Bip01_L_Finger01" 0.323568 -0.165401 -0.006299 -0.038237 -0.031513 0.133003 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_thumb_low" "ValveBiped.Bip01_L_Finger0" 0.619302 -0.144023 -0.080420 -0.022526 -0.028904 0.043128 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_index_tip" "ValveBiped.Bip01_L_Finger12" -0.115993 0.136216 0.119473 0.731102 -0.051121 -0.032702 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_index_mid" "ValveBiped.Bip01_L_Finger11" 0.047288 0.105729 0.104320 0.728551 0.006661 0.021138 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_index_low" "ValveBiped.Bip01_L_Finger1" 0.197371 0.109627 0.136786 0.732327 0.009130 -0.009649 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_middle_tip" "ValveBiped.Bip01_L_Finger22" -0.144276 0.134282 0.011643 0.713150 0.066679 0.033040 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_middle_mid" "ValveBiped.Bip01_L_Finger21" 0.047011 0.012902 0.048841 0.710651 0.065974 0.035073 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_middle_low" "ValveBiped.Bip01_L_Finger2" 0.264223 0.064898 0.179358 0.712111 0.023978 -0.050703 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_ring_tip" "ValveBiped.Bip01_L_Finger32" -0.144176 0.021755 -0.012701 0.662051 0.075559 0.095196 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_ring_mid" "ValveBiped.Bip01_L_Finger31" 0.026010 0.091388 0.018706 0.667113 -0.008813 -0.038611 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_ring_low" "ValveBiped.Bip01_L_Finger3" 0.244611 0.119344 0.125546 0.663419 0.025503 -0.037241 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_pinky_tip" "ValveBiped.Bip01_L_Finger42" -0.205936 0.218742 -0.005672 0.628452 0.025847 0.064846 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_pinky_mid" "ValveBiped.Bip01_L_Finger41" 0.075369 0.171679 0.009089 0.627807 0.037496 0.028109 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_pinky_low" "ValveBiped.Bip01_L_Finger4" 0.303741 0.224130 0.022635 0.624496 -0.010888 -0.026163 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_wrist" "ValveBiped.Bip01_L_Hand" -0.483183 0.085919 0.039583 0.712835 -0.029385 -0.053007 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_armtwist_4" "ValveBiped.Bip01_L_ForeTwist6" -1.229097 -0.098784 -0.063417 -0.001047 -0.000052 0.026734 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_armtwist_3" "ValveBiped.Bip01_L_ForeTwist4" -0.687423 -0.200492 -0.062452 -0.001163 0.000087 0.026733 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_armtwist_2" "ValveBiped.Bip01_L_ForeTwist2" -0.386811 -0.315084 -0.060287 -0.001278 0.000225 0.026732 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_armtwist_1" "ValveBiped.Bip01_L_ForeTwist1" -1.473238 -0.438566 -0.057920 -0.001391 0.000293 0.026731 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_upperarm" "ValveBiped.Bip01_L_UpperArm" -2.016219 -0.514361 -1.382956 0.002147 -0.054566 0.004444 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_thumb_tip" "ValveBiped.Bip01_R_Finger02" 0.322366 0.024373 0.001706 -0.998703 0.002220 0.021548 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_thumb_mid" "ValveBiped.Bip01_R_Finger01" 0.472650 -0.205722 0.040339 -0.988715 -0.139523 0.024634 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_thumb_low" "ValveBiped.Bip01_R_Finger0" 0.746819 -0.152275 0.135880 -0.998870 -0.009475 0.036664 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_index_tip" "ValveBiped.Bip01_R_Finger12" -0.077940 -0.073040 0.031672 0.676556 -0.035399 -0.051529 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_index_mid" "ValveBiped.Bip01_R_Finger11" 0.178061 -0.058577 -0.009662 0.681103 -0.011574 -0.021449 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_index_low" "ValveBiped.Bip01_R_Finger1" 0.329236 0.031135 -0.096600 0.650409 -0.125208 -0.032254 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_middle_tip" "ValveBiped.Bip01_R_Finger22" -0.032540 0.096451 -0.016163 0.695960 0.021430 0.036897 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_middle_mid" "ValveBiped.Bip01_R_Finger21" 0.149344 0.050403 -0.032008 0.699277 0.012258 0.025458 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_middle_low" "ValveBiped.Bip01_R_Finger2" 0.356815 0.042253 -0.132234 0.696337 -0.020980 0.036736 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_ring_tip" "ValveBiped.Bip01_R_Finger32" -0.082891 0.161453 -0.001987 0.759888 0.002961 -0.057166 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_ring_mid" "ValveBiped.Bip01_R_Finger31" 0.101632 0.085271 -0.020671 0.765989 0.031657 0.041391 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_ring_low" "ValveBiped.Bip01_R_Finger3" 0.316779 0.085631 -0.076644 0.769751 -0.012943 0.019058 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_pinky_tip" "ValveBiped.Bip01_R_Finger42" -0.122939 0.121941 0.025749 0.770102 0.105885 0.060965 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_pinky_mid" "ValveBiped.Bip01_R_Finger41" 0.129879 0.151013 0.033729 0.775024 0.035387 0.030967 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_pinky_low" "ValveBiped.Bip01_R_Finger4" 0.358829 0.190007 0.032557 0.778104 -0.013579 -0.010091 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_wrist" "ValveBiped.Bip01_R_Hand" -0.404174 0.031242 0.107285 0.696334 -0.040460 -0.036450 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_armtwist_1" "ValveBiped.Bip01_R_ForeTwist1" -1.389066 -0.414084 0.026888 -0.999194 -0.016765 0.001616 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_armtwist_4" "ValveBiped.Bip01_R_ForeTwist6" -1.139462 -0.200615 0.016820 -0.999194 -0.016740 0.001838 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_armtwist_3" "ValveBiped.Bip01_R_ForeTwist5" -1.817343 -0.264395 0.020776 -0.999194 -0.016746 0.001794 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_armtwist_2" "ValveBiped.Bip01_R_ForeTwist3" -1.518572 -0.336370 0.024041 -0.999194 -0.016757 0.001705 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_upperarm" "ValveBiped.Bip01_R_UpperArm" -1.961136 -0.019127 0.960382 0.999138 -0.015280 -0.038490 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

$BoneMerge "ValveBiped.Bip01_Spine4"
=======
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition 0.398 -13.379 -7.488

$cdmaterials "models\bf3\weapons\rifles\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"acwr"
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
		"acwr_tape"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 0 0
$attachment "shell" "A_Eject" -0 0 -0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -18.131 -25.058 -17.273 27.956 9.57 4.074

$definebone "ValveBiped.Bip01_L_Clavicle" "" 3.491543 8.830969 -9.976974 1.596637 -1.286515 2.942962 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853647 -0.000001 0.000000 -1.579613 0.047802 -0.585173 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390537 -0.000002 0.000001 0.000000 0.000000 -0.060372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525425 0.000000 -0.000002 1.573183 -0.106613 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555143 0.315171 -0.822495 -1.222677 -0.679213 -0.788819 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556973 0.000002 0.000000 0.000000 0.000000 0.228523 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.221090 0.000000 0.000000 0.000000 0.000000 0.362860 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828094 -0.209480 -1.286461 0.354449 -0.042750 -0.531718 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382519 0.000001 0.000004 -0.000000 0.004074 -0.363009 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865904 -0.000001 -0.000002 0.000000 0.002596 -0.244331 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813034 -0.266274 -0.544264 0.085902 0.021830 -0.587867 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445751 0.000000 -0.000001 -0.000000 0.005516 -0.366478 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053756 -0.000003 0.000004 0.000000 0.003084 -0.216400 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.689441 -0.342860 0.236190 -0.151780 0.073206 -0.810985 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439795 -0.000002 -0.000001 0.000000 0.000000 -0.247797 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.982989 0.000002 0.000000 0.000000 0.000000 -0.430802 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426952 -0.353604 1.013784 -0.468133 0.151533 -0.880197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104663 0.000000 0.000001 0.000000 0.000000 -0.439720 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908442 0.000000 -0.000001 0.000000 0.000000 -0.244299 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_Forearm" 0 0 -0.000002 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217918 -0.000005 0 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217918 0.000001 -0.000001 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.217916 0 -0.000005 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217916 0.000001 -0.000002 -0 0 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.21792 0 -0.000003 -0 0 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217916 -0.000003 0.000003 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" 0.475380 8.830965 -9.976974 -1.668475 1.286518 2.942953 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000001 0.000000 1.639479 -0.008065 -0.586846 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.390539 -0.000001 0.000000 0.000000 0.000000 -0.060372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525430 0.000001 0.000000 -1.564937 0.106606 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.555141 0.315171 0.822494 1.221731 0.673635 -0.793558 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556972 0.000001 0.000000 0.000000 0.000000 0.226893 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221089 -0.000002 -0.000001 0.000000 0.000000 0.362905 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828093 -0.209481 1.286462 -0.354419 0.038567 -0.532001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382517 -0.000000 0.000000 0.000000 -0.006613 -0.362970 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.865909 0.000000 0.000005 0.000000 -0.004211 -0.244312 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813032 -0.266277 0.544264 -0.085905 -0.026404 -0.587695 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445753 0.000000 0.000000 -0.000000 -0.007974 -0.366436 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053751 0.000000 -0.000005 0.000000 -0.004461 -0.216376 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.689445 -0.342860 -0.236189 0.150078 -0.079191 -0.810205 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439795 0.000000 0.000002 0.000000 0.000000 -0.247771 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.982989 0.000000 0.000004 0.000000 0.000000 -0.430761 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426955 -0.353604 -1.013783 0.466236 -0.158066 -0.878825 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104665 -0.000000 -0.000001 0.000000 0.000000 -0.439672 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908442 0.000000 0.000003 0.000000 0.000000 -0.244271 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_Forearm" 0 0 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217917 0.000002 0 0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.217918 0.000001 0 0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217918 0.000002 0 0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.217916 -0.000002 0 0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.217918 0 0 0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.217916 -0.000002 0 0 0.000001 0.152006 0 0 0 0 0 0
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
	"acwr_anims/base_idle.smd"
	fps 30
=======


$sequence "base_idle" {
	"acwr_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 1
	loop
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "base_draw" {
	"acwr_anims/base_draw.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "base_fire" {
	"acwr_anims/base_fire.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 28
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "base_reload" {
	"acwr_anims/base_reload.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_RELOAD" 1
	{ event 5004 15 "bf3_acwr.clipout" }
	{ event 5004 58 "bf3_acwr.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "base_reload_empty" {
	"acwr_anims/base_reload_empty.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 15 "bf3_acwr.clipout" }
	{ event 5004 62 "bf3_acwr.clipin" }
	{ event 5004 89 "bf3_acwr.boltcatch" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "foregrip_idle" {
	"acwr_anims/foregrip_idle.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
	loop
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "foregrip_draw" {
	"acwr_anims/foregrip_draw.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "foregrip_fire" {
	"acwr_anims/foregrip_fire.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 28
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "foregrip_reload" {
	"acwr_anims/foregrip_reload.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 15 "bf3_acwr.clipout" }
	{ event 5004 58 "bf3_acwr.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "foregrip_reload_empty" {
	"acwr_anims/foregrip_reload_empty.smd"
<<<<<<< HEAD
	fps 30
}

=======
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 15 "bf3_acwr.clipout" }
	{ event 5004 62 "bf3_acwr.clipin" }
	{ event 5004 85 "bf3_acwr.boltcatch" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3

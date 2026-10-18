<<<<<<< HEAD
// Decompiled from famas.mdl
=======
// 

>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
$modelname "weapons/c_famas.mdl"

$bodygroup "sight"
{
<<<<<<< HEAD
	studio "famas.smd"
}
$bodygroup "barrel"
{
	studio "famas.smd"
}
$bodygroup "grip"
{
	studio "famas.smd"
}
$bodygroup "laser"
{
	studio "famas.smd"
=======
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
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}
$bodygroup "famas"
{
	studio "famas.smd"
}
<<<<<<< HEAD
// REMOVED: hands bodygroup

$surfaceprop "default"
$contents "solid"
$illumposition 3.647000 1.760000 -7.303000

$cdmaterials ""
$cdmaterials ""
$cdmaterials ""

$bbox -14.910000 -5.528000 -18.316999 22.204000 9.047000 3.712000
$cbox 0 0 0 0 0 0

$attachment "muzzle" "A_Muzzle" 1.000000 -0.000000 0.000000 rotate 0.000000 -0.000000 1.000000
$attachment "muzzle_supp" "A_Muzzle_Supp" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "2" "A_Eject" 1.000000 0.000000 0.000000 rotate -0.000000 0.000000 1.000000
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "camera" "camera" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Suppressor" "A_Suppressor" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Laser" "A_Underbarrel" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Optic" "A_Optic" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Foregrip" "A_Foregrip" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000

$definebone "ValveBiped.Bip01_L_Clavicle" "" 3.491543 8.830969 -9.976974 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853647 -0.000001 0.000000 -0.487879 0.515110 -0.489086 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390535 -0.000002 0.000001 0.000000 -0.000000 -0.053412 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525425 -0.000002 0.000000 -0.714517 -0.007280 0.040727 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555143 0.315172 -0.822494 0.719176 0.393021 -0.101563 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556972 0.000002 -0.000002 0.000000 -0.000000 0.083063 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.221090 -0.000002 0.000001 -0.000000 -0.000000 0.119830 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828093 -0.209482 -1.286462 0.061809 0.008540 -0.026814 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382519 0.000001 0.000004 0.000000 -0.000000 0.049766 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865905 -0.000001 -0.000003 0.000000 -0.000000 0.014632 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813033 -0.266274 -0.544265 0.043212 -0.006414 -0.042500 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445751 0.000000 0.000000 0.000000 -0.000000 0.071409 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053753 -0.000002 0.000002 0.000000 -0.000000 -0.013037 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.689438 -0.342860 0.236189 0.064974 -0.005280 -0.032223 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439796 -0.000002 -0.000001 0.000000 -0.000000 0.028862 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.982990 0.000001 -0.000001 0.000000 -0.000000 -0.045538 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426952 -0.353602 1.013784 0.044697 -0.010160 -0.075276 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104664 0.000001 0.000000 -0.000000 -0.000000 0.039536 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908442 0.000001 -0.000001 -0.000000 -0.000000 -0.028207 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist" "ValveBiped.Bip01_L_UpperArm" 10.390535 -0.000002 0.000001 -0.001325 0.000071 -0.053411 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist1" "L ForeTwist" 1.217918 -0.000003 0.000000 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist2" "L ForeTwist1" 1.217918 -0.000002 -0.000003 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist3" "L ForeTwist2" 1.217917 -0.000002 -0.000004 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist4" "L ForeTwist3" 1.217916 0.000003 -0.000001 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist5" "L ForeTwist4" 1.217918 0.000000 -0.000003 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist6" "L ForeTwist5" 1.217916 0.000000 0.000001 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Clavicle" "" 0.475380 8.830965 -9.976974 0.000001 -1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000001 0.000000 0.487879 -0.515110 -0.489086 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.390536 -0.000002 0.000000 0.000000 -0.000000 -0.053412 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525427 0.000001 0.000000 0.714517 0.007280 0.040727 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.555140 0.315171 0.822496 -0.719176 -0.393021 -0.101563 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556972 0.000000 0.000000 -0.000000 -0.000000 0.083063 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221088 -0.000002 0.000000 -0.000000 -0.000000 0.119830 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828091 -0.209481 1.286462 -0.061809 -0.008540 -0.026814 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382519 0.000000 -0.000002 0.000000 0.000000 0.049766 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.865910 -0.000000 0.000003 0.000000 0.000000 0.014631 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813031 -0.266276 0.544264 -0.043212 0.006414 -0.042499 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445755 -0.000000 0.000000 -0.000000 0.000000 0.071409 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053750 -0.000000 -0.000003 -0.000000 0.000000 -0.013037 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.689442 -0.342860 -0.236188 -0.064974 0.005280 -0.032223 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439795 -0.000000 0.000001 0.000000 0.000000 0.028862 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.982989 0.000000 0.000002 -0.000000 0.000000 -0.045538 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426953 -0.353604 -1.013783 -0.044697 0.010160 -0.075276 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104666 0.000000 0.000001 0.000000 -0.000000 0.039536 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908442 -0.000000 0.000002 0.000000 -0.000000 -0.028207 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist" "ValveBiped.Bip01_R_UpperArm" 10.390536 -0.000002 0.000000 0.001325 -0.000071 -0.053411 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist1" "R ForeTwist" 1.217917 0.000002 -0.000000 0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist2" "R ForeTwist1" 1.217918 -0.000002 -0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist3" "R ForeTwist2" 1.217918 0.000002 0.000000 0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist4" "R ForeTwist3" 1.217916 0.000001 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist5" "R ForeTwist4" 1.217918 0.000001 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist6" "R ForeTwist5" 1.217916 0.000001 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_Root" "" 1.983461 8.830967 -25.945992 0.000000 0.000000 -0.707106 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Pelvis" "ValveBiped.Bip01_Root" 0.000000 0.000000 0.000000 -0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Spine" "Pelvis" 3.242140 -0.005069 0.000005 -0.000002 -0.000000 0.000398 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Spine1" "Spine" 6.363438 -0.005069 0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Neck" "Spine1" 6.363436 -0.002058 0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "FAM_MAIN" "" -2.599743 -11.954530 -3.800601 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "FAM_MAG_RELEASE" "FAM_MAIN" 0.007674 4.962811 -0.934264 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "FAM_MAGAZINE" "FAM_MAIN" -0.000003 6.395597 -1.654393 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "FAM_BULLET_MAIN" "FAM_MAGAZINE" -0.118810 -0.065419 2.054317 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "FAM_BULLETS" "FAM_MAGAZINE" -0.118478 -0.065419 1.737719 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "FAM_TRIGGER" "FAM_MAIN" -0.043907 -0.441948 -0.673573 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "FAM_BOLT" "FAM_MAIN" 0.016472 -1.774496 1.703275 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "FAM_BOLT_HANDLE" "FAM_BOLT" 0.000460 -0.120476 -0.363187 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "FAMAS_SIGHT" "FAM_MAIN" 0.014103 -7.235753 2.358691 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Optic" "FAM_MAIN" -0.001140 -1.080784 3.777362 -0.000000 0.707107 -0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle_Ironsight" "FAM_MAIN" 2.599741 -10.852775 3.711483 0.000000 -0.000000 -0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Foregrip" "FAM_MAIN" 0.029664 -4.359653 -0.897634 0.000000 0.000000 1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Underbarrel" "FAM_MAIN" 0.002434 -7.569705 0.687202 -0.500000 0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Suppressor" "FAM_MAIN" -0.007880 -11.116035 0.676175 0.000000 0.000000 1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle_Supp" "FAM_MAIN" -0.007880 -19.032196 0.684833 0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_LaserFlashlight" "FAM_MAIN" 0.010177 -8.554111 0.683143 -0.707107 0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle" "FAM_MAIN" -0.008317 -12.853469 0.672902 0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Eject" "FAM_MAIN" -0.730943 8.039146 0.993207 -0.066794 0.016099 -0.986338 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_01" "FAM_MAIN" 0.012741 -7.969989 0.684858 -0.707016 -0.011349 0.707016 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_02" "SLING_BONE_01" 1.046484 0.000000 0.000000 0.000017 0.000001 -0.051006 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_03" "SLING_BONE_02" 1.420767 0.000055 0.000000 0.000000 0.000000 -0.118856 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_04" "SLING_BONE_03" 1.408961 -0.000002 0.000000 0.000000 0.000000 -0.124231 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_05" "SLING_BONE_04" 1.214037 0.000000 -0.000000 -0.000000 -0.000000 -0.115938 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_06" "SLING_BONE_05" 1.019244 -0.000010 0.000000 0.000000 0.000000 -0.130268 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_07" "SLING_BONE_06" 1.049126 0.000001 0.000000 0.000009 0.000089 -0.090669 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_08" "SLING_BONE_07" 1.505385 0.000007 0.000000 0.000126 0.004498 -0.024415 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_09" "SLING_BONE_08" 1.943114 0.000003 0.000000 0.000155 -0.000708 -0.033988 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_10" "SLING_BONE_09" 1.999505 -0.000016 0.000000 0.000051 -0.001362 -0.061425 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_11" "SLING_BONE_10" 2.023267 0.000066 0.000000 0.000146 0.002523 -0.056259 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_12" "SLING_BONE_11" 1.602904 -0.000002 0.000000 -0.023589 0.018437 -0.067955 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_13" "SLING_BONE_12" 2.383555 -0.000039 0.000000 -0.211637 0.047374 -0.155538 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_14" "SLING_BONE_13" 1.883695 0.000000 0.000000 -0.157657 0.080076 -0.078549 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_15" "SLING_BONE_14" 1.848095 -0.000005 0.000000 -0.246398 0.130811 -0.015823 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_16" "SLING_BONE_15" 1.960040 -0.000001 0.000000 -0.013359 -0.021298 -0.015530 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_17" "SLING_BONE_16" 1.396478 -0.000000 0.000000 -0.117135 -0.226369 -0.006304 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SLING_BONE_18" "SLING_BONE_17" 1.036103 0.000004 0.000000 0.004069 -0.095871 -0.008986 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "camera" "" 0.000000 0.000000 0.000000 0.000000 0.000000 -0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "CAM_Movement" "" 0.000000 0.000000 0.000000 -0.006923 -0.704284 -0.707389 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

$BoneMerge "ValveBiped.Bip01_Spine4"
=======
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition 1.76 -3.647 -7.303

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
		"famas"
		"muzzle"
		"suppressor"
		"grip"
		"laser"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 -0 0
$attachment "muzzle_supp" "A_Muzzle_Supp" 0 0 0 rotate -0 0 0
$attachment "2" "A_Eject" -0 0 0 rotate -0 0 0
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 0 0 0 rotate -0 0 0
$attachment "camera" "camera" 0 0 0 rotate -0 0 0
$attachment "Suppressor" "A_Suppressor" 0 0 0 rotate -0 0 0
$attachment "Laser" "A_Underbarrel" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 0
$attachment "Foregrip" "A_Foregrip" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -14.91 -5.528 -18.317 22.204 9.047 3.712

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
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_UpperArm" 10.390535 -0.000002 0.000001 -0 -6.123426 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217918 -0.000003 0 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217918 -0.000002 -0.000003 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.217917 -0.000002 -0.000004 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217916 0.000003 -0.000001 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.217918 0 -0.000003 -0 0.000003 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217916 0 0.000001 -0 0.000003 -0.152006 0 0 0 0 0 0
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
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_UpperArm" 10.390536 -0.000002 0 -0 -6.123426 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217917 0.000002 -0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.217918 -0.000002 -0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217918 0.000002 0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.217916 0.000001 0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.217918 0.000001 0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.217916 0.000001 0 -0 0.000003 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Root" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "ValveBiped.Bip01_Root" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 3.24214 -0.005069 0.000005 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 6.363438 -0.005069 0 -0 -0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 6.363436 -0.002058 0 -0 -0 0 0 0 0 0 0 0
$definebone "FAM_MAIN" "" -2.599743 -11.95453 -3.800601 0 0 0 0 0 0 0 0 0
$definebone "FAM_MAG_RELEASE" "FAM_MAIN" 0.007674 4.962811 -0.934264 -0 0 0 0 0 0 0 0 0
$definebone "FAM_MAGAZINE" "FAM_MAIN" -0.000003 6.395597 -1.654393 -0 0 0 0 0 0 0 0 0
$definebone "FAM_BULLET_MAIN" "FAM_MAGAZINE" -0.11881 -0.065419 2.054317 -0 0 0 0 0 0 0 0 0
$definebone "FAM_BULLETS" "FAM_MAGAZINE" -0.118478 -0.065419 1.737719 -0 0 0 0 0 0 0 0 0
$definebone "FAM_TRIGGER" "FAM_MAIN" -0.043907 -0.441948 -0.673573 -0 0 0 0 0 0 0 0 0
$definebone "FAM_BOLT" "FAM_MAIN" 0.016472 -1.774496 1.703275 -0 0 0 0 0 0 0 0 0
$definebone "FAM_BOLT_HANDLE" "FAM_BOLT" 0.00046 -0.120476 -0.363187 -0 0 0 0 0 0 0 0 0
$definebone "FAMAS_SIGHT" "FAM_MAIN" 0.014103 -7.235753 2.358691 -0 0 0 0 0 0 0 0 0
$definebone "A_Optic" "FAM_MAIN" -0.00114 -1.080784 3.777362 -0.000019 -180.000005 -90.000016 0 0 0 0 0 0
$definebone "A_Muzzle_Ironsight" "FAM_MAIN" 2.599741 -10.852775 3.711483 -0 -90.000098 0 0 0 0 0 0 0
$definebone "A_Foregrip" "FAM_MAIN" 0.029664 -4.359653 -0.897634 -0 179.999909 0 0 0 0 0 0 0
$definebone "A_Underbarrel" "FAM_MAIN" 0.002434 -7.569705 0.687202 -0 -89.999982 -89.999982 0 0 0 0 0 0
$definebone "A_Suppressor" "FAM_MAIN" -0.00788 -11.116035 0.676175 -0 179.999964 0 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "FAM_MAIN" -0.00788 -19.032196 0.684833 -0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "FAM_MAIN" 0.010177 -8.554111 0.683143 0.000036 -90.000016 -180.000005 0 0 0 0 0 0
$definebone "A_Muzzle" "FAM_MAIN" -0.008317 -12.853469 0.672902 0.000057 -89.999982 89.999982 0 0 0 0 0 0
$definebone "A_Eject" "FAM_MAIN" -0.730943 8.039146 0.993207 -7.292951 -162.546809 -2.991126 0 0 0 0 0 0
$definebone "SLING_BONE_01" "FAM_MAIN" 0.012741 -7.969989 0.684858 88.162736 89.999811 -90.002161 0 0 0 0 0 0
$definebone "SLING_BONE_02" "SLING_BONE_01" 1.046484 0 0 0.000172 -5.847435 0.001948 0 0 0 0 0 0
$definebone "SLING_BONE_03" "SLING_BONE_02" 1.420767 0.000055 0 0 -13.652209 0 0 0 0 0 0 0
$definebone "SLING_BONE_04" "SLING_BONE_03" 1.408961 -0.000002 0 0 -14.272726 0 0 0 0 0 0 0
$definebone "SLING_BONE_05" "SLING_BONE_04" 1.214037 0 -0 -0.000057 -13.315424 0 0 0 0 0 0 0
$definebone "SLING_BONE_06" "SLING_BONE_05" 1.019244 -0.00001 0 0.000057 -14.970125 0 0 0 0 0 0 0
$definebone "SLING_BONE_07" "SLING_BONE_06" 1.049126 0.000001 0 0.010256 -10.404224 0.000057 0 0 0 0 0 0
$definebone "SLING_BONE_08" "SLING_BONE_07" 1.505385 0.000007 0 0.515605 -2.798037 0.001833 0 0 0 0 0 0
$definebone "SLING_BONE_09" "SLING_BONE_08" 1.943114 0.000003 0 -0.080443 -3.895481 0.020455 0 0 0 0 0 0
$definebone "SLING_BONE_10" "SLING_BONE_09" 1.999505 -0.000016 0 -0.155443 -7.043254 0.01547 0 0 0 0 0 0
$definebone "SLING_BONE_11" "SLING_BONE_10" 2.023267 0.000066 0 0.28963 -6.450187 0.000458 0 0 0 0 0 0
$definebone "SLING_BONE_12" "SLING_BONE_11" 1.602904 -0.000002 0 1.923533 -7.844307 -2.841928 0 0 0 0 0 0
$definebone "SLING_BONE_13" "SLING_BONE_12" 2.383555 -0.000039 0 1.459838 -18.659855 -25.011212 0 0 0 0 0 0
$definebone "SLING_BONE_14" "SLING_BONE_13" 1.883695 0 0 7.605837 -10.426283 -18.952976 0 0 0 0 0 0
$definebone "SLING_BONE_15" "SLING_BONE_14" 1.848095 -0.000005 0 14.087542 -5.611957 -29.479182 0 0 0 0 0 0
$definebone "SLING_BONE_16" "SLING_BONE_15" 1.96004 -0.000001 0 -2.464067 -1.748099 -1.49381 0 0 0 0 0 0
$definebone "SLING_BONE_17" "SLING_BONE_16" 1.396478 -0 0 -26.056176 2.605636 -14.41716 0 0 0 0 0 0
$definebone "SLING_BONE_18" "SLING_BONE_17" 1.036103 0.000004 0 -10.99811 -1.089656 0.57336 0 0 0 0 0 0
$definebone "camera" "" 0 0 0 0 -90.000037 0 0 0 0 0 0 0
$definebone "CAM_Movement" "" 0 0 0 -5.368384 -175.715386 89.547004 0 0 0 0 0 0

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
	"famas_anims/base_idle.smd"
	fps 30
=======



$sequence "base_idle" {
	"famas_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "base_draw" {
	"famas_anims/base_draw.smd"
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
	"famas_anims/base_fire.smd"
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
	"famas_anims/base_reload.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_RELOAD" 1
	{ event 5004 28 "bf3_famas.clipout" }
	{ event 5004 66 "bf3_famas.clipin" }
	fadein 0.3
	fadeout 0.6
	fps 35.1
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "base_reload_empty" {
	"famas_anims/base_reload_empty.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 28 "bf3_famas.clipout" }
	{ event 5004 85 "bf3_famas.clipin" }
	{ event 5004 122 "bf3_famas.boltpull" }
	fadein 0.3
	fadeout 0.6
	fps 35.86
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "foregrip_idle" {
	"famas_anims/foregrip_idle.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.4
	fadeout 0.2
	fps 30
	loop
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "foregrip_draw" {
	"famas_anims/foregrip_draw.smd"
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
	"famas_anims/foregrip_fire.smd"
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
	"famas_anims/foregrip_reload.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 28 "bf3_famas.clipout" }
	{ event 5004 66 "bf3_famas.clipin" }
	fadein 0.3
	fadeout 0.6
	fps 35.1
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "foregrip_reload_empty" {
	"famas_anims/foregrip_reload_empty.smd"
<<<<<<< HEAD
	fps 30
}

=======
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 28 "bf3_famas.clipout" }
	{ event 5004 85 "bf3_famas.clipin" }
	{ event 5004 122 "bf3_famas.boltpull" }
	fadein 0.3
	fadeout 0.6
	fps 35.86
}
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3

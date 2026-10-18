// Decompiled from aks74u.mdl
$modelname "weapons/c_aks74u.mdl"

$bodygroup "sight"
{
	studio "aks74u.smd"
}
$bodygroup "barrel"
{
	studio "aks74u.smd"
}
$bodygroup "grip"
{
	studio "aks74u.smd"
}
$bodygroup "laser"
{
	studio "aks74u.smd"
}
$bodygroup "ak74"
{
	studio "aks74u.smd"
}
// REMOVED: hands bodygroup

$surfaceprop "default"
$contents "solid"
$illumposition 7.049000 -3.270000 -11.762000

$cdmaterials ""
$cdmaterials ""
$cdmaterials ""

$bbox -15.569000 -15.376000 -25.945999 29.666000 8.836000 2.422000
$cbox 0 0 0 0 0 0

$attachment "muzzle" "A_Muzzle" 1.000000 -0.000000 0.000000 rotate 0.000000 -0.000000 1.000000
$attachment "muzzle_gl" "A_GLMuzzle" 1.000000 -0.000000 0.000000 rotate 0.000000 -0.000000 1.000000
$attachment "muzzle_supp" "A_Muzzle_Supp" 1.000000 -0.000000 0.000000 rotate 0.000000 -0.000000 1.000000
$attachment "2" "A_Eject" 1.000000 -0.000000 0.000000 rotate 0.000000 -0.000000 1.000000
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 1.000000 0.000000 -0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Suppressor" "A_Suppressor" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Modkit" "A_Modkit" 1.000000 -0.000000 0.000000 rotate 0.000000 -0.000000 1.000000
$attachment "Laser" "A_Underbarrel" 1.000000 -0.000000 0.000000 rotate 0.000000 -0.000000 1.000000
$attachment "Optic" "A_Optic" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Foregrip" "A_Foregrips" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000

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
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_Forearm" -0.000000 0.000000 0.000000 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217918 -0.000003 0.000000 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217918 -0.000001 -0.000003 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.217917 -0.000001 -0.000004 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217916 0.000002 -0.000001 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.217918 0.000000 -0.000003 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217916 -0.000002 0.000001 -0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
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
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_Forearm" 0.000000 0.000000 0.000000 0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217917 0.000002 -0.000000 0.001327 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.217918 -0.000001 -0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217918 0.000002 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.217916 -0.000001 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.217918 0.000001 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.217916 0.000000 0.000000 0.001327 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "(null)" "" 1.983461 8.830967 -25.945992 0.000000 0.000000 -0.707106 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Pelvis" "(null)" 0.000000 0.000000 0.000000 -0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Spine" "Pelvis" 3.242140 -0.005069 0.000005 -0.000002 -0.000000 0.000398 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Spine1" "Spine" 6.363438 -0.005069 0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Neck" "Spine1" 6.363436 -0.002058 0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Weapon" "" -2.249564 -11.152735 -2.826391 0.000001 0.000000 0.000088 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Magazine" "Weapon" 0.008195 0.181844 -2.444005 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bullets" "Magazine" 0.112215 0.559316 2.399464 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Safety" "Weapon" -0.718951 4.684340 0.032320 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Trigger" "Weapon" -0.001748 3.534093 -0.807314 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bolt" "Weapon" -0.800971 -1.456638 0.700426 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Magazine Release" "Weapon" 0.002608 1.938277 -1.137029 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Eject" "Weapon" -0.560400 0.330936 0.970054 -0.120907 -0.047817 -0.985851 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle" "Weapon" -0.004700 -17.398869 0.335220 0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Underbarrel" "Weapon" 0.005541 -9.114821 1.174847 -0.500000 0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Suppressor" "Weapon" -0.006525 -15.684190 0.287403 0.000000 0.000000 1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Optic" "Weapon" 0.006863 2.456758 1.825240 -0.000000 0.707107 -0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Modkit" "Weapon" 0.003085 2.456742 1.416514 -0.000000 0.707107 -0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle_Supp" "Weapon" -0.004700 -25.968014 0.335223 0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_LaserFlashlight" "Weapon" 0.005541 -9.114821 1.174847 -0.707107 0.707107 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Foregrips" "Weapon" 0.005373 -4.913064 -0.193990 0.000000 0.000000 1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle_Ironsight" "Weapon" 2.249564 -18.513626 2.826420 -0.000001 -0.000001 -0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_GL" "Weapon" 0.000663 -9.800418 0.204282 0.500000 0.500000 0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "GL_Base" "A_GL" 0.000000 0.000000 -0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "GL_Trigger" "GL_Base" 4.033323 -1.616606 -0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "GL_Round" "GL_Base" 0.413366 -1.794379 -0.000000 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_GLMuzzle" "GL_Base" -2.572542 -1.780955 -0.000000 0.000000 1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

$BoneMerge "ValveBiped.Bip01_Spine4"
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

$include "c_arms_definebones.qci"

$sequence "base_idle" {
	"aks74u_anims/base_idle.smd"
	fps 30
}

$sequence "base_draw" {
	"aks74u_anims/base_draw.smd"
	fps 30
}

$sequence "base_fire" {
	"aks74u_anims/base_fire.smd"
	fps 30
}

$sequence "base_reload" {
	"aks74u_anims/base_reload.smd"
	fps 30
}

$sequence "base_reloadempty" {
	"aks74u_anims/base_reloadempty.smd"
	fps 30
}

$sequence "foregrip_idle" {
	"aks74u_anims/foregrip_idle.smd"
	fps 30
}

$sequence "foregrip_draw" {
	"aks74u_anims/foregrip_draw.smd"
	fps 30
}

$sequence "foregrip_fire" {
	"aks74u_anims/foregrip_fire.smd"
	fps 30
}

$sequence "foregrip_reload" {
	"aks74u_anims/foregrip_reload.smd"
	fps 30
}

$sequence "foregrip_reload_empty" {
	"aks74u_anims/foregrip_reload_empty.smd"
	fps 30
}


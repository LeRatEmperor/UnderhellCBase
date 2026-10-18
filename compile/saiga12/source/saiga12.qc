<<<<<<< HEAD
// Decompiled from saiga12.mdl
=======
// 

>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
$modelname "weapons/c_saiga12.mdl"

$bodygroup "saiga12"
{
	studio "saiga12.smd"
}
<<<<<<< HEAD
// REMOVED: hands bodygroup

$surfaceprop "default"
$contents "solid"
$illumposition -5.962000 -3.334000 -8.123000

$cdmaterials ""
$cdmaterials ""
$cdmaterials ""

$bbox -6.784000 -9.750000 -28.584999 26.424000 8.251000 6.986000
$cbox 0 0 0 0 0 0

$attachment "1" "Muzzle_Flash" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "2" "Shell_Ejection" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000

$definebone "Saiga12k" "" -1.912251 -7.946754 -2.472074 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Saiga_Bolt" "" -2.025490 -12.156538 -3.311307 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Saiga_magazine" "" -2.025491 -9.323847 -3.311307 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Saiga_Shell" "" -4.416613 -10.012898 6.930110 0.009102 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Saiga_FireSelector" "" -2.709427 -6.149755 -2.743764 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Saiga_MagRelease" "" -2.025375 -8.577040 -4.093821 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Saiga_Trigger" "" -2.025375 -7.357790 -3.328720 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Muzzle_Flash" "" -2.017735 -24.424179 -2.385310 0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Shell_Ejection" "" -2.017735 -10.593838 -2.077611 -0.058105 -0.649517 -0.704715 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01" "" 0.000000 0.000001 -19.912289 0.000000 0.000000 -0.707106 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 Pelvis" "Bip01" 0.000000 0.000000 0.000000 -0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 Spine" "Bip01 Pelvis" 4.019418 -0.003332 0.000006 -0.000002 -0.000000 0.000398 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 Spine1" "Bip01 Spine" 4.183875 -0.004077 0.000000 0.000000 -0.000206 -0.000341 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 Neck" "Bip01 Spine1" 5.120475 -0.002087 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Clavicle" "Bip01 Neck" 0.000001 0.002084 1.508082 0.707107 -0.000282 0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L UpperArm" "Bip01 L Clavicle" 5.853648 -0.000000 0.000000 -0.501428 0.497211 -0.499489 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Forearm" "Bip01 L UpperArm" 9.961164 -0.000000 0.000000 -0.000000 0.000000 -0.006343 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Hand" "Bip01 L Forearm" 8.503072 0.000000 0.000000 -0.706749 -0.009063 0.003112 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger0" "Bip01 L Hand" 0.756620 0.677738 -1.164278 0.695092 0.302967 -0.040221 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger01" "Bip01 L Finger0" 1.815094 0.000000 0.000001 -0.000000 -0.000000 0.108625 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger02" "Bip01 L Finger01" 1.031525 -0.000002 -0.000003 -0.000000 -0.000000 0.102048 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger1" "Bip01 L Hand" 3.560257 0.118226 -1.221193 0.082846 0.031192 0.045545 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger11" "Bip01 L Finger1" 1.161261 0.000000 0.000000 0.000000 -0.000000 0.167181 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger12" "Bip01 L Finger11" 0.705673 -0.000002 0.000000 0.000000 -0.000000 0.214355 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger2" "Bip01 L Hand" 3.535858 -0.001417 -0.449380 0.048292 0.008806 0.080904 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger21" "Bip01 L Finger2" 1.259424 0.000001 0.000001 0.000000 -0.000000 0.260841 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger22" "Bip01 L Finger21" 0.945203 -0.000002 -0.000000 0.000000 -0.000000 0.206915 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger3" "Bip01 L Hand" 3.379938 -0.050748 0.292730 -0.064755 -0.036334 0.139319 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger31" "Bip01 L Finger3" 1.267426 0.000000 0.000000 -0.000000 0.000000 0.259945 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger32" "Bip01 L Finger31" 0.855784 0.000000 -0.000000 -0.000000 0.000000 0.221650 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger4" "Bip01 L Hand" 3.272118 0.110096 1.013748 -0.087129 -0.051924 0.190753 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger41" "Bip01 L Finger4" 0.753933 0.000001 0.000000 -0.000000 -0.000000 0.184619 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger42" "Bip01 L Finger41" 0.703491 -0.000004 0.000000 -0.000000 -0.000000 0.149469 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L ForeTwist" "Bip01 L UpperArm" 9.961164 -0.000000 0.000000 0.000061 -0.000000 -0.006343 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L ForeTwist1" "Bip01 L ForeTwist" 1.417176 -0.000000 0.000000 0.000061 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L ForeTwist2" "Bip01 L ForeTwist1" 1.417181 -0.000000 0.000001 0.000061 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L ForeTwist3" "Bip01 L ForeTwist2" 1.417178 0.000000 0.000000 0.000061 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L ForeTwist4" "Bip01 L ForeTwist3" 1.417179 -0.000000 0.000000 0.000061 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L ForeTwist5" "Bip01 L ForeTwist4" 1.417178 0.000000 0.000000 0.000061 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Clavicle" "Bip01 Neck" 0.000001 0.002092 -1.508082 -0.707107 0.000282 0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R UpperArm" "Bip01 R Clavicle" 5.853648 0.000000 0.000000 0.501640 -0.497411 -0.499288 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Forearm" "Bip01 R UpperArm" 9.961167 0.000000 0.000000 0.000000 -0.000000 -0.006326 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Hand" "Bip01 R Forearm" 8.503076 -0.000000 0.000000 0.706749 0.009060 0.003108 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger0" "Bip01 R Hand" 0.756618 0.677738 1.164277 -0.695092 -0.302967 -0.040221 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger01" "Bip01 R Finger0" 1.815093 0.000004 -0.000004 0.000000 0.000000 0.108625 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger02" "Bip01 R Finger01" 1.031528 -0.000001 0.000001 0.000000 0.000000 0.102048 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger1" "Bip01 R Hand" 3.560268 0.118225 1.221195 -0.082846 -0.031192 0.045545 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger11" "Bip01 R Finger1" 1.161263 0.000000 0.000000 -0.000000 0.000000 0.167181 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger12" "Bip01 R Finger11" 0.705671 0.000000 0.000000 -0.000000 0.000000 0.214355 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger2" "Bip01 R Hand" 3.535862 -0.001417 0.449379 -0.048292 -0.008806 0.080904 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger21" "Bip01 R Finger2" 1.259428 0.000000 0.000000 -0.000000 0.000000 0.260841 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger22" "Bip01 R Finger21" 0.945210 0.000000 0.000000 -0.000000 0.000000 0.206915 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger3" "Bip01 R Hand" 3.379951 -0.050748 -0.292730 0.064755 0.036334 0.139319 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger31" "Bip01 R Finger3" 1.267431 0.000000 0.000001 0.000000 -0.000000 0.259945 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger32" "Bip01 R Finger31" 0.855788 -0.000002 0.000000 0.000000 -0.000000 0.221650 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger4" "Bip01 R Hand" 3.272118 0.110096 -1.013746 0.087129 0.051924 0.190753 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger41" "Bip01 R Finger4" 0.753937 0.000000 0.000000 0.000000 0.000000 0.184619 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger42" "Bip01 R Finger41" 0.703492 0.000000 0.000001 0.000000 -0.000000 0.149469 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R ForeTwist" "Bip01 R UpperArm" 9.961167 0.000000 0.000000 -0.000061 0.000000 -0.006326 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R ForeTwist1" "Bip01 R ForeTwist" 1.417179 0.000000 0.000000 -0.000061 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R ForeTwist2" "Bip01 R ForeTwist1" 1.417178 0.000000 0.000000 -0.000061 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R ForeTwist3" "Bip01 R ForeTwist2" 1.417181 0.000000 0.000000 -0.000061 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R ForeTwist4" "Bip01 R ForeTwist3" 1.417179 0.000000 -0.000000 -0.000061 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R ForeTwist5" "Bip01 R ForeTwist4" 1.417177 0.000000 -0.000000 -0.000061 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

$BoneMerge "ValveBiped.Bip01_Spine4"
=======
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition -3.334 5.962 -8.123

$cdmaterials "models\bf3\weapons\shotguns\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"saiga12"
	}
}

$attachment "1" "Muzzle_Flash" 0 0 0 rotate -0 0 0
$attachment "2" "Shell_Ejection" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -6.784 -9.75 -28.585 26.424 8.251 6.986

$hboxset "default"

$definebone "Saiga12k" "" -1.912251 -7.946754 -2.472074 0 0 0 0 0 0 0 0 0
$definebone "Saiga_Bolt" "" -2.02549 -12.156538 -3.311307 0 0 0 0 0 0 0 0 0
$definebone "Saiga_magazine" "" -2.025491 -9.323847 -3.311307 0 0 0 0 0 0 0 0 0
$definebone "Saiga_Shell" "" -4.416613 -10.012898 6.93011 0 0 1.04307 0 0 0 0 0 0
$definebone "Saiga_FireSelector" "" -2.709427 -6.149755 -2.743764 0 0 0 0 0 0 0 0 0
$definebone "Saiga_MagRelease" "" -2.025375 -8.57704 -4.093821 0 0 0 0 0 0 0 0 0
$definebone "Saiga_Trigger" "" -2.025375 -7.35779 -3.32872 0 0 0 0 0 0 0 0 0
$definebone "Muzzle_Flash" "" -2.017735 -24.424179 -2.38531 0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "Shell_Ejection" "" -2.017735 -10.593838 -2.077611 -26.422865 -159.168324 80.389933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01" "" 0 0.000001 -19.912289 0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "ValveBiped.Bip01" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 4.019418 -0.003332 0.000006 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 4.183875 -0.004077 0 -0.023549 -0.039076 0.000057 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 5.120475 -0.002087 0 -0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Neck1" 0.000001 0.002084 1.508082 1.596637 -1.286515 2.942962 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853648 -0.000000 0.000000 -1.579613 0.047802 -0.585173 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 9.961164 -0.000000 0.000000 0.000000 0.000000 -0.060372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.503072 0.000000 0.000000 1.573183 -0.106613 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.756620 0.677738 -1.164278 -1.222677 -0.679213 -0.788819 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.815094 0.000000 0.000001 0.000000 0.000000 0.228523 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.031525 -0.000002 -0.000003 0.000000 0.000000 0.362860 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.560257 0.118226 -1.221193 0.354449 -0.042750 -0.531718 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.161261 0.000000 0.000000 -0.000000 0.004074 -0.363009 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.705673 -0.000002 0.000000 0.000000 0.002596 -0.244331 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.535858 -0.001417 -0.449380 0.085902 0.021830 -0.587867 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.259424 0.000001 0.000001 0.000000 0.005516 -0.366478 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 0.945203 -0.000002 -0.000000 0.000000 0.003084 -0.216400 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.379938 -0.050748 0.292730 -0.151780 0.073206 -0.810985 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.267426 0.000000 0.000000 0.000000 0.000000 -0.247797 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.855784 0.000000 -0.000000 0.000000 0.000000 -0.430802 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.272118 0.110096 1.013748 -0.468133 0.151533 -0.880197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 0.753933 0.000001 0.000000 0.000000 0.000000 -0.439720 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.703491 -0.000004 0.000000 0.000000 0.000000 -0.244299 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_UpperArm" 9.961164 -0 0 -0 -0.726854 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.417176 -0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.417181 -0 0.000001 -0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.417178 0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.417179 -0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.417178 0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Neck1" 0.000001 0.002092 -1.508082 -1.668475 1.286518 2.942953 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000000 0.000000 1.639479 -0.008065 -0.586846 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 9.961167 0.000000 0.000000 0.000000 0.000000 -0.060372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.503076 -0.000000 0.000000 -1.564937 0.106606 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.756618 0.677738 1.164277 1.221731 0.673635 -0.793558 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.815093 0.000004 -0.000004 0.000000 0.000000 0.226893 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.031528 -0.000001 0.000001 0.000000 0.000000 0.362905 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.560268 0.118225 1.221195 -0.354419 0.038567 -0.532001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.161263 0.000000 0.000000 0.000000 -0.006613 -0.362970 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.705671 0.000000 0.000000 0.000000 -0.004211 -0.244312 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.535862 -0.001417 0.449379 -0.085905 -0.026404 -0.587695 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.259428 0.000000 0.000000 -0.000000 -0.007974 -0.366436 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 0.945210 0.000000 0.000000 0.000000 -0.004461 -0.216376 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.379951 -0.050748 -0.292730 0.150078 -0.079191 -0.810205 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.267431 0.000000 0.000001 0.000000 0.000000 -0.247771 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.855788 -0.000002 0.000000 0.000000 0.000000 -0.430761 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.272118 0.110096 -1.013746 0.466236 -0.158066 -0.878825 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 0.753937 0.000000 0.000000 0.000000 0.000000 -0.439672 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.703492 0.000000 0.000001 0.000000 0.000000 -0.244271 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_UpperArm" 9.961167 0 0 -0 -0.724963 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.417179 0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.417178 0 0 -0 -0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.417181 0 0 -0 -0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.417179 0 -0 -0 -0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.417177 0 -0 -0 0 -0.006933 0 0 0 0 0 0

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

$sequence "idle1" {
	"saiga12_anims/idle1.smd"
	fps 30
=======



$sequence "idle1" {
	"saiga12_anims/idle1.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "draw" {
	"saiga12_anims/draw.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_DRAW" 1
	{ event 5004 1 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "fire" {
	"saiga12_anims/fire.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "reload" {
	"saiga12_anims/reload.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_RELOAD" 1
	{ event 5004 21 "bf3_saiga12.clipout" }
	{ event 5004 75 "bf3_saiga12.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 37
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "reload_empty" {
	"saiga12_anims/reload_empty.smd"
<<<<<<< HEAD
	fps 30
}

=======
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 21 "bf3_saiga12.clipout" }
	{ event 5004 75 "bf3_saiga12.clipin" }
	{ event 5004 103 "bf3_saiga12.boltpull" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 37
}
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3

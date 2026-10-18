// 

$modelname "weapons/c_g3a3.mdl"

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
$bodygroup "g3a3"
{
	studio "g3a3.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition 0.707 7.613 -9.11

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
		"g3a3"
		"muzzle"
		"suppressor"
		"grip"
		"laser"
	}
}

$attachment "Suppressor" "a_suppressor" 0 0 0 rotate -0 0 0
$attachment "Laser" "a_laserflashlight" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 -0
$attachment "camera" "b_camera" 0 0 0 rotate -0 -90 0

$cbox 0 0 0 0 0 0

$bbox -33.201 -5.851 -20.721 17.975 7.265 2.501

$definebone "ValveBiped.Bip01" "" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "b_ch_middle" "ValveBiped.Bip01" -0.000002 0.000007 -20.720551 -0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "b_ch_middle" -0.005068 -0 3.242138 -89.949391 -89.998664 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine2" "ValveBiped.Bip01_Spine1" 6.363434 -0.004122 0.000548 0.048759 -0.00848 -35.782651 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine2" 6.363431 -0.000044 1.508102 -39.616767 -170.680963 -14.501163 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_UpperArm" "anim_ValveBiped.Bip01_L_Clavicle" 5.853645 -0.000012 0.000004 -9.851441 -71.24375 -6.78709 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Forearm" "anim_ValveBiped.Bip01_L_UpperArm" 10.390531 -0.000019 0.000035 -0.000283 -70.094454 0.000114 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Hand" "anim_ValveBiped.Bip01_L_Forearm" 8.525427 0.000032 0.000027 7.250783 40.165204 165.325426 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger0" "anim_ValveBiped.Bip01_L_Hand" 0.555144 0.315169 -0.822497 17.475389 14.694771 120.16289 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger01" "anim_ValveBiped.Bip01_L_Finger0" 1.556971 -0 -0.000002 -14.226603 12.897628 -4.627485 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger02" "anim_ValveBiped.Bip01_L_Finger01" 1.22109 0.000004 0 -14.751665 -3.171146 0.175846 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger4" "anim_ValveBiped.Bip01_L_Hand" 2.426952 -0.353609 1.01379 -3.424396 47.756853 -32.014528 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger41" "anim_ValveBiped.Bip01_L_Finger4" 1.104666 0.000004 0.000001 -3.825015 62.556787 -2.429001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger42" "anim_ValveBiped.Bip01_L_Finger41" 0.908442 0 -0.000005 -0.000066 -8.079047 -0.000111 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger2" "anim_ValveBiped.Bip01_L_Hand" 2.813026 -0.266285 -0.544264 -30.192134 -0.123585 -3.309 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger21" "anim_ValveBiped.Bip01_L_Finger2" 1.445755 0.000002 -0.000005 -0.000174 89.041208 -0.000065 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger22" "anim_ValveBiped.Bip01_L_Finger21" 1.05375 0 0.000001 0.000007 34.828439 -0.000181 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger3" "anim_ValveBiped.Bip01_L_Hand" 2.689438 -0.342867 0.23619 -22.403507 19.117489 -15.165619 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger31" "anim_ValveBiped.Bip01_L_Finger3" 1.439799 0.000005 -0.000002 -0.000289 108.85642 0.000113 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger32" "anim_ValveBiped.Bip01_L_Finger31" 0.982992 0.000004 -0.000002 -0.000056 -19.464644 -0.000352 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger1" "anim_ValveBiped.Bip01_L_Hand" 2.828089 -0.209492 -1.286463 -30.234649 -26.375607 9.324543 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger11" "anim_ValveBiped.Bip01_L_Finger1" 1.382523 -0.000005 -0.000003 0.000225 52.697174 -0.000631 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger12" "anim_ValveBiped.Bip01_L_Finger11" 0.865907 0.000009 -0.000001 -0.000404 51.175684 0.00029 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine2" 6.363439 -0.000035 -1.508061 38.154178 -90.045819 90.000098 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_UpperArm" "anim_ValveBiped.Bip01_R_Clavicle" 5.853649 0.000003 0.000002 -27.528502 -128.476405 20.810005 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Forearm" "anim_ValveBiped.Bip01_R_UpperArm" 10.390537 -0.000019 -0.000002 -0.000106 -92.978211 -0.000176 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Hand" "anim_ValveBiped.Bip01_R_Forearm" 8.525428 -0.000002 -0.000022 -10.889972 25.937804 154.303098 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger0" "anim_ValveBiped.Bip01_R_Hand" 0.555146 0.315173 0.822495 -13.420799 46.124821 -130.073644 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger01" "anim_ValveBiped.Bip01_R_Finger0" 1.556974 -0.000001 -0.000005 14.698321 32.385161 11.018265 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger02" "anim_ValveBiped.Bip01_R_Finger01" 1.221091 -0.000002 0 7.83205 45.012244 -9.683854 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger1" "anim_ValveBiped.Bip01_R_Hand" 2.828094 -0.209486 1.286468 -2.754161 -14.911964 -5.157822 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger11" "anim_ValveBiped.Bip01_R_Finger1" 1.382521 -0.000001 0.000005 -0.000178 69.042216 -0.000008 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger12" "anim_ValveBiped.Bip01_R_Finger11" 0.865909 0 0 0.000002 47.742517 -0.00001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger2" "anim_ValveBiped.Bip01_R_Hand" 2.813032 -0.266282 0.54427 9.802956 55.289169 6.77035 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger21" "anim_ValveBiped.Bip01_R_Finger2" 1.445754 -0.000003 0 0.000178 87.372839 -0.000179 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger22" "anim_ValveBiped.Bip01_R_Finger21" 1.053749 -0 0.000003 -0.000102 36.56956 -0.000059 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger3" "anim_ValveBiped.Bip01_R_Hand" 2.68944 -0.342867 -0.236182 5.536941 57.145949 10.291288 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger31" "anim_ValveBiped.Bip01_R_Finger3" 1.439798 -0.000004 0 0.000121 81.188533 -0.00024 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger32" "anim_ValveBiped.Bip01_R_Finger31" 0.982987 0 0 -0.000159 30.168826 0.000053 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger4" "anim_ValveBiped.Bip01_R_Hand" 2.426957 -0.353611 -1.013782 -2.152896 52.72638 13.097347 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger41" "anim_ValveBiped.Bip01_R_Finger4" 1.104664 -0.000002 -0 1.244986 51.942742 3.73396 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger42" "anim_ValveBiped.Bip01_R_Finger41" 0.908442 0 0 -0.41773 53.534828 -1.972348 0 0 0 0 0 0
$definebone "b_camera" "ValveBiped.Bip01" 0 0 0 -0 0 0.000057 0 0 0 0 0 0
$definebone "b_wpn" "ValveBiped.Bip01" -2.579667 -11.947805 -4.859893 -0 0 0 0 0 0 0 0 0
$definebone "a_suppressor" "b_wpn" 0.01 -19.200001 1.8 -0 180.000005 0 0 0 0 0 0 0
$definebone "a_laserflashlight" "b_wpn" 0 -16.85 1.84 -0 -90.000003 180.000005 0 0 0 0 0 0
$definebone "A_Optic" "b_wpn_optic" 0 0.5 0.1 -0 180.000005 -90.000003 0 0 0 0 0 0
$definebone "A_Foregrip" "b_wpn_foregrip" 0 0 0 -0 180.000005 0 0 0 0 0 0 0
$definebone "A_Modkit" "b_wpn_optic" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger02" "anim_ValveBiped.Bip01_L_Finger02" 0 0 0 -0.000001 0.000004 0.000005 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger01" "anim_ValveBiped.Bip01_L_Finger01" 0 0 0 -0.000002 -0.000001 0.00001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger0" "anim_ValveBiped.Bip01_L_Finger0" 0.000001 0 0.000001 0.000003 -0.000006 0.000009 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger42" "anim_ValveBiped.Bip01_L_Finger42" 0 0 0 -0.000006 0.000003 0.000005 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger41" "anim_ValveBiped.Bip01_L_Finger41" 0.000001 0 -0.000001 -0.000009 -0.000006 0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger4" "anim_ValveBiped.Bip01_L_Finger4" 0 0 0 -0.000003 0.000019 0.000009 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger22" "anim_ValveBiped.Bip01_L_Finger22" 0.000001 -0.000001 0 0.000003 -0.000009 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger21" "anim_ValveBiped.Bip01_L_Finger21" 0.000001 -0.000001 0 0.000003 0.000005 -0.000007 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger2" "anim_ValveBiped.Bip01_L_Finger2" 0 0.000001 0 -0.000002 -0.000003 -0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger32" "anim_ValveBiped.Bip01_L_Finger32" 0 0 0 0 -0.000002 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger31" "anim_ValveBiped.Bip01_L_Finger31" 0 -0 -0.000001 0.000002 -0.000007 0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger3" "anim_ValveBiped.Bip01_L_Finger3" 0 0 0 0.000003 0.000004 -0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger12" "anim_ValveBiped.Bip01_L_Finger12" 0 0 0 0.000003 0.000005 0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger11" "anim_ValveBiped.Bip01_L_Finger11" -0 0 0 0.000002 0.000005 -0.000006 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger1" "anim_ValveBiped.Bip01_L_Finger1" 0 0 0 -0.000003 -0.000007 -0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Hand" "anim_ValveBiped.Bip01_L_Hand" 0.000001 0.000001 -0 0.000005 0 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Forearm" "anim_ValveBiped.Bip01_L_Forearm" 0 0.000002 0 -0.000003 -0.000001 -0.000004 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_UpperArm" "anim_ValveBiped.Bip01_L_UpperArm" 0 0 0 -0 -0 -0.000007 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Clavicle" "anim_ValveBiped.Bip01_L_Clavicle" 0 -0 -0 0.000005 -0.000003 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger02" "anim_ValveBiped.Bip01_R_Finger02" 0 0 0 0.000003 -0.000005 -0.000007 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger01" "anim_ValveBiped.Bip01_R_Finger01" 0 0 0 -0.000002 -0.000015 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger0" "anim_ValveBiped.Bip01_R_Finger0" 0 0 0 -0 -0.000003 0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger12" "anim_ValveBiped.Bip01_R_Finger12" 0 0.000001 -0 0.000003 0.00001 -0.000008 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger11" "anim_ValveBiped.Bip01_R_Finger11" 0 0 0 -0.000004 -0.000007 -0.000007 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger1" "anim_ValveBiped.Bip01_R_Finger1" 0 0 0 -0.000009 -0.000001 0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger22" "anim_ValveBiped.Bip01_R_Finger22" 0.000001 0 0 0.00001 0.000012 0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger21" "anim_ValveBiped.Bip01_R_Finger21" 0 0 0 0.000008 -0.000003 -0.000006 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger2" "anim_ValveBiped.Bip01_R_Finger2" 0 0 0 -0.000005 0.000002 -0.000008 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger32" "anim_ValveBiped.Bip01_R_Finger32" -0.000001 0 -0 0.000011 0.000006 -0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger31" "anim_ValveBiped.Bip01_R_Finger31" 0.000001 0 0 0.000009 0.000002 -0.000006 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger3" "anim_ValveBiped.Bip01_R_Finger3" 0 -0.000001 0 -0.000004 -0.000003 -0.000011 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger42" "anim_ValveBiped.Bip01_R_Finger42" 0.000002 -0 0 0.000007 -0.000003 0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger41" "anim_ValveBiped.Bip01_R_Finger41" 0 0 0 0.000009 -0.00001 -0.000008 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger4" "anim_ValveBiped.Bip01_R_Finger4" 0 0.000001 0 -0.000002 0.000003 -0.000008 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Hand" "anim_ValveBiped.Bip01_R_Hand" 0 0 0 -0.000008 0.000003 -0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Forearm" "anim_ValveBiped.Bip01_R_Forearm" 0 0 0 0.000007 0.000003 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_UpperArm" "anim_ValveBiped.Bip01_R_UpperArm" 0 0 0 -0 -0.000007 0.000005 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Clavicle" "anim_ValveBiped.Bip01_R_Clavicle" 0 0 0 0 0.000004 -0 0 0 0 0 0 0

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -90.000153 -79.749996 -89.999924 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 71.286752 -2.806186 0.524648 21.921583 -51.399124 -116.880277 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 69.586342 -6.160738 5.235706 -44.445686 -29.641655 -151.516226 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 60.654062 -11.007298 11.018539 -42.952217 -32.031996 -154.428678 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 51.873845 -15.208642 17.108312 43.305003 -34.577363 -147.125941 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 51.030952 -14.372050 18.160369 -10.291796 -22.073237 148.919221 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 49.610461 -13.515803 18.832954 -15.121809 -19.178630 162.569332 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 48.522799 -13.174312 19.229471 -20.832800 -12.689426 -176.867630 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 49.071227 -15.812245 20.019324 73.011118 -13.194721 -171.250840 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 47.416670 -16.066880 20.411803 73.381119 6.799766 -177.022391 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 46.326216 -16.123601 20.281605 72.439807 20.230109 178.901373 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 49.143492 -16.580372 19.544472 57.403169 -8.391645 -170.249616 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 47.466899 -16.868474 19.795425 57.351900 9.517203 178.738071 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 46.274648 -16.842207 19.595490 55.601101 19.963911 171.818474 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 49.192421 -17.334479 19.113558 44.621784 3.570966 -175.609997 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 47.660827 -17.452061 19.017699 43.083245 13.434314 174.050324 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 46.503507 -17.331450 18.739756 35.496724 29.244874 153.590342 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 49.132328 -17.830493 18.504147 27.086199 9.405520 -174.329230 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 47.843745 -17.958445 18.289647 20.985330 19.821870 161.913223 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 47.191500 -17.745427 18.042324 15.578592 24.237431 147.573892 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 71.293486 -0.540348 -2.619180 -163.514207 50.884526 116.220831 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 69.613172 2.871376 -7.296272 -42.124338 33.489906 155.967568 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 60.707080 6.842663 -13.748102 -43.726808 31.133507 152.970757 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 51.952608 11.308922 -19.684535 -135.221017 37.257941 149.959982 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 51.110987 12.573251 -19.225957 -48.997342 -19.448203 147.289203 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 49.690972 13.485263 -18.630040 -51.157132 -9.458970 155.894313 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 48.604209 13.971525 -18.431683 -51.457583 6.839870 168.852618 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 49.159431 13.885265 -21.185666 -146.285605 12.438532 169.875610 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 47.506502 14.180416 -21.556013 -144.320888 0.818370 -172.724900 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 46.415804 14.041175 -21.571720 -144.988922 -7.110661 -161.159778 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 49.231915 13.191706 -21.763976 -129.823588 11.996021 174.871502 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 47.556625 13.342056 -22.121373 -128.944455 -4.021008 -171.468690 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 46.363768 13.163116 -22.036583 -130.219594 -13.429822 -163.287293 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 49.281162 12.544312 -22.342956 -115.677750 3.202314 -175.344198 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 47.749538 12.419582 -22.428936 -116.024709 -9.585759 -169.157354 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 46.590979 12.197681 -22.229720 -120.461943 -31.419225 -156.760160 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 49.220363 11.809433 -22.620943 -97.731885 2.527781 -169.403676 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 47.931436 11.568301 -22.678828 -98.360487 -22.423739 -165.851983 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 47.277662 11.403504 -22.400611 -99.594074 -36.250456 -163.352792 0 0 0 0 0 0
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




$sequence "base_idle" {
	"g3a3_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "base_draw" {
	"g3a3_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 301
}

$sequence "base_fire" {
	"g3a3_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "base_reload" {
	"g3a3_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 25 "bf3_g3a3.clipout" }
	{ event 5004 82 "bf3_g3a3.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 40
}

$sequence "base_reload_empty" {
	"g3a3_anims/base_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 24 "bf3_g3a3.boltback" }
	{ event 5004 62 "bf3_g3a3.clipout" }
	{ event 5004 117 "bf3_g3a3.clipin" }
	{ event 5004 149 "bf3_g3a3.boltforward" }
	fadein 0.2
	fadeout 0.2
	fps 40
}

$sequence "foregrip_idle" {
	"g3a3_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"g3a3_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "foregrip_fire" {
	"g3a3_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "foregrip_reload" {
	"g3a3_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 25 "bf3_g3a3.clipout" }
	{ event 5004 82 "bf3_g3a3.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 38
}

$sequence "foregrip_reload_empty" {
	"g3a3_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 24 "bf3_g3a3.boltback" }
	{ event 5004 62 "bf3_g3a3.clipout" }
	{ event 5004 117 "bf3_g3a3.clipin" }
	{ event 5004 149 "bf3_g3a3.boltforward" }
	fadein 0.2
	fadeout 0.2
	fps 32
}

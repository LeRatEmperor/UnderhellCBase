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
$cdmaterials "models\weapons\v_models\hands\"

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
		"v_hands"
		"sleeve_diffuse"
	}
}

$attachment "muzzle" "b_wpn_muzzle" 0 0 0 rotate -0 0 0
$attachment "muzzle_supp" "b_wpn_muzzle" 8.07 0 0 rotate -0 0 0
$attachment "2" "b_wpn_eject" 0 0 0 rotate 0 -0 0
$attachment "Suppressor" "a_suppressor" 0 0 0 rotate -0 0 0
$attachment "Laser" "a_laserflashlight" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 -0
$attachment "Foregrip" "b_wpn_foregrip" 0 0 0 rotate -0 0 0
$attachment "Magazine" "b_wpn_mag" 0 0 0 rotate -0 0 0
$attachment "camera" "b_camera" 0 0 0 rotate -0 -90 0

$cbox 0 0 0 0 0 0

$bbox -33.201 -5.851 -20.721 17.975 7.265 2.501

$definebone "ValveBiped.Bip01" "" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "b_ch_middle" "ValveBiped.Bip01" -0.000002 0.000007 -20.720551 -0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "b_ch_middle" -0.005068 -0 3.242138 -89.949391 -89.998664 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine2" "ValveBiped.Bip01_Spine1" 6.363434 -0.004122 0.000548 0.048759 -0.00848 -35.782651 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine2" 6.363431 -0.000044 1.508102 -39.616767 -170.680963 -14.501163 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853645 -0.000012 0.000004 -9.851441 -71.24375 -6.78709 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390531 -0.000019 0.000035 -0.000283 -70.094454 0.000114 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_Forearm" -0.000002 0.000006 -0.000003 -0.000345 0.000284 -13.230858 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_Forearm" 1.217918 0.00001 0.000003 -0.000167 0.000287 -26.461201 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_Forearm" 2.435836 0.000011 0.000007 -0.000283 0.000231 -39.691483 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_Forearm" 3.653755 0.000013 0.000011 -0.000169 0.000171 -52.921477 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_Forearm" 4.871674 0.000019 0.000014 0.00006 0.000229 -66.152506 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_Forearm" 6.089593 0.000029 0.00002 0.000289 0.00023 -79.382842 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist7" "ValveBiped.Bip01_L_Forearm" 7.307508 0.000025 0.000024 -0.000002 0.000114 -92.613301 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525427 0.000032 0.000027 7.250783 40.165204 165.325426 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555144 0.315169 -0.822497 17.475389 14.694771 120.16289 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556971 -0 -0.000002 -14.226603 12.897628 -4.627485 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.22109 0.000004 0 -14.751665 -3.171146 0.175846 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426952 -0.353609 1.01379 -3.424396 47.756853 -32.014528 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104666 0.000004 0.000001 -3.825015 62.556787 -2.429001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908442 0 -0.000005 -0.000066 -8.079047 -0.000111 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813026 -0.266285 -0.544264 -30.192134 -0.123585 -3.309 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445755 0.000002 -0.000005 -0.000174 89.041208 -0.000065 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.05375 0 0.000001 0.000007 34.828439 -0.000181 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.689438 -0.342867 0.23619 -22.403507 19.117489 -15.165619 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439799 0.000005 -0.000002 -0.000289 108.85642 0.000113 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.982992 0.000004 -0.000002 -0.000056 -19.464644 -0.000352 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828089 -0.209492 -1.286463 -30.234649 -26.375607 9.324543 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382523 -0.000005 -0.000003 0.000225 52.697174 -0.000631 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865907 0.000009 -0.000001 -0.000404 51.175684 0.00029 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine2" 6.363439 -0.000035 -1.508061 38.154178 -90.045819 90.000098 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853649 0.000003 0.000002 -27.528502 -128.476405 20.810005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.390537 -0.000019 -0.000002 -0.000106 -92.978211 -0.000176 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_Forearm" 0.000002 -0.000001 0 0.000009 0.000231 8.797359 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_Forearm" 1.21792 0.000001 0 0.000353 0.000058 17.594615 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_Forearm" 2.435839 -0.000001 -0.000006 0.000123 0.000348 26.391921 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_Forearm" 3.653756 -0.000001 -0.000009 0.000294 0.000003 35.189165 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_Forearm" 4.871675 -0.000001 -0.000012 0.000297 0.000287 43.986357 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_Forearm" 6.089591 -0.000003 -0.000017 0.00041 0.000056 52.783555 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist7" "ValveBiped.Bip01_R_Forearm" 7.30751 -0.000001 -0.000019 0.000297 -0.000055 61.58076 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525428 -0.000002 -0.000022 -10.889972 25.937804 154.303098 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.555146 0.315173 0.822495 -13.420799 46.124821 -130.073644 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556974 -0.000001 -0.000005 14.698321 32.385161 11.018265 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221091 -0.000002 0 7.83205 45.012244 -9.683854 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828094 -0.209486 1.286468 -2.754161 -14.911964 -5.157822 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382521 -0.000001 0.000005 -0.000178 69.042216 -0.000008 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.865909 0 0 0.000002 47.742517 -0.00001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813032 -0.266282 0.54427 9.802956 55.289169 6.77035 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445754 -0.000003 0 0.000178 87.372839 -0.000179 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053749 -0 0.000003 -0.000102 36.56956 -0.000059 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.68944 -0.342867 -0.236182 5.536941 57.145949 10.291288 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439798 -0.000004 0 0.000121 81.188533 -0.00024 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.982987 0 0 -0.000159 30.168826 0.000053 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426957 -0.353611 -1.013782 -2.152896 52.72638 13.097347 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104664 -0.000002 -0 1.244986 51.942742 3.73396 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908442 0 0 -0.41773 53.534828 -1.972348 0 0 0 0 0 0
$definebone "b_camera" "ValveBiped.Bip01" 0 0 0 -0 0 0.000057 0 0 0 0 0 0
$definebone "ik_hand_root" "ValveBiped.Bip01" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "ik_hand_r" "ik_hand_root" -3.990748 -5.973761 -6.666942 2.796435 -73.169972 7.609854 0 0 0 0 0 0
$definebone "ik_hand_l" "ik_hand_root" -1.277242 -16.02747 -4.548577 -11.971893 -118.791852 114.914531 0 0 0 0 0 0
$definebone "b_wpn" "ValveBiped.Bip01" -2.579667 -11.947805 -4.859893 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_eject" "b_wpn" -0.54111 -1.045988 2.423685 -22.618942 -157.226146 -4.243383 0 0 0 0 0 0
$definebone "b_wpn_fireselect" "b_wpn" 0.497737 2.452932 0.580558 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_magrelease" "b_wpn" 0 0.004086 -0.007531 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_muzzle" "b_wpn" 0.023565 -20.688456 1.852278 -0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "b_wpn_spec_1" "b_wpn" 0.057624 -0.345571 0.590815 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_trigger" "b_wpn" 0 1.658607 -0.0555 -0 0 0 0 0 0 0 0 0
$definebone "ik_hand_wpn_l" "b_wpn" 1.302424 -4.079666 0.311316 -11.971896 -118.791975 114.914477 0 0 0 0 0 0
$definebone "ik_hand_wpn_r" "b_wpn" -1.411081 5.974045 -1.807053 2.796263 -73.17015 7.609857 0 0 0 0 0 0
$definebone "b_wpn_chargehandle" "b_wpn" -0.000987 -9.751673 2.693876 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_spec_2" "b_wpn" -0.000987 -8.743616 2.693876 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_bolt" "b_wpn" -0.000001 -4.161116 2.223405 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_mag" "b_wpn" -0.000001 -1.751438 -0.712535 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_mag_b1" "b_wpn_mag" -0.139335 0.070539 2.106509 -0.000057 0 -2.603004 0 0 0 0 0 0
$definebone "b_wpn_mag_b2" "b_wpn_mag" 0.003623 0.063092 1.613393 -0.000057 0 -0.000172 0 0 0 0 0 0
$definebone "b_wpn_mag_follow" "b_wpn_mag" 0.004323 0.018379 0.941049 -0 0 -0.000172 0 0 0 0 0 0
$definebone "b_wpn_foregrip" "b_wpn" -0.004371 -6.654654 0.768527 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_optic" "b_wpn" -0.000987 0.722011 3.407384 -0 -0.000057 0 0 0 0 0 0 0
$definebone "b_wpn_bipod" "b_wpn" -0.000001 -11.086353 0.894633 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_bipod_base" "b_wpn_bipod" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_bipod_spring_l" "b_wpn_bipod_base" 0.690645 1.589273 -0.662467 -0.579776 -88.600189 22.492839 0 0 0 0 0 0
$definebone "b_wpn_bipod_spring_r" "b_wpn_bipod_base" -0.691 1.589275 -0.662467 -0.595418 -91.385909 -22.493063 0 0 0 0 0 0
$definebone "b_wpn_bipod_base_l" "b_wpn_bipod_base" 0.750996 0.339142 -1.16316 0.000057 89.999982 -22.511342 0 0 0 0 0 0
$definebone "b_wpn_bipod_spring_base_l" "b_wpn_bipod_base_l" -4.468534 -0.28717 0.340499 -1.453365 1.514614 0.011284 0 0 0 0 0 0
$definebone "b_wpn_bipod_base_r" "b_wpn_bipod_base" -0.602622 0.339144 -1.224393 -0 89.999982 22.500168 0 0 0 0 0 0
$definebone "b_wpn_bipod_spring_base_r" "b_wpn_bipod_base_r" -4.466202 0.447207 0.342232 -1.433598 -1.508884 0.000056 0 0 0 0 0 0
$definebone "b_wpn_mag_2" "b_wpn" 4.545642 29.042681 -1.492936 -0 0 0 0 0 0 0 0 0
$definebone "a_suppressor" "b_wpn" 0.01 -19.200001 1.8 -0 180.000005 0 0 0 0 0 0 0
$definebone "a_laserflashlight" "b_wpn" 0 -16.85 1.84 -0 -90.000003 180.000005 0 0 0 0 0 0
$definebone "A_Optic" "b_wpn_optic" 0 0.5 0.1 -0 180.000005 -90.000003 0 0 0 0 0 0
$definebone "A_Foregrip" "b_wpn_foregrip" 0 0 0 -0 180.000005 0 0 0 0 0 0 0
$definebone "A_Modkit" "b_wpn_optic" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_ForeTwist1" 0.000001 -0.000004 -0.000001 -0.000007 0.000001 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist2" 0 0 0 0.000002 -0.000003 -0.000006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist3" 0 0 0 -0.000007 -0.000003 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist4" -0 0 -0.000001 -0.000002 -0.000003 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist5" -0 -0 0 -0 -0.000002 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist6" 0 0 0 -0.000002 -0.000005 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist7" -0 -0 0.000002 -0.000002 -0.000003 0.000004 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger02" 0 0 0 -0.000001 0.000004 0.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger01" 0 0 0 -0.000002 -0.000001 0.00001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Finger0" 0.000001 0 0.000001 0.000003 -0.000006 0.000009 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger42" 0 0 0 -0.000006 0.000003 0.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger41" 0.000001 0 -0.000001 -0.000009 -0.000006 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Finger4" 0 0 0 -0.000003 0.000019 0.000009 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger22" 0.000001 -0.000001 0 0.000003 -0.000009 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger21" 0.000001 -0.000001 0 0.000003 0.000005 -0.000007 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Finger2" 0 0.000001 0 -0.000002 -0.000003 -0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger32" 0 0 0 0 -0.000002 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger31" 0 -0 -0.000001 0.000002 -0.000007 0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Finger3" 0 0 0 0.000003 0.000004 -0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger12" 0 0 0 0.000003 0.000005 0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger11" -0 0 0 0.000002 0.000005 -0.000006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Finger1" 0 0 0 -0.000003 -0.000007 -0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Hand" 0.000001 0.000001 -0 0.000005 0 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_Forearm" 0 0.000002 0 -0.000003 -0.000001 -0.000004 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_UpperArm" 0 0 0 -0 -0 -0.000007 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_L_Clavicle" 0 -0 -0 0.000005 -0.000003 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_ForeTwist1" 0 0 0 0.00001 0.000005 -0.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist2" 0 0 0 0.000009 -0.000004 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist3" 0 0 0 0.00001 0 0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist4" -0 -0.000001 0 0.000007 0.000003 -0.000004 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist5" 0 0 0 0.00001 -0.000003 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist6" 0 0 0 0.000005 -0.000003 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist7" 0 0 -0 0.000007 -0.000005 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger02" 0 0 0 0.000003 -0.000005 -0.000007 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger01" 0 0 0 -0.000002 -0.000015 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Finger0" 0 0 0 -0 -0.000003 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger12" 0 0.000001 -0 0.000003 0.00001 -0.000008 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger11" 0 0 0 -0.000004 -0.000007 -0.000007 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Finger1" 0 0 0 -0.000009 -0.000001 0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger22" 0.000001 0 0 0.00001 0.000012 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger21" 0 0 0 0.000008 -0.000003 -0.000006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Finger2" 0 0 0 -0.000005 0.000002 -0.000008 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger32" -0.000001 0 -0 0.000011 0.000006 -0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger31" 0.000001 0 0 0.000009 0.000002 -0.000006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Finger3" 0 -0.000001 0 -0.000004 -0.000003 -0.000011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger42" 0.000002 -0 0 0.000007 -0.000003 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger41" 0 0 0 0.000009 -0.00001 -0.000008 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Finger4" 0 0.000001 0 -0.000002 0.000003 -0.000008 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Hand" 0 0 0 -0.000008 0.000003 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_Forearm" 0 0 0 0.000007 0.000003 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_UpperArm" 0 0 0 -0 -0.000007 0.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_R_Clavicle" 0 0 0 0 0.000004 -0 0 0 0 0 0 0

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

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


$surfaceprop "default"

$contents "solid"

$illumposition 0.707 7.613 -9.11

$cdmaterials "models/bf3/weapons/rifles/"
$cdmaterials "models/bf3/weapons/att/"

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

$attachment "muzzle" "b_wpn_muzzle" 0 0 -0 rotate -0 0 0
$attachment "muzzle_supp" "b_wpn_muzzle" 8.07 0 -0 rotate -0 0 0
$attachment "2" "b_wpn_eject" -0 0 0 rotate -0 0 0
$attachment "Suppressor" "a_suppressor" 0 0 0 rotate -0 0 0
$attachment "Laser" "a_laserflashlight" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 0
$attachment "Foregrip" "b_wpn_foregrip" 0 0 0 rotate -0 0 0
$attachment "Magazine" "b_wpn_mag" 0 0 0 rotate -0 0 0
$attachment "camera" "b_camera" 0 0 0 rotate -0 -90 0

$cbox 0 0 0 0 0 0

$bbox -33.201 -5.851 -20.721 17.975 7.265 2.501

$definebone "ValveBiped.Bip01" "" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "b_ch_middle" "ValveBiped.Bip01" -0.000002 0.000007 -20.720551 -0 -89.999914 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "b_ch_middle" -0.005068 -0 3.242138 -89.949377 -89.99865 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine2" "ValveBiped.Bip01_Spine1" 6.363434 -0.004122 0.000548 0.048759 -0.00848 -35.78264 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine2" 6.363429 -0.000044 1.508102 -39.616764 -170.680963 -14.501171 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853644 -0.000013 0.000005 -9.851443 -71.243729 -6.787086 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390535 -0.000019 0.000037 -0.00029 -70.094434 0.000128 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_Forearm" -0.000001 0.000006 -0.000003 -0.000348 0.000303 -13.230842 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_Forearm" 1.217918 0.00001 0.000003 -0.000169 0.000303 -26.461182 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_Forearm" 2.435836 0.000011 0.000007 -0.000285 0.000248 -39.691466 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_Forearm" 3.653755 0.000013 0.000011 -0.000174 0.000187 -52.921457 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_Forearm" 4.871674 0.000021 0.000014 0.000056 0.000245 -66.152486 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_Forearm" 6.089592 0.000031 0.000021 0.000285 0.000246 -79.382829 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist7" "ValveBiped.Bip01_L_Forearm" 7.307507 0.000027 0.000025 -0.000007 0.00013 -92.613281 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525426 0.000032 0.000027 7.250763 40.165218 165.325412 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555144 0.315169 -0.822497 17.475399 14.694739 120.162876 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556972 0 -0.000002 -14.226622 12.897607 -4.627511 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.221087 0.000003 0 -14.751685 -3.171176 0.175821 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426953 -0.35361 1.013791 -3.424388 47.75683 -32.014504 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104666 0.000006 0 -3.825024 62.556767 -2.428994 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908442 0 -0.000005 -0.000079 -8.07908 -0.000109 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813027 -0.266285 -0.544265 -30.192107 -0.123593 -3.308991 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445755 0.000003 -0.000003 -0.000186 89.041181 -0.000061 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053752 0.000001 0.000001 -0.000012 34.828415 -0.000186 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.689441 -0.342868 0.236189 -22.403497 19.117472 -15.165602 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439798 0.000006 -0.000001 -0.000302 108.856413 0.000118 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.982993 0.000005 -0.000002 -0.000071 -19.464637 -0.00034 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828092 -0.209493 -1.286465 -30.234614 -26.375597 9.324541 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382522 -0.000005 -0.000003 0.000242 52.697153 -0.000604 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865907 0.00001 -0.000002 -0.000414 51.175684 0.000324 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine2" 6.363437 -0.000035 -1.508061 38.154168 -90.045806 90.000084 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853649 0.000004 0.000002 -27.528495 -128.476377 20.809997 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.390532 -0.000022 -0.000001 -0.000101 -92.978184 -0.000171 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_Forearm" 0.000002 0 0 0.000024 0.000251 8.797363 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_Forearm" 1.217919 0.000002 -0 0.000367 0.000079 17.594615 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_Forearm" 2.435838 0 -0.000007 0.000138 0.000369 26.391924 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_Forearm" 3.653754 0.000002 -0.00001 0.000309 0.000026 35.189159 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_Forearm" 4.871674 0.000002 -0.000013 0.000311 0.000307 43.986353 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_Forearm" 6.089589 0 -0.000018 0.000425 0.000077 52.783555 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist7" "ValveBiped.Bip01_R_Forearm" 7.307508 0.000002 -0.000021 0.000311 -0.000038 61.580753 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525425 0.000002 -0.000023 -10.889955 25.937794 154.303085 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.555147 0.315173 0.822495 -13.420807 46.12478 -130.073603 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556973 -0.000002 -0.000006 14.698364 32.385151 11.018264 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221091 -0.000003 -0.000001 7.832084 45.01219 -9.683813 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828094 -0.209486 1.286468 -2.754174 -14.911959 -5.157811 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382524 -0.000001 0.000006 -0.000204 69.042168 -0.000027 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.865908 -0.000003 0 -0.000005 47.742534 -0.000056 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813032 -0.266282 0.54427 9.802942 55.289138 6.770334 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445753 -0.000004 0.000001 0.000212 87.372873 -0.000213 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053747 0.000001 0.000003 -0.000037 36.569553 -0.000074 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.689439 -0.342867 -0.236181 5.536928 57.145929 10.291274 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439797 -0.000004 0.000001 0.000146 81.188539 -0.000272 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.982987 0.000001 0 -0.000108 30.168812 0.000024 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426955 -0.353611 -1.013779 -2.152908 52.726349 13.097335 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104664 -0.000002 0 1.244987 51.942749 3.733918 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908441 0.000001 -0 -0.417681 53.534859 -1.972378 0 0 0 0 0 0
$definebone "b_camera" "ValveBiped.Bip01" 0 0 0 -0 0 0.000057 0 0 0 0 0 0
$definebone "ik_hand_root" "ValveBiped.Bip01" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "ik_hand_r" "ik_hand_root" -3.990748 -5.973761 -6.666942 2.796435 -73.169966 7.609854 0 0 0 0 0 0
$definebone "ik_hand_l" "ik_hand_root" -1.277242 -16.02747 -4.548577 -11.971892 -118.791852 114.914531 0 0 0 0 0 0
$definebone "b_wpn" "ValveBiped.Bip01" -2.579667 -11.947805 -4.859893 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_eject" "b_wpn" -0.54111 -1.045988 2.423685 -22.618938 -157.226119 -4.243382 0 0 0 0 0 0
$definebone "b_wpn_fireselect" "b_wpn" 0.497737 2.452932 0.580558 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_magrelease" "b_wpn" 0 0.004086 -0.007531 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_muzzle" "b_wpn" 0.023565 -20.688456 1.852278 -0 -89.999968 89.999968 0 0 0 0 0 0
$definebone "b_wpn_spec_1" "b_wpn" 0.057624 -0.345571 0.590815 -0 0 0 0 0 0 0 0 0
$definebone "b_wpn_trigger" "b_wpn" 0 1.658607 -0.0555 -0 0 0 0 0 0 0 0 0
$definebone "ik_hand_wpn_l" "b_wpn" 1.302424 -4.079666 0.311316 -11.971895 -118.791975 114.914463 0 0 0 0 0 0
$definebone "ik_hand_wpn_r" "b_wpn" -1.411081 5.974045 -1.807053 2.796263 -73.170143 7.609858 0 0 0 0 0 0
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
$definebone "b_wpn_bipod_spring_l" "b_wpn_bipod_base" 0.690645 1.589273 -0.662467 -0.579776 -88.600183 22.492839 0 0 0 0 0 0
$definebone "b_wpn_bipod_spring_r" "b_wpn_bipod_base" -0.691 1.589275 -0.662467 -0.595418 -91.385903 -22.493061 0 0 0 0 0 0
$definebone "b_wpn_bipod_base_l" "b_wpn_bipod_base" 0.750996 0.339142 -1.16316 0.000057 89.999975 -22.51134 0 0 0 0 0 0
$definebone "b_wpn_bipod_spring_base_l" "b_wpn_bipod_base_l" -4.468536 -0.28717 0.340499 -1.453365 1.514614 0.011284 0 0 0 0 0 0
$definebone "b_wpn_bipod_base_r" "b_wpn_bipod_base" -0.602622 0.339144 -1.224393 -0 89.999975 22.500166 0 0 0 0 0 0
$definebone "b_wpn_bipod_spring_base_r" "b_wpn_bipod_base_r" -4.466202 0.447207 0.342232 -1.433598 -1.508884 0.000056 0 0 0 0 0 0
$definebone "b_wpn_mag_2" "b_wpn" 4.545642 29.042681 -1.492936 -0 0 0 0 0 0 0 0 0
$definebone "a_suppressor" "b_wpn" 0.01 -19.200001 1.8 -0 -179.999964 0 0 0 0 0 0 0
$definebone "a_laserflashlight" "b_wpn" 0 -16.85 1.84 -0 -89.999968 -179.999964 0 0 0 0 0 0
$definebone "A_Optic" "b_wpn_optic" 0 0.5 0.1 -0 -179.999964 -89.999968 0 0 0 0 0 0
$definebone "A_Foregrip" "b_wpn_foregrip" 0 0 0 -0 -179.999978 0 0 0 0 0 0 0
$definebone "A_Modkit" "b_wpn_optic" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_ForeTwist1" 0 -0.000004 -0.000001 -0.000017 0.000017 0.000018 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_ForeTwist1" 0.000001 0 0 0.000029 0.000024 -0.000007 0 0 0 0 0 0

$bonemerge "ValveBiped.Bip01"
$bonemerge "b_ch_middle"
$bonemerge "ValveBiped.Bip01_Spine1"
$bonemerge "ValveBiped.Bip01_Spine2"
$bonemerge "ValveBiped.Bip01_L_Clavicle"
$bonemerge "ValveBiped.Bip01_L_UpperArm"
$bonemerge "ValveBiped.Bip01_L_Forearm"
$bonemerge "ValveBiped.Bip01_L_Hand"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger02"
$bonemerge "ValveBiped.Bip01_L_Finger4"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "ValveBiped.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger2"
$bonemerge "ValveBiped.Bip01_L_Finger21"
$bonemerge "ValveBiped.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger3"
$bonemerge "ValveBiped.Bip01_L_Finger31"
$bonemerge "ValveBiped.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger1"
$bonemerge "ValveBiped.Bip01_L_Finger11"
$bonemerge "ValveBiped.Bip01_L_Finger12"
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


$sequence "base_idle" {
	"c_g3a3_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "base_draw" {
	"c_g3a3_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 301
}

$sequence "base_fire" {
	"c_g3a3_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "base_reload" {
	"c_g3a3_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 25 "bf3_g3a3.clipout" }
	{ event 5004 82 "bf3_g3a3.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 40
}

$sequence "base_reload_empty" {
	"c_g3a3_anims/base_reload_empty.smd"
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
	"c_g3a3_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"c_g3a3_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "foregrip_fire" {
	"c_g3a3_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "foregrip_reload" {
	"c_g3a3_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 25 "bf3_g3a3.clipout" }
	{ event 5004 82 "bf3_g3a3.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 38
}

$sequence "foregrip_reload_empty" {
	"c_g3a3_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 24 "bf3_g3a3.boltback" }
	{ event 5004 62 "bf3_g3a3.clipout" }
	{ event 5004 117 "bf3_g3a3.clipin" }
	{ event 5004 149 "bf3_g3a3.boltforward" }
	fadein 0.2
	fadeout 0.2
	fps 32
}

// 

$modelname "weapons/v_scotia.mdl"

$bodygroup "rec_1"
{
	studio "rec_1.smd"
	blank
}
$bodygroup "rec_2"
{
	studio "rec_2.smd"
	blank
}
$bodygroup "tag_sight"
{
	studio "iro_on.smd"
	studio "iro_off.smd"
	studio "iro_off_2.smd"
}
$bodygroup "ammo"
{
	studio "ammo.smd"
}


$surfaceprop "weapon"

$contents "solid"

$illumposition 0 0 0

$mostlyopaque

$cdmaterials "bo7\scotia\"
$cdmaterials "bo7\scotia\bar\"
$cdmaterials "bo7\scotia\mag\"
$cdmaterials "bo7\scotia\psg\"

$texturegroup "skinfamilies"
{
	{
		"dm_scotia_rail"
		"dm_scotia_rec"
		"556n_dt"
		"556n"
	}
}

$attachment "muzzle" "tag_barrel_attach" 0 0 0 rotate -0 0 0
$attachment "shell_eject" "tag_brass" 0 0 0 rotate -0 0 0
$attachment "camera" "tag_playerhelmet" 0 0 0 rotate -0 0 0
$attachment "reflex" "tag_reflex" 0 0 0 rotate -0 0 0
$attachment "holo" "tag_holo" 0 0 0 rotate -0 0 0
$attachment "scope" "tag_scope" 0 0 0 rotate -0 0 0
$attachment "acog" "tag_acog_2" 0 0 0 rotate -0 0 0
$attachment "hybrid" "tag_hybrid" 0 0 0 rotate -0 0 0
$attachment "thermal" "tag_thermal" 0 0 0 rotate -0 0 0
$attachment "align" "tag_align_gun" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -8.163 -33.701 -64.32 36.52 14.585 64.32

$definebone "tag_origin" "" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "tag_view" "tag_origin" -0.106 3.193533 65.086945 -0 -89.999982 0 0 0 0 0 0 0
$definebone "tag_ads" "tag_view" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_torso" "tag_ads" -0.904 0 -11.806 -0 0 0 0 0 0 0 0 0
$definebone "j_mainroot" "tag_torso" 0 0 -14.313999 -89.999982 90.003479 0 0 0 0 0 0 0
$definebone "j_spinelower" "j_mainroot" 3.533001 0 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_spineupper" "j_spinelower" 6.25 0.000003 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_clavicle_le" "j_spineupper" 8.980732 -2.943577 -2.869731 84.803 120.473977 120.327825 0 0 0 0 0 0
$definebone "j_shoulder_le" "j_clavicle_le" 5.784615 -0.000028 0.000229 47.175679 -3.685284 1.003216 0 0 0 0 0 0
$definebone "j_elbow_le" "j_shoulder_le" 11.530243 -0.000299 0.000183 1.65416 4.072105 0.000009 0 0 0 0 0 0
$definebone "j_elbowdq_le" "j_elbow_le" 0.119207 -0.27576 -0.000145 -0.000032 23.4832 -0.000062 0 0 0 0 0 0
$definebone "j_wrist_le" "j_elbow_le" 11.041269 -0.00036 -0.000637 -2.335179 -2.116062 6.802162 0 0 0 0 0 0
$definebone "j_metaindex_le_1" "j_wrist_le" 0.610312 -0.939534 0.070267 -7.625743 -8.521767 -95.174684 0 0 0 0 0 0
$definebone "j_index_le_1" "j_metaindex_le_1" 2.619612 0.000153 0.000405 -3.027623 27.825849 5.945166 0 0 0 0 0 0
$definebone "j_index_le_2" "j_index_le_1" 1.867861 -0.00005 -0.000524 0.000008 23.16541 -0.000016 0 0 0 0 0 0
$definebone "j_index_le_3" "j_index_le_2" 0.920021 -0.000298 -0.000418 0.000013 19.588561 -0.000015 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_finger12" "j_index_le_3" -0.175198 -0.011336 0.025322 -6.759857 -4.163816 -172.98913 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_finger11" "j_index_le_2" -0.336788 -0.09845 -0.065714 -4.727007 1.5025 -171.607219 0 0 0 0 0 0
$definebone "j_indexbulge_le_1" "j_index_le_1" 1.200441 0.398918 -0.000742 0.921716 0.408321 -0.542321 0 0 0 0 0 0
$definebone "j_proc_index_le_1" "j_index_le_1" 0.000105 0.099689 -0.000888 -1.256326 -12.010122 -6.877464 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_finger1" "j_index_le_1" -0.117598 -0.346882 -0.103427 -1.238903 4.131237 -170.569262 0 0 0 0 0 0
$definebone "j_metamid_le_1" "j_wrist_le" 0.639954 -0.199152 0.060165 -8.125638 -4.125301 -94.931536 0 0 0 0 0 0
$definebone "j_mid_le_1" "j_metamid_le_1" 2.659569 0.000099 -0.000828 -1.823311 36.031416 -4.058267 0 0 0 0 0 0
$definebone "j_mid_le_2" "j_mid_le_1" 2.008781 -0.000076 -0.00022 0.000012 18.078428 0.000005 0 0 0 0 0 0
$definebone "j_mid_le_3" "j_mid_le_2" 1.099674 -0.000422 0.000134 0.000008 26.567909 0.000009 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_finger22" "j_mid_le_3" -0.403351 0.180552 -0.027793 -5.246382 -11.417009 -176.939056 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_finger21" "j_mid_le_2" -0.546246 -0.077066 -0.118231 -4.296018 2.743794 -175.922164 0 0 0 0 0 0
$definebone "j_proc_mid_le_1" "j_mid_le_1" 0.000217 0.098991 0.000206 0.620698 -13.706193 -1.078481 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_finger2" "j_mid_le_1" -0.204794 -0.239429 -0.186196 -2.257322 -0.113966 -174.770402 0 0 0 0 0 0
$definebone "j_metapinky_le_1" "j_wrist_le" 0.600179 1.080258 -0.339489 -12.175822 6.5117 -103.578268 0 0 0 0 0 0
$definebone "j_pinky_le_1" "j_metapinky_le_1" 2.199732 0.000526 0.00012 0.06236 29.037129 -1.862048 0 0 0 0 0 0
$definebone "j_pinky_le_2" "j_pinky_le_1" 1.17931 0.000214 -0.000693 0.000016 21.835743 0.000019 0 0 0 0 0 0
$definebone "j_pinky_le_3" "j_pinky_le_2" 0.680134 -0.001225 0.000442 0.000005 31.299629 0.000027 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "j_pinky_le_3" -0.019482 0.147079 0.079202 2.210758 -3.47178 165.803389 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "j_pinky_le_2" -0.123856 0.072741 0.029507 -3.473662 5.433626 166.053729 0 0 0 0 0 0
$definebone "j_proc_pinky_le_1" "j_pinky_le_1" -0.0002 0.099625 -0.000034 0.000006 -17.996712 0 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_finger4" "j_pinky_le_1" 0.345568 -0.379066 -0.368974 -11.212698 27.586861 162.344881 0 0 0 0 0 0
$definebone "j_metaring_le_1" "j_wrist_le" 0.609756 0.400167 -0.009407 -7.991974 1.981733 -99.407263 0 0 0 0 0 0
$definebone "j_ring_le_1" "j_metaring_le_1" 2.560411 -0.000168 0.00003 1.525061 40.211854 3.256349 0 0 0 0 0 0
$definebone "j_proc_ring_le_1" "j_ring_le_1" 0.00013 0.100433 0.000323 1.325379 -14.94533 -0.625334 0 0 0 0 0 0
$definebone "j_ring_le_2" "j_ring_le_1" 1.708754 0.000727 -0.000201 0.000017 17.841359 0.000002 0 0 0 0 0 0
$definebone "j_ring_le_3" "j_ring_le_2" 1.019997 -0.000795 -0.000213 0.000015 26.16521 0.000008 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_finger32" "j_ring_le_3" -0.122314 0.129976 0.030934 1.334603 3.43855 168.887383 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_finger31" "j_ring_le_2" -0.336082 -0.049809 -0.040218 -3.399287 5.36819 169.331045 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_finger3" "j_ring_le_1" -0.107189 -0.394079 -0.198659 -5.900986 9.186668 170.473967 0 0 0 0 0 0
$definebone "j_proc_metaknuckle_le_1" "j_wrist_le" 0.657072 0.008398 0.040352 -7.529074 -0.000811 -95.451675 0 0 0 0 0 0
$definebone "j_proc_knuckle_le_1" "j_proc_metaknuckle_le_1" 1.799658 -0.000237 0.00023 -1.908559 27.378617 1.569154 0 0 0 0 0 0
$definebone "j_thumb_le_1" "j_wrist_le" 0.62973 -0.690042 -0.229778 13.69984 -72.195018 15.93748 0 0 0 0 0 0
$definebone "j_thumb_le_2" "j_thumb_le_1" 2.099438 0.000477 -0.000416 16.278941 38.714448 -28.606863 0 0 0 0 0 0
$definebone "j_thumb_le_3" "j_thumb_le_2" 1.29001 -0.000221 0.000587 -0.000022 16.090198 0.000083 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_finger02" "j_thumb_le_3" -0.231773 -0.119981 -0.001694 9.880519 1.166939 5.964236 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_finger01" "j_thumb_le_2" -0.080177 -0.100325 0.236382 11.347357 -3.847051 2.033976 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_finger0" "j_thumb_le_1" 0.447235 -0.488852 0.7995 17.295622 17.20909 -33.763954 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_hand" "j_wrist_le" -0.671118 -0.105824 0.391094 -5.457321 0.120425 83.106839 0 0 0 0 0 0
$definebone "j_wristfronttwist1_le" "j_elbow_le" 10.60005 -0.00035 -0.000626 -0.000029 -0.000079 -0.00005 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_forearm" "j_elbow_le" -1.07934 0.913673 0.013863 -1.665267 -5.19932 -0.100144 0 0 0 0 0 0
$definebone "j_shouldertwist_le" "j_shoulder_le" 0.500225 0.000133 -0.000061 -0.000029 -0.000016 0.000009 0 0 0 0 0 0
$definebone "valvebiped.bip01_l_upperarm" "j_shoulder_le" -1.293232 0.358266 0.044594 -0.002893 2.333985 -0.250717 0 0 0 0 0 0
$definebone "j_teres_le" "j_clavicle_le" 5.999792 -0.000402 -4.000004 -0 -0.000001 -0.000041 0 0 0 0 0 0
$definebone "j_clavicle_ri" "j_spineupper" 10.8936 -3.008277 3.542333 -77.058502 160.088064 -158.379109 0 0 0 0 0 0
$definebone "j_shoulder_ri" "j_clavicle_ri" 5.784617 -0.000033 -0.00024 -41.256108 -2.906039 -15.313668 0 0 0 0 0 0
$definebone "j_elbow_ri" "j_shoulder_ri" 11.530252 -0.000299 -0.000195 -1.762697 5.736002 0.000022 0 0 0 0 0 0
$definebone "j_elbowdq_ri" "j_elbow_ri" 0.119223 -0.275762 0.000137 0.000003 23.483427 0.000088 0 0 0 0 0 0
$definebone "j_wrist_ri" "j_elbow_ri" 11.041273 -0.000331 0.000645 4.479629 3.716845 16.11579 0 0 0 0 0 0
$definebone "j_metaindex_ri_1" "j_wrist_ri" 0.610313 -0.939535 -0.070282 2.028056 -16.234759 90.245213 0 0 0 0 0 0
$definebone "j_index_ri_1" "j_metaindex_ri_1" 2.619611 0.000145 -0.000405 4.091612 22.032377 -12.423798 0 0 0 0 0 0
$definebone "j_index_ri_2" "j_index_ri_1" 1.867874 -0.000053 0.000524 0.000023 23.506149 -0.00008 0 0 0 0 0 0
$definebone "j_index_ri_3" "j_index_ri_2" 0.919384 0.000416 0.000087 0.000031 20.984568 0.000046 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_finger12" "j_index_ri_3" 0.057266 -0.077172 -0.022277 6.123753 -3.012963 175.989318 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_finger11" "j_index_ri_2" -0.092777 -0.127134 0.068685 4.739939 3.97683 174.687566 0 0 0 0 0 0
$definebone "j_indexbulge_ri_1" "j_index_ri_1" 1.199593 0.399277 0.000411 -0.921764 0.408389 0.542218 0 0 0 0 0 0
$definebone "j_proc_index_ri_1" "j_index_ri_1" 0.000122 0.099686 0.000886 1.256218 -12.010066 6.877407 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_finger1" "j_index_ri_1" 0.127424 -0.357056 0.135159 2.198629 6.799091 173.491299 0 0 0 0 0 0
$definebone "j_metamid_ri_1" "j_wrist_ri" 0.63995 -0.199152 -0.060165 4.731725 -12.269834 92.62037 0 0 0 0 0 0
$definebone "j_mid_ri_1" "j_metamid_ri_1" 2.659555 0.000114 0.000826 4.965383 29.886377 -3.852526 0 0 0 0 0 0
$definebone "j_mid_ri_2" "j_mid_ri_1" 2.008768 -0.000874 -0.000381 0.000019 22.851752 -0.00007 0 0 0 0 0 0
$definebone "j_mid_ri_3" "j_mid_ri_2" 1.100365 0.00001 0.000468 0.000019 13.235855 -0.000008 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_finger22" "j_mid_ri_3" -0.196659 -0.045367 0.000946 5.591006 1.462033 179.840097 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_finger21" "j_mid_ri_2" -0.284042 -0.136448 0.110417 5.176696 2.249439 178.696259 0 0 0 0 0 0
$definebone "j_proc_mid_ri_1" "j_mid_ri_1" 0.000238 0.099014 -0.000205 -0.620678 -13.706202 1.078457 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_finger2" "j_mid_ri_1" 0.08882 -0.358677 0.228047 3.938013 4.069653 177.092189 0 0 0 0 0 0
$definebone "j_metapinky_ri_1" "j_wrist_ri" 0.60018 1.080263 0.339481 0.569613 -4.20482 99.642549 0 0 0 0 0 0
$definebone "j_pinky_ri_1" "j_metapinky_ri_1" 2.199736 0.000523 -0.000122 -3.143257 -15.459211 -11.802835 0 0 0 0 0 0
$definebone "j_pinky_ri_2" "j_pinky_ri_1" 1.180099 0.000374 0.000078 0.00002 42.581834 -0.000035 0 0 0 0 0 0
$definebone "j_pinky_ri_3" "j_pinky_ri_2" 0.679457 -0.000816 0.000175 0.000037 31.299458 -0.000021 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "j_pinky_ri_3" 0.044266 0.020134 0.001684 -6.810857 8.319793 -165.211389 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "j_pinky_ri_2" -0.019512 -0.016533 0.038579 2.88227 4.401932 -158.353005 0 0 0 0 0 0
$definebone "j_proc_pinky_ri_1" "j_pinky_ri_1" -0.000195 0.099625 0.000031 -0.000021 -17.99665 0.000022 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "j_pinky_ri_1" 0.036894 -0.634449 0.266284 9.986708 28.12733 -160.489064 0 0 0 0 0 0
$definebone "j_metaring_ri_1" "j_wrist_ri" 0.609756 0.400167 0.009407 6.377538 -8.375783 89.527265 0 0 0 0 0 0
$definebone "j_ring_ri_1" "j_metaring_ri_1" 2.56041 -0.00016 -0.00003 2.903878 31.385313 -0.065508 0 0 0 0 0 0
$definebone "j_proc_ring_ri_1" "j_ring_ri_1" 0.000116 0.100433 -0.000323 -1.32536 -14.94518 0.625304 0 0 0 0 0 0
$definebone "j_ring_ri_2" "j_ring_ri_1" 1.708731 0.000721 0.000199 0.000019 22.801555 -0.000013 0 0 0 0 0 0
$definebone "j_ring_ri_3" "j_ring_ri_2" 1.019794 -0.000032 -0.000396 0.000022 22.132046 -0.000004 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_finger32" "j_ring_ri_3" 0.117516 -0.000896 0.000818 -1.319555 10.370477 -171.377806 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_finger31" "j_ring_ri_2" -0.054367 -0.124937 0.050262 2.387939 8.095612 -171.609049 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_finger3" "j_ring_ri_1" 0.238005 -0.579456 0.16766 4.366529 16.815289 -172.442879 0 0 0 0 0 0
$definebone "j_proc_metaknuckle_ri_1" "j_wrist_ri" 0.657077 0.008401 -0.040359 7.529074 -0.000806 95.451696 0 0 0 0 0 0
$definebone "j_proc_knuckle_ri_1" "j_proc_metaknuckle_ri_1" 1.799656 -0.00024 -0.000229 1.908588 27.378535 -1.569121 0 0 0 0 0 0
$definebone "j_thumb_ri_1" "j_wrist_ri" 0.62974 -0.690042 0.229774 -27.518673 -72.612609 -22.684609 0 0 0 0 0 0
$definebone "j_thumb_ri_2" "j_thumb_ri_1" 2.099438 0.000484 0.000404 -14.152487 34.287181 46.322848 0 0 0 0 0 0
$definebone "j_thumb_ri_3" "j_thumb_ri_2" 1.290009 -0.000224 -0.000587 0.00002 5.030387 0.000066 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_finger02" "j_thumb_ri_3" -0.04302 -0.289031 0.019089 -5.391058 13.441195 -17.099346 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_finger01" "j_thumb_ri_2" 0.088469 -0.255658 -0.212936 -11.054678 -1.75286 -14.173139 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_finger0" "j_thumb_ri_1" 0.552177 -0.334946 -0.689346 -12.569916 13.602832 37.990489 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_hand" "j_wrist_ri" -0.380544 -0.161674 -0.314842 4.533305 -6.72973 -92.423859 0 0 0 0 0 0
$definebone "j_wristfronttwist1_ri" "j_elbow_ri" 10.600054 -0.000319 0.000622 0.000015 0.000066 0.000023 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_forearm" "j_elbow_ri" -0.742134 0.982277 0.740597 5.27948 -5.403964 12.526032 0 0 0 0 0 0
$definebone "j_shouldertwist_ri" "j_shoulder_ri" 0.500259 0.000134 0.000053 0.000024 0.000007 0.000021 0 0 0 0 0 0
$definebone "valvebiped.bip01_r_upperarm" "j_shoulder_ri" -0.983025 0.142275 1.280079 2.759056 3.723148 12.877602 0 0 0 0 0 0
$definebone "j_teres_ri" "j_clavicle_ri" 5.999796 -0.000418 4 0.000003 0 0.000004 0 0 0 0 0 0
$definebone "ValveBiped.Anim_Attachment_RH" "" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "tag_sling" "" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "j_gun" "" 0 0 0 0 0 0 0 0 0 0 0 0
$definebone "j_trigger" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_align_gun" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_barrel_attach" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_brass" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_mag_attach" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_pistolgrip_attach" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "j_ammo_01" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_ik_loc_ri" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_ik_loc_le" "tag_barrel_attach" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_reflex" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_scope" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_acog_2" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_holo" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_hybrid" "tag_sling" 3.72 0 1 -0 0 0 0 0 0 0 0 0
$definebone "tag_stock_attach" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "j_magrel" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "j_bolt_release" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "j_bolt" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "j_charginghandle" "j_bolt" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "bone_904ff012da770706" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "bone_8ff71012da2b1490" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "j_mag1" "tag_mag_attach" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "j_mag2" "tag_mag_attach" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_sync" "tag_origin" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_camera_scripted" "tag_origin" -0.106 0 64.32 -0 0 0 0 0 0 0 0 0
$definebone "tag_cambone" "tag_view" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_camera" "tag_cambone" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "tag_weapon" "tag_torso" 19.220905 -3.1474 8.567799 -0 0 -2.500674 0 0 0 0 0 0
$definebone "tag_player" "tag_camera" 0.106 -0 -64.32 -0 0 0 0 0 0 0 0 0
$definebone "tag_playerhelmet" "tag_camera" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "j_hip_le" "j_mainroot" 0 0 -4.867 -0.000019 -179.255091 180.000005 0 0 0 0 0 0
$definebone "j_hip_ri" "j_mainroot" 0 0 4.867 -0.000019 -179.255091 180.000005 0 0 0 0 0 0
$definebone "j_groinprotector" "j_mainroot" 4 -6.5 -0 -0 0.055978 0 0 0 0 0 0 0
$definebone "j_crotch" "j_mainroot" -6.5 0 0 89.999982 0 0 0 0 0 0 0 0
$definebone "j_hiptwist_le" "j_hip_le" 1.000095 -0.000031 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_knee_le" "j_hip_le" 17.162516 -0.000404 0 -0 6.830459 0 0 0 0 0 0 0
$definebone "j_hip_proc_le" "j_hip_le" 9.999895 -0.000304 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_hiptwist_ri" "j_hip_ri" 1.000099 -0.000031 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_knee_ri" "j_hip_ri" 17.162521 -0.000404 0 -0 6.830459 0 0 0 0 0 0 0
$definebone "j_hip_proc_ri" "j_hip_ri" 9.499846 0.000211 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_proc_spinelower" "j_spinelower" 0 0 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_ankle_le" "j_knee_le" 17.749374 0.295516 0 0 -66.403393 0 0 0 0 0 0 0
$definebone "j_kneedq_le" "j_knee_le" 0.017889 0.299793 0 -0 -3.413797 0 0 0 0 0 0 0
$definebone "tag_stowed_thigh" "j_hiptwist_ri" 12.283567 1.581456 -4.696001 -4.969036 5.167222 83.781839 0 0 0 0 0 0
$definebone "j_ankle_ri" "j_knee_ri" 17.749376 0.295515 0 0 -66.403393 0 0 0 0 0 0 0
$definebone "j_kneedq_ri" "j_knee_ri" 0.017891 0.299792 0 -0 -3.413797 0 0 0 0 0 0 0
$definebone "j_neck" "j_spineupper" 13.354 0 0 -0 -16.850746 0 0 0 0 0 0 0
$definebone "j_spine4" "j_spineupper" 4.530998 0 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_proc_spineupper" "j_spineupper" 0 0 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_ball_le" "j_ankle_le" 5.413524 0.000347 0 -0 -29.682366 -0 0 0 0 0 0 0
$definebone "j_ball_ri" "j_ankle_ri" 5.413525 0.000347 0 -0 -29.682366 -0 0 0 0 0 0 0
$definebone "tag_carry_attach" "j_clavicle_le" 4.662 -5.366333 4.825191 89.45619 -178.831797 89.937493 0 0 0 0 0 0
$definebone "j_head" "j_neck" 3.11697 -0.000444 0 -0 16.850746 0 0 0 0 0 0 0
$definebone "j_chest" "j_spine4" 0 0 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_eyeball_le" "j_head" 3.512001 -3.547 -1.066 89.999982 0 0 0 0 0 0 0 0
$definebone "j_eyeball_ri" "j_head" 3.456001 -3.517 1.169 89.999982 0 0 0 0 0 0 0 0
$definebone "j_head_end" "j_head" 6.233002 0 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_jaw" "j_head" -0.171997 -0.106 -0.902 58.967441 -179.596491 89.995228 0 0 0 0 0 0
$definebone "j_nvg" "j_head" 6.241997 -6.38 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_shield_le" "j_elbow_le" 3.999437 -0.000527 -0.000328 -0.003157 0.001481 -49.665297 0 0 0 0 0 0
$definebone "j_shield_ri" "j_elbow_ri" 3.999893 0.000039 0.001007 0.000015 0.000005 18.33307 0 0 0 0 0 0
$definebone "j_helmet" "j_head_end" 1.598 0 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_proc_wristfronttwist1_le" "j_wristfronttwist1_le" -1.145527 0.00013 0.000679 -0 -0.000003 0.000001 0 0 0 0 0 0
$definebone "tag_weapon_right" "j_wrist_le" 2.179619 0.848711 -0.758743 -25.275965 -28.653361 145.624769 0 0 0 0 0 0
$definebone "tag_accessory_right" "j_wrist_le" -9.580694 -27.862095 -37.184681 -7.073676 -32.571318 46.574548 0 0 0 0 0 0
$definebone "j_proc_metaindex_le_1" "j_wrist_le" 0.649931 -0.548294 0.093647 -7.528613 -6.420677 -95.449776 0 0 0 0 0 0
$definebone "j_proc_metapinky_le_1" "j_wrist_le" 0.665772 0.747221 -0.029194 -7.529122 5.441724 -95.451047 0 0 0 0 0 0
$definebone "tag_knife_attach2" "j_wrist_ri" 2.762352 0.116951 1.523975 3.675677 99.912383 93.362443 0 0 0 0 0 0
$definebone "j_proc_metaindex_ri_1" "j_wrist_ri" 0.650396 -0.54773 -0.092976 7.528619 -6.420683 95.449797 0 0 0 0 0 0
$definebone "j_proc_metapinky_ri_1" "j_wrist_ri" 0.665778 0.747221 0.02919 7.529126 5.441722 95.451074 0 0 0 0 0 0
$definebone "j_visor" "j_helmet" -4.481003 -0.202 0 -0 -0 0 0 0 0 0 0 0
$definebone "j_visor_inner" "j_helmet" -5.516998 -0.291 -0.001 -0 -0 0 0 0 0 0 0 0
$definebone "tag_wrist_attach_le" "j_proc_wristfronttwist1_le" -0.857697 0.104071 0.104683 9.392154 0.78106 1.348513 0 0 0 0 0 0
$definebone "j_proc_metaindex_le_2" "j_proc_metaindex_le_1" 1.899118 0.00042 -0.000439 -1.908585 27.378663 1.569099 0 0 0 0 0 0
$definebone "j_proc_idle_knuckle_le_1" "j_proc_metaknuckle_le_1" 1.79966 -0.000237 0.000231 -1.908579 27.378651 1.569099 0 0 0 0 0 0
$definebone "j_proc_orient_knuckle_le_1" "j_proc_metaknuckle_le_1" 1.79966 -0.000237 0.000231 -1.908579 27.378651 1.569099 0 0 0 0 0 0
$definebone "j_proc_metapinky_le_2" "j_proc_metapinky_le_1" 1.900311 -0.000141 -0.000517 -1.908582 27.37866 1.569099 0 0 0 0 0 0
$definebone "j_proc_metaindex_ri_2" "j_proc_metaindex_ri_1" 1.899437 -0.000324 -0.000151 1.908579 27.378661 -1.569122 0 0 0 0 0 0
$definebone "j_proc_idle_knuckle_ri_1" "j_proc_metaknuckle_ri_1" 1.799662 -0.000237 -0.000233 1.908584 27.378654 -1.569115 0 0 0 0 0 0
$definebone "j_proc_orient_knuckle_ri_1" "j_proc_metaknuckle_ri_1" 1.799662 -0.000237 -0.000233 1.908584 27.378654 -1.569115 0 0 0 0 0 0
$definebone "j_proc_metapinky_ri_2" "j_proc_metapinky_ri_1" 1.900726 0.000549 -0.000072 1.908585 27.378649 -1.569128 0 0 0 0 0 0
$definebone "j_thumb_le_4" "j_thumb_le_3" 0.599888 0.400185 -0.000027 0.000002 0.00001 0.000004 0 0 0 0 0 0
$definebone "j_thumb_ri_4" "j_thumb_ri_3" 0.599894 0.400187 0.000023 -0.000012 -179.999978 0 0 0 0 0 0 0
$definebone "j_index_le_4" "j_index_le_3" 0.599503 0.400695 0.000236 -0.000002 -0.000019 -0.000009 0 0 0 0 0 0
$definebone "j_index_ri_4" "j_index_ri_3" 0.600403 0.399632 -0.000468 -0.000029 180.000005 0.000008 0 0 0 0 0 0
$definebone "tag_grip_hide" "tag_sling" 14.532408 0.701122 -0.789534 -0 0 0 0 0 0 0 0 0
$definebone "tag_thermal" "tag_sling" 3.086973 0.701122 3.360271 -0 0 0 0 0 0 0 0 0
$definebone "j_firesel" "tag_sling" 2.569582 0.701122 -0.401856 -0 0 0 0 0 0 0 0 0
$definebone "j_webbing_le_3" "j_metapinky_le_1" -0.000002 0 -0 0.000004 0.000014 0 0 0 0 0 0 0
$definebone "j_webbing_ri_3" "j_metapinky_ri_1" -0.000001 0 0 -0 -0.000012 -0.000003 0 0 0 0 0 0
$definebone "j_webbing_le_1" "j_wrist_le" -0.000001 0.000001 0 0.000003 -0.000004 0.000005 0 0 0 0 0 0
$definebone "j_webbing_ri_1" "j_wrist_ri" -0.000001 0 0 0.000007 0 0.000006 0 0 0 0 0 0
$definebone "tag_acog_ads" "tag_sling" 0 0 0 -0 0 0 0 0 0 0 0 0

$bonemerge "tag_origin"
$bonemerge "tag_view"
$bonemerge "tag_ads"
$bonemerge "tag_torso"
$bonemerge "j_mainroot"
$bonemerge "j_spinelower"
$bonemerge "j_spineupper"
$bonemerge "j_clavicle_le"
$bonemerge "j_shoulder_le"
$bonemerge "j_elbow_le"
$bonemerge "j_elbowdq_le"
$bonemerge "j_wrist_le"
$bonemerge "j_metaindex_le_1"
$bonemerge "j_index_le_1"
$bonemerge "j_index_le_2"
$bonemerge "j_index_le_3"
$bonemerge "valvebiped.bip01_l_finger12"
$bonemerge "valvebiped.bip01_l_finger11"
$bonemerge "j_indexbulge_le_1"
$bonemerge "j_proc_index_le_1"
$bonemerge "valvebiped.bip01_l_finger1"
$bonemerge "j_metamid_le_1"
$bonemerge "j_mid_le_1"
$bonemerge "j_mid_le_2"
$bonemerge "j_mid_le_3"
$bonemerge "valvebiped.bip01_l_finger22"
$bonemerge "valvebiped.bip01_l_finger21"
$bonemerge "j_proc_mid_le_1"
$bonemerge "valvebiped.bip01_l_finger2"
$bonemerge "j_metapinky_le_1"
$bonemerge "j_pinky_le_1"
$bonemerge "j_pinky_le_2"
$bonemerge "j_pinky_le_3"
$bonemerge "ValveBiped.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "j_proc_pinky_le_1"
$bonemerge "valvebiped.bip01_l_finger4"
$bonemerge "j_metaring_le_1"
$bonemerge "j_ring_le_1"
$bonemerge "j_proc_ring_le_1"
$bonemerge "j_ring_le_2"
$bonemerge "j_ring_le_3"
$bonemerge "valvebiped.bip01_l_finger32"
$bonemerge "valvebiped.bip01_l_finger31"
$bonemerge "valvebiped.bip01_l_finger3"
$bonemerge "j_proc_metaknuckle_le_1"
$bonemerge "j_proc_knuckle_le_1"
$bonemerge "j_thumb_le_1"
$bonemerge "j_thumb_le_2"
$bonemerge "j_thumb_le_3"
$bonemerge "valvebiped.bip01_l_finger02"
$bonemerge "valvebiped.bip01_l_finger01"
$bonemerge "valvebiped.bip01_l_finger0"
$bonemerge "valvebiped.bip01_l_hand"
$bonemerge "j_wristfronttwist1_le"
$bonemerge "valvebiped.bip01_l_forearm"
$bonemerge "j_shouldertwist_le"
$bonemerge "valvebiped.bip01_l_upperarm"
$bonemerge "j_teres_le"
$bonemerge "j_clavicle_ri"
$bonemerge "j_shoulder_ri"
$bonemerge "j_elbow_ri"
$bonemerge "j_elbowdq_ri"
$bonemerge "j_wrist_ri"
$bonemerge "j_metaindex_ri_1"
$bonemerge "j_index_ri_1"
$bonemerge "j_index_ri_2"
$bonemerge "j_index_ri_3"
$bonemerge "valvebiped.bip01_r_finger12"
$bonemerge "valvebiped.bip01_r_finger11"
$bonemerge "j_indexbulge_ri_1"
$bonemerge "j_proc_index_ri_1"
$bonemerge "valvebiped.bip01_r_finger1"
$bonemerge "j_metamid_ri_1"
$bonemerge "j_mid_ri_1"
$bonemerge "j_mid_ri_2"
$bonemerge "j_mid_ri_3"
$bonemerge "valvebiped.bip01_r_finger22"
$bonemerge "valvebiped.bip01_r_finger21"
$bonemerge "j_proc_mid_ri_1"
$bonemerge "valvebiped.bip01_r_finger2"
$bonemerge "j_metapinky_ri_1"
$bonemerge "j_pinky_ri_1"
$bonemerge "j_pinky_ri_2"
$bonemerge "j_pinky_ri_3"
$bonemerge "ValveBiped.Bip01_R_Finger42"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "j_proc_pinky_ri_1"
$bonemerge "ValveBiped.Bip01_R_Finger4"
$bonemerge "j_metaring_ri_1"
$bonemerge "j_ring_ri_1"
$bonemerge "j_proc_ring_ri_1"
$bonemerge "j_ring_ri_2"
$bonemerge "j_ring_ri_3"
$bonemerge "valvebiped.bip01_r_finger32"
$bonemerge "valvebiped.bip01_r_finger31"
$bonemerge "valvebiped.bip01_r_finger3"
$bonemerge "j_proc_metaknuckle_ri_1"
$bonemerge "j_proc_knuckle_ri_1"
$bonemerge "j_thumb_ri_1"
$bonemerge "j_thumb_ri_2"
$bonemerge "j_thumb_ri_3"
$bonemerge "valvebiped.bip01_r_finger02"
$bonemerge "valvebiped.bip01_r_finger01"
$bonemerge "valvebiped.bip01_r_finger0"
$bonemerge "valvebiped.bip01_r_hand"
$bonemerge "j_wristfronttwist1_ri"
$bonemerge "valvebiped.bip01_r_forearm"
$bonemerge "j_shouldertwist_ri"
$bonemerge "valvebiped.bip01_r_upperarm"
$bonemerge "j_teres_ri"
$bonemerge "ValveBiped.Anim_Attachment_RH"
$bonemerge "tag_sling"
$bonemerge "j_gun"
$bonemerge "j_trigger"
$bonemerge "tag_barrel_attach"
$bonemerge "tag_mag_attach"
$bonemerge "tag_pistolgrip_attach"
$bonemerge "j_ammo_01"
$bonemerge "tag_ik_loc_ri"
$bonemerge "tag_ik_loc_le"
$bonemerge "tag_reflex"
$bonemerge "tag_scope"
$bonemerge "tag_holo"
$bonemerge "tag_hybrid"
$bonemerge "tag_stock_attach"
$bonemerge "j_magrel"
$bonemerge "j_bolt_release"
$bonemerge "j_bolt"
$bonemerge "bone_904ff012da770706"
$bonemerge "bone_8ff71012da2b1490"
$bonemerge "j_mag1"
$bonemerge "j_mag2"
$bonemerge "tag_sync"
$bonemerge "tag_camera_scripted"
$bonemerge "tag_cambone"
$bonemerge "tag_camera"
$bonemerge "tag_weapon"
$bonemerge "tag_player"
$bonemerge "tag_playerhelmet"
$bonemerge "j_hip_le"
$bonemerge "j_hip_ri"
$bonemerge "j_groinprotector"
$bonemerge "j_crotch"
$bonemerge "j_hiptwist_le"
$bonemerge "j_knee_le"
$bonemerge "j_hip_proc_le"
$bonemerge "j_hiptwist_ri"
$bonemerge "j_knee_ri"
$bonemerge "j_hip_proc_ri"
$bonemerge "j_proc_spinelower"
$bonemerge "j_ankle_le"
$bonemerge "j_kneedq_le"
$bonemerge "tag_stowed_thigh"
$bonemerge "j_ankle_ri"
$bonemerge "j_kneedq_ri"
$bonemerge "j_neck"
$bonemerge "j_spine4"
$bonemerge "j_proc_spineupper"
$bonemerge "j_ball_le"
$bonemerge "j_ball_ri"
$bonemerge "j_head"
$bonemerge "j_chest"
$bonemerge "j_eyeball_le"
$bonemerge "j_eyeball_ri"
$bonemerge "j_head_end"
$bonemerge "j_jaw"
$bonemerge "j_nvg"
$bonemerge "j_shield_le"
$bonemerge "j_shield_ri"
$bonemerge "j_helmet"
$bonemerge "j_proc_wristfronttwist1_le"
$bonemerge "tag_weapon_right"
$bonemerge "tag_accessory_right"
$bonemerge "j_proc_metaindex_le_1"
$bonemerge "j_proc_metapinky_le_1"
$bonemerge "tag_knife_attach2"
$bonemerge "j_proc_metaindex_ri_1"
$bonemerge "j_proc_metapinky_ri_1"
$bonemerge "j_visor"
$bonemerge "j_visor_inner"
$bonemerge "tag_wrist_attach_le"
$bonemerge "j_proc_idle_knuckle_le_1"
$bonemerge "j_proc_orient_knuckle_le_1"
$bonemerge "j_proc_idle_knuckle_ri_1"
$bonemerge "j_proc_orient_knuckle_ri_1"
$bonemerge "j_thumb_le_4"
$bonemerge "j_thumb_ri_4"
$bonemerge "j_index_le_4"
$bonemerge "j_index_ri_4"
$bonemerge "tag_grip_hide"
$bonemerge "j_webbing_le_3"
$bonemerge "j_webbing_ri_3"
$bonemerge "j_webbing_le_1"
$bonemerge "j_webbing_ri_1"
$bonemerge "tag_acog_ads"


$sectionframes 30 30

$poseparameter "aim_offset" 0 1 loop 0
$poseparameter "jog_offset" 0 1 loop 0
$poseparameter "firemode_offset" 0 1 loop 0
$poseparameter "jog_loop" 0 1 loop 0
$poseparameter "walk_loop" 0 1 loop 0
$poseparameter "sprint_loop" 0 1 loop 0
$poseparameter "sprint_offset" 0 1 loop 0
$poseparameter "freefall_loop" 0 1 loop 0
$poseparameter "grip_ang_offset" 0 1 loop 0
$poseparameter "grip_vert_offset" 0 1 loop 0
$poseparameter "grip_vertpro_offset" 0 1 loop 0
$poseparameter "grip_ang_short_offset" 0 1 loop 0
$poseparameter "grip_misc_offset" 0 1 loop 0
$poseparameter "empty_offset" 0 1 loop 0

$ikchain "rhand" "j_wrist_ri" knee 0.707 0.707 0
$ikchain "lhand" "j_wrist_le" knee 0.707 0.707 0

$animation "a_aim_idle_to_sub_corrective_animation" "v_scotia_anims/a_aim_idle_to_sub_corrective_animation.smd" {
}

$animation "a_delta_ads_additive_for_offset_corrective_animation" "v_scotia_anims/a_delta_ads_additive_for_offset_corrective_animation.smd" {
}

$animation "a_jog_offset_idle_corrective_animation" "v_scotia_anims/a_jog_offset_idle_corrective_animation.smd" {
}

$animation "a_jog_offset_corrective_animation" "v_scotia_anims/a_jog_offset_corrective_animation.smd" {
}

$animation "@a_jog_to_walk_corrective_animation" "v_scotia_anims/@a_jog_to_walk_corrective_animation.smd" {
}

$animation "a_firemode_idle_corrective_animation" "v_scotia_anims/a_firemode_idle_corrective_animation.smd" {
}

$animation "fix_semi_add_corrective_animation" "v_scotia_anims/fix_semi_add_corrective_animation.smd" {
}

$animation "a_jog_idle_corrective_animation" "v_scotia_anims/a_jog_idle_corrective_animation.smd" {
}

$animation "a_jog_corrective_animation" "v_scotia_anims/a_jog_corrective_animation.smd" {
}

$animation "a_walk_idle_corrective_animation" "v_scotia_anims/a_walk_idle_corrective_animation.smd" {
}

$animation "a_walk_corrective_animation" "v_scotia_anims/a_walk_corrective_animation.smd" {
}

$animation "@a_walk_to_sprint_corrective_animation" "v_scotia_anims/@a_walk_to_sprint_corrective_animation.smd" {
}

$animation "a_sprint_idle_corrective_animation" "v_scotia_anims/a_sprint_idle_corrective_animation.smd" {
}

$animation "a_sprint_corrective_animation" "v_scotia_anims/a_sprint_corrective_animation.smd" {
}

$animation "@a_sprint_to_walk_corrective_animation" "v_scotia_anims/@a_sprint_to_walk_corrective_animation.smd" {
}

$animation "a_sprint_offset_idle_corrective_animation" "v_scotia_anims/a_sprint_offset_idle_corrective_animation.smd" {
}

$animation "a_sprint_offset_corrective_animation" "v_scotia_anims/a_sprint_offset_corrective_animation.smd" {
}

$animation "a_fidget_corrective_animation" "v_scotia_anims/a_fidget_corrective_animation.smd" {
}

$animation "a_zerodiff_corrective_animation" "v_scotia_anims/a_zerodiff_corrective_animation.smd" {
}

$animation "a_freefall_idle_corrective_animation" "v_scotia_anims/a_freefall_idle_corrective_animation.smd" {
}

$animation "a_freefall_corrective_animation" "v_scotia_anims/a_freefall_corrective_animation.smd" {
}

$animation "@a_landdelta_corrective_animation" "v_scotia_anims/@a_landdelta_corrective_animation.smd" {
}

$animation "@a_jumpdelta_corrective_animation" "v_scotia_anims/@a_jumpdelta_corrective_animation.smd" {
}

$animation "a_empty_idle_to_sub_corrective_animation" "v_scotia_anims/a_empty_idle_to_sub_corrective_animation.smd" {
}

$animation "a_delta_empty_additive_for_offset_corrective_animation" "v_scotia_anims/a_delta_empty_additive_for_offset_corrective_animation.smd" {
}

$animation "ang_pose_v1_corrective_animation" "v_scotia_anims/ang_pose_v1_corrective_animation.smd" {
}

$animation "vert_pose_v1_corrective_animation" "v_scotia_anims/vert_pose_v1_corrective_animation.smd" {
}

$animation "vert_pro_v1_corrective_animation" "v_scotia_anims/vert_pro_v1_corrective_animation.smd" {
}

$animation "ang_pose_v2_corrective_animation" "v_scotia_anims/ang_pose_v2_corrective_animation.smd" {
}

$animation "misc_pose_v1_corrective_animation" "v_scotia_anims/misc_pose_v1_corrective_animation.smd" {
}

$animation "a_empty_idle_to_sub_corrective_animation" "v_scotia_anims/a_empty_idle_to_sub_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_delta_empty_additive_for_offset_corrective_animation" "v_scotia_anims/a_delta_empty_additive_for_offset_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_firemode_idle_corrective_animation" "v_scotia_anims/a_firemode_idle_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_semi_override_additive_corrective_animation" "v_scotia_anims/a_semi_override_additive_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_jog_offset_idle_corrective_animation" "v_scotia_anims/a_jog_offset_idle_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_jog_offset_corrective_animation" "v_scotia_anims/a_jog_offset_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_jog_idle_corrective_animation" "v_scotia_anims/a_jog_idle_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_jog_corrective_animation" "v_scotia_anims/a_jog_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_walk_idle_corrective_animation" "v_scotia_anims/a_walk_idle_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_walk_corrective_animation" "v_scotia_anims/a_walk_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_sprint_idle_corrective_animation" "v_scotia_anims/a_sprint_idle_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_sprint_corrective_animation" "v_scotia_anims/a_sprint_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_sprint_offset_idle_corrective_animation" "v_scotia_anims/a_sprint_offset_idle_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_sprint_offset_corrective_animation" "v_scotia_anims/a_sprint_offset_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_fidget_corrective_animation" "v_scotia_anims/a_fidget_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_zerodiff_corrective_animation" "v_scotia_anims/a_zerodiff_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_freefall_idle_corrective_animation" "v_scotia_anims/a_freefall_idle_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "a_freefall_corrective_animation" "v_scotia_anims/a_freefall_corrective_animation.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "empty_idle_to_sub" "v_scotia_anims/empty_idle_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_empty_idle_to_sub" "v_scotia_anims/a_empty_idle_to_sub.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_empty_idle_to_sub_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_delta_empty_additive_for_offset" "v_scotia_anims/a_delta_empty_additive_for_offset.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_delta_empty_additive_for_offset_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "aim_idle_to_sub" "v_scotia_anims/aim_idle_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_aim_idle_to_sub" "v_scotia_anims/a_aim_idle_to_sub.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_aim_idle_to_sub_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_delta_ads_additive_for_offset" "v_scotia_anims/a_delta_ads_additive_for_offset.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_delta_ads_additive_for_offset_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "jog_offset_to_sub" "v_scotia_anims/jog_offset_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 23 23 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 23 23 target 1
}

$animation "jog_idle_to_sub" "v_scotia_anims/jog_idle_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_jog_offset_idle" "v_scotia_anims/a_jog_offset_idle.smd" {
	fps 0.416
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_jog_offset_idle_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_jog_offset" "v_scotia_anims/a_jog_offset.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_jog_offset_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "jog_out_to_sub" "v_scotia_anims/jog_out_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 23 23 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 23 23 target 1
}

$animation "a_jog_idle_to_sub" "v_scotia_anims/a_jog_idle_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 72 72 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 72 72 target 1
}

$animation "a_jog_to_sub" "v_scotia_anims/a_jog_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 72 72 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 72 72 target 1
}

$animation "a_jog_idle" "v_scotia_anims/a_jog_idle.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_jog_idle_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 72 72 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 72 72 target 1
}

$animation "a_jog" "v_scotia_anims/a_jog.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_jog_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 72 72 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 72 72 target 1
}

$animation "a_walk_idle_to_sub" "v_scotia_anims/a_walk_idle_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 112 112 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 112 112 target 1
}

$animation "a_walk_to_sub" "v_scotia_anims/a_walk_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 112 112 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 112 112 target 1
}

$animation "a_walk_idle" "v_scotia_anims/a_walk_idle.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_walk_idle_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 112 112 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 112 112 target 1
}

$animation "a_walk" "v_scotia_anims/a_walk.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_walk_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 112 112 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 112 112 target 1
}

$animation "sprint_in_to_sub" "v_scotia_anims/sprint_in_to_sub.smd" {
	fps 28
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 23 23 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 23 23 target 1
}

$animation "a_sprint_idle_to_sub" "v_scotia_anims/a_sprint_idle_to_sub.smd" {
	fps 28
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 64 64 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 64 64 target 1
}

$animation "a_sprint_to_sub" "v_scotia_anims/a_sprint_to_sub.smd" {
	fps 28
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 64 64 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 64 64 target 1
}

$animation "a_sprint_idle" "v_scotia_anims/a_sprint_idle.smd" {
	fps 28
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_sprint_idle_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 66 66 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 66 66 target 1
}

$animation "a_sprint" "v_scotia_anims/a_sprint.smd" {
	fps 28
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_sprint_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 66 66 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 66 66 target 1
}

$animation "sprint_out_to_sub" "v_scotia_anims/sprint_out_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 23 23 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 23 23 target 1
}

$animation "sprint_offset_to_sub" "v_scotia_anims/sprint_offset_to_sub.smd" {
	fps 28
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "sprint_idle_to_sub" "v_scotia_anims/sprint_idle_to_sub.smd" {
	fps 28
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_sprint_offset_idle" "v_scotia_anims/a_sprint_offset_idle.smd" {
	fps 0.416
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_sprint_offset_idle_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_sprint_offset" "v_scotia_anims/a_sprint_offset.smd" {
	fps 28
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_sprint_offset_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_normalidle_to_sub" "v_scotia_anims/a_normalidle_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "fuckedpose_to_sub" "v_scotia_anims/fuckedpose_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 770 770 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 770 770 target 1
}

$animation "fix_semi_add" "v_scotia_anims/fix_semi_add.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "fix_semi_add_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_zerodiff" "v_scotia_anims/a_zerodiff.smd" {
	fps 0.0389
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_zerodiff_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_fidget" "v_scotia_anims/a_fidget.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_fidget_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 770 770 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 770 770 target 1
}

$animation "freefall_idle_to_sub" "v_scotia_anims/freefall_idle_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "freefall_to_sub" "v_scotia_anims/freefall_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 99 99 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 99 99 target 1
}

$animation "a_freefall_idle" "v_scotia_anims/a_freefall_idle.smd" {
	fps 0.303
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_freefall_idle_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_freefall" "v_scotia_anims/a_freefall.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_freefall_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 99 99 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 99 99 target 1
}

$animation "jump_land_to_sub" "v_scotia_anims/jump_land_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 22 22 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 22 22 target 1
}

$animation "jump_to_sub" "v_scotia_anims/jump_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 18 18 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 18 18 target 1
}

$animation "ang_pose_v1" "v_scotia_anims/ang_pose_v1.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "ang_pose_v1_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 0 0 target 1
}

$animation "ang_pose_v2" "v_scotia_anims/ang_pose_v2.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "ang_pose_v2_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "vert_pro_v1" "v_scotia_anims/vert_pro_v1.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "vert_pro_v1_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "vert_pose_v1" "v_scotia_anims/vert_pose_v1.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "vert_pose_v1_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "misc_pose_v1" "v_scotia_anims/misc_pose_v1.smd" {
	fps 30
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "misc_pose_v1_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "firemode_idle_to_sub" "v_scotia_anims/firemode_idle_to_sub.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_firemode_idle" "v_scotia_anims/a_firemode_idle.smd" {
	fps 0.416
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "a_firemode_idle_corrective_animation" 0
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$animation "a_semi_override_additive" "v_scotia_anims/a_semi_override_additive.smd" {
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$sequence "idle" {
	"v_scotia_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	{ event 9011 0 "1" }
	{ event 9021 0 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "a_idle_active"
	fps 0.416
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0 usesequence 
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1 usesequence 
}

$sequence "idle_empty" {
	"v_scotia_anims/idle_empty.smd"
	activity "ACT_VM_IDLE_EMPTY" 1
	{ event 9011 0 "1" }
	{ event 9021 0 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "empty_offset"
	addlayer "a_idle_active"
	fps 0.416
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0 usesequence 
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1 usesequence 
}

$sequence "iron_idle" {
	"v_scotia_anims/iron_idle.smd"
	{ event 9011 0 "1" }
	{ event 9021 0 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "aim_offset"
	fps 0.416
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$sequence "iron_idle_empty" {
	"v_scotia_anims/iron_idle_empty.smd"
	{ event 9011 0 "1" }
	{ event 9021 0 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "aim_offset"
	addlayer "empty_offset"
	fps 0.416
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$sequence "jog" {
	"v_scotia_anims/jog.smd"
	{ event 9011 0 "1" }
	{ event 9021 0 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "jog_loop"
	fps 0.416
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0 usesequence 
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1 usesequence 
}

$sequence "jog_empty" {
	"v_scotia_anims/jog_empty.smd"
	{ event 9011 0 "1" }
	{ event 9021 0 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "jog_loop"
	addlayer "empty_offset"
	fps 0.416
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0 usesequence 
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1 usesequence 
}

$sequence "sprint" {
	"v_scotia_anims/sprint.smd"
	{ event 9011 0 "1" }
	{ event 9021 0 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "sprint_loop"
	fps 0.416
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0 usesequence 
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1 usesequence 
}

$sequence "sprint_empty" {
	"v_scotia_anims/sprint_empty.smd"
	{ event 9011 0 "1" }
	{ event 9021 0 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "sprint_loop"
	addlayer "empty_offset"
	fps 0.416
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0 usesequence 
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1 usesequence 
}

$sequence "holster" {
	"v_scotia_anims/holster.smd"
	activity "ACT_VM_HOLSTER" 1
	{ event 9011 0 "0" }
	{ event 9011 1 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_drop_drop" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 9 9 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 9 9 target 1
}

$sequence "holster_empty" {
	"v_scotia_anims/holster_empty.smd"
	activity "ACT_VM_HOLSTER_SILENCED" 1
	{ event 9011 0 "0" }
	{ event 9011 1 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_drop_drop" }
	fadein 0.2
	fadeout 0.2
	addlayer "empty_offset"
	snap
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 9 9 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 9 9 target 1
}

$sequence "draw" {
	"v_scotia_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 9011 0 "0" }
	{ event 5004 3 "fly_plr_dm_scotia_raise_raise" }
	{ event 9011 10 "1" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 1
}

$sequence "draw_empty" {
	"v_scotia_anims/draw_empty.smd"
	activity "ACT_VM_DRAW_EMPTY" 1
	{ event 9011 0 "0" }
	{ event 5004 3 "fly_plr_dm_scotia_raise_raise" }
	{ event 9011 10 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "empty_offset"
	snap
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 1
}

$sequence "draw_first" {
	"v_scotia_anims/draw_first.smd"
	activity "ACT_VM_DRAW_DEPLOYED" 1
	{ event 9011 1 "0" }
	{ event 9011 30 "1" }
	{ event 5004 2 "fly_plr_dm_scotia_raise_first_raise" }
	{ event 5004 17 "fly_plr_dm_scotia_raise_first_charge" }
	{ event 5004 28 "fly_plr_dm_scotia_raise_first_end" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 58 58 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 58 58 target 1
}

$sequence "semi_off" {
	"v_scotia_anims/semi_off.smd"
	activity "ACT_VM_FIREMODE" 1
	{ event 9021 0 "0" }
	{ event 5004 5 "fly_plr_dm_scotia_selectsemi_off_switch" }
	{ event 9021 1 "1" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 18 18 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 18 18 target 1
}

$sequence "semi_on" {
	"v_scotia_anims/semi_on.smd"
	activity "ACT_VM_FIREMODE" 1
	{ event 9021 0 "0" }
	{ event 5004 5 "fly_plr_dm_scotia_selectsemi_on_switch" }
	{ event 9021 1 "1" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 18 18 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 18 18 target 1
}

$sequence "reload" {
	"v_scotia_anims/reload.smd"
	"v_scotia_anims/reload_2.smd"
	activity "ACT_VM_RELOAD" 1
	blend "aim_offset" 0 1
	blendwidth 2
	{ event 9011 7 "0" }
	{ event 9011 73 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_reload_raise" }
	{ event 5004 23 "fly_plr_dm_scotia_reload_tilt" }
	{ event 5004 35 "fly_plr_dm_scotia_reload_magout" }
	{ event 5004 44 "fly_plr_dm_scotia_reload_maghit" }
	{ event 5004 54 "fly_plr_dm_scotia_reload_magslide" }
	{ event 5004 58 "fly_plr_dm_scotia_reload_magin" }
	{ event 5004 75 "fly_plr_dm_scotia_reload_empty_drop" }
	{ event 5004 78 "fly_plr_dm_scotia_reload_end" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 93 93 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 93 93 target 1
}

$sequence "reload_empty" {
	"v_scotia_anims/reload_empty.smd"
	"v_scotia_anims/reload_empty_2.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	blend "aim_offset" 0 1
	blendwidth 2
	{ event 9011 10 "0" }
	{ event 9011 83 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_reload_raise" }
	{ event 5004 21 "fly_plr_dm_scotia_reload_empty_magout" }
	{ event 9031 30 "ResetBullets" }
	{ event 5004 38 "fly_plr_dm_scotia_reload_empty_maghit" }
	{ event 5004 44 "fly_plr_dm_scotia_reload_empty_magslide" }
	{ event 5004 50 "fly_plr_dm_scotia_reload_empty_magin" }
	{ event 5004 66 "fly_plr_dm_scotia_reload_empty_charge" }
	{ event 5004 85 "fly_plr_dm_scotia_reload_empty_drop" }
	{ event 5004 91 "fly_plr_dm_scotia_reload_empty_end" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 112 112 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 112 112 target 1
}

$sequence "reload_ext01" {
	"v_scotia_anims/reload_ext01.smd"
	"v_scotia_anims/reload_ext01_2.smd"
	activity "ACT_VM_RELOAD_1" 1
	blend "aim_offset" 0 1
	blendwidth 2
	{ event 9011 7 "0" }
	{ event 9011 73 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_reload_raise" }
	{ event 5004 23 "fly_plr_dm_scotia_reload_tilt" }
	{ event 5004 37 "fly_plr_dm_scotia_reload_ext01_magout" }
	{ event 5004 44 "fly_plr_dm_scotia_reload_maghit" }
	{ event 5004 48 "fly_plr_dm_scotia_inspect_drop_maghit2" }
	{ event 5004 54 "fly_plr_dm_scotia_reload_magslide" }
	{ event 5004 57 "fly_plr_dm_scotia_reload_ext01_magin" }
	{ event 5004 75 "fly_plr_dm_scotia_reload_empty_drop" }
	{ event 5004 80 "fly_plr_dm_scotia_reload_end" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 103 103 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 103 103 target 1
}

$sequence "reload_empty_ext01" {
	"v_scotia_anims/reload_empty_ext01.smd"
	"v_scotia_anims/reload_empty_ext01_2.smd"
	activity "ACT_VM_RELOAD_EMPTY_1" 1
	blend "aim_offset" 0 1
	blendwidth 2
	{ event 9011 8 "0" }
	{ event 9011 83 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_reload_raise" }
	{ event 5004 21 "fly_plr_dm_scotia_reload_empty_ext01_magout" }
	{ event 9031 30 "ResetBullets" }
	{ event 5004 36 "fly_plr_dm_scotia_reload_empty_maghit" }
	{ event 5004 42 "fly_plr_dm_scotia_inspect_drop_maghit2" }
	{ event 5004 47 "fly_plr_dm_scotia_reload_empty_magslide" }
	{ event 5004 50 "fly_plr_dm_scotia_reload_empty_ext01_magin" }
	{ event 5004 65 "fly_plr_dm_scotia_reload_empty_charge" }
	{ event 5004 86 "fly_plr_dm_scotia_reload_empty_drop" }
	{ event 5004 92 "fly_plr_dm_scotia_reload_empty_end" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 114 114 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 114 114 target 1
}

$sequence "reload_fast02" {
	"v_scotia_anims/reload_fast02.smd"
	"v_scotia_anims/reload_fast02_2.smd"
	activity "ACT_VM_RELOAD_2" 1
	blend "aim_offset" 0 1
	blendwidth 2
	{ event 9011 4 "0" }
	{ event 9011 43 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_reload_raise" }
	{ event 5004 14 "fly_plr_dm_scotia_reload_fast02_magout" }
	{ event 5004 30 "fly_plr_dm_scotia_reload_maghit" }
	{ event 5004 33 "fly_plr_dm_scotia_reload_fast02_magin" }
	{ event 5004 46 "fly_plr_dm_scotia_reload_empty_drop" }
	{ event 5004 49 "fly_plr_dm_scotia_reload_end" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 66 66 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 66 66 target 1
}

$sequence "reload_empty_fast02" {
	"v_scotia_anims/reload_empty_fast02.smd"
	"v_scotia_anims/reload_empty_fast02_2.smd"
	activity "ACT_VM_RELOAD_EMPTY_2" 1
	blend "aim_offset" 0 1
	blendwidth 2
	{ event 9011 5 "0" }
	{ event 9011 60 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_reload_raise" }
	{ event 5004 14 "fly_plr_dm_scotia_reload_empty_fast02_magout" }
	{ event 9031 20 "ResetBullets" }
	{ event 5004 32 "fly_plr_dm_scotia_reload_empty_maghit" }
	{ event 5004 38 "fly_plr_dm_scotia_reload_empty_fast02_magin" }
	{ event 5004 51 "fly_plr_dm_scotia_reload_empty_fast02_charge" }
	{ event 5004 63 "fly_plr_dm_scotia_reload_empty_drop" }
	{ event 5004 67 "fly_plr_dm_scotia_reload_empty_end" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 88 88 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 88 88 target 1
}

$sequence "reload_ext02" {
	"v_scotia_anims/reload_ext02.smd"
	"v_scotia_anims/reload_ext02_2.smd"
	activity "ACT_VM_RELOAD_3" 1
	blend "aim_offset" 0 1
	blendwidth 2
	{ event 9011 13 "0" }
	{ event 9011 92 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_reload_raise" }
	{ event 5004 27 "fly_plr_dm_scotia_reload_ext02_magout" }
	{ event 5004 52 "fly_plr_dm_scotia_reload_maghit" }
	{ event 5004 57 "fly_plr_dm_scotia_inspect_drop_maghit2" }
	{ event 5004 66 "fly_plr_dm_scotia_reload_magslide" }
	{ event 5004 69 "fly_plr_dm_scotia_reload_ext02_magin" }
	{ event 5004 80 "fly_plr_dm_scotia_reload_ext02_magslam" }
	{ event 5004 95 "fly_plr_dm_scotia_reload_empty_drop" }
	{ event 5004 98 "fly_plr_dm_scotia_reload_end" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 117 117 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 117 117 target 1
}

$sequence "reload_empty_ext02" {
	"v_scotia_anims/reload_empty_ext02.smd"
	"v_scotia_anims/reload_empty_ext02_2.smd"
	activity "ACT_VM_RELOAD_EMPTY_3" 1
	blend "aim_offset" 0 1
	blendwidth 2
	{ event 9011 8 "0" }
	{ event 9011 99 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_reload_raise" }
	{ event 5004 27 "fly_plr_dm_scotia_reload_tilt" }
	{ event 5004 38 "fly_plr_dm_scotia_reload_ext02_magslam" }
	{ event 5004 39 "fly_plr_dm_scotia_reload_empty_magout" }
	{ event 5004 55 "fly_plr_dm_scotia_reload_maghit" }
	{ event 5004 61 "fly_plr_dm_scotia_inspect_drop_maghit2" }
	{ event 5004 69 "fly_plr_dm_scotia_reload_magslide" }
	{ event 5004 73 "fly_plr_dm_scotia_reload_empty_ext02_magin" }
	{ event 5004 87 "fly_plr_dm_scotia_reload_empty_ext02_slam" }
	{ event 5004 88 "fly_plr_dm_scotia_reload_empty_ext02_charge" }
	{ event 5004 102 "fly_plr_dm_scotia_reload_empty_drop" }
	{ event 5004 109 "fly_plr_dm_scotia_reload_end" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 128 128 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 128 128 target 1
}

$sequence "inspect" {
	"v_scotia_anims/inspect.smd"
	activity "ACT_VM_FIDGET" 1
	{ event 9011 50 "0" }
	{ event 9011 246 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_inspect_raise" }
	{ event 5004 49 "fly_plr_dm_scotia_inspect_drop" }
	{ event 5004 89 "fly_plr_dm_scotia_inspect_drop_magout" }
	{ event 5004 99 "fly_plr_dm_scotia_inspect_drop_regrip1" }
	{ event 5004 120 "fly_plr_dm_scotia_inspect_drop_regrip3" }
	{ event 5004 153 "fly_plr_dm_scotia_inspect_drop_regrip5" }
	{ event 5004 159 "fly_plr_dm_scotia_inspect_drop_rattle" }
	{ event 5004 167 "fly_plr_dm_scotia_inspect_drop_maggrab1" }
	{ event 5004 181 "fly_plr_dm_scotia_inspect_drop_maghit1" }
	{ event 5004 186 "fly_plr_dm_scotia_inspect_drop_maghit2" }
	{ event 5004 189 "fly_plr_dm_scotia_inspect_drop_magin" }
	{ event 5004 207 "fly_plr_dm_scotia_empty_inspect_slideopen1" }
	{ event 5004 229 "fly_plr_dm_scotia_raise_first_quick_fast01_charge" }
	{ event 5004 249 "fly_plr_dm_scotia_reload_empty_drop" }
	{ event 5004 254 "fly_plr_dm_scotia_reload_empty_end" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 273 273 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 273 273 target 1
}

$sequence "inspect_empty" {
	"v_scotia_anims/inspect_empty.smd"
	activity "ACT_CROSSBOW_FIDGET_UNLOADED" 1
	{ event 9011 50 "0" }
	{ event 9011 306 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_inspect_raise" }
	{ event 5004 49 "fly_plr_dm_scotia_inspect_drop" }
	{ event 5004 89 "fly_plr_dm_scotia_inspect_drop_magout" }
	{ event 5004 99 "fly_plr_dm_scotia_inspect_drop_regrip1" }
	{ event 5004 120 "fly_plr_dm_scotia_inspect_drop_regrip3" }
	{ event 5004 153 "fly_plr_dm_scotia_inspect_drop_regrip5" }
	{ event 5004 159 "fly_plr_dm_scotia_inspect_drop_rattle" }
	{ event 5004 167 "fly_plr_dm_scotia_inspect_drop_maggrab1" }
	{ event 5004 184 "fly_plr_dm_scotia_empty_inspect_chamberchecks" }
	{ event 5004 233 "fly_plr_dm_scotia_inspect_drop_maghit1" }
	{ event 5004 240 "fly_plr_dm_scotia_inspect_drop_maghit2" }
	{ event 5004 246 "fly_plr_dm_scotia_inspect_drop_magin" }
	{ event 5004 266 "fly_plr_dm_scotia_empty_inspect_slideopen1" }
	{ event 5004 272 "fly_plr_dm_scotia_empty_inspect_slideopen2" }
	{ event 5004 308 "fly_plr_dm_scotia_reload_empty_drop" }
	{ event 5004 312 "fly_plr_dm_scotia_inspect_drop_end" }
	fadein 0.2
	fadeout 0.2
	addlayer "empty_offset"
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 333 333 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 333 333 target 1
}

$sequence "inspect_empty_fast02" {
	"v_scotia_anims/inspect_empty_fast02.smd"
	{ event 9011 50 "0" }
	{ event 9011 306 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_inspect_raise" }
	{ event 5004 49 "fly_plr_dm_scotia_inspect_drop" }
	{ event 5004 89 "fly_plr_dm_scotia_reload_empty_fast02_magout" }
	{ event 5004 99 "fly_plr_dm_scotia_inspect_drop_regrip1" }
	{ event 5004 120 "fly_plr_dm_scotia_inspect_drop_regrip3" }
	{ event 5004 153 "fly_plr_dm_scotia_inspect_drop_regrip5" }
	{ event 5004 159 "fly_plr_dm_scotia_inspect_drop_rattle" }
	{ event 5004 167 "fly_plr_dm_scotia_inspect_drop_maggrab1" }
	{ event 5004 184 "fly_plr_dm_scotia_empty_inspect_chamberchecks" }
	{ event 5004 233 "fly_plr_dm_scotia_inspect_drop_maghit1" }
	{ event 5004 240 "fly_plr_dm_scotia_inspect_drop_maghit2" }
	{ event 5004 246 "fly_plr_dm_scotia_reload_empty_fast02_magin" }
	{ event 5004 266 "fly_plr_dm_scotia_empty_inspect_slideopen1" }
	{ event 5004 272 "fly_plr_dm_scotia_empty_inspect_slideopen2" }
	{ event 5004 308 "fly_plr_dm_scotia_reload_empty_drop" }
	{ event 5004 312 "fly_plr_dm_scotia_inspect_drop_end" }
	fadein 0.2
	fadeout 0.2
	addlayer "empty_offset"
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 333 333 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 333 333 target 1
}

$sequence "inspect_empty_ext01" {
	"v_scotia_anims/inspect_empty_ext01.smd"
	{ event 9011 50 "0" }
	{ event 9011 306 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_inspect_raise" }
	{ event 5004 49 "fly_plr_dm_scotia_inspect_drop" }
	{ event 5004 89 "fly_plr_dm_scotia_reload_empty_ext01_magout" }
	{ event 5004 99 "fly_plr_dm_scotia_inspect_drop_regrip1" }
	{ event 5004 120 "fly_plr_dm_scotia_inspect_drop_regrip3" }
	{ event 5004 153 "fly_plr_dm_scotia_inspect_drop_regrip5" }
	{ event 5004 159 "fly_plr_dm_scotia_inspect_drop_rattle" }
	{ event 5004 167 "fly_plr_dm_scotia_inspect_drop_maggrab1" }
	{ event 5004 184 "fly_plr_dm_scotia_empty_inspect_chamberchecks" }
	{ event 5004 233 "fly_plr_dm_scotia_inspect_drop_maghit1" }
	{ event 5004 240 "fly_plr_dm_scotia_inspect_drop_maghit2" }
	{ event 5004 246 "fly_plr_dm_scotia_reload_empty_ext01_magin" }
	{ event 5004 266 "fly_plr_dm_scotia_empty_inspect_slideopen1" }
	{ event 5004 272 "fly_plr_dm_scotia_empty_inspect_slideopen2" }
	{ event 5004 308 "fly_plr_dm_scotia_reload_empty_drop" }
	{ event 5004 312 "fly_plr_dm_scotia_inspect_drop_end" }
	fadein 0.2
	fadeout 0.2
	addlayer "empty_offset"
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 333 333 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 333 333 target 1
}

$sequence "inspect_empty_ext02" {
	"v_scotia_anims/inspect_empty_ext02.smd"
	{ event 9011 50 "0" }
	{ event 9011 152 "1" }
	{ event 5004 1 "fly_plr_dm_scotia_inspect_raise" }
	{ event 5004 49 "fly_plr_dm_scotia_inspect_drop" }
	{ event 5004 89 "fly_plr_dm_scotia_raise_raise" }
	{ event 5004 151 "fly_plr_dm_scotia_raise_first_raise" }
	{ event 5004 156 "fly_plr_dm_scotia_reload_empty_drop" }
	{ event 5004 160 "fly_plr_dm_scotia_inspect_drop_end" }
	fadein 0.2
	fadeout 0.2
	addlayer "empty_offset"
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 181 181 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 181 181 target 1
}

$sequence "fire" {
	"v_scotia_anims/fire.smd"
	"v_scotia_anims/fire_2.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	blend "aim_offset" 0 1
	blendwidth 2
	{ event 9001 1 "MuzzleFlash muzzle" }
	{ event 6001 1 "shell_eject" }
	{ event 9001 1 "Ejection shell_eject" }
	{ event 9011 0 "1" }
	{ event 9021 0 "1" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 10 10 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 10 10 target 1
}

$sequence "fire_last" {
	"v_scotia_anims/fire_last.smd"
	"v_scotia_anims/fire_last_2.smd"
	activity "ACT_VM_PRIMARYATTACK_EMPTY" 1
	blend "aim_offset" 0 1
	blendwidth 2
	{ event 9001 1 "MuzzleFlash muzzle" }
	{ event 6001 1 "shell_eject" }
	{ event 9001 1 "Ejection shell_eject" }
	{ event 5004 1 "wpn_br_hcharlie36_plr_last_mech_01" }
	{ event 9011 0 "1" }
	{ event 9021 0 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "empty_offset"
	snap
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 19 19 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 19 19 target 1
}

$sequence "iron_fire" {
	"v_scotia_anims/iron_fire.smd"
	"v_scotia_anims/iron_fire_2.smd"
	blend "aim_offset" 1 0
	blendwidth 2
	{ event 9001 1 "MuzzleFlash muzzle" }
	{ event 6001 1 "shell_eject" }
	{ event 9001 1 "Ejection shell_eject" }
	{ event 9011 0 "1" }
	{ event 9021 0 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "aim_offset"
	snap
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 10 10 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 10 10 target 1
}

$sequence "iron_fire_last" {
	"v_scotia_anims/iron_fire_last.smd"
	"v_scotia_anims/iron_fire_last_2.smd"
	blend "aim_offset" 1 0
	blendwidth 2
	{ event 9001 1 "MuzzleFlash muzzle" }
	{ event 6001 1 "shell_eject" }
	{ event 9001 1 "Ejection shell_eject" }
	{ event 5004 1 "wpn_br_hcharlie36_plr_last_mech_01" }
	{ event 9011 0 "1" }
	{ event 9021 0 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "aim_offset"
	addlayer "empty_offset"
	snap
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 19 19 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 19 19 target 1
}

$sequence "ads_in" {
	"v_scotia_anims/ads_in.smd"
	{ event 9011 0 "1" }
	{ event 5004 1 "wfoly_ar_mike4_ads_up" }
	{ event 9011 0 "1" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 9 9 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 9 9 target 1
}

$sequence "ads_out" {
	"v_scotia_anims/ads_out.smd"
	{ event 9011 0 "1" }
	{ event 5004 1 "wfoly_ar_mike4_ads_down" }
	{ event 9011 0 "1" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 9 9 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 9 9 target 1
}

$sequence "ads_in_empty" {
	"v_scotia_anims/ads_in_empty.smd"
	{ event 9011 0 "1" }
	{ event 5004 1 "wfoly_ar_mike4_ads_up" }
	{ event 9011 0 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "empty_offset"
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 9 9 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 9 9 target 1
}

$sequence "ads_out_empty" {
	"v_scotia_anims/ads_out_empty.smd"
	{ event 9011 0 "1" }
	{ event 5004 1 "wfoly_ar_mike4_ads_down" }
	{ event 9011 0 "1" }
	fadein 0.2
	fadeout 0.2
	addlayer "empty_offset"
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 9 9 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 9 9 target 1
}

$sequence "melee_miss_01" {
	"v_scotia_anims/melee_miss_01.smd"
	activity "ACT_VM_HITCENTER" 1
	{ event 9011 0 "0" }
	{ event 9011 25 "1" }
	{ event 9021 0 "0" }
	{ event 9021 1 "1" }
	{ event 5004 0 "MW_Melee.Miss_Medium" }
	{ event 5004 7 "Viewmodel.Large" }
	{ event 5004 8 "Viewmodel.Medium" }
	{ event 5004 31 "Viewmodel.Small" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 1
}

$sequence "melee_miss_01e" {
	"v_scotia_anims/melee_miss_01e.smd"
	activity "ACT_VM_MISSCENTER" 1
	{ event 9011 0 "0" }
	{ event 9011 25 "1" }
	{ event 9021 0 "0" }
	{ event 9021 1 "1" }
	{ event 5004 0 "MW_Melee.Miss_Medium" }
	{ event 5004 7 "Viewmodel.Large" }
	{ event 5004 8 "Viewmodel.Medium" }
	{ event 5004 31 "Viewmodel.Small" }
	fadein 0.2
	fadeout 0.2
	addlayer "empty_offset"
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 1
}

$sequence "melee_miss_02" {
	"v_scotia_anims/melee_miss_02.smd"
	{ event 9011 0 "0" }
	{ event 9011 25 "1" }
	{ event 9021 0 "0" }
	{ event 9021 1 "1" }
	{ event 5004 0 "MW_Melee.Miss_Medium" }
	{ event 5004 7 "Viewmodel.Large" }
	{ event 5004 8 "Viewmodel.Medium" }
	{ event 5004 31 "Viewmodel.Small" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 1
}

$sequence "melee_hit_01" {
	"v_scotia_anims/melee_hit_01.smd"
	{ event 9011 0 "0" }
	{ event 9011 26 "1" }
	{ event 9021 0 "0" }
	{ event 9021 1 "1" }
	{ event 5004 7 "Viewmodel.Large" }
	{ event 5004 0 "MW_Melee.Flesh_Medium" }
	{ event 5004 8 "Viewmodel.Medium" }
	{ event 5004 31 "Viewmodel.Small" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 1
}

$sequence "melee_hit_02" {
	"v_scotia_anims/melee_hit_02.smd"
	{ event 9011 0 "0" }
	{ event 9011 26 "1" }
	{ event 9021 0 "0" }
	{ event 9021 1 "1" }
	{ event 5004 7 "Viewmodel.Large" }
	{ event 5004 0 "MW_Melee.Flesh_Medium" }
	{ event 5004 8 "Viewmodel.Medium" }
	{ event 5004 31 "Viewmodel.Small" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 1
}

$sequence "melee_hit_03" {
	"v_scotia_anims/melee_hit_03.smd"
	{ event 9011 0 "0" }
	{ event 9011 26 "1" }
	{ event 9021 0 "0" }
	{ event 9021 1 "1" }
	{ event 5004 7 "Viewmodel.Large" }
	{ event 5004 0 "MW_Melee.Flesh_Medium" }
	{ event 5004 8 "Viewmodel.Medium" }
	{ event 5004 31 "Viewmodel.Small" }
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" touch "tag_ik_loc_ri" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 39 39 target 1
}

$sequence "aim_offset" {
	"a_aim_idle_to_sub"
	"a_delta_ads_additive_for_offset"
	blend "aim_offset" 1 0
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "jog_offset" {
	"a_jog_offset_idle"
	"a_jog_offset"
	blend "jog_offset" 1 0
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "a_jog_to_walk" {
	"v_scotia_anims/a_jog_to_walk.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@a_jog_to_walk_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 23 23 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 23 23 target 1
}

$sequence "jog_out" {
	"v_scotia_anims/jog_out.smd"
	fadein 0.2
	fadeout 0.2
	fps 1.304
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$sequence "firemode_offset" {
	"a_firemode_idle"
	"fix_semi_add"
	blend "firemode_offset" 0 1
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "jog_loop" {
	"a_jog_idle"
	"a_jog"
	blend "jog_loop" 1 0
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "walk_loop" {
	"a_walk_idle"
	"a_walk"
	blend "walk_loop" 0 1
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "a_walk_to_sprint" {
	"v_scotia_anims/a_walk_to_sprint.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@a_walk_to_sprint_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 24 24 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 24 24 target 1
}

$sequence "sprint_in" {
	"v_scotia_anims/sprint_in.smd"
	fadein 0.2
	fadeout 0.2
	fps 1.25
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$sequence "sprint_loop" {
	"a_sprint_idle"
	"a_sprint"
	blend "sprint_loop" 1 0
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "a_sprint_to_walk" {
	"v_scotia_anims/a_sprint_to_walk.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@a_sprint_to_walk_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 23 23 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 23 23 target 1
}

$sequence "sprint_out" {
	"v_scotia_anims/sprint_out.smd"
	fadein 0.2
	fadeout 0.2
	fps 1.25
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$sequence "sprint_offset" {
	"a_sprint_offset_idle"
	"a_sprint_offset"
	blend "sprint_offset" 1 0
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "a_idle_active" {
	"a_fidget"
	"a_zerodiff"
	blend "aim_offset" 0 1
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "freefall_loop" {
	"a_freefall_idle"
	"a_freefall"
	blend "freefall_loop" 0 1
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "a_landdelta" {
	"v_scotia_anims/a_landdelta.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@a_landdelta_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 22 22 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 22 22 target 1
}

$sequence "jump_land" {
	"v_scotia_anims/jump_land.smd"
	fadein 0.2
	fadeout 0.2
	fps 1.363
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$sequence "a_jumpdelta" {
	"v_scotia_anims/a_jumpdelta.smd"
	delta
	// Crowbar writes this subtract option to prevent jigglebone and poseparameter problems when delta sequences are recompiled.
	subtract "@a_jumpdelta_corrective_animation" 0
	fadein 0.2
	fadeout 0.2
	fps 30
	ikrule "rhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 18 18 target 0
	ikrule "lhand" release contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 18 18 target 1
}

$sequence "jump" {
	"v_scotia_anims/jump.smd"
	fadein 0.2
	fadeout 0.2
	fps 2.727
	ikrule "rhand" touch "tag_sling" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 0
	ikrule "lhand" touch "tag_ik_loc_le" contact 0 fakeorigin 0 0 0 fakerotate 0 -0 0 floor 0 height 0 radius 0 range 0 0 1 1 target 1
}

$sequence "empty_offset" {
	"a_empty_idle_to_sub"
	"a_delta_empty_additive_for_offset"
	blend "empty_offset" 0.5 0
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "grip_ang_offset" {
	"a_aim_idle_to_sub"
	"ang_pose_v1"
	blend "grip_ang_offset" 0 1
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "grip_vert_offset" {
	"a_aim_idle_to_sub"
	"vert_pose_v1"
	blend "grip_vert_offset" 0 1
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "grip_vertpro_offset" {
	"a_aim_idle_to_sub"
	"vert_pro_v1"
	blend "grip_vertpro_offset" 0 1
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "grip_ang_short_offset" {
	"a_aim_idle_to_sub"
	"ang_pose_v2"
	blend "grip_ang_short_offset" 0 1
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$sequence "grip_misc_offset" {
	"a_aim_idle_to_sub"
	"misc_pose_v1"
	blend "grip_misc_offset" 0 1
	blendwidth 2
	delta
	fadein 0.2
	fadeout 0.2
	realtime
}

$keyvalues
{
}

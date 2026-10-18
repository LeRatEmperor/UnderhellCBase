<<<<<<< HEAD
// Decompiled from m93r.mdl
=======
// 

>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
$modelname "weapons/c_m93r.mdl"

$bodygroup "m9"
{
<<<<<<< HEAD
	studio "m93r.smd"
}
$bodygroup "suppressor"
{
	studio "m93r.smd"
}

$surfaceprop "default"
$contents "solid"
$illumposition 4.412000 0.611000 -13.339000

$cdmaterials ""
$cdmaterials ""
$cdmaterials ""

$bbox -8.894000 -7.609000 -25.945999 17.716999 8.831000 -0.732000
$cbox 0 0 0 0 0 0

$attachment "1" "muzzle_flash" 1.000000 -0.000000 0.000000 rotate 0.200001 -0.000000 1.000000
$attachment "2" "shell_ejection" 0.866025 -0.500000 0.000000 rotate -0.000000 0.500000 0.866025

$definebone "ValveBiped.Bip01_Root" "" 1.983461 8.830967 -25.945992 0.000000 0.000000 -0.707106 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Pelvis" "ValveBiped.Bip01_Root" 0.000000 0.000000 0.000000 -0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Spine" "Pelvis" 5.461617 6.827055 -1.983477 -0.000000 0.000387 0.000001 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Spine1" "Spine" 6.236319 -0.006065 0.000000 -0.196124 0.000156 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Neck" "Spine1" 6.363842 -0.001061 0.000014 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Clavicle" "Neck" 0.000000 0.002061 -1.508108 0.814519 -0.133995 -0.525019 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853310 0.000001 0.000001 0.183561 -0.577543 -0.728398 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.393280 0.000002 -0.000002 0.000000 0.000000 -0.539095 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525156 0.000002 -0.000004 0.789644 0.292329 -0.028617 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.557343 0.315021 0.821068 -0.749943 -0.355603 -0.038097 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.557490 0.000001 -0.000001 -0.000000 0.000000 0.275321 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.220284 -0.000000 0.000002 -0.000000 0.000000 0.296669 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_thumb_tip" "ValveBiped.Bip01_R_Finger02" 0.322370 0.024372 0.001706 -0.998703 0.002220 0.021548 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_thumb_mid" "ValveBiped.Bip01_R_Finger01" 0.472650 -0.205722 0.040340 -0.988715 -0.139523 0.024634 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_thumb_low" "ValveBiped.Bip01_R_Finger0" 0.746821 -0.152274 0.135879 -0.998870 -0.009474 0.036664 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.831470 -0.209887 1.278946 -0.015275 0.162852 0.051876 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382491 -0.000000 0.000000 0.000000 -0.000000 0.259544 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.866467 0.000001 0.000000 0.000000 -0.000000 0.391216 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_index_tip" "ValveBiped.Bip01_R_Finger12" -0.077940 -0.073037 0.031671 0.676556 -0.035399 -0.051529 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_index_mid" "ValveBiped.Bip01_R_Finger11" 0.178063 -0.058576 -0.009662 0.681103 -0.011574 -0.021449 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_index_low" "ValveBiped.Bip01_R_Finger1" 0.329239 0.031135 -0.096597 0.650409 -0.125208 -0.032254 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.814442 -0.266586 0.536788 0.069972 0.252702 0.305085 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445683 0.000001 0.000000 0.000000 -0.000000 0.667324 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053950 0.000005 -0.000000 -0.000000 -0.000000 0.596022 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_middle_tip" "ValveBiped.Bip01_R_Finger22" -0.032545 0.096451 -0.016163 0.695960 0.021430 0.036897 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_middle_mid" "ValveBiped.Bip01_R_Finger21" 0.149343 0.050403 -0.032008 0.699277 0.012258 0.025458 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_middle_low" "ValveBiped.Bip01_R_Finger2" 0.356819 0.042253 -0.132234 0.696337 -0.020980 0.036736 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.688777 -0.343061 -0.243351 0.124184 0.234319 0.394060 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.440185 -0.000004 0.000002 0.000000 -0.000000 0.639468 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.983190 -0.000002 -0.000001 0.018669 -0.011480 0.562786 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_ring_tip" "ValveBiped.Bip01_R_Finger32" -0.082892 0.161453 -0.001984 0.759888 0.002961 -0.057166 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_ring_mid" "ValveBiped.Bip01_R_Finger31" 0.101631 0.085269 -0.020670 0.765989 0.031657 0.041391 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_ring_low" "ValveBiped.Bip01_R_Finger3" 0.316780 0.085630 -0.076644 0.769751 -0.012943 0.019058 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.424231 -0.353684 -1.020247 0.171214 0.175304 0.421964 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.103120 -0.000004 -0.000002 0.052850 0.049637 0.482923 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.909964 0.000001 0.000001 0.000000 -0.000000 0.486335 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_pinky_tip" "ValveBiped.Bip01_R_Finger42" -0.122943 0.121940 0.025750 0.770102 0.105885 0.060965 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_pinky_mid" "ValveBiped.Bip01_R_Finger41" 0.129880 0.151013 0.033726 0.775024 0.035387 0.030967 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_pinky_low" "ValveBiped.Bip01_R_Finger4" 0.358832 0.190003 0.032558 0.778104 -0.013579 -0.010091 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_wrist" "ValveBiped.Bip01_R_Hand" -0.404172 0.031242 0.107285 0.696334 -0.040460 -0.036450 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist" "ValveBiped.Bip01_R_UpperArm" 10.393280 0.000002 -0.000002 0.023631 -0.015125 -0.538883 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist1" "R ForeTwist" 1.217878 0.000000 0.000000 0.028057 0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_armtwist_1" "R ForeTwist1" -1.389066 -0.414085 0.026890 -0.999194 -0.016765 0.001616 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist2" "R ForeTwist1" 1.217877 0.000000 0.000000 0.028057 0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist3" "R ForeTwist2" 1.217878 -0.000002 -0.000000 0.028057 0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist4" "R ForeTwist3" 1.217880 0.000003 -0.000000 0.028057 0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist5" "R ForeTwist4" 1.217880 0.000000 -0.000000 0.028057 0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist6" "R ForeTwist5" 1.217876 0.000001 -0.000000 0.028057 0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_armtwist_4" "R ForeTwist6" -1.139465 -0.200616 0.016822 -0.999194 -0.016740 0.001838 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_armtwist_3" "R ForeTwist5" -1.817343 -0.264394 0.020775 -0.999194 -0.016746 0.001794 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_armtwist_2" "R ForeTwist3" -1.518572 -0.336370 0.024042 -0.999194 -0.016757 0.001705 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r_upperarm" "ValveBiped.Bip01_R_UpperArm" -1.961135 -0.019129 0.960382 0.999138 -0.015280 -0.038490 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "usp_main" "" -2.536746 -12.163893 -2.335202 0.499989 -0.500011 -0.500011 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "usp_barrel" "usp_main" 2.083984 0.616699 0.000000 0.000000 0.000000 0.029928 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "muzzle_flash" "usp_barrel" 3.267395 0.333982 0.007761 0.000000 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "shell_ejection" "usp_main" 0.223548 1.289429 0.520273 -0.091686 -0.625387 0.074338 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "usp_trigger" "usp_main" 1.398664 -0.091955 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "usp_slide" "usp_main" 3.804338 0.860844 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "usp_hammer" "usp_main" -1.696121 0.240685 0.000000 0.000000 0.000000 0.490395 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "usp_magazine" "usp_main" -0.392484 -0.832852 0.000001 0.000000 -0.000000 -0.148499 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "usp_bullets" "usp_magazine" -0.018716 1.546493 -0.000074 0.000000 -0.000000 0.215999 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Clavicle" "Neck" 0.000000 0.002053 1.508081 -0.706922 0.016166 -0.706935 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853311 -0.000000 0.000000 -0.166688 0.514175 -0.402343 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.393284 0.000004 -0.000001 -0.000000 -0.000000 -0.670856 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525153 -0.000006 -0.000001 -0.681709 -0.519422 0.002215 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.557343 0.315022 -0.821067 0.716850 0.357017 0.064204 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.557487 0.000000 0.000001 -0.013050 0.000351 0.280058 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.220284 -0.000000 0.000000 0.045985 0.009524 0.483319 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_thumb_tip" "ValveBiped.Bip01_L_Finger02" 0.205811 0.027752 0.056258 -0.039007 0.012921 0.033158 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_thumb_mid" "ValveBiped.Bip01_L_Finger01" 0.342587 -0.224117 -0.058165 -0.038237 -0.031514 0.133003 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_thumb_low" "ValveBiped.Bip01_L_Finger0" 0.628740 -0.150741 -0.238198 -0.021444 -0.087977 -0.006656 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.831477 -0.209886 -1.278941 -0.057359 -0.183746 0.467576 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382490 0.000000 0.000000 -0.000000 -0.000000 0.613769 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.866469 -0.000001 -0.000002 -0.000000 0.000000 0.417609 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_index_tip" "ValveBiped.Bip01_L_Finger12" -0.115995 0.136214 0.119478 0.731102 -0.051121 -0.032702 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_index_mid" "ValveBiped.Bip01_L_Finger11" 0.111596 -0.181038 0.087602 0.727244 0.032358 0.048474 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_index_low" "ValveBiped.Bip01_L_Finger1" 0.687411 0.137435 0.132266 0.726229 -0.057801 -0.105648 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.814445 -0.266586 -0.536781 -0.064068 -0.185973 0.507162 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445679 -0.000001 0.000000 -0.000000 -0.000000 0.623955 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053951 -0.000001 -0.000002 -0.000000 0.000000 0.478989 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_middle_tip" "ValveBiped.Bip01_L_Finger22" -0.144276 0.134284 0.011645 0.713150 0.066679 0.033040 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_middle_mid" "ValveBiped.Bip01_L_Finger21" 0.047011 0.012902 0.048839 0.710651 0.065974 0.035073 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_middle_low" "ValveBiped.Bip01_L_Finger2" 0.264220 0.064895 0.179359 0.712111 0.023978 -0.050703 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.688777 -0.343059 0.243349 -0.121296 -0.170204 0.545307 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.440186 -0.000006 -0.000001 -0.000000 0.000000 0.616995 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.983192 -0.000002 -0.000001 -0.020270 0.008336 0.422744 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_ring_tip" "ValveBiped.Bip01_L_Finger32" -0.144176 0.021755 -0.012703 0.662051 0.075559 0.095196 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_ring_mid" "ValveBiped.Bip01_L_Finger31" 0.026013 0.091388 0.018707 0.667113 -0.008813 -0.038611 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_ring_low" "ValveBiped.Bip01_L_Finger3" 0.244614 0.119343 0.125542 0.663419 0.025503 -0.037241 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.424234 -0.353683 1.020251 -0.165228 -0.136423 0.519702 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.103117 0.000006 -0.000001 -0.000000 0.000000 0.353789 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.909956 0.000002 0.000000 -0.000000 0.000000 0.434079 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_pinky_tip" "ValveBiped.Bip01_L_Finger42" -0.205940 0.218741 -0.005665 0.628452 0.025847 0.064846 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_pinky_mid" "ValveBiped.Bip01_L_Finger41" 0.075366 0.171684 0.009089 0.627807 0.037496 0.028109 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_pinky_low" "ValveBiped.Bip01_L_Finger4" 0.303744 0.224131 0.022638 0.624496 -0.010888 -0.026163 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_wrist" "ValveBiped.Bip01_L_Hand" -0.483189 0.085924 0.039585 0.730403 -0.019538 -0.035362 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist" "ValveBiped.Bip01_L_UpperArm" 10.393284 0.000004 -0.000001 -0.020820 0.018834 -0.670591 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist1" "L ForeTwist" 1.217879 0.000001 -0.000001 -0.028075 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist2" "L ForeTwist1" 1.217879 -0.000004 0.000000 -0.028075 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist3" "L ForeTwist2" 1.217880 -0.000003 0.000000 -0.028075 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist4" "L ForeTwist3" 1.217879 -0.000002 0.000000 -0.028075 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist5" "L ForeTwist4" 1.217879 -0.000002 0.000002 -0.028075 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist6" "L ForeTwist5" 1.217877 0.000001 -0.000002 -0.028075 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_armtwist_4" "L ForeTwist6" -1.229097 -0.098787 -0.063422 -0.074438 -0.002014 0.026658 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_armtwist_3" "L ForeTwist4" -0.687421 -0.200492 -0.062449 -0.082263 -0.002082 0.026652 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_armtwist_2" "L ForeTwist2" -0.386811 -0.315084 -0.060283 -0.090082 -0.002151 0.026646 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_armtwist_1" "L ForeTwist1" -1.473238 -0.438568 -0.057920 -0.097892 -0.002289 0.026634 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l_upperarm" "ValveBiped.Bip01_L_UpperArm" -2.016220 -0.514363 -1.382949 0.002147 -0.054566 0.004444 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

$BoneMerge "ValveBiped.Bip01_Spine4"
=======
	studio "m9.smd"
}
$bodygroup "suppressor"
{
	blank
	blank
	studio "suppressor.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 0.611 -4.412 -13.339

$cdmaterials "models\bf3\weapons\pistols\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"m9"
		"suppressor_pistol"
	}
}

$attachment "1" "muzzle_flash" 0.2 -0.04 -0.01 rotate -0 -0 0
$attachment "2" "shell_ejection" -0 0 0 rotate -0 30 0

$cbox 0 0 0 0 0 0

$bbox -8.894 -7.609 -25.946 17.717 8.831 -0.732

$definebone "ValveBiped.Bip01_Root" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "ValveBiped.Bip01_Root" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 5.461617 6.827055 -1.983477 0.044404 0.000115 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 6.236319 -0.006065 0 0.017475 -0.003495 -22.620775 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 6.363842 -0.001061 0.000014 -0 -0 0.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Neck1" 0.000000 0.002061 -1.508108 -1.668475 1.286518 2.942953 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853310 0.000001 0.000001 1.639479 -0.008065 -0.586846 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.393280 0.000002 -0.000002 0.000000 0.000000 -0.060372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525156 0.000002 -0.000004 -1.564937 0.106606 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.557343 0.315021 0.821068 1.221731 0.673635 -0.793558 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.557490 0.000001 -0.000001 0.000000 0.000000 0.226893 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.220284 -0.000000 0.000002 0.000000 0.000000 0.362905 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.831470 -0.209887 1.278946 -0.354419 0.038567 -0.532001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382491 -0.000000 0.000000 0.000000 -0.006613 -0.362970 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.866467 0.000001 0.000000 -0.000000 -0.004211 -0.244312 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.814442 -0.266586 0.536788 -0.085905 -0.026404 -0.587695 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445683 0.000001 0.000000 0.000000 -0.007974 -0.366436 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053950 0.000005 -0.000000 0.000000 -0.004461 -0.216376 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.688777 -0.343061 -0.243351 0.150078 -0.079191 -0.810205 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.440185 -0.000004 0.000002 0.000000 0.000000 -0.247771 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.983190 -0.000002 -0.000001 0.000000 -0.000000 -0.430761 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.424231 -0.353684 -1.020247 0.466236 -0.158066 -0.878825 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.103120 -0.000004 -0.000002 -0.000000 0.000000 -0.439672 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.909964 0.000001 0.000001 0.000000 0.000000 -0.244271 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_UpperArm" 10.39328 0.000002 -0.000002 0.000015 -65.244146 3.215495 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217878 0 0 0.000009 -0.000006 3.215494 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.217877 0 0 0.000014 -0.000005 3.215491 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217878 -0.000002 -0 0.000012 -0.000008 3.21549 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.21788 0.000003 -0 0.000012 -0.000006 3.215489 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.21788 0 -0 0.000009 -0.000005 3.215488 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.217876 0.000001 -0 0.00001 -0.000005 3.215489 0 0 0 0 0 0
$definebone "usp_main" "" -2.536746 -12.163893 -2.335202 0 -90.002502 90.000037 0 0 0 0 0 0
$definebone "usp_barrel" "usp_main" 2.083984 0.616699 0 -0 3.430012 0 0 0 0 0 0 0
$definebone "muzzle_flash" "usp_barrel" 3.267395 0.333982 0.007761 -0 -0 0 0 0 0 0 0 0
$definebone "shell_ejection" "usp_main" 0.223548 1.289429 0.520273 -72.014605 47.970147 -49.393374 0 0 0 0 0 0
$definebone "usp_trigger" "usp_main" 1.398664 -0.091955 0 -0 0 0 0 0 0 0 0 0
$definebone "usp_slide" "usp_main" 3.804338 0.860844 0 -0 0 0 0 0 0 0 0 0
$definebone "usp_hammer" "usp_main" -1.696121 0.240685 0 -0 58.733043 0 0 0 0 0 0 0
$definebone "usp_magazine" "usp_main" -0.392484 -0.832852 0.000001 -0 -17.079872 0 0 0 0 0 0 0
$definebone "usp_bullets" "usp_magazine" -0.018716 1.546493 -0.000074 -0 24.948302 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Neck1" 0.000000 0.002053 1.508081 1.596637 -1.286515 2.942962 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853311 -0.000000 0.000000 -1.579613 0.047802 -0.585173 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.393284 0.000004 -0.000001 0.000000 0.000000 -0.060372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525153 -0.000006 -0.000001 1.573183 -0.106613 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.557343 0.315022 -0.821067 -1.222677 -0.679213 -0.788819 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.557487 0.000000 0.000001 0.000000 0.000000 0.228523 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.220284 -0.000000 0.000000 0.000000 0.000000 0.362860 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.831477 -0.209886 -1.278941 0.354449 -0.042750 -0.531718 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382490 0.000000 0.000000 -0.000000 0.004074 -0.363009 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.866469 -0.000001 -0.000002 -0.000000 0.002596 -0.244331 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.814445 -0.266586 -0.536781 0.085902 0.021830 -0.587867 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445679 -0.000001 0.000000 -0.000000 0.005516 -0.366478 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053951 -0.000001 -0.000002 0.000000 0.003084 -0.216400 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.688777 -0.343059 0.243349 -0.151780 0.073206 -0.810985 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.440186 -0.000006 -0.000001 0.000000 0.000000 -0.247797 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.983192 -0.000002 -0.000001 -0.000000 0.000000 -0.430802 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.424234 -0.353683 1.020251 -0.468133 0.151533 -0.880197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.103117 0.000006 -0.000001 0.000000 0.000000 -0.439720 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.909956 0.000002 0.000000 0.000000 0.000000 -0.244299 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_UpperArm" 10.393284 0.000004 -0.000001 -0.000012 -84.266264 -3.217624 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217879 0.000001 -0.000001 -0.000012 -0.000001 -3.217625 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217879 -0.000004 0 -0.00001 -0.000004 -3.217627 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.21788 -0.000003 0 -0.000005 -0.000004 -3.21763 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217879 -0.000002 0 -0.000005 -0.000006 -3.217632 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.217879 -0.000002 0.000002 -0.000007 -0.000003 -3.217634 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217877 0.000001 -0.000002 -0.000003 -0.000008 -3.217637 0 0 0 0 0 0

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

$sequence "idle" {
	"m93r_anims/idle.smd"
	fps 30
=======


$sequence "idle" {
	"m93r_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 15
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "draw" {
	"m93r_anims/draw.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_DRAW" 1
	{ event 5004 1 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "fire" {
	"m93r_anims/fire.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 18
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "shoot_empty" {
	"m93r_anims/shoot_empty.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_DRYFIRE" 1
	{ event 5004 0 "bf3.empty" }
	fadein 0.2
	fadeout 0.2
	snap
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "reload" {
	"m93r_anims/reload.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 12 "bf3_m9.clipout" }
	{ event 5004 49 "bf3_m9.clipin" }
	{ event 5004 59 "bf3_m9.slide" }
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "reload_full" {
	"m93r_anims/reload_full.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_RELOAD" 1
	{ event 5004 14 "bf3_m9.clipout" }
	{ event 5004 49 "bf3_m9.clipin" }
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "fire_empty" {
	"m93r_anims/fire_empty.smd"
<<<<<<< HEAD
	fps 30
}

=======
	activity "ACT_VM_DRYFIRE" 1
	{ event 5004 0 "bf3.empty" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 120
}
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3

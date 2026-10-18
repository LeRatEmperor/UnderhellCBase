// 

$modelname "weapons/c_mp443.mdl"

$bodygroup "m9"
{
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
		"mp443"
		"suppressor_pistol"
	}
}

$attachment "1" "muzzle_flash" 0.2 -0.04 -0.01 rotate -0 -0 0
$attachment "2" "shell_ejection" -0 0 0 rotate -0 30 0

$cbox 0 0 0 0 0 0

$bbox -8.894 -7.609 -25.946 17.717 8.831 -0.732

$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "(null)" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 5.461617 6.827055 -1.983477 0.044404 0.000115 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 6.236319 -0.006065 0 0.017475 -0.003495 -22.620775 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 6.363842 -0.001061 0.000014 -0 -0 0.000005 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Neck1" 0 0.002061 -1.508108 53.104468 -46.560378 127.178013 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_UpperArm" "anim_ValveBiped.Bip01_R_Clavicle" 5.85331 0.000001 0.000001 -5.844633 -137.058032 74.520957 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Forearm" "anim_ValveBiped.Bip01_R_UpperArm" 10.39328 0.000002 -0.000002 0.000015 -65.244146 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Hand" "anim_ValveBiped.Bip01_R_Forearm" 8.525156 0.000002 -0.000004 21.109039 27.505293 116.618964 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger0" "anim_ValveBiped.Bip01_R_Hand" 0.557343 0.315021 0.821068 -26.931205 33.413982 -115.067514 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger01" "anim_ValveBiped.Bip01_R_Finger0" 1.55749 0.000001 -0.000001 0.000006 31.962277 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger02" "anim_ValveBiped.Bip01_R_Finger01" 1.220284 -0 0.000002 0.000007 34.51533 -0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger1" "anim_ValveBiped.Bip01_R_Hand" 2.83147 -0.209887 1.278946 18.811637 5.896128 -0.799095 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger11" "anim_ValveBiped.Bip01_R_Finger1" 1.382491 -0 0 -0.000004 30.086068 0.000007 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger12" "anim_ValveBiped.Bip01_R_Finger11" 0.866467 0.000001 0 -0.000007 46.06031 0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger2" "anim_ValveBiped.Bip01_R_Hand" 2.814442 -0.266586 0.536788 24.835203 40.882763 18.124382 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger21" "anim_ValveBiped.Bip01_R_Finger2" 1.445683 0.000001 0 -0.000007 83.721686 -0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger22" "anim_ValveBiped.Bip01_R_Finger21" 1.05395 0.000005 -0 -0.000001 73.171052 -0.000008 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger3" "anim_ValveBiped.Bip01_R_Hand" 2.688777 -0.343061 -0.243351 18.332298 52.366278 25.137553 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger31" "anim_ValveBiped.Bip01_R_Finger3" 1.440185 -0.000004 0.000002 -0.000006 79.504263 -0.000004 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger32" "anim_ValveBiped.Bip01_R_Finger31" 0.98319 -0.000002 -0.000001 -2.291603 68.495623 1.028223 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger4" "anim_ValveBiped.Bip01_R_Hand" 2.424231 -0.353684 -1.020247 9.296462 53.830077 26.922543 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger41" "anim_ValveBiped.Bip01_R_Finger4" 1.10312 -0.000004 -0.000002 2.039377 58.063602 8.063524 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger42" "anim_ValveBiped.Bip01_R_Finger41" 0.909964 0.000001 0.000001 -0.00001 58.199953 -0.000005 0 0 0 0 0 0
$definebone "usp_main" "" -2.536746 -12.163893 -2.335202 0 -90.002502 90.000037 0 0 0 0 0 0
$definebone "usp_barrel" "usp_main" 2.083984 0.616699 0 -0 3.430012 0 0 0 0 0 0 0
$definebone "muzzle_flash" "usp_barrel" 3.267395 0.333982 0.007761 -0 -0 0 0 0 0 0 0 0
$definebone "shell_ejection" "usp_main" 0.223548 1.289429 0.520273 -72.014605 47.970147 -49.393374 0 0 0 0 0 0
$definebone "usp_trigger" "usp_main" 1.398664 -0.091955 0 -0 0 0 0 0 0 0 0 0
$definebone "usp_slide" "usp_main" 3.804338 0.860844 0 -0 0 0 0 0 0 0 0 0
$definebone "usp_hammer" "usp_main" -1.696121 0.240685 0 -0 58.733043 0 0 0 0 0 0 0
$definebone "usp_magazine" "usp_main" -0.392484 -0.832852 0.000001 -0 -17.079872 0 0 0 0 0 0 0
$definebone "usp_bullets" "usp_magazine" -0.018716 1.546493 -0.000074 -0 24.948302 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Neck1" 0 0.002053 1.508081 -87.425568 -90.045936 -89.99975 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_UpperArm" "anim_ValveBiped.Bip01_L_Clavicle" 5.853311 -0 0 38.734016 -79.101295 -57.799684 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Forearm" "anim_ValveBiped.Bip01_L_UpperArm" 10.393284 0.000004 -0.000001 -0.000012 -84.266264 -0.000007 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Hand" "anim_ValveBiped.Bip01_L_Forearm" 8.525153 -0.000006 -0.000001 -32.15622 57.056405 -123.644838 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger0" "anim_ValveBiped.Bip01_L_Hand" 0.557343 0.315022 -0.821067 19.457766 38.605144 107.445112 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger01" "anim_ValveBiped.Bip01_L_Finger0" 1.557487 0 0.000001 0.457447 32.524531 -1.424328 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger02" "anim_ValveBiped.Bip01_L_Finger01" 1.220284 -0 0 -1.592986 57.803126 5.142862 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger1" "anim_ValveBiped.Bip01_L_Hand" 2.831477 -0.209886 -1.278941 -15.272487 59.112733 -16.302944 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger11" "anim_ValveBiped.Bip01_L_Finger1" 1.38249 0 0 0.000001 75.724982 -0.000006 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger12" "anim_ValveBiped.Bip01_L_Finger11" 0.866469 -0.000001 -0.000002 0.000011 49.367477 -0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger2" "anim_ValveBiped.Bip01_L_Hand" 2.814445 -0.266586 -0.536781 -14.306884 64.549645 -17.796422 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger21" "anim_ValveBiped.Bip01_L_Finger2" 1.445679 -0.000001 0 0.000007 77.211061 -0.00001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger22" "anim_ValveBiped.Bip01_L_Finger21" 1.053951 -0.000001 -0.000002 0.000015 57.238829 0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger3" "anim_ValveBiped.Bip01_L_Hand" 2.688777 -0.343059 0.243349 -8.281884 69.451351 -22.742192 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger31" "anim_ValveBiped.Bip01_L_Finger3" 1.440186 -0.000006 -0.000001 0.000014 76.194059 -0.000005 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger32" "anim_ValveBiped.Bip01_L_Finger31" 0.983192 -0.000002 -0.000001 1.847742 50.001288 -1.701736 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger4" "anim_ValveBiped.Bip01_L_Hand" 2.424234 -0.353683 1.020251 -3.090599 64.962455 -24.563681 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger41" "anim_ValveBiped.Bip01_L_Finger4" 1.103117 0.000006 -0.000001 0.000005 41.438484 -0.000007 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger42" "anim_ValveBiped.Bip01_L_Finger41" 0.909956 0.000002 0 0.000009 51.453403 -0.000001 0 0 0 0 0 0

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -90.000153 -79.749996 -89.999924 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 0.399878 0.684600 68.057610 90.349795 16.329461 19.729033 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" -43.544990 -42.171036 27.136811 -28.566415 -9.484495 68.528232 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 26.314445 -52.608965 29.063520 -28.012466 -11.124238 149.698744 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" -12.979364 -19.663234 -51.867014 -87.264854 -39.237933 -87.947654 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" -4.217182 -49.762119 24.269080 -9.485173 -6.602765 80.858494 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" -30.636605 -38.115234 23.290837 -10.435609 -5.764964 61.251610 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" -47.360141 8.911771 24.036139 -15.843139 1.821202 23.813712 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" -38.198460 11.914577 -37.479675 -123.180296 -61.924704 -92.800560 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 0.993908 41.135698 -35.962572 -167.781810 -74.958952 -121.159857 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 31.019460 26.644099 -34.900581 144.322737 -71.989198 -120.809186 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" -37.969171 16.416025 -37.477057 -141.068083 -66.745356 -95.674251 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 6.610196 41.986819 -35.897181 162.086213 -71.501380 -112.705110 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 37.937063 17.981257 -34.750473 135.016361 -64.983435 -140.907234 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" -33.490392 24.063130 -39.050961 -169.328735 -71.165681 -84.467979 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 14.563468 39.499175 -37.594280 151.231545 -68.781797 -118.905507 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 39.718968 15.941553 -34.758611 120.335898 -48.234618 -133.781567 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" -29.849417 25.318018 -42.129340 -169.255555 -74.567505 -99.026358 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" -6.717603 39.242605 -40.864099 125.579540 -63.298982 -71.911151 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 25.758335 30.145885 -40.212513 114.613273 -51.118304 -110.408896 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 27.929252 -0.780967 -62.066529 -72.513308 -30.099114 -60.305923 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" -20.370796 -49.668337 -35.220923 5.518049 9.522284 69.430521 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 24.113767 -40.535487 -37.155229 4.930306 9.837340 131.180203 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 7.027136 -20.651098 46.323653 62.196119 41.746349 -102.585249 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 15.202868 -28.759132 -37.483129 1.366330 -17.103668 100.668045 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" -3.026036 -30.028645 -36.956750 -2.633710 -16.959183 82.303970 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" -19.738211 -21.481650 -36.604683 -8.607695 -14.897444 69.316327 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" -11.271258 -23.933010 40.108793 72.224635 76.246749 -86.182976 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" -23.127498 -14.731820 38.438659 -59.297813 81.086095 111.475690 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" -27.186494 7.209871 37.352277 -77.295999 67.822125 46.898812 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" -29.085932 -8.529364 38.503949 118.732698 74.528423 -87.940652 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" -12.270949 29.349224 36.846686 -133.487320 79.924978 -62.496547 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 24.083223 21.103463 35.656153 -109.115034 69.211953 -110.490736 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" -29.444248 0.369146 40.397522 153.907868 83.439365 -77.167310 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" -5.424490 30.365299 38.868503 -117.763276 77.274524 -67.610519 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 27.199721 17.564854 36.333930 -102.496221 51.620480 -119.007772 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" -24.085425 4.695379 44.451000 87.205030 82.952739 -166.693364 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" -10.983363 29.737452 38.998870 -100.037878 64.594054 -51.161932 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 18.902624 25.483167 38.340034 -96.786475 50.741942 -105.542385 0 0 0 0 0 0
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



$sequence "idle" {
	"mp443_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 15
}

$sequence "draw" {
	"mp443_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 1 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire" {
	"mp443_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 18
}

$sequence "shoot_empty" {
	"mp443_anims/shoot_empty.smd"
	activity "ACT_VM_DRYFIRE" 1
	{ event 5004 0 "bf3.empty" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload" {
	"mp443_anims/reload.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 12 "bf3_mp443.clipout" }
	{ event 5004 49 "bf3_mp443.clipin" }
	{ event 5004 59 "bf3_mp443.slide" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "reload_full" {
	"mp443_anims/reload_full.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 14 "bf3_mp443.clipout" }
	{ event 5004 49 "bf3_mp443.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire_empty" {
	"mp443_anims/fire_empty.smd"
	activity "ACT_VM_DRYFIRE" 1
	{ event 5004 0 "bf3.empty" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 120
}

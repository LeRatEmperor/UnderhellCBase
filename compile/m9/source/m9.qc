// 

$modelname "weapons/c_m9.mdl"

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
		"m9"
		"suppressor_pistol"
	}
}

$attachment "1" "muzzle_flash" 0.2 -0.04 -0.01 rotate -0 -0 0
$attachment "2" "shell_ejection" -0 0 0 rotate -0 30 0

$cbox 0 0 0 0 0 0

$bbox -8.894 -7.609 -25.946 17.717 8.831 -0.732

$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "Pelvis" "(null)" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "Spine" "Pelvis" 5.461617 6.827055 -1.983477 0.044404 0.000115 0 0 0 0 0 0 0
$definebone "Spine1" "Spine" 6.236319 -0.006065 0 0.017475 -0.003495 -22.620775 0 0 0 0 0 0
$definebone "Neck" "Spine1" 6.363842 -0.001061 0.000014 -0 -0 0.000005 0 0 0 0 0 0
$definebone "R Clavicle" "Neck" 0 0.002061 -1.508108 53.104468 -46.560378 127.178013 0 0 0 0 0 0
$definebone "R UpperArm" "R Clavicle" 5.85331 0.000001 0.000001 -5.844633 -137.058032 74.520957 0 0 0 0 0 0
$definebone "R Forearm" "R UpperArm" 10.39328 0.000002 -0.000002 0.000015 -65.244146 -0.000003 0 0 0 0 0 0
$definebone "R Hand" "R Forearm" 8.525156 0.000002 -0.000004 21.109039 27.505293 116.618964 0 0 0 0 0 0
$definebone "R Finger0" "R Hand" 0.557343 0.315021 0.821068 -26.931205 33.413982 -115.067514 0 0 0 0 0 0
$definebone "R Finger01" "R Finger0" 1.55749 0.000001 -0.000001 0.000006 31.962277 -0.000003 0 0 0 0 0 0
$definebone "R Finger02" "R Finger01" 1.220284 -0 0.000002 0.000007 34.51533 -0.000002 0 0 0 0 0 0
$definebone "r_thumb_tip" "R Finger02" 0.32237 0.024372 0.001706 2.478507 -0.140365 -174.718671 0 0 0 0 0 0
$definebone "r_thumb_mid" "R Finger01" 0.47265 -0.205722 0.04034 2.013094 16.168757 -174.076237 0 0 0 0 0 0
$definebone "r_thumb_low" "R Finger0" 0.746821 -0.152274 0.135879 4.169131 1.208412 -176.662201 0 0 0 0 0 0
$definebone "R Finger1" "R Hand" 2.83147 -0.209887 1.278946 18.811637 5.896128 -0.799095 0 0 0 0 0 0
$definebone "R Finger11" "R Finger1" 1.382491 -0 0 -0.000004 30.086068 0.000007 0 0 0 0 0 0
$definebone "R Finger12" "R Finger11" 0.866467 0.000001 0 -0.000007 46.06031 0.000001 0 0 0 0 0 0
$definebone "r_index_tip" "R Finger12" -0.07794 -0.073037 0.031671 1.018598 -7.096144 85.293476 0 0 0 0 0 0
$definebone "r_index_mid" "R Finger11" 0.178063 -0.058576 -0.009662 0.703531 -2.703158 85.874923 0 0 0 0 0 0
$definebone "r_index_low" "R Finger1" 0.329239 0.031135 -0.096597 -8.365072 -12.323297 82.882761 0 0 0 0 0 0
$definebone "R Finger2" "R Hand" 2.814442 -0.266586 0.536788 24.835203 40.882763 18.124382 0 0 0 0 0 0
$definebone "R Finger21" "R Finger2" 1.445683 0.000001 0 -0.000007 83.721686 -0.000001 0 0 0 0 0 0
$definebone "R Finger22" "R Finger21" 1.05395 0.000005 -0 -0.000001 73.171052 -0.000008 0 0 0 0 0 0
$definebone "r_middle_tip" "R Finger22" -0.032545 0.096451 -0.016163 -1.182357 4.746253 88.259841 0 0 0 0 0 0
$definebone "r_middle_mid" "R Finger21" 0.149343 0.050403 -0.032008 -1.036659 3.068026 88.754996 0 0 0 0 0 0
$definebone "r_middle_low" "R Finger2" 0.356819 0.042253 -0.132234 -4.658892 1.346565 88.312638 0 0 0 0 0 0
$definebone "R Finger3" "R Hand" 2.688777 -0.343061 -0.243351 18.332298 52.366278 25.137553 0 0 0 0 0 0
$definebone "R Finger31" "R Finger3" 1.440185 -0.000004 0.000002 -0.000006 79.504263 -0.000004 0 0 0 0 0 0
$definebone "R Finger32" "R Finger31" 0.98319 -0.000002 -0.000001 -2.291603 68.495623 1.028223 0 0 0 0 0 0
$definebone "r_ring_tip" "R Finger32" -0.082892 0.161453 -0.001984 5.204632 -4.003727 98.946881 0 0 0 0 0 0
$definebone "r_ring_mid" "R Finger31" 0.101631 0.085269 -0.02067 -1.308871 5.829339 100.109475 0 0 0 0 0 0
$definebone "r_ring_low" "R Finger3" 0.31678 0.08563 -0.076644 -2.628105 0.251813 100.694016 0 0 0 0 0 0
$definebone "R Finger4" "R Hand" 2.424231 -0.353684 -1.020247 9.296462 53.830077 26.922543 0 0 0 0 0 0
$definebone "R Finger41" "R Finger4" 1.10312 -0.000004 -0.000002 2.039377 58.063602 8.063524 0 0 0 0 0 0
$definebone "R Finger42" "R Finger41" 0.909964 0.000001 0.000001 -0.00001 58.199953 -0.000005 0 0 0 0 0 0
$definebone "r_pinky_tip" "R Finger42" -0.122943 0.12194 0.02575 2.217511 13.86321 102.045786 0 0 0 0 0 0
$definebone "r_pinky_mid" "R Finger41" 0.12988 0.151013 0.033726 -0.194815 5.387015 101.76098 0 0 0 0 0 0
$definebone "r_pinky_low" "R Finger4" 0.358832 0.190003 0.032558 -0.077296 -1.937227 102.196255 0 0 0 0 0 0
$definebone "r_wrist" "R Hand" -0.404172 0.031242 0.107285 -0.409554 -6.230116 88.45485 0 0 0 0 0 0
$definebone "R ForeTwist" "R UpperArm" 10.39328 0.000002 -0.000002 0.000015 -65.244146 3.215495 0 0 0 0 0 0
$definebone "R ForeTwist1" "R ForeTwist" 1.217878 0 0 0.000009 -0.000006 3.215494 0 0 0 0 0 0
$definebone "r_armtwist_1" "R ForeTwist1" -1.389066 -0.414085 0.02689 0.115005 1.926681 -175.820462 0 0 0 0 0 0
$definebone "R ForeTwist2" "R ForeTwist1" 1.217877 0 0 0.000014 -0.000005 3.215491 0 0 0 0 0 0
$definebone "R ForeTwist3" "R ForeTwist2" 1.217878 -0.000002 -0 0.000012 -0.000008 3.21549 0 0 0 0 0 0
$definebone "R ForeTwist4" "R ForeTwist3" 1.21788 0.000003 -0 0.000012 -0.000006 3.215489 0 0 0 0 0 0
$definebone "R ForeTwist5" "R ForeTwist4" 1.21788 0 -0 0.000009 -0.000005 3.215488 0 0 0 0 0 0
$definebone "R ForeTwist6" "R ForeTwist5" 1.217876 0.000001 -0 0.00001 -0.000005 3.215489 0 0 0 0 0 0
$definebone "r_armtwist_4" "R ForeTwist6" -1.139465 -0.200616 0.016822 0.140613 1.924794 -175.82109 0 0 0 0 0 0
$definebone "r_armtwist_3" "R ForeTwist5" -1.817343 -0.264394 0.020775 0.135458 1.925307 -175.820817 0 0 0 0 0 0
$definebone "r_armtwist_2" "R ForeTwist3" -1.518572 -0.33637 0.024042 0.125201 1.926105 -175.820544 0 0 0 0 0 0
$definebone "r_upperarm" "R UpperArm" -1.961135 -0.019129 0.960382 4.406284 -1.767221 179.612201 0 0 0 0 0 0
$definebone "usp_main" "" -2.536746 -12.163893 -2.335202 0 -90.002502 90.000037 0 0 0 0 0 0
$definebone "usp_barrel" "usp_main" 2.083984 0.616699 0 -0 3.430012 0 0 0 0 0 0 0
$definebone "muzzle_flash" "usp_barrel" 3.267395 0.333982 0.007761 -0 -0 0 0 0 0 0 0 0
$definebone "shell_ejection" "usp_main" 0.223548 1.289429 0.520273 -72.014605 47.970147 -49.393374 0 0 0 0 0 0
$definebone "usp_trigger" "usp_main" 1.398664 -0.091955 0 -0 0 0 0 0 0 0 0 0
$definebone "usp_slide" "usp_main" 3.804338 0.860844 0 -0 0 0 0 0 0 0 0 0
$definebone "usp_hammer" "usp_main" -1.696121 0.240685 0 -0 58.733043 0 0 0 0 0 0 0
$definebone "usp_magazine" "usp_main" -0.392484 -0.832852 0.000001 -0 -17.079872 0 0 0 0 0 0 0
$definebone "usp_bullets" "usp_magazine" -0.018716 1.546493 -0.000074 -0 24.948302 0 0 0 0 0 0 0
$definebone "L Clavicle" "Neck" 0 0.002053 1.508081 -87.425568 -90.045936 -89.99975 0 0 0 0 0 0
$definebone "L UpperArm" "L Clavicle" 5.853311 -0 0 38.734016 -79.101295 -57.799684 0 0 0 0 0 0
$definebone "L Forearm" "L UpperArm" 10.393284 0.000004 -0.000001 -0.000012 -84.266264 -0.000007 0 0 0 0 0 0
$definebone "L Hand" "L Forearm" 8.525153 -0.000006 -0.000001 -32.15622 57.056405 -123.644838 0 0 0 0 0 0
$definebone "L Finger0" "L Hand" 0.557343 0.315022 -0.821067 19.457766 38.605144 107.445112 0 0 0 0 0 0
$definebone "L Finger01" "L Finger0" 1.557487 0 0.000001 0.457447 32.524531 -1.424328 0 0 0 0 0 0
$definebone "L Finger02" "L Finger01" 1.220284 -0 0 -1.592986 57.803126 5.142862 0 0 0 0 0 0
$definebone "l_thumb_tip" "L Finger02" 0.205811 0.027752 0.056258 1.626983 3.740793 -4.420722 0 0 0 0 0 0
$definebone "l_thumb_mid" "L Finger01" 0.342587 -0.224117 -0.058165 -2.99324 15.431486 -4.829876 0 0 0 0 0 0
$definebone "l_thumb_low" "L Finger0" 0.62874 -0.150741 -0.238198 -10.108529 -0.551928 -2.418291 0 0 0 0 0 0
$definebone "L Finger1" "L Hand" 2.831477 -0.209886 -1.278941 -15.272487 59.112733 -16.302944 0 0 0 0 0 0
$definebone "L Finger11" "L Finger1" 1.38249 0 0 0.000001 75.724982 -0.000006 0 0 0 0 0 0
$definebone "L Finger12" "L Finger11" 0.866469 -0.000001 -0.000002 0.000011 49.367477 -0.000002 0 0 0 0 0 0
$definebone "l_index_tip" "L Finger12" -0.115995 0.136214 0.119478 -1.241304 -6.847236 94.258885 0 0 0 0 0 0
$definebone "l_index_mid" "L Finger11" 0.111596 -0.181038 0.087602 -1.503896 6.511683 93.433026 0 0 0 0 0 0
$definebone "l_index_low" "L Finger1" 0.687411 0.137435 0.132266 4.313103 -13.156324 93.535937 0 0 0 0 0 0
$definebone "L Finger2" "L Hand" 2.814445 -0.266586 -0.536781 -14.306884 64.549645 -17.796422 0 0 0 0 0 0
$definebone "L Finger21" "L Finger2" 1.445679 -0.000001 0 0.000007 77.211061 -0.00001 0 0 0 0 0 0
$definebone "L Finger22" "L Finger21" 1.053951 -0.000001 -0.000002 0.000015 57.238829 0.000001 0 0 0 0 0 0
$definebone "l_middle_tip" "L Finger22" -0.144276 0.134284 0.011645 2.626969 8.123903 91.494714 0 0 0 0 0 0
$definebone "l_middle_mid" "L Finger21" 0.047011 0.012902 0.048839 2.433308 8.219725 91.075648 0 0 0 0 0 0
$definebone "l_middle_low" "L Finger2" 0.26422 0.064895 0.179359 6.071685 -2.121788 90.884737 0 0 0 0 0 0
$definebone "L Finger3" "L Hand" 2.688777 -0.343059 0.243349 -8.281884 69.451351 -22.742192 0 0 0 0 0 0
$definebone "L Finger31" "L Finger3" 1.440186 -0.000006 -0.000001 0.000014 76.194059 -0.000005 0 0 0 0 0 0
$definebone "L Finger32" "L Finger31" 0.983192 -0.000002 -0.000001 1.847742 50.001288 -1.701736 0 0 0 0 0 0
$definebone "l_ring_tip" "L Finger32" -0.144176 0.021755 -0.012703 -0.818858 13.938232 83.57106 0 0 0 0 0 0
$definebone "l_ring_mid" "L Finger31" 0.026013 0.091388 0.018707 2.200915 -3.971271 83.693491 0 0 0 0 0 0
$definebone "l_ring_low" "L Finger3" 0.244614 0.119343 0.125542 5.020253 -1.253415 83.171118 0 0 0 0 0 0
$definebone "L Finger4" "L Hand" 2.424234 -0.353683 1.020251 -3.090599 64.962455 -24.563681 0 0 0 0 0 0
$definebone "L Finger41" "L Finger4" 1.103117 0.000006 -0.000001 0.000005 41.438484 -0.000007 0 0 0 0 0 0
$definebone "L Finger42" "L Finger41" 0.909956 0.000002 0 0.000009 51.453403 -0.000001 0 0 0 0 0 0
$definebone "l_pinky_tip" "L Finger42" -0.20594 0.218741 -0.005665 -2.37599 7.647391 77.939794 0 0 0 0 0 0
$definebone "l_pinky_mid" "L Finger41" 0.075366 0.171684 0.009089 1.316318 5.208709 77.938647 0 0 0 0 0 0
$definebone "l_pinky_low" "L Finger4" 0.303744 0.224131 0.022638 0.898509 -3.121089 77.302763 0 0 0 0 0 0
$definebone "l_wrist" "L Hand" -0.483189 0.085924 0.039585 1.433362 -4.403861 93.885438 0 0 0 0 0 0
$definebone "L ForeTwist" "L UpperArm" 10.393284 0.000004 -0.000001 -0.000012 -84.266264 -3.217624 0 0 0 0 0 0
$definebone "L ForeTwist1" "L ForeTwist" 1.217879 0.000001 -0.000001 -0.000012 -0.000001 -3.217625 0 0 0 0 0 0
$definebone "L ForeTwist2" "L ForeTwist1" 1.217879 -0.000004 0 -0.00001 -0.000004 -3.217627 0 0 0 0 0 0
$definebone "L ForeTwist3" "L ForeTwist2" 1.21788 -0.000003 0 -0.000005 -0.000004 -3.21763 0 0 0 0 0 0
$definebone "L ForeTwist4" "L ForeTwist3" 1.217879 -0.000002 0 -0.000005 -0.000006 -3.217632 0 0 0 0 0 0
$definebone "L ForeTwist5" "L ForeTwist4" 1.217879 -0.000002 0.000002 -0.000007 -0.000003 -3.217634 0 0 0 0 0 0
$definebone "L ForeTwist6" "L ForeTwist5" 1.217877 0.000001 -0.000002 -0.000003 -0.000008 -3.217637 0 0 0 0 0 0
$definebone "l_armtwist_4" "L ForeTwist6" -1.229097 -0.098787 -0.063422 -0.002696 3.063888 -8.541044 0 0 0 0 0 0
$definebone "l_armtwist_3" "L ForeTwist4" -0.687421 -0.200492 -0.062449 0.013519 3.063718 -9.440299 0 0 0 0 0 0
$definebone "l_armtwist_2" "L ForeTwist2" -0.386811 -0.315084 -0.060283 0.02967 3.063548 -10.339551 0 0 0 0 0 0
$definebone "l_armtwist_1" "L ForeTwist1" -1.473238 -0.438568 -0.05792 0.037803 3.063428 -11.238642 0 0 0 0 0 0
$definebone "l_upperarm" "L UpperArm" -2.01622 -0.514363 -1.382949 -6.256923 0.498013 0.219205 0 0 0 0 0 0


$include "c_arms_definebones.qci"

$sequence "idle" {
	"m9_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 15
}

$sequence "draw" {
	"m9_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 1 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire" {
	"m9_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 18
}

$sequence "shoot_empty" {
	"m9_anims/shoot_empty.smd"
	activity "ACT_VM_DRYFIRE" 1
	{ event 5004 0 "bf3.empty" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload" {
	"m9_anims/reload.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 12 "bf3_m9.clipout" }
	{ event 5004 49 "bf3_m9.clipin" }
	{ event 5004 59 "bf3_m9.slide" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "reload_full" {
	"m9_anims/reload_full.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 14 "bf3_m9.clipout" }
	{ event 5004 49 "bf3_m9.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire_empty" {
	"m9_anims/fire_empty.smd"
	activity "ACT_VM_DRYFIRE" 1
	{ event 5004 0 "bf3.empty" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 120
}

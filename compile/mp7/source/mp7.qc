// 

$modelname "weapons/c_mp7.mdl"

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
$bodygroup "blank"
{
	blank
}
$bodygroup "laser"
{
	blank
	studio "laser.smd"
}
$bodygroup "mp7"
{
	studio "mp7.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition 1.042 51.031 -13.86

$cdmaterials "models\bf3\weapons\smg\"
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
		"mp7"
		"muzzle"
		"suppressor"
		"laser"
	}
}

$attachment "1" "muzzle_flash" 0 0.08 -0.1 rotate -0 0 0
$attachment "2" "shell_ejection" 0 0 0 rotate 15 -50 0

$cbox 0 0 0 0 0 0

$bbox -8.595 -9.768 -12.275 19.381 8.26 0.588

$hboxset "default"

$definebone "Mp7_Body" "" 1.312189 1.72819 0.482725 0 0 -179.999964 0 0 0 0 0 0
$definebone "Mp7_Magazine" "" 1.312189 1.728192 0.482723 0 0 -179.999964 0 0 0 0 0 0
$definebone "Mp7_Trigger" "" 1.312189 1.728192 0.482723 0 0 -179.999964 0 0 0 0 0 0
$definebone "Mp7_BoltRelease" "" 1.312188 1.72819 0.482723 0 0 -179.999964 0 0 0 0 0 0
$definebone "Mp7_Foregrip" "" 1.312189 1.728189 0.482722 0 0 -179.999964 0 0 0 0 0 0
$definebone "shell_ejection" "" -2.743761 -10.212969 -3.251182 -22.071481 -150.113447 0 0 0 0 0 0 0
$definebone "muzzle_flash" "" -2.525776 -19.332973 -2.973041 0 -89.999982 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Clavicle" "" 1.510186 2.670961 -6.828427 0.004125 0 -0.039076 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_UpperArm" "anim_ValveBiped.Bip01_L_Clavicle" 5.853649 -0 0 -0.104221 -89.622805 -89.845224 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Forearm" "anim_ValveBiped.Bip01_L_UpperArm" 9.961163 0 0 0 -0.729261 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Hand" "anim_ValveBiped.Bip01_L_Forearm" 8.503069 0 0 -0.48266 0.986576 -89.951454 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger0" "anim_ValveBiped.Bip01_L_Hand" 0.756623 0.677738 -1.164276 26.757068 24.397465 99.663313 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger01" "anim_ValveBiped.Bip01_L_Finger0" 1.815093 -0.000001 -0.000002 0.000005 12.472147 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger02" "anim_ValveBiped.Bip01_L_Finger01" 1.031523 -0.000001 0.000001 0.000005 11.714242 -0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger1" "anim_ValveBiped.Bip01_L_Hand" 3.560264 0.118226 -1.221193 3.125714 5.505954 9.66929 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger11" "anim_ValveBiped.Bip01_L_Finger1" 1.161263 0.000001 0 -0.000001 19.24789 0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger12" "anim_ValveBiped.Bip01_L_Finger11" 0.705674 -0.000001 0 0.000001 24.755397 -0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger2" "anim_ValveBiped.Bip01_L_Hand" 3.535865 -0.001417 -0.449379 0.556915 9.319503 5.599804 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger21" "anim_ValveBiped.Bip01_L_Finger2" 1.25942 0 0 0 30.239928 -0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger22" "anim_ValveBiped.Bip01_L_Finger21" 0.945206 0.000002 -0 0 23.8833 -0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger3" "anim_ValveBiped.Bip01_L_Hand" 3.379947 -0.050748 0.292731 -3.079076 16.275383 -7.944232 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger31" "anim_ValveBiped.Bip01_L_Finger3" 1.267426 -0.000001 0 -0 30.133627 -0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger32" "anim_ValveBiped.Bip01_L_Finger31" 0.855791 -0.000002 -0.000001 -0 25.611956 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger4" "anim_ValveBiped.Bip01_L_Hand" 3.272117 0.110096 1.013747 -3.908089 22.484522 -10.975865 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger41" "anim_ValveBiped.Bip01_L_Finger4" 0.753935 -0.000001 0 -0.000001 21.277882 0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger42" "anim_ValveBiped.Bip01_L_Finger41" 0.703493 0.000002 0 -0.000003 17.192295 0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Clavicle" "" -1.505977 2.670953 -6.827188 -0.042972 -179.999677 -179.96095 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_UpperArm" "anim_ValveBiped.Bip01_R_Clavicle" 5.853648 0 0 0.103935 -89.622518 89.892325 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Forearm" "anim_ValveBiped.Bip01_R_UpperArm" 9.961164 0.000001 0 -0 -0.729261 -0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Hand" "anim_ValveBiped.Bip01_R_Forearm" 8.503071 0 0 0.48266 0.986576 89.951454 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger0" "anim_ValveBiped.Bip01_R_Hand" 0.756617 0.677738 1.164276 -26.757066 24.397465 -99.663313 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger01" "anim_ValveBiped.Bip01_R_Finger0" 1.815095 0.000002 -0.000001 -0.000003 12.472153 -0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger02" "anim_ValveBiped.Bip01_R_Finger01" 1.031525 -0.000002 -0.000001 -0.000007 11.71424 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger1" "anim_ValveBiped.Bip01_R_Hand" 3.560263 0.118225 1.221194 -3.125713 5.505954 -9.669291 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger11" "anim_ValveBiped.Bip01_R_Finger1" 1.161264 0.000001 -0.000001 -0.000001 19.247891 0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger12" "anim_ValveBiped.Bip01_R_Finger11" 0.705669 0 0 -0.000003 24.755394 0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger2" "anim_ValveBiped.Bip01_R_Hand" 3.53586 -0.001417 0.44938 -0.556915 9.319502 -5.599804 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger21" "anim_ValveBiped.Bip01_R_Finger2" 1.259424 0 -0 -0.000001 30.239921 0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger22" "anim_ValveBiped.Bip01_R_Finger21" 0.945208 0.000004 0 -0.000002 23.8833 0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger3" "anim_ValveBiped.Bip01_R_Hand" 3.379942 -0.050749 -0.29273 3.079074 16.275385 7.944232 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger31" "anim_ValveBiped.Bip01_R_Finger3" 1.267433 0 0.000001 0 30.13363 -0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger32" "anim_ValveBiped.Bip01_R_Finger31" 0.855784 0.000002 -0.000001 0.000001 25.611954 -0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger4" "anim_ValveBiped.Bip01_R_Hand" 3.272116 0.110096 -1.013746 3.908087 22.484525 10.975865 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger41" "anim_ValveBiped.Bip01_R_Finger4" 0.753936 0 -0 0.000001 21.277882 -0.000005 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger42" "anim_ValveBiped.Bip01_R_Finger41" 0.703496 0.000004 0 0.000003 17.192283 -0.000004 0 0 0 0 0 0

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -90.000153 -79.749996 -89.999924 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 0.422655 -0.727136 67.002932 90.343333 16.280984 -0.319014 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 0.880480 -65.310276 0.526738 -1.770057 -40.030492 93.342134 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" -8.884360 -56.490138 8.047335 1.137712 -40.049592 89.552845 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" -18.006931 -15.627589 -47.382807 -88.148366 -43.853833 -91.463521 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.088498 -48.720051 16.359026 -0.797611 -5.806733 82.271929 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" -11.592828 -45.526350 16.540106 -2.096092 -5.474663 82.952964 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" -21.218227 -40.877358 16.655260 -3.904893 -4.374199 92.078032 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" -19.586681 -23.643009 -41.103978 -44.858107 -83.070868 -119.280138 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" -27.537640 -15.619087 -39.397108 71.860529 -73.308400 103.890388 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" -32.128742 -2.046821 -38.343779 79.541183 -59.672450 70.840228 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" -23.452180 -18.986594 -42.780477 -55.056445 -81.904918 -129.203280 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" -31.137739 -4.042702 -41.078035 70.806651 -74.839011 73.881921 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" -30.769254 9.535294 -39.910939 78.809445 -62.795498 41.485652 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" -28.562227 -5.450169 -44.698840 -95.829169 -83.579391 -109.411732 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" -28.665431 10.149744 -43.169405 94.777892 -82.163065 29.928314 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" -22.070404 21.925989 -41.984254 91.211238 -57.501023 8.028223 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" -30.920001 0.066761 -44.441947 -89.846201 -85.119010 -139.453210 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" -29.595964 11.519557 -43.134142 89.962304 -69.686868 19.457506 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" -25.287681 19.970743 -42.450138 89.976784 -55.689568 2.249044 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 0.481883 -0.727104 -67.001333 -94.458518 -16.327851 -0.318738 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 0.880457 -65.304254 -0.530885 1.770361 40.030702 93.342207 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" -8.884470 -56.484150 -8.051506 -1.137431 40.049819 89.552904 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" -18.006912 -15.631841 47.376847 88.620996 43.854015 -91.463634 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.084280 -48.714925 -16.362057 1.170976 5.809084 82.255034 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" -11.595352 -45.520624 -16.543207 2.451157 5.396438 82.839021 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" -21.217227 -40.871861 -16.656722 4.208461 4.175185 91.955648 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" -19.587396 -23.646158 41.097434 45.268167 83.070706 -119.279572 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" -27.539357 -15.621821 39.390563 -71.476889 73.308692 103.891217 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" -32.131447 -2.048590 38.337233 -79.169527 59.672613 70.840396 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" -23.452903 -18.990160 42.774152 55.450381 81.904757 -129.202702 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" -31.140161 -4.045414 41.071712 -70.439572 74.839142 73.881731 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" -30.772575 9.533788 39.904618 -78.450799 62.795634 41.485611 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" -28.563071 -5.455016 44.693452 96.064545 83.559818 -109.407034 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" -28.668991 10.145627 43.164067 -94.995745 82.178861 29.483277 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" -22.075624 21.922522 41.978874 -91.264496 57.521099 7.754058 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" -30.921192 0.061774 44.436756 90.104581 85.086741 -139.395842 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" -29.599542 11.514994 43.129014 -90.025844 69.721899 19.197843 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" -25.292824 19.966279 42.444848 -90.015905 55.726202 2.016656 0 0 0 0 0 0
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
	"mp7_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "reload" {
	"mp7_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 10 "bf3_mp7.clipout" }
	{ event 5004 49 "bf3_mp7.clipin" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "reload_empty" {
	"mp7_anims/reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 10 "bf3_mp7.clipout" }
	{ event 5004 49 "bf3_mp7.clipin" }
	{ event 5004 68 "bf3_mp7.boltcatch" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "draw" {
	"mp7_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	{ event 5004 14 "bf3_mp7.grip" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire" {
	"mp7_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

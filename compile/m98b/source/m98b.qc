// 

$modelname "weapons/c_m98b.mdl"

$bodygroup "sight"
{
	studio "sight.smd"
	studio "reflex.smd"
	studio "kobra.smd"
	studio "acog.smd"
	studio "eotech.smd"
	studio "scope.smd"
}
$bodygroup "barrel"
{
	studio "default.smd"
	blank
	studio "suppressor.smd"
}
$bodygroup "m98b"
{
	studio "m98b.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition -0.836 -14.927 -5.726

$cdmaterials "models\bf3\weapons\sniper\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"m98b_sight"
		"reticle"
		"reflex"
		"lens"
		"kobra"
		"acog"
		"reticle_acog"
		"eotech"
		"reticle_eotech"
		"lens_eotech"
		"scope_ballistic"
		"m98b"
		"suppressor"
	}
}

$attachment "1" "Muzzle_Flash_1" 0 0 0 rotate -0 0 0
$attachment "2" "Shell_Ejection" 0 0 0 rotate 0 180 -180

$cbox 0 0 0 0 0 0

$bbox -9.198 -9.953 -12.186 39.052 8.282 0.733

$hboxset "default"

$definebone "M98_Body" "" -2.190128 -20.547756 -2.763069 0 0 0 0 0 0 0 0 0
$definebone "M98_Magazine" "" -2.195648 -11.891459 -4.929236 0 0 0 0 0 0 0 0 0
$definebone "M98_Trigger" "" -2.190128 -20.547756 -2.763069 0 0 0 0 0 0 0 0 0
$definebone "M98_BoltHandle" "" -2.190128 -20.547756 -2.763069 0 0 0 0 0 0 0 0 0
$definebone "Muzzle_Flash_1" "" -2.18981 -37.075294 -2.70611 0 -90.000037 89.999982 0 0 0 0 0 0
$definebone "Shell_Ejection" "" -2.625289 -11.769227 -2.538591 18.826194 5.713078 -89.999982 0 0 0 0 0 0
$definebone "Bip01 L Arm" "" 1.510186 2.670961 -6.828427 0.004125 0 -0.039076 0 0 0 0 0 0
$definebone "Bip01 L Arm1" "Bip01 L Arm" 5.853648 -0 0 -0.104221 -89.622805 -89.845224 0 0 0 0 0 0
$definebone "Bip01 L Arm2" "Bip01 L Arm1" 9.961161 0 0 0 -0.729261 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Hand" "Bip01 L Arm2" 8.503063 0 0 -0.48266 0.986576 -89.951454 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger0" "anim_ValveBiped.Bip01_L_Hand" 0.756618 0.677738 -1.164276 26.757066 24.397465 99.663313 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger01" "anim_ValveBiped.Bip01_L_Finger0" 1.815093 0.000002 -0.000002 0.000003 12.472152 -0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger02" "anim_ValveBiped.Bip01_L_Finger01" 1.031524 -0.000002 0.000001 0.000002 11.714245 -0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger1" "anim_ValveBiped.Bip01_L_Hand" 3.560264 0.118227 -1.221193 3.125714 5.505955 9.669288 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger11" "anim_ValveBiped.Bip01_L_Finger1" 1.161263 0.000001 0 0.000002 19.247897 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger12" "anim_ValveBiped.Bip01_L_Finger11" 0.705672 -0.000002 -0 0.000001 24.755396 -0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger2" "anim_ValveBiped.Bip01_L_Hand" 3.535871 -0.001417 -0.449377 0.556915 9.319502 5.599804 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger21" "anim_ValveBiped.Bip01_L_Finger2" 1.259424 -0.000001 0 0.000001 30.239935 -0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger22" "anim_ValveBiped.Bip01_L_Finger21" 0.94521 0.000002 -0.000002 0 23.883307 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger3" "anim_ValveBiped.Bip01_L_Hand" 3.379947 -0.050748 0.292731 -3.079076 16.275393 -7.944231 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger31" "anim_ValveBiped.Bip01_L_Finger3" 1.267426 -0.000002 0 0 30.133616 -0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger32" "anim_ValveBiped.Bip01_L_Finger31" 0.85579 0.000002 -0.000001 0.000001 25.611948 -0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger4" "anim_ValveBiped.Bip01_L_Hand" 3.272117 0.110096 1.013747 -3.908087 22.484522 -10.975865 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger41" "anim_ValveBiped.Bip01_L_Finger4" 0.75393 -0.000001 0 -0.000001 21.27788 0.000004 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger42" "anim_ValveBiped.Bip01_L_Finger41" 0.703496 0.000004 0 -0.000003 17.19229 0.000005 0 0 0 0 0 0
$definebone "Bip01 R Arm" "" -1.505977 2.670953 -6.827188 -0.042972 -179.999677 -179.96095 0 0 0 0 0 0
$definebone "Bip01 R Arm1" "Bip01 R Arm" 5.853648 0 0 0.103935 -89.622518 89.892325 0 0 0 0 0 0
$definebone "Bip01 R Arm2" "Bip01 R Arm1" 9.961164 0.000001 0 -0 -0.729261 -0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Hand" "Bip01 R Arm2" 8.503071 0 0 0.48266 0.986576 89.951454 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger0" "anim_ValveBiped.Bip01_R_Hand" 0.756617 0.677738 1.164276 -26.757065 24.39747 -99.663313 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger01" "anim_ValveBiped.Bip01_R_Finger0" 1.815092 0.000006 -0.000002 -0.000005 12.472157 -0.000007 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger02" "anim_ValveBiped.Bip01_R_Finger01" 1.031527 -0.000003 0.000001 -0 11.714246 -0.000006 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger1" "anim_ValveBiped.Bip01_R_Hand" 3.560261 0.118225 1.221194 -3.125713 5.505956 -9.66929 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger11" "anim_ValveBiped.Bip01_R_Finger1" 1.161264 -0 -0 -0.000002 19.247902 0.000005 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger12" "anim_ValveBiped.Bip01_R_Finger11" 0.705667 -0.000001 0 -0.000005 24.755394 0.000005 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger2" "anim_ValveBiped.Bip01_R_Hand" 3.535858 -0.001417 0.44938 -0.556915 9.319503 -5.599804 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger21" "anim_ValveBiped.Bip01_R_Finger2" 1.259422 0 0 -0.000003 30.239932 0.000004 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger22" "anim_ValveBiped.Bip01_R_Finger21" 0.945206 0.000002 0 -0.000005 23.883314 0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger3" "anim_ValveBiped.Bip01_R_Hand" 3.379936 -0.050749 -0.29273 3.079072 16.275386 7.944232 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger31" "anim_ValveBiped.Bip01_R_Finger3" 1.267433 0 -0 0 30.13364 -0.000004 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger32" "anim_ValveBiped.Bip01_R_Finger31" 0.855783 0.000008 -0.000001 0.000002 25.611965 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger4" "anim_ValveBiped.Bip01_R_Hand" 3.27212 0.110096 -1.013746 3.908085 22.484529 10.975865 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger41" "anim_ValveBiped.Bip01_R_Finger4" 0.753935 0 -0 0.000003 21.277885 -0.000011 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger42" "anim_ValveBiped.Bip01_R_Finger41" 0.703493 0.000002 0 0.000008 17.192293 -0.000011 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Clavicle" "" 1.510186 2.670961 -6.828427 0.004125 0 -0.039076 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_UpperArm" "anim_ValveBiped.Bip01_L_Clavicle" 5.853648 -0 0 -0.104221 -89.622805 -89.845224 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Forearm" "anim_ValveBiped.Bip01_L_UpperArm" 9.961161 0 0 0 -0.729261 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Clavicle" "" -1.505977 2.670953 -6.827188 -0.042972 -179.999677 -179.96095 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_UpperArm" "anim_ValveBiped.Bip01_R_Clavicle" 5.853648 0 0 0.103935 -89.622518 89.892325 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Forearm" "anim_ValveBiped.Bip01_R_UpperArm" 9.961164 0.000001 0 -0 -0.729261 -0 0 0 0 0 0 0

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -90.000153 -79.749996 -89.999924 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 0.422655 -0.727136 67.002932 90.343333 16.280984 -0.319014 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 0.880480 -65.310276 0.526739 -1.770057 -40.030492 93.342134 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" -8.884358 -56.490138 8.047336 1.137712 -40.049592 89.552845 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" -18.006923 -15.627590 -47.382807 -88.148366 -43.853833 -91.463521 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.088508 -48.720045 16.359032 -0.797611 -5.806733 82.271929 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" -11.592818 -45.526349 16.540112 -2.096092 -5.474663 82.952964 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" -21.218218 -40.877358 16.655265 -3.904893 -4.374199 92.078032 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" -19.586673 -23.643012 -41.103977 -44.858107 -83.070868 -119.280138 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" -27.537633 -15.619092 -39.397107 71.860529 -73.308400 103.890388 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" -32.128736 -2.046828 -38.343778 79.541183 -59.672450 70.840228 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" -23.452178 -18.986596 -42.780479 -55.056445 -81.904918 -129.203280 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" -31.137741 -4.042701 -41.078037 70.806651 -74.839011 73.881921 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" -30.769260 9.535297 -39.910939 78.809445 -62.795498 41.485652 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" -28.562220 -5.450173 -44.698841 -95.829169 -83.579391 -109.411732 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" -28.665426 10.149739 -43.169406 94.777892 -82.163065 29.928314 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" -22.070402 21.925978 -41.984255 91.211238 -57.501023 8.028223 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" -30.919994 0.066757 -44.441949 -89.846201 -85.119010 -139.453210 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" -29.595955 11.519549 -43.134143 89.962304 -69.686868 19.457506 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" -25.287677 19.970732 -42.450140 89.976784 -55.689568 2.249044 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 0.481883 -0.727104 -67.001333 -94.458518 -16.327851 -0.318738 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 0.880457 -65.304254 -0.530885 1.770361 40.030702 93.342207 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" -8.884470 -56.484150 -8.051506 -1.137431 40.049819 89.552904 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" -18.006912 -15.631841 47.376847 88.620996 43.854015 -91.463634 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.084280 -48.714925 -16.362057 1.170976 5.809084 82.255034 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" -11.595350 -45.520629 -16.543206 2.451157 5.396438 82.839021 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" -21.217228 -40.871864 -16.656723 4.208461 4.175185 91.955648 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" -19.587394 -23.646158 41.097434 45.268167 83.070706 -119.279572 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" -27.539355 -15.621821 39.390562 -71.476889 73.308692 103.891217 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" -32.131443 -2.048591 38.337232 -79.169527 59.672613 70.840396 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" -23.452901 -18.990161 42.774152 55.450381 81.904757 -129.202702 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" -31.140158 -4.045417 41.071712 -70.439572 74.839142 73.881731 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" -30.772570 9.533786 39.904618 -78.450799 62.795634 41.485611 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" -28.563065 -5.455018 44.693453 96.064545 83.559818 -109.407034 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" -28.668987 10.145623 43.164069 -94.995745 82.178861 29.483277 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" -22.075624 21.922511 41.978875 -91.264496 57.521099 7.754058 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" -30.921195 0.061776 44.436755 90.104581 85.086741 -139.395842 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" -29.599544 11.514996 43.129013 -90.025844 69.721899 19.197843 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" -25.292821 19.966283 42.444847 -90.015905 55.726202 2.016656 0 0 0 0 0 0
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
	"m98b_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "draw" {
	"m98b_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "fire" {
	"m98b_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event 5004 30 "bf3_m98b.boltback" }
	{ event 5004 42 "bf3_m98b.boltforward" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload" {
	"m98b_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 40 "bf3_m98b.clipout" }
	{ event 5004 78 "bf3_m98b.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload_empty" {
	"m98b_anims/reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 40 "bf3_m98b.clipout" }
	{ event 5004 78 "bf3_m98b.clipin" }
	{ event 5004 129 "bf3_m98b.boltback" }
	{ event 5004 150 "bf3_m98b.boltforward" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

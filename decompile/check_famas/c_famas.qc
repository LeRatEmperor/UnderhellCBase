// 

$modelname "weapons/c_famas.mdl"

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
$bodygroup "famas"
{
	studio "famas.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 1.76 -3.647 -7.303

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
		"famas"
		"muzzle"
		"suppressor"
		"grip"
		"laser"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 -0 0
$attachment "muzzle_supp" "A_Muzzle_Supp" 0 0 0 rotate -0 0 0
$attachment "2" "A_Eject" 0 0 0 rotate -0 0 -0
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 0 0 0 rotate -0 0 0
$attachment "camera" "camera" 0 0 0 rotate -0 0 0
$attachment "Suppressor" "A_Suppressor" 0 0 0 rotate -0 0 0
$attachment "Laser" "A_Underbarrel" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 -0
$attachment "Foregrip" "A_Foregrip" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -14.91 -5.528 -18.317 22.204 9.047 3.712

$definebone "ValveBiped.Bip01_L_Clavicle" "" 3.491543 8.830969 -9.976974 -0 0.000057 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853647 -0.000001 0 2.606728 -90.521187 -90.385915 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390537 -0.000002 0.000003 0 -6.123426 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525429 -0.000002 -0.000002 2.75306 3.862882 -91.214697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555143 0.315173 -0.822493 36.110694 33.914147 115.151539 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556972 0.000005 -0.000001 -0.00002 9.529354 0.000014 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.221089 -0.000002 0.000003 -0.000031 13.764658 0.000007 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828095 -0.20948 -1.286462 1.166311 -3.007111 7.05947 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.38252 0.000001 0.000005 -0.000002 5.705103 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865905 -0.000001 -0.000003 -0.000002 1.676688 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813036 -0.266272 -0.544265 -0.523168 -4.898958 4.980263 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445752 0.000002 0.000003 -0.000001 8.189848 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053756 -0.000002 0.000003 -0.000001 -1.493994 0.000007 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.689442 -0.342859 0.236191 -0.363542 -3.72474 7.466499 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439797 -0.000003 0 0 3.307798 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.98299 0 -0.000001 0 -5.220037 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426954 -0.353601 1.013784 -0.774237 -8.67841 5.197185 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104664 0.000001 0.000001 0.000001 4.531697 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908442 0.000002 -0.000003 0.000002 -3.232676 0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_UpperArm" 10.390536 -0.000002 0.000002 -0 -6.123425 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217918 -0.000003 0 -0 0.000004 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217918 -0.000001 -0.000003 0 0.000004 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.217917 -0.000002 -0.000005 -0 0.000004 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217916 0.000003 -0.000001 -0 0.000004 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.217918 -0.000001 -0.000004 -0 0.000004 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217916 -0.000001 0.000002 -0 0.000004 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" 0.47538 8.830965 -9.976974 -0 -179.999909 -179.999937 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000003 0 -2.606728 -90.521187 90.385915 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.39054 -0.000002 0 -0 -6.123427 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525432 0 0 -2.75306 3.862882 91.214697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.555141 0.31517 0.822497 -36.110718 33.914157 -115.151539 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556973 -0.000001 -0.000001 0.000019 9.529332 -0.000006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221089 -0.000003 -0.000001 0.000022 13.764633 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828094 -0.209482 1.286462 -1.166311 -3.00711 -7.05947 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382519 0 -0.000003 0.000002 5.705106 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.865911 -0 0.000003 0.000002 1.676693 -0.000004 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813035 -0.266277 0.544266 0.523168 -4.898957 -4.980263 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445758 0 0.000001 0.000001 8.189853 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053752 0 -0.000003 0.000002 -1.493993 -0.000006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.689445 -0.342861 -0.236184 0.363542 -3.724739 -7.466499 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439795 0.000001 0.000001 0.000001 3.3078 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.98299 -0 0 0 -5.220037 -0.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426956 -0.353605 -1.013782 0.774238 -8.678414 -5.197187 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104669 -0 0.000001 -0 4.531693 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908442 -0.000001 0.000001 -0.000001 -3.232681 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_UpperArm" 10.390538 -0.000002 0 -0 -6.123425 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217917 0.000003 0 -0 0.000005 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.217918 -0.000002 0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217918 0.000001 -0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.217916 0.000001 0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.217919 0.000001 0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.217916 0.000001 0 -0 0.000004 0.152006 0 0 0 0 0 0
$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999914 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "(null)" 0 0 0 -89.999975 -89.999914 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 3.24214 -0.005069 0.000005 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 6.363438 -0.005069 0 -0 -0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 6.363435 -0.002059 0 -0 -0 0 0 0 0 0 0 0
$definebone "FAM_MAIN" "" -2.599743 -11.95453 -3.800601 -0 0 0 0 0 0 0 0 0
$definebone "FAM_MAG_RELEASE" "FAM_MAIN" 0.007674 4.962811 -0.934264 -0 0 0 0 0 0 0 0 0
$definebone "FAM_MAGAZINE" "FAM_MAIN" -0.000003 6.395597 -1.654393 -0 0 0 0 0 0 0 0 0
$definebone "FAM_BULLET_MAIN" "FAM_MAGAZINE" -0.11881 -0.065419 2.054317 -0 0 0 0 0 0 0 0 0
$definebone "FAM_BULLETS" "FAM_MAGAZINE" -0.118478 -0.065419 1.737719 -0 0 0 0 0 0 0 0 0
$definebone "FAM_TRIGGER" "FAM_MAIN" -0.043907 -0.441948 -0.673573 -0 0 0 0 0 0 0 0 0
$definebone "FAM_BOLT" "FAM_MAIN" 0.016472 -1.774496 1.703275 -0 0 0 0 0 0 0 0 0
$definebone "FAM_BOLT_HANDLE" "FAM_BOLT" 0.00046 -0.120476 -0.363187 -0 0 0 0 0 0 0 0 0
$definebone "FAMAS_SIGHT" "FAM_MAIN" 0.014103 -7.235753 2.358691 -0 0 0 0 0 0 0 0 0
$definebone "A_Optic" "FAM_MAIN" -0.00114 -1.080784 3.777362 -0 179.999964 -90.000023 0 0 0 0 0 0
$definebone "A_Muzzle_Ironsight" "FAM_MAIN" 2.599741 -10.852775 3.711483 -0 -90.000084 0 0 0 0 0 0 0
$definebone "A_Foregrip" "FAM_MAIN" 0.029664 -4.359653 -0.897634 -0 179.999896 0 0 0 0 0 0 0
$definebone "A_Underbarrel" "FAM_MAIN" 0.002434 -7.569705 0.687202 -0 -89.999968 -89.999968 0 0 0 0 0 0
$definebone "A_Suppressor" "FAM_MAIN" -0.00788 -11.116035 0.676175 -0 179.999937 0 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "FAM_MAIN" -0.00788 -19.032196 0.684833 -0 -89.999968 89.999968 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "FAM_MAIN" 0.010177 -8.554111 0.683143 0.000036 -90.000009 179.999978 0 0 0 0 0 0
$definebone "A_Muzzle" "FAM_MAIN" -0.008317 -12.853469 0.672902 0.000057 -89.999968 89.999968 0 0 0 0 0 0
$definebone "A_Eject" "FAM_MAIN" -0.730943 8.039146 0.993207 -7.29295 -162.546782 -2.991126 0 0 0 0 0 0
$definebone "SLING_BONE_01" "FAM_MAIN" 0.012741 -7.969989 0.684858 88.162736 89.999811 -90.002161 0 0 0 0 0 0
$definebone "SLING_BONE_02" "SLING_BONE_01" 1.046484 0 0 0.000172 -5.847435 0.001948 0 0 0 0 0 0
$definebone "SLING_BONE_03" "SLING_BONE_02" 1.420767 0.000057 0 0 -13.652209 0 0 0 0 0 0 0
$definebone "SLING_BONE_04" "SLING_BONE_03" 1.408961 -0.000004 0 0 -14.272725 0 0 0 0 0 0 0
$definebone "SLING_BONE_05" "SLING_BONE_04" 1.214038 0 -0 -0.000057 -13.315423 0 0 0 0 0 0 0
$definebone "SLING_BONE_06" "SLING_BONE_05" 1.019245 -0.00001 0 0.000057 -14.970123 0 0 0 0 0 0 0
$definebone "SLING_BONE_07" "SLING_BONE_06" 1.049126 0.000001 0 0.010256 -10.404223 0.000057 0 0 0 0 0 0
$definebone "SLING_BONE_08" "SLING_BONE_07" 1.505384 0.000008 0 0.515605 -2.798037 0.001833 0 0 0 0 0 0
$definebone "SLING_BONE_09" "SLING_BONE_08" 1.943114 0.000003 0 -0.080443 -3.895481 0.020455 0 0 0 0 0 0
$definebone "SLING_BONE_10" "SLING_BONE_09" 1.999506 -0.000015 0 -0.155443 -7.043254 0.01547 0 0 0 0 0 0
$definebone "SLING_BONE_11" "SLING_BONE_10" 2.023268 0.000065 0 0.28963 -6.450189 0.000458 0 0 0 0 0 0
$definebone "SLING_BONE_12" "SLING_BONE_11" 1.602902 -0.000002 0 1.923533 -7.844309 -2.841928 0 0 0 0 0 0
$definebone "SLING_BONE_13" "SLING_BONE_12" 2.383555 -0.00004 0 1.459838 -18.659855 -25.011212 0 0 0 0 0 0
$definebone "SLING_BONE_14" "SLING_BONE_13" 1.883695 0 0 7.605835 -10.426283 -18.952976 0 0 0 0 0 0
$definebone "SLING_BONE_15" "SLING_BONE_14" 1.848094 -0.000005 0 14.087543 -5.611957 -29.479185 0 0 0 0 0 0
$definebone "SLING_BONE_16" "SLING_BONE_15" 1.96004 -0.000001 0 -2.464067 -1.7481 -1.493817 0 0 0 0 0 0
$definebone "SLING_BONE_17" "SLING_BONE_16" 1.396478 0 -0 -26.056171 2.605633 -14.417165 0 0 0 0 0 0
$definebone "SLING_BONE_18" "SLING_BONE_17" 1.036103 0.000004 -0 -10.998111 -1.089657 0.573362 0 0 0 0 0 0
$definebone "camera" "" 0 0 0 -0 -90.000009 0 0 0 0 0 0 0
$definebone "CAM_Movement" "" 0 0 0 -5.368384 -175.715373 89.546997 0 0 0 0 0 0

$bonemerge "ValveBiped.Bip01_L_Clavicle"
$bonemerge "ValveBiped.Bip01_L_UpperArm"
$bonemerge "ValveBiped.Bip01_L_Forearm"
$bonemerge "ValveBiped.Bip01_L_Hand"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger02"
$bonemerge "ValveBiped.Bip01_L_Finger1"
$bonemerge "ValveBiped.Bip01_L_Finger11"
$bonemerge "ValveBiped.Bip01_L_Finger12"
$bonemerge "ValveBiped.Bip01_L_Finger2"
$bonemerge "ValveBiped.Bip01_L_Finger21"
$bonemerge "ValveBiped.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger3"
$bonemerge "ValveBiped.Bip01_L_Finger31"
$bonemerge "ValveBiped.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger4"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "ValveBiped.Bip01_L_Finger42"
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
	"c_famas_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "base_draw" {
	"c_famas_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "base_fire" {
	"c_famas_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "base_reload" {
	"c_famas_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 28 "bf3_famas.clipout" }
	{ event 5004 66 "bf3_famas.clipin" }
	fadein 0.3
	fadeout 0.6
	fps 35.1
}

$sequence "base_reload_empty" {
	"c_famas_anims/base_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 28 "bf3_famas.clipout" }
	{ event 5004 85 "bf3_famas.clipin" }
	{ event 5004 122 "bf3_famas.boltpull" }
	fadein 0.3
	fadeout 0.6
	fps 35.86
}

$sequence "foregrip_idle" {
	"c_famas_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.4
	fadeout 0.2
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"c_famas_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "foregrip_fire" {
	"c_famas_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_reload" {
	"c_famas_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 28 "bf3_famas.clipout" }
	{ event 5004 66 "bf3_famas.clipin" }
	fadein 0.3
	fadeout 0.6
	fps 35.1
}

$sequence "foregrip_reload_empty" {
	"c_famas_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 28 "bf3_famas.clipout" }
	{ event 5004 85 "bf3_famas.clipin" }
	{ event 5004 122 "bf3_famas.boltpull" }
	fadein 0.3
	fadeout 0.6
	fps 35.86
}

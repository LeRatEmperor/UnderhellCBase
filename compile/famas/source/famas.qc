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
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"


$contents "solid"

$illumposition 1.76 -3.647 -7.303

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
		"famas"
		"muzzle"
		"suppressor"
		"grip"
		"laser"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 -0 0
$attachment "muzzle_supp" "A_Muzzle_Supp" 0 0 0 rotate -0 0 0
$attachment "2" "A_Eject" -0 0 0 rotate -0 0 0
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 0 0 0 rotate -0 0 0
$attachment "camera" "camera" 0 0 0 rotate -0 0 0
$attachment "Suppressor" "A_Suppressor" 0 0 0 rotate -0 0 0
$attachment "Laser" "A_Underbarrel" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 0
$attachment "Foregrip" "A_Foregrip" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -14.91 -5.528 -18.317 22.204 9.047 3.712

$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "(null)" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 3.24214 -0.005069 0.000005 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 6.363438 -0.005069 0 -0 -0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 6.363436 -0.002058 0 -0 -0 0 0 0 0 0 0 0
$definebone "FAM_MAIN" "" -2.599743 -11.95453 -3.800601 0 0 0 0 0 0 0 0 0
$definebone "FAM_MAG_RELEASE" "FAM_MAIN" 0.007674 4.962811 -0.934264 -0 0 0 0 0 0 0 0 0
$definebone "FAM_MAGAZINE" "FAM_MAIN" -0.000003 6.395597 -1.654393 -0 0 0 0 0 0 0 0 0
$definebone "FAM_BULLET_MAIN" "FAM_MAGAZINE" -0.11881 -0.065419 2.054317 -0 0 0 0 0 0 0 0 0
$definebone "FAM_BULLETS" "FAM_MAGAZINE" -0.118478 -0.065419 1.737719 -0 0 0 0 0 0 0 0 0
$definebone "FAM_TRIGGER" "FAM_MAIN" -0.043907 -0.441948 -0.673573 -0 0 0 0 0 0 0 0 0
$definebone "FAM_BOLT" "FAM_MAIN" 0.016472 -1.774496 1.703275 -0 0 0 0 0 0 0 0 0
$definebone "FAM_BOLT_HANDLE" "FAM_BOLT" 0.00046 -0.120476 -0.363187 -0 0 0 0 0 0 0 0 0
$definebone "FAMAS_SIGHT" "FAM_MAIN" 0.014103 -7.235753 2.358691 -0 0 0 0 0 0 0 0 0
$definebone "A_Optic" "FAM_MAIN" -0.00114 -1.080784 3.777362 -0.000019 -180.000005 -90.000016 0 0 0 0 0 0
$definebone "A_Muzzle_Ironsight" "FAM_MAIN" 2.599741 -10.852775 3.711483 -0 -90.000098 0 0 0 0 0 0 0
$definebone "A_Foregrip" "FAM_MAIN" 0.029664 -4.359653 -0.897634 -0 179.999909 0 0 0 0 0 0 0
$definebone "A_Underbarrel" "FAM_MAIN" 0.002434 -7.569705 0.687202 -0 -89.999982 -89.999982 0 0 0 0 0 0
$definebone "A_Suppressor" "FAM_MAIN" -0.00788 -11.116035 0.676175 -0 179.999964 0 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "FAM_MAIN" -0.00788 -19.032196 0.684833 -0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "FAM_MAIN" 0.010177 -8.554111 0.683143 0.000036 -90.000016 -180.000005 0 0 0 0 0 0
$definebone "A_Muzzle" "FAM_MAIN" -0.008317 -12.853469 0.672902 0.000057 -89.999982 89.999982 0 0 0 0 0 0
$definebone "A_Eject" "FAM_MAIN" -0.730943 8.039146 0.993207 -7.292951 -162.546809 -2.991126 0 0 0 0 0 0
$definebone "SLING_BONE_01" "FAM_MAIN" 0.012741 -7.969989 0.684858 88.162736 89.999811 -90.002161 0 0 0 0 0 0
$definebone "SLING_BONE_02" "SLING_BONE_01" 1.046484 0 0 0.000172 -5.847435 0.001948 0 0 0 0 0 0
$definebone "SLING_BONE_03" "SLING_BONE_02" 1.420767 0.000055 0 0 -13.652209 0 0 0 0 0 0 0
$definebone "SLING_BONE_04" "SLING_BONE_03" 1.408961 -0.000002 0 0 -14.272726 0 0 0 0 0 0 0
$definebone "SLING_BONE_05" "SLING_BONE_04" 1.214037 0 -0 -0.000057 -13.315424 0 0 0 0 0 0 0
$definebone "SLING_BONE_06" "SLING_BONE_05" 1.019244 -0.00001 0 0.000057 -14.970125 0 0 0 0 0 0 0
$definebone "SLING_BONE_07" "SLING_BONE_06" 1.049126 0.000001 0 0.010256 -10.404224 0.000057 0 0 0 0 0 0
$definebone "SLING_BONE_08" "SLING_BONE_07" 1.505385 0.000007 0 0.515605 -2.798037 0.001833 0 0 0 0 0 0
$definebone "SLING_BONE_09" "SLING_BONE_08" 1.943114 0.000003 0 -0.080443 -3.895481 0.020455 0 0 0 0 0 0
$definebone "SLING_BONE_10" "SLING_BONE_09" 1.999505 -0.000016 0 -0.155443 -7.043254 0.01547 0 0 0 0 0 0
$definebone "SLING_BONE_11" "SLING_BONE_10" 2.023267 0.000066 0 0.28963 -6.450187 0.000458 0 0 0 0 0 0
$definebone "SLING_BONE_12" "SLING_BONE_11" 1.602904 -0.000002 0 1.923533 -7.844307 -2.841928 0 0 0 0 0 0
$definebone "SLING_BONE_13" "SLING_BONE_12" 2.383555 -0.000039 0 1.459838 -18.659855 -25.011212 0 0 0 0 0 0
$definebone "SLING_BONE_14" "SLING_BONE_13" 1.883695 0 0 7.605837 -10.426283 -18.952976 0 0 0 0 0 0
$definebone "SLING_BONE_15" "SLING_BONE_14" 1.848095 -0.000005 0 14.087542 -5.611957 -29.479182 0 0 0 0 0 0
$definebone "SLING_BONE_16" "SLING_BONE_15" 1.96004 -0.000001 0 -2.464067 -1.748099 -1.49381 0 0 0 0 0 0
$definebone "SLING_BONE_17" "SLING_BONE_16" 1.396478 -0 0 -26.056176 2.605636 -14.41716 0 0 0 0 0 0
$definebone "SLING_BONE_18" "SLING_BONE_17" 1.036103 0.000004 0 -10.99811 -1.089656 0.57336 0 0 0 0 0 0
$definebone "camera" "" 0 0 0 0 -90.000037 0 0 0 0 0 0 0
$definebone "CAM_Movement" "" 0 0 0 -5.368384 -175.715386 89.547004 0 0 0 0 0 0


$definebone "ValveBiped.Bip01_Spine4" "" 0.000006 0.000000 0.000000 -79.749939 -89.999874 -90.000099 0.000000 0.000000 0.000000 -0.000000 0.000000 -0.000000
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 2.033349 1.000767 1.937660 -73.711860 168.619273 91.480543 0.000000 0.000000 0.000000 -0.000000 0.000002 0.000001
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 6.028141 0.000000 0.000000 2.738853 -33.527944 -90.505158 0.000000 0.000000 0.000000 -0.000000 0.000000 -0.000001
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.692556 0.000001 0.000003 -0.000003 -3.459061 -0.000001 0.000000 0.000000 0.000000 -0.000003 -0.000000 -0.000001
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 11.481674 0.000001 -0.000032 -6.108477 2.532073 90.136744 0.000000 0.000000 0.000000 0.000000 0.000002 0.000001
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.859707 -0.142403 -1.191975 8.682203 -50.431563 -26.822042 0.000002 0.000000 0.000000 -0.000001 0.000007 0.000003
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.312557 0.000000 0.000002 -0.000001 -25.194099 0.000003 0.000001 0.000000 0.000000 -0.000001 0.000000 0.000003
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.729364 -0.000002 -0.000001 -0.000002 -13.997301 0.000005 -0.000001 0.000000 0.000000 -0.000002 -0.000002 0.000005
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.942333 0.046767 -0.431443 4.194397 -46.466010 -8.696352 0.000000 0.000000 0.000000 0.000001 0.000007 -0.000001
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.539097 0.000000 0.000000 0.000000 -14.197715 -0.000001 0.000000 0.000000 0.000000 0.000000 0.000007 -0.000001
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 1.196325 -0.000002 -0.000001 0.000000 -24.683134 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.883694 -0.046766 0.431443 1.250768 -33.682286 4.921822 0.000000 -0.000002 0.000000 0.000002 0.000013 0.000002
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.719572 -0.000004 -0.000001 0.316047 -20.997629 0.000001 0.000000 0.000000 0.000000 0.000004 0.000013 0.000001
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.209173 -0.000002 -0.000000 0.176703 -12.398796 0.000000 0.000000 0.000004 0.000000 0.000003 0.000010 0.000000
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.859863 -0.137946 1.332466 -2.449394 -30.465192 20.308434 0.000000 0.000000 0.000000 0.000004 0.000011 0.000002
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.719429 0.000002 -0.000002 0.233428 -20.798876 0.000000 -0.000002 0.000002 0.000000 0.000005 0.000009 0.000000
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 1.099663 0.000000 0.000000 0.148745 -13.999132 -0.000002 0.000000 -0.000002 0.000000 0.000004 0.000005 -0.000002
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.806053 -0.348924 1.321258 -38.916041 -45.195987 -70.054232 0.000000 0.000000 0.000002 -0.000011 -0.000000 0.000002
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.789782 -0.000002 0.000002 -0.000009 13.093406 0.000000 0.000000 0.000000 0.000000 -0.000009 0.000003 0.000000
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.207006 0.000000 0.000000 -0.000009 20.790348 -0.000003 0.000000 0.000000 0.000000 -0.000009 0.000004 -0.000003
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 2.033356 1.000772 -1.937610 73.712038 168.618781 -95.596497 0.000000 0.000000 0.000000 0.000000 0.000000 0.000002
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 6.028143 0.000000 -0.000000 -0.462090 -33.623802 93.935244 0.000000 0.000000 0.000000 -0.000003 -0.000001 -0.000000
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.692554 0.000001 0.000004 -0.000003 -3.459062 -0.000000 0.000000 0.000000 0.000000 -0.000003 -0.000001 -0.000000
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 11.481697 0.000001 0.000003 6.108071 2.532072 -89.664286 0.000000 0.000000 0.000000 0.000001 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.859676 -0.132571 1.193109 -9.056514 -50.352978 26.713357 0.000000 0.000002 0.000000 -0.000003 -0.000006 0.000000
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.312559 -0.000002 0.000001 -0.000003 -25.191357 0.000000 0.000000 0.000000 0.000000 -0.000003 -0.000009 0.000000
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.729364 0.000000 -0.000001 -0.000002 -13.995702 0.000002 0.000000 0.000000 -0.000001 -0.000002 -0.000005 0.000002
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.942303 0.050328 0.431044 -4.537309 -46.421337 8.598836 0.000000 0.000000 0.000000 -0.000001 -0.000007 0.000002
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.539099 -0.000002 0.000000 -0.000001 -14.196238 0.000000 0.000000 0.000000 0.000000 -0.000001 -0.000007 0.000000
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 1.196321 0.000004 -0.000000 -0.000000 -24.680792 0.000001 0.000000 0.000000 0.000000 -0.000000 -0.000003 0.000001
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.883659 -0.050324 -0.431042 -1.512837 -33.672457 -4.921995 0.000000 0.000000 0.000000 0.000001 -0.000012 -0.000001
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.719578 0.000002 -0.000000 -0.456875 -20.995249 -0.000001 0.000000 0.000000 0.000000 0.000001 -0.000010 -0.000001
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.209183 0.000002 -0.000000 -0.255595 -12.397439 -0.000001 0.000000 0.000000 0.000000 0.000001 -0.000007 -0.000001
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.859837 -0.148935 -1.331282 2.209727 -30.481417 -20.306713 0.000000 0.000000 0.000000 0.000003 -0.000003 0.000003
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.719425 0.000000 0.000000 -0.378893 -20.796658 0.000002 0.000002 0.000000 0.000000 0.000004 -0.000006 0.000000
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 1.099665 0.000002 0.000000 -0.241269 -13.998056 -0.000002 0.000001 0.000002 0.000000 0.000003 -0.000007 -0.000002
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.806021 -0.359836 -1.318334 38.596443 -45.467528 69.981641 0.000000 0.000000 0.000000 -0.000003 -0.000004 0.000005
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.789782 0.000000 -0.000004 -0.000004 13.095237 0.000003 -0.000002 0.000000 0.000000 -0.000004 -0.000002 0.000003
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.206999 0.000001 0.000002 -0.000003 20.792925 0.000002 0.000000 0.000000 0.000000 -0.000003 -0.000000 0.000002


$bonemerge "ValveBiped.Bip01_Spine4"
$bonemerge "ValveBiped.Bip01_R_Clavicle"
$bonemerge "ValveBiped.Bip01_R_UpperArm"
$bonemerge "ValveBiped.Bip01_R_Forearm"
$bonemerge "ValveBiped.Bip01_R_Hand"
$bonemerge "ValveBiped.Bip01_Neck1"
$bonemerge "ValveBiped.Bip01_Head1"
$bonemerge "ValveBiped.Bip01_L_Clavicle"
$bonemerge "ValveBiped.Bip01_L_UpperArm"
$bonemerge "ValveBiped.Bip01_L_Forearm"
$bonemerge "ValveBiped.Bip01_L_Hand"
$bonemerge "ValveBiped.Bip01_L_Finger4"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "ValveBiped.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger3"
$bonemerge "ValveBiped.Bip01_L_Finger31"
$bonemerge "ValveBiped.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger2"
$bonemerge "ValveBiped.Bip01_L_Finger21"
$bonemerge "ValveBiped.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger1"
$bonemerge "ValveBiped.Bip01_L_Finger11"
$bonemerge "ValveBiped.Bip01_L_Finger12"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger02"
$bonemerge "ValveBiped.Bip01_R_Finger4"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "ValveBiped.Bip01_R_Finger42"
$bonemerge "ValveBiped.Bip01_R_Finger3"
$bonemerge "ValveBiped.Bip01_R_Finger31"
$bonemerge "ValveBiped.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_R_Finger2"
$bonemerge "ValveBiped.Bip01_R_Finger21"
$bonemerge "ValveBiped.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger1"
$bonemerge "ValveBiped.Bip01_R_Finger11"
$bonemerge "ValveBiped.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger0"
$bonemerge "ValveBiped.Bip01_R_Finger01"
$bonemerge "ValveBiped.Bip01_R_Finger02"



$sequence "base_idle" {
	"famas_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "base_draw" {
	"famas_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "base_fire" {
	"famas_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "base_reload" {
	"famas_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 28 "bf3_famas.clipout" }
	{ event 5004 66 "bf3_famas.clipin" }
	fadein 0.3
	fadeout 0.6
	fps 35.1
}

$sequence "base_reload_empty" {
	"famas_anims/base_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 28 "bf3_famas.clipout" }
	{ event 5004 85 "bf3_famas.clipin" }
	{ event 5004 122 "bf3_famas.boltpull" }
	fadein 0.3
	fadeout 0.6
	fps 35.86
}

$sequence "foregrip_idle" {
	"famas_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.4
	fadeout 0.2
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"famas_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 31
}

$sequence "foregrip_fire" {
	"famas_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_reload" {
	"famas_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 28 "bf3_famas.clipout" }
	{ event 5004 66 "bf3_famas.clipin" }
	fadein 0.3
	fadeout 0.6
	fps 35.1
}

$sequence "foregrip_reload_empty" {
	"famas_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 28 "bf3_famas.clipout" }
	{ event 5004 85 "bf3_famas.clipin" }
	{ event 5004 122 "bf3_famas.boltpull" }
	fadein 0.3
	fadeout 0.6
	fps 35.86
}

// 

$modelname "weapons/c_acwr.mdl"

$bodygroup "sight"
{
	studio "sight.smd"
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
$bodygroup "acwr"
{
	studio "acwr.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition 0.398 -13.379 -7.488

$cdmaterials "models\bf3\weapons\rifles\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"acwr"
		"reticle"
		"reflex"
		"lens"
		"kobra"
		"acog"
		"reticle_acog"
		"eotech"
		"reticle_eotech"
		"lens_eotech"
		"muzzle"
		"suppressor"
		"grip"
		"laser"
		"acwr_tape"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 0 0
$attachment "shell" "A_Eject" -0 0 -0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -18.131 -25.058 -17.273 27.956 9.57 4.074

$definebone "ValveBiped.Bip01_L_Clavicle" "" 3.491543 8.830969 -9.976974 91.480562 -73.711880 168.619302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853647 -0.000001 0.000000 -90.505158 2.738853 -33.527943 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390537 -0.000002 0.000001 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525425 0.000000 -0.000002 90.136746 -6.108475 2.532072 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555143 0.315171 -0.822495 -70.054232 -38.916038 -45.195999 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556973 0.000002 0.000000 0.000000 0.000000 13.093403 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.221090 0.000000 0.000000 0.000000 0.000000 20.790347 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828094 -0.209480 -1.286461 20.308432 -2.449395 -30.465197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382519 0.000001 0.000004 0.000000 0.233423 -20.798884 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865904 -0.000001 -0.000002 0.000000 0.148740 -13.999135 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813034 -0.266274 -0.544264 4.921822 1.250767 -33.682298 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445751 0.000000 -0.000001 0.000000 0.316044 -20.997643 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053756 -0.000003 0.000004 0.000000 0.176700 -12.398807 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.689441 -0.342860 0.236190 -8.696353 4.194395 -46.466018 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439795 -0.000002 -0.000001 0.000000 0.000000 -14.197722 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.982989 0.000002 0.000000 -0.000000 0.000000 -24.683136 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426952 -0.353604 1.013784 -26.822045 8.682201 -50.431573 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104663 0.000000 0.000001 0.000000 0.000000 -25.194100 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908442 0.000000 -0.000001 0.000000 0.000000 -13.997302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_Forearm" 0 0 -0.000002 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217918 -0.000005 0 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217918 0.000001 -0.000001 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.217916 0 -0.000005 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217916 0.000001 -0.000002 -0 0 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.21792 0 -0.000003 -0 0 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217916 -0.000003 0.000003 -0 0.000002 -0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" 0.475380 8.830965 -9.976974 -95.596576 73.712052 168.618786 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000001 0.000000 93.935227 -0.462090 -33.623799 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.390539 -0.000001 0.000000 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525430 0.000001 0.000000 -89.664285 6.108074 2.532072 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.555141 0.315171 0.822494 70.000030 38.596442 -45.467524 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556972 0.000001 0.000000 0.000000 -0.000000 13.000011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221089 -0.000002 -0.000001 0.000000 0.000000 20.792925 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828093 -0.209481 1.286462 -20.306713 2.209726 -30.481412 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382517 -0.000000 0.000000 0.000000 -0.378897 -20.796649 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.865909 0.000000 0.000005 0.000000 -0.241273 -13.998046 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813032 -0.266277 0.544264 -4.921994 -1.512838 -33.672443 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445753 0.000000 0.000000 0.000000 -0.456877 -20.995236 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053751 0.000000 -0.000005 0.000000 -0.255596 -12.397432 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.689445 -0.342860 -0.236189 8.598836 -4.537310 -46.421327 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439795 0.000000 0.000002 0.000000 0.000000 -14.196233 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.982989 0.000000 0.000004 0.000000 0.000000 -24.680787 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426955 -0.353604 -1.013783 26.713355 -9.056515 -50.352963 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104665 -0.000000 -0.000001 0.000000 0.000000 -25.191350 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908442 0.000000 0.000003 -0.000000 0.000000 -13.995697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_Forearm" 0 0 0 -0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217917 0.000002 0 0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.217918 0.000001 0 0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217918 0.000002 0 0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.217916 -0.000002 0 0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.217918 0 0 0 0.000002 0.152006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.217916 -0.000002 0 0 0.000001 0.152006 0 0 0 0 0 0
$definebone "Weapon" "" -2.387503 -15.270334 -5.074594 0 0 0 0 0 0 0 0 0
$definebone "Charging_Handle" "Weapon" 0.066779 8.881084 3.401956 -0 0 0.000057 0 0 0 0 0 0
$definebone "Bolt" "Charging_Handle" -0.095912 -5.251013 -0.854032 -0 -89.999982 0 0 0 0 0 0 0
$definebone "DustCover" "Weapon" -0.665847 3.477695 2.269095 -0 0 0.000057 0 0 0 0 0 0
$definebone "Magazine_Release" "Weapon" -0.006288 4.178158 1.057485 -0 0 0.000057 0 0 0 0 0 0
$definebone "Magazine" "Weapon" 0.037367 2.635598 -1.334266 -0 0 0.000057 0 0 0 0 0 0
$definebone "Bullet" "Magazine" -0.174255 0.505857 3.360352 -0 0 0 0 0 0 0 0 0
$definebone "Bullet_2" "Magazine" 0.014291 0.505857 3.121574 -0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Weapon" 0.040949 6.055264 0.892183 -0 0 0.000057 0 0 0 0 0 0
$definebone "A_Suppressor" "Weapon" 0.016964 -18.515348 2.541246 -0 179.999964 -0.000057 0 0 0 0 0 0
$definebone "A_Muzzle" "Weapon" 0.022494 -19.748304 2.539137 -0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "A_UnderBarrel" "Weapon" -0.91062 -13.172815 2.531399 0.000057 -90.000037 -90.000037 0 0 0 0 0 0
$definebone "Bipod" "A_UnderBarrel" -3.480284 2.046947 0.93866 89.999982 -90.000037 0 0 0 0 0 0 0
$definebone "Bipod_Left" "Bipod" 0.782162 -0.000002 -0.319805 -65.000001 -179.999909 89.999921 0 0 0 0 0 0
$definebone "Bipod_Right" "Bipod" -0.782096 -0.000004 -0.319805 64.999939 179.999841 -90.000153 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "Weapon" -0.950814 -7.898512 2.485385 0.000115 -90.000037 179.999978 0 0 0 0 0 0
$definebone "A_GL" "Weapon" 0.02472 -2.024908 1.422118 0.000057 -90.000037 90.000037 0 0 0 0 0 0
$definebone "GL_Base" "A_GL" 0 -0 -0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Slide" "GL_Base" 1.891411 -1.591587 0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Trigger" "GL_Base" -2.772263 -2.006649 -0 -0 -0 0 0 0 0 0 0 0
$definebone "GL_Round" "GL_Base" 3.309917 -1.59422 0.001201 89.999982 89.999982 0 0 0 0 0 0 0
$definebone "GL_Casing" "GL_Base" 4.085115 -1.594219 0.001201 89.999982 89.999982 0 0 0 0 0 0 0
$definebone "M203_Slide_Release" "GL_Base" 4.013391 -0.151551 -0.688799 89.999982 89.999982 0 0 0 0 0 0 0
$definebone "A_Eject" "Weapon" -0.496131 2.887262 2.652126 -24.317246 179.999841 0 0 0 0 0 0 0
$definebone "A_Optic" "Weapon" 0.031988 4.874125 3.698847 -0 179.999964 -90.000037 0 0 0 0 0 0
$definebone "Trigger_m16" "Weapon" 0.040949 5.989647 0.389903 -0 0 0 0 0 0 0 0 0
$definebone "Bipod_Main" "" 8.098196 -21.222406 -0.376701 -26.18136 -38.337234 81.044081 0 0 0 0 0 0
$definebone "A_Bipod" "Bipod_Main" -0.000004 -9.774027 -0.000003 0.000003 0.000005 0 0 0 0 0 0 0
$definebone "Bipod_RightLeg" "Bipod_Main" 0 -1.188227 1.002607 24.963368 93.309441 -88.60202 0 0 0 0 0 0
$definebone "Bipod_LeftLeg" "Bipod_Main" 0.000002 -1.188228 -1.002702 24.963372 -86.69053 -88.601965 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger02" 0.185302 0.061439 0.053308 0.000000 0.000000 20.790347 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger01" 0.323568 -0.165401 -0.006299 0.000000 0.000000 13.093403 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Finger0" 0.619302 -0.144023 -0.080420 -70.054232 -38.916038 -45.195999 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger12" -0.115993 0.136216 0.119473 0.000000 0.148740 -13.999135 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger11" 0.047288 0.105729 0.104320 0.000000 0.233423 -20.798884 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Finger1" 0.197371 0.109627 0.136786 20.308432 -2.449395 -30.465197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger22" -0.144276 0.134282 0.011643 0.000000 0.176700 -12.398807 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger21" 0.047011 0.012902 0.048841 0.000000 0.316044 -20.997643 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Finger2" 0.264223 0.064898 0.179358 4.921822 1.250767 -33.682298 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger32" -0.144176 0.021755 -0.012701 -0.000000 0.000000 -24.683136 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger31" 0.026010 0.091388 0.018706 0.000000 0.000000 -14.197722 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Finger3" 0.244611 0.119344 0.125546 -8.696353 4.194395 -46.466018 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger42" -0.205936 0.218742 -0.005672 0.000000 0.000000 -13.997302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger41" 0.075369 0.171679 0.009089 0.000000 0.000000 -25.194100 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Finger4" 0.303741 0.224130 0.022635 -26.822045 8.682201 -50.431573 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Hand" -0.483183 0.085919 0.039583 90.136746 -6.108475 2.532072 0 0 0 0 0 0
$definebone "l_armtwist_4" "ValveBiped.Bip01_L_ForeTwist6" -1.229097 -0.098784 -0.063417 -0.002693 3.063892 -0.120092 0 0 0 0 0 0
$definebone "l_armtwist_3" "ValveBiped.Bip01_L_ForeTwist4" -0.687423 -0.200492 -0.062452 0.013522 3.06372 -0.132926 0 0 0 0 0 0
$definebone "l_armtwist_2" "ValveBiped.Bip01_L_ForeTwist2" -0.386811 -0.315084 -0.060287 0.029679 3.063548 -0.14576 0 0 0 0 0 0
$definebone "l_armtwist_1" "ValveBiped.Bip01_L_ForeTwist1" -1.473238 -0.438566 -0.05792 0.037815 3.063434 -0.158423 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_UpperArm" -2.016219 -0.514361 -1.382956 -90.505158 2.738853 -33.527943 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger02" 0.322366 0.024373 0.001706 0.000000 0.000000 20.792925 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger01" 0.472650 -0.205722 0.040339 0.000000 -0.000000 13.000011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Finger0" 0.746819 -0.152275 0.135880 70.000030 38.596442 -45.467524 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger12" -0.077940 -0.073040 0.031672 0.000000 -0.241273 -13.998046 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger11" 0.178061 -0.058577 -0.009662 0.000000 -0.378897 -20.796649 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Finger1" 0.329236 0.031135 -0.096600 -20.306713 2.209726 -30.481412 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger22" -0.032540 0.096451 -0.016163 0.000000 -0.255596 -12.397432 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger21" 0.149344 0.050403 -0.032008 0.000000 -0.456877 -20.995236 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Finger2" 0.356815 0.042253 -0.132234 -4.921994 -1.512838 -33.672443 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger32" -0.082891 0.161453 -0.001987 0.000000 0.000000 -24.680787 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger31" 0.101632 0.085271 -0.020671 0.000000 0.000000 -14.196233 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Finger3" 0.316779 0.085631 -0.076644 8.598836 -4.537310 -46.421327 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger42" -0.122939 0.121941 0.025749 -0.000000 0.000000 -13.995697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger41" 0.129879 0.151013 0.033729 0.000000 0.000000 -25.191350 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Finger4" 0.358829 0.190007 0.032557 26.713355 -9.056515 -50.352963 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Hand" -0.404174 0.031242 0.107285 -89.664285 6.108074 2.532072 0 0 0 0 0 0
$definebone "r_armtwist_1" "ValveBiped.Bip01_R_ForeTwist1" -1.389066 -0.414084 0.026888 0.114993 1.926687 -175.820462 0 0 0 0 0 0
$definebone "r_armtwist_4" "ValveBiped.Bip01_R_ForeTwist6" -1.139462 -0.200615 0.01682 0.140604 1.924796 -175.82109 0 0 0 0 0 0
$definebone "r_armtwist_3" "ValveBiped.Bip01_R_ForeTwist5" -1.817343 -0.264395 0.020776 0.135447 1.925312 -175.820804 0 0 0 0 0 0
$definebone "r_armtwist_2" "ValveBiped.Bip01_R_ForeTwist3" -1.518572 -0.33637 0.024041 0.125191 1.926113 -175.82053 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_UpperArm" -1.961136 -0.019127 0.960382 93.935227 -0.462090 -33.623799 0 0 0 0 0 0

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
	"acwr_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 1
	loop
}

$sequence "base_draw" {
	"acwr_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "base_fire" {
	"acwr_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 28
}

$sequence "base_reload" {
	"acwr_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 15 "bf3_acwr.clipout" }
	{ event 5004 58 "bf3_acwr.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "base_reload_empty" {
	"acwr_anims/base_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 15 "bf3_acwr.clipout" }
	{ event 5004 62 "bf3_acwr.clipin" }
	{ event 5004 89 "bf3_acwr.boltcatch" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "foregrip_idle" {
	"acwr_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"acwr_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 40
}

$sequence "foregrip_fire" {
	"acwr_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 28
}

$sequence "foregrip_reload" {
	"acwr_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 15 "bf3_acwr.clipout" }
	{ event 5004 58 "bf3_acwr.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

$sequence "foregrip_reload_empty" {
	"acwr_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 15 "bf3_acwr.clipout" }
	{ event 5004 62 "bf3_acwr.clipin" }
	{ event 5004 85 "bf3_acwr.boltcatch" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 33
}

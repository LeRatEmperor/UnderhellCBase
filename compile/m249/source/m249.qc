<<<<<<< HEAD
// Decompiled from m249.mdl
=======
// 

>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
$modelname "weapons/c_m249.mdl"

$bodygroup "sight"
{
<<<<<<< HEAD
	studio "m249.smd"
}
$bodygroup "barrel"
{
	studio "m249.smd"
=======
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
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}
$bodygroup "m249"
{
	studio "m249.smd"
}

<<<<<<< HEAD
$surfaceprop "default"
$contents "solid"
$illumposition 9.278000 1.553000 -8.124000

$cdmaterials ""
$cdmaterials ""
$cdmaterials ""

$bbox -13.187000 -12.125000 -16.347000 31.743000 15.230000 0.099000
$cbox 0 0 0 0 0 0

$attachment "1" "a" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "2" "s" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "3" "a" -0.000000 0.000000 1.000000 rotate -19.000000 0.000000 1.000000
$attachment "4" "a" 1.000000 0.000000 0.000000 rotate 8.000002 0.000000 1.000000

$definebone "body" "" -2.958619 -9.459352 -6.840805 0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "box" "body" 5.435676 0.447883 -0.000001 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "1" "box" 0.999733 0.774824 -1.723059 -0.549251 -0.445336 0.549251 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "2" "1" 0.522316 0.000000 0.000003 0.000000 -0.000000 -0.008277 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "3" "2" 0.491262 0.000004 -0.000003 0.000000 0.000000 -0.088673 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "4" "3" 0.511077 0.000000 0.000000 0.000000 0.000000 -0.069158 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "5" "4" 0.464242 0.000000 0.000000 0.000000 0.000000 -0.131915 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "6" "5" 0.474506 0.000000 -0.000003 -0.000000 0.000000 -0.134923 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "7" "6" 0.446314 0.000007 -0.000002 -0.000000 0.000000 -0.182957 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "8" "7" 0.445628 0.000000 -0.000003 -0.000000 0.000000 -0.137346 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "9" "8" 0.462731 -0.000003 -0.000001 -0.000000 0.000000 -0.052681 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "10" "9" 0.401141 0.000000 0.000000 -0.000000 0.000000 -0.036570 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "11" "10" 0.404678 0.000000 0.000000 -0.000000 0.000000 -0.018685 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "bolt" "body" 6.519150 3.386316 2.063232 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "cover" "body" 7.003280 4.620227 1.473876 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "a" "body" 21.991043 3.578003 0.446293 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "s" "body" 4.431913 3.879596 1.795678 0.816427 0.213566 0.519040 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "handle" "body" 8.509753 4.092883 0.563612 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Dummy01" "" -5.566715 7.677234 -6.998626 0.000000 0.000000 0.125087 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right_U_Arm" "Dummy01" 0.000000 0.000000 0.000000 0.302252 -0.635990 -0.645907 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right_L_Arm" "Right_U_Arm" 8.403359 -0.000001 -0.000006 -0.000000 0.484786 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right_Hand" "Right_L_Arm" 8.136633 0.000010 0.000007 -0.702846 -0.097445 -0.089998 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right1" "Right_Hand" 1.369798 0.361444 1.237273 0.386981 0.113360 0.339005 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right2" "Right1" 1.320667 -0.000004 0.000002 0.110239 -0.051738 -0.200441 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right3" "Right2" 1.066024 0.000001 -0.000000 0.030632 -0.048444 -0.473215 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right4" "Right_Hand" 3.525413 -0.419239 0.945130 0.706837 -0.023712 -0.008235 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right5" "Right4" 1.209884 0.000000 0.000001 0.003877 0.209430 -0.009512 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right6" "Right5" 0.743917 -0.000000 0.000000 0.002042 0.539675 -0.047955 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right7" "Right_Hand" 3.914318 -1.008661 0.216022 0.525743 0.481894 0.471799 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right8" "Right7" 1.491587 -0.000724 0.197241 0.001263 0.398924 -0.007295 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right9" "Right8" 0.906343 0.000000 0.000000 0.002095 0.040988 0.022640 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right10" "Right_Hand" 3.766824 -0.795713 -0.528269 0.494700 0.538016 0.495130 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right11" "Right10" 1.336411 -0.014436 0.211799 0.034873 0.254976 0.035662 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right12" "Right11" 0.919429 0.000000 -0.000001 -0.024389 0.217111 -0.006301 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right13" "Right_Hand" 3.438739 -0.444397 -1.217639 0.576785 0.455803 0.403358 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right14" "Right13" 0.919743 -0.008903 0.139835 0.027935 0.423793 0.009012 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Right15" "Right14" 0.708997 -0.000000 -0.000000 -0.022616 0.087266 0.036608 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Dummy02" "" 8.390234 -10.286664 -11.630341 0.098530 0.563532 -0.410748 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left_U_Arm" "Dummy02" 0.000000 0.000000 0.000000 -0.594370 0.359714 -0.343306 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left_L_Arm" "Left_U_Arm" 8.403361 0.000003 -0.000006 0.000000 0.606591 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left_Hand" "Left_L_Arm" 8.136637 -0.000009 0.000004 0.666094 -0.268824 0.233342 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left1" "Left_Hand" 1.369792 -0.361444 1.237273 -0.662396 -0.111017 -0.312959 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left2" "Left1" 1.320669 0.000000 0.000002 -0.103524 -0.133731 -0.004348 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left3" "Left2" 1.066031 -0.000001 -0.000002 -0.001976 -0.057282 -0.035478 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left10" "Left_Hand" 3.289558 0.311003 -0.505976 -0.698161 0.098274 -0.049529 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left11" "Left10" 1.262956 0.000000 -0.000004 -0.041702 0.042219 -0.027365 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left12" "Left11" 0.919428 0.000002 0.000000 0.024389 0.217110 0.006301 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left13" "Left_Hand" 3.167419 0.097636 -1.197365 -0.703823 0.064722 -0.003425 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left14" "Left13" 0.817883 -0.000001 0.000001 -0.029291 0.189764 -0.001913 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left15" "Left14" 0.708995 -0.000003 0.000006 0.022616 0.087266 -0.036609 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left7" "Left_Hand" 3.414732 0.449904 0.223657 -0.704596 0.062904 -0.050450 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left8" "Left7" 1.390924 0.000000 -0.000002 0.001534 0.112316 0.008726 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left9" "Left8" 0.906347 -0.000002 -0.000004 -0.002095 0.040988 -0.022640 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left4" "Left_Hand" 3.525411 0.419243 0.945131 -0.706608 0.035372 -0.050754 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left5" "Left4" 1.209881 -0.000001 -0.000004 -0.002719 0.081027 0.009434 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Left6" "Left5" 0.743919 -0.000002 0.000004 -0.000364 0.025678 0.046368 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

$BoneMerge "ValveBiped.Bip01_Spine4"
=======

$surfaceprop "default"

$contents "solid"

$illumposition 1.553 -9.278 -8.124

$cdmaterials "models\bf3\weapons\lmg\"
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
		"m249"
		"muzzle"
		"suppressor"
		"m249_bullets"
		"m249_misc"
	}
}

$attachment "1" "a" 0 0 -0 rotate -0 0 0
$attachment "2" "s" 0 0 0 rotate -0 0 -0
$attachment "3" "a" -19 2 -0 rotate 90 -0 -0
$attachment "4" "a" 8 0 -0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -13.187 -12.125 -16.347 31.743 15.23 0.099

$definebone "body" "" -2.958619 -9.459352 -6.840805 0 -90.000037 89.999982 0 0 0 0 0 0
$definebone "box" "body" 5.435676 0.447883 -0.000001 -0 0 0 0 0 0 0 0 0
$definebone "1" "box" 0.999733 0.774824 -1.723059 11.929357 90.000016 -90.000016 0 0 0 0 0 0
$definebone "2" "1" 0.522316 0 0.000003 0 -0.948532 0.000057 0 0 0 0 0 0
$definebone "3" "2" 0.491262 0.000004 -0.000003 0 -10.174585 0 0 0 0 0 0 0
$definebone "4" "3" 0.511077 0 0 0 -7.931228 0 0 0 0 0 0 0
$definebone "5" "4" 0.464242 0 0 0 -15.160575 0 0 0 0 0 0 0
$definebone "6" "5" 0.474506 0 -0.000003 0 -15.508361 -0 0 0 0 0 0 0
$definebone "7" "6" 0.446314 0.000007 -0.000002 0 -21.084104 -0 0 0 0 0 0 0
$definebone "8" "7" 0.445628 0 -0.000003 0 -15.788653 -0 0 0 0 0 0 0
$definebone "9" "8" 0.462731 -0.000003 -0.000001 0 -6.039547 -0 0 0 0 0 0 0
$definebone "10" "9" 0.401141 0 0 0 -4.19153 -0 0 0 0 0 0 0
$definebone "11" "10" 0.404678 0 0 0 -2.141258 -0 0 0 0 0 0 0
$definebone "bolt" "body" 6.51915 3.386316 2.063232 -0 0 0 0 0 0 0 0 0
$definebone "cover" "body" 7.00328 4.620227 1.473876 -0 0 0 0 0 0 0 0 0
$definebone "a" "body" 21.991043 3.578003 0.446293 -0 0 0 0 0 0 0 0 0
$definebone "s" "body" 4.431913 3.879596 1.795678 -52.140937 52.926576 133.740951 0 0 0 0 0 0
$definebone "handle" "body" 8.509753 4.092883 0.563612 -0 0 0 0 0 0 0 0 0
$definebone "Dummy01" "" -5.566715 7.677234 -6.998626 0 14.371614 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "Dummy01" 0.000000 0.000000 0.000000 1.639479 -0.008065 -0.586846 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 8.403359 -0.000001 -0.000006 0.000000 0.000000 -0.060372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.136633 0.000010 0.000007 -1.564937 0.106606 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 1.369798 0.361444 1.237273 1.221731 0.673635 -0.793558 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.320667 -0.000004 0.000002 0.000000 0.000000 0.226893 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.066024 0.000001 -0.000000 0.000000 0.000000 0.362905 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.525413 -0.419239 0.945130 -0.354419 0.038567 -0.532001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.209884 0.000000 0.000001 0.000000 -0.006613 -0.362970 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.743917 -0.000000 0.000000 -0.000000 -0.004211 -0.244312 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.914318 -1.008661 0.216022 -0.085905 -0.026404 -0.587695 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.491587 -0.000724 0.197241 0.000000 -0.007974 -0.366436 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 0.906343 0.000000 0.000000 0.000000 -0.004461 -0.216376 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.766824 -0.795713 -0.528269 0.150078 -0.079191 -0.810205 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.336411 -0.014436 0.211799 -0.000000 -0.000000 -0.247771 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.919429 0.000000 -0.000001 0.000000 0.000000 -0.430761 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.438739 -0.444397 -1.217639 0.466236 -0.158066 -0.878825 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 0.919743 -0.008903 0.139835 0.000000 -0.000000 -0.439672 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.708997 -0.000000 -0.000000 0.000000 0.000000 -0.244271 0 0 0 0 0 0
$definebone "Dummy02" "" 8.390234 -10.286664 -11.630341 61.773617 -86.674418 -43.080066 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "Dummy02" 0.000000 0.000000 0.000000 -1.579613 0.047802 -0.585173 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 8.403361 0.000003 -0.000006 -0.000000 -0.000000 -0.060372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.136637 -0.000009 0.000004 1.573183 -0.106613 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 1.369792 -0.361444 1.237273 -1.222677 -0.679213 -0.788819 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.320669 0.000000 0.000002 0.000000 -0.000000 0.228523 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.066031 -0.000001 -0.000002 0.000000 -0.000000 0.362860 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.289558 0.311003 -0.505976 -0.151780 0.073206 -0.810985 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.262956 0.000000 -0.000004 0.000000 -0.000000 -0.247797 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.919428 0.000002 0.000000 0.000000 0.000000 -0.430802 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.167419 0.097636 -1.197365 -0.468133 0.151533 -0.880197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 0.817883 -0.000001 0.000001 0.000000 0.000000 -0.439720 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.708995 -0.000003 0.000006 0.000000 0.000000 -0.244299 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.414732 0.449904 0.223657 0.085902 0.021830 -0.587867 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.390924 0.000000 -0.000002 0.000000 0.005516 -0.366478 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 0.906347 -0.000002 -0.000004 -0.000000 0.003084 -0.216400 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.525411 0.419243 0.945131 0.354449 -0.042750 -0.531718 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.209881 -0.000001 -0.000004 0.000000 0.004074 -0.363009 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.743919 -0.000002 0.000004 0.000000 0.002596 -0.244331 0 0 0 0 0 0

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

$sequence "idle1" {
	"m249_anims/idle1.smd"
	fps 30
=======



$sequence "idle1" {
	"m249_anims/idle1.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 35
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "draw" {
	"m249_anims/draw.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 32
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "fire" {
	"m249_anims/fire.smd"
<<<<<<< HEAD
	fps 30
=======
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 38
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "reload" {
	"m249_anims/reload.smd"
<<<<<<< HEAD
	fps 30
}

=======
	activity "ACT_VM_RELOAD" 1
	{ event 5004 23 "bf3_m249.boltpull" }
	{ event 5004 83 "bf3_m249.coverup" }
	{ event 5004 108 "bf3_m249.boxout" }
	{ event 5004 132 "bf3_m249.boxin" }
	{ event 5004 157 "bf3_m249.chain" }
	{ event 5004 190 "bf3_m249.coverdown" }
	fadein 0.2
	fadeout 0.2
	fps 39
}
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3

<<<<<<< HEAD
// Decompiled from mp7.mdl
=======
// 

>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
$modelname "weapons/c_mp7.mdl"

$bodygroup "sight"
{
<<<<<<< HEAD
	studio "mp7.smd"
}
$bodygroup "barrel"
{
	studio "mp7.smd"
}
$bodygroup "blank"
{
	studio "mp7.smd"
}
$bodygroup "laser"
{
	studio "mp7.smd"
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
}
$bodygroup "blank"
{
	blank
}
$bodygroup "laser"
{
	blank
	studio "laser.smd"
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}
$bodygroup "mp7"
{
	studio "mp7.smd"
}
<<<<<<< HEAD
// REMOVED: hands bodygroup

$surfaceprop "default"
$contents "solid"
$illumposition -51.030998 1.042000 -13.860000

$cdmaterials ""
$cdmaterials ""
$cdmaterials ""

$bbox -8.595000 -9.768000 -12.275000 19.381001 8.260000 0.588000
$cbox 0 0 0 0 0 0

$attachment "1" "muzzle_flash" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "2" "shell_ejection" 0.620885 0.766044 0.166366 rotate 0.000000 -0.739942 0.642788

$definebone "Mp7_Body" "" 1.312189 1.728190 0.482725 -1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Mp7_Magazine" "" 1.312189 1.728192 0.482723 -1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Mp7_Trigger" "" 1.312189 1.728192 0.482723 -1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Mp7_BoltRelease" "" 1.312188 1.728190 0.482723 -1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Mp7_Foregrip" "" 1.312189 1.728189 0.482722 -1.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "shell_ejection" "" -2.743761 -10.212969 -3.251182 -0.184948 -0.049360 -0.948315 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "muzzle_flash" "" -2.525776 -19.332973 -2.973041 0.000000 0.000000 -0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Clavicle" "" 1.510186 2.670961 -6.828427 -0.000341 0.000036 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L UpperArm" "Bip01 L Clavicle" 5.853649 -0.000000 0.000000 -0.501419 0.497221 -0.499480 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Forearm" "Bip01 L UpperArm" 9.961163 0.000000 0.000000 0.000000 0.000000 -0.006364 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Hand" "Bip01 L Forearm" 8.503069 0.000000 0.000000 -0.706749 -0.009065 0.003113 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger0" "Bip01 L Hand" 0.756623 0.677738 -1.164276 0.695092 0.302967 -0.040221 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger01" "Bip01 L Finger0" 1.815093 -0.000001 -0.000002 -0.000000 0.000000 0.108625 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger02" "Bip01 L Finger01" 1.031523 -0.000001 0.000001 -0.000000 0.000000 0.102048 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger1" "Bip01 L Hand" 3.560264 0.118226 -1.221193 0.082846 0.031192 0.045545 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger11" "Bip01 L Finger1" 1.161263 0.000001 0.000000 0.000000 -0.000000 0.167181 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger12" "Bip01 L Finger11" 0.705674 -0.000001 0.000000 -0.000000 0.000000 0.214355 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger2" "Bip01 L Hand" 3.535865 -0.001417 -0.449379 0.048292 0.008806 0.080904 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger21" "Bip01 L Finger2" 1.259420 0.000000 0.000000 -0.000000 0.000000 0.260841 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger22" "Bip01 L Finger21" 0.945206 0.000002 -0.000000 -0.000000 0.000000 0.206915 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger3" "Bip01 L Hand" 3.379947 -0.050748 0.292731 -0.064755 -0.036334 0.139319 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger31" "Bip01 L Finger3" 1.267426 -0.000001 0.000000 -0.000000 -0.000000 0.259945 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger32" "Bip01 L Finger31" 0.855791 -0.000002 -0.000001 0.000000 0.000000 0.221650 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger4" "Bip01 L Hand" 3.272117 0.110096 1.013747 -0.087129 -0.051924 0.190753 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger41" "Bip01 L Finger4" 0.753935 -0.000001 0.000000 0.000000 -0.000000 0.184619 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L Finger42" "Bip01 L Finger41" 0.703493 0.000002 0.000000 0.000000 -0.000000 0.149469 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L ForeTwist" "Bip01 L UpperArm" 9.961163 0.000000 0.000000 0.000061 -0.000000 -0.006364 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L ForeTwist1" "Bip01 L ForeTwist" 1.417177 0.000000 0.000000 0.000061 -0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L ForeTwist2" "Bip01 L ForeTwist1" 1.417180 -0.000000 0.000000 0.000061 0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L ForeTwist3" "Bip01 L ForeTwist2" 1.417174 0.000000 0.000001 0.000061 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L ForeTwist4" "Bip01 L ForeTwist3" 1.417179 0.000000 0.000000 0.000061 0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 L ForeTwist5" "Bip01 L ForeTwist4" 1.417177 -0.000000 0.000000 0.000061 0.000000 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Clavicle" "" -1.505977 2.670953 -6.827188 -0.000003 1.000000 -0.000341 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R UpperArm" "Bip01 R Clavicle" 5.853648 0.000000 0.000000 0.501625 -0.497426 -0.499273 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Forearm" "Bip01 R UpperArm" 9.961164 0.000001 0.000000 -0.000000 -0.000000 -0.006364 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Hand" "Bip01 R Forearm" 8.503071 0.000000 0.000000 0.706749 0.009065 0.003113 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger0" "Bip01 R Hand" 0.756617 0.677738 1.164276 -0.695092 -0.302967 -0.040221 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger01" "Bip01 R Finger0" 1.815095 0.000002 -0.000001 -0.000000 -0.000000 0.108625 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger02" "Bip01 R Finger01" 1.031525 -0.000002 -0.000001 -0.000000 -0.000000 0.102048 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger1" "Bip01 R Hand" 3.560263 0.118225 1.221194 -0.082847 -0.031192 0.045545 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger11" "Bip01 R Finger1" 1.161264 0.000001 -0.000001 0.000000 -0.000000 0.167181 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger12" "Bip01 R Finger11" 0.705669 0.000000 0.000000 0.000000 -0.000000 0.214355 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger2" "Bip01 R Hand" 3.535860 -0.001417 0.449380 -0.048292 -0.008806 0.080904 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger21" "Bip01 R Finger2" 1.259424 0.000000 -0.000000 0.000000 -0.000000 0.260841 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger22" "Bip01 R Finger21" 0.945208 0.000004 0.000000 0.000000 -0.000000 0.206915 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger3" "Bip01 R Hand" 3.379942 -0.050749 -0.292730 0.064755 0.036334 0.139319 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger31" "Bip01 R Finger3" 1.267433 0.000000 0.000001 -0.000000 0.000000 0.259945 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger32" "Bip01 R Finger31" 0.855784 0.000002 -0.000001 -0.000000 0.000000 0.221650 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger4" "Bip01 R Hand" 3.272116 0.110096 -1.013746 0.087129 0.051924 0.190753 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger41" "Bip01 R Finger4" 0.753936 0.000000 -0.000000 -0.000000 0.000000 0.184619 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R Finger42" "Bip01 R Finger41" 0.703496 0.000004 0.000000 -0.000000 0.000000 0.149469 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R ForeTwist" "Bip01 R UpperArm" 9.961164 0.000001 0.000000 -0.000061 0.000000 -0.006364 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R ForeTwist1" "Bip01 R ForeTwist" 1.417178 -0.000000 0.000000 -0.000061 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R ForeTwist2" "Bip01 R ForeTwist1" 1.417179 0.000000 0.000000 -0.000061 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R ForeTwist3" "Bip01 R ForeTwist2" 1.417178 0.000000 -0.000000 -0.000061 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R ForeTwist4" "Bip01 R ForeTwist3" 1.417182 0.000000 -0.000000 -0.000061 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bip01 R ForeTwist5" "Bip01 R ForeTwist4" 1.417176 0.000000 -0.000000 -0.000061 -0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

$BoneMerge "ValveBiped.Bip01_Spine4"
=======
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
$definebone "ValveBiped.Bip01_L_Clavicle" "" 1.510186 2.670961 -6.828427 1.596637 -1.286515 2.942962 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853649 -0.000000 0.000000 -1.579613 0.047802 -0.585173 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 9.961163 0.000000 0.000000 0.000000 0.000000 -0.060372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.503069 0.000000 0.000000 1.573183 -0.106613 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.756623 0.677738 -1.164276 -1.222677 -0.679213 -0.788819 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.815093 -0.000001 -0.000002 0.000000 0.000000 0.228523 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.031523 -0.000001 0.000001 0.000000 0.000000 0.362860 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.560264 0.118226 -1.221193 0.354449 -0.042750 -0.531718 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.161263 0.000001 0.000000 -0.000000 0.004074 -0.363009 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.705674 -0.000001 0.000000 0.000000 0.002596 -0.244331 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.535865 -0.001417 -0.449379 0.085902 0.021830 -0.587867 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.259420 0.000000 0.000000 0.000000 0.005516 -0.366478 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 0.945206 0.000002 -0.000000 0.000000 0.003084 -0.216400 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.379947 -0.050748 0.292731 -0.151780 0.073206 -0.810985 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.267426 -0.000001 0.000000 0.000000 0.000000 -0.247797 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.855791 -0.000002 -0.000001 0.000000 0.000000 -0.430802 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.272117 0.110096 1.013747 -0.468133 0.151533 -0.880197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 0.753935 -0.000001 0.000000 0.000000 0.000000 -0.439720 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.703493 0.000002 0.000000 0.000000 0.000000 -0.244299 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_UpperArm" 9.961163 0 0 0 -0.729261 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.417177 0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.41718 -0 0 0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.417174 0 0.000001 -0 0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.417179 0 0 0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.417177 -0 0 0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" -1.505977 2.670953 -6.827188 -1.668475 1.286518 2.942953 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0.000000 0.000000 1.639479 -0.008065 -0.586846 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 9.961164 0.000001 0.000000 0.000000 0.000000 -0.060372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.503071 0.000000 0.000000 -1.564937 0.106606 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.756617 0.677738 1.164276 1.221731 0.673635 -0.793558 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.815095 0.000002 -0.000001 0.000000 0.000000 0.226893 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.031525 -0.000002 -0.000001 0.000000 0.000000 0.362905 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.560263 0.118225 1.221194 -0.354419 0.038567 -0.532001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.161264 0.000001 -0.000001 0.000000 -0.006613 -0.362970 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.705669 0.000000 0.000000 0.000000 -0.004211 -0.244312 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.535860 -0.001417 0.449380 -0.085905 -0.026404 -0.587695 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.259424 0.000000 -0.000000 -0.000000 -0.007974 -0.366436 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 0.945208 0.000004 0.000000 0.000000 -0.004461 -0.216376 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.379942 -0.050749 -0.292730 0.150078 -0.079191 -0.810205 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.267433 0.000000 0.000001 0.000000 0.000000 -0.247771 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.855784 0.000002 -0.000001 0.000000 0.000000 -0.430761 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.272116 0.110096 -1.013746 0.466236 -0.158066 -0.878825 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 0.753936 0.000000 -0.000000 0.000000 0.000000 -0.439672 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.703496 0.000004 0.000000 0.000000 0.000000 -0.244271 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_UpperArm" 9.961164 0.000001 0 -0 -0.729261 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.417178 -0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.417179 0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.417178 0 -0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.417182 0 -0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.417176 0 -0 -0 0 -0.006933 0 0 0 0 0 0

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
	"mp7_anims/idle.smd"
	fps 30
=======



$sequence "idle" {
	"mp7_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}

$sequence "reload" {
	"mp7_anims/reload.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_RELOAD" 1
	{ event 5004 10 "bf3_mp7.clipout" }
	{ event 5004 49 "bf3_mp7.clipin" }
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "reload_empty" {
	"mp7_anims/reload_empty.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 10 "bf3_mp7.clipout" }
	{ event 5004 49 "bf3_mp7.clipin" }
	{ event 5004 68 "bf3_mp7.boltcatch" }
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "draw" {
	"mp7_anims/draw.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	{ event 5004 14 "bf3_mp7.grip" }
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "fire" {
	"mp7_anims/fire.smd"
<<<<<<< HEAD
	fps 30
}

=======
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3

<<<<<<< HEAD
// Decompiled from sv98.mdl
=======
// 

>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
$modelname "weapons/c_sv98.mdl"

$bodygroup "sight"
{
<<<<<<< HEAD
	studio "sv98.smd"
}
$bodygroup "barrel"
{
	studio "sv98.smd"
=======
	blank
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
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
}
$bodygroup "sv98"
{
	studio "sv98.smd"
}

<<<<<<< HEAD
$surfaceprop "default"
$contents "solid"
$illumposition 11.874000 -3.253000 -6.016000

$cdmaterials ""
$cdmaterials ""
$cdmaterials ""

$bbox -7.477000 -28.874001 -11.906000 31.225000 4.231000 1.061000
$cbox 0 0 0 0 0 0

$attachment "muzzle" "Base" -0.000000 1.000000 0.000000 rotate 0.000000 -1.000000 -0.000000
$attachment "ejectbrass" "Base" -0.707107 0.000000 0.707107 rotate 0.000000 -0.000000 -1.000000

$definebone "Base" "" -2.762827 -10.694886 -1.985199 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bolt2" "Base" -0.007069 4.169496 -0.010798 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Bolt1" "Bolt2" 0.012820 -1.271972 0.010798 0.000000 -0.029785 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Mag" "Base" 0.005037 0.777761 -1.158804 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-upperarm-movement" "" 2.442776 -0.684586 -5.344038 -0.357468 0.350628 -0.613335 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-upperarm" "l-upperarm-movement" 0.000000 0.000000 0.000000 -0.920200 -0.357243 0.156029 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-forearm" "l-upperarm" 9.051079 -0.000001 -0.000007 0.081834 0.110069 0.775094 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "lwrist" "l-forearm" 9.267328 -0.012908 -0.047794 -0.210504 -0.067305 -0.327114 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-index-low" "lwrist" 3.720291 0.080502 -0.994914 0.679627 -0.075923 0.048859 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-index-mid" "l-index-low" 1.279286 0.000002 -0.000000 0.001701 0.386141 0.003340 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-index-tip" "l-index-mid" 0.769876 0.000001 0.000003 0.000461 0.595453 0.000706 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-middle-low" "lwrist" 3.819602 -0.171115 -0.271817 0.457674 0.084108 0.278947 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-middle-mid" "l-middle-low" 1.425531 0.000004 -0.000003 0.004482 0.658076 0.005789 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-middle-tip" "l-middle-mid" 0.831717 0.000002 0.000000 0.013831 -0.184970 -0.011397 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-ring-low" "lwrist" 3.610806 -0.040065 0.504235 0.353911 0.180087 0.333881 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-ring-mid" "l-ring-low" 1.310056 -0.000002 0.000000 0.007380 0.575557 0.015735 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-ring-tip" "l-ring-mid" 0.866592 0.000007 0.000001 0.008689 -0.161443 0.013874 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-pinky-low" "lwrist" 3.227354 0.282462 1.200264 0.215353 0.276905 0.344264 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-pinky-mid" "l-pinky-low" 0.998019 0.000001 -0.000017 0.024402 0.498350 0.041845 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-pinky-tip" "l-pinky-mid" 0.721984 0.000000 0.000001 0.004735 -0.104314 0.013458 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-thumb-low" "lwrist" 0.992898 0.886230 -0.993035 -0.988310 0.018891 0.149442 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-thumb-mid" "l-thumb-low" 1.656128 -0.000001 0.000000 -0.017157 -0.021509 -0.054709 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-thumb-tip" "l-thumb-mid" 1.015349 0.000003 0.000001 -0.013810 -0.087050 0.001883 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "l-forearm-twist" "l-forearm" 7.988212 0.070387 -0.005725 0.406260 0.593897 0.354527 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-upperarm-movement" "" -3.078900 7.479184 -4.110960 0.127280 -0.136392 -0.697733 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-upperarm" "r-upperarm-movement" 0.000000 -0.000000 0.000000 0.825322 -0.556075 -0.087811 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-forearm" "r-upperarm" 9.051083 0.000005 -0.000006 -0.067853 0.121261 -0.850655 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-rist" "r-forearm" 9.267326 0.012918 -0.047794 -0.288122 -0.158430 0.397488 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-index-low" "r-rist" 3.720295 -0.080503 -0.994916 -0.639673 0.076129 -0.093761 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-index-mid" "r-index-low" 1.279294 0.000000 0.000000 0.000273 0.286332 -0.003378 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-index-tip" "r-index-mid" 0.769872 0.000000 0.000003 0.000249 0.382503 -0.000756 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-pinky-low" "r-rist" 3.227356 -0.282463 1.200263 -0.345302 0.409561 -0.409312 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-pinky-mid" "r-pinky-low" 0.998023 0.000000 -0.000012 -0.033709 0.277442 -0.034816 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-pinky-tip" "r-pinky-mid" 0.721982 -0.000002 -0.000001 0.002680 0.393281 -0.012337 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-middle-low" "r-rist" 3.819603 0.171115 -0.271819 -0.387770 0.340915 -0.550084 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-middle-mid" "r-middle-low" 1.425537 0.000001 -0.000001 -0.005637 0.488186 -0.004758 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-middle-tip" "r-middle-mid" 0.831716 0.000000 0.000000 -0.017868 0.411910 0.001404 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-ring-low" "r-rist" 3.610808 0.040063 0.504234 -0.331807 0.396425 -0.537622 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-ring-mid" "r-ring-low" 1.310058 0.000002 0.000001 -0.010697 0.382939 -0.013758 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-ring-tip" "r-ring-mid" 0.866600 -0.000008 0.000000 0.002841 0.512201 -0.010763 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-thumb-low" "r-rist" 0.992896 -0.886230 -0.993032 0.961088 -0.144021 -0.225597 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-thumb-mid" "r-thumb-low" 1.656127 0.000004 0.000000 0.001512 0.252774 0.057318 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-thumb-tip" "r-thumb-mid" 1.015355 -0.000005 0.000001 0.013330 0.338042 0.004072 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "r-forearm-twist" "r-forearm" 7.988214 -0.070377 -0.005723 -0.625777 0.353935 -0.582525 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "SV" "" -2.726657 -13.699903 -4.063514 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Mesh_0011" "SV" -0.078963 17.931120 0.662951 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

$BoneMerge "ValveBiped.Bip01_Spine4"
=======

$surfaceprop "default"

$contents "solid"

$illumposition -3.253 -11.874 -6.016

$cdmaterials "models\bf3\weapons\sniper\"
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
		"scope_ballistic"
		"sv98"
		"suppressor"
	}
}

$attachment "muzzle" "Base" 0 -20.5 0 rotate -0 -90 0
$attachment "ejectbrass" "Base" 0 0 0 rotate -45 -180 0

$cbox 0 0 0 0 0 0

$bbox -7.477 -28.874 -11.906 31.225 4.231 1.061

$definebone "Base" "" -2.762827 -10.694886 -1.985199 0 0 0 0 0 0 0 0 0
$definebone "Bolt2" "Base" -0.007069 4.169496 -0.010798 -0 0 0 0 0 0 0 0 0
$definebone "Bolt1" "Bolt2" 0.01282 -1.271972 0.010798 -3.413568 0 0 0 0 0 0 0 0
$definebone "Mag" "Base" 0.005037 0.777761 -1.158804 -0 0 0 0 0 0 0 0 0
$definebone "l-upperarm-movement" "" 2.442776 -0.684586 -5.344038 -0.581953 -89.899141 -60.09393 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 9.267328 -0.012908 -0.047794 1.573183 -0.106613 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.720291 0.080502 -0.994914 0.354449 -0.042750 -0.531718 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.279286 0.000002 -0.000000 0.000000 0.004074 -0.363009 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.769876 0.000001 0.000003 0.000000 0.002596 -0.244331 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.819602 -0.171115 -0.271817 0.085902 0.021830 -0.587867 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.425531 0.000004 -0.000003 -0.000000 0.005516 -0.366478 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 0.831717 0.000002 0.000000 0.000000 0.003084 -0.216400 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.610806 -0.040065 0.504235 -0.151780 0.073206 -0.810985 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.310056 -0.000002 0.000000 -0.000000 -0.000000 -0.247797 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.866592 0.000007 0.000001 0.000000 -0.000000 -0.430802 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.227354 0.282462 1.200264 -0.468133 0.151533 -0.880197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 0.998019 0.000001 -0.000017 0.000000 0.000000 -0.439720 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.721984 0.000000 0.000001 0.000000 -0.000000 -0.244299 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.992898 0.886230 -0.993035 -1.222677 -0.679213 -0.788819 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.656128 -0.000001 0.000000 -0.000000 -0.000000 0.228523 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.015349 0.000003 0.000001 -0.000000 -0.000000 0.362860 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_Forearm" 7.988212 0.070387 -0.005725 24.909903 87.270297 92.244608 0 0 0 0 0 0
$definebone "r-upperarm-movement" "" -3.0789 7.479184 -4.11096 -0.633347 -90.622731 21.494798 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 9.267326 0.012918 -0.047794 -1.564937 0.106606 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.720295 -0.080503 -0.994916 -0.354419 0.038567 -0.532001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.279294 0.000000 0.000000 0.000000 -0.006613 -0.362970 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.769872 0.000000 0.000003 0.000000 -0.004211 -0.244312 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.227356 -0.282463 1.200263 0.466236 -0.158066 -0.878825 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 0.998023 0.000000 -0.000012 -0.000000 0.000000 -0.439672 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.721982 -0.000002 -0.000001 -0.000000 0.000000 -0.244271 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.819603 0.171115 -0.271819 -0.085905 -0.026404 -0.587695 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.425537 0.000001 -0.000001 -0.000000 -0.007974 -0.366436 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 0.831716 0.000000 0.000000 0.000000 -0.004461 -0.216376 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.610808 0.040063 0.504234 0.150078 -0.079191 -0.810205 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.310058 0.000002 0.000001 -0.000000 -0.000000 -0.247771 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.866600 -0.000008 0.000000 0.000000 0.000000 -0.430761 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.992896 -0.886230 -0.993032 1.221731 0.673635 -0.793558 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.656127 0.000004 0.000000 0.000000 0.000000 0.226893 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.015355 -0.000005 0.000001 0.000000 -0.000000 0.362905 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_Forearm" 7.988214 -0.070377 -0.005723 -27.427832 -85.425538 -92.178027 0 0 0 0 0 0
$definebone "SV" "" -2.726657 -13.699903 -4.063514 0 0 0 0 0 0 0 0 0
$definebone "Mesh_0011" "SV" -0.078963 17.93112 0.662951 -0 0 0 0 0 0 0 0 0

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
	"sv98_anims/idle.smd"
=======



$definebone "ValveBiped.Bip01_Spine4" "" 0.000006 3.336140 58.352139 -1.570799 -1.391900 -1.570795 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 2.033348 1.000767 1.937660 1.596637 -1.286515 2.942962 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 6.028141 0.000000 0.000000 -1.579613 0.047802 -0.585173 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.692558 -0.000000 0.000000 0.000000 0.000000 -0.060372 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 2.033360 1.000772 -1.937610 -1.668475 1.286518 2.942953 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 6.028143 0.000004 0.000000 1.639479 -0.008065 -0.586846 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.692549 -0.000000 0.000004 0.000000 0.000000 -0.060372 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$sequence "idle" {
	"sv98_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "draw" {
	"sv98_anims/draw.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "fire" {
	"sv98_anims/fire.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event 5004 16 "bf3_sv98.boltback" }
	{ event 5004 25 "bf3_sv98.boltforward" }
	fadein 0
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "reload" {
	"sv98_anims/reload.smd"
<<<<<<< HEAD
=======
	activity "ACT_VM_RELOAD" 1
	{ event 5004 23 "bf3_sv98.clipout" }
	{ event 5004 62 "bf3_sv98.clipin" }
	fadein 0.2
	fadeout 0.2
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3
	fps 30
}

$sequence "reload_empty" {
	"sv98_anims/reload_empty.smd"
<<<<<<< HEAD
	fps 30
}

=======
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 23 "bf3_sv98.clipout" }
	{ event 5004 62 "bf3_sv98.clipin" }
	{ event 5004 89 "bf3_sv98.boltback" }
	{ event 5004 96 "bf3_sv98.boltforward" }
	fadein 0.2
	fadeout 0.2
	fps 30
}
>>>>>>> af8e51f72233f79e1f56ef3085a5cc5e2f78bed3

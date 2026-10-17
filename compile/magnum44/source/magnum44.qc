// 

$modelname "weapons/c_magnum44.mdl"

$bodygroup "magnum44"
{
	studio "magnum44.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition 0.784 -4.379 -2.747

$cdmaterials "models\bf3\weapons\pistols\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"magnum44"
		"magnum44_bullets"
	}
}

$attachment "1" "muzzle" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -9.037 -9.049 -12.381 17.794 10.623 6.926

$definebone "base" "" 0.008779 1.770679 -0.936522 0 0 0 0 0 0 0 0 0
$definebone "flip" "base" 0.108669 -2.432133 -0.071752 -89.999982 -179.999964 0 0 0 0 0 0 0
$definebone "pusher" "flip" 0.936885 0.828433 -0.108668 -0 0.000057 0 0 0 0 0 0 0
$definebone "loader" "flip" -4.580906 -6.735054 0.906216 -89.999982 -179.999841 0 0 0 0 0 0 0
$definebone "hammer" "base" -0.410086 -0.310845 0.591224 -0 -89.999982 0 0 0 0 0 0 0
$definebone "muzzle" "base" 0 -6.608323 1.193437 -89.999982 179.999964 0 0 0 0 0 0 0
$definebone "trigger" "base" 0.155943 -0.994107 -0.321766 -89.999921 89.999982 0 0 0 0 0 0 0
$definebone "4" "" 0.008779 0.335253 -0.483823 -89.999982 -179.999964 0 0 0 0 0 0 0
$definebone "4tip" "4" 0.084945 0.588403 0 -0 0.000057 0 0 0 0 0 0 0
$definebone "1" "" 0.008779 0.335253 0.331036 -89.999982 -179.999964 0 0 0 0 0 0 0
$definebone "1tip" "1" -0.253313 0.588403 0 -0 0.000057 0 0 0 0 0 0 0
$definebone "5" "" -0.342842 0.335253 -0.282213 0 0 -179.999909 0 0 0 0 0 0
$definebone "5tip" "5" 0.145963 0.588404 -0.001254 0.000057 -179.999978 -179.999964 0 0 0 0 0 0
$definebone "2" "" 0.3604 0.335253 0.129425 0.000057 0 -179.999841 0 0 0 0 0 0
$definebone "2tip" "2" -0.145962 0.588403 0.169621 0.000057 -179.999978 -179.999964 0 0 0 0 0 0
$definebone "6" "" -0.343223 0.335253 0.128772 0 0 -179.999964 0 0 0 0 0 0
$definebone "6tip" "6" 0.146121 0.588403 0.169352 0.000057 -179.999978 179.999964 0 0 0 0 0 0
$definebone "3" "" 0.360781 0.335253 -0.28156 0 0 -179.999964 0 0 0 0 0 0
$definebone "3tip" "3" -0.146121 0.588403 -0.000983 0.000057 -179.999978 -179.999978 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "" 1.508079 0.000000 -8.194570 91.480562 -73.711880 168.619302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" -1.508079 0.000000 -8.194570 -95.596576 73.712052 168.618786 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853649 0.000000 0.000000 -90.505158 2.738853 -33.527943 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_UpperArm" 10.390505 -0.000001 -0.000055 0.000344 -6.121424 0.030195 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390505 -0.000001 -0.000055 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525411 -0.000607 -0.000010 90.136746 -6.108475 2.532072 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "" 7.341143 -11.595627 -8.584749 -3.457915 -91.139763 -79.654779 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "" 7.316963 -12.81109 -8.511314 -3.456884 -91.139483 -80.261246 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "" 7.292786 -14.026556 -8.437876 -3.456597 -91.139538 -80.867896 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "" 7.268604 -15.24202 -8.364442 -3.456826 -91.139879 -81.474028 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "" 7.244421 -16.457479 -8.291 -3.456425 -91.139763 -83.352582 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "" 7.220244 -17.672949 -8.217566 -3.456769 -91.139879 -87.393712 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.433310 0.688199 -0.697962 -70.054232 -38.916038 -45.195999 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556974 -0.000010 0.000001 0.000000 0.000000 13.093403 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.221089 -0.000002 0.000000 0.000000 0.000000 20.790347 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.566481 0.028852 -1.094442 20.308432 -2.449395 -30.465197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382511 -0.000008 -0.000000 0.000000 0.233423 -20.798884 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865908 -0.000004 -0.000000 0.000000 0.148740 -13.999135 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.564030 -0.012874 -0.297896 4.921822 1.250767 -33.682298 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445751 -0.000013 0.000002 0.000000 0.316044 -20.997643 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053745 -0.000005 0.000000 0.000000 0.176700 -12.398807 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.346977 -0.023844 0.546131 -8.696353 4.194395 -46.466018 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439793 0.000005 0.000003 0.000000 0.000000 -14.197722 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.982988 -0.000008 -0.000003 -0.000000 0.000000 -24.683136 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.037622 -0.091710 1.293838 -26.822045 8.682201 -50.431573 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104668 -0.000010 -0.000001 0.000000 0.000000 -25.194100 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908443 0.000003 -0.000009 0.000000 0.000000 -13.997302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853650 -0.000014 0.000007 93.935227 -0.462090 -33.623799 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_UpperArm" 10.390506 0.000009 -0.000042 0.000458 -6.119875 0.152062 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.390506 0.000009 -0.000042 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525418 -0.000586 0.000004 -89.664285 6.108074 2.532072 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.378057 0.533960 0.718029 70.000030 38.596442 -45.467524 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556977 0.000017 0.000002 0.000000 -0.000000 13.000011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.221090 -0.000002 -0.000003 0.000000 0.000000 20.792925 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.589037 -0.111526 1.117205 -20.306713 2.209726 -30.481412 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382523 0.000010 -0.000001 0.000000 -0.378897 -20.796649 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.865911 0.000017 0.000004 0.000000 -0.241273 -13.998046 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.551071 0.004457 0.299675 -4.921994 -1.512838 -33.672443 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445763 -0.000006 0.000003 0.000000 -0.456877 -20.995236 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053757 0.000010 -0.000002 0.000000 -0.255596 -12.397432 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.083281 -0.085196 -1.332310 26.713355 -9.056515 -50.352963 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104664 -0.000002 0.000006 0.000000 0.000000 -25.191350 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908430 0.000013 0.000004 -0.000000 0.000000 -13.995697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.385414 -0.066617 -0.421817 8.598836 -4.537310 -46.421327 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439795 -0.000009 0.000009 0.000000 0.000000 -14.196233 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.982986 0.000008 0.000005 0.000000 0.000000 -24.680787 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "" -7.341264 -11.595633 -8.584687 -3.456083 -88.859163 -100.074928 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "" -7.31706 -12.811097 -8.511278 -3.454764 -88.858992 -99.358557 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "" -7.292856 -14.026567 -8.437872 -3.455852 -88.859395 -98.64121 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "" -7.268649 -15.242027 -8.36446 -3.455967 -88.859334 -97.925016 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "" -7.244441 -16.457489 -8.291046 -3.454133 -88.85962 -96.078837 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "" -7.220239 -17.672956 -8.217644 -3.45654 -88.859286 -92.312554 0 0 0 0 0 0

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
	"magnum44_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 10
	fadeout 71
	fps 30
	loop
}

$sequence "fire" {
	"magnum44_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 30
	snap
	fps 30
}

$sequence "reload" {
	"magnum44_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 8 "bf3_magnum44.open" }
	{ event 5004 40 "bf3_magnum44.shellin" }
	{ event 5004 56 "bf3_magnum44.close" }
	fadein 0.2
	fadeout 17
	snap
	fps 30
}

$sequence "draw" {
	"magnum44_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 30
	snap
	fps 30
}

$sequence "fire_empty" {
	"magnum44_anims/fire_empty.smd"
	activity "ACT_VM_DRYFIRE" 1
	{ event 5004 0 "bf3.empty" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 120
}

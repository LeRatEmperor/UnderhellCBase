// 

$modelname "weapons/c_magnum44.mdl"

$bodygroup "magnum44"
{
	studio "magnum44.smd"
}
// REMOVED: hands bodygroup


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
$definebone "L Clavicle" "" 1.508079 0 -8.19457 0 0 0 0 0 0 0 0 0
$definebone "R Clavicle" "" -1.508079 0 -8.19457 0 -179.999568 -179.999978 0 0 0 0 0 0
$definebone "L UpperArm" "L Clavicle" 5.853649 0 0 2.561981 -89.979123 -79.086863 0 0 0 0 0 0
$definebone "L ForeTwist" "L UpperArm" 10.390505 -0.000001 -0.000055 0.000344 -6.121424 0.030195 0 0 0 0 0 0
$definebone "L Forearm" "L UpperArm" 10.390505 -0.000001 -0.000055 0.000172 -6.129903 0.000576 0 0 0 0 0 0
$definebone "L Hand" "L Forearm" 8.525411 -0.000607 -0.00001 2.79867 3.31479 -102.516358 0 0 0 0 0 0
$definebone "L ForeTwist1" "" 7.341143 -11.595627 -8.584749 -3.457915 -91.139763 -79.654779 0 0 0 0 0 0
$definebone "L ForeTwist2" "" 7.316963 -12.81109 -8.511314 -3.456884 -91.139483 -80.261246 0 0 0 0 0 0
$definebone "L ForeTwist3" "" 7.292786 -14.026556 -8.437876 -3.456597 -91.139538 -80.867896 0 0 0 0 0 0
$definebone "L ForeTwist4" "" 7.268604 -15.24202 -8.364442 -3.456826 -91.139879 -81.474028 0 0 0 0 0 0
$definebone "L ForeTwist5" "" 7.244421 -16.457479 -8.291 -3.456425 -91.139763 -83.352582 0 0 0 0 0 0
$definebone "L ForeTwist6" "" 7.220244 -17.672949 -8.217566 -3.456769 -91.139879 -87.393712 0 0 0 0 0 0
$definebone "L Finger0" "L Hand" 0.43331 0.688199 -0.697962 37.481414 29.181444 108.468247 0 0 0 0 0 0
$definebone "L Finger01" "L Finger0" 1.556974 -0.00001 0.000001 1.972991 19.17592 0.000167 0 0 0 0 0 0
$definebone "L Finger02" "L Finger01" 1.221089 -0.000002 0 -0.000051 13.764278 0.000171 0 0 0 0 0 0
$definebone "L Finger1" "L Hand" 2.566481 0.028852 -1.094442 1.554779 -6.16331 6.984988 0 0 0 0 0 0
$definebone "L Finger11" "L Finger1" 1.382511 -0.000008 -0 0.000058 27.326882 0.000113 0 0 0 0 0 0
$definebone "L Finger12" "L Finger11" 0.865908 -0.000004 -0 -0.000114 1.67688 -0.00023 0 0 0 0 0 0
$definebone "L Finger2" "L Hand" 2.56403 -0.012874 -0.297896 -0.52334 -4.899996 4.980894 0 0 0 0 0 0
$definebone "L Finger21" "L Finger2" 1.445751 -0.000013 0.000002 -0.000001 22.035792 -0.000115 0 0 0 0 0 0
$definebone "L Finger22" "L Finger21" 1.053745 -0.000005 0 0.000056 18.040676 0.000114 0 0 0 0 0 0
$definebone "L Finger3" "L Hand" 2.346977 -0.023844 0.546131 -0.737741 -0.865911 7.439457 0 0 0 0 0 0
$definebone "L Finger31" "L Finger3" 1.439793 0.000005 0.000003 -0.00023 14.981711 -0.000288 0 0 0 0 0 0
$definebone "L Finger32" "L Finger31" 0.982988 -0.000008 -0.000003 0 18.49716 0.000169 0 0 0 0 0 0
$definebone "L Finger4" "L Hand" 2.037622 -0.09171 1.293838 -1.707988 1.788203 4.969953 0 0 0 0 0 0
$definebone "L Finger41" "L Finger4" 1.104668 -0.00001 -0.000001 -0.000229 11.36073 -0.000173 0 0 0 0 0 0
$definebone "L Finger42" "L Finger41" 0.908443 0.000003 -0.000009 0 14.730876 0.00017 0 0 0 0 0 0
$definebone "R UpperArm" "R Clavicle" 5.85365 -0.000014 0.000007 -2.564158 -89.977463 79.065088 0 0 0 0 0 0
$definebone "R ForeTwist" "R UpperArm" 10.390506 0.000009 -0.000042 0.000458 -6.119875 0.152062 0 0 0 0 0 0
$definebone "R Forearm" "R UpperArm" 10.390506 0.000009 -0.000042 0.000057 -6.130418 -0.000342 0 0 0 0 0 0
$definebone "R Hand" "R Forearm" 8.525418 -0.000586 0.000004 -2.798441 3.312154 102.537846 0 0 0 0 0 0
$definebone "R Finger0" "R Hand" 0.378057 0.53396 0.718029 -34.248256 32.858555 -114.544117 0 0 0 0 0 0
$definebone "R Finger01" "R Finger0" 1.556977 0.000017 0.000002 -0.000294 16.81145 -0.000063 0 0 0 0 0 0
$definebone "R Finger02" "R Finger01" 1.22109 -0.000002 -0.000003 0.000113 13.764514 0.000165 0 0 0 0 0 0
$definebone "R Finger1" "R Hand" 2.589037 -0.111526 1.117205 -0.973341 -1.452333 -7.088867 0 0 0 0 0 0
$definebone "R Finger11" "R Finger1" 1.382523 0.00001 -0.000001 0.000058 23.616117 -0.000002 0 0 0 0 0 0
$definebone "R Finger12" "R Finger11" 0.865911 0.000017 0.000004 -0.000114 1.677338 -0.000174 0 0 0 0 0 0
$definebone "R Finger2" "R Hand" 2.551071 0.004457 0.299675 0.696774 -2.903578 -4.959355 0 0 0 0 0 0
$definebone "R Finger21" "R Finger2" 1.445763 -0.000006 0.000003 -0.000114 16.623337 -0.000232 0 0 0 0 0 0
$definebone "R Finger22" "R Finger21" 1.053757 0.00001 -0.000002 0.000117 20.194588 0.000169 0 0 0 0 0 0
$definebone "R Finger4" "R Hand" 2.083281 -0.085196 -1.33231 1.181037 -4.176061 -5.120357 0 0 0 0 0 0
$definebone "R Finger41" "R Finger4" 1.104664 -0.000002 0.000006 0.000116 19.934633 0.000112 0 0 0 0 0 0
$definebone "R Finger42" "R Finger41" 0.90843 0.000013 0.000004 -0.000114 15.49994 -0.000518 0 0 0 0 0 0
$definebone "R Finger3" "R Hand" 2.385414 -0.066617 -0.421817 2.692556 -2.257052 -7.394883 0 0 0 0 0 0
$definebone "R Finger31" "R Finger3" 1.439795 -0.000009 0.000009 0.000001 18.222861 -0.000176 0 0 0 0 0 0
$definebone "R Finger32" "R Finger31" 0.982986 0.000008 0.000005 0.000003 19.578018 -0.000232 0 0 0 0 0 0
$definebone "R ForeTwist1" "" -7.341264 -11.595633 -8.584687 -3.456083 -88.859163 -100.074928 0 0 0 0 0 0
$definebone "R ForeTwist2" "" -7.31706 -12.811097 -8.511278 -3.454764 -88.858992 -99.358557 0 0 0 0 0 0
$definebone "R ForeTwist3" "" -7.292856 -14.026567 -8.437872 -3.455852 -88.859395 -98.64121 0 0 0 0 0 0
$definebone "R ForeTwist4" "" -7.268649 -15.242027 -8.36446 -3.455967 -88.859334 -97.925016 0 0 0 0 0 0
$definebone "R ForeTwist5" "" -7.244441 -16.457489 -8.291046 -3.454133 -88.85962 -96.078837 0 0 0 0 0 0
$definebone "R ForeTwist6" "" -7.220239 -17.672956 -8.217644 -3.45654 -88.859286 -92.312554 0 0 0 0 0 0


$include "c_arms_definebones.qci"

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

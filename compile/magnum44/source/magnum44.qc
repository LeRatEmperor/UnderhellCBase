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
$definebone "anim_ValveBiped.Bip01_L_Clavicle" "" 1.508079 0 -8.19457 0 0 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Clavicle" "" -1.508079 0 -8.19457 0 -179.999568 -179.999978 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_UpperArm" "anim_ValveBiped.Bip01_L_Clavicle" 5.853649 0 0 2.561981 -89.979123 -79.086863 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Forearm" "anim_ValveBiped.Bip01_L_UpperArm" 10.390505 -0.000001 -0.000055 0.000172 -6.129903 0.000576 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Hand" "anim_ValveBiped.Bip01_L_Forearm" 8.525411 -0.000607 -0.00001 2.79867 3.31479 -102.516358 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger0" "anim_ValveBiped.Bip01_L_Hand" 0.43331 0.688199 -0.697962 37.481414 29.181444 108.468247 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger01" "anim_ValveBiped.Bip01_L_Finger0" 1.556974 -0.00001 0.000001 1.972991 19.17592 0.000167 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger02" "anim_ValveBiped.Bip01_L_Finger01" 1.221089 -0.000002 0 -0.000051 13.764278 0.000171 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger1" "anim_ValveBiped.Bip01_L_Hand" 2.566481 0.028852 -1.094442 1.554779 -6.16331 6.984988 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger11" "anim_ValveBiped.Bip01_L_Finger1" 1.382511 -0.000008 -0 0.000058 27.326882 0.000113 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger12" "anim_ValveBiped.Bip01_L_Finger11" 0.865908 -0.000004 -0 -0.000114 1.67688 -0.00023 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger2" "anim_ValveBiped.Bip01_L_Hand" 2.56403 -0.012874 -0.297896 -0.52334 -4.899996 4.980894 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger21" "anim_ValveBiped.Bip01_L_Finger2" 1.445751 -0.000013 0.000002 -0.000001 22.035792 -0.000115 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger22" "anim_ValveBiped.Bip01_L_Finger21" 1.053745 -0.000005 0 0.000056 18.040676 0.000114 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger3" "anim_ValveBiped.Bip01_L_Hand" 2.346977 -0.023844 0.546131 -0.737741 -0.865911 7.439457 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger31" "anim_ValveBiped.Bip01_L_Finger3" 1.439793 0.000005 0.000003 -0.00023 14.981711 -0.000288 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger32" "anim_ValveBiped.Bip01_L_Finger31" 0.982988 -0.000008 -0.000003 0 18.49716 0.000169 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger4" "anim_ValveBiped.Bip01_L_Hand" 2.037622 -0.09171 1.293838 -1.707988 1.788203 4.969953 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger41" "anim_ValveBiped.Bip01_L_Finger4" 1.104668 -0.00001 -0.000001 -0.000229 11.36073 -0.000173 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger42" "anim_ValveBiped.Bip01_L_Finger41" 0.908443 0.000003 -0.000009 0 14.730876 0.00017 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_UpperArm" "anim_ValveBiped.Bip01_R_Clavicle" 5.85365 -0.000014 0.000007 -2.564158 -89.977463 79.065088 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Forearm" "anim_ValveBiped.Bip01_R_UpperArm" 10.390506 0.000009 -0.000042 0.000057 -6.130418 -0.000342 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Hand" "anim_ValveBiped.Bip01_R_Forearm" 8.525418 -0.000586 0.000004 -2.798441 3.312154 102.537846 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger0" "anim_ValveBiped.Bip01_R_Hand" 0.378057 0.53396 0.718029 -34.248256 32.858555 -114.544117 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger01" "anim_ValveBiped.Bip01_R_Finger0" 1.556977 0.000017 0.000002 -0.000294 16.81145 -0.000063 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger02" "anim_ValveBiped.Bip01_R_Finger01" 1.22109 -0.000002 -0.000003 0.000113 13.764514 0.000165 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger1" "anim_ValveBiped.Bip01_R_Hand" 2.589037 -0.111526 1.117205 -0.973341 -1.452333 -7.088867 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger11" "anim_ValveBiped.Bip01_R_Finger1" 1.382523 0.00001 -0.000001 0.000058 23.616117 -0.000002 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger12" "anim_ValveBiped.Bip01_R_Finger11" 0.865911 0.000017 0.000004 -0.000114 1.677338 -0.000174 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger2" "anim_ValveBiped.Bip01_R_Hand" 2.551071 0.004457 0.299675 0.696774 -2.903578 -4.959355 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger21" "anim_ValveBiped.Bip01_R_Finger2" 1.445763 -0.000006 0.000003 -0.000114 16.623337 -0.000232 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger22" "anim_ValveBiped.Bip01_R_Finger21" 1.053757 0.00001 -0.000002 0.000117 20.194588 0.000169 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger4" "anim_ValveBiped.Bip01_R_Hand" 2.083281 -0.085196 -1.33231 1.181037 -4.176061 -5.120357 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger41" "anim_ValveBiped.Bip01_R_Finger4" 1.104664 -0.000002 0.000006 0.000116 19.934633 0.000112 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger42" "anim_ValveBiped.Bip01_R_Finger41" 0.90843 0.000013 0.000004 -0.000114 15.49994 -0.000518 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger3" "anim_ValveBiped.Bip01_R_Hand" 2.385414 -0.066617 -0.421817 2.692556 -2.257052 -7.394883 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger31" "anim_ValveBiped.Bip01_R_Finger3" 1.439795 -0.000009 0.000009 0.000001 18.222861 -0.000176 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger32" "anim_ValveBiped.Bip01_R_Finger31" 0.982986 0.000008 0.000005 0.000003 19.578018 -0.000232 0 0 0 0 0 0

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -90.000153 -79.749996 -89.999924 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 0.429586 1.989521 68.369525 90.302601 16.284888 -0.330433 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" -4.934628 -65.253290 12.950855 -2.042111 -29.247910 90.827356 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" -9.505369 -56.389671 18.664305 -0.102361 -29.312083 92.992112 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" -22.365221 -12.864653 -49.197897 -88.653734 -42.072885 -95.237296 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 8.677867 -50.123910 18.577214 -4.549219 -3.334617 95.122755 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" -9.942184 -47.948416 18.350051 -7.158963 -2.251551 89.085230 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" -21.945323 -42.748656 18.397620 -7.490692 0.428276 95.942408 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" -20.790457 -23.681046 -43.414867 -70.229631 -79.590827 -86.901366 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" -30.697120 -11.142798 -41.723744 71.112877 -78.396992 103.813768 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" -31.922164 -9.998007 -40.646529 80.910461 -64.724565 91.904011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" -23.748432 -21.711625 -44.322709 -74.876520 -80.588831 -99.664526 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" -31.647380 -10.912225 -42.626302 76.877678 -77.780410 86.129006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" -34.377312 -0.011102 -41.444550 82.948372 -65.524160 61.749701 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" -25.775181 -22.061786 -44.333278 42.239629 -82.240744 125.841737 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" -32.067264 -14.082133 -42.808226 73.198226 -69.771309 79.180915 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" -35.607981 -2.508652 -41.685682 81.788320 -45.590489 50.750691 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" -27.730236 -18.644600 -45.571019 15.341249 -78.582339 132.268109 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" -32.076276 -12.376152 -44.284337 67.664945 -59.844990 66.100688 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" -34.818806 -3.295959 -43.653660 73.867651 -46.602510 43.681526 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 0.429511 1.989477 -68.369539 -94.418118 -16.284659 -0.329981 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" -4.937164 -65.248228 -12.975614 2.040958 29.226425 90.824351 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" -9.507576 -56.382894 -18.684946 0.102665 29.290819 92.990334 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" -22.365374 -12.864598 49.198627 89.126621 42.073103 -95.236864 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 5.698648 -48.918552 -22.334074 8.584494 -0.860144 93.268880 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" -9.764759 -46.285895 -22.307206 8.176269 -2.762851 89.324499 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" -21.382567 -41.175318 -22.248944 6.673981 -5.479373 96.230685 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" -22.704745 -21.738333 43.410861 70.638891 79.590581 -91.646816 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" -30.911114 -10.549183 41.719697 -70.728918 78.397451 102.780454 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" -32.114703 -9.397636 40.642536 -80.538368 64.724489 90.869661 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" -24.479232 -20.884171 44.320588 75.270498 80.588404 -101.667382 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" -30.949188 -12.842515 42.624168 -76.509900 77.780450 89.538477 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" -34.378747 -0.765714 41.442320 -82.590007 65.524403 63.004461 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" -26.992815 -22.457215 43.273080 -56.383409 83.376921 112.706893 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" -34.043201 -12.262799 41.744208 -79.262028 69.956962 71.145537 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" -36.855471 0.504104 40.620337 -84.774430 45.480416 45.197051 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" -25.680751 -21.447669 45.608337 -14.992202 78.595637 138.404862 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" -32.616836 -10.801899 44.321638 -67.605561 59.911691 63.373270 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" -34.947294 -1.179050 43.690601 -73.836687 46.674019 40.156481 0 0 0 0 0 0
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

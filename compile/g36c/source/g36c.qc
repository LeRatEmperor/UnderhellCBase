// 

$modelname "weapons/c_g36c.mdl"

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
$bodygroup "g36c"
{
	studio "g36c.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition -15.245 29.189 -4.52

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
		"g36c"
		"muzzle"
		"suppressor"
		"grip"
		"laser"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 0 0
$attachment "muzzle_supp" "A_Muzzle_Supp" 0 0 0 rotate -0 0 0
$attachment "2" "A_Eject" 0 0 -0 rotate 0 -0 0
$attachment "Suppressor" "A_Suppressor" 0 0 0 rotate -0 -0 -0
$attachment "Laser" "A_Underbarrel" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate 0 0 0
$attachment "Foregrip" "A_Foregrip" -0 0 0 rotate -0 -0 0

$cbox 0 0 0 0 0 0

$bbox -37.732 2.803 -12.341 29.336 73.652 3.147

$definebone "anim_ValveBiped.Bip01_L_Clavicle" "" -27.570877 67.798546 -8.338637 6.954563 -0.565452 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_UpperArm" "anim_ValveBiped.Bip01_L_Clavicle" 5.853643 -0.000023 -0.000001 19.546799 -97.615103 -38.683818 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Forearm" "anim_ValveBiped.Bip01_L_UpperArm" 10.39053 0.000044 0.000011 -0.000861 -95.228396 -0.00011 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Hand" "anim_ValveBiped.Bip01_L_Forearm" 8.525422 0.000004 -0.000061 -19.96959 70.637967 -133.37712 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger0" "anim_ValveBiped.Bip01_L_Hand" 0.555138 0.315182 -0.822497 33.221524 -3.239227 97.515362 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger01" "anim_ValveBiped.Bip01_L_Finger0" 1.556969 0.000011 -0.000008 -2.834376 12.556429 -5.300202 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger02" "anim_ValveBiped.Bip01_L_Finger01" 1.221096 -0.000004 0 0.813881 59.418247 1.803604 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger1" "anim_ValveBiped.Bip01_L_Hand" 2.828079 -0.209492 -1.286466 -19.506004 46.726608 -10.26866 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger11" "anim_ValveBiped.Bip01_L_Finger1" 1.382514 0.000008 -0.000002 2.683671 51.670719 -0.240811 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger12" "anim_ValveBiped.Bip01_L_Finger11" 0.865917 0.000011 0.000003 -0.000004 66.711755 -0.000118 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger2" "anim_ValveBiped.Bip01_L_Hand" 2.813034 -0.266285 -0.544267 -14.897416 57.255973 -15.045122 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger21" "anim_ValveBiped.Bip01_L_Finger2" 1.445755 -0.000008 0.000002 -0.000009 70.987795 -0.000055 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger22" "anim_ValveBiped.Bip01_L_Finger21" 1.053734 0.000002 0.000003 -0.000123 44.019603 0.00011 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger3" "anim_ValveBiped.Bip01_L_Hand" 2.689438 -0.342869 0.236182 -11.272716 57.925298 -17.370013 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger31" "anim_ValveBiped.Bip01_L_Finger3" 1.439797 -0.000004 -0.000003 0.000044 67.471559 -0.000112 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger32" "anim_ValveBiped.Bip01_L_Finger31" 0.982979 -0.000004 0.000002 -0.000182 50.926819 0.000106 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger4" "anim_ValveBiped.Bip01_L_Hand" 2.426952 -0.353611 1.013784 -7.401184 59.206887 -26.365106 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger41" "anim_ValveBiped.Bip01_L_Finger4" 1.104669 0.000011 0.000004 -0.000067 28.815936 0.000176 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger42" "anim_ValveBiped.Bip01_L_Finger41" 0.908451 0 -0.000006 0.00011 77.838038 0.000107 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Clavicle" "" -30.58704 67.798538 -8.338637 0.218397 90.000016 -180.000005 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_UpperArm" "anim_ValveBiped.Bip01_R_Clavicle" 5.853676 -0.000019 -0.000002 -17.29525 -133.932947 37.453103 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Forearm" "anim_ValveBiped.Bip01_R_UpperArm" 10.390526 0.000122 -0.000004 0.000063 -115.585816 0.000746 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Hand" "anim_ValveBiped.Bip01_R_Forearm" 8.525414 0.000088 0.00005 -22.35705 70.598475 142.663677 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger0" "anim_ValveBiped.Bip01_R_Hand" 0.555141 0.315166 0.822495 -8.796623 48.349335 -119.379303 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger01" "anim_ValveBiped.Bip01_R_Finger0" 1.556969 -0.00001 0 28.598388 16.125259 5.747523 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger02" "anim_ValveBiped.Bip01_R_Finger01" 1.2211 -0.000002 -0.000013 -5.455195 71.314401 10.120264 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger1" "anim_ValveBiped.Bip01_R_Hand" 2.828098 -0.20948 1.286459 0.002349 -4.358314 -1.334936 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger11" "anim_ValveBiped.Bip01_R_Finger1" 1.382526 0.000008 -0.000004 0.000001 39.23123 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger12" "anim_ValveBiped.Bip01_R_Finger11" 0.865906 0.000003 -0.000003 1.268933 55.22362 0.424618 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger2" "anim_ValveBiped.Bip01_R_Hand" 2.813026 -0.266277 0.544263 27.061898 58.488904 38.620564 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger21" "anim_ValveBiped.Bip01_R_Finger2" 1.445763 -0.000002 -0.000008 19.550631 70.18824 -12.744111 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger22" "anim_ValveBiped.Bip01_R_Finger21" 1.053739 0.000015 -0.000008 8.337385 67.542634 -9.492363 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger3" "anim_ValveBiped.Bip01_R_Hand" 2.689442 -0.342855 -0.236189 16.749794 62.072069 16.085099 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger31" "anim_ValveBiped.Bip01_R_Finger3" 1.439804 -0.000002 -0.000004 0.075798 56.536829 0.324989 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger32" "anim_ValveBiped.Bip01_R_Finger31" 0.98299 0.000008 0 1.755019 80.244484 -1.377279 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger4" "anim_ValveBiped.Bip01_R_Hand" 2.426968 -0.353603 -1.013785 13.627752 54.920472 21.573458 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger41" "anim_ValveBiped.Bip01_R_Finger4" 1.104668 0.000004 -0.000015 1.690345 31.501044 -0.281551 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger42" "anim_ValveBiped.Bip01_R_Finger41" 0.908447 -0.000011 0.000004 -3.114536 78.89738 -3.947216 0 0 0 0 0 0
$definebone "acr_main" "" -31.07818 57.51207 -3.295033 0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "acr_bolt_release" "acr_main" -0.384193 -2.067762 -0.000006 -0 0 0 0 0 0 0 0 0
$definebone "acr_trigger" "acr_main" -1.921764 -0.937333 -0.00001 -0 0 0 0 0 0 0 0 0
$definebone "A_Optic" "acr_main" -0.028477 2.424619 0.000006 -89.999982 179.999978 0 0 0 0 0 0 0
$definebone "A_Foregrip" "acr_main" 5.834476 -0.939685 0.00001 89.999921 91.548236 0 0 0 0 0 0 0
$definebone "A_Muzzle" "acr_main" 11.438957 0.366893 0.000027 -0 0 0 0 0 0 0 0 0
$definebone "A_Suppressor" "acr_main" 9.623878 0.333447 0.000021 -89.999873 -92.292392 0 0 0 0 0 0 0
$definebone "A_Underbarrel" "acr_main" 7.941658 0.426127 -0.873259 0.002905 179.601272 90.398681 0 0 0 0 0 0
$definebone "A_Eject" "acr_main" 0.493866 0.303905 0.7143 -79.035746 -25.957453 -61.870845 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "acr_main" 16.05632 0.366893 0.000038 -0 0 0 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "acr_main" 7.943981 -0.111292 -0.758898 0.002636 0.398779 -90.398763 0 0 0 0 0 0
$definebone "Magazine" "" -31.065052 56.315331 -5.005428 0 -52.999741 0 0 0 0 0 0 0
$definebone "bullet" "" -31.08181 56.510086 -4.993142 0 -52.999741 0 0 0 0 0 0 0
$definebone "bullet2" "" -30.914131 56.510086 -5.122903 0 -52.999741 0 0 0 0 0 0 0
$definebone "G36_Bolt" "" -31.080494 54.8899 -1.994407 0 -52.999741 0 0 0 0 0 0 0
$definebone "G36_Bolt_End" "" -31.080494 54.628365 -1.994407 0 -52.999741 0 0 0 0 0 0 0

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -90.000153 -79.749996 -89.999924 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 21.638912 -65.514605 71.660925 90.273763 9.330383 0.228614 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 34.809023 -31.014540 87.086179 -20.233553 5.145123 85.046582 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 17.016361 27.087074 86.037394 -20.491382 3.940328 177.021900 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 52.741786 -60.210187 -40.439176 -73.960807 -35.817744 -113.979198 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 68.429756 6.315148 57.793833 15.825657 -3.530845 98.368342 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 69.558325 -11.601587 53.689067 16.716252 -12.643346 98.276304 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 24.928029 -62.254267 56.300099 9.498675 -16.557261 60.274081 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" -23.247898 -72.873932 -44.172606 -106.365915 -76.392447 -112.266379 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" -70.760804 -25.792345 -45.973706 127.132115 -83.698667 -36.633691 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" -52.036966 55.476590 -44.880579 101.095915 -70.637115 -76.814330 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" -35.120704 -65.054956 -47.981424 -110.412343 -78.440368 -134.515365 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" -73.729391 13.527236 -46.296715 110.147631 -79.211593 -65.298399 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" -44.451532 61.480899 -45.108942 99.151707 -67.202182 -97.878149 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" -34.462840 -61.212660 -53.084843 -159.838625 -86.741089 -99.376206 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" -70.382440 9.689955 -51.548291 103.293109 -76.579445 -69.598875 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" -37.600960 61.272373 -50.384648 94.987991 -52.138250 -111.524947 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" -33.847173 -49.802424 -64.064829 -175.883140 -83.366222 -103.531310 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" -54.730696 -26.901089 -62.760921 105.505165 -64.467882 -52.256750 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" -38.221493 48.482363 -62.102952 100.507307 -50.813405 -124.221388 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" -66.069734 28.649414 -68.262234 -94.645617 -16.285776 -90.266586 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 12.151129 -98.427337 -17.198486 -16.909595 -10.524532 49.607930 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 76.901161 47.032660 -15.063293 -16.263192 -11.511983 161.816243 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 56.954027 7.329584 52.421966 96.362437 42.637137 -89.865170 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 50.562072 -19.033571 -55.226808 32.733066 5.957363 73.507048 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 64.058775 -33.066122 -25.003173 4.380399 -5.764682 71.531110 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" -12.310929 -73.209091 -11.128659 -5.443394 1.777749 20.961735 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 54.952394 7.772127 48.717221 93.878663 73.171670 -66.083966 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 46.279230 -28.340160 47.071424 -100.536476 85.927293 60.487773 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 1.683450 -53.116609 46.418026 -93.873413 70.853018 12.176945 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 6.599814 2.200596 73.337263 166.055487 40.117285 -68.639913 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" -21.506428 -20.070105 66.214900 -149.371907 59.041880 -92.620719 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" -36.908733 2.822212 61.776475 -140.706767 63.797804 -148.252865 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 13.774332 -27.946116 66.704215 -151.897998 67.073797 -44.586592 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" -16.714544 -25.917151 65.412697 -130.397732 57.648212 -77.040516 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" -31.090388 11.273416 63.769053 -115.409254 38.911027 -137.451698 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 21.868529 -16.823242 68.370962 -145.798657 68.836620 -47.933266 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 7.015816 -25.990075 67.256308 -115.076294 48.270966 -45.197559 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" -20.938748 -16.050378 67.004063 -115.965320 37.316630 -120.168908 0 0 0 0 0 0
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




$sequence "base_idle" {
	"g36c_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "base_draw" {
	"g36c_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "base_fire" {
	"g36c_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "base_reload" {
	"g36c_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 25 "bf3_g36c.clipout" }
	{ event 5004 91 "bf3_g36c.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

$sequence "base_reloadempty" {
	"g36c_anims/base_reloadempty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 28 "bf3_g36c.clipout" }
	{ event 5004 84 "bf3_g36c.clipin" }
	{ event 5004 109 "bf3_g36c.boltpull" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

$sequence "foregrip_idle" {
	"g36c_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"g36c_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_fire" {
	"g36c_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_reload" {
	"g36c_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 25 "bf3_g36c.clipout" }
	{ event 5004 91 "bf3_g36c.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

$sequence "foregrip_reload_empty" {
	"g36c_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 28 "bf3_g36c.clipout" }
	{ event 5004 84 "bf3_g36c.clipin" }
	{ event 5004 109 "bf3_g36c.boltpull" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

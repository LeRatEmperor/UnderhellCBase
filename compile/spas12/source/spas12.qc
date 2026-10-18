// 

$modelname "weapons/c_spas12.mdl"

$bodygroup "870mcs"
{
	studio "870mcs.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition -3.27 -6.451 -11.676

$cdmaterials "models\bf3\weapons\shotguns\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"shell"
		"spas12"
	}
}

$attachment "muzzle" "A_Muzzle" 0 0 0 rotate -0 -0 0
$attachment "muzzle_supp" "A_Muzzle_Supp" 0 0 0 rotate -0 -0 0
$attachment "2" "A_Eject" 0 0 0 rotate 0 -0 0
$attachment "muzzle_ads" "A_Muzzle_Ironsight" 0 0 0 rotate 0 0 0
$attachment "Suppressor" "A_Suppressor" 0 0 0 rotate -0 0 0
$attachment "Laser" "A_Underbarrel" 0 0 0 rotate -0 -0 0
$attachment "Modkit" "A_Modkit" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" 0 0 0 rotate -0 0 0
$attachment "Foregrip" "A_Foregrip" 0 0 0 rotate -0 0 0

$cbox 0 0 0 0 0 0

$bbox -17.925 -15.376 -25.946 30.827 8.836 2.593

$definebone "anim_ValveBiped.Bip01_L_Clavicle" "" 3.491543 8.830969 -9.976974 0 0.000057 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_UpperArm" "anim_ValveBiped.Bip01_L_Clavicle" 5.853647 -0.000001 0 2.606709 -90.52118 -90.385901 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Forearm" "anim_ValveBiped.Bip01_L_UpperArm" 10.390535 -0.000002 0.000001 -0 -6.123426 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Hand" "anim_ValveBiped.Bip01_L_Forearm" 8.525425 -0.000002 0 2.753062 3.862882 -91.214711 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger0" "anim_ValveBiped.Bip01_L_Hand" 0.555143 0.315172 -0.822494 36.110722 33.914171 115.151566 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger01" "anim_ValveBiped.Bip01_L_Finger0" 1.556972 0.000002 -0.000002 -0.000005 9.52932 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger02" "anim_ValveBiped.Bip01_L_Finger01" 1.22109 -0.000002 0.000001 -0.000012 13.764626 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger1" "anim_ValveBiped.Bip01_L_Hand" 2.828093 -0.209482 -1.286462 1.166311 -3.007112 7.059473 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger11" "anim_ValveBiped.Bip01_L_Finger1" 1.382519 0.000001 0.000004 -0.000003 5.705115 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger12" "anim_ValveBiped.Bip01_L_Finger11" 0.865905 -0.000001 -0.000003 -0.000003 1.676707 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger2" "anim_ValveBiped.Bip01_L_Hand" 2.813033 -0.266274 -0.544265 -0.523171 -4.898962 4.980264 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger21" "anim_ValveBiped.Bip01_L_Finger2" 1.445751 0 0 -0.000003 8.18986 0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger22" "anim_ValveBiped.Bip01_L_Finger21" 1.053753 -0.000002 0.000002 -0.000003 -1.49399 0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger3" "anim_ValveBiped.Bip01_L_Hand" 2.689438 -0.34286 0.236189 -0.363545 -3.72474 7.4665 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger31" "anim_ValveBiped.Bip01_L_Finger3" 1.439796 -0.000002 -0.000001 -0.000003 3.307803 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger32" "anim_ValveBiped.Bip01_L_Finger31" 0.98299 0.000001 -0.000001 -0.000003 -5.220043 0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger4" "anim_ValveBiped.Bip01_L_Hand" 2.426952 -0.353602 1.013784 -0.774241 -8.678418 5.197188 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger41" "anim_ValveBiped.Bip01_L_Finger4" 1.104664 0.000001 0 -0.000003 4.531697 -0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_L_Finger42" "anim_ValveBiped.Bip01_L_Finger41" 0.908442 0.000001 -0.000001 -0.000003 -3.232686 -0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Clavicle" "" 0.47538 8.830965 -9.976974 -0.000019 -179.999937 180.000005 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_UpperArm" "anim_ValveBiped.Bip01_R_Clavicle" 5.853648 0.000001 0 -2.606709 -90.52118 90.385901 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Forearm" "anim_ValveBiped.Bip01_R_UpperArm" 10.390536 -0.000002 0 -0 -6.123426 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Hand" "anim_ValveBiped.Bip01_R_Forearm" 8.525427 0.000001 0 -2.753062 3.862882 91.214711 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger0" "anim_ValveBiped.Bip01_R_Hand" 0.55514 0.315171 0.822496 -36.110712 33.914171 -115.151566 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger01" "anim_ValveBiped.Bip01_R_Finger0" 1.556972 0 0 -0.000002 9.529332 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger02" "anim_ValveBiped.Bip01_R_Finger01" 1.221088 -0.000002 0 -0.000005 13.764635 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger1" "anim_ValveBiped.Bip01_R_Hand" 2.828091 -0.209481 1.286462 -1.166311 -3.007112 -7.059472 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger11" "anim_ValveBiped.Bip01_R_Finger1" 1.382519 0 -0.000002 0.000002 5.70511 0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger12" "anim_ValveBiped.Bip01_R_Finger11" 0.86591 -0 0.000003 0.000002 1.6767 0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger2" "anim_ValveBiped.Bip01_R_Hand" 2.813031 -0.266276 0.544264 0.523168 -4.89896 -4.980265 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger21" "anim_ValveBiped.Bip01_R_Finger2" 1.445755 -0 0 0.000001 8.18986 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger22" "anim_ValveBiped.Bip01_R_Finger21" 1.05375 -0 -0.000003 0.000002 -1.493987 -0.000003 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger3" "anim_ValveBiped.Bip01_R_Hand" 2.689442 -0.34286 -0.236188 0.363542 -3.72474 -7.4665 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger31" "anim_ValveBiped.Bip01_R_Finger3" 1.439795 -0 0.000001 0.000001 3.307801 0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger32" "anim_ValveBiped.Bip01_R_Finger31" 0.982989 0 0.000002 0.000001 -5.220044 -0.000001 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger4" "anim_ValveBiped.Bip01_R_Hand" 2.426953 -0.353604 -1.013783 0.774238 -8.678418 -5.197187 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger41" "anim_ValveBiped.Bip01_R_Finger4" 1.104666 0 0.000001 -0 4.531694 0 0 0 0 0 0 0
$definebone "anim_ValveBiped.Bip01_R_Finger42" "anim_ValveBiped.Bip01_R_Finger41" 0.908442 -0 0.000002 -0 -3.232686 0.000001 0 0 0 0 0 0
$definebone "(null)" "" 1.983461 8.830967 -25.945992 0 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Pelvis" "(null)" 0 0 0 -89.999982 -89.999921 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 3.24214 -0.005069 0.000005 -0.000057 0.045607 -0.000229 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 6.363438 -0.005069 0 -0 -0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine1" 6.363436 -0.002058 0 -0 -0 0 0 0 0 0 0 0
$definebone "Weapon" "" -2.006258 -11.175688 -2.336329 0 0 0 0 0 0 0 0 0
$definebone "Shell" "Weapon" -4.706641 10.038044 -6.763193 -0 0 0 0 0 0 0 0 0
$definebone "Trigger" "Weapon" -0.000262 4.94468 -0.918392 -0 0 0 0 0 0 0 0 0
$definebone "Pump" "Weapon" -0.000262 -5.844028 -0.621645 -0 0 0 0 0 0 0 0 0
$definebone "Bolt" "Pump" -0.301779 7.450962 0.930556 -0 0 0 0 0 0 0 0 0
$definebone "A_Foregrip" "Pump" 0.003436 -1.40336 -1.006513 -0 179.999964 0 0 0 0 0 0 0
$definebone "Shell_2" "Weapon" 0.004375 -0.547402 -0.651955 -0 0 0 0 0 0 0 0 0
$definebone "A_Modkit" "Weapon" -0.009132 1.080424 0.989291 -0 179.999964 -89.999982 0 0 0 0 0 0
$definebone "A_Optic" "Weapon" -0.005354 1.542797 1.321645 -0 179.999964 -89.999921 0 0 0 0 0 0
$definebone "A_Underbarrel" "Weapon" -1.232874 -15.750898 -0.527484 -0.000019 -90.000016 -90.000016 0 0 0 0 0 0
$definebone "A_Suppressor" "Weapon" 0.000793 -19.229965 0.464693 -0 179.999978 0 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "Weapon" -0.001309 -16.437506 -0.573479 0.000057 -89.999982 -89.999982 0 0 0 0 0 0
$definebone "A_Muzzle" "Weapon" 0.001232 -19.172737 0.469255 0.000019 -90.000016 90.000016 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "Weapon" 0.001232 -30.411051 0.469257 0.000019 -90.000016 90.000016 0 0 0 0 0 0
$definebone "A_Eject" "Weapon" -0.504499 1.405825 0.331594 6.464453 171.110118 -1.244636 0 0 0 0 0 0
$definebone "A_Muzzle_Ironsight" "Weapon" 2.006258 -19.597813 2.336333 -0.000057 -90.000098 0 0 0 0 0 0 0
$definebone "Shell_3" "Weapon" 0.004375 -0.547402 -0.651955 -0 0 0 0 0 0 0 0 0

$definebone "ValveBiped.Bip01_Spine4" "" 0.000000 0.000000 0.000000 -90.000153 -79.749996 -89.999924 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" -1.553885 -6.841447 70.151929 90.302601 16.284888 -0.330490 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 3.768504 -68.691984 -2.021465 -2.966598 -40.510277 91.363731 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" -0.415196 -60.192495 5.573837 -0.006283 -40.600064 92.935474 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" -13.446108 -11.335921 -50.988614 -88.653943 -42.073064 -95.235941 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 15.089064 -44.068816 23.953286 -8.209032 0.864402 95.337495 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 6.180481 -43.916190 23.926287 -7.804289 2.695993 98.779680 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" -5.527417 -42.633877 23.869513 -6.348862 5.285521 105.695985 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" -13.487806 -20.464282 -45.101335 -70.229630 -79.590558 -90.079307 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" -16.862303 -19.193767 -43.410209 71.112193 -78.397328 122.258263 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" -18.394745 -18.476420 -42.333013 80.910034 -64.724687 110.348395 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" -15.276756 -19.344958 -46.157119 -74.876987 -80.588384 -99.663880 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" -19.393935 -17.033138 -44.460690 76.876973 -77.780727 99.975807 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" -20.047540 -17.309638 -43.278904 82.948351 -65.524566 95.130484 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" -16.203779 -21.148685 -46.166788 42.239383 -82.241067 128.726247 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" -18.954879 -19.926084 -44.641789 73.197828 -69.771363 93.739454 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" -18.106704 -21.248810 -43.519254 81.788295 -45.590699 89.026062 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" -15.724839 -20.490296 -47.462246 15.341411 -78.582317 142.774771 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" -18.589670 -18.923486 -46.175656 67.664390 -59.844887 83.437014 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" -18.378686 -19.627127 -45.544997 73.867410 -46.602564 78.981093 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 2.412989 -6.841469 -70.151940 -94.418100 -16.284658 -0.330387 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 3.732469 -68.717099 -1.945175 2.966827 40.510489 91.363775 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" -0.448350 -60.221343 -9.540502 0.006490 40.600289 92.935504 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" -13.671626 -15.294958 51.099152 89.126555 42.073248 -95.236005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 13.218472 -44.084987 -27.451478 8.584307 -0.859943 95.321124 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 4.333533 -43.622490 -27.424617 8.175844 -2.762559 98.658882 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" -7.248915 -41.909451 -27.366445 6.673781 -5.479133 105.564952 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" -13.503070 -24.413234 44.724030 70.639031 79.590384 -90.079342 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" -17.270053 -23.121637 43.032900 -70.728135 78.397609 122.259562 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" -18.917257 -22.390685 41.955703 -80.538333 64.724846 110.348664 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" -15.164368 -23.303476 45.924166 75.270410 80.588202 -99.663757 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" -19.846603 -20.967291 44.227739 -76.509946 77.780849 99.975624 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" -20.397478 -21.254265 43.045957 -82.589702 65.524698 95.130504 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" -16.172338 -25.094747 45.761320 -41.915322 82.255964 128.820521 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" -19.151225 -23.867911 44.236259 -73.111848 69.808481 93.593464 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" -17.942451 -25.192706 43.113455 -81.755309 45.634721 88.823194 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" -15.351935 -24.432243 47.219769 -14.992158 78.595465 142.925849 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" -18.529624 -22.883278 45.933120 -67.604963 59.911549 83.297670 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" -18.094594 -23.578013 45.302026 -73.836908 46.674163 78.812829 0 0 0 0 0 0
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
	"spas12_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "draw" {
	"spas12_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

$sequence "fire1" {
	"spas12_anims/fire1.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event 5004 3 "bf3_870mcs.pump" }
	fadein 0.2
	fadeout 0.2
	fps 25
}

$sequence "fire2" {
	"spas12_anims/fire2.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event AE_CL_CREATE_PARTICLE_BRASS 4 "" }
	{ event 5004 3 "bf3_870mcs.pump" }
	fadein 0.2
	fadeout 0.2
	fps 25
}

$sequence "reload_insert" {
	"spas12_anims/reload_insert.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 5 "bf3.insert" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 50
}

$sequence "reload_start" {
	"spas12_anims/reload_start.smd"
	activity "ACT_SHOTGUN_RELOAD_START" 1
	fadein 0.2
	fadeout 0.2
	fps 50
}

$sequence "reload_end" {
	"spas12_anims/reload_end.smd"
	activity "ACT_SHOTGUN_RELOAD_FINISH" 1
	fadein 0.2
	fadeout 0.2
	fps 50
}

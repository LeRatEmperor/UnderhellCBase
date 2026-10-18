// 

$modelname "weapons/c_mp412.mdl"

$bodygroup "mp412"
{
	studio "mp412.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 5.962 3.334 -8.123

$cdmaterials "models/bf3/weapons/pistols/"
$cdmaterials "models/bf3/weapons/att/"

$texturegroup "skinfamilies"
{
	{
		"mp412"
		"mp412_bullets"
	}
}

$attachment "1" "Muzzleflash" 0 0 0 rotate -0 180 180

$cbox 0 0 0 0 0 0

$bbox -9.122 -10.83 -12.133 22.994 7.455 1.444

$hboxset "default"

$definebone "l-upperarm-movement" "" 6 3.058743 -5.344038 24.346462 -63.264504 -15.811859 0 0 0 0 0 0
$definebone "lwrist" "" 9.267324 -0.012912 -0.047792 7.888309 -58.717962 25.541943 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "lwrist" 3.720293 0.0805 -0.994915 0.84322 10.514232 101.757408 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.279289 0 -0.000001 48.711089 3.652207 2.488027 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.769876 -0.000001 -0 23.450053 0.105186 0.036348 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "lwrist" 3.819603 -0.171115 -0.271816 -22.424594 59.529108 84.594857 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.425532 -0.000004 0.000001 44.157675 -3.701483 -2.379957 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 0.831717 -0 0.000001 17.700533 -7.44623 -5.632074 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "lwrist" 3.610804 -0.040065 0.504238 -21.55238 69.971552 40.759973 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.310058 0 -0.000001 54.951334 2.83878 -0.859496 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.866595 0.000007 0.000001 39.883227 2.466296 1.030344 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "lwrist" 3.227354 0.282464 1.200263 -16.178719 66.853857 34.808495 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 0.998022 0 -0.000013 62.02421 13.630943 7.370647 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.721984 -0.000001 0 35.080391 1.952693 0.5073 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "lwrist" 0.992898 0.886226 -0.993035 20.48192 -4.977397 171.764067 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.656128 -0.000001 -0 27.278633 1.89958 -9.066769 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.015351 0.000002 0.000001 13.306843 -1.194736 -1.695447 0 0 0 0 0 0
$definebone "l-forearm-twist" "" 7.988214 0.070384 -0.00572 -49.643765 84.031968 93.088518 0 0 0 0 0 0
$definebone "r-upperarm-movement" "" -6 9.122312 -5.344038 24.390469 -116.725652 71.293658 0 0 0 0 0 0
$definebone "r-rist" "" 9.267324 0.012915 -0.047796 -9.633138 63.252592 -16.810579 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "r-rist" 3.720289 -0.080501 -0.994916 -7.554849 -18.599582 -93.94415 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.279294 0.000001 -0.000001 12.658176 -0.940572 -0.912319 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.769871 -0 0.000001 76.593516 -0.097773 -0.009633 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "r-rist" 3.22735 -0.282461 1.200261 -4.904403 -61.778474 -68.532281 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 0.998021 0 -0.000014 85.423585 176.157586 179.547737 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.72198 -0.000002 0 46.376868 -1.707133 -0.396195 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "r-rist" 3.819596 0.171115 -0.271819 -12.292008 -76.729478 -70.467827 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.425533 0 -0.000001 81.420855 -174.650396 -174.427513 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 0.831716 0 0 21.965878 0.264444 -1.940329 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "r-rist" 3.610802 0.040066 0.504237 -2.751457 -70.773874 -68.731675 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.310057 0.000002 -0 88.181246 -73.647293 -72.668992 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.866597 -0.000005 0 36.525144 -1.877952 -0.740901 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "r-rist" 0.992895 -0.88623 -0.993034 15.172094 -16.791445 159.919372 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.656125 0.000003 0 20.351005 -2.371404 -5.389543 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.015353 -0.000003 0.000002 16.272241 0.388498 1.661953 0 0 0 0 0 0
$definebone "r-forearm-twist" "" 7.988211 -0.070379 -0.005724 0.41024 -86.400766 -91.999376 0 0 0 0 0 0
$definebone "MP412" "" -2.353549 -8.190057 -2.920231 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Hammer" "" -2.34632 -8.549809 -1.648241 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Trigger" "" -2.356686 -10.011681 -2.805099 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Bullet2" "" -2.346566 -10.10801 -1.161647 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Bullet1" "" -2.013401 -10.107956 -1.356813 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Bullet6" "" -2.015832 -10.10643 -1.742872 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Bullet5" "" -2.351407 -10.104959 -1.933847 0.361708 -0.560123 0.222823 0 0 0 0 0 0
$definebone "MP412_Bullet4" "" -2.684548 -10.105014 -1.738672 -1.830771 -2.055428 0.35277 0 0 0 0 0 0
$definebone "MP412_Bullet3" "" -2.682127 -10.106539 -1.352589 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Cannon" "" -2.355192 -11.34129 -2.118922 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_SpeedLoader" "" 0 0 -10 -0 -0.000057 0 0 0 0 0 0 0
$definebone "Muzzleflash" "" -2.355 -14.534104 -1.159893 -0 89.999955 89.999955 0 0 0 0 0 0
$definebone "Barrel_MatchSuppressor" "" -2.355 -17.115093 -1.433259 0 0 0 0 0 0 0 0 0
$definebone "Sight_RDS_Trijiflex" "" -2.215368 -10.967797 -0.067798 0 0 0 0 0 0 0 0 0
$definebone "Sight_RDS_Eotech" "" -2.383348 -10.970474 0.018079 0 0 0 0 0 0 0 0 0
$definebone "Sight_RDS_Docter" "" -2.108012 -10.498397 -0.22715 0 0 -0.251127 0 0 0 0 0 0
$definebone "Sight_Scope_M145" "" -2.211603 -9.908962 -0.055753 0 0 0 0 0 0 0 0 0
$definebone "Sight_RDS_Aimpoint" "" -2.36897 -10.468639 0.117397 0 0 0 0 0 0 0 0 0
$definebone "Sight_Scope_Acog" "" -2.285495 -9.884172 -0.079618 0 0 0 0 0 0 0 0 0
$definebone "Side_FlashLight" "" -2.355 -13.179268 -2.440168 -89.980188 -0.000229 0 0 0 0 0 0 0
$definebone "Sight_RDS_Kobra" "" -2.41494 -10.514967 -0.150055 0 0 0 0 0 0 0 0 0
$definebone "Sight_RDS_RedDot" "" -2.37549 -10.348389 -0.037037 0 0 0 0 0 0 0 0 0
$definebone "Sight_Scope_Trillux" "" -2.379334 -10.171145 0.314339 0 0 0 0 0 0 0 0 0
$definebone "Sight_Scope_RifleScope" "" -2.251611 -11.904766 -0.6652 0 0 0 0 0 0 0 0 0
$definebone "Side_ANPEQ2" "" -3.240351 -12.815468 -1.555607 0 0 0 0 0 0 0 0 0
$definebone "Bottom_Bipod" "" -2.355 -12.342264 -1.940682 0 0 0 0 0 0 0 0 0
$definebone "Sight_Ironsight_SCARSight" "" -2.355 -14.166673 0.167329 0 0 0 0 0 0 0 0 0
$definebone "Sight_Ironsight_Battlesight" "" -2.413706 -10.466678 -0.078088 0 0 0 0 0 0 0 0 0
$definebone "Barrel_KACSilencer" "" -2.355 -14.541517 -1.274725 0 0 0 0 0 0 0 0 0
$definebone "Barrel_GemtechSilencer" "" -2.355 -14.670494 -1.221097 0 0 0 0 0 0 0 0 0
$definebone "" "" 0 0 0 0 0 0 0 0 0 0 0 0

$bonemerge "lwrist"
$bonemerge "ValveBiped.Bip01_L_Finger1"
$bonemerge "ValveBiped.Bip01_L_Finger11"
$bonemerge "ValveBiped.Bip01_L_Finger12"
$bonemerge "ValveBiped.Bip01_L_Finger2"
$bonemerge "ValveBiped.Bip01_L_Finger21"
$bonemerge "ValveBiped.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger3"
$bonemerge "ValveBiped.Bip01_L_Finger31"
$bonemerge "ValveBiped.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger4"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "ValveBiped.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger02"
$bonemerge "r-rist"
$bonemerge "ValveBiped.Bip01_R_Finger1"
$bonemerge "ValveBiped.Bip01_R_Finger11"
$bonemerge "ValveBiped.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger4"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "ValveBiped.Bip01_R_Finger42"
$bonemerge "ValveBiped.Bip01_R_Finger2"
$bonemerge "ValveBiped.Bip01_R_Finger21"
$bonemerge "ValveBiped.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger3"
$bonemerge "ValveBiped.Bip01_R_Finger31"
$bonemerge "ValveBiped.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_R_Finger0"
$bonemerge "ValveBiped.Bip01_R_Finger01"
$bonemerge "ValveBiped.Bip01_R_Finger02"


$sequence "Idle" {
	"c_mp412_anims/Idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "draw" {
	"c_mp412_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 1 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire" {
	"c_mp412_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload" {
	"c_mp412_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 19 "bf3_mp412.open" }
	{ event 5004 75 "bf3_mp412.shellin" }
	{ event 5004 100 "bf3_mp412.close" }
	fadein 0.2
	fadeout 0.2
	node "idle1"
	fps 35
}

$sequence "fire_empty" {
	"c_mp412_anims/fire_empty.smd"
	activity "ACT_VM_DRYFIRE" 1
	{ event 5004 0 "bf3.empty" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 120
}

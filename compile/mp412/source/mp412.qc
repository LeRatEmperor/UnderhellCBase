// 

$modelname "weapons/c_mp412.mdl"

$bodygroup "mp412"
{
	studio "mp412.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 5.962 3.334 -8.123

$cdmaterials "models\bf3\weapons\pistols\"
$cdmaterials "models\bf3\weapons\att\"

$texturegroup "skinfamilies"
{
	{
		"mp412"
		"mp412_bullets"
	}
}

$attachment "1" "Muzzleflash" 0 0 0 rotate -0 -180 -180

$cbox 0 0 0 0 0 0

$bbox -9.122 -10.83 -12.133 22.994 7.455 1.444

$hboxset "default"

$definebone "l-upperarm-movement" "" 6 3.058743 -5.344038 24.346465 -63.264511 -15.811859 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 9.267324 -0.012912 -0.047792 1.573183 -0.106613 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.720293 0.080500 -0.994915 0.354449 -0.042750 -0.531718 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.279289 0.000000 -0.000001 0.000000 0.004074 -0.363009 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.769876 -0.000001 0.000000 0.000000 0.002596 -0.244331 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.819602 -0.171115 -0.271816 0.085902 0.021830 -0.587867 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.425532 -0.000004 0.000001 0.000000 0.005516 -0.366478 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 0.831717 0.000000 0.000003 -0.000000 0.003084 -0.216400 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.610804 -0.040065 0.504238 -0.151780 0.073206 -0.810985 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.310057 -0.000001 -0.000001 -0.000000 0.000000 -0.247797 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.866594 0.000007 0.000000 0.000000 -0.000000 -0.430802 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.227353 0.282463 1.200263 -0.468133 0.151533 -0.880197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 0.998020 0.000000 -0.000013 -0.000000 0.000000 -0.439720 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.721985 0.000000 0.000000 -0.000000 -0.000000 -0.244299 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.992897 0.886227 -0.993035 -1.222677 -0.679213 -0.788819 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.656128 -0.000001 -0.000000 -0.000000 0.000000 0.228523 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.015352 0.000002 0.000001 -0.000000 -0.000000 0.362860 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_Forearm" 7.988214 0.070384 -0.00572 -49.643772 84.031974 93.088518 0 0 0 0 0 0
$definebone "r-upperarm-movement" "" -6 9.122312 -5.344038 24.390471 -116.725652 71.293658 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 9.267324 0.012915 -0.047796 -1.564937 0.106606 0.044193 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.720290 -0.080502 -0.994916 -0.354419 0.038567 -0.532001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.279293 0.000001 -0.000000 0.000000 -0.006613 -0.362970 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.769872 0.000000 0.000001 0.000000 -0.004211 -0.244312 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.227351 -0.282461 1.200262 0.466236 -0.158066 -0.878825 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 0.998022 0.000000 -0.000014 -0.000000 0.000000 -0.439672 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.721981 -0.000002 -0.000001 0.000000 0.000000 -0.244271 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.819597 0.171115 -0.271819 -0.085905 -0.026404 -0.587695 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.425534 -0.000000 -0.000001 -0.000000 -0.007974 -0.366436 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 0.831716 -0.000001 0.000001 0.000000 -0.004461 -0.216376 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.610803 0.040064 0.504237 0.150078 -0.079191 -0.810205 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.310057 0.000002 0.000000 0.000000 -0.000000 -0.247771 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.866597 -0.000005 -0.000001 -0.000000 0.000000 -0.430761 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.992896 -0.886229 -0.993034 1.221731 0.673635 -0.793558 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.656126 0.000003 0.000000 0.000000 0.000000 0.226893 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.015353 -0.000004 0.000002 -0.000000 -0.000000 0.362905 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_Forearm" 7.988211 -0.070379 -0.005724 0.41024 -86.400773 -91.999376 0 0 0 0 0 0
$definebone "MP412" "" -2.353549 -8.190057 -2.920231 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Hammer" "" -2.34632 -8.549809 -1.648241 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Trigger" "" -2.356686 -10.011681 -2.805099 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Bullet2" "" -2.346566 -10.10801 -1.161647 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Bullet1" "" -2.013401 -10.107956 -1.356813 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Bullet6" "" -2.015832 -10.10643 -1.742872 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Bullet5" "" -2.351407 -10.104959 -1.933847 0.361708 -0.560124 0.222823 0 0 0 0 0 0
$definebone "MP412_Bullet4" "" -2.684548 -10.105014 -1.738672 -1.830772 -2.055429 0.35277 0 0 0 0 0 0
$definebone "MP412_Bullet3" "" -2.682127 -10.106539 -1.352589 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_Cannon" "" -2.355192 -11.34129 -2.118922 0.359989 -0.12141 0.225573 0 0 0 0 0 0
$definebone "MP412_SpeedLoader" "" 0 0 -10 0 -0.000057 0 0 0 0 0 0 0
$definebone "Muzzleflash" "" -2.355 -14.534104 -1.159893 0 89.999982 89.999982 0 0 0 0 0 0
$definebone "Barrel_MatchSuppressor" "" -2.355 -17.115093 -1.433259 0 0 0 0 0 0 0 0 0
$definebone "Sight_RDS_Trijiflex" "" -2.215368 -10.967797 -0.067798 0 0 0 0 0 0 0 0 0
$definebone "Sight_RDS_Eotech" "" -2.383348 -10.970474 0.018079 0 0 0 0 0 0 0 0 0
$definebone "Sight_RDS_Docter" "" -2.108012 -10.498397 -0.22715 0 0 -0.251127 0 0 0 0 0 0
$definebone "Sight_Scope_M145" "" -2.211603 -9.908962 -0.055753 0 0 0 0 0 0 0 0 0
$definebone "Sight_RDS_Aimpoint" "" -2.36897 -10.468639 0.117397 0 0 0 0 0 0 0 0 0
$definebone "Sight_Scope_Acog" "" -2.285495 -9.884172 -0.079618 0 0 0 0 0 0 0 0 0
$definebone "Side_FlashLight" "" -2.355 -13.179268 -2.440168 -89.980195 -0.000229 0 0 0 0 0 0 0
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




$definebone "ValveBiped.Bip01_Spine4" "" 0.000006 3.336140 58.352139 -1.570799 -1.391900 -1.570795 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 2.033348 1.000767 1.937660 1.596637 -1.286515 2.942962 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 6.028141 0.000000 0.000000 -1.579613 0.047802 -0.585173 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.692558 -0.000000 0.000000 0.000000 0.000000 -0.060372 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 2.033360 1.000772 -1.937610 -1.668475 1.286518 2.942953 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 6.028143 0.000004 0.000000 1.639479 -0.008065 -0.586846 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.692549 -0.000000 0.000004 0.000000 0.000000 -0.060372 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$sequence "Idle" {
	"mp412_anims/Idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "draw" {
	"mp412_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 1 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "fire" {
	"mp412_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload" {
	"mp412_anims/reload.smd"
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
	"mp412_anims/fire_empty.smd"
	activity "ACT_VM_DRYFIRE" 1
	{ event 5004 0 "bf3.empty" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 120
}

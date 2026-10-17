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

$definebone "ValveBiped.Bip01_Spine4" "" 0.000006 3.336140 58.352139 -90.000153 -79.749996 -89.999924 0 0 0 0 0 0
$definebone "l-upperarm-movement" "" 6 3.058743 -5.344038 24.346465 -63.264511 -15.811859 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 6.028141 0.000000 0.000000 -90.505158 2.738853 -33.527943 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.692558 -0.000000 0.000000 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "lwrist" "ValveBiped.Bip01_L_Forearm" 9.267324 -0.012912 -0.047792 7.888316 -58.717968 25.541953 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.859858 -0.137947 1.332466 20.308432 -2.449395 -30.465197 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.719429 0.000000 0.000001 0.000000 0.233423 -20.798884 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 1.099663 0.000002 0.000000 0.000000 0.148740 -13.999135 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.883686 -0.046768 0.431443 4.921822 1.250767 -33.682298 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.719576 0.000000 0.000000 0.000000 0.316044 -20.997643 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.209183 -0.000004 -0.000000 0.000000 0.176700 -12.398807 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.942322 0.046772 -0.431443 -8.696353 4.194395 -46.466018 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.539089 0.000002 0.000000 0.000000 0.000000 -14.197722 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 1.196323 0.000000 -0.000000 -0.000000 0.000000 -24.683136 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.859701 -0.142406 -1.191974 -26.822045 8.682201 -50.431573 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.312565 -0.000002 0.000000 0.000000 0.000000 -25.194100 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.729362 0.000003 0.000001 0.000000 0.000000 -13.997302 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.806047 -0.348923 1.321258 -70.054232 -38.916038 -45.195999 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.789783 -0.000001 0.000000 0.000000 0.000000 13.093403 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.207001 0.000001 0.000000 0.000000 0.000000 20.790347 0 0 0 0 0 0
$definebone "l-forearm-twist" "ValveBiped.Bip01_L_Forearm" 7.988214 0.070384 -0.00572 -49.643772 84.031974 93.088518 0 0 0 0 0 0
$definebone "r-upperarm-movement" "" -6 9.122312 -5.344038 24.390471 -116.725652 71.293658 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 6.028143 0.000004 0.000000 93.935227 -0.462090 -33.623799 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.692549 -0.000000 0.000004 0.000000 0.000000 -3.459061 0 0 0 0 0 0
$definebone "r-rist" "ValveBiped.Bip01_R_Forearm" 9.267324 0.012915 -0.047796 -9.633147 63.252592 -16.810583 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.859829 -0.148937 -1.331282 -20.306713 2.209726 -30.481412 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.719431 -0.000008 0.000000 0.000000 -0.378897 -20.796649 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 1.099663 0.000000 0.000000 0.000000 -0.241273 -13.998046 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.859674 -0.132568 1.193107 26.713355 -9.056515 -50.352963 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.312565 -0.000004 0.000001 0.000000 0.000000 -25.191350 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.729370 0.000004 -0.000001 -0.000000 0.000000 -13.995697 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.883656 -0.050331 -0.431043 -4.921994 -1.512838 -33.672443 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.719574 -0.000008 0.000000 0.000000 -0.456877 -20.995236 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.209179 0.000000 -0.000000 0.000000 -0.255596 -12.397432 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.942293 0.050327 0.431043 8.598836 -4.537310 -46.421327 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.539097 0.000004 -0.000001 0.000000 0.000000 -14.196233 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 1.196323 0.000000 0.000000 0.000000 0.000000 -24.680787 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.806017 -0.359833 -1.318334 70.000030 38.596442 -45.467524 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.789783 0.000000 0.000000 0.000000 -0.000000 13.000011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.207001 0.000002 -0.000002 0.000000 0.000000 20.792925 0 0 0 0 0 0
$definebone "r-forearm-twist" "ValveBiped.Bip01_R_Forearm" 7.988211 -0.070379 -0.005724 0.41024 -86.400773 -91.999376 0 0 0 0 0 0
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

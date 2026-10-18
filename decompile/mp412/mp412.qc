// 

$modelname "bf3\weapons\mp412.mdl"

$bodygroup "mp412"
{
	studio "mp412.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 5.962 3.334 -8.123

$cdmaterials "models\bf3\weapons\pistols\"
$cdmaterials "models\bf3\weapons\att\"
$cdmaterials "models\weapons\v_models\hands\"

$texturegroup "skinfamilies"
{
	{
		"v_hands"
		"mp412"
		"mp412_bullets"
	}
}

$attachment "1" "Muzzleflash" 0 0 0 rotate -0 -180 -180

$cbox 0 0 0 0 0 0

$bbox -9.122 -10.83 -12.133 22.994 7.455 1.444

$hboxset "default"

$definebone "l-upperarm-movement" "" 6 3.058743 -5.344038 24.346465 -63.264511 -15.811859 0 0 0 0 0 0
$definebone "l-upperarm" "l-upperarm-movement" -2.128412 1.394681 -0.606004 26.182967 -25.882507 149.85838 0 0 0 0 0 0
$definebone "l-forearm" "l-upperarm" 9.051079 -0.000002 -0.000005 0.53267 90.043982 15.56984 0 0 0 0 0 0
$definebone "lwrist" "l-forearm" 9.267324 -0.012912 -0.047792 7.888316 -58.717968 25.541953 0 0 0 0 0 0
$definebone "l-index-low" "lwrist" 3.720293 0.0805 -0.994915 0.843229 10.514247 101.757429 0 0 0 0 0 0
$definebone "l-index-mid" "l-index-low" 1.279289 0 -0.000001 48.711103 3.652185 2.48802 0 0 0 0 0 0
$definebone "l-index-tip" "l-index-mid" 0.769876 -0.000001 0 23.450075 0.105183 0.036319 0 0 0 0 0 0
$definebone "l-middle-low" "lwrist" 3.819602 -0.171115 -0.271816 -22.424585 59.529128 84.594878 0 0 0 0 0 0
$definebone "l-middle-mid" "l-middle-low" 1.425532 -0.000004 0.000001 44.157675 -3.701485 -2.37996 0 0 0 0 0 0
$definebone "l-middle-tip" "l-middle-mid" 0.831717 0 0.000003 17.700534 -7.446213 -5.632074 0 0 0 0 0 0
$definebone "l-ring-low" "lwrist" 3.610804 -0.040065 0.504238 -21.552368 69.971566 40.759997 0 0 0 0 0 0
$definebone "l-ring-mid" "l-ring-low" 1.310057 -0.000001 -0.000001 54.951341 2.838769 -0.859497 0 0 0 0 0 0
$definebone "l-ring-tip" "l-ring-mid" 0.866594 0.000007 0 39.883274 2.466298 1.030346 0 0 0 0 0 0
$definebone "l-pinky-low" "lwrist" 3.227353 0.282463 1.200263 -16.17871 66.853871 34.808509 0 0 0 0 0 0
$definebone "l-pinky-mid" "l-pinky-low" 0.99802 0 -0.000013 62.02421 13.630933 7.370648 0 0 0 0 0 0
$definebone "l-pinky-tip" "l-pinky-mid" 0.721985 0 0 35.08036 1.952698 0.507283 0 0 0 0 0 0
$definebone "l-thumb-low" "lwrist" 0.992897 0.886227 -0.993035 20.481926 -4.977397 171.764095 0 0 0 0 0 0
$definebone "l-thumb-mid" "l-thumb-low" 1.656128 -0.000001 -0 27.27863 1.899578 -9.066767 0 0 0 0 0 0
$definebone "l-thumb-tip" "l-thumb-mid" 1.015352 0.000002 0.000001 13.306826 -1.194737 -1.695437 0 0 0 0 0 0
$definebone "l-forearm-twist" "l-forearm" 7.988214 0.070384 -0.00572 -49.643772 84.031974 93.088518 0 0 0 0 0 0
$definebone "r-upperarm-movement" "" -6 9.122312 -5.344038 24.390471 -116.725652 71.293658 0 0 0 0 0 0
$definebone "r-upperarm" "r-upperarm-movement" 0 0 0 -3.174983 17.981419 123.714766 0 0 0 0 0 0
$definebone "r-forearm" "r-upperarm" 9.05108 0.000003 -0.000001 0.516918 -78.860654 -15.407172 0 0 0 0 0 0
$definebone "r-rist" "r-forearm" 9.267324 0.012915 -0.047796 -9.633147 63.252592 -16.810583 0 0 0 0 0 0
$definebone "r-index-low" "r-rist" 3.72029 -0.080502 -0.994916 -7.554859 -18.59959 -93.94417 0 0 0 0 0 0
$definebone "r-index-mid" "r-index-low" 1.279293 0.000001 -0 12.658184 -0.940577 -0.91232 0 0 0 0 0 0
$definebone "r-index-tip" "r-index-mid" 0.769872 0 0.000001 76.593516 -0.097754 -0.009626 0 0 0 0 0 0
$definebone "r-pinky-low" "r-rist" 3.227351 -0.282461 1.200262 -4.904412 -61.778494 -68.532274 0 0 0 0 0 0
$definebone "r-pinky-mid" "r-pinky-low" 0.998022 0 -0.000014 85.423571 176.157723 179.547696 0 0 0 0 0 0
$definebone "r-pinky-tip" "r-pinky-mid" 0.721981 -0.000002 -0.000001 46.376872 -1.707112 -0.396206 0 0 0 0 0 0
$definebone "r-middle-low" "r-rist" 3.819597 0.171115 -0.271819 -12.292014 -76.729478 -70.46784 0 0 0 0 0 0
$definebone "r-middle-mid" "r-middle-low" 1.425534 -0 -0.000001 81.420882 -174.650341 -174.427609 0 0 0 0 0 0
$definebone "r-middle-tip" "r-middle-mid" 0.831716 -0.000001 0.000001 21.96588 0.264426 -1.940323 0 0 0 0 0 0
$definebone "r-ring-low" "r-rist" 3.610803 0.040064 0.504237 -2.751464 -70.773874 -68.731675 0 0 0 0 0 0
$definebone "r-ring-mid" "r-ring-low" 1.310057 0.000002 0 88.18126 -73.647717 -72.668568 0 0 0 0 0 0
$definebone "r-ring-tip" "r-ring-mid" 0.866597 -0.000005 -0.000001 36.525147 -1.877967 -0.740902 0 0 0 0 0 0
$definebone "r-thumb-low" "r-rist" 0.992896 -0.886229 -0.993034 15.172089 -16.791445 159.919399 0 0 0 0 0 0
$definebone "r-thumb-mid" "r-thumb-low" 1.656126 0.000003 0 20.351013 -2.371409 -5.389532 0 0 0 0 0 0
$definebone "r-thumb-tip" "r-thumb-mid" 1.015353 -0.000004 0.000002 16.272239 0.388474 1.661974 0 0 0 0 0 0
$definebone "r-forearm-twist" "r-forearm" 7.988211 -0.070379 -0.005724 0.41024 -86.400773 -91.999376 0 0 0 0 0 0
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


$sectionframes 30 130

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

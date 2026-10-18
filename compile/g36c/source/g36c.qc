// Decompiled from g36c.mdl
$modelname "weapons/c_g36c.mdl"

$bodygroup "sight"
{
	studio "g36c.smd"
}
$bodygroup "barrel"
{
	studio "g36c.smd"
}
$bodygroup "grip"
{
	studio "g36c.smd"
}
$bodygroup "laser"
{
	studio "g36c.smd"
}
$bodygroup "g36c"
{
	studio "g36c.smd"
}
// REMOVED: hands bodygroup

$surfaceprop "default"
$contents "solid"
$illumposition -29.188999 -15.245000 -4.520000

$cdmaterials ""
$cdmaterials ""
$cdmaterials ""



$bbox -37.731998 2.803000 -12.341000 29.336000 73.652000 3.147000
$cbox 0 0 0 0 0 0

$attachment "muzzle" "A_Muzzle" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "muzzle_supp" "A_Muzzle_Supp" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "2" "A_Eject" 1.000000 -0.000000 -0.000000 rotate 0.000000 -0.000000 1.000000
$attachment "Suppressor" "A_Suppressor" 1.000000 -0.000000 0.000000 rotate 0.000000 -0.000000 1.000000
$attachment "Laser" "A_Underbarrel" 1.000000 0.000000 0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Optic" "A_Optic" 1.000000 0.000000 -0.000000 rotate 0.000000 0.000000 1.000000
$attachment "Foregrip" "A_Foregrip" 1.000000 -0.000000 0.000000 rotate -0.000002 -0.000000 1.000000

$definebone "ValveBiped.Bip01_L_Clavicle" "" 2.033348 1.000767 1.937660 1.596637 -1.286515 2.942962 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 6.028141 0.000000 0.000000 -1.579613 0.047802 -0.585173 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.692558 0.000000 0.000000 0.000000 0.000000 -0.060372 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 11.481672 0.000000 0.000000 1.573183 -0.106613 0.044193 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.806047 -0.348923 1.321258 -1.222677 -0.679213 -0.788819 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.789783 0.000000 0.000000 0.000000 0.000000 0.228523 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.207001 0.000000 0.000000 0.000000 0.000000 0.362860 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.859858 -0.137947 1.332466 0.354449 -0.042750 -0.531718 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.719429 0.000000 0.000000 0.000000 0.004074 -0.363009 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 1.099663 0.000000 0.000000 0.000000 0.002596 -0.244331 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.883686 -0.046768 0.431443 0.085902 0.021830 -0.587867 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.719576 0.000000 0.000000 0.000000 0.005516 -0.366478 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.209183 0.000000 0.000000 0.000000 0.003084 -0.216400 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.942322 0.046772 -0.431443 -0.151780 0.073206 -0.810985 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.539089 0.000000 0.000000 0.000000 0.000000 -0.247797 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 1.196323 0.000000 0.000000 -0.000000 0.000000 -0.430802 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.859701 -0.142406 -1.191974 -0.468133 0.151533 -0.880197 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.312565 0.000000 0.000000 0.000000 0.000000 -0.439720 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.729362 0.000000 0.000000 0.000000 0.000000 -0.244299 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist" "ValveBiped.Bip01_L_UpperArm" 10.390530 0.000044 0.000011 -0.039983 0.043790 -0.737323 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist1" "L ForeTwist" 1.217921 0.000004 -0.000031 -0.059301 0.000007 0.000002 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist2" "L ForeTwist1" 1.217916 0.000008 -0.000027 -0.059297 0.000004 0.000001 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist3" "L ForeTwist2" 1.217911 -0.000011 0.000011 -0.059295 -0.000002 -0.000001 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist4" "L ForeTwist3" 1.217916 0.000000 -0.000004 -0.059302 0.000005 0.000002 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist5" "L ForeTwist4" 1.217918 0.000003 0.000015 -0.059296 -0.000006 -0.000002 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "L ForeTwist6" "L ForeTwist5" 1.217913 0.000001 0.000000 -0.059300 0.000004 0.000002 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Clavicle" "" 2.033360 1.000772 -1.937610 -1.668475 1.286518 2.942953 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 6.028143 0.000000 0.000000 1.639479 -0.008065 -0.586846 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.692549 0.000000 0.000000 0.000000 0.000000 -0.060372 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 11.481703 0.000000 0.000000 -1.564937 0.106606 0.044193 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.806017 -0.359833 -1.318334 1.221731 0.673635 -0.793558 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.789783 0.000000 0.000000 0.000000 -0.000000 0.226893 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.207001 0.000000 0.000000 0.000000 0.000000 0.362905 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.859829 -0.148937 -1.331282 -0.354419 0.038567 -0.532001 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.719431 0.000000 0.000000 0.000000 -0.006613 -0.362970 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 1.099663 0.000000 0.000000 0.000000 -0.004211 -0.244312 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.883656 -0.050331 -0.431043 -0.085905 -0.026404 -0.587695 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.719574 0.000000 0.000000 0.000000 -0.007974 -0.366436 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.209179 0.000000 0.000000 0.000000 -0.004461 -0.216376 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.942293 0.050327 0.431043 0.150078 -0.079191 -0.810205 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.539097 0.000000 0.000000 0.000000 0.000000 -0.247771 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 1.196323 0.000000 0.000000 0.000000 0.000000 -0.430761 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.859674 -0.132568 1.193107 0.466236 -0.158066 -0.878825 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.312565 0.000000 0.000000 0.000000 0.000000 -0.439672 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.729370 0.000000 0.000000 -0.000000 0.000000 -0.244271 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist" "ValveBiped.Bip01_R_UpperArm" 10.390526 0.000122 -0.000004 0.055998 -0.088907 -0.841438 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist1" "R ForeTwist" 1.217915 -0.000011 -0.000008 0.105070 -0.000017 -0.000005 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist2" "R ForeTwist1" 1.217930 0.000004 -0.000034 0.105069 0.000001 -0.000006 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist3" "R ForeTwist2" 1.217911 0.000011 -0.000040 0.105071 0.000014 -0.000006 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist4" "R ForeTwist3" 1.217915 0.000023 -0.000011 0.105086 0.000004 0.000007 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist5" "R ForeTwist4" 1.217930 -0.000011 0.000000 0.105060 -0.000010 -0.000001 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "R ForeTwist6" "R ForeTwist5" 1.217926 0.000008 -0.000017 0.105084 0.000013 -0.000004 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "acr_main" "" -31.078180 57.512070 -3.295033 0.500000 -0.500000 -0.500000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "acr_bolt_release" "acr_main" -0.384193 -2.067762 -0.000006 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "acr_trigger" "acr_main" -1.921764 -0.937333 -0.000010 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Optic" "acr_main" -0.028477 2.424619 0.000006 0.707107 -0.000000 0.707107 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Foregrip" "acr_main" 5.834476 -0.939685 0.000010 -0.506709 0.493199 0.506710 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle" "acr_main" 11.438957 0.366893 0.000027 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Suppressor" "acr_main" 9.623878 0.333447 0.000021 -0.509901 -0.489898 -0.509902 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Underbarrel" "acr_main" 7.941658 0.426127 -0.873259 0.002451 0.709558 0.704638 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Eject" "acr_main" 0.493866 0.303905 0.714300 -0.509018 -0.442792 -0.467365 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_Muzzle_Supp" "acr_main" 16.056320 0.366893 0.000038 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "A_LaserFlashlight" "acr_main" 7.943981 -0.111292 -0.758898 -0.709559 -0.002453 0.002468 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "Magazine" "" -31.065052 56.315331 -5.005428 0.000000 0.000000 -0.446196 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "bullet" "" -31.081810 56.510086 -4.993142 0.000000 0.000000 -0.446196 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "bullet2" "" -30.914131 56.510086 -5.122903 0.000000 0.000000 -0.446196 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "G36_Bolt" "" -31.080494 54.889900 -1.994407 0.000000 0.000000 -0.446196 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000
$definebone "G36_Bolt_End" "" -31.080494 54.628365 -1.994407 0.000000 0.000000 -0.446196 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000

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


$include "c_arms_definebones.qci"

$sequence "base_idle" {
	"g36c_anims/base_idle.smd"
	fps 30
}

$sequence "base_draw" {
	"g36c_anims/base_draw.smd"
	fps 30
}

$sequence "base_fire" {
	"g36c_anims/base_fire.smd"
	fps 30
}

$sequence "base_reload" {
	"g36c_anims/base_reload.smd"
	fps 30
}

$sequence "base_reloadempty" {
	"g36c_anims/base_reloadempty.smd"
	fps 30
}

$sequence "foregrip_idle" {
	"g36c_anims/foregrip_idle.smd"
	fps 30
}

$sequence "foregrip_draw" {
	"g36c_anims/foregrip_draw.smd"
	fps 30
}

$sequence "foregrip_fire" {
	"g36c_anims/foregrip_fire.smd"
	fps 30
}

$sequence "foregrip_reload" {
	"g36c_anims/foregrip_reload.smd"
	fps 30
}

$sequence "foregrip_reload_empty" {
	"g36c_anims/foregrip_reload_empty.smd"
	fps 30
}


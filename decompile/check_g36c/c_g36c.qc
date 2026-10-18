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


$surfaceprop "default"

$contents "solid"

$illumposition -15.245 29.189 -4.52

$cdmaterials "models/bf3/weapons/rifles/"
$cdmaterials "models/bf3/weapons/att/"

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
$attachment "2" "A_Eject" 0 0 -0 rotate -0 0 0
$attachment "Suppressor" "A_Suppressor" 0 0 -0 rotate 0 0 -0
$attachment "Laser" "A_Underbarrel" 0 0 0 rotate -0 0 0
$attachment "Optic" "A_Optic" -0 0 0 rotate -0 0 0
$attachment "Foregrip" "A_Foregrip" 0 0 -0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -37.732 2.803 -12.341 29.336 73.652 3.147

$definebone "ValveBiped.Bip01_L_Clavicle" "" -27.570877 67.798546 -8.338637 6.954561 -0.565452 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853636 -0.000008 -0.000002 19.546799 -97.61509 -38.683811 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 10.390522 0.000042 0.000011 -0.000857 -95.228396 -0.000109 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 8.525419 0.000008 -0.000061 -19.969585 70.637946 -133.377106 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.555134 0.315178 -0.822497 33.221518 -3.239228 97.515355 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.556965 0.000015 -0.000015 -2.834376 12.556435 -5.300211 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.221096 -0.000004 0 0.813886 59.418206 1.803591 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 2.828079 -0.209496 -1.286466 -19.506003 46.726591 -10.268654 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.382515 0.000008 -0.000004 2.683653 51.670712 -0.240797 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.865906 0.000015 0.000004 -0.000033 66.711776 -0.000137 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 2.813026 -0.266289 -0.544267 -14.89742 57.255946 -15.045119 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.445755 -0.000011 0.000003 -0.000028 70.987809 -0.000055 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.053741 0.000007 0.000005 -0.000142 44.019599 0.000089 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 2.68943 -0.342873 0.236181 -11.272717 57.925291 -17.370013 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.439799 -0.000008 -0.000005 0.000028 67.471573 -0.000106 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.982971 -0.000001 0.000002 -0.000207 50.926823 0.000088 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 2.426949 -0.353615 1.013783 -7.401185 59.20688 -26.365095 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.104672 0.000008 0.000004 -0.000076 28.815929 0.0002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.908451 0.000004 -0.000004 0.000073 77.838052 0.000099 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "ValveBiped.Bip01_L_UpperArm" 10.390526 0.000044 0.000011 -0.001489 -95.228396 -6.799 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.217919 0.000004 -0.000031 0.000806 0.000232 -6.79934 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.217916 0.000011 -0.000023 0.000458 0.000111 -6.798887 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.217911 -0.00001 0.000015 -0.000176 -0.000063 -6.798725 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.217916 0 0 0.000574 0.000171 -6.799544 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.217916 0.000003 0.000019 -0.000686 -0.000227 -6.798854 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist6" "ValveBiped.Bip01_L_ForeTwist5" 1.217914 0.000004 -0.000004 0.000461 0.000227 -6.799315 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" -30.58704 67.798538 -8.338637 0.218411 90.000009 179.999937 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853691 -0.000019 -0.000004 -17.295243 -133.93292 37.453107 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 10.390524 0.000122 -0.000004 0.000055 -115.585789 0.000739 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 8.525421 0.000095 0.00005 -22.357023 70.598475 142.66365 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.55513 0.315165 0.822495 -8.796638 48.349301 -119.379289 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.556957 -0.000012 -0.000002 28.598431 16.125257 5.747504 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.2211 -0.000005 -0.000013 -5.455162 71.314367 10.120331 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 2.828091 -0.209482 1.286458 0.002322 -4.35833 -1.334931 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.382526 0.000011 -0.000004 -0.000034 39.231169 -0.000025 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.865898 0.000004 -0.000002 1.268933 55.223654 0.424562 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 2.813019 -0.266279 0.544264 27.061872 58.488897 38.62054 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.445763 -0.000004 -0.000015 19.550669 70.18824 -12.744143 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.053741 0.000011 -0.000008 8.337458 67.542559 -9.492338 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 2.689434 -0.342855 -0.236188 16.749779 62.072062 16.085073 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.439804 0 -0.000004 0.07584 56.53686 0.324935 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.982986 0.000004 0 1.7551 80.244416 -1.377234 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 2.426956 -0.3536 -1.013783 13.627727 54.920462 21.573441 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.104664 0.000002 -0.000015 1.690344 31.501051 -0.281602 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.908447 -0.000011 0.000004 -3.11447 78.89738 -3.94723 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "ValveBiped.Bip01_R_UpperArm" 10.39053 0.000122 -0.000004 -0.00057 -115.584614 12.062654 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.217918 -0.000015 -0.000008 -0.001836 -0.000748 12.062425 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.217922 0.000004 -0.000034 0.000227 -0.000687 12.062252 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.217911 0.000011 -0.000041 0.00166 -0.000511 12.062485 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.217915 0.000023 -0.000011 0.000401 0.000863 12.064208 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.217934 -0.000015 -0.000002 -0.001146 -0.000284 12.061227 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist6" "ValveBiped.Bip01_R_ForeTwist5" 1.21793 0.000011 -0.000017 0.001545 -0.000292 12.063986 0 0 0 0 0 0
$definebone "acr_main" "" -31.07818 57.51207 -3.295033 -0 -89.999955 89.999955 0 0 0 0 0 0
$definebone "acr_bolt_release" "acr_main" -0.384193 -2.067762 -0.000006 -0 0 0 0 0 0 0 0 0
$definebone "acr_trigger" "acr_main" -1.921764 -0.937333 -0.00001 -0 0 0 0 0 0 0 0 0
$definebone "A_Optic" "acr_main" -0.028477 2.424619 0.000002 -89.999968 179.999937 0 0 0 0 0 0 0
$definebone "A_Foregrip" "acr_main" 5.834476 -0.939685 0.000008 89.999914 91.548215 0 0 0 0 0 0 0
$definebone "A_Muzzle" "acr_main" 11.438957 0.366893 0.000027 -0 0 0 0 0 0 0 0 0
$definebone "A_Suppressor" "acr_main" 9.623878 0.333447 0.000019 -89.999852 -92.292371 0 0 0 0 0 0 0
$definebone "A_Underbarrel" "acr_main" 7.941658 0.426127 -0.873259 0.002922 179.601272 90.398687 0 0 0 0 0 0
$definebone "A_Eject" "acr_main" 0.493858 0.303905 0.7143 -79.035746 -25.957449 -61.870831 0 0 0 0 0 0
$definebone "A_Muzzle_Supp" "acr_main" 16.05632 0.366893 0.000034 -0 0 0 0 0 0 0 0 0
$definebone "A_LaserFlashlight" "acr_main" 7.943981 -0.111292 -0.7589 0.002636 0.398779 -90.398756 0 0 0 0 0 0
$definebone "Magazine" "" -31.065052 56.315331 -5.005428 -0 -52.999724 0 0 0 0 0 0 0
$definebone "bullet" "" -31.08181 56.510086 -4.993142 0 -52.999737 0 0 0 0 0 0 0
$definebone "bullet2" "" -30.914131 56.510086 -5.122903 0 -52.999737 0 0 0 0 0 0 0
$definebone "G36_Bolt" "" -31.080494 54.8899 -1.994407 -0 -52.999724 0 0 0 0 0 0 0
$definebone "G36_Bolt_End" "" -31.080494 54.628365 -1.994407 -0 -52.999724 0 0 0 0 0 0 0

$bonemerge "ValveBiped.Bip01_L_Clavicle"
$bonemerge "ValveBiped.Bip01_L_UpperArm"
$bonemerge "ValveBiped.Bip01_L_Forearm"
$bonemerge "ValveBiped.Bip01_L_Hand"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger02"
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
$bonemerge "ValveBiped.Bip01_R_Clavicle"
$bonemerge "ValveBiped.Bip01_R_UpperArm"
$bonemerge "ValveBiped.Bip01_R_Forearm"
$bonemerge "ValveBiped.Bip01_R_Hand"
$bonemerge "ValveBiped.Bip01_R_Finger0"
$bonemerge "ValveBiped.Bip01_R_Finger01"
$bonemerge "ValveBiped.Bip01_R_Finger02"
$bonemerge "ValveBiped.Bip01_R_Finger1"
$bonemerge "ValveBiped.Bip01_R_Finger11"
$bonemerge "ValveBiped.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger2"
$bonemerge "ValveBiped.Bip01_R_Finger21"
$bonemerge "ValveBiped.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger3"
$bonemerge "ValveBiped.Bip01_R_Finger31"
$bonemerge "ValveBiped.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_R_Finger4"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "ValveBiped.Bip01_R_Finger42"


$sequence "base_idle" {
	"c_g36c_anims/base_idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "base_draw" {
	"c_g36c_anims/base_draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "base_fire" {
	"c_g36c_anims/base_fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "base_reload" {
	"c_g36c_anims/base_reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 25 "bf3_g36c.clipout" }
	{ event 5004 91 "bf3_g36c.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

$sequence "base_reloadempty" {
	"c_g36c_anims/base_reloadempty.smd"
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
	"c_g36c_anims/foregrip_idle.smd"
	activity "ACT_VM_IDLE_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "foregrip_draw" {
	"c_g36c_anims/foregrip_draw.smd"
	activity "ACT_VM_DRAW_FOREGRIP" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_fire" {
	"c_g36c_anims/foregrip_fire.smd"
	activity "ACT_VM_PRIMARYATTACK_FOREGRIP" 1
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "foregrip_reload" {
	"c_g36c_anims/foregrip_reload.smd"
	activity "ACT_VM_RELOAD_FOREGRIP" 1
	{ event 5004 25 "bf3_g36c.clipout" }
	{ event 5004 91 "bf3_g36c.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

$sequence "foregrip_reload_empty" {
	"c_g36c_anims/foregrip_reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY_FOREGRIP" 1
	{ event 5004 28 "bf3_g36c.clipout" }
	{ event 5004 84 "bf3_g36c.clipin" }
	{ event 5004 109 "bf3_g36c.boltpull" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 35
}

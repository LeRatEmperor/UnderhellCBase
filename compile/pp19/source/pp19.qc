// 

$modelname "weapons/c_pp19.mdl"

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
$bodygroup "pp19"
{
	studio "pp19.smd"
}
// REMOVED: hands bodygroup


$surfaceprop "default"

$contents "solid"

$illumposition -0.024 -3.1 -6.694

$cdmaterials "models\bf3\weapons\smg\"
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
		"pp19"
		"muzzle"
		"suppressor"
		"pp19_tape"
		"V_hands"
	}
}

$attachment "1" "Muzzle_Flash" 0 0 0 rotate -0 0 0
$attachment "2" "Shell_Eject" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -12.947 -11.067 -13.651 19.148 11.018 0.264

$definebone "BIZON_Body" "" -2.012597 -14.537454 -1.876409 0 0 0 0 0 0 0 0 0
$definebone "BIZON_Magazine" "" -2.012596 -16.605995 -3.392382 0 0 0 0 0 0 0 0 0
$definebone "BIZON_MagRelease" "" -2.012597 -4.368316 -2.462387 0 0 0 0 0 0 0 0 0
$definebone "BIZON_FireSelector" "" -2.012597 -4.402978 -1.853887 0 0 17.999985 0 0 0 0 0 0
$definebone "BIZON_Bolt" "" -2.012597 -4.368316 -2.462387 0 0 0 0 0 0 0 0 0
$definebone "BIZON_Trigger" "" -2.012597 -4.368316 -2.462387 0 0 0 0 0 0 0 0 0
$definebone "BIZON_Bullet" "" -2.012597 -16.605995 -3.392382 0 0 0 0 0 0 0 0 0
$definebone "BIZON_Bullet2" "" -2.012597 -16.605995 -3.733645 0 0 0 0 0 0 0 0 0
$definebone "Muzzle_Flash" "" -2.011627 -18.794914 -2.044978 0 -89.999982 89.999982 0 0 0 0 0 0
$definebone "Shell_Eject" "" -2.111937 -9.65472 -1.634943 -24.999908 179.999937 90.000016 0 0 0 0 0 0
$definebone "Bip01 L Clavicle" "" 1.510186 2.670961 -6.828427 0.004125 0 -0.039076 0 0 0 0 0 0
$definebone "Bip01 L UpperArm" "Bip01 L Clavicle" 5.853648 -0 0 -0.104221 -89.622805 -89.845224 0 0 0 0 0 0
$definebone "Bip01 L Forearm" "Bip01 L UpperArm" 9.961163 0 0 0 -0.729261 0 0 0 0 0 0 0
$definebone "Bip01 L Hand" "Bip01 L Forearm" 8.503067 0 0 -0.48266 0.986576 -89.951454 0 0 0 0 0 0
$definebone "Bip01 L Finger0" "Bip01 L Hand" 0.756619 0.677738 -1.164276 26.757068 24.397463 99.663313 0 0 0 0 0 0
$definebone "Bip01 L Finger01" "Bip01 L Finger0" 1.815094 0.000001 -0.000002 0.000002 12.472148 -0.000002 0 0 0 0 0 0
$definebone "Bip01 L Finger02" "Bip01 L Finger01" 1.031527 -0.000002 0 0.000002 11.714242 -0.000002 0 0 0 0 0 0
$definebone "Bip01 L Finger1" "Bip01 L Hand" 3.560264 0.118227 -1.221193 3.125714 5.505954 9.669289 0 0 0 0 0 0
$definebone "Bip01 L Finger11" "Bip01 L Finger1" 1.161263 0.000001 0 0.000001 19.247895 -0.000002 0 0 0 0 0 0
$definebone "Bip01 L Finger12" "Bip01 L Finger11" 0.705673 -0.000003 -0 0.000002 24.755397 -0.000002 0 0 0 0 0 0
$definebone "Bip01 L Finger2" "Bip01 L Hand" 3.535867 -0.001417 -0.449378 0.556915 9.319502 5.599804 0 0 0 0 0 0
$definebone "Bip01 L Finger21" "Bip01 L Finger2" 1.25942 0.000001 0 0.000002 30.239928 0 0 0 0 0 0 0
$definebone "Bip01 L Finger22" "Bip01 L Finger21" 0.945207 0.000002 -0 0 23.8833 0 0 0 0 0 0 0
$definebone "Bip01 L Finger3" "Bip01 L Hand" 3.379947 -0.050748 0.292731 -3.079076 16.275388 -7.944231 0 0 0 0 0 0
$definebone "Bip01 L Finger31" "Bip01 L Finger3" 1.267427 -0.000002 0 0 30.133616 0 0 0 0 0 0 0
$definebone "Bip01 L Finger32" "Bip01 L Finger31" 0.85579 0 -0.000001 0.000001 25.611949 -0.000001 0 0 0 0 0 0
$definebone "Bip01 L Finger4" "Bip01 L Hand" 3.272117 0.110096 1.013747 -3.908087 22.484522 -10.975865 0 0 0 0 0 0
$definebone "Bip01 L Finger41" "Bip01 L Finger4" 0.753933 0 -0 -0.000001 21.27788 0.000005 0 0 0 0 0 0
$definebone "Bip01 L Finger42" "Bip01 L Finger41" 0.703494 0.000002 -0.000001 -0.000003 17.192288 0.000004 0 0 0 0 0 0
$definebone "Bip01 L ForeTwist" "Bip01 L UpperArm" 9.961163 0 0 0 -0.729261 0.006933 0 0 0 0 0 0
$definebone "Bip01 L ForeTwist1" "Bip01 L ForeTwist" 1.417176 0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "Bip01 L ForeTwist2" "Bip01 L ForeTwist1" 1.417181 -0 0 0 -0 0.006933 0 0 0 0 0 0
$definebone "Bip01 L ForeTwist3" "Bip01 L ForeTwist2" 1.417176 0 0.000001 -0 0 0.006933 0 0 0 0 0 0
$definebone "Bip01 L ForeTwist4" "Bip01 L ForeTwist3" 1.417179 0 0 0 -0 0.006933 0 0 0 0 0 0
$definebone "Bip01 L ForeTwist5" "Bip01 L ForeTwist4" 1.417176 -0 0 0 -0 0.006933 0 0 0 0 0 0
$definebone "Bip01 R Clavicle" "" -1.505977 2.670953 -6.827188 -0.042972 -179.999745 -179.96095 0 0 0 0 0 0
$definebone "Bip01 R UpperArm" "Bip01 R Clavicle" 5.853648 0 0 0.103935 -89.622518 89.892325 0 0 0 0 0 0
$definebone "Bip01 R Forearm" "Bip01 R UpperArm" 9.961161 0.000001 0 -0 -0.729261 -0 0 0 0 0 0 0
$definebone "Bip01 R Hand" "Bip01 R Forearm" 8.503067 0 0 0.48266 0.986576 89.951454 0 0 0 0 0 0
$definebone "Bip01 R Finger0" "Bip01 R Hand" 0.756622 0.677738 1.164277 -26.757066 24.397466 -99.663313 0 0 0 0 0 0
$definebone "Bip01 R Finger01" "Bip01 R Finger0" 1.815093 0.000001 0 -0.000003 12.472153 -0.000002 0 0 0 0 0 0
$definebone "Bip01 R Finger02" "Bip01 R Finger01" 1.031525 -0.000002 -0.000001 -0.000003 11.714239 -0.000003 0 0 0 0 0 0
$definebone "Bip01 R Finger1" "Bip01 R Hand" 3.560265 0.118225 1.221195 -3.125713 5.505953 -9.669291 0 0 0 0 0 0
$definebone "Bip01 R Finger11" "Bip01 R Finger1" 1.161268 0.000001 -0.000002 -0.000002 19.2479 0.000005 0 0 0 0 0 0
$definebone "Bip01 R Finger12" "Bip01 R Finger11" 0.705667 0.000002 -0 -0.000003 24.755399 0.000003 0 0 0 0 0 0
$definebone "Bip01 R Finger2" "Bip01 R Hand" 3.535858 -0.001417 0.44938 -0.556915 9.319503 -5.599804 0 0 0 0 0 0
$definebone "Bip01 R Finger21" "Bip01 R Finger2" 1.25943 0.000002 -0 -0.000002 30.239925 0.000003 0 0 0 0 0 0
$definebone "Bip01 R Finger22" "Bip01 R Finger21" 0.945208 0 0 -0.000003 23.883309 0.000001 0 0 0 0 0 0
$definebone "Bip01 R Finger3" "Bip01 R Hand" 3.379944 -0.050749 -0.29273 3.079074 16.275379 7.944232 0 0 0 0 0 0
$definebone "Bip01 R Finger31" "Bip01 R Finger3" 1.267437 -0.000002 0 -0 30.13362 0 0 0 0 0 0 0
$definebone "Bip01 R Finger32" "Bip01 R Finger31" 0.855783 0 -0.000001 -0 25.611954 -0.000001 0 0 0 0 0 0
$definebone "Bip01 R Finger4" "Bip01 R Hand" 3.272116 0.110096 -1.013745 3.908086 22.484525 10.975866 0 0 0 0 0 0
$definebone "Bip01 R Finger41" "Bip01 R Finger4" 0.75394 -0.000001 -0 0.000001 21.27788 -0.000003 0 0 0 0 0 0
$definebone "Bip01 R Finger42" "Bip01 R Finger41" 0.703498 0.000002 0 0.000003 17.192295 -0.000002 0 0 0 0 0 0
$definebone "Bip01 R ForeTwist" "Bip01 R UpperArm" 9.961161 0.000001 0 -0 -0.729261 -0.006933 0 0 0 0 0 0
$definebone "Bip01 R ForeTwist1" "Bip01 R ForeTwist" 1.417179 0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "Bip01 R ForeTwist2" "Bip01 R ForeTwist1" 1.41718 0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "Bip01 R ForeTwist3" "Bip01 R ForeTwist2" 1.417177 -0 0.000001 -0 0 -0.006933 0 0 0 0 0 0
$definebone "Bip01 R ForeTwist4" "Bip01 R ForeTwist3" 1.41718 0 -0 0 0 -0.006933 0 0 0 0 0 0
$definebone "Bip01 R ForeTwist5" "Bip01 R ForeTwist4" 1.417176 0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "BIZON_Rail" "" -2.012597 -8.036591 -1.31326 0 0 0 0 0 0 0 0 0



$include "c_arms_definebones.qci"

$sequence "idle" {
	"pp19_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 100
	fadeout 0.2
	fps 30
}

$sequence "draw" {
	"pp19_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 100
	snap
	fps 40
}

$sequence "fire" {
	"pp19_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	fadein 0.2
	fadeout 100
	snap
	fps 30
}

$sequence "reload" {
	"pp19_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 25 "bf3_pp19.clipout" }
	{ event 5004 91 "bf3_pp19.clipin" }
	fadein 0.2
	fadeout 100
	snap
	fps 40
}

$sequence "reload_empty" {
	"pp19_anims/reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 25 "bf3_pp19.clipout" }
	{ event 5004 91 "bf3_pp19.clipin" }
	{ event 5004 133 "bf3_pp19.boltpull" }
	fadein 0.2
	fadeout 100
	snap
	fps 40
}

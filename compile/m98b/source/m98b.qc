// 

$modelname "weapons/c_m98b.mdl"

$bodygroup "sight"
{
	studio "sight.smd"
	studio "reflex.smd"
	studio "kobra.smd"
	studio "acog.smd"
	studio "eotech.smd"
	studio "scope.smd"
}
$bodygroup "barrel"
{
	studio "default.smd"
	blank
	studio "suppressor.smd"
}
$bodygroup "m98b"
{
	studio "m98b.smd"
}
// REMOVED: hands bodygroup (c_hands provides arm mesh)


$surfaceprop "default"

$contents "solid"

$illumposition -0.836 -14.927 -5.726

$cdmaterials "models\bf3\weapons\sniper\"
$cdmaterials "models\bf3\weapons\att\"
$cdmaterials "models\weapons\v_models\hands\"

$texturegroup "skinfamilies"
{
	{
		"m98b_sight"
		"reticle"
		"reflex"
		"lens"
		"kobra"
		"acog"
		"reticle_acog"
		"eotech"
		"reticle_eotech"
		"lens_eotech"
		"scope_ballistic"
		"m98b"
		"suppressor"
		"v_hands"
		"sleeve_diffuse"
	}
}

$attachment "1" "Muzzle_Flash_1" 0 0 0 rotate -0 0 0
$attachment "2" "Shell_Ejection" 0 0 0 rotate 0 180 -180

$cbox 0 0 0 0 0 0

$bbox -9.198 -9.953 -12.186 39.052 8.282 0.733

$hboxset "default"

$definebone "M98_Body" "" -2.190128 -20.547756 -2.763069 0 0 0 0 0 0 0 0 0
$definebone "M98_Magazine" "" -2.195648 -11.891459 -4.929236 0 0 0 0 0 0 0 0 0
$definebone "M98_Trigger" "" -2.190128 -20.547756 -2.763069 0 0 0 0 0 0 0 0 0
$definebone "M98_BoltHandle" "" -2.190128 -20.547756 -2.763069 0 0 0 0 0 0 0 0 0
$definebone "Muzzle_Flash_1" "" -2.18981 -37.075294 -2.70611 0 -90.000037 89.999982 0 0 0 0 0 0
$definebone "Shell_Ejection" "" -2.625289 -11.769227 -2.538591 18.826194 5.713078 -89.999982 0 0 0 0 0 0
$definebone "Bip01 L Arm" "" 1.510186 2.670961 -6.828427 0.004125 0 -0.039076 0 0 0 0 0 0
$definebone "Bip01 L Arm1" "Bip01 L Arm" 5.853648 -0 0 -0.104221 -89.622805 -89.845224 0 0 0 0 0 0
$definebone "Bip01 L Arm2" "Bip01 L Arm1" 9.961161 0 0 0 -0.729261 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "Bip01 L Arm2" 8.503063 0 0 -0.48266 0.986576 -89.951454 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 0.756618 0.677738 -1.164276 26.757066 24.397465 99.663313 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.815093 0.000002 -0.000002 0.000003 12.472152 -0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.031524 -0.000002 0.000001 0.000002 11.714245 -0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.560264 0.118227 -1.221193 3.125714 5.505955 9.669288 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.161263 0.000001 0 0.000002 19.247897 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 0.705672 -0.000002 -0 0.000001 24.755396 -0.000002 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.535871 -0.001417 -0.449377 0.556915 9.319502 5.599804 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 1.259424 -0.000001 0 0.000001 30.239935 -0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 0.94521 0.000002 -0.000002 0 23.883307 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.379947 -0.050748 0.292731 -3.079076 16.275393 -7.944231 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.267426 -0.000002 0 0 30.133616 -0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 0.85579 0.000002 -0.000001 0.000001 25.611948 -0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.272117 0.110096 1.013747 -3.908087 22.484522 -10.975865 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 0.75393 -0.000001 0 -0.000001 21.27788 0.000004 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.703496 0.000004 0 -0.000003 17.19229 0.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist" "Bip01 L Arm1" 9.961161 0 0 0 -0.729261 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist1" "ValveBiped.Bip01_L_ForeTwist" 1.417174 0 0 -0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist2" "ValveBiped.Bip01_L_ForeTwist1" 1.417181 -0 0 0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist3" "ValveBiped.Bip01_L_ForeTwist2" 1.417173 0 0.000002 -0 0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist4" "ValveBiped.Bip01_L_ForeTwist3" 1.417179 0 0 0 -0 0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_ForeTwist5" "ValveBiped.Bip01_L_ForeTwist4" 1.417172 -0 0 0 -0 0.006933 0 0 0 0 0 0
$definebone "Bip01 R Arm" "" -1.505977 2.670953 -6.827188 -0.042972 -179.999677 -179.96095 0 0 0 0 0 0
$definebone "Bip01 R Arm1" "Bip01 R Arm" 5.853648 0 0 0.103935 -89.622518 89.892325 0 0 0 0 0 0
$definebone "Bip01 R Arm2" "Bip01 R Arm1" 9.961164 0.000001 0 -0 -0.729261 -0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "Bip01 R Arm2" 8.503071 0 0 0.48266 0.986576 89.951454 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 0.756617 0.677738 1.164276 -26.757065 24.39747 -99.663313 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.815092 0.000006 -0.000002 -0.000005 12.472157 -0.000007 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.031527 -0.000003 0.000001 -0 11.714246 -0.000006 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.560261 0.118225 1.221194 -3.125713 5.505956 -9.66929 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.161264 -0 -0 -0.000002 19.247902 0.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 0.705667 -0.000001 0 -0.000005 24.755394 0.000005 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.535858 -0.001417 0.44938 -0.556915 9.319503 -5.599804 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 1.259422 0 0 -0.000003 30.239932 0.000004 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 0.945206 0.000002 0 -0.000005 23.883314 0.000001 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.379936 -0.050749 -0.29273 3.079072 16.275386 7.944232 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.267433 0 -0 0 30.13364 -0.000004 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 0.855783 0.000008 -0.000001 0.000002 25.611965 -0.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.27212 0.110096 -1.013746 3.908085 22.484529 10.975865 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 0.753935 0 -0 0.000003 21.277885 -0.000011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.703493 0.000002 0 0.000008 17.192293 -0.000011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist" "Bip01 R Arm1" 9.961164 0.000001 0 -0 -0.729261 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist1" "ValveBiped.Bip01_R_ForeTwist" 1.417178 -0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist2" "ValveBiped.Bip01_R_ForeTwist1" 1.417181 0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist3" "ValveBiped.Bip01_R_ForeTwist2" 1.417178 0 0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist4" "ValveBiped.Bip01_R_ForeTwist3" 1.417184 0 -0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_ForeTwist5" "ValveBiped.Bip01_R_ForeTwist4" 1.417174 -0 -0 -0 0 -0.006933 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "" 1.510186 2.670961 -6.828427 0.004125 0 -0.039076 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.853648 -0 0 -0.104221 -89.622805 -89.845224 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 9.961161 0 0 0 -0.729261 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "" -1.505977 2.670953 -6.827188 -0.042972 -179.999677 -179.96095 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.853648 0 0 0.103935 -89.622518 89.892325 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 9.961164 0.000001 0 -0 -0.729261 -0 0 0 0 0 0 0

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
	"m98b_anims/idle.smd"
	activity "ACT_VM_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "draw" {
	"m98b_anims/draw.smd"
	activity "ACT_VM_DRAW" 1
	{ event 5004 0 "bf3.draw" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "fire" {
	"m98b_anims/fire.smd"
	activity "ACT_VM_PRIMARYATTACK" 1
	{ event 5004 30 "bf3_m98b.boltback" }
	{ event 5004 42 "bf3_m98b.boltforward" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload" {
	"m98b_anims/reload.smd"
	activity "ACT_VM_RELOAD" 1
	{ event 5004 40 "bf3_m98b.clipout" }
	{ event 5004 78 "bf3_m98b.clipin" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

$sequence "reload_empty" {
	"m98b_anims/reload_empty.smd"
	activity "ACT_VM_RELOAD_EMPTY" 1
	{ event 5004 40 "bf3_m98b.clipout" }
	{ event 5004 78 "bf3_m98b.clipin" }
	{ event 5004 129 "bf3_m98b.boltback" }
	{ event 5004 150 "bf3_m98b.boltforward" }
	fadein 0.2
	fadeout 0.2
	snap
	fps 30
}

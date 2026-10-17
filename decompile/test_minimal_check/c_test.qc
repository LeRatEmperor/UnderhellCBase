// 

$modelname "weapons/c_test.mdl"

$bodygroup "studio"
{
	studio "test_minimal.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 0.5 0.5 0

$cdmaterials "models/test/"

$texturegroup "skinfamilies"
{
	{
		"test_material"
	}
}

$cbox 0 0 0 0 0 0

$bbox -1 -0 0 0 1 0

$definebone "ValveBiped.Bip01_Spine4" "" 0 0 0 -0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 0 0 0 -0 -0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 0 0 0 -0 -0 0 0 0 0 0 0 0
$definebone "Weapon" "" 0 0 0 -0 0 0 0 0 0 0 0 0

$bonemerge "ValveBiped.Bip01_Spine4"
$bonemerge "ValveBiped.Bip01_L_Clavicle"
$bonemerge "ValveBiped.Bip01_L_UpperArm"


$sequence "idle" {
	"c_test_anims/idle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

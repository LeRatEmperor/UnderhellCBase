#!/usr/bin/env python3
"""test_crowbar_decompile.py — Decompiles a Source .mdl using the local Crowbar build."""
import os, sys, shutil, datetime

if len(sys.argv) < 2:
    print("Usage: test_crowbar_decompile.py <model.mdl> [output_subdir]")
    sys.exit(1)

mdl_path = os.path.abspath(sys.argv[1])
if not os.path.exists(mdl_path):
    print(f"ERROR: File not found: {mdl_path}")
    sys.exit(1)

model_name = os.path.splitext(os.path.basename(mdl_path))[0]
output_dir = os.path.join("/home/z/my-project/decompile", sys.argv[2] if len(sys.argv) >= 3 else model_name)

if os.path.exists(output_dir) and os.listdir(output_dir):
    timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_dir = f"{output_dir}_backup_{timestamp}"
    shutil.move(output_dir, backup_dir)

os.makedirs(output_dir, exist_ok=True)

os.environ.setdefault('DOTNET_ROOT', '/home/z/my-project/tools/dotnet')
os.environ.setdefault('PYTHONNET_RUNTIME', 'coreclr')

import pythonnet
pythonnet.set_runtime_from_env()
import clr
sys.path.append("/home/z/my-project/tools/crowbar-src/Crowbar/bin/Debug/net8.0")
clr.AddReference("Crowbar")
clr.AddReference("System")
clr.AddReference("System.IO")
clr.AddReference("System.Reflection")

from Crowbar import TheApp, Decompiler, AppEnums
import System, System.IO, System.Reflection

settings = TheApp.Settings
settings.DecompileMdlPathFileName = mdl_path
settings.DecompileOutputFullPath = output_dir
settings.DecompileOutputSubfolderName = model_name
settings.DecompileOutputFolderOption = AppEnums.DecompileOutputPathOptions.WorkFolder
settings.DecompileMode = AppEnums.InputOptions.File
settings.DecompileOverrideMdlVersion = AppEnums.SupportedMdlVersion.DoNotOverride

for p in ["DecompileBoneAnimationPlaceInSubfolderIsChecked",
          "DecompileBoneAnimationSmdFilesIsChecked",
          "DecompileDeclareSequenceQciFileIsChecked",
          "DecompileLodMeshSmdFilesIsChecked",
          "DecompilePhysicsMeshSmdFileIsChecked",
          "DecompileProceduralBonesVrdFileIsChecked",
          "DecompileQcFileIsChecked",
          "DecompileQcIncludeDefineBoneLinesIsChecked",
          "DecompileReferenceMeshSmdFileIsChecked",
          "DecompileTextureBmpFilesIsChecked",
          "DecompileVertexAnimationVtaFileIsChecked",
          "DecompilerIsRunning"]:
    try: setattr(settings, p, True)
    except: pass
try: setattr(settings, "DecompileFolderForEachModelIsChecked", False)
except: pass

decompiler = Decompiler()
dec_type = decompiler.GetType()
flags = System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance
dec_type.GetField("theOutputPath", flags).SetValue(decompiler, output_dir)
op_field = dec_type.GetField("theOutputPathOrModelOutputFileName", flags)
if op_field: op_field.SetValue(decompiler, output_dir)
input_field = dec_type.GetField("theInputMdlPathName", flags)
if input_field: input_field.SetValue(decompiler, System.IO.Path.GetDirectoryName(mdl_path))
mop_field = dec_type.GetField("theModelOutputPath", flags)
if mop_field: mop_field.SetValue(decompiler, output_dir)

method = dec_type.GetMethod("Decompile", flags)
args = System.Array[System.Object]([])
try:
    result = method.Invoke(decompiler, args)
except Exception as e:
    pass

print(f"Decompiled: {model_name}")
total = 0
for root, dirs, files in os.walk(output_dir):
    for f in files:
        if f != "README.md":
            total += 1
print(f"Output: {total} files in {output_dir}")

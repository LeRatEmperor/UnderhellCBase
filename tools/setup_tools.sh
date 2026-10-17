#!/bin/bash
# setup_tools.sh
# -----------------------------------------------------------------------------
# Persistent paths for the three BF3 SWEP pipeline tools.
#
# These paths live under /home/z/my-project/ which is on the persistent
# rootfs filesystem and survives session restarts. Source these into your
# shell or scripts via:
#
#     source /home/z/my-project/tools/setup_tools.sh
#
# After sourcing, the following helpers become available:
#   * studiomdl <args...>     # compiles .qc -> .mdl/.vvd/.vtx
#   * crowbar-decompile <model.mdl> [output_dir]
#   * blender <args...>       # launches Blender 4.2.0 with SourceIO plugin enabled
# -----------------------------------------------------------------------------

# ---- studiomdl (compiler) ----------------------------------------------------
# Binary lives inside the source-sdk-2013 tree (also persisted at /home/z/my-project/repos/).
# Needs libtier0.so + libvstdlib.so from src/lib/public/linux64/.
export STUDIOMDL_BIN="/home/z/my-project/repos/source-sdk-2013/game/bin/studiomdl"
export STUDIOMDL_LIBS="/home/z/my-project/repos/source-sdk-2013/src/lib/public/linux64"

# Helper: studiomdl <args...>
studiomdl() {
    LD_LIBRARY_PATH="${STUDIOMDL_LIBS}" "${STUDIOMDL_BIN}" "$@"
}

# ---- dotnet (Crowbar runtime) ------------------------------------------------
# Crowbar is a .NET 8 (VB.NET) app. The dotnet SDK + runtime is persisted at
# /home/z/my-project/tools/dotnet/  (also exported via DOTNET_ROOT below).
export DOTNET_ROOT="/home/z/my-project/tools/dotnet"
export PATH="${DOTNET_ROOT}:${PATH}"

# ---- Crowbar (decompiler) ----------------------------------------------------
# Source lives at /home/z/my-project/tools/crowbar-src/  (already built).
# Compiled DLL: crowbar-src/Crowbar/bin/Debug/net8.0/Crowbar.dll
export CROWBAR_DLL_DIR="/home/z/my-project/tools/crowbar-src/Crowbar/bin/Debug/net8.0"
export CROWBAR_DLL="${CROWBAR_DLL_DIR}/Crowbar.dll"

# Helper: crowbar-decompile <model.mdl> [output_dir]
# Calls the Crowbar Decompiler class through pythonnet.
crowbar-decompile() {
    local mdl="$1"
    local out="${2:-/home/z/my-project/decompile/$(basename "${mdl}" .mdl)}"
    mkdir -p "${out}"
    DOTNET_ROOT="${DOTNET_ROOT}" PYTHONNET_RUNTIME=coreclr /home/z/.venv/bin/python3 \
        /home/z/my-project/scripts/test_crowbar_decompile.py "${mdl}" "$(basename "${out}")"
}

# ---- Blender (3D authoring + SourceIO plugin) -------------------------------
# Binary lives at /home/z/my-project/tools/blender-4.2.0-linux-x64/blender
# SourceIO plugin lives at /home/z/my-project/tools/SourceIO/source_io/  (installed into Blender's scripts path)
export BLENDER_BIN="/home/z/my-project/tools/blender-4.2.0-linux-x64/blender"
export BLENDER_USER_SCRIPTS="/home/z/my-project/tools/SourceIO"

# Helper: blender <args...>   (uses BLENDER_USER_SCRIPTS so SourceIO loads)
blender() {
    BLENDER_USER_SCRIPTS="${BLENDER_USER_SCRIPTS}" "${BLENDER_BIN}" "$@"
}

# ---- Summary -----------------------------------------------------------------
setup_tools_status() {
    echo "studiomdl: ${STUDIOMDL_BIN}  ($(test -x "${STUDIOMDL_BIN}" && echo OK || echo MISSING))"
    echo "  libtier0.so:  ${STUDIOMDL_LIBS}/libtier0.so  ($(test -f "${STUDIOMDL_LIBS}/libtier0.so" && echo OK || echo MISSING))"
    echo "  libvstdlib.so: ${STUDIOMDL_LIBS}/libvstdlib.so  ($(test -f "${STUDIOMDL_LIBS}/libvstdlib.so" && echo OK || echo MISSING))"
    echo ""
    echo "dotnet:    ${DOTNET_ROOT}/dotnet  ($(test -x "${DOTNET_ROOT}/dotnet" && echo OK || echo MISSING))"
    echo ""
    echo "crowbar:   ${CROWBAR_DLL}  ($(test -f "${CROWBAR_DLL}" && echo OK || echo MISSING))"
    echo ""
    echo "blender:   ${BLENDER_BIN}  ($(test -x "${BLENDER_BIN}" && echo OK || echo MISSING))"
    echo "  SourceIO plugin: ${BLENDER_USER_SCRIPTS}/source_io/__init__.py  ($(test -f "${BLENDER_USER_SCRIPTS}/source_io/__init__.py" && echo OK || echo MISSING))"
    echo ""
    echo "Run 'setup_tools_status' again any time to verify tool paths."
}

setup_tools_status

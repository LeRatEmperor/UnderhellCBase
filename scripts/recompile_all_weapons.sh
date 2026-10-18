#!/bin/bash
# recompile_all_weapons.sh - Recompile all 32 BF3 weapons with studiomdl

set -e
export LD_LIBRARY_PATH=/home/z/my-project/repos/source-sdk-2013/src/lib/public/linux64
STUDIOMDL=/home/z/my-project/repos/source-sdk-2013/game/bin/studiomdl

COMPILE_DIR=/home/z/my-project/compile
SUCCESS=0
FAILED=0
FAILED_WEAPONS=""

for weapon_dir in "${COMPILE_DIR}"/*/; do
    weapon=$(basename "${weapon_dir}")
    [ "${weapon}" = "Battlefield3" ] && continue
    
    qc="${weapon_dir}source/${weapon}.qc"
    if [ ! -f "${qc}" ]; then
        echo "SKIP ${weapon}: no QC file"
        continue
    fi
    
    cd "${weapon_dir}source"
    OUTPUT=$("${STUDIOMDL}" -nop4 -game . "${weapon}.qc" 2>&1)
    EXIT_CODE=$?
    
    if [ ${EXIT_CODE} -eq 0 ] && ! echo "${OUTPUT}" | grep -q "ERROR: Aborted"; then
        echo "OK   ${weapon}"
        # Copy compiled files to compiled/ folder
        cp -f models/weapons/c_${weapon}.* "${weapon_dir}compiled/" 2>/dev/null || true
        SUCCESS=$((SUCCESS + 1))
    else
        echo "FAIL ${weapon}:"
        echo "${OUTPUT}" | grep "ERROR" | head -3
        FAILED=$((FAILED + 1))
        FAILED_WEAPONS="${FAILED_WEAPONS} ${weapon}"
    fi
done

echo ""
echo "==============================="
echo "Compiled ${SUCCESS} weapons, ${FAILED} failed"
if [ -n "${FAILED_WEAPONS}" ]; then
    echo "Failed weapons:${FAILED_WEAPONS}"
fi
echo "==============================="

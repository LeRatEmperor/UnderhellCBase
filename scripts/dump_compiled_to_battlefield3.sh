#!/bin/bash
# dump_compiled_to_battlefield3.sh
# Copies all compiled model files (.mdl/.vvd/.dx80.vtx/.dx90.vtx/.sw.vtx/.xbox.vtx) from each weapon's
# compiled/ folder into the single /home/z/my-project/compile/Battlefield3/ directory.

set -e

COMPILE_DIR="/home/z/my-project/compile"
DEST_DIR="${COMPILE_DIR}/Battlefield3"

mkdir -p "${DEST_DIR}"

count=0
for weapon_dir in "${COMPILE_DIR}"/*/; do
    weapon_name=$(basename "${weapon_dir}")
    # skip the destination itself
    [ "${weapon_name}" = "Battlefield3" ] && continue

    compiled_dir="${weapon_dir}compiled"
    if [ ! -d "${compiled_dir}" ]; then
        echo "WARN: ${weapon_name} has no compiled/ subfolder, skipping"
        continue
    fi

    for f in "${compiled_dir}"/*; do
        [ -f "$f" ] || continue
        ext="${f##*.}"
        case "${ext}" in
            mdl|vvd|vtx|phy|ani|jpg|vmt|vtf)
                cp -f "$f" "${DEST_DIR}/"
                count=$((count + 1))
                ;;
        esac
    done
done

echo ""
echo "Copied ${count} files to ${DEST_DIR}"
echo "=== Final listing ==="
ls "${DEST_DIR}" | wc -l
echo "files in Battlefield3/"
echo ""
echo "=== Per-extension count ==="
for ext in mdl vvd "dx80.vtx" "dx90.vtx" "sw.vtx" "xbox.vtx" phy ani; do
    n=$(ls "${DEST_DIR}"/*.${ext} 2>/dev/null | wc -l)
    echo "  *.${ext}: ${n}"
done

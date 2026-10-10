#!/usr/bin/env python3
"""
Port the BO7 1911 TRM attachments to CUH format.

TRM attachment format:
  ATTACHMENT.Base = "att_base"
  ATTACHMENT.Name = "Barrel-H"
  ATTACHMENT.Model = Model("path/to/model.mdl")
  ATTACHMENT.Bonemerge = true
  ATTACHMENT.Category = "bo7_1911_barrel"
  function ATTACHMENT:ChangeWeaponStats(stat)
      stat.Primary.ClipSize = 10
      stat.Animations.Reload = stat.Animations.Reload_Xmag
  end

CUH attachment format:
  ATTACHMENT.Name = "..."
  ATTACHMENT.ModelPath = "..."
  ATTACHMENT.PartClass = "barrel"  (mapped from Category)
  ATTACHMENT.WeaponTable = {
      ["Primary"] = { ["ClipSize"] = function(wep, val) return 10 end, ... },
      ["Animations"] = { ["reload"] = "reload_xmag", ... },
  }
  function ATTACHMENT:Attach(wep) ... model swap ... end
"""
import os
import re

SRC_DIR = "/tmp/bo7_1911_port/atts"
DST_DIR = "/home/z/my-project/download/custom_uh_base/lua/cuh_attachments"

# Map TRM category → CUH PartClass (VElement key)
# These match the VElement names we'll define on the weapon.
CATEGORY_TO_PARTCLASS = {
    "bo7_1911_barrel": "barrel",
    "bo7_1911_mag":    "mag",
    "bo7_1911_pgrip":  "pgrip",
    "bo7_1911_tr":     "trigger",   # trigger guard
    "bo7_1911_muzzle": "muzzle",    # muzzle devices
    "bo7_1911_misc":   None,        # misc (pos offset, no model swap)
}

# Map TRM animation key names → CUH animation key names
# TRM uses: Reload, Reload_Empty, Reload_Fast, Reload_Xmag, etc.
# CUH uses lowercase: reload, reload_empty, etc.
ANIM_KEY_MAP = {
    "Reload":             "reload",
    "Reload_Empty":       "reload_empty",
    "Reload_Fast":        "reload_fast",
    "Reload_Empty_Fast":  "reload_empty_fast",
    "Reload_Xmag":        "reload_xmag",
    "Reload_Empty_Xmag":  "reload_empty_xmag",
    "Reload_XmagLrg":    "reload_xmaglrg",
    "Reload_Empty_XmagLrg": "reload_empty_xmaglrg",
    "Inspect":            "inspect",
    "Inspect_Empty":      "inspect_empty",
    "Fire":               "shoot",
    "Fire_Last":          "shoot_last",
    "Idle":               "idle",
    "Idle_Empty":         "idle_empty",
    "Draw":               "deploy",
    "Sprint":             "sprint_idle",
    "Ads_In":             "iron_in",
    "Ads_Out":            "iron_out",
}


def parse_trm_attachment(src_text):
    """Parse a TRM attachment file."""
    # Get Name
    name_match = re.search(r'ATTACHMENT\.Name\s*=\s*"([^"]+)"', src_text)
    name = name_match.group(1) if name_match else "Unknown"

    # Get Model path (TRM uses Model("...") wrapper)
    model_match = re.search(r'ATTACHMENT\.Model\s*=\s*Model\("([^"]+)"\)', src_text)
    model_path = model_match.group(1) if model_match else None

    # Get Category
    cat_match = re.search(r'ATTACHMENT\.Category\s*=\s*"([^"]+)"', src_text)
    category = cat_match.group(1) if cat_match else None

    # Get Pos/Angles (for muzzle attachments)
    pos_match = re.search(r'ATTACHMENT\.Pos\s*=\s*Vector\(([^)]+)\)', src_text)
    angles_match = re.search(r'ATTACHMENT\.Angles\s*=\s*Angle\(([^)]+)\)', src_text)

    # Get Bonemerge flag
    bonemerge = 'ATTACHMENT.Bonemerge = true' in src_text or 'ATTACHMENT.Bonemerge=true' in src_text

    # Extract ChangeWeaponStats function body
    stats_match = re.search(r'function ATTACHMENT:ChangeWeaponStats\(\w+\)\s*(.*?)\nend', src_text, re.DOTALL)
    stats_body = stats_match.group(1).strip() if stats_match else ""

    return {
        "name": name,
        "model_path": model_path,
        "category": category,
        "pos": pos_match.group(1) if pos_match else None,
        "angles": angles_match.group(1) if angles_match else None,
        "bonemerge": bonemerge,
        "stats_body": stats_body,
    }


def convert_stats_body(stats_body):
    """Convert TRM ChangeWeaponStats body to CUH WeaponTable entries.

    TRM patterns we need to handle:
      stat.Primary.ClipSize = 10
      stat.Animations.Reload = stat.Animations.Reload_Xmag
      weapon.Primary.Automatic = true
      weapon.Primary.RPM = weapon.Primary.RPM * 0.95
      weapon.Slienced = true
      weapon.Aim.Spread = weapon.Aim.Spread * 0.9
      weapon.Recoil.Shake = weapon.Recoil.Shake * 1.1
      weapon.Primary.Damage = weapon.Primary.Damage * 0.8
      weapon.Primary.RPM = 888
      weapon.VMOffset.Idle.Pos = weapon.VMOffset.Idle.Pos + Vector(3, 0, 1)
    """
    if not stats_body:
        return None

    primary_entries = {}      # key → value (string or function)
    top_level_entries = {}   # key → value
    anim_entries = {}         # anim_key → sequence_name
    skip = False

    # Parse line by line
    for line in stats_body.split('\n'):
        line = line.strip()
        if not line or line.startswith('--'):
            continue

        # stat.Primary.ClipSize = 10
        m = re.match(r'(?:stat|weapon|wep)\.Primary\.(\w+)\s*=\s*(.+)', line)
        if m:
            key = m.group(1)
            val = m.group(2).strip()
            # Check if it's a simple value or a self-referencing expression
            if re.match(r'^\d+$', val) or val in ('true', 'false') or val.startswith('"'):
                primary_entries[key] = val
            elif re.match(r'(?:stat|weapon|wep)\.Primary\.' + key + r'\s*[\*\+/\-]', val):
                # weapon.Primary.RPM = weapon.Primary.RPM * 0.95 → function
                primary_entries[key] = f'function(wep, val) return val * {val.split("*")[1].strip() if "*" in val else "1"} end'
            else:
                # Fallback: store as a function that returns the expression
                # with 'val' substituted for the self-reference
                expr = re.sub(r'(?:stat|weapon|wep)\.Primary\.' + key, 'val', val)
                primary_entries[key] = f'function(wep, val) return {expr} end'
            continue

        # stat.Animations.Reload = stat.Animations.Reload_Xmag
        m = re.match(r'(?:stat|weapon|wep)\.Animations\.(\w+)\s*=\s*(?:stat|weapon|wep)\.Animations\.(\w+)', line)
        if m:
            cuh_key = ANIM_KEY_MAP.get(m.group(1), m.group(1).lower())
            # The RHS is an animation key that maps to a sequence name.
            # In CUH, we just set the anim key to the lowercase version.
            cuh_val = ANIM_KEY_MAP.get(m.group(2), m.group(2).lower())
            anim_entries[cuh_key] = cuh_val
            continue

        # weapon.Slienced = true → store as top-level
        m = re.match(r'(?:stat|weapon|wep)\.(\w+)\s*=\s*(.+)', line)
        if m:
            key = m.group(1)
            val = m.group(2).strip()
            # Skip VMOffset and complex stuff we can't handle
            if key in ('VMOffset', 'Aim', 'Recoil', 'VisualRecoil', 'MoveSpeed'):
                skip = True
                continue
            top_level_entries[key] = val
            continue

    return {
        "primary": primary_entries,
        "top_level": top_level_entries,
        "animations": anim_entries,
        "skipped": skip,
    }


def write_cuh_attachment(att_id, parsed, stats):
    """Write the CUH-format attachment file."""
    lines = []
    lines.append('if not ATTACHMENT then ATTACHMENT = {} end')
    lines.append('')
    lines.append(f'ATTACHMENT.Name = "{parsed["name"]}"')
    lines.append(f'ATTACHMENT.ShortName = ""')

    # Icon - TRM uses Material("path"), CUH uses string path
    if parsed["model_path"]:
        lines.append(f'ATTACHMENT.Icon = nil')
        lines.append(f'ATTACHMENT.ModelPath = "{parsed["model_path"]}"')
    else:
        lines.append(f'ATTACHMENT.Icon = nil')
        lines.append(f'ATTACHMENT.ModelPath = nil')

    # PartClass from category
    part_class = CATEGORY_TO_PARTCLASS.get(parsed["category"], None)
    if part_class:
        lines.append(f'ATTACHMENT.PartClass = "{part_class}"')
    else:
        lines.append(f'ATTACHMENT.PartClass = nil')

    lines.append('')
    lines.append('ATTACHMENT.Description = {')
    lines.append(f'    Color(255, 255, 255), "{parsed["name"]}",')
    lines.append('}')
    lines.append('')

    # WeaponTable
    has_stats = stats and (stats["primary"] or stats["top_level"] or stats["animations"])
    if has_stats:
        lines.append('ATTACHMENT.WeaponTable = {')
        if stats["primary"]:
            lines.append('    ["Primary"] = {')
            for key, val in stats["primary"].items():
                lines.append(f'        ["{key}"] = {val},')
            lines.append('    },')
        if stats["animations"]:
            lines.append('    ["Animations"] = {')
            for key, val in stats["animations"].items():
                lines.append(f'        ["{key}"] = "{val}",')
            lines.append('    },')
        # Top-level entries (Slienced, etc.)
        for key, val in stats["top_level"].items():
            lines.append(f'    ["{key}"] = {val},')
        lines.append('}')
    else:
        lines.append('ATTACHMENT.WeaponTable = {}')
    lines.append('')

    # Attach/Detach functions — model swap if we have a model + PartClass
    if parsed["model_path"] and part_class:
        lines.append('function ATTACHMENT:Attach(wep)')
        lines.append('    local partClass = self.PartClass')
        lines.append('    local newModel = self.ModelPath')
        lines.append('    if wep.ViewModelElements and wep.ViewModelElements[partClass] then')
        lines.append('        if not wep.ViewModelElements[partClass]._original_model then')
        lines.append('            wep.ViewModelElements[partClass]._original_model = wep.ViewModelElements[partClass].model')
        lines.append('        end')
        lines.append('        wep.ViewModelElements[partClass].model = newModel')
        lines.append('    end')
        lines.append('    if wep.WorldModelElements and wep.WorldModelElements[partClass] then')
        lines.append('        if not wep.WorldModelElements[partClass]._original_model then')
        lines.append('            wep.WorldModelElements[partClass]._original_model = wep.WorldModelElements[partClass].model')
        lines.append('        end')
        lines.append('        wep.WorldModelElements[partClass].model = newModel')
        lines.append('    end')
        lines.append('    wep:CleanupVElements()')
        lines.append('    wep:InitVElements()')
        lines.append('    wep:CleanupWElements()')
        lines.append('    wep:InitWElements()')
        lines.append('end')
        lines.append('')
        lines.append('function ATTACHMENT:Detach(wep)')
        lines.append('    local partClass = self.PartClass')
        lines.append('    if wep.ViewModelElements and wep.ViewModelElements[partClass] and wep.ViewModelElements[partClass]._original_model then')
        lines.append('        wep.ViewModelElements[partClass].model = wep.ViewModelElements[partClass]._original_model')
        lines.append('    end')
        lines.append('    if wep.WorldModelElements and wep.WorldModelElements[partClass] and wep.WorldModelElements[partClass]._original_model then')
        lines.append('        wep.WorldModelElements[partClass].model = wep.WorldModelElements[partClass]._original_model')
        lines.append('    end')
        lines.append('    wep:CleanupVElements()')
        lines.append('    wep:InitVElements()')
        lines.append('    wep:CleanupWElements()')
        lines.append('    wep:InitWElements()')
        lines.append('end')
    else:
        lines.append('function ATTACHMENT:Attach(wep)')
        lines.append('end')
        lines.append('')
        lines.append('function ATTACHMENT:Detach(wep)')
        lines.append('end')

    return '\n'.join(lines) + '\n'


def main():
    os.makedirs(DST_DIR, exist_ok=True)
    count = 0
    for fname in sorted(os.listdir(SRC_DIR)):
        if not fname.endswith('.lua'):
            continue
        att_id = fname[:-4]

        src_path = os.path.join(SRC_DIR, fname)
        with open(src_path, 'r') as f:
            src_text = f.read()

        parsed = parse_trm_attachment(src_text)
        stats = convert_stats_body(parsed["stats_body"])
        out_text = write_cuh_attachment(att_id, parsed, stats)

        dst_path = os.path.join(DST_DIR, att_id + '.lua')
        with open(dst_path, 'w') as f:
            f.write(out_text)

        model_short = parsed["model_path"].split("/")[-1] if parsed["model_path"] else "N/A"
        print(f"  {att_id} → {parsed['category']} → {model_short}")
        count += 1

    print(f"\nPorted {count} attachments to {DST_DIR}")


if __name__ == "__main__":
    main()

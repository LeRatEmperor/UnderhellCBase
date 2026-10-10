#!/usr/bin/env python3
"""
Port the BO6 XM4 TFA attachments to CUH format.
Reads from /tmp/xm4_port/atts/, writes to /home/z/my-project/download/custom_uh_base/lua/cuh_attachments/
"""
import os
import re
import sys

SRC_DIR = "/tmp/xm4_port/atts"
DST_DIR = "/home/z/my-project/download/custom_uh_base/lua/cuh_attachments"

# Map of attachment IDs that need rename to avoid collision with M8A1's xm8_* IDs.
# Since CUH registers all attachments globally, xm4_* prefix is fine.
ATT_MAP = {
    # No rename needed — xm4_* are already unique
}


def parse_tfa_attachment(src_text):
    """Parse a TFA attachment file and extract:
    - Name, ShortName, Icon
    - ModelPath (from VElements.X.model = "...")
    - PartClass (from VElements.X where X is the key)
    - WeaponTable (Primary, IronSightTime, MoveSpeed, etc.)
    - Description (strip TFA.AttachmentColors["+"], keep as Color(100,255,100))
    """
    # Get Name
    name_match = re.search(r'ATTACHMENT\.Name\s*=\s*"([^"]+)"', src_text)
    name = name_match.group(1) if name_match else "Unknown"
    
    # Get ShortName
    short_match = re.search(r'ATTACHMENT\.ShortName\s*=\s*"([^"]+)"', src_text)
    short_name = short_match.group(1) if short_match else ""
    
    # Get Icon
    icon_match = re.search(r'ATTACHMENT\.Icon\s*=\s*"([^"]+)"', src_text)
    icon = icon_match.group(1) if icon_match else None
    
    # Get the VElement key + model path from :Attach
    # Pattern: wep.VElements.X.model = "path" (in :Attach)
    attach_match = re.search(r'function ATTACHMENT:Attach\(wep\)\s*(.*?)\s*end', src_text, re.DOTALL)
    part_class = None
    model_path = None
    if attach_match:
        attach_body = attach_match.group(1)
        # Look for: wep.VElements.<key>.model = "<path>"
        m = re.search(r'wep\.VElements\.(\w+)\.model\s*=\s*"([^"]+)"', attach_body)
        if m:
            part_class = m.group(1)
            model_path = m.group(2).strip()  # strip trailing space
            # Some have trailing space in the path — strip it
            if model_path.endswith(' '):
                model_path = model_path[:-1]
    
    # Extract WeaponTable entries using a balanced-brace scan
    # (regex fails because the table has nested closing braces)
    wt_body = None
    wt_match = re.search(r'ATTACHMENT\.WeaponTable\s*=\s*\{', src_text)
    if wt_match:
        # Scan from the opening { to find the matching close }
        start = wt_match.end() - 1  # position of the {
        depth = 0
        i = start
        while i < len(src_text):
            c = src_text[i]
            if c == '{':
                depth += 1
            elif c == '}':
                depth -= 1
                if depth == 0:
                    wt_body = src_text[start+1:i]
                    break
            i += 1
    
    primary_entries = []
    top_entries = []
    anim_entries = []
    
    if wt_body:
        # Extract Primary table using the same balanced-brace scan
        primary_match = re.search(r'\["Primary"\]\s*=\s*\{', wt_body)
        if primary_match:
            start = primary_match.end() - 1
            depth = 0
            i = start
            pb = None
            while i < len(wt_body):
                c = wt_body[i]
                if c == '{':
                    depth += 1
                elif c == '}':
                    depth -= 1
                    if depth == 0:
                        pb = wt_body[start+1:i]
                        break
                i += 1
            if pb:
                # Find each entry like: ["X"] = function(wep, stat) return ... end,
                for m in re.finditer(r'\["(\w+)"\]\s*=\s*(function\(wep,\s*stat\)[^}]+?end)', pb):
                    key = m.group(1)
                    func_src = m.group(2).strip()
                    # Convert TFA's stat variable name to CUH's val variable name
                    func_src = func_src.replace('function(wep, stat)', 'function(wep, val)')
                    func_src = func_src.replace('function(wep,stat)', 'function(wep, val)')
                    func_src = re.sub(r'return stat\b', 'return val', func_src)
                    primary_entries.append((key, func_src))
        
        # Extract IronSightTime, MoveSpeed, IronRecoilMultiplier (top-level function entries)
        for m in re.finditer(r'\["(IronSightTime|MoveSpeed|IronRecoilMultiplier)"\]\s*=\s*(function\(wep,\s*stat\)[^}]+?end)', wt_body):
            key = m.group(1)
            func_src = m.group(2).strip()
            func_src = func_src.replace('function(wep, stat)', 'function(wep, val)')
            func_src = func_src.replace('function(wep,stat)', 'function(wep, val)')
            func_src = re.sub(r'return stat\b', 'return val', func_src)
            top_entries.append((key, func_src))
        
        # Look for Animations table (mags)
        anim_match = re.search(r'\["Animations"\]\s*=\s*\{', wt_body)
        if anim_match:
            start = anim_match.end() - 1
            depth = 0
            i = start
            ab = None
            while i < len(wt_body):
                c = wt_body[i]
                if c == '{':
                    depth += 1
                elif c == '}':
                    depth -= 1
                    if depth == 0:
                        ab = wt_body[start+1:i]
                        break
                i += 1
            if ab:
                # TFA Animations format:
                #   ["reload"] = { ["type"] = ..., ["value"] = "reload_fast01" },
                # We want just the outer key + the value string.
                # Scan for each ["KEY"] = { ... ["value"] = "STRING" ... } block.
                pos = 0
                while pos < len(ab):
                    # Find next ["key"] = {
                    m = re.search(r'\["(\w+)"\]\s*=\s*\{', ab[pos:])
                    if not m:
                        break
                    outer_key = m.group(1)
                    block_start = pos + m.end() - 1  # position of {
                    # Scan for matching }
                    depth = 0
                    i = block_start
                    block_end = -1
                    while i < len(ab):
                        c = ab[i]
                        if c == '{':
                            depth += 1
                        elif c == '}':
                            depth -= 1
                            if depth == 0:
                                block_end = i
                                break
                        i += 1
                    if block_end > 0:
                        block_text = ab[block_start+1:block_end]
                        # Find the value string
                        val_match = re.search(r'\["value"\]\s*=\s*"([^"]+)"', block_text)
                        if val_match:
                            anim_entries.append((outer_key, val_match.group(1)))
                        pos = block_end + 1
                    else:
                        break
    
    return {
        "name": name,
        "short_name": short_name,
        "icon": icon,
        "part_class": part_class,
        "model_path": model_path,
        "primary_entries": primary_entries,
        "top_entries": top_entries,
        "anim_entries": anim_entries,
    }


def write_cuh_attachment(att_id, parsed):
    """Write the CUH-format attachment file."""
    lines = []
    lines.append('if not ATTACHMENT then ATTACHMENT = {} end')
    lines.append('')
    lines.append(f'ATTACHMENT.Name = "{parsed["name"]}"')
    lines.append(f'ATTACHMENT.ShortName = "{parsed["short_name"]}"')
    if parsed["icon"]:
        lines.append(f'ATTACHMENT.Icon = "{parsed["icon"]}"')
    else:
        lines.append('ATTACHMENT.Icon = nil')
    lines.append(f'ATTACHMENT.ModelPath = "{parsed["model_path"]}"' if parsed["model_path"] else 'ATTACHMENT.ModelPath = nil')
    lines.append(f'ATTACHMENT.PartClass = "{parsed["part_class"]}"' if parsed["part_class"] else 'ATTACHMENT.PartClass = nil')
    lines.append('')
    # Description (generic positive/negative — we don't have the actual desc strings easily, skip for now)
    lines.append('ATTACHMENT.Description = {')
    lines.append('    Color(255, 255, 255), "' + parsed["name"] + '",')
    lines.append('}')
    lines.append('')
    
    # WeaponTable
    lines.append('ATTACHMENT.WeaponTable = {')
    has_primary = parsed["primary_entries"]
    has_top = parsed["top_entries"]
    has_anim = parsed["anim_entries"]
    if has_primary:
        lines.append('    ["Primary"] = {')
        for key, func in has_primary:
            lines.append(f'        ["{key}"] = {func},')
        lines.append('    },')
    for key, func in has_top:
        lines.append(f'    ["{key}"] = {func},')
    if has_anim:
        lines.append('    ["Animations"] = {')
        for key, val in has_anim:
            lines.append(f'        ["{key}"] = "{val}",')
        lines.append('    },')
    lines.append('}')
    lines.append('')
    
    # Attach/Detach functions
    if parsed["model_path"] and parsed["part_class"]:
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
        # No model swap (like xm4_sight) — just empty Attach/Detach
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
        # Skip the M8A1's xm8_ attachments — different weapon
        if att_id.startswith('xm8_'):
            continue
        
        src_path = os.path.join(SRC_DIR, fname)
        with open(src_path, 'r') as f:
            src_text = f.read()
        
        parsed = parse_tfa_attachment(src_text)
        out_text = write_cuh_attachment(att_id, parsed)
        
        dst_path = os.path.join(DST_DIR, att_id + '.lua')
        with open(dst_path, 'w') as f:
            f.write(out_text)
        print(f"  {att_id} → {parsed['part_class'] or 'NO_MODEL'} → {parsed['model_path'] or 'N/A'}")
        count += 1
    print(f"\nPorted {count} attachments to {DST_DIR}")


if __name__ == "__main__":
    main()

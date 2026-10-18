#!/usr/bin/env python3
"""decompile_mdl.py — Python-based Source MDL decompiler (v48)."""
import struct, sys, os, re, math
from pathlib import Path

IDST = b'IDST'
BONE_SIZE = 216  # mstudiobone_t for v48 (without alignment padding)

def read_string(data, offset, max_len=256):
    if offset < 0 or offset >= len(data):
        return ""
    end = offset
    while end < len(data) and end < offset + max_len and data[end] != 0:
        end += 1
    return data[offset:end].decode('ascii', errors='ignore')

def parse_header(data):
    h = {}
    h['id'] = data[0:4]
    h['version'] = struct.unpack('<i', data[4:8])[0]
    h['checksum'] = struct.unpack('<I', data[8:12])[0]
    h['name'] = read_string(data, 12, 64)
    h['length'] = struct.unpack('<i', data[76:80])[0]
    h['eyeposition'] = struct.unpack('<fff', data[80:92])
    h['illumposition'] = struct.unpack('<fff', data[92:104])
    h['hull_min'] = struct.unpack('<fff', data[104:116])
    h['hull_max'] = struct.unpack('<fff', data[116:128])
    h['view_bbmin'] = struct.unpack('<fff', data[128:140])
    h['view_bbmax'] = struct.unpack('<fff', data[140:152])
    h['flags'] = struct.unpack('<i', data[152:156])[0]
    h['numbones'] = struct.unpack('<i', data[156:160])[0]
    h['boneindex'] = struct.unpack('<i', data[160:164])[0]
    h['numbonecontrollers'] = struct.unpack('<i', data[164:168])[0]
    h['bonecontrollerindex'] = struct.unpack('<i', data[168:172])[0]
    h['numhitboxsets'] = struct.unpack('<i', data[172:176])[0]
    h['hitboxsetindex'] = struct.unpack('<i', data[176:180])[0]
    h['numlocalseq'] = struct.unpack('<i', data[180:184])[0]
    h['localseqindex'] = struct.unpack('<i', data[184:188])[0]
    h['activitylistversion'] = struct.unpack('<i', data[188:192])[0]
    h['eventsindexed'] = struct.unpack('<i', data[192:196])[0]
    h['numtextures'] = struct.unpack('<i', data[196:200])[0]
    h['textureindex'] = struct.unpack('<i', data[200:204])[0]
    h['numcdtextures'] = struct.unpack('<i', data[204:208])[0]
    h['cdtextureindex'] = struct.unpack('<i', data[208:212])[0]
    h['numskinref'] = struct.unpack('<i', data[212:216])[0]
    h['skinrefindex'] = struct.unpack('<i', data[216:220])[0]
    h['numbodyparts'] = struct.unpack('<i', data[220:224])[0]
    h['bodypartindex'] = struct.unpack('<i', data[224:228])[0]
    h['numattachments'] = struct.unpack('<i', data[228:232])[0]
    h['attachmentindex'] = struct.unpack('<i', data[232:236])[0]
    h['numlocalanims'] = struct.unpack('<i', data[236:240])[0]
    h['localanimindex'] = struct.unpack('<i', data[240:244])[0]
    h['surfacepropindex'] = struct.unpack('<i', data[288:292])[0]
    return h

def parse_bones(data, hdr):
    bones = []
    for i in range(hdr['numbones']):
        off = hdr['boneindex'] + i * BONE_SIZE
        if off + BONE_SIZE > len(data):
            break
        b = {}
        b['sznameindex'] = struct.unpack('<i', data[off:off+4])[0]
        b['parent'] = struct.unpack('<i', data[off+4:off+8])[0]
        b['pos'] = struct.unpack('<fff', data[off+32:off+44])
        b['rot'] = struct.unpack('<fff', data[off+44:off+56])
        b['quat'] = struct.unpack('<ffff', data[off+56:off+72])
        b['name'] = read_string(data, off + b['sznameindex']) if b['sznameindex'] > 0 else f"bone_{i}"
        b['flags'] = struct.unpack('<i', data[off+148:off+152])[0] if off+152 <= len(data) else 0
        bones.append(b)
    return bones

def parse_attachments(data, hdr, bones):
    atts = []
    ATTACH_SIZE = 92
    for i in range(hdr['numattachments']):
        off = hdr['attachmentindex'] + i * ATTACH_SIZE
        if off + ATTACH_SIZE > len(data):
            break
        a = {}
        a['nameoffset'] = struct.unpack('<i', data[off:off+4])[0]
        a['flags'] = struct.unpack('<i', data[off+4:off+8])[0]
        a['localbone'] = struct.unpack('<i', data[off+8:off+12])[0]
        a['local'] = struct.unpack('<fff', data[off+12:off+24])
        a['local_rot'] = struct.unpack('<fff', data[off+24:off+36])
        a['name'] = read_string(data, off + a['nameoffset']) if a['nameoffset'] > 0 else f"attachment_{i}"
        bone_name = bones[a['localbone']]['name'] if 0 <= a['localbone'] < len(bones) else ""
        a['bone_name'] = bone_name
        atts.append(a)
    return atts

def parse_sequences(data, hdr):
    seqs = []
    # mstudioseqdesc_t is complex. Let me parse it properly.
    # The struct starts with:
    # int baseptr (4) - offset to studiohdr from this struct
    # int sznameindex (4) - offset to name from this struct
    # ...
    # Actually, the struct is variable. Let me read sequentially.
    
    offset = hdr['localseqindex']
    for i in range(hdr['numlocalseq']):
        if offset + 100 > len(data):
            break
        seq = {}
        seq['baseptr'] = struct.unpack('<i', data[offset:offset+4])[0]
        seq['sznameindex'] = struct.unpack('<i', data[offset+4:offset+8])[0]
        seq['name'] = read_string(data, offset + seq['sznameindex']) if seq['sznameindex'] > 0 else f"seq_{i}"
        
        # Read more fields
        # The actual mstudioseqdesc_t has many fields. Key ones:
        # flags at offset 12
        # activity at offset 16
        # actweight at offset 20
        # numevents at offset 24
        # eventindex at offset 28
        # numframes at offset 32
        # fps at... wait, the layout is complex
        # Let me just read numframes and fps
        
        # Actually for v48, the struct layout is:
        # int baseptr; // 0
        # int sznameindex; // 4
        # int flags; // 8  
        # int activity; // 12
        # int actweight; // 16
        # int numevents; // 20
        # int eventindex; // 24
        # int numframes; // 28
        # float fps; // 32 (offset 32 from struct start)
        # ...
        # But this might vary. Let me just use the name.
        
        seq['numframes'] = struct.unpack('<i', data[offset+28:offset+32])[0] if offset+32 <= len(data) else 0
        seq['fps'] = struct.unpack('<f', data[offset+32:offset+36])[0] if offset+36 <= len(data) else 30.0
        
        # Find the struct size (sz field at the beginning? or we need to compute)
        # Actually, mstudioseqdesc_t doesn't have a size field. It's a fixed struct.
        # For v48, the size is ~212 bytes. But let me try to find the next sequence.
        # The next seq starts at localseqindex + (i+1) * seq_size
        # We need to figure out seq_size.
        # 
        # Let me search for the next sequence's name
        if i + 1 < hdr['numlocalseq']:
            # Try to find the next seq's sznameindex pointing to a valid name
            for test_size in range(180, 300, 4):
                next_off = offset + test_size
                if next_off + 8 > len(data):
                    continue
                next_nameidx = struct.unpack('<i', data[next_off+4:next_off+8])[0]
                if next_nameidx > 0 and next_nameidx < 10000:
                    next_name = read_string(data, next_off + next_nameidx, 50)
                    if next_name and next_name[0].isalpha():
                        seq['size'] = test_size
                        break
            else:
                seq['size'] = 212  # fallback
        else:
            seq['size'] = 212
        
        seqs.append(seq)
        offset += seq['size']
    
    return seqs

def parse_cdtextures(data, hdr):
    cdt = []
    for i in range(hdr['numcdtextures']):
        off = hdr['cdtextureindex'] + i * 4
        if off + 4 > len(data):
            break
        name_off = struct.unpack('<i', data[off:off+4])[0]
        cdt.append(read_string(data, hdr['cdtextureindex'] + name_off))
    return cdt

def parse_textures(data, hdr):
    texs = []
    # mstudiotexture_t is 64 bytes
    TEX_SIZE = 64
    for i in range(hdr['numtextures']):
        off = hdr['textureindex'] + i * TEX_SIZE
        if off + TEX_SIZE > len(data):
            break
        name_off = struct.unpack('<i', data[off:off+4])[0]
        texs.append(read_string(data, off + name_off) if name_off > 0 else f"texture_{i}")
    return texs

def parse_bodyparts(data, hdr):
    bps = []
    BP_SIZE = 16
    for i in range(hdr['numbodyparts']):
        off = hdr['bodypartindex'] + i * BP_SIZE
        if off + BP_SIZE > len(data):
            break
        bp = {}
        bp['nameoffset'] = struct.unpack('<i', data[off:off+4])[0]
        bp['nummodels'] = struct.unpack('<i', data[off+4:off+8])[0]
        bp['base'] = struct.unpack('<i', data[off+8:off+12])[0]
        bp['modelindex'] = struct.unpack('<i', data[off+12:off+16])[0]
        bp['name'] = read_string(data, off + bp['nameoffset']) if bp['nameoffset'] > 0 else f"bodypart_{i}"
        bps.append(bp)
    return bps

def decompile_mdl(mdl_path, output_dir):
    mdl_path = Path(mdl_path)
    weapon = mdl_path.stem
    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    
    with open(mdl_path, 'rb') as f:
        data = f.read()
    
    if data[0:4] != IDST:
        return False, "not a valid MDL"
    
    hdr = parse_header(data)
    bones = parse_bones(data, hdr)
    attachments = parse_attachments(data, hdr, bones)
    sequences = parse_sequences(data, hdr)
    cdtextures = parse_cdtextures(data, hdr)
    textures = parse_textures(data, hdr)
    bodyparts = parse_bodyparts(data, hdr)
    surfaceprop = read_string(data, hdr['surfacepropindex']) if hdr['surfacepropindex'] > 0 else "default"
    
    # Generate QC
    qc = []
    qc.append(f'// Decompiled from {weapon}.mdl')
    qc.append(f'$modelname "weapons/c_{weapon}.mdl"')
    qc.append('')
    
    for bp in bodyparts:
        qc.append(f'$bodygroup "{bp["name"]}"')
        qc.append('{')
        qc.append(f'\tstudio "{weapon}.smd"')
        qc.append('}')
    qc.append('')
    
    qc.append(f'$surfaceprop "{surfaceprop}"')
    qc.append('')
    qc.append('$contents "solid"')
    qc.append(f'$illumposition {hdr["illumposition"][0]:.6f} {hdr["illumposition"][1]:.6f} {hdr["illumposition"][2]:.6f}')
    qc.append('')
    
    for cd in cdtextures:
        qc.append(f'$cdmaterials "{cd}"')
    qc.append('')
    
    if textures:
        qc.append('$texturegroup "skinfamilies"')
        qc.append('{')
        qc.append('\t{')
        for tex in textures[:10]:
            qc.append(f'\t\t"{tex}"')
        qc.append('\t}')
        qc.append('}')
        qc.append('')
    
    qc.append(f'$bbox {hdr["hull_min"][0]:.6f} {hdr["hull_min"][1]:.6f} {hdr["hull_min"][2]:.6f} {hdr["hull_max"][0]:.6f} {hdr["hull_max"][1]:.6f} {hdr["hull_max"][2]:.6f}')
    qc.append(f'$cbox 0 0 0 0 0 0')
    qc.append('')
    
    for att in attachments:
        qc.append(f'$attachment "{att["name"]}" "{att["bone_name"]}" {att["local"][0]:.4f} {att["local"][1]:.4f} {att["local"][2]:.4f} rotate {att["local_rot"][0]:.4f} {att["local_rot"][1]:.4f} {att["local_rot"][2]:.4f}')
    qc.append('')
    
    # $definebone
    for i, bone in enumerate(bones):
        parent_name = bones[bone['parent']]['name'] if 0 <= bone['parent'] < len(bones) else ""
        pos = bone['pos']
        rot = bone['rot']
        qc.append(f'$definebone "{bone["name"]}" "{parent_name}" {pos[0]:.6f} {pos[1]:.6f} {pos[2]:.6f} {rot[0]:.6f} {rot[1]:.6f} {rot[2]:.6f} 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000')
    qc.append('')
    
    # Sequences
    for seq in sequences:
        qc.append(f'$sequence "{seq["name"]}" {{')
        qc.append(f'\t"{weapon}_anims/{seq["name"]}.smd"')
        qc.append(f'\tfps {int(seq["fps"]) if seq["fps"] > 0 else 30}')
        qc.append('}')
        qc.append('')
    
    with open(output_dir / f"{weapon}.qc", 'w') as f:
        f.write('\n'.join(qc))
    
    # Generate reference SMD (skeleton + empty mesh)
    smd = []
    smd.append(f'// Decompiled reference SMD for {weapon}')
    smd.append('version 1')
    smd.append('nodes')
    for i, bone in enumerate(bones):
        smd.append(f'{i} "{bone["name"]}" {bone["parent"]}')
    smd.append('end')
    smd.append('skeleton')
    smd.append('time 0')
    for i, bone in enumerate(bones):
        pos = bone['pos']
        rot = bone['rot']
        smd.append(f'{i} {pos[0]:.6f} {pos[1]:.6f} {pos[2]:.6f} {rot[0]:.6f} {rot[1]:.6f} {rot[2]:.6f}')
    smd.append('end')
    smd.append('triangles')
    smd.append('end')
    
    with open(output_dir / f"{weapon}.smd", 'w') as f:
        f.write('\n'.join(smd))
    
    # Generate animation SMDs (just bind pose for now)
    anims_dir = output_dir / f"{weapon}_anims"
    anims_dir.mkdir(exist_ok=True)
    
    for seq in sequences:
        anim = []
        anim.append(f'// Animation: {seq["name"]}')
        anim.append('version 1')
        anim.append('nodes')
        for i, bone in enumerate(bones):
            anim.append(f'{i} "{bone["name"]}" {bone["parent"]}')
        anim.append('end')
        anim.append('skeleton')
        for frame in range(max(1, seq['numframes'])):
            anim.append(f'time {frame}')
            for i, bone in enumerate(bones):
                pos = bone['pos']
                rot = bone['rot']
                anim.append(f'{i} {pos[0]:.6f} {pos[1]:.6f} {pos[2]:.6f} {rot[0]:.6f} {rot[1]:.6f} {rot[2]:.6f}')
        anim.append('end')
        
        with open(anims_dir / f"{seq['name']}.smd", 'w') as f:
            f.write('\n'.join(anim))
    
    return True, f"{len(bones)} bones, {len(sequences)} seqs, {len(attachments)} atts"

def main():
    if len(sys.argv) < 3:
        print(f"Usage: {sys.argv[0]} <model.mdl> <output_dir>")
        sys.exit(1)
    ok, msg = decompile_mdl(sys.argv[1], sys.argv[2])
    if ok:
        print(f"  OK: {msg}")
    else:
        print(f"  FAIL: {msg}")
        sys.exit(1)

if __name__ == "__main__":
    main()

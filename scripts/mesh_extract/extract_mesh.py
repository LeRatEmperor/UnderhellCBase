#!/usr/bin/env python3
"""extract_mesh.py - Extract mesh data from BF3 .mdl/.vvd/.vtx and write SMD triangles.

This script reads the ORIGINAL BF3 model files (not the empty decompiled SMDs)
and produces a proper SMD triangles section that can be merged into the existing
compile/<weapon>/source/<weapon>.smd.

Approach:
1. Parse .mdl for bones (with original BF3 names + indices).
2. Parse .vvd for vertices (position, normal, texcoord, boneweights).
3. Parse .vtx (.dx90.vtx) for triangle indices + VTX->VVD vertex mapping.
4. Build a BONE_INDEX_MAP: original BF3 bone index -> new SMD bone index
   (by matching the BONE_MAP-renamed name against the existing SMD's bone list).
5. Emit SMD triangles with proper bone weights, using the new SMD indices.
"""

import struct
import sys
import os
import re
from pathlib import Path

# ---------- Bone name mapping (BF3 -> ValveBiped) ----------
# Imported from full_pipeline.py
def build_bone_map():
    bm = {}
    short_base = {
        "L Clavicle": "ValveBiped.Bip01_L_Clavicle", "L UpperArm": "ValveBiped.Bip01_L_UpperArm",
        "L Forearm": "ValveBiped.Bip01_L_Forearm", "L Hand": "ValveBiped.Bip01_L_Hand",
        "R Clavicle": "ValveBiped.Bip01_R_Clavicle", "R UpperArm": "ValveBiped.Bip01_R_UpperArm",
        "R Forearm": "ValveBiped.Bip01_R_Forearm", "R Hand": "ValveBiped.Bip01_R_Hand",
        "Pelvis": "ValveBiped.Bip01_Pelvis", "Spine": "ValveBiped.Bip01_Spine",
        "Spine1": "ValveBiped.Bip01_Spine1", "Spine2": "ValveBiped.Bip01_Spine2",
        "Spine4": "ValveBiped.Bip01_Spine4", "Neck": "ValveBiped.Bip01_Neck1",
        "Neck1": "ValveBiped.Bip01_Neck1", "Head1": "ValveBiped.Bip01_Head1",
    }
    for side in ["L", "R"]:
        for finger in range(5):
            for seg in range(3):
                if seg == 0:
                    short_base[f"{side} Finger{finger}"] = f"ValveBiped.Bip01_{side}_Finger{finger}"
                else:
                    short_base[f"{side} Finger{finger}{seg}"] = f"ValveBiped.Bip01_{side}_Finger{finger}{seg}"
        short_base[f"{side} ForeTwist"] = f"ValveBiped.Bip01_{side}_ForeTwist"
        for i in range(1, 8):
            short_base[f"{side} ForeTwist{i}"] = f"ValveBiped.Bip01_{side}_ForeTwist{i}"
    bm.update(short_base)
    for short, vb in short_base.items():
        bm[f"Bip01 {short}"] = vb
    bm["Bip01"] = "ValveBiped.Bip01"
    bm["Bip01 Pelvis"] = "ValveBiped.Bip01_Pelvis"
    bm["Bip01 Spine"] = "ValveBiped.Bip01_Spine"
    bm["Bip01 Spine1"] = "ValveBiped.Bip01_Spine1"
    bm["Bip01 Neck"] = "ValveBiped.Bip01_Neck1"
    b_ch = {"b_ch_l_clavical": "ValveBiped.Bip01_L_Clavicle", "b_ch_l_upperarm": "ValveBiped.Bip01_L_UpperArm",
            "b_ch_l_forearm": "ValveBiped.Bip01_L_Forearm", "b_ch_l_hand": "ValveBiped.Bip01_L_Hand",
            "b_ch_r_clavical": "ValveBiped.Bip01_R_Clavicle", "b_ch_r_upperarm": "ValveBiped.Bip01_R_UpperArm",
            "b_ch_r_forearm": "ValveBiped.Bip01_R_Forearm", "b_ch_r_hand": "ValveBiped.Bip01_R_Hand",
            "b_ch_spine1": "ValveBiped.Bip01_Spine1", "b_ch_spine2": "ValveBiped.Bip01_Spine2", "b_root": "ValveBiped.Bip01"}
    for sl, side in [("l", "L"), ("r", "R")]:
        for finger in range(5):
            for segment in range(3):
                bf3 = f"b_ch_{sl}_finger_{finger}{segment}"
                vb = f"ValveBiped.Bip01_{side}_Finger{finger}" + (str(segment) if segment > 0 else "")
                b_ch[bf3] = vb
        for i in range(1, 8):
            b_ch[f"b_ch_{sl}_forearm_twist{i}"] = f"ValveBiped.Bip01_{side}_ForeTwist{i}"
    bm.update(b_ch)
    fwords = {"thumb": 0, "index": 1, "middle": 2, "ring": 3, "pinky": 4}
    swords = {"low": "", "mid": "1", "tip": "2"}
    for sl, side in [("l", "L"), ("r", "R")]:
        bm[f"{sl}-upperarm"] = f"ValveBiped.Bip01_{side}_UpperArm"
        bm[f"{sl}-forearm"] = f"ValveBiped.Bip01_{side}_Forearm"
        bm[f"{sl}_upperarm"] = f"ValveBiped.Bip01_{side}_UpperArm"
        bm[f"{sl}_wrist"] = f"ValveBiped.Bip01_{side}_Hand"
        bm[f"{sl}wrist"] = f"ValveBiped.Bip01_{side}_Hand"
        bm[f"{sl}-rist"] = f"ValveBiped.Bip01_{side}_Hand"
        bm[f"{sl}-forearm-twist"] = f"ValveBiped.Bip01_{side}_ForeTwist"
        bm[f"{sl}_forearm_twist"] = f"ValveBiped.Bip01_{side}_ForeTwist"
        for fn, fnum in fwords.items():
            for sn, sseg in swords.items():
                bm[f"{sl}-{fn}-{sn}"] = f"ValveBiped.Bip01_{side}_Finger{fnum}{sseg}"
                bm[f"{sl}_{fn}_{sn}"] = f"ValveBiped.Bip01_{side}_Finger{fnum}{sseg}"
    bm["Left_U_Arm"] = "ValveBiped.Bip01_L_UpperArm"
    bm["Left_L_Arm"] = "ValveBiped.Bip01_L_Forearm"
    bm["Left_Hand"] = "ValveBiped.Bip01_L_Hand"
    bm["Right_U_Arm"] = "ValveBiped.Bip01_R_UpperArm"
    bm["Right_L_Arm"] = "ValveBiped.Bip01_R_Forearm"
    bm["Right_Hand"] = "ValveBiped.Bip01_R_Hand"
    # BF3 helper bones for clavicle/upper-arm movement
    bm["l-upperarm-movement"] = "ValveBiped.Bip01_L_Clavicle"
    bm["r-upperarm-movement"] = "ValveBiped.Bip01_R_Clavicle"
    bm["l_upperarm_movement"] = "ValveBiped.Bip01_L_Clavicle"
    bm["r_upperarm_movement"] = "ValveBiped.Bip01_R_Clavicle"
    return bm

BONE_MAP = build_bone_map()


def map_bone_name(name):
    """Map a BF3 bone name to ValveBiped, fall back to original if no mapping."""
    if name in BONE_MAP:
        return BONE_MAP[name]
    return name


# ---------- .mdl parsing ----------

def parse_mdl_bones(mdl_path):
    """Returns list of (name, parent) for each bone."""
    with open(mdl_path, 'rb') as f:
        data = f.read()
    numbones = struct.unpack('<i', data[156:160])[0]
    boneindex = struct.unpack('<i', data[160:164])[0]
    BONE_SIZE = 216  # mstudiobone_t v48
    bones = []
    for i in range(numbones):
        off = boneindex + i * BONE_SIZE
        name_off = struct.unpack('<i', data[off:off+4])[0]
        parent = struct.unpack('<i', data[off+4:off+8])[0]
        # Read name (null-terminated, starting at off+name_off)
        end = off + name_off
        while end < len(data) and data[end] != 0:
            end += 1
        name = data[off+name_off:end].decode('ascii', errors='ignore')
        bones.append((name, parent))
    return bones


def parse_mdl_meshes(mdl_path):
    """Returns list of meshes, each as dict with material, numverts, vertexoffset, texture_name."""
    with open(mdl_path, 'rb') as f:
        data = f.read()
    numbodyparts = struct.unpack('<i', data[232:236])[0]
    bodypartindex = struct.unpack('<i', data[236:240])[0]
    # Textures (correct v48 studiohdr_t offsets)
    numtextures = struct.unpack('<i', data[204:208])[0]
    textureindex = struct.unpack('<i', data[208:212])[0]
    textures = []
    for i in range(numtextures):
        t_off = textureindex + i * 64
        t_name_off = struct.unpack('<i', data[t_off:t_off+4])[0]
        end = t_off + t_name_off
        while end < len(data) and data[end] != 0:
            end += 1
        t_name = data[t_off+t_name_off:end].decode('ascii', errors='ignore')
        textures.append(t_name)
    # Skin refs (correct v48 offsets)
    numskinref = struct.unpack('<i', data[220:224])[0]
    numskinfamilies = struct.unpack('<i', data[224:228])[0]
    skinrefindex = struct.unpack('<i', data[228:232])[0]
    skinrefs = []
    for sf in range(numskinfamilies):
        sf_off = skinrefindex + sf * numskinref * 2
        refs = []
        for i in range(numskinref):
            r = struct.unpack('<h', data[sf_off+i*2:sf_off+i*2+2])[0]
            refs.append(r)
        skinrefs.append(refs)
    # Use first skin family (default)
    skin_family = skinrefs[0] if skinrefs else []

    meshes = []
    BP_SIZE = 16
    MODEL_SIZE = 148
    MESH_SIZE = 116
    for bp_i in range(numbodyparts):
        bp_off = bodypartindex + bp_i * BP_SIZE
        bp_nummodels = struct.unpack('<i', data[bp_off+4:bp_off+8])[0]
        bp_modelindex = struct.unpack('<i', data[bp_off+12:bp_off+16])[0]
        for m_i in range(bp_nummodels):
            m_off = bp_off + bp_modelindex + m_i * MODEL_SIZE
            m_nummeshes = struct.unpack('<i', data[m_off+72:m_off+76])[0]
            m_meshindex = struct.unpack('<i', data[m_off+76:m_off+80])[0]
            for mesh_i in range(m_nummeshes):
                mesh_off = m_off + m_meshindex + mesh_i * MESH_SIZE
                material = struct.unpack('<i', data[mesh_off:mesh_off+4])[0]
                numverts = struct.unpack('<i', data[mesh_off+8:mesh_off+12])[0]
                vertexoffset = struct.unpack('<i', data[mesh_off+12:mesh_off+16])[0]
                # Map material index through skin family
                tex_idx = skin_family[material] if material < len(skin_family) else material
                tex_name = textures[tex_idx] if tex_idx < len(textures) else f"mat_{material}"
                meshes.append({
                    'material': material,
                    'texture_name': tex_name,
                    'numverts': numverts,
                    'vertexoffset': vertexoffset,
                    'bodypart': bp_i,
                    'model': m_i,
                    'mesh': mesh_i,
                })
    return meshes


# ---------- .vvd parsing ----------

def parse_vvd(vvd_path):
    """Returns list of vertices, each as dict with pos, normal, texcoord, bone_weights, bone_ids."""
    with open(vvd_path, 'rb') as f:
        data = f.read()
    # vertexFileHeader_t (64 bytes)
    id_magic = data[0:4]
    if id_magic != b'IDSV':
        raise ValueError(f"Not a VVD file: {id_magic}")
    version = struct.unpack('<i', data[4:8])[0]
    checksum = struct.unpack('<i', data[8:12])[0]
    numLODs = struct.unpack('<i', data[12:16])[0]
    numLODVertexes = [struct.unpack('<i', data[16+i*4:20+i*4])[0] for i in range(8)]
    numFixups = struct.unpack('<i', data[48:52])[0]
    fixupTableStart = struct.unpack('<i', data[52:56])[0]
    vertexDataStart = struct.unpack('<i', data[56:60])[0]
    tangentDataStart = struct.unpack('<i', data[60:64])[0]
    # We want all vertices (LOD 0). Use numLODVertexes[0] = total unique vertices.
    total_verts = numLODVertexes[0]
    # Each mstudiovertex_t is 48 bytes
    VERTEX_SIZE = 48
    verts = []
    for i in range(total_verts):
        v_off = vertexDataStart + i * VERTEX_SIZE
        # mstudioboneweight_t (16 bytes): float weight[3], char bone[3], byte numbones
        w0, w1, w2 = struct.unpack('<fff', data[v_off:v_off+12])
        b0, b1, b2 = data[v_off+12], data[v_off+13], data[v_off+14]
        numbones = data[v_off+15]
        # mstudiovertex_t continues with Vector pos (12), Vector normal (12), Vector2D texcoord (8)
        px, py, pz = struct.unpack('<fff', data[v_off+16:v_off+28])
        nx, ny, nz = struct.unpack('<fff', data[v_off+28:v_off+40])
        u, v = struct.unpack('<ff', data[v_off+40:v_off+48])
        weights = [w0, w1, w2]
        bone_ids = [b0, b1, b2]
        # Trim to numbones
        if numbones == 0:
            numbones = 1  # safety
        weights = weights[:numbones]
        bone_ids = bone_ids[:numbones]
        verts.append({
            'pos': (px, py, pz),
            'normal': (nx, ny, nz),
            'texcoord': (u, v),
            'weights': weights,
            'bone_ids': bone_ids,
            'numbones': numbones,
        })
    return verts


# ---------- .vtx parsing ----------

def parse_vtx(vtx_path):
    """Returns list of meshes, each as dict with texture_name (None here, filled by caller),
    triangles (list of (v0, v1, v2) VTX vertex indices), and vtx_vertices (list of origMeshVertID)."""
    with open(vtx_path, 'rb') as f:
        data = f.read()
    # FileHeader_t (36 bytes)
    version = struct.unpack('<i', data[0:4])[0]
    vertCacheSize = struct.unpack('<i', data[4:8])[0]
    maxBonesPerStrip = struct.unpack('<H', data[8:10])[0]
    maxBonesPerTri = struct.unpack('<H', data[10:12])[0]
    maxBonesPerVert = struct.unpack('<i', data[12:16])[0]
    checkSum = struct.unpack('<i', data[16:20])[0]
    numLODs = struct.unpack('<i', data[20:24])[0]
    materialReplacementListOffset = struct.unpack('<i', data[24:28])[0]
    numBodyParts = struct.unpack('<i', data[28:32])[0]
    bodyPartOffset = struct.unpack('<i', data[32:36])[0]
    # We use LOD 0 only
    target_lod = 0
    result_meshes = []
    for bp_i in range(numBodyParts):
        bp_off = bodyPartOffset + bp_i * 8
        numModels = struct.unpack('<i', data[bp_off:bp_off+4])[0]
        modelOffset = struct.unpack('<i', data[bp_off+4:bp_off+8])[0]
        for m_i in range(numModels):
            m_off = bp_off + modelOffset + m_i * 8
            numLODs_m = struct.unpack('<i', data[m_off:m_off+4])[0]
            lodOffset = struct.unpack('<i', data[m_off+4:m_off+8])[0]
            if target_lod >= numLODs_m:
                continue
            lod_off = m_off + lodOffset + target_lod * 12
            numMeshes = struct.unpack('<i', data[lod_off:lod_off+4])[0]
            meshOffset = struct.unpack('<i', data[lod_off+4:lod_off+8])[0]
            for mesh_i in range(numMeshes):
                mesh_off = lod_off + meshOffset + mesh_i * 9
                numStripGroups = struct.unpack('<i', data[mesh_off:mesh_off+4])[0]
                stripGroupHeaderOffset = struct.unpack('<i', data[mesh_off+4:mesh_off+8])[0]
                # Collect all vertices and indices across strip groups for this mesh
                vtx_verts = []  # list of origMeshVertID
                indices = []  # triangle indices (3 per tri)
                for sg_i in range(numStripGroups):
                    sg_off = mesh_off + stripGroupHeaderOffset + sg_i * 23
                    sg_numVerts = struct.unpack('<i', data[sg_off:sg_off+4])[0]
                    sg_vertOffset = struct.unpack('<i', data[sg_off+4:sg_off+8])[0]
                    sg_numIndices = struct.unpack('<i', data[sg_off+8:sg_off+12])[0]
                    sg_indexOffset = struct.unpack('<i', data[sg_off+12:sg_off+16])[0]
                    sg_numStrips = struct.unpack('<i', data[sg_off+16:sg_off+20])[0]
                    sg_stripOffset = struct.unpack('<i', data[sg_off+20:sg_off+24])[0]
                    # sg_flags = data[sg_off+24]  # unused
                    # VTX Vertex_t: 9 bytes packed (3 bytes boneWeightIndex, 1 numBones, 2 origMeshVertID, 3 boneID)
                    VERTEX_T_SIZE = 9
                    base_v_off = sg_off + sg_vertOffset
                    sg_vtx_verts = []
                    for v_i in range(sg_numVerts):
                        v_off = base_v_off + v_i * VERTEX_T_SIZE
                        # boneWeightIndex[3], numBones, origMeshVertID (unsigned short), boneID[3]
                        origMeshVertID = struct.unpack('<H', data[v_off+4:v_off+6])[0]
                        sg_vtx_verts.append(origMeshVertID)
                    # Strips: each StripHeader_t is 33 bytes packed
                    # int numIndices, indexOffset, numVerts, vertOffset, short numBones,
                    # uchar flags, int numBoneStateChanges, int boneStateChangeOffset
                    STRIP_SIZE = 33
                    base_idx_off = sg_off + sg_indexOffset
                    for strip_i in range(sg_numStrips):
                        strip_off = sg_off + sg_stripOffset + strip_i * STRIP_SIZE
                        s_numIndices = struct.unpack('<i', data[strip_off:strip_off+4])[0]
                        s_indexOffset = struct.unpack('<i', data[strip_off+4:strip_off+8])[0]
                        s_numVerts = struct.unpack('<i', data[strip_off+8:strip_off+12])[0]
                        s_vertOffset = struct.unpack('<i', data[strip_off+12:strip_off+16])[0]
                        s_numBones = struct.unpack('<h', data[strip_off+16:strip_off+18])[0]
                        s_flags = data[strip_off+18]
                        # Read indices (unsigned short)
                        idx_base = base_idx_off + s_indexOffset
                        strip_indices = [struct.unpack('<H', data[idx_base+k*2:idx_base+k*2+2])[0] for k in range(s_numIndices)]
                        # Strip vertOffset is relative to strip group's vertex array
                        # VTX vertex index = s_vertOffset + local_index (into strip group's verts)
                        # Then map to origMeshVertID via sg_vtx_verts
                        # Determine if trilist or tristrip
                        if s_flags & 0x01:  # STRIP_IS_TRILIST
                            for k in range(0, len(strip_indices), 3):
                                if k+2 < len(strip_indices):
                                    i0 = strip_indices[k] + s_vertOffset
                                    i1 = strip_indices[k+1] + s_vertOffset
                                    i2 = strip_indices[k+2] + s_vertOffset
                                    # Map VTX-local index -> sg_vtx_verts index
                                    o0 = sg_vtx_verts[i0] if 0 <= i0 < len(sg_vtx_verts) else 0
                                    o1 = sg_vtx_verts[i1] if 0 <= i1 < len(sg_vtx_verts) else 0
                                    o2 = sg_vtx_verts[i2] if 0 <= i2 < len(sg_vtx_verts) else 0
                                    indices.append((o0, o1, o2))
                        elif s_flags & 0x02:  # STRIP_IS_TRISTRIP
                            # Tristrip: every consecutive 3 verts is a triangle, alternating winding
                            for k in range(len(strip_indices) - 2):
                                if k % 2 == 0:
                                    i0 = strip_indices[k] + s_vertOffset
                                    i1 = strip_indices[k+1] + s_vertOffset
                                    i2 = strip_indices[k+2] + s_vertOffset
                                else:
                                    i0 = strip_indices[k+1] + s_vertOffset
                                    i1 = strip_indices[k] + s_vertOffset
                                    i2 = strip_indices[k+2] + s_vertOffset
                                o0 = sg_vtx_verts[i0] if 0 <= i0 < len(sg_vtx_verts) else 0
                                o1 = sg_vtx_verts[i1] if 0 <= i1 < len(sg_vtx_verts) else 0
                                o2 = sg_vtx_verts[i2] if 0 <= i2 < len(sg_vtx_verts) else 0
                                indices.append((o0, o1, o2))
                result_meshes.append({
                    'bodypart': bp_i,
                    'model': m_i,
                    'mesh': mesh_i,
                    'triangles': indices,
                })
    return result_meshes


# ---------- SMD output ----------

def build_bone_index_map(bf3_bones, smd_bone_list):
    """Map BF3 bone index -> SMD bone index by name (after BONE_MAP renaming).

    bf3_bones: list of (name, parent) tuples
    smd_bone_list: list of (idx, name, parent) tuples from existing SMD
    Returns: dict {bf3_idx: smd_idx}
    """
    name_to_smd_idx = {}
    for entry in smd_bone_list:
        idx, name, parent = entry
        name_to_smd_idx[name] = idx
    bone_map = {}
    for bf3_idx, (bf3_name, _) in enumerate(bf3_bones):
        new_name = map_bone_name(bf3_name)
        if new_name in name_to_smd_idx:
            bone_map[bf3_idx] = name_to_smd_idx[new_name]
        else:
            # Try original name (might be a weapon bone like "MP412")
            if bf3_name in name_to_smd_idx:
                bone_map[bf3_idx] = name_to_smd_idx[bf3_name]
            else:
                # Default to bone 0 (or skip)
                bone_map[bf3_idx] = 0
    return bone_map


def parse_smd_bones(smd_path):
    """Parse the nodes section of an SMD file. Returns list of (idx, name, parent)."""
    bones = []
    with open(smd_path, 'r', errors='ignore') as f:
        in_nodes = False
        for line in f:
            line = line.strip()
            if line == 'nodes':
                in_nodes = True
                continue
            if line == 'end' and in_nodes:
                break
            if not in_nodes:
                continue
            # Format: <idx> "<name>" <parent>
            m = re.match(r'^(\d+)\s+"([^"]+)"\s+(-?\d+)', line)
            if m:
                idx = int(m.group(1))
                name = m.group(2)
                parent = int(m.group(3))
                bones.append((idx, name, parent))
    return bones


def write_triangles_section(out_path, bf3_bones, smd_bone_list, vvd_verts, vtx_meshes, mdl_meshes):
    """Write only a triangles section to out_path."""
    bone_map = build_bone_index_map(bf3_bones, smd_bone_list)
    # Map (bp, model, mesh) -> texture_name
    mesh_tex = {}
    for m in mdl_meshes:
        mesh_tex[(m['bodypart'], m['model'], m['mesh'])] = m['texture_name']
    lines = ['triangles']
    total_tris = 0
    for vm in vtx_meshes:
        key = (vm['bodypart'], vm['model'], vm['mesh'])
        tex_name = mesh_tex.get(key, 'null')
        for (i0, i1, i2) in vm['triangles']:
            lines.append(tex_name)
            for vi in (i0, i1, i2):
                if vi < 0 or vi >= len(vvd_verts):
                    # safety: emit null vertex
                    lines.append('0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0')
                    continue
                v = vvd_verts[vi]
                px, py, pz = v['pos']
                nx, ny, nz = v['normal']
                u, v_t = v['texcoord']
                # SMD inverts V
                v_inverted = 1.0 - v_t
                nb = v['numbones']
                if nb == 1:
                    b0 = v['bone_ids'][0]
                    new_b0 = bone_map.get(b0, 0)
                    lines.append(f'{new_b0} {px:.6f} {py:.6f} {pz:.6f} {nx:.6f} {ny:.6f} {nz:.6f} {u:.6f} {v_inverted:.6f}')
                else:
                    # Multi-bone: <primary_bone> <px> <py> <pz> <nx> <ny> <nz> <u> <v> <iCount> <b1> <w1> <b2> <w2> <b3> <w3>
                    # primary_bone is the first bone (most-weighted), then full pos/normal/uv, then iCount and weights
                    primary_b = bone_map.get(v['bone_ids'][0], 0)
                    parts = [str(primary_b),
                             f'{px:.6f}', f'{py:.6f}', f'{pz:.6f}',
                             f'{nx:.6f}', f'{ny:.6f}', f'{nz:.6f}',
                             f'{u:.6f}', f'{v_inverted:.6f}',
                             str(nb)]
                    for k in range(nb):
                        w = v['weights'][k]
                        b = v['bone_ids'][k]
                        new_b = bone_map.get(b, 0)
                        parts.append(str(new_b))
                        parts.append(f'{w:.6f}')
                    lines.append(' '.join(parts))
            total_tris += 1
    lines.append('end')
    with open(out_path, 'w') as f:
        f.write('\n'.join(lines) + '\n')
    return total_tris


def merge_triangles_into_smd(smd_path, triangles_file):
    """Replace the existing 'triangles ... end' section in smd_path with the new triangles content."""
    with open(smd_path, 'r', errors='ignore') as f:
        content = f.read()
    # Find a "triangles" line, then the next "end" line (could be immediately after, or after content)
    # Use a non-greedy match that handles BOTH "triangles\nend" and "triangles\n<content>\nend"
    # Strategy: find "triangles" at line start, match everything up to and including the next "end" at line start.
    pattern = re.compile(
        r'^triangles[ \t]*\r?\n'      # the "triangles" line, plus newline
        r'(?:.*\r?\n)*?'              # zero or more content lines (non-greedy)
        r'end[ \t]*\r?\n?',           # the "end" line, optional trailing newline
        re.MULTILINE
    )
    m = pattern.search(content)
    if not m:
        # Append if not found
        with open(triangles_file, 'r') as f:
            tri_content = f.read()
        content = content.rstrip() + '\n' + tri_content
    else:
        with open(triangles_file, 'r') as f:
            tri_content = f.read().rstrip()
        content = content[:m.start()] + tri_content + '\n' + content[m.end():]
    with open(smd_path, 'w') as f:
        f.write(content)


def main():
    if len(sys.argv) < 4:
        print(f"Usage: {sys.argv[0]} <weapon> <bf3_mdl_dir> <compile_source_dir>")
        print(f"Example: {sys.argv[0]} mp412 /home/z/my-project/repos/bf3_sweps_fresh/models/bf3/weapons /home/z/my-project/compile/mp412/source")
        sys.exit(1)
    weapon = sys.argv[1]
    bf3_dir = Path(sys.argv[2])
    src_dir = Path(sys.argv[3])

    mdl_path = bf3_dir / f"{weapon}.mdl"
    vvd_path = bf3_dir / f"{weapon}.vvd"
    vtx_path = bf3_dir / f"{weapon}.dx90.vtx"
    smd_path = src_dir / f"{weapon}.smd"

    print(f"[extract_mesh] weapon={weapon}")
    print(f"  mdl:  {mdl_path}")
    print(f"  vvd:  {vvd_path}")
    print(f"  vtx:  {vtx_path}")
    print(f"  smd:  {smd_path}")

    bf3_bones = parse_mdl_bones(mdl_path)
    print(f"  BF3 bones: {len(bf3_bones)}")

    smd_bone_list = parse_smd_bones(smd_path)
    print(f"  SMD bones: {len(smd_bone_list)}")

    mdl_meshes = parse_mdl_meshes(mdl_path)
    print(f"  MDL meshes: {len(mdl_meshes)}")
    for m in mdl_meshes:
        print(f"    mesh[{m['bodypart']}/{m['model']}/{m['mesh']}]: tex='{m['texture_name']}' verts={m['numverts']} offset={m['vertexoffset']}")

    vvd_verts = parse_vvd(vvd_path)
    print(f"  VVD vertices: {len(vvd_verts)}")

    vtx_meshes = parse_vtx(vtx_path)
    total_tris = sum(len(vm['triangles']) for vm in vtx_meshes)
    print(f"  VTX meshes: {len(vtx_meshes)}, total triangles: {total_tris}")

    # Build bone index map
    bone_map = build_bone_index_map(bf3_bones, smd_bone_list)
    unmapped = [i for i, (n, _) in enumerate(bf3_bones) if map_bone_name(n) not in {x[1] for x in smd_bone_list} and n not in {x[1] for x in smd_bone_list}]
    if unmapped:
        print(f"  WARNING: {len(unmapped)} BF3 bones have no SMD counterpart:")
        for i in unmapped[:10]:
            print(f"    [{i}] '{bf3_bones[i][0]}' -> '{map_bone_name(bf3_bones[i][0])}'")

    tri_file = src_dir / f"{weapon}_triangles.smd.part"
    n_tris = write_triangles_section(tri_file, bf3_bones, smd_bone_list, vvd_verts, vtx_meshes, mdl_meshes)
    print(f"  Wrote {n_tris} triangles to {tri_file}")

    merge_triangles_into_smd(smd_path, tri_file)
    print(f"  Merged triangles into {smd_path}")
    print(f"  DONE.")


if __name__ == '__main__':
    main()

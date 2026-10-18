using System;
using System.IO;
using System.Text;
using System.Collections.Generic;
using System.Globalization;

namespace CrowbarDecompiler
{
    class MdlDecompiler
    {
        private string mdlPath;
        private string outputDir;
        private string weaponName;
        private BinaryReader reader;
        private byte[] data;
        
        // Header fields
        private int numbones, boneindex;
        private int numlocalseq, localseqindex;
        private int numtextures, textureindex;
        private int numcdtextures, cdtextureindex;
        private int numskinref, numskinfamilies, skinindex;
        private int numbodyparts, bodypartindex;
        private int numattachments, attachmentindex;
        private float[] illumposition = new float[3];
        private float[] hullMin = new float[3];
        private float[] hullMax = new float[3];
        private int surfacepropindex;
        
        const int BONE_SIZE = 216;
        
        public MdlDecompiler(string mdlPath, string outputDir)
        {
            this.mdlPath = mdlPath;
            this.outputDir = outputDir;
            this.weaponName = Path.GetFileNameWithoutExtension(mdlPath);
            this.data = File.ReadAllBytes(mdlPath);
        }
        
        public void Decompile()
        {
            ParseHeader();
            var bones = ParseBones();
            var bodyparts = ParseBodyparts();
            var sequences = ParseSequences();
            var attachments = ParseAttachments(bones);
            var cdtextures = ParseCdTextures();
            var textures = ParseTextures();
            string surfaceprop = ReadString(surfacepropindex);
            
            WriteQC(bones, bodyparts, sequences, attachments, cdtextures, textures, surfaceprop);
            WriteReferenceSMD(bones);
            WriteAnimationSMDs(bones, sequences);
        }
        
        private int ReadInt(int offset)
        {
            return BitConverter.ToInt32(data, offset);
        }
        
        private float ReadFloat(int offset)
        {
            return BitConverter.ToSingle(data, offset);
        }
        
        private string ReadString(int offset)
        {
            if (offset <= 0 || offset >= data.Length) return "";
            int end = offset;
            while (end < data.Length && data[end] != 0) end++;
            return Encoding.ASCII.GetString(data, offset, end - offset);
        }
        
        private void ParseHeader()
        {
            if (data[0] != (byte)'I' || data[1] != (byte)'D' || data[2] != (byte)'S' || data[3] != (byte)'T')
                throw new Exception("Not a valid MDL file");
            
            illumposition[0] = ReadFloat(92);
            illumposition[1] = ReadFloat(96);
            illumposition[2] = ReadFloat(100);
            hullMin[0] = ReadFloat(104); hullMin[1] = ReadFloat(108); hullMin[2] = ReadFloat(112);
            hullMax[0] = ReadFloat(116); hullMax[1] = ReadFloat(120); hullMax[2] = ReadFloat(124);
            
            numbones = ReadInt(156);
            boneindex = ReadInt(160);
            numlocalseq = ReadInt(188);
            localseqindex = ReadInt(192);
            numtextures = ReadInt(204);
            textureindex = ReadInt(208);
            numcdtextures = ReadInt(212);
            cdtextureindex = ReadInt(216);
            numskinref = ReadInt(220);
            numskinfamilies = ReadInt(224);
            skinindex = ReadInt(228);
            numbodyparts = ReadInt(232);
            bodypartindex = ReadInt(236);
            numattachments = ReadInt(240);
            attachmentindex = ReadInt(244);
            surfacepropindex = ReadInt(288);
        }
        
        class Bone
        {
            public string name;
            public int parent;
            public float[] pos = new float[3];
            public float[] rot = new float[3];
        }
        
        private List<Bone> ParseBones()
        {
            var bones = new List<Bone>();
            for (int i = 0; i < numbones; i++)
            {
                int off = boneindex + i * BONE_SIZE;
                if (off + BONE_SIZE > data.Length) break;
                var b = new Bone();
                int sznameindex = ReadInt(off);
                b.parent = ReadInt(off + 4);
                b.pos[0] = ReadFloat(off + 32);
                b.pos[1] = ReadFloat(off + 36);
                b.pos[2] = ReadFloat(off + 40);
                b.rot[0] = ReadFloat(off + 44);
                b.rot[1] = ReadFloat(off + 48);
                b.rot[2] = ReadFloat(off + 52);
                b.name = sznameindex > 0 ? ReadString(off + sznameindex) : $"bone_{i}";
                bones.Add(b);
            }
            return bones;
        }
        
        class Bodypart
        {
            public string name;
            public int nummodels;
        }
        
        private List<Bodypart> ParseBodyparts()
        {
            var bps = new List<Bodypart>();
            const int BP_SIZE = 16;
            for (int i = 0; i < numbodyparts; i++)
            {
                int off = bodypartindex + i * BP_SIZE;
                if (off + BP_SIZE > data.Length) break;
                var bp = new Bodypart();
                int nameoffset = ReadInt(off);
                bp.nummodels = ReadInt(off + 4);
                bp.name = nameoffset > 0 ? ReadString(off + nameoffset) : $"bodypart_{i}";
                bps.Add(bp);
            }
            return bps;
        }
        
        class Sequence
        {
            public string name;
        }
        
        private List<Sequence> ParseSequences()
        {
            var seqs = new List<Sequence>();
            int offset = localseqindex;
            const int SEQ_SIZE = 212;
            for (int i = 0; i < numlocalseq; i++)
            {
                if (offset + 8 > data.Length) break;
                int sznameindex = ReadInt(offset + 4);
                var seq = new Sequence();
                seq.name = sznameindex > 0 ? ReadString(offset + sznameindex) : $"seq_{i}";
                seqs.Add(seq);
                offset += SEQ_SIZE;
            }
            return seqs;
        }
        
        class Attachment
        {
            public string name;
            public string bone;
            public float[] pos = new float[3];
            public float[] rot = new float[3];
        }
        
        private List<Attachment> ParseAttachments(List<Bone> bones)
        {
            var atts = new List<Attachment>();
            const int ATTACH_SIZE = 92;
            for (int i = 0; i < numattachments; i++)
            {
                int off = attachmentindex + i * ATTACH_SIZE;
                if (off + ATTACH_SIZE > data.Length) break;
                var a = new Attachment();
                int nameoffset = ReadInt(off);
                int localbone = ReadInt(off + 8);
                a.pos[0] = ReadFloat(off + 12); a.pos[1] = ReadFloat(off + 16); a.pos[2] = ReadFloat(off + 20);
                a.rot[0] = ReadFloat(off + 24); a.rot[1] = ReadFloat(off + 28); a.rot[2] = ReadFloat(off + 32);
                a.name = nameoffset > 0 ? ReadString(off + nameoffset) : $"attachment_{i}";
                a.bone = (localbone >= 0 && localbone < bones.Count) ? bones[localbone].name : "";
                atts.Add(a);
            }
            return atts;
        }
        
        private List<string> ParseCdTextures()
        {
            var cdt = new List<string>();
            for (int i = 0; i < numcdtextures; i++)
            {
                int off = cdtextureindex + i * 4;
                if (off + 4 > data.Length) break;
                int name_off = ReadInt(off);
                cdt.Add(ReadString(cdtextureindex + name_off));
            }
            return cdt;
        }
        
        private List<string> ParseTextures()
        {
            var texs = new List<string>();
            const int TEX_SIZE = 64;
            for (int i = 0; i < numtextures; i++)
            {
                int off = textureindex + i * TEX_SIZE;
                if (off + TEX_SIZE > data.Length) break;
                int name_off = ReadInt(off);
                texs.Add(name_off > 0 ? ReadString(off + name_off) : $"texture_{i}");
            }
            return texs;
        }
        
        private string F(float v) { return v.ToString("F6", CultureInfo.InvariantCulture); }
        
        private void WriteQC(List<Bone> bones, List<Bodypart> bodyparts, List<Sequence> sequences,
            List<Attachment> attachments, List<string> cdtextures, List<string> textures, string surfaceprop)
        {
            var sb = new StringBuilder();
            sb.AppendLine($"// Decompiled from {weaponName}.mdl");
            sb.AppendLine($"$modelname \"weapons/c_{weaponName}.mdl\"");
            sb.AppendLine();
            
            foreach (var bp in bodyparts)
            {
                sb.AppendLine($"$bodygroup \"{bp.name}\"");
                sb.AppendLine("{");
                if (bp.name == "hands")
                    sb.AppendLine("\tblank");
                else
                    sb.AppendLine($"\tstudio \"{weaponName}.smd\"");
                sb.AppendLine("}");
            }
            sb.AppendLine();
            
            sb.AppendLine($"$surfaceprop \"{(string.IsNullOrEmpty(surfaceprop) ? "default" : surfaceprop)}\"");
            sb.AppendLine("$contents \"solid\"");
            sb.AppendLine($"$illumposition {F(illumposition[0])} {F(illumposition[1])} {F(illumposition[2])}");
            sb.AppendLine();
            
            foreach (var cd in cdtextures)
                sb.AppendLine($"$cdmaterials \"{cd}\"");
            sb.AppendLine();
            
            if (textures.Count > 0)
            {
                sb.AppendLine("$texturegroup \"skinfamilies\"");
                sb.AppendLine("{");
                sb.AppendLine("\t{");
                foreach (var tex in textures)
                    sb.AppendLine($"\t\t\"{tex}\"");
                sb.AppendLine("\t}");
                sb.AppendLine("}");
                sb.AppendLine();
            }
            
            sb.AppendLine($"$bbox {F(hullMin[0])} {F(hullMin[1])} {F(hullMin[2])} {F(hullMax[0])} {F(hullMax[1])} {F(hullMax[2])}");
            sb.AppendLine("$cbox 0 0 0 0 0 0");
            sb.AppendLine();
            
            foreach (var att in attachments)
                sb.AppendLine($"$attachment \"{att.name}\" \"{att.bone}\" {F(att.pos[0])} {F(att.pos[1])} {F(att.pos[2])} rotate {F(att.rot[0])} {F(att.rot[1])} {F(att.rot[2])}");
            sb.AppendLine();
            
            foreach (var b in bones)
            {
                string parentName = (b.parent >= 0 && b.parent < bones.Count) ? bones[b.parent].name : "";
                sb.AppendLine($"$definebone \"{b.name}\" \"{parentName}\" {F(b.pos[0])} {F(b.pos[1])} {F(b.pos[2])} {F(b.rot[0])} {F(b.rot[1])} {F(b.rot[2])} 0.000000 0.000000 0.000000 0.000000 0.000000 0.000000");
            }
            sb.AppendLine();
            
            foreach (var seq in sequences)
            {
                sb.AppendLine($"$sequence \"{seq.name}\" {{");
                sb.AppendLine($"\t\"{weaponName}_anims/{seq.name}.smd\"");
                sb.AppendLine($"\tfps 30");
                sb.AppendLine("}");
                sb.AppendLine();
            }
            
            File.WriteAllText(Path.Combine(outputDir, $"{weaponName}.qc"), sb.ToString());
        }
        
        private void WriteReferenceSMD(List<Bone> bones)
        {
            var sb = new StringBuilder();
            sb.AppendLine($"// Decompiled reference SMD for {weaponName}");
            sb.AppendLine("version 1");
            sb.AppendLine("nodes");
            for (int i = 0; i < bones.Count; i++)
                sb.AppendLine($"{i} \"{bones[i].name}\" {bones[i].parent}");
            sb.AppendLine("end");
            sb.AppendLine("skeleton");
            sb.AppendLine("time 0");
            for (int i = 0; i < bones.Count; i++)
                sb.AppendLine($"{i} {F(bones[i].pos[0])} {F(bones[i].pos[1])} {F(bones[i].pos[2])} {F(bones[i].rot[0])} {F(bones[i].rot[1])} {F(bones[i].rot[2])}");
            sb.AppendLine("end");
            sb.AppendLine("triangles");
            sb.AppendLine("end");
            
            File.WriteAllText(Path.Combine(outputDir, $"{weaponName}.smd"), sb.ToString());
        }
        
        private void WriteAnimationSMDs(List<Bone> bones, List<Sequence> sequences)
        {
            string animsDir = Path.Combine(outputDir, $"{weaponName}_anims");
            Directory.CreateDirectory(animsDir);
            
            foreach (var seq in sequences)
            {
                var sb = new StringBuilder();
                sb.AppendLine($"// Animation: {seq.name}");
                sb.AppendLine("version 1");
                sb.AppendLine("nodes");
                for (int i = 0; i < bones.Count; i++)
                    sb.AppendLine($"{i} \"{bones[i].name}\" {bones[i].parent}");
                sb.AppendLine("end");
                sb.AppendLine("skeleton");
                sb.AppendLine("time 0");
                for (int i = 0; i < bones.Count; i++)
                    sb.AppendLine($"{i} {F(bones[i].pos[0])} {F(bones[i].pos[1])} {F(bones[i].pos[2])} {F(bones[i].rot[0])} {F(bones[i].rot[1])} {F(bones[i].rot[2])}");
                sb.AppendLine("end");
                
                File.WriteAllText(Path.Combine(animsDir, $"{seq.name}.smd"), sb.ToString());
            }
        }
    }
}

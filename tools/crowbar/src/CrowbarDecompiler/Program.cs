using System;
using System.IO;
using System.Text;
using System.Collections.Generic;

namespace CrowbarDecompiler
{
    class Program
    {
        static int Main(string[] args)
        {
            if (args.Length < 2)
            {
                Console.Error.WriteLine("Usage: crowbar-decompile <input.mdl> <output_dir>");
                return 1;
            }

            string mdlPath = args[0];
            string outputDir = args[1];

            if (!File.Exists(mdlPath))
            {
                Console.Error.WriteLine($"ERROR: File not found: {mdlPath}");
                return 1;
            }

            Directory.CreateDirectory(outputDir);
            
            try
            {
                var decompiler = new MdlDecompiler(mdlPath, outputDir);
                decompiler.Decompile();
                Console.WriteLine($"OK: {Path.GetFileNameWithoutExtension(mdlPath)} decompiled");
                return 0;
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine($"FAIL: {ex.Message}");
                return 1;
            }
        }
    }
}

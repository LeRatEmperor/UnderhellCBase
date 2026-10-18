#!/usr/bin/env python3
"""
Generate a C++ stub implementation of IFileSystem by parsing the
source-sdk-2013 filesystem.h header. This produces a stub .so that
implements all IAppSystem + IBaseFileSystem + IFileSystem methods,
with the few that studiomdl actually calls doing real work (using
POSIX file I/O) and the rest returning safe defaults.
"""
import re
import sys
from pathlib import Path

SDK = Path("/home/z/my-project/repos/source-sdk-2013/src/public")
HEADER = SDK / "filesystem.h"
APP_HEADER = SDK / "appframework" / "IAppSystem.h"

text = HEADER.read_text(errors="ignore")
app_text = APP_HEADER.read_text(errors="ignore")

# Find the IFileSystem class declaration. It starts at "abstract_class IFileSystem"
# and ends at the matching closing brace at column 0.
m = re.search(r'abstract_class IFileSystem[^{]*\{', text)
if not m:
    print("Cannot find IFileSystem class", file=sys.stderr)
    sys.exit(1)

start = m.end()
depth = 1
i = start
while i < len(text) and depth > 0:
    if text[i] == '{':
        depth += 1
    elif text[i] == '}':
        depth -= 1
    i += 1
class_body = text[start:i-1]

# Also extract IBaseFileSystem (parent) so we can stub its methods too
m = re.search(r'abstract_class IBaseFileSystem[^{]*\{', text)
if not m:
    print("Cannot find IBaseFileSystem class", file=sys.stderr); sys.exit(1)
start = m.end()
depth = 1
i = start
while i < len(text) and depth > 0:
    if text[i] == '{':
        depth += 1
    elif text[i] == '}':
        depth -= 1
    i += 1
base_body = text[start:i-1]

# IAppSystem
m = re.search(r'abstract_class IAppSystem[^{]*\{', app_text)
if not m:
    print("Cannot find IAppSystem class", file=sys.stderr); sys.exit(1)
start = m.end()
depth = 1
i = start
while i < len(app_text) and depth > 0:
    if app_text[i] == '{':
        depth += 1
    elif app_text[i] == '}':
        depth -= 1
    i += 1
app_body = app_text[start:i-1]

# Extract pure virtual declarations. These look like:
#   virtual <ret> <name>( <args> ) <const?> = 0;
# They may span multiple lines.
def extract_pure_virtuals(body):
    # Find every "virtual" keyword followed by something ending in "= 0;"
    # The function name is the LAST identifier before the opening paren.
    # Return type is everything between "virtual" and the function name.
    pat = re.compile(
        r'virtual\s+(?P<rest>[^;{}]*?)\)\s*(?P<const>const)?\s*=\s*0\s*;',
        re.DOTALL
    )
    results = []
    for m in pat.finditer(body):
        rest = m.group('rest')
        # rest contains "<ret> <name>(<args" up to the last ')'
        # The function name is the LAST identifier before the FIRST '('
        # (because args themselves may contain parens like OUT_Z_CAP(x)).
        first_paren = rest.find('(')
        if first_paren < 0:
            continue
        before_paren = rest[:first_paren]
        args = rest[first_paren+1:]
        # Strip leading/trailing whitespace from before_paren
        before_paren = before_paren.strip()
        # Function name is the last identifier in before_paren.
        m2 = re.search(r'(\w+)\s*$', before_paren)
        if not m2:
            continue
        name = m2.group(1)
        # Return type is before_paren minus the name
        ret = before_paren[:m2.start()].strip()
        # Cleanup
        ret = re.sub(r'\s+', ' ', ret)
        args = re.sub(r'\s+', ' ', args).strip()
        is_const = bool(m.group('const'))
        results.append((ret, name, args, is_const))
    return results

app_methods = extract_pure_virtuals(app_body)
base_methods = extract_pure_virtuals(base_body)
fs_methods = extract_pure_virtuals(class_body)

print(f"// IAppSystem: {len(app_methods)} methods", file=sys.stderr)
print(f"// IBaseFileSystem: {len(base_methods)} methods", file=sys.stderr)
print(f"// IFileSystem: {len(fs_methods)} methods", file=sys.stderr)

# Methods that need real implementations
REAL_IMPL = {
    # IAppSystem
    'Connect': 'return true;',
    'Disconnect': '',
    'QueryInterface': 'if (pInterfaceName && !strcmp(pInterfaceName, FILESYSTEM_INTERFACE_VERSION)) return (void*)(IFileSystem*)this; return nullptr;',
    'Init': 'return INIT_OK;',
    'Shutdown': '',
    # IBaseFileSystem
    'Read': 'if (!file || !pOutput || size <= 0) return 0; return (int)fread(pOutput, 1, (size_t)size, (FILE*)file);',
    'Write': 'if (!file || !pInput || size <= 0) return 0; return (int)fwrite(pInput, 1, (size_t)size, (FILE*)file);',
    'Open': 'if (!pFileName || !pOptions) return nullptr; return (FileHandle_t)fopen(pFileName, pOptions);',
    'Close': 'if (file) fclose((FILE*)file);',
    'Seek': 'if (!file) return; int w = SEEK_SET; if (seekType == FILESYSTEM_SEEK_CURRENT) w = SEEK_CUR; else if (seekType == FILESYSTEM_SEEK_TAIL) w = SEEK_END; fseek((FILE*)file, pos, w);',
    'Tell': 'if (!file) return 0; return (unsigned int)ftell((FILE*)file);',
    'Size': 'if (!file) return 0; FILE* f = (FILE*)file; long cur = ftell(f); fseek(f, 0, SEEK_END); long end = ftell(f); fseek(f, cur, SEEK_SET); return end > 0 ? (unsigned int)end : 0;',
    'Flush': 'if (file) fflush((FILE*)file);',
    'FileExists': 'if (!pFileName) return false; struct stat st; return stat(pFileName, &st) == 0;',
    'IsFileWritable': 'if (!pFileName) return false; return access(pFileName, W_OK) == 0;',
    'SetFileWritable': 'if (!pFileName) return false; return chmod(pFileName, writable ? 0644 : 0444) == 0;',
    'GetFileTime': 'if (!pFileName) return 0; struct stat st; if (stat(pFileName, &st) != 0) return 0; return (long)st.st_mtime;',
    'ReadFile': 'return false; // CUtlBuffer overload - not used by studiomdl',
    'WriteFile': 'return false; // CUtlBuffer overload - not used by studiomdl',
    # IFileSystem
    'IsSteam': 'return false;',
    'MountSteamContent': 'return FILESYSTEM_MOUNT_OK;',
    'AddSearchPath': '',
    'RemoveSearchPath': 'return true;',
    'RemoveAllSearchPaths': '',
    'RemoveSearchPaths': '',
    'MarkPathIDByRequestOnly': '',
    'RelativePathToFullPath': 'if (pDest && maxLenInChars > 0) { strncpy(pDest, pFileName ? pFileName : "", maxLenInChars); pDest[maxLenInChars-1] = 0; } return pDest;',
    'GetSearchPath': 'if (pDest && maxLenInChars > 0) { strncpy(pDest, ".", maxLenInChars); pDest[maxLenInChars-1] = 0; return 1; } return 0;',
    'FindFirst': 'return nullptr; // simplified - studiomdl usually has the file directly',
    'FindNext': 'return nullptr;',
    'FindClose': '',
    'FindIsDirectory': 'return false;',
    'IsDirectory': 'if (!pFileName) return false; struct stat st; if (stat(pFileName, &st) != 0) return false; return S_ISDIR(st.st_mode);',
    'LoadModule': 'return nullptr; // studiomdl falls back gracefully',
    'UnloadModule': '',
    'GetLocalPath': 'if (pDest && maxLenInChars > 0) { strncpy(pDest, pFileName ? pFileName : "", maxLenInChars); pDest[maxLenInChars-1] = 0; } return pDest;',
    'RenameFile': 'return rename(pOldPath, pNewPath) == 0;',
}

# Default return expressions based on return type
def default_return(ret):
    ret = ret.strip()
    if ret == 'void':
        return ''
    if ret == 'bool':
        return 'return false;'
    if ret in ('int', 'unsigned int', 'uint32', 'int32', 'long', 'unsigned long', 'int64', 'uint64', 'FSAsyncStatus_t', 'FilesystemMountRetval_t'):
        return 'return 0;'
    if ret == 'InitReturnVal_t':
        return 'return INIT_OK;'
    if ret.startswith('const char') or ret.startswith('char *') or ret == 'char*':
        return 'return nullptr;'
    if ret.startswith('FileHandle_t') or ret.startswith('void *') or ret.startswith('void*') or ret == 'CSysModule *' or ret == 'FSAsyncControl_t':
        return 'return nullptr;'
    if 'CRC32_t' in ret or 'FileCRCStatus_t' in ret:
        return 'return 0;'
    # Fallback
    return 'return {};'

# Generate the .cpp file
out = []
out.append('// AUTO-GENERATED by gen_fs_stub.py')
out.append('// Stub implementation of filesystem_stdio.so for studiomdl on Linux.')
out.append('//')
out.append('// Inherits IFileSystem (which inherits IAppSystem + IBaseFileSystem)')
out.append('// so the compiler lays out the vtable correctly. All methods are')
out.append('// provided; the few that studiomdl actually uses (Open/Read/Write/')
out.append('// Close/Size/IsSteam/FileExists/etc) do real POSIX I/O, the rest')
out.append('// return safe defaults.')
out.append('')
out.append('#include <cstdio>')
out.append('#include <cstdlib>')
out.append('#include <cstring>')
out.append('#include <sys/stat.h>')
out.append('#include <sys/types.h>')
out.append('#include <dirent.h>')
out.append('#include <unistd.h>')
out.append('#include <errno.h>')
out.append('')
out.append('#include "tier1/utlbuffer.h"')
out.append('#include "tier1/utlvector.h"')
out.append('#include "appframework/IAppSystem.h"')
out.append('#include "filesystem.h"')
out.append('#include "tier1/interface.h"')
out.append('')
out.append('// Helper: implement IBaseFileSystem::Size(name, pathID) - takes a filename not a handle')
out.append('// We use an overload marker to distinguish in REAL_IMPL.')
out.append('')
out.append('class CStubFileSystem : public IFileSystem')
out.append('{')
out.append('public:')

# Emit all methods
emitted = set()
def emit(ret, name, args, is_const, body_source='interface'):
    sig_const = ' const' if is_const else ''
    # Skip duplicates (some methods declared multiple times in header)
    key = (name, args, is_const)
    if key in emitted:
        return
    emitted.add(key)
    # Get body
    if name in REAL_IMPL:
        body = REAL_IMPL[name]
    else:
        body = default_return(ret)
    # Clean up args - normalize whitespace
    args_clean = re.sub(r'\s+', ' ', args).strip()
    # For the second Size overload (by name), give it a different body
    if name == 'Size' and 'pFileName' in args and 'FileHandle_t' not in args:
        body = 'if (!pFileName) return 0; struct stat st; if (stat(pFileName, &st) != 0) return 0; return (unsigned int)st.st_size;'
    # Strip // comments from body (they would swallow the trailing brace on same line)
    body = re.sub(r'//[^\n]*', '', body)
    # Emit on multiple lines so any '}' in body doesn't break parsing
    out.append(f'    virtual {ret} {name}({args_clean}){sig_const}')
    out.append(f'    {{')
    out.append(f'        {body}')
    out.append(f'    }}')

# Note: IAppSystem and IBaseFileSystem methods are inherited via IFileSystem.
# We override them as 'virtual' which the compiler accepts even without 'override'
# (override is just a hint).
for ret, name, args, is_const in app_methods:
    emit(ret, name, args, is_const, 'app')
for ret, name, args, is_const in base_methods:
    emit(ret, name, args, is_const, 'base')
for ret, name, args, is_const in fs_methods:
    emit(ret, name, args, is_const, 'fs')

out.append('};')
out.append('')
out.append('static CStubFileSystem g_FilesystemSingleton;')
out.append('')
out.append('extern "C" __attribute__((visibility("default"))) void* CreateInterface(const char *pName, int *pReturnCode)')
out.append('{')
out.append('    if (pName && !strcmp(pName, FILESYSTEM_INTERFACE_VERSION)) {')
out.append('        if (pReturnCode) *pReturnCode = 0;')
out.append('        return (void*)(IFileSystem*)&g_FilesystemSingleton;')
out.append('    }')
out.append('    if (pReturnCode) *pReturnCode = 1;')
out.append('    return nullptr;')
out.append('}')

print('\n'.join(out))

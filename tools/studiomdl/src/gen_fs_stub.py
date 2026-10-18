#!/usr/bin/env python3
"""
Generate a C++ stub implementation of filesystem_stdio.so for studiomdl.
Parses IFileSystem from source-sdk-2013 headers and generates a stub class
that inherits from IFileSystem (so compiler handles vtable layout correctly).
"""
import re, sys
from pathlib import Path

SDK = Path("/home/z/my-project/repos/source-sdk-2013/src/public")
HEADER = SDK / "filesystem.h"
APP_HEADER = SDK / "appframework" / "IAppSystem.h"

text = HEADER.read_text(errors="ignore")
app_text = APP_HEADER.read_text(errors="ignore")

def extract_class_body(text, class_name):
    m = re.search(r'abstract_class\s+' + class_name + r'[^{]*\{', text)
    if not m:
        return ""
    start = m.end()
    depth = 1
    i = start
    while i < len(text) and depth > 0:
        if text[i] == '{': depth += 1
        elif text[i] == '}': depth -= 1
        i += 1
    return text[start:i-1]

class_body = extract_class_body(text, "IFileSystem")
base_body = extract_class_body(text, "IBaseFileSystem")
app_body = extract_class_body(app_text, "IAppSystem")

def extract_pure_virtuals(body):
    pat = re.compile(
        r'virtual\s+(?P<rest>[^;{}]*?)\)\s*(?P<const>const)?\s*=\s*0\s*;',
        re.DOTALL
    )
    results = []
    for m in pat.finditer(body):
        rest = m.group('rest')
        first_paren = rest.find('(')
        if first_paren < 0: continue
        before_paren = rest[:first_paren].strip()
        args = rest[first_paren+1:]
        m2 = re.search(r'(\w+)\s*$', before_paren)
        if not m2: continue
        name = m2.group(1)
        ret = before_paren[:m2.start()].strip()
        ret = re.sub(r'\s+', ' ', ret)
        args = re.sub(r'\s+', ' ', args).strip()
        is_const = bool(m.group('const'))
        results.append((ret, name, args, is_const))
    return results

app_methods = extract_pure_virtuals(app_body)
base_methods = extract_pure_virtuals(base_body)
fs_methods = extract_pure_virtuals(class_body)

REAL_IMPL = {
    'Connect': 'return true;',
    'Disconnect': '',
    'QueryInterface': 'if (pInterfaceName && !strcmp(pInterfaceName, FILESYSTEM_INTERFACE_VERSION)) return (void*)(IFileSystem*)this; return nullptr;',
    'Init': 'return INIT_OK;',
    'Shutdown': '',
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
    'ReadFile': 'return false;',
    'WriteFile': 'return false;',
    'IsSteam': 'return false;',
    'MountSteamContent': 'return FILESYSTEM_MOUNT_OK;',
    'AddSearchPath': '',
    'RemoveSearchPath': 'return true;',
    'RemoveAllSearchPaths': '',
    'RemoveSearchPaths': '',
    'MarkPathIDByRequestOnly': '',
    'RelativePathToFullPath': 'if (pDest && maxLenInChars > 0) { strncpy(pDest, pFileName ? pFileName : "", maxLenInChars); pDest[maxLenInChars-1] = 0; } return pDest;',
    'GetSearchPath': 'if (pDest && maxLenInChars > 0) { strncpy(pDest, ".", maxLenInChars); pDest[maxLenInChars-1] = 0; return 1; } return 0;',
    'FindFirst': 'return nullptr;',
    'FindNext': 'return nullptr;',
    'FindClose': '',
    'FindIsDirectory': 'return false;',
    'IsDirectory': 'if (!pFileName) return false; struct stat st; if (stat(pFileName, &st) != 0) return false; return S_ISDIR(st.st_mode);',
    'LoadModule': 'return nullptr;',
    'UnloadModule': '',
    'GetLocalPath': 'if (pDest && maxLenInChars > 0) { strncpy(pDest, pFileName ? pFileName : "", maxLenInChars); pDest[maxLenInChars-1] = 0; } return pDest;',
    'RenameFile': 'return rename(pOldPath, pNewPath) == 0;',
}

def default_return(ret):
    ret = ret.strip()
    if ret == 'void': return ''
    if ret == 'bool': return 'return false;'
    if ret in ('int','unsigned int','uint32','int32','long','unsigned long','int64','uint64','FSAsyncStatus_t','FilesystemMountRetval_t'): return 'return 0;'
    if ret == 'InitReturnVal_t': return 'return INIT_OK;'
    if ret.startswith('const char') or ret.startswith('char *'): return 'return nullptr;'
    if ret.startswith('FileHandle_t') or ret.startswith('void *'): return 'return nullptr;'
    if ret.startswith('CSysModule *'): return 'return nullptr;'
    if 'CRC32_t' in ret: return 'return 0;'
    return 'return {};'

out = []
out.append('// AUTO-GENERATED filesystem_stdio.so stub')
out.append('#include <cstdio>')
out.append('#include <cstdlib>')
out.append('#include <cstring>')
out.append('#include <sys/stat.h>')
out.append('#include <dirent.h>')
out.append('#include <unistd.h>')
out.append('#include "tier1/utlbuffer.h"')
out.append('#include "tier1/utlvector.h"')
out.append('#include "appframework/IAppSystem.h"')
out.append('#include "filesystem.h"')
out.append('#include "tier1/interface.h"')
out.append('')
out.append('class CStubFileSystem : public IFileSystem')
out.append('{')
out.append('public:')

emitted = set()
def emit(ret, name, args, is_const):
    key = (name, args, is_const)
    if key in emitted: return
    emitted.add(key)
    body = REAL_IMPL.get(name, default_return(ret))
    args_clean = re.sub(r'\s+', ' ', args).strip()
    if name == 'Size' and 'pFileName' in args and 'FileHandle_t' not in args:
        body = 'if (!pFileName) return 0; struct stat st; if (stat(pFileName, &st) != 0) return 0; return (unsigned int)st.st_size;'
    body = re.sub(r'//[^\n]*', '', body)
    sig_const = ' const' if is_const else ''
    out.append(f'    virtual {ret} {name}({args_clean}){sig_const}')
    out.append(f'    {{')
    out.append(f'        {body}')
    out.append(f'    }}')

for ret, name, args, is_const in app_methods: emit(ret, name, args, is_const)
for ret, name, args, is_const in base_methods: emit(ret, name, args, is_const)
for ret, name, args, is_const in fs_methods: emit(ret, name, args, is_const)

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

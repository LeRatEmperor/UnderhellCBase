# file

**Realm:** Shared, Menu  ·  **Members:** 13

The file library provides functions for finding, reading and writing to files. 
The following path values are most commonly used:
* `LUA` searches the lua files (in /lua/, in your gamemodes, in all the addons).
* `GAME` searches all the mounted content (main folder, addons, mounted games etc).
* `MOD` searches only the garrysmod folder.
* `DATA` searches in the data folder.

See [File Search Paths](https://wiki.facepunch.com/gmod/File%20Search%20Paths) for the descriptive list of path values.
For the full list of path values, type `path` in the console.

[wiki page](https://wiki.facepunch.com/gmod/file)

### file.Append · Shared, Menu
`file.Append(name: string, content: string) → boolean`

Appends data to a file in the `data/` folder.

**Arguments:**
- `name` (string) — The file's name.
- `content` (string) — The content which should be appended to the file.

**Returns:**
- boolean — If the operation was successful.

[wiki](https://wiki.facepunch.com/gmod/file.Append) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/file.lua#L31-L39)

---

### file.AsyncRead · Shared
`file.AsyncRead(fileName: string, gamePath: string, callback: function, sync: boolean = false) → number{FSASYNC}`

Returns the content of a file asynchronously.

All limitations of [file.Read](https://wiki.facepunch.com/gmod/file.Read) also apply.

**Arguments:**
- `fileName` (string) — The name of the file.
- `gamePath` (string) — The path to look for the files and directories in.
- `callback` (function) — A callback function that will be called when the file read operation finishes.
- `sync` (boolean, default `false`) — If `true` the file will be read synchronously.

**Returns:**
- `status` (number{FSASYNC}) — FSASYNC_OK on success, FSASYNC_ERR_ on failure.

[wiki](https://wiki.facepunch.com/gmod/file.AsyncRead)

---

### file.CreateDir · Shared, Menu
`file.CreateDir(name: string)`

Creates a directory that is relative to the `data` folder.

**Arguments:**
- `name` (string) — The directory's name.

[wiki](https://wiki.facepunch.com/gmod/file.CreateDir)

---

### file.Delete · Shared, Menu
`file.Delete(name: string, path: string = DATA) → boolean`

Deletes a file or `empty` folder that is relative to the **data** folder. You can't remove any files outside of **data** folder.

**Arguments:**
- `name` (string) — The file name.
- `path` (string, default `DATA`) — The path to look for the files and directories in.

**Returns:**
- `success` (boolean)

> **Note:** You are able to delete **any** file in the Menu state.

[wiki](https://wiki.facepunch.com/gmod/file.Delete)

---

### file.Exists · Shared, Menu
`file.Exists(name: string, gamePath: string) → boolean`

Returns a boolean of whether the file or directory exists or not.    
		If you want to check for a directory, [file.IsDir](https://wiki.facepunch.com/gmod/file.IsDir) will be faster since it won't check for files.

**Arguments:**
- `name` (string) — The file or directory's name.
- `gamePath` (string) — The path to look for the files and directories in.

**Returns:**
- boolean — Returns `true` if the file exists and `false` if it does not.

[wiki](https://wiki.facepunch.com/gmod/file.Exists)

---

### file.Find · Shared, Menu
`file.Find(name: string, path: string, sorting: string = nameasc) → table, table`

Returns a list of files and directories inside a single folder.

**Arguments:**
- `name` (string) — The wildcard to search for.
- `path` (string) — The path to look for the files and directories in.
- `sorting` (string, default `nameasc`) — The sorting to be used, optional.

**Returns:**
- table — A table of found files, or `nil` if the path is invalid.
- table — A table of found directories, or `nil` if the path is invalid.

> **Warning:** It seems that paths with capital letters (e.g. lua/MyFolder/*) don't work as expected on Linux.

[wiki](https://wiki.facepunch.com/gmod/file.Find)

---

### file.IsDir · Shared, Menu
`file.IsDir(fileName: string, gamePath: string) → boolean`

Returns whether the given file is a directory or not.

**Arguments:**
- `fileName` (string) — The file or directory's name.
- `gamePath` (string) — The path to look for the files and directories in.

**Returns:**
- boolean — `true` if the given path is a directory or `false` if it's a file.

[wiki](https://wiki.facepunch.com/gmod/file.IsDir)

---

### file.Open · Shared, Menu
`file.Open(fileName: string, fileMode: string, gamePath: string) → file_class`

Attempts to open a file with the given mode.

**Arguments:**
- `fileName` (string) — The files name.
- `fileMode` (string) — The mode to open the file in.
- `gamePath` (string) — The path to look for the files and directories in.

**Returns:**
- `File` (file_class) — The opened file object, or `nil` if it failed to open due to it not existing or being used by another process.

> **Warning:** When trying to open files with the following characteristics, it returns nil:
> 
> the file extension is ".db; .mdmp; .dmp" or 
> the file is "server.cfg; autoexec.cfg; config.cfg; listenserver.cfg; mount.cfg"

[wiki](https://wiki.facepunch.com/gmod/file.Open)

---

### file.Read · Shared, Menu
`file.Read(fileName: string, gamePath: string = DATA) → string`

Returns the content of a file.

**Arguments:**
- `fileName` (string) — The name of the file.
- `gamePath` (string, default `DATA`) — The path to look for the files and directories in.

**Returns:**
- string — The data from the file as a string, or `nil` if the file isn't found.

> **Warning:** Beware of casing -- some filesystems are case-sensitive. SRCDS on Linux seems to force file/directory creation to lowercase, but will not modify read operations.

[wiki](https://wiki.facepunch.com/gmod/file.Read) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/file.lua#L4-L19)

---

### file.Rename · Shared, Menu
`file.Rename(orignalFileName: string, targetFileName: string) → boolean`

Attempts to rename a file with the given name to another given name.

This function is constrained to the `data/` folder.

**Arguments:**
- `orignalFileName` (string) — The original file or folder name.
- `targetFileName` (string) — The target file or folder name.

**Returns:**
- boolean — `true` on success, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/file.Rename)

---

### file.Size · Shared, Menu
`file.Size(fileName: string, gamePath: string) → number`

Returns the file's size in bytes.

**Arguments:**
- `fileName` (string) — The file's name.
- `gamePath` (string) — The path to look for the files and directories in.

**Returns:**
- number — The file size in bytes, or `-1` if the file is not found.

[wiki](https://wiki.facepunch.com/gmod/file.Size)

---

### file.Time · Shared, Menu
`file.Time(path: string, gamePath: string) → number`

Returns when the file or folder was last modified in Unix time.

**Arguments:**
- `path` (string) — The file or folder path.
- `gamePath` (string) — The path to look for the files and directories in.

**Returns:**
- number — Seconds passed since Unix epoch, or `0` if the file is not found.

[wiki](https://wiki.facepunch.com/gmod/file.Time)

---

### file.Write · Shared, Menu
`file.Write(fileName: string, content: string) → boolean`

Writes the given string to a file. Erases all previous data in the file. To add data without deleting previous data, use [file.Append](https://wiki.facepunch.com/gmod/file.Append).

**Arguments:**
- `fileName` (string) — The name of the file being written into.
- `content` (string) — The content that will be written into the file.

**Returns:**
- boolean — If the operation was successful.

[wiki](https://wiki.facepunch.com/gmod/file.Write) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/file.lua#L21-L29)

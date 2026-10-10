# util

**Realm:** Shared, Menu  ·  **Members:** 91

This is the list of utility functions.

[wiki page](https://wiki.facepunch.com/gmod/util)

### util.AddNetworkString · Server
`util.AddNetworkString(str: string) → number`

Adds the specified string to a string table, which will cache it and network it to all clients automatically.
Whenever you want to create a net message with [net.Start](https://wiki.facepunch.com/gmod/net.Start), you must add the name of that message as a networked string via this function.

If the passed string already exists, nothing will happen and the ID of the existing item will be returned.

**Arguments:**
- `str` (string) — Adds the specified string to the string table.

**Returns:**
- number — The id of the string that was added to the string table.

> **Note:** Each unique network name needs to be pooled once - do not put this function call into any other functions if you're using a constant string. Preferable place for this function is in a serverside lua file, or in a shared file with the [net.Receive](https://wiki.facepunch.com/gmod/net.Receive) function.
> 
> The string table used for this function does not interfere with the engine string tables and has 4095 slots.  
> This limit is shared among all entities, SetNW* and SetGlobal* functions. If you exceed the limit, you cannot create new variables, and you will get the following warning:
> ```lua 
> Warning:  Table networkstring is full, can't add [key]
> ```

[wiki](https://wiki.facepunch.com/gmod/util.AddNetworkString)

---

### util.AimVector · Shared, Menu
`util.AimVector(ViewAngles: Angle, ViewFOV: number, x: number, y: number, scrWidth: number, scrHeight: number) → Vector`

Function used to calculate aim vector from 2D screen position. It is used in SuperDOF calculate Distance.

Essentially a generic version of [gui.ScreenToVector](https://wiki.facepunch.com/gmod/gui.ScreenToVector).

**Arguments:**
- `ViewAngles` (Angle) — View angles
- `ViewFOV` (number) — View Field of View
- `x` (number) — Mouse X position
- `y` (number) — Mouse Y position
- `scrWidth` (number) — Screen width
- `scrHeight` (number) — Screen height

**Returns:**
- Vector — Calculated aim vector

[wiki](https://wiki.facepunch.com/gmod/util.AimVector)

---

### util.Base64Decode · Shared, Menu
`util.Base64Decode(str: string) → string`

Decodes the specified string from base64.

**Arguments:**
- `str` (string) — String to decode.

**Returns:**
- string — The raw bytes of the decoded string.

[wiki](https://wiki.facepunch.com/gmod/util.Base64Decode)

---

### util.Base64Encode · Shared, Menu
`util.Base64Encode(str: string, inline: boolean = false) → string`

Encodes the specified string to base64.

**Arguments:**
- `str` (string) — String to encode.
- `inline` (boolean, default `false`) — `true` to disable RFC 2045 compliance (newline every 76th character)

**Returns:**
- string — Base 64 encoded string.

> **Note:** Unless disabled with the `inline` argument, the Base64 returned is compliant to the RFC 2045 standard. **This means it will have a line break after every 76th character.**

[wiki](https://wiki.facepunch.com/gmod/util.Base64Encode)

---

### util.BlastDamage · Server
`util.BlastDamage(inflictor: Entity, attacker: Entity, damageOrigin: Vector, damageRadius: number, damage: number)`

Applies explosion damage to all entities in the specified radius. Performs block checking.

**Arguments:**
- `inflictor` (Entity) — The entity that caused the damage.
- `attacker` (Entity) — The entity that attacked.
- `damageOrigin` (Vector) — The center of the explosion
- `damageRadius` (number) — The radius in which entities will be damaged.
- `damage` (number) — The amount of damage to be applied.

[wiki](https://wiki.facepunch.com/gmod/util.BlastDamage)

---

### util.BlastDamageInfo · Server
`util.BlastDamageInfo(dmg: CTakeDamageInfo, damageOrigin: Vector, damageRadius: number)`

Applies spherical damage based on damage info to all entities in the specified radius.

**Arguments:**
- `dmg` (CTakeDamageInfo) — The information about the damage
- `damageOrigin` (Vector) — Center of the spherical damage
- `damageRadius` (number) — The radius in which entities will be damaged.

[wiki](https://wiki.facepunch.com/gmod/util.BlastDamageInfo)

---

### util.Compress · Shared, Menu
`util.Compress(str: string) → string`

Compresses the given string using the [LZMA](https://en.wikipedia.org/wiki/LZMA) algorithm.

Use with [net.WriteData](https://wiki.facepunch.com/gmod/net.WriteData) and [net.ReadData](https://wiki.facepunch.com/gmod/net.ReadData) for networking and  [util.Decompress](https://wiki.facepunch.com/gmod/util.Decompress) to decompress the data.

**Arguments:**
- `str` (string) — String to compress.

**Returns:**
- string — The compressed string, or an empty string if the input string was zero length ("").

> **Note:** The output of this function will have the uncompressed size of the data prepended to it as an 8-byte little-endian integer. [Source](https://github.com/garrynewman/bootil/blob/beb4cec8ad29533965491b767b177dc549e62d23/src/Bootil/Utility/CompressionLZMA.cpp#L56-L63)
> 
> You may therefore experience issues using the output of this function **_outside of Garry's Mod_**. If you need to do this, you will need to manually strip the first 8 bytes from the compressed output, or use third-party tools such as [gmod-lzma](https://github.com/WilliamVenner/gmod-lzma-rs) to decompress the output instead.

[wiki](https://wiki.facepunch.com/gmod/util.Compress)

---

### util.CRC · Shared
`util.CRC(stringToChecksum: string) → string`

Generates the [CRC Checksum](https://en.wikipedia.org/wiki/Cyclic_redundancy_check) of the specified string.

**Arguments:**
- `stringToChecksum` (string) — The string to calculate the checksum of.

**Returns:**
- string — The unsigned 32 bit checksum.

> **Warning:** This is NOT a hashing function. It is a checksum, typically used for error detection/data corruption detection. It is possible for this function to generate "collisions", where two different strings will produce the same CRC. If you need a hashing function, use [util.SHA256](https://wiki.facepunch.com/gmod/util.SHA256).

[wiki](https://wiki.facepunch.com/gmod/util.CRC)

---

### util.DateStamp · Shared, Menu
`util.DateStamp() → string`

Returns the current date formatted like '2012-10-31 18-00-00'

**Returns:**
- string — date

[wiki](https://wiki.facepunch.com/gmod/util.DateStamp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L101-L106)

---

### util.Decal · Shared
`util.Decal(name: string, start: Vector, end: Vector, filter: Entity = NULL)`

Performs a trace and paints a decal to the surface hit.

**Arguments:**
- `name` (string) — The name of the decal to paint.
- `start` (Vector) — The start of the trace.
- `end` (Vector) — The end of the trace.
- `filter` (Entity, default `NULL`) — If set, the decal will not be able to be placed on given entity.

[wiki](https://wiki.facepunch.com/gmod/util.Decal)

---

### util.DecalEx · Client
`util.DecalEx(material: IMaterial, ent: Entity, position: Vector, normal: Vector, color: Color, w: number, h: number)`

Performs a trace and paints a decal to the surface hit.

**Arguments:**
- `material` (IMaterial) — The name of the decal to paint.
- `ent` (Entity) — The entity to apply the decal to
- `position` (Vector) — The position of the decal.
- `normal` (Vector) — The direction of the decal.
- `color` (Color) — The color of the decal.
- `w` (number) — The width scale of the decal.
- `h` (number) — The height scale of the decal.

> **Note:** This function has trouble spanning across multiple brushes on the map.

[wiki](https://wiki.facepunch.com/gmod/util.DecalEx)

---

### util.DecalMaterial · Shared
`util.DecalMaterial(decalName: string) → string`

Gets the full material path by the decal name. Used with [util.DecalEx](https://wiki.facepunch.com/gmod/util.DecalEx).

If decal specifies multiple materials, a random one will be chosen.

**Arguments:**
- `decalName` (string) — Name of the decal.

**Returns:**
- string — Material path of the decal.

[wiki](https://wiki.facepunch.com/gmod/util.DecalMaterial)

---

### util.Decompress · Shared, Menu
`util.Decompress(compressedString: string, maxSize: number = nil) → string|nil`

Decompresses the given string using [LZMA](https://en.wikipedia.org/wiki/LZMA) algorithm. Used to decompress strings previously compressed with [util.Compress](https://wiki.facepunch.com/gmod/util.Compress).

**Arguments:**
- `compressedString` (string) — The compressed string to decompress.
- `maxSize` (number, default `nil`) — The maximum size of uncompressed data in bytes, if greater it fails.

**Returns:**
- string|nil — The original, decompressed string or `nil` on failure or invalid input.

> **Note:** This function expects the compressed input data to have the uncompressed size of the data prepended to it as an 8-byte little-endian integer. [Source](https://github.com/garrynewman/bootil/blob/beb4cec8ad29533965491b767b177dc549e62d23/src/Bootil/Utility/CompressionLZMA.cpp#L101)
> 
> If your compressed input data was compressed by [util.Compress](https://wiki.facepunch.com/gmod/util.Compress), you don't need to worry about this - the uncompressed size of the data is already prepended to its output.
> 
> However, if your compressed data was produced using standard tools **_outside of Garry's Mod_**, you will need to manually prepend the length of the uncompressed data to its compressed form as an 8-byte little endian integer.
> **Warning:** When reading user data, always try to specify `maxSize` argument, otherwise the server can be [decompression bombed](https://en.wikipedia.org/wiki/Zip_bomb) with bad data that will fill up all Lua memory

[wiki](https://wiki.facepunch.com/gmod/util.Decompress)

---

### util.DistanceToLine · Shared
`util.DistanceToLine(lineStart: Vector, lineEnd: Vector, pointPos: Vector) → number, Vector, number`

Gets the distance between a line and a point in 3d space.

**Arguments:**
- `lineStart` (Vector) — Start of the line.
- `lineEnd` (Vector) — End of the line.
- `pointPos` (Vector) — The position of the point.

**Returns:**
- number — Distance from line.
- Vector — Nearest point on line.
- number — Distance along line from start.

[wiki](https://wiki.facepunch.com/gmod/util.DistanceToLine)

---

### util.Effect · Shared
`util.Effect(effectName: string, effectData: CEffectData, allowOverride: boolean = true, ignorePredictionOrRecipientFilter: boolean|CRecipientFilter = nil)`

Creates an effect with the specified data.

For Orange Box `.pcf` particles, see [ParticleEffect](https://wiki.facepunch.com/gmod/Global.ParticleEffect), [ParticleEffectAttach](https://wiki.facepunch.com/gmod/Global.ParticleEffectAttach) and  [CreateParticleSystem](https://wiki.facepunch.com/gmod/Global.CreateParticleSystem).

**Arguments:**
- `effectName` (string) — The name of the effect to create.
- `effectData` (CEffectData) — The effect data describing the effect.
- `allowOverride` (boolean, default `true`) — Whether Lua-defined effects should override engine-defined effects with the same name for this/single function call.
- `ignorePredictionOrRecipientFilter` (boolean|CRecipientFilter, default `nil`) — Can either be a boolean to ignore the prediction filter or a CRecipientFilter.

> **Note:** When dispatching an effect from the server, some values may be clamped for networking optimizations. Visit the Set accessors on [CEffectData](https://wiki.facepunch.com/gmod/CEffectData) to see which ones are affected.
> 
> You will need to couple this function with [IsFirstTimePredicted](https://wiki.facepunch.com/gmod/Global.IsFirstTimePredicted) if you want to use it in a [predicted hook](https://wiki.facepunch.com/gmod/Prediction).

[wiki](https://wiki.facepunch.com/gmod/util.Effect)

---

### util.FilterText · Client
`util.FilterText(str: string, context: number = TEXT_FILTER_UNKNOWN, player: Player = nil) → string`

Filters given text using Steam's filtering system. The function will obey local client's Steam settings for chat filtering:

**Arguments:**
- `str` (string) — String to filter.
- `context` (number, default `TEXT_FILTER_UNKNOWN`, enum [TEXT_FILTER](https://wiki.facepunch.com/gmod/Enums/TEXT_FILTER)) — Filtering context.
- `player` (Player, default `nil`) — Used to determine if the text should be filtered according to local user's Steam chat filtering settings.

**Returns:**
- string — The filtered text based on given settings.

> **Note:** In some cases, especially in a chatbox, messages from some players may return an empty string if the context argument used for filtering is `TEXT_FILTER_CHAT` and [if the local player has blocked the sender of the message on Steam](https://github.com/Facepunch/garrysmod-issues/issues/5161#issuecomment-1035153941).

[wiki](https://wiki.facepunch.com/gmod/util.FilterText)

---

### util.FullPathToRelative_Menu · Menu
`util.FullPathToRelative_Menu(fullPath: string, fsPath: string = MOD) → string`

Converts the full path of the given file to a relative path.  
		You can use [util.RelativePathToFull_Menu](https://wiki.facepunch.com/gmod/util.RelativePathToFull_Menu) to convert the relative path back to the full path.

**Arguments:**
- `fullPath` (string) — The full path to a file.
- `fsPath` (string, default `MOD`) — The path to look for the files and directories in.

**Returns:**
- `relativePath` (string) — The relative path to the given file.

[wiki](https://wiki.facepunch.com/gmod/util.FullPathToRelative_Menu)

---

### util.GetActivityIDByName · Shared
`util.GetActivityIDByName(a1: string) → number`

Returns the ID of a custom model activity. This is useful for models that define custom ones.

See [util.GetActivityNameByID](https://wiki.facepunch.com/gmod/util.GetActivityNameByID) for a function that does the opposite.

**Arguments:**
- `a1` (string) — The name of an activity, as defined in the model's `.qc` at compile time.

**Returns:**
- `id` (number) — The ID of the activity.

[wiki](https://wiki.facepunch.com/gmod/util.GetActivityIDByName)

---

### util.GetActivityNameByID · Shared
`util.GetActivityNameByID(id: number) → string`

Returns a name for given activity ID. This is useful for models that define custom activities.

See [util.GetActivityIDByName](https://wiki.facepunch.com/gmod/util.GetActivityIDByName) for a function that does the opposite.

**Arguments:**
- `id` (number, enum [ACT](https://wiki.facepunch.com/gmod/Enums/ACT)) — The ID of an activity from some hook.

**Returns:**
- string — The associated name with given activity ID.

[wiki](https://wiki.facepunch.com/gmod/util.GetActivityNameByID)

---

### util.GetAnimEventIDByName · Shared
`util.GetAnimEventIDByName(a1: string) → number`

Returns the ID of a custom model animation event. This is useful for models that define custom animation events.

See [util.GetAnimEventNameByID](https://wiki.facepunch.com/gmod/util.GetAnimEventNameByID) for a function that does the opposite.

**Arguments:**
- `a1` (string) — The name of an model animation event, as defined in the model's `.qc` at compile time.

**Returns:**
- `id` (number) — The ID of an animation event, typically for usage with ENTITY:HandleAnimEvent.

[wiki](https://wiki.facepunch.com/gmod/util.GetAnimEventIDByName)

---

### util.GetAnimEventNameByID · Shared
`util.GetAnimEventNameByID(id: number) → string`

Returns a name for given automatically generated numerical animation event ID. This is useful for models that define custom animation events.

See [util.GetAnimEventIDByName](https://wiki.facepunch.com/gmod/util.GetAnimEventIDByName) for a function that does the opposite.

**Arguments:**
- `id` (number) — The ID of an animation event, typically from ENTITY:HandleAnimEvent.

**Returns:**
- string — The associated name with given event ID.

[wiki](https://wiki.facepunch.com/gmod/util.GetAnimEventNameByID)

---

### util.GetModelInfo · Shared
`util.GetModelInfo(mdl: string) → table{ModelInfo}`

Returns a table containing the info about the model. The model will be loaded and cached if it was not previously.

See also [util.GetModelMeshes](https://wiki.facepunch.com/gmod/util.GetModelMeshes)

**Arguments:**
- `mdl` (string) — The model path to retrieve information about.

**Returns:**
- table{ModelInfo} — The model info.

> **Note:** This function will silently fail if used on models with following strings in them:
> * _shared
> * _anims
> * _gestures
> * _anim
> * _postures
> * _gst
> * _pst
> * _shd
> * _ss
> * _anm
> * _include

[wiki](https://wiki.facepunch.com/gmod/util.GetModelInfo)

---

### util.GetModelMeshes · Shared
`util.GetModelMeshes(model: string, lod: number = 0, bodygroupMask: string|number = 0, skin: number = 0) → table<Structures/ModelMeshData>, table<Structures/BoneBindPose>`

Retrieves vertex, triangle, and bone data for the visual meshes of a given model.

**Arguments:**
- `model` (string) — The full path to the model to get the visual meshes of.
- `lod` (number, default `0`) — Which of the model's Level of Detail (LOD) models to retrieve.
- `bodygroupMask` (string|number, default `0`) — The combination of bodygroups to retrieve meshes for.
- `skin` (number, default `0`) — Skin index.

**Returns:**
- `modelMeshes` (table<Structures/ModelMeshData>) — Each index in this table corresponds to a mesh within the model passed as an argument to this function.
- `modelBindPoses` (table<Structures/BoneBindPose>) — This tables indices are bone IDs for the Structures/BoneBindPose stored at each index.

> **Note:** This does not work on brush models (Models with names in the format `*number`)

[wiki](https://wiki.facepunch.com/gmod/util.GetModelMeshes)

---

### util.GetPData · Shared, Menu
`util.GetPData(steamID: string, name: string, default: any) → string`

Gets persistent data of an offline player using their SteamID.

See also [Player:GetPData](https://wiki.facepunch.com/gmod/Player:GetPData) for a more convenient version of this function for online players, [util.RemovePData](https://wiki.facepunch.com/gmod/util.RemovePData) and 
 [util.SetPData](https://wiki.facepunch.com/gmod/util.SetPData) for the other accompanying functions.

**Arguments:**
- `steamID` (string) — SteamID of the player, in the `STEAM_0:0:0` format.
- `name` (string) — Variable name to get the value of
- `default` (any) — The default value, in case there's nothing stored

**Returns:**
- string — The stored value

> **Note:** This function internally uses [util.SteamIDTo64](https://wiki.facepunch.com/gmod/util.SteamIDTo64), it previously utilized [Player:UniqueID](https://wiki.facepunch.com/gmod/Player:UniqueID) which can cause collisions (two or more players sharing the same PData entry). This function now only uses the old method as a fallback if the name isn't found.

[wiki](https://wiki.facepunch.com/gmod/util.GetPData) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L336-L344)

---

### util.GetPixelVisibleHandle · Client
`util.GetPixelVisibleHandle() → pixelvis_handle_t`

Creates a new PixVis handle. See [util.PixelVisible](https://wiki.facepunch.com/gmod/util.PixelVisible).

**Returns:**
- pixelvis_handle_t — PixVis

[wiki](https://wiki.facepunch.com/gmod/util.GetPixelVisibleHandle)

---

### util.GetPlayerTrace · Shared, Menu
`util.GetPlayerTrace(ply: Player, dir: Vector = ply:GetAimVector()) → table{Trace}`

Utility function to quickly generate a trace table that starts at the players view position, and ends `32768` units along a specified direction.

For usage with [util.TraceLine](https://wiki.facepunch.com/gmod/util.TraceLine) and similar functions.

**Arguments:**
- `ply` (Player) — The player the trace should be based on
- `dir` (Vector, default `ply:GetAimVector()`) — The direction of the trace.

**Returns:**
- table{Trace} — The trace data.

[wiki](https://wiki.facepunch.com/gmod/util.GetPlayerTrace) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L37-L49)

---

### util.GetSunInfo · Client
`util.GetSunInfo() → table`

Gets information about the sun position and obstruction or nil if there is no sun.

**Returns:**
- table — The sun info.

[wiki](https://wiki.facepunch.com/gmod/util.GetSunInfo)

---

### util.GetSurfaceData · Shared
`util.GetSurfaceData(id: number) → table{SurfacePropertyData}`

Returns data of a [surface property](https://developer.valvesoftware.com/wiki/Material_surface_properties) at given ID. New surface properties can be added via [physenv.AddSurfaceData](https://wiki.facepunch.com/gmod/physenv.AddSurfaceData).

**Arguments:**
- `id` (number) — Surface property ID.

**Returns:**
- table{SurfacePropertyData} — The data or no value if there is no valid surface property at given index.

[wiki](https://wiki.facepunch.com/gmod/util.GetSurfaceData)

---

### util.GetSurfaceIndex · Shared
`util.GetSurfaceIndex(surfaceName: string) → number`

Returns the matching surface property index for the given surface property name.

See also [util.GetSurfaceData](https://wiki.facepunch.com/gmod/util.GetSurfaceData) and [util.GetSurfacePropName](https://wiki.facepunch.com/gmod/util.GetSurfacePropName) for opposite function.

**Arguments:**
- `surfaceName` (string) — The name of the surface.

**Returns:**
- number — The surface property index, or -1 if name doesn't correspond to a valid surface property.

[wiki](https://wiki.facepunch.com/gmod/util.GetSurfaceIndex)

---

### util.GetSurfacePropName · Shared
`util.GetSurfacePropName(id: number) → string`

Returns the name of a surface property at given ID.

See also [util.GetSurfaceData](https://wiki.facepunch.com/gmod/util.GetSurfaceData) and [util.GetSurfaceIndex](https://wiki.facepunch.com/gmod/util.GetSurfaceIndex) for opposite function.

**Arguments:**
- `id` (number) — Surface property ID.

**Returns:**
- string — The name or an empty string if there is no valid surface property at given index.

[wiki](https://wiki.facepunch.com/gmod/util.GetSurfacePropName)

---

### util.GetUserGroups · Server
`util.GetUserGroups() → table`

Returns a table of all SteamIDs that have a usergroup.

**Returns:**
- table — A table of users where the key is the SteamID of the user and the value is a table with 2 fields: * string name - Player Steam name * string group - Player usergroup name

> **Note:** This returns the original usergroups table, changes done to this table are not retroactive and will only affect newly connected users
> **Note:** This returns only groups that are registered in the **settings/users.txt** file of your server.  
> 
> In order to get the usergroup of a connected player, please use [Player:GetUserGroup](https://wiki.facepunch.com/gmod/Player:GetUserGroup) instead.

[wiki](https://wiki.facepunch.com/gmod/util.GetUserGroups) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/player_auth.lua#L99-L103)

---

### util.IntersectRayWithOBB · Shared
`util.IntersectRayWithOBB(rayStart: Vector, rayDelta: Vector, boxOrigin: Vector, boxAngles: Angle, boxMins: Vector, boxMaxs: Vector) → Vector, Vector, number`

Performs a Ray-OBB (Orientated Bounding Box) intersection and returns position, normal and the fraction if there was an intersection.

**Arguments:**
- `rayStart` (Vector) — Origin or start position of the ray.
- `rayDelta` (Vector) — The ray vector itself, the ray end point relative to the start point.
- `boxOrigin` (Vector) — The center of the box.
- `boxAngles` (Angle) — The angle of the box.
- `boxMins` (Vector) — The min position of the box.
- `boxMaxs` (Vector) — The max position of the box.

**Returns:**
- Vector — Hit position, nil if not hit.
- Vector — Normal/direction vector, nil if not hit.
- number — Fraction of trace used, nil if not hit.

[wiki](https://wiki.facepunch.com/gmod/util.IntersectRayWithOBB)

---

### util.IntersectRayWithPlane · Shared
`util.IntersectRayWithPlane(rayOrigin: Vector, rayDirection: Vector, planePosition: Vector, planeNormal: Vector) → Vector`

Performs a [ray-plane intersection](https://en.wikipedia.org/wiki/Line%E2%80%93plane_intersection) and returns the hit position or nil.

**Arguments:**
- `rayOrigin` (Vector) — Origin/start position of the ray.
- `rayDirection` (Vector) — The direction of the ray.
- `planePosition` (Vector) — Any position of the plane.
- `planeNormal` (Vector) — The normal vector of the plane.

**Returns:**
- Vector — The position of intersection, nil if not hit.

[wiki](https://wiki.facepunch.com/gmod/util.IntersectRayWithPlane)

---

### util.IntersectRayWithSphere · Shared
`util.IntersectRayWithSphere(rayOrigin: Vector, rayDelta: Vector, spherePosition: Vector, sphereRadius: number) → number, number`

Performs a ray-sphere intersection and returns the intersection positions or nil.

**Arguments:**
- `rayOrigin` (Vector) — Origin/start position of the ray.
- `rayDelta` (Vector) — The end position of the ray relative to the start position.
- `spherePosition` (Vector) — Any position of the sphere.
- `sphereRadius` (number) — The radius of the sphere.

**Returns:**
- number — The first intersection position along the ray, or `nil` if there is no intersection.
- number — The second intersection position along the ray, or `nil` if there is no intersection.

[wiki](https://wiki.facepunch.com/gmod/util.IntersectRayWithSphere)

---

### util.IsBinaryModuleInstalled · Shared, Menu
`util.IsBinaryModuleInstalled(name: string) → boolean`

Returns whether a binary module is installed and is resolvable by [require](https://wiki.facepunch.com/gmod/Global.require).

**Arguments:**
- `name` (string) — Name of the binary module, exactly the same as you would enter it as the argument to require.

**Returns:**
- boolean — Whether the binary module is installed and require can resolve it.

[wiki](https://wiki.facepunch.com/gmod/util.IsBinaryModuleInstalled) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L394-L418)

---

### util.IsBoxIntersectingBox · Shared
`util.IsBoxIntersectingBox(boxMin: Vector, boxMax: Vector, box2Min: Vector, box2Max: Vector) → boolean`

Performs a box-box intersection and returns whether there was an intersection or not.

**Arguments:**
- `boxMin` (Vector) — The minimum extents of the Axis-Aligned box.
- `boxMax` (Vector) — The maximum extents of the Axis-Aligned box.
- `box2Min` (Vector) — The minimum extents of the second Axis-Aligned box.
- `box2Max` (Vector) — The maximum extents of the second Axis-Aligned box.

**Returns:**
- boolean — `true` if there is an intersection, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/util.IsBoxIntersectingBox)

---

### util.IsBoxIntersectingSphere · Shared
`util.IsBoxIntersectingSphere(boxMin: Vector, boxMax: Vector, shpere2Position: Vector, sphere2Radius: number) → boolean`

Performs a box-sphere intersection and returns whether there was an intersection or not.

**Arguments:**
- `boxMin` (Vector) — The minimum extents of the Axis-Aligned box.
- `boxMax` (Vector) — The maximum extents of the Axis-Aligned box.
- `shpere2Position` (Vector) — Any position of the sphere.
- `sphere2Radius` (number) — The radius of the sphere.

**Returns:**
- boolean — `true` if there is an intersection, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/util.IsBoxIntersectingSphere)

---

### util.IsInWorld · Server
`util.IsInWorld(position: Vector) → boolean`

Checks if a certain position is within the world bounds.

**Arguments:**
- `position` (Vector) — Position to check.

**Returns:**
- boolean — Whether the vector is in world.

[wiki](https://wiki.facepunch.com/gmod/util.IsInWorld)

---

### util.IsModelLoaded · Shared
`util.IsModelLoaded(modelName: string) → boolean`

Checks if the model is loaded in the game.

**Arguments:**
- `modelName` (string) — Name/Path of the model to check.

**Returns:**
- boolean — Returns true if the model is loaded in the game; otherwise false.

[wiki](https://wiki.facepunch.com/gmod/util.IsModelLoaded)

---

### util.IsOBBIntersectingOBB · Shared
`util.IsOBBIntersectingOBB(box1Origin: Vector, box1Angles: Angle, box1Mins: Vector, box1Maxs: Vector, box2Origin: Vector, box2Angles: Angle, box2Mins: Vector, box2Maxs: Vector, tolerance: number) → boolean`

Performs OBB on OBB intersection test.

**Arguments:**
- `box1Origin` (Vector) — The center of the first box.
- `box1Angles` (Angle) — The angles of the first box.
- `box1Mins` (Vector) — The min position of the first box.
- `box1Maxs` (Vector) — The max position of the first box.
- `box2Origin` (Vector) — The center of the second box.
- `box2Angles` (Angle) — The angles of the second box.
- `box2Mins` (Vector) — The min position of the second box.
- `box2Maxs` (Vector) — The max position of the second box.
- `tolerance` (number) — Tolerance for error.

**Returns:**
- boolean — Whether there is an intersection.

[wiki](https://wiki.facepunch.com/gmod/util.IsOBBIntersectingOBB)

---

### util.IsPointInCone · Shared
`util.IsPointInCone(point: Vector, coneOrigin: Vector, coneAxis: Vector, coneSine: number, coneLength: number) → boolean`

Returns whether a point is within a cone or not.

**Arguments:**
- `point` (Vector) — The position of the point to test.
- `coneOrigin` (Vector) — The position of the cone tip.
- `coneAxis` (Vector) — The direction of the cone.
- `coneSine` (number) — The sine of the cone's angle.
- `coneLength` (number) — Length of the cone's axis.

**Returns:**
- boolean — `true` if the point is within the cone, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/util.IsPointInCone)

---

### util.IsRayIntersectingRay · Shared
`util.IsRayIntersectingRay(ray1Start: Vector, ray1End: Vector, ray2Start: Vector, ray2End: Vector) → boolean, number, number`

Performs a ray-ray intersection and returns whether there was an intersection or not.

**Arguments:**
- `ray1Start` (Vector) — Start position of the first ray.
- `ray1End` (Vector) — End position of the first ray.
- `ray2Start` (Vector) — Start position of the second ray.
- `ray2End` (Vector) — End position of the second ray.

**Returns:**
- boolean — `true` if there is an intersection, `false` otherwise.
- number — Distance from start of ray 1 to the intersection, if there was one.
- number — Distance from start of ray 2 to the intersection, if there was one.

[wiki](https://wiki.facepunch.com/gmod/util.IsRayIntersectingRay)

---

### util.IsSkyboxVisibleFromPoint · Client
`util.IsSkyboxVisibleFromPoint(position: Vector) → boolean`

Check whether the skybox is visible from the point specified.

**Arguments:**
- `position` (Vector) — The position to check the skybox visibility from.

**Returns:**
- boolean — Whether the skybox is visible from the position.

> **Note:** This will always return true in fullbright maps.

[wiki](https://wiki.facepunch.com/gmod/util.IsSkyboxVisibleFromPoint)

---

### util.IsSphereIntersectingCone · Shared
`util.IsSphereIntersectingCone(sphereCenter: Vector, sphereRadius: number, coneOrigin: Vector, coneAxis: Vector, coneSine: number, coneCosine: number) → boolean`

Returns whether a sphere is intersecting a cone or not.

**Arguments:**
- `sphereCenter` (Vector) — The center position of the sphere to test.
- `sphereRadius` (number) — The radius of the sphere to test.
- `coneOrigin` (Vector) — The position of the cone tip.
- `coneAxis` (Vector) — The direction of the cone.
- `coneSine` (number) — The math.sin of the cone's angle.
- `coneCosine` (number) — The math.cos of the cone's angle.

**Returns:**
- boolean — `true` if the sphere intersects the cone, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/util.IsSphereIntersectingCone)

---

### util.IsSphereIntersectingSphere · Shared
`util.IsSphereIntersectingSphere(sphere1Position: Vector, sphere1Radius: number, sphere2Position: Vector, sphere2Radius: number) → boolean`

Performs a sphere-sphere intersection and returns whether there was an intersection or not.

**Arguments:**
- `sphere1Position` (Vector) — Any position of the first sphere.
- `sphere1Radius` (number) — The radius of the first sphere.
- `sphere2Position` (Vector) — Any position of the second sphere.
- `sphere2Radius` (number) — The radius of the second sphere.

**Returns:**
- boolean — `true` if there is an intersection, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/util.IsSphereIntersectingSphere)

---

### util.IsValidModel · Shared
`util.IsValidModel(modelName: string) → boolean`

Checks if the specified model is valid.
 

A model is considered invalid in following cases:
* Starts with a space or **maps**
* Doesn't start with **models**
* Contains any of the following:
  * `_gestures`
  * `_animations`
  * `_postures`
  * `_gst`
  * `_pst`
  * `_shd`
  * `_ss`
  * `_anm`
  * `.bsp`
  * `cs_fix`
* If the model isn't precached on the server, AND if the model file doesn't exist on disk
* If precache failed
* Model is the error model

Running this function will also precache the model.

**Arguments:**
- `modelName` (string) — Name/Path of the model to check.

**Returns:**
- boolean — Whether the model is valid or not.

[wiki](https://wiki.facepunch.com/gmod/util.IsValidModel)

---

### util.IsValidPhysicsObject · Shared
`util.IsValidPhysicsObject(ent: Entity, physobj: number) → boolean`

Checks whether the given numbered physics object of the given entity is valid or not. Most useful for ragdolls.

**Arguments:**
- `ent` (Entity) — The entity to take.
- `physobj` (number) — Number of the physics object to test.

**Returns:**
- boolean — `true` that's valid, `false` otherwise.

[wiki](https://wiki.facepunch.com/gmod/util.IsValidPhysicsObject) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L14-L30)

---

### util.IsValidProp · Shared
`util.IsValidProp(modelName: string) → boolean`

Checks if the specified prop is valid (has valid physics object).

**Arguments:**
- `modelName` (string) — Name/Path of the model to check.

**Returns:**
- boolean — Returns true if the specified prop is valid; otherwise false.

[wiki](https://wiki.facepunch.com/gmod/util.IsValidProp)

---

### util.IsValidRagdoll · Shared
`util.IsValidRagdoll(ragdollName: string) → boolean`

Checks if the specified model name points to a valid ragdoll.

**Arguments:**
- `ragdollName` (string) — Name/Path of the ragdoll model to check.

**Returns:**
- boolean — Returns true if the specified model name points to a valid ragdoll; otherwise false.

[wiki](https://wiki.facepunch.com/gmod/util.IsValidRagdoll)

---

### util.JSONToTable · Shared, Menu
`util.JSONToTable(json: string, ignoreLimits: boolean = false, ignoreConversions: boolean = false) → table|nil`

Converts a JSON string to a Lua table. It supports comments and trailing commas.

See [util.TableToJSON](https://wiki.facepunch.com/gmod/util.TableToJSON) for the opposite function.

**Arguments:**
- `json` (string) — The JSON string to convert.
- `ignoreLimits` (boolean, default `false`) — ignore the depth and breadth limits, use at your own risk!.
- `ignoreConversions` (boolean, default `false`) — ignore string to number conversions for table keys.

**Returns:**
- table|nil — The table containing converted information.

> **Bug** ([#2407](https://github.com/Facepunch/garrysmod/issues/2407)): Colors will not have the color metatable.

[wiki](https://wiki.facepunch.com/gmod/util.JSONToTable)

---

### util.KeyValuesToTable · Shared, Menu
`util.KeyValuesToTable(keyValues: string, usesEscapeSequences: boolean = false, preserveKeyCase: boolean = false) → table`

Converts a Valve KeyValue string (typically from [util.TableToKeyValues](https://wiki.facepunch.com/gmod/util.TableToKeyValues)) to a Lua table.

**Arguments:**
- `keyValues` (string) — The KeyValue string to convert.
- `usesEscapeSequences` (boolean, default `false`) — If set to true, will replace `\t`, `\n`, `\"` and `\\` in the input text with their escaped variants
- `preserveKeyCase` (boolean, default `false`) — Whether we should preserve key case (may fail) or not (always lowercase)

**Returns:**
- table — The converted table

> **Note:** Due to how [table](https://wiki.facepunch.com/gmod/table)s work in Lua, keys will not repeat within a table. See [util.KeyValuesToTablePreserveOrder](https://wiki.facepunch.com/gmod/util.KeyValuesToTablePreserveOrder) for alternative.

[wiki](https://wiki.facepunch.com/gmod/util.KeyValuesToTable)

---

### util.KeyValuesToTablePreserveOrder · Shared, Menu
`util.KeyValuesToTablePreserveOrder(keyvals: string, usesEscapeSequences: boolean = false, preserveKeyCase: boolean = false) → table`

Similar to [util.KeyValuesToTable](https://wiki.facepunch.com/gmod/util.KeyValuesToTable) but it also preserves order of keys.

**Arguments:**
- `keyvals` (string) — The key value string
- `usesEscapeSequences` (boolean, default `false`) — If set to true, will replace `\t`, `\n`, `\"` and `\\` in the input text with their escaped variants
- `preserveKeyCase` (boolean, default `false`) — Whether we should preserve key case (may fail) or not (always lowercase)

**Returns:**
- table — The output table

[wiki](https://wiki.facepunch.com/gmod/util.KeyValuesToTablePreserveOrder)

---

### util.LocalToWorld · Shared
`util.LocalToWorld(ent: Entity, lpos: Vector, bone: number = 0) → Vector`

A convenience function around LocalToWorld-related functions.

**Arguments:**
- `ent` (Entity) — The entity to take.
- `lpos` (Vector) — A local space vector.
- `bone` (number, default `0`) — Actually to be treated as the number corresponding to a specific PhysObj of the entity.

**Returns:**
- Vector — The corresponding worldspace vector.

> **Note:** If [Entity:EntIndex](https://wiki.facepunch.com/gmod/Entity:EntIndex) returns `0`, the function will return the passed `lpos`.

[wiki](https://wiki.facepunch.com/gmod/util.LocalToWorld) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L80-L95)

---

### util.MD5 · Shared
`util.MD5(stringToHash: string) → string`

Generates the [MD5 hash](https://en.wikipedia.org/wiki/MD5) of the specified string.

**Arguments:**
- `stringToHash` (string) — The string to calculate the MD5 hash of.

**Returns:**
- string — The MD5 hash of the string in hexadecimal form.

> **Warning:** MD5 is considered cryptographically broken and is known to be vulnerable to a variety of attacks including duplicate return values. If security or duplicate returns is a concern, use [util.SHA256](https://wiki.facepunch.com/gmod/util.SHA256).

[wiki](https://wiki.facepunch.com/gmod/util.MD5)

---

### util.NetworkIDToString · Shared
`util.NetworkIDToString(stringTableID: number) → string`

Returns the networked string associated with the given ID from the string table.

**Arguments:**
- `stringTableID` (number) — ID to get the associated string from.

**Returns:**
- string — The networked string, or nil if it wasn't found.

[wiki](https://wiki.facepunch.com/gmod/util.NetworkIDToString)

---

### util.NetworkStringToID · Shared
`util.NetworkStringToID(networkString: string) → number`

Returns the networked ID associated with the given string from the string table.

**Arguments:**
- `networkString` (string) — String to get the associated networked ID from.

**Returns:**
- number — The networked ID of the string, or 0 if it hasn't been networked with util.AddNetworkString.

[wiki](https://wiki.facepunch.com/gmod/util.NetworkStringToID)

---

### util.NiceFloat · Shared, Menu
`util.NiceFloat(float: number) → string`

Formats a float by stripping off extra `0's` and `.'s`.

**Arguments:**
- `float` (number) — The float to format.

**Returns:**
- string — Formatted float.

[wiki](https://wiki.facepunch.com/gmod/util.NiceFloat) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L155-L164)

---

### util.ParticleTracer · Shared
`util.ParticleTracer(name: string, startPos: Vector, endPos: Vector, doWhiz: boolean)`

Creates an orange box (.pcf) tracer effect with the given parameters. See [util.ParticleTracerEx](https://wiki.facepunch.com/gmod/util.ParticleTracerEx) for version with additional arguments.

Internally uses `ParticleTracer` engine effect. ([util.Effect](https://wiki.facepunch.com/gmod/util.Effect)) which then spawns in `ParticleEffect` effect.

**Arguments:**
- `name` (string) — The name of the .pcf particle effect to use for the tracer.
- `startPos` (Vector) — The start position of the tracer.
- `endPos` (Vector) — The end position of the tracer.
- `doWhiz` (boolean) — Whether to play the hit near-miss (whiz) sound.

> **Note:** The default bullet effect is not in .pcf format, therefore it is not used with util.ParticleTracer.  Consider utilizing [util.Effect](https://wiki.facepunch.com/gmod/util.Effect) instead

[wiki](https://wiki.facepunch.com/gmod/util.ParticleTracer)

---

### util.ParticleTracerEx · Shared
`util.ParticleTracerEx(name: string, startPos: Vector, endPos: Vector, doWhiz: boolean, entityIndex: number, attachmentIndex: number)`

Creates a tracer effect with the given parameters. Expanded version of [util.ParticleTracer](https://wiki.facepunch.com/gmod/util.ParticleTracer).

**Arguments:**
- `name` (string) — The name of the tracer effect.
- `startPos` (Vector) — The start position of the tracer.
- `endPos` (Vector) — The end position of the tracer.
- `doWhiz` (boolean) — Play the hit miss(whiz) sound.
- `entityIndex` (number) — Entity index of the emitting entity.
- `attachmentIndex` (number) — Attachment index to be used as origin.

[wiki](https://wiki.facepunch.com/gmod/util.ParticleTracerEx)

---

### util.PixelVisible · Client
`util.PixelVisible(position: Vector, size: number, PixVis: pixelvis_handle_t) → number`

Returns the visibility of a square that is always pointed at the camera in the world-space.

This is typically used for in-game sprites or "billboards". ([render.DrawSprite](https://wiki.facepunch.com/gmod/render.DrawSprite))

**Arguments:**
- `position` (Vector) — The center of the visibility test.
- `size` (number) — The size of the square to check for visibility.
- `PixVis` (pixelvis_handle_t) — The PixVis handle created with util.GetPixelVisibleHandle.

**Returns:**
- number — Visibility percentage, in range of `[0-1]`.

[wiki](https://wiki.facepunch.com/gmod/util.PixelVisible)

---

### util.PointContents · Shared
`util.PointContents(position: Vector) → number{CONTENTS}`

Returns the contents of the position specified.

**Arguments:**
- `position` (Vector) — Position to get the contents sample from.

**Returns:**
- number{CONTENTS} — Contents bitflag, see CONTENTS

> **Note:** This function will sample only the world environments. It can be used to check if [Entity:GetPos](https://wiki.facepunch.com/gmod/Entity:GetPos) is underwater for example unlike [Entity:WaterLevel](https://wiki.facepunch.com/gmod/Entity:WaterLevel) which works for players only.

[wiki](https://wiki.facepunch.com/gmod/util.PointContents)

---

### util.PrecacheModel · Shared
`util.PrecacheModel(modelName: string)`

Precaches a model for later use. Model is cached after being loaded once.

**Arguments:**
- `modelName` (string) — The model to precache.

> **Note:** Does nothing on the client.
> **Warning:** Modelprecache is limited to 8192 unique models. When it reaches the limit the game will crash.

[wiki](https://wiki.facepunch.com/gmod/util.PrecacheModel)

---

### util.PrecacheSound · Shared
`util.PrecacheSound(soundName: string)`

Precaches a sound for later use. Sound is cached after being loaded once.

**Arguments:**
- `soundName` (string) — The sound to precache.

> **Note:** Soundcache is limited to 16384 unique sounds on the server.
> **Bug:** Broken on purpose because hitting the limit above causes the server to shutdown
> **Bug:** Ultimately does nothing on client, and only works with sound scripts, not direct paths.

[wiki](https://wiki.facepunch.com/gmod/util.PrecacheSound)

---

### util.QuickTrace · Shared, Menu
`util.QuickTrace(origin: Vector, dir: Vector, filter: Entity|table<Entity>|table<string>|function = nil) → table{TraceResult}`

Performs a trace with the given origin, direction, and filter.

**Arguments:**
- `origin` (Vector) — The origin of the trace.
- `dir` (Vector) — The direction of the trace times the distance of the trace.
- `filter` (Entity|table<Entity>|table<string>|function, default `nil`) — Entity which should be ignored by the trace.

**Returns:**
- table{TraceResult} — Trace result.

> **Note:** This function will throw an error in the menu realm because it internally uses util.TraceLine which doesn't exist in the menu realm and thus error.

[wiki](https://wiki.facepunch.com/gmod/util.QuickTrace) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L56-L66)

---

### util.RelativePathToFull_Menu · Menu
`util.RelativePathToFull_Menu(filePath: string, mountPath: string = MOD) → string`

Converts the relative path of a given file to the full path on disk.  
		You can use [util.FullPathToRelative_Menu](https://wiki.facepunch.com/gmod/util.FullPathToRelative_Menu) to convert the full path back to the relative path.

**Arguments:**
- `filePath` (string) — The relative path of a file, for example: `addons/[Name].gma`
- `mountPath` (string, default `MOD`) — The path to look for the files and directories in.

**Returns:**
- `fullpath` (string) — The full path to the file.

[wiki](https://wiki.facepunch.com/gmod/util.RelativePathToFull_Menu)

---

### util.RelativePathToGMA_Menu · Menu
`util.RelativePathToGMA_Menu(filePath: string) → table`

Returns which Workshop addon the given file belongs to.

**Arguments:**
- `filePath` (string) — The relative path to a file, such as `materials/myMaterial.vmt`.

**Returns:**
- `addonInfo` (table) — The info about owner addon.

[wiki](https://wiki.facepunch.com/gmod/util.RelativePathToGMA_Menu)

---

### util.RemoveDecalsAt · Client
`util.RemoveDecalsAt(pos: Vector, distance: number, limit: number = 0, permanent: boolean = false) → number`

Removes world decals at given position, in given radius. Does not remove decals on models!

**Arguments:**
- `pos` (Vector) — The position at which to remove decals.
- `distance` (number) — Radius of the sphere to remove decals in.
- `limit` (number, default `0`) — If set to above 0, only remove this many decals.
- `permanent` (boolean, default `false`) — Whether to remove map-spawned decals (`true`), or only gameplay-spawned decals such as bullet holes or anything placed by util.Decal and similar(`false`)

**Returns:**
- `removed` (number) — How many decals were removed.

[wiki](https://wiki.facepunch.com/gmod/util.RemoveDecalsAt)

---

### util.RemovePData · Shared, Menu
`util.RemovePData(steamID: string, name: string)`

Removes persistent data of an offline player using their SteamID.

See also [Player:RemovePData](https://wiki.facepunch.com/gmod/Player:RemovePData) for a more convenient version of this function for online players, [util.SetPData](https://wiki.facepunch.com/gmod/util.SetPData) and 
 [util.GetPData](https://wiki.facepunch.com/gmod/util.GetPData) for the other accompanying functions.

**Arguments:**
- `steamID` (string) — SteamID of the player to remove data of, in the `STEAM_0:0:0` format.
- `name` (string) — Variable name to remove

> **Note:** This function internally uses [util.SteamIDTo64](https://wiki.facepunch.com/gmod/util.SteamIDTo64), it previously utilized [Player:UniqueID](https://wiki.facepunch.com/gmod/Player:UniqueID) which can cause collisions (two or more players sharing the same PData entry). This function now tries to remove both old and new entries.

[wiki](https://wiki.facepunch.com/gmod/util.RemovePData) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L361-L366)

---

### util.ScreenShake · Shared
`util.ScreenShake(pos: Vector, amplitude: number, frequency: number, duration: number, radius: number, airshake: boolean = false, filter: CRecipientFilter = nil)`

Makes the screen shake.

**Arguments:**
- `pos` (Vector) — The origin of the effect.
- `amplitude` (number) — The strength of the effect.
- `frequency` (number) — How many times per second to change the direction of the camera wobble.
- `duration` (number) — The duration of the effect in seconds.
- `radius` (number) — The range from the origin within which views will be affected, in Hammer units.
- `airshake` (boolean, default `false`) — Whether players in the air should also be affected.
- `filter` (CRecipientFilter, default `nil`) — If set, will only network the screen shake event to players present in the filter.

> **Note:** The screen shake effect is rendered by modifying the view origin on the client. If you override the view origin in [GM:CalcView](https://wiki.facepunch.com/gmod/GM:CalcView) you may not be able to see the shake effect.

[wiki](https://wiki.facepunch.com/gmod/util.ScreenShake)

---

### util.SetPData · Shared, Menu
`util.SetPData(steamID: string, name: string, value: any)`

Sets persistent data for offline player using their SteamID.

See also [Player:SetPData](https://wiki.facepunch.com/gmod/Player:SetPData) for a more convenient version of this function for online players, [util.RemovePData](https://wiki.facepunch.com/gmod/util.RemovePData) and 
 [util.GetPData](https://wiki.facepunch.com/gmod/util.GetPData) for the other accompanying functions.

**Arguments:**
- `steamID` (string) — SteamID of the player, in the `STEAM_0:0:0` format.
- `name` (string) — Variable name to store the value in.
- `value` (any) — The value to store.

> **Note:** This function internally uses [util.SteamIDTo64](https://wiki.facepunch.com/gmod/util.SteamIDTo64), it previously utilized [Player:UniqueID](https://wiki.facepunch.com/gmod/Player:UniqueID) which could have caused collisions (two or more players sharing the same PData entry).

[wiki](https://wiki.facepunch.com/gmod/util.SetPData) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L350-L355)

---

### util.SHA1 · Shared
`util.SHA1(stringToHash: string) → string`

Generates the [SHA-1 hash](https://en.wikipedia.org/wiki/SHA-1) of the specified string.

**Arguments:**
- `stringToHash` (string) — The string to calculate the SHA-1 hash of.

**Returns:**
- string — The SHA-1 hash of the string in hexadecimal form.

> **Warning:** SHA-1 is considered cryptographically broken and is known to be vulnerable to a variety of attacks. If security is a concern, use [util.SHA256](https://wiki.facepunch.com/gmod/util.SHA256).

[wiki](https://wiki.facepunch.com/gmod/util.SHA1)

---

### util.SHA256 · Shared
`util.SHA256(stringToHash: string) → string`

Generates the [SHA-256 hash](https://en.wikipedia.org/wiki/SHA-2) of the specified string. This is mostly unique and is astronomically unlikely to return the same hash for a different string unlike [util.CRC](https://wiki.facepunch.com/gmod/util.CRC) or [util.MD5](https://wiki.facepunch.com/gmod/util.MD5) which are both much more vulnerable to duplicate returns.

**Arguments:**
- `stringToHash` (string) — The string to calculate the SHA-256 hash of.

**Returns:**
- string — The SHA-256 hash of the string in hexadecimal form.

[wiki](https://wiki.facepunch.com/gmod/util.SHA256)

---

### util.SharedRandom · Shared
`util.SharedRandom(uniqueName: string, min: number, max: number, additionalSeed: number = 0) → number`

Generates a random float value that should be the same on client and server.



This uses a different method of obtaining random numbers and is unaffected by [math.randomseed](https://wiki.facepunch.com/gmod/math.randomseed). Instead it uses an internal seed that is based on the player's current predicted command and is fixed to a value of -1 outside of prediction.

**Arguments:**
- `uniqueName` (string) — The seed for the random value
- `min` (number) — The minimum value of the random range
- `max` (number) — The maximum value of the random range
- `additionalSeed` (number, default `0`) — The additional seed

**Returns:**
- number — The random float value

> **Note:** This function is best used in a [predicted hook](https://wiki.facepunch.com/gmod/prediction).

[wiki](https://wiki.facepunch.com/gmod/util.SharedRandom)

---

### util.SpriteTrail · Server
`util.SpriteTrail(ent: Entity, attachmentID: number, color: Color, additive: boolean, startWidth: number, endWidth: number, lifetime: number, textureRes: number, texture: string) → Entity`

Adds a trail to the specified entity.

**Arguments:**
- `ent` (Entity) — Entity to attach trail to
- `attachmentID` (number) — Attachment ID of the entities model to attach trail to.
- `color` (Color) — Color of the trail
- `additive` (boolean) — Should the trail be additive or not
- `startWidth` (number) — Start width of the trail
- `endWidth` (number) — End width of the trail
- `lifetime` (number) — How long it takes to transition from startWidth to endWidth
- `textureRes` (number) — The resolution of trails texture.
- `texture` (string) — Path to the texture to use as a trail.

**Returns:**
- Entity — Entity of created trail (env_spritetrail)

[wiki](https://wiki.facepunch.com/gmod/util.SpriteTrail)

---

### util.Stack · Shared, Menu
`util.Stack() → Stack`

Returns a new [Stack](https://wiki.facepunch.com/gmod/Stack) object.

**Returns:**
- Stack — A brand new stack object.

[wiki](https://wiki.facepunch.com/gmod/util.Stack) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L323-L325)

---

### util.SteamIDFrom64 · Shared
`util.SteamIDFrom64(id: string) → string`

Given a [64bit SteamID](https://wiki.facepunch.com/gmod/Player:SteamID64) will return a [STEAM_0:0:0](https://wiki.facepunch.com/gmod/Player:SteamID) style Steam ID.

**Arguments:**
- `id` (string) — The 64 bit Steam ID

**Returns:**
- string — String STEAM_0:0:0 style Steam ID representation.

> **Note:** This operation induces data loss. Not all fields of a [64bit SteamID](https://developer.valvesoftware.com/wiki/SteamID) can be represented using the `STEAM_0:0:0` format, specifically the "account type" and "account instance" fields.

[wiki](https://wiki.facepunch.com/gmod/util.SteamIDFrom64)

---

### util.SteamIDTo64 · Shared
`util.SteamIDTo64(id: string) → string`

Converts a [STEAM_0:0:0](https://wiki.facepunch.com/gmod/Player:SteamID) style SteamID to a [64bit SteamID](https://wiki.facepunch.com/gmod/Player:SteamID64).

**Arguments:**
- `id` (string) — The STEAM_0:0:0 format SteamID

**Returns:**
- string — 64bit SteamID or 0 (as a string) on fail

[wiki](https://wiki.facepunch.com/gmod/util.SteamIDTo64)

---

### util.StringToType · Shared, Menu
`util.StringToType(str: string, typename: string) → any`

Converts a string to the specified type.

This can be useful when dealing with ConVars.

**Arguments:**
- `str` (string) — The string to convert
- `typename` (string) — The type to attempt to convert the string to.

**Returns:**
- any — The result of the conversion, or nil if a bad type is specified.

[wiki](https://wiki.facepunch.com/gmod/util.StringToType) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L111-L124)

---

### util.TableToJSON · Shared, Menu
`util.TableToJSON(table: table, prettyPrint: boolean = false) → string`

Converts a table to a JSON string. Keep in mind that not every data type can be stored in the JSON format, notably any entity will not be written, as if it wasn't in the table. Same goes for materials and textures, etc.

See [util.JSONToTable](https://wiki.facepunch.com/gmod/util.JSONToTable) for the opposite function.

**Arguments:**
- `table` (table) — Table to convert.
- `prettyPrint` (boolean, default `false`) — Format and indent the JSON.

**Returns:**
- string — A JSON formatted string containing the serialized data

> **Warning:** All keys are strings in the JSON format, so all keys of other types will be converted to strings!  
> This can lead to loss of data where a number key could be converted into an already existing string key! (for example in a table like this: `{["5"] = "ok", [5] = "BBB"}`)

[wiki](https://wiki.facepunch.com/gmod/util.TableToJSON)

---

### util.TableToKeyValues · Shared, Menu
`util.TableToKeyValues(table: table, rootKey: string = TableToKeyValues) → string`

Converts the given table into a Valve key value string.

Use [util.KeyValuesToTable](https://wiki.facepunch.com/gmod/util.KeyValuesToTable) to perform the opposite transformation.

You should consider using [util.TableToJSON](https://wiki.facepunch.com/gmod/util.TableToJSON) instead.

**Arguments:**
- `table` (table) — The table to convert.
- `rootKey` (string, default `TableToKeyValues`) — The root key name for the output KV table.

**Returns:**
- string — The output.

[wiki](https://wiki.facepunch.com/gmod/util.TableToKeyValues)

---

### util.Timer · Shared, Menu
`util.Timer(duration: number = 0) → table`

Creates a timer object. The returned timer will be already started with given duration.

**Arguments:**
- `duration` (number, default `0`) — How long you want the timer to be.

**Returns:**
- table — A timer object.

[wiki](https://wiki.facepunch.com/gmod/util.Timer) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L216-L225)

---

### util.TimerCycle · Shared, Menu
`util.TimerCycle() → number`

Returns the time since this function has been last called

**Returns:**
- number — Time since this function has been last called in ms

[wiki](https://wiki.facepunch.com/gmod/util.TimerCycle)

---

### util.tobool · Shared, Menu · `DEPRECATED`
`util.tobool(input: any) → boolean`

Converts string or a number to a bool, if possible. Alias of [tobool](https://wiki.facepunch.com/gmod/Global.tobool).

**Arguments:**
- `input` (any) — A string or a number to convert.

**Returns:**
- boolean — False if the input is equal to the string or boolean "false", if the input is equal to the string or number "0", or if the input is nil.

[wiki](https://wiki.facepunch.com/gmod/util.tobool) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L251-L254)

---

### util.TraceEntity · Shared
`util.TraceEntity(tracedata: table{Trace}, ent: Entity) → table{TraceResult}`

Runs a trace using the entity's collisionmodel between two points. This does not take the entity's angles into account and will trace its unrotated collisionmodel.

**Arguments:**
- `tracedata` (table{Trace}) — Trace data.
- `ent` (Entity) — The entity to use

**Returns:**
- table{TraceResult} — Trace result.

[wiki](https://wiki.facepunch.com/gmod/util.TraceEntity)

---

### util.TraceEntityHull · Shared
`util.TraceEntityHull(tracedata: table{HullTrace}, ent: Entity) → table{TraceResult}`

Identical to [util.TraceHull](https://wiki.facepunch.com/gmod/util.TraceHull) but uses an entity's [Axis-Aligned Bounding Box (AABB)](https://en.wikipedia.org/wiki/Minimum_bounding_box) for `mins`/`maxs` inputs. (These 2 keys will be ignored in the provided table)

**Arguments:**
- `tracedata` (table{HullTrace}) — Trace data.
- `ent` (Entity) — The entity to use mins/maxs of for the hull trace.

**Returns:**
- table{TraceResult} — Trace result.

[wiki](https://wiki.facepunch.com/gmod/util.TraceEntityHull)

---

### util.TraceHull · Shared
`util.TraceHull(TraceData: table{HullTrace}) → table{TraceResult}`

Performs an AABB hull (axis-aligned bounding box, aka not rotated) trace with the given trace data.

This trace type cannot hit hitboxes.

See [util.TraceLine](https://wiki.facepunch.com/gmod/util.TraceLine) for a simple line ("ray") trace.

**Arguments:**
- `TraceData` (table{HullTrace}) — The trace data to use.

**Returns:**
- table{TraceResult} — Trace result.

> **Note:** This function may not always give desired results clientside due to certain physics mechanisms not existing on the client. Use it serverside for accurate results.

[wiki](https://wiki.facepunch.com/gmod/util.TraceHull)

---

### util.TraceLine · Shared
`util.TraceLine(traceConfig: table{Trace}) → table{TraceResult}`

Performs an infinitely thin, invisible ray trace (or "trace") in a line based on the input and returns a table that contains information about what, if anything, the trace line hit or intersected.

Traces intersect with the physics meshes of [solid](https://wiki.facepunch.com/gmod/enums/SOLID), [server-side](https://wiki.facepunch.com/gmod/States), [entities](https://wiki.facepunch.com/gmod/Entity) (including the [game world](https://wiki.facepunch.com/gmod/game.GetWorld)) but cannot detect client-side only entities unless [hitclientonly](https://wiki.facepunch.com/gmod/Structures/Trace#hitclientonly) is set to true.
  
See [ents.FindAlongRay](https://wiki.facepunch.com/gmod/ents.FindAlongRay) if you wish for the trace to not stop on first intersection.  
See [util.TraceHull](https://wiki.facepunch.com/gmod/util.TraceHull) for a "box" type trace.

Traces do not differentiate between the inside and the outside faces of physics meshes. Because of this, if a trace starts within a solid physics mesh it will hit the inside faces of the physics mesh and may return unexpected values as a result.


You can use `r_visualizetraces` set to `1` (requires `sv_cheats` set to `1`) to visualize traces in real time for debugging purposes.

**Arguments:**
- `traceConfig` (table{Trace}) — A table of data that configures the trace.

**Returns:**
- table{TraceResult} — A table of information detailing where and what the trace line intersected, or `nil` if the trace is being done before the GM:InitPostEntity hook.

[wiki](https://wiki.facepunch.com/gmod/util.TraceLine)

---

### util.TypeToString · Shared, Menu
`util.TypeToString(input: any) → string`

Converts a type to a (nice, but still parsable) string

**Arguments:**
- `input` (any) — What to convert

**Returns:**
- string — Converted string

[wiki](https://wiki.facepunch.com/gmod/util.TypeToString) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L129-L143)

---

### util.worldpicker.Active · Client
`util.worldpicker.Active() → boolean`

Returns if the user is currently picking an entity.

**Returns:**
- boolean — Is world picking

[wiki](https://wiki.facepunch.com/gmod/util.worldpicker.Active) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util/worldpicker.lua#L37-L37)

---

### util.worldpicker.Finish · Client · `INTERNAL`
`util.worldpicker.Finish(tr: table)`

Finishes the world picking. This is called when a user presses their mouse after calling [util.worldpicker.Start](https://wiki.facepunch.com/gmod/util.worldpicker.Start).

**Arguments:**
- `tr` (table) — Structures/TraceResult from the mouse press

[wiki](https://wiki.facepunch.com/gmod/util.worldpicker.Finish) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util/worldpicker.lua#L29-L35)

---

### util.worldpicker.Start · Client
`util.worldpicker.Start(callback: function)`

Starts picking an entity in the world. This will suppress the next mouse click, and instead use it as a direction in the trace sent to the callback.

**Arguments:**
- `callback` (function) — Function to call after an entity choice has been made.

[wiki](https://wiki.facepunch.com/gmod/util.worldpicker.Start) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util/worldpicker.lua#L18-L24)

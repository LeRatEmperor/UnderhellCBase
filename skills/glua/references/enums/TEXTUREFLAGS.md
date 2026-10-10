# TEXTUREFLAGS enumeration

**Realm:** Client  ·  **Constants:** 32

Bit flags used by [GetRenderTargetEx](https://wiki.facepunch.com/gmod/Global.GetRenderTargetEx). Information taken from [VTF (Valve Texture Format) - Texture flags](https://developer.valvesoftware.com/wiki/Valve_Texture_Format#Texture_flags)

[wiki page](https://wiki.facepunch.com/gmod/Enums/TEXTUREFLAGS)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `TEXTUREFLAGS_ALL_MIPS` | `1024` | Client | No Minimum Mipmap _(REF-ONLY)_ |
| `TEXTUREFLAGS_ANISOTROPIC` | `16` | Client | High quality texture filtering. _(REF-ONLY)_ |
| `TEXTUREFLAGS_BORDER` | `536870912` | Client | Clamp to border colour on all texture coordinates _(REF-ONLY)_ |
| `TEXTUREFLAGS_CLAMPS` | `4` | Client | Clamp S coordinates. _(REF-ONLY)_ |
| `TEXTUREFLAGS_CLAMPT` | `8` | Client | Clamp T coordinates. _(REF-ONLY)_ |
| `TEXTUREFLAGS_CLAMPU` | `33554432` | Client | Clamp U coordinates (for volumetric textures). _(REF-ONLY)_ |
| `TEXTUREFLAGS_DEPTHRENDERTARGET` | `65536` | Client | Texture is a depth render target. _(REF-ONLY)_ |
| `TEXTUREFLAGS_EIGHTBITALPHA` | `8192` | Client | Eight bit alpha channel used. _(REF-ONLY)_ |
| `TEXTUREFLAGS_ENVMAP` | `16384` | Client | Texture is an environment map. _(REF-ONLY)_ |
| `TEXTUREFLAGS_HINT_DXT5` | `32` | Client | Used in skyboxes. _(REF-ONLY)_ |
| `TEXTUREFLAGS_IGNORE_PICMIP` | `2097152` | Client | Aka TEXTUREFLAGS_UNUSED_00200000 _(DEPRECATED, REF-ONLY)_ |
| `TEXTUREFLAGS_IMMEDIATE_CLEANUP` | `1048576` | Client | Immediately destroy this texture when its reference count hits zero. _(DEPRECATED, REF-ONLY)_ |
| `TEXTUREFLAGS_NODEBUGOVERRIDE` | `131072` | Client |  _(REF-ONLY)_ |
| `TEXTUREFLAGS_NODEPTHBUFFER` | `8388608` | Client | Do not buffer for Video Processing, generally render distance. _(REF-ONLY)_ |
| `TEXTUREFLAGS_NOLOD` | `512` | Client | Not affected by texture resolution settings. _(REF-ONLY)_ |
| `TEXTUREFLAGS_NOMIP` | `256` | Client | Render largest mipmap only. _(REF-ONLY)_ |
| `TEXTUREFLAGS_NORMAL` | `128` | Client | Texture is a normal map. _(REF-ONLY)_ |
| `TEXTUREFLAGS_ONEBITALPHA` | `4096` | Client | One bit alpha channel used. _(REF-ONLY)_ |
| `TEXTUREFLAGS_POINTSAMPLE` | `1` | Client | Low quality, "pixel art" texture filtering. _(REF-ONLY)_ |
| `TEXTUREFLAGS_PROCEDURAL` | `2048` | Client | Texture is an procedural texture (code can modify it). _(REF-ONLY)_ |
| `TEXTUREFLAGS_PWL_CORRECTED` | `64` | Client | Purpose unknown. _(REF-ONLY)_ |
| `TEXTUREFLAGS_RENDERTARGET` | `32768` | Client | Texture is a render target. _(REF-ONLY)_ |
| `TEXTUREFLAGS_SINGLECOPY` | `262144` | Client |  _(REF-ONLY)_ |
| `TEXTUREFLAGS_SSBUMP` | `134217728` | Client | Texture is a SSBump. _(REF-ONLY)_ |
| `TEXTUREFLAGS_STAGING_MEMORY` | `524288` | Client | Aka TEXTUREFLAGS_UNUSED_00080000 _(DEPRECATED, REF-ONLY)_ |
| `TEXTUREFLAGS_STREAMABLE_COARSE` | `1073741824` | Client | Aka TEXTUREFLAGS_UNUSED_40000000 _(DEPRECATED, REF-ONLY)_ |
| `TEXTUREFLAGS_STREAMABLE_FINE` | `2147483648` | Client | Aka TEXTUREFLAGS_UNUSED_80000000 _(DEPRECATED, REF-ONLY)_ |
| `TEXTUREFLAGS_TRILINEAR` | `2` | Client | Medium quality texture filtering. _(REF-ONLY)_ |
| `TEXTUREFLAGS_UNUSED_00400000` | `4194304` | Client |  _(REF-ONLY)_ |
| `TEXTUREFLAGS_UNUSED_01000000` | `16777216` | Client |  _(REF-ONLY)_ |
| `TEXTUREFLAGS_UNUSED_10000000` | `268435456` | Client |  _(REF-ONLY)_ |
| `TEXTUREFLAGS_VERTEXTEXTURE` | `67108864` | Client | Usable as a vertex texture _(REF-ONLY)_ |

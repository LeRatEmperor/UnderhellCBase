# MAT enumeration

**Realm:** Shared  ·  **Constants:** 23

Enumerations used in [Structures/TraceResult](https://wiki.facepunch.com/gmod/Structures/TraceResult) and [Structures/SurfacePropertyData](https://wiki.facepunch.com/gmod/Structures/SurfacePropertyData), and by [Entity:GetMaterialType](https://wiki.facepunch.com/gmod/Entity:GetMaterialType).

# These aren't VMT materials!

[Material types](https://developer.valvesoftware.com/wiki/Material_Types) are a [holdover from GoldSrc](https://developer.valvesoftware.com/wiki/Material_surface_properties) and Quake before it. They were previously used to classify textures and entities into categories, defining their physical properties. In practice, this really only changed impact sounds and effects, and player footstep sounds. For example, `func_breakable` (in GoldSrc) used it to select which gibs to spawn when broken. Raw texture files were given these properties by assigning them to a material. These were tracked in the single file `materials.txt`, which contained mappings of material types to texture names. Materials are indexed using a letter—for example `MAT_METAL` was indexed in `materials.txt` with the letter "M". The value of `MAT_METAL` is 77, because the ASCII value for M is 77. Some entities could also be assigned materials directly in their [keyvalues](https://wiki.facepunch.com/gmod/Entity:GetSaveTable) using the same system.

In Source, materials were moved out of the single `materials.txt` file; now every texture has its own associated [material](https://wiki.facepunch.com/gmod/Materials_and_Textures) file, called [VMT](https://developer.valvesoftware.com/wiki/VMT) (**V**alve **M**aterial **T**ype). VMTs contain all the information legacy materials used to provide and more, including including shader, transparency, physical properties, animations...

Rather than place the properties directly inside the VMT (which would prevent them from being assigned directly to entities like legacy materials could), [surface properties](https://wiki.facepunch.com/gmod/Structures/SurfacePropertyData) were added, which can be selected in the VMT using the `$surfaceprop` key. Surface properties are what determine impact sounds, buoyancy, friction, and other such properties. These do not use letters as identifiers and instead use [string names](https://wiki.facepunch.com/gmod/util.GetSurfaceIndex). You can view the surface properties Garry's Mod loads by looking in the `GarrysMod/sourceengine/scripts/surfaceproperties.txt` file.

However, legacy materials still exist in Source. They are called game materials or [material types](https://wiki.facepunch.com/gmod/Entity:GetMaterialType) to separate them from the new material system where confusion between the two is a concern. For example, surface property definitions contain a `gamematerial` parameter; this field assigns a legacy game material to a surface property, which is then assigned to VMTs and entities.

The main thing legacy game materials are used for nowadays are picking impact effects and decals, like in GoldSrc. Otherwise, surface properties and VMTs replace most other functionality.

[wiki page](https://wiki.facepunch.com/gmod/Enums/MAT)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `MAT_ALIENFLESH` | `72` | Shared | Alien flesh - headcrabs and vortigaunts |
| `MAT_ANTLION` | `65` | Shared | Antlions |
| `MAT_BLOODYFLESH` | `66` | Shared | Similar to MAT_FLESH, only used by "bloodyflesh" surface property, has different impact sound |
| `MAT_CLIP` | `73` | Shared | Unused |
| `MAT_COMPUTER` | `80` | Shared | Electronics, only used by "computer" surface property |
| `MAT_CONCRETE` | `67` | Shared | Concrete |
| `MAT_DEFAULT` | `88` | Shared | Skybox or nodraw texture |
| `MAT_DIRT` | `68` | Shared | Dirt |
| `MAT_EGGSHELL` | `69` | Shared | The egg sacs in the antlion tunnels in HL2: EP2 |
| `MAT_FLESH` | `70` | Shared | Flesh |
| `MAT_FOLIAGE` | `79` | Shared | Plants, only used by the "foliage" surface property |
| `MAT_GLASS` | `89` | Shared | Glass |
| `MAT_GRASS` | `85` | Shared | Grass |
| `MAT_GRATE` | `71` | Shared | Grates, chainlink fences |
| `MAT_METAL` | `77` | Shared | Metal |
| `MAT_PLASTIC` | `76` | Shared | Plastic |
| `MAT_SAND` | `78` | Shared | Sand |
| `MAT_SLOSH` | `83` | Shared | Water, slime |
| `MAT_SNOW` | `74` | Shared | Snow |
| `MAT_TILE` | `84` | Shared | Floor tiles |
| `MAT_VENT` | `86` | Shared | Metallic vents |
| `MAT_WARPSHIELD` | `90` | Shared | "wierd-looking jello effect for advisor shield." |
| `MAT_WOOD` | `87` | Shared | Wood |

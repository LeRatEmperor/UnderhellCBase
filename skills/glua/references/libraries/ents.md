# ents

**Realm:** Shared  ·  **Members:** 20

The ents library provides functions for creating and finding entities in the game.

[wiki page](https://wiki.facepunch.com/gmod/ents)

### ents.Create · Server
`ents.Create(class: string) → Entity`

Creates an entity. This function will fail and return `NULL` if the networked-edict limit is hit (around **8176**), or the provided entity class doesn't exist.

**Arguments:**
- `class` (string) — The classname of the entity to create.

**Returns:**
- Entity — The created entity, or `NULL` if failed.

> **Warning:** Do not use before [GM:InitPostEntity](https://wiki.facepunch.com/gmod/GM:InitPostEntity) has been called, otherwise the server will crash!
> If you need to perform entity creation when the game starts, create a hook for [GM:InitPostEntity](https://wiki.facepunch.com/gmod/GM:InitPostEntity) and do it there.

[wiki](https://wiki.facepunch.com/gmod/ents.Create)

---

### ents.CreateClientProp · Client
`ents.CreateClientProp(model: string = models/error.mdl) → Entity`

Creates a clientside only prop with optional physics. See also [ClientsideModel](https://wiki.facepunch.com/gmod/Global.ClientsideModel) if physics is not needed.

For physics to work you're expected to use the `model` argument. A simple [Entity:SetModel](https://wiki.facepunch.com/gmod/Entity:SetModel) will not be enough — the [Entity:PhysicsInit](https://wiki.facepunch.com/gmod/Entity:PhysicsInit)* function will be needed.

**Arguments:**
- `model` (string, default `models/error.mdl`) — The model for the entity to be created.

**Returns:**
- Entity — Created entity (`C_PhysPropClientside`).

> **Bug** ([#861](https://github.com/Facepunch/garrysmod/issues/861)): Parented clientside prop will become detached if the parent entity leaves the PVS. **A workaround is available on its github page.**

[wiki](https://wiki.facepunch.com/gmod/ents.CreateClientProp)

---

### ents.CreateClientRope · Client
`ents.CreateClientRope(ent1: Entity, ent1attach: number|Vector, ent2: Entity, ent2attach: number|Vector, extra: table = nil) → Entity`

Creates a clientside only rope, similar to those used by the Dog and Fast Zombie models from Half-Life 2.

Created ropes will be automatically cleaned up when one of the attached entities is removed.

**Arguments:**
- `ent1` (Entity) — The first entity to attach the rope to.
- `ent1attach` (number|Vector) — The attachment ID on the first entity to attach the rope to, or a local Vector relative to the first entity.
- `ent2` (Entity) — The second entity to attach the rope to.
- `ent2attach` (number|Vector) — The attachment ID on the second entity to attach the rope to, or a local Vector relative to the second entity.
- `extra` (table, default `nil`) — Extra optional settings for the rope.

**Returns:**
- Entity — Created entity (`C_RopeKeyframe`).

> **Warning:** It doesn’t work exactly the same way as [constraint.CreateKeyframeRope](https://wiki.facepunch.com/gmod/constraint.CreateKeyframeRope) or [constraint.Rope](https://wiki.facepunch.com/gmod/constraint.Rope), you can see it when you try to use Slack with [constraint.CreateKeyframeRope](https://wiki.facepunch.com/gmod/constraint.CreateKeyframeRope) or addlength on [constraint.Rope](https://wiki.facepunch.com/gmod/constraint.Rope).

[wiki](https://wiki.facepunch.com/gmod/ents.CreateClientRope)

---

### ents.CreateClientside · Client
`ents.CreateClientside(class: string) → Entity`

Creates a clientside only scripted entity. The scripted entity must be of "anim" type.

**Arguments:**
- `class` (string) — The class name of the entity to create.

**Returns:**
- Entity — Created entity.

[wiki](https://wiki.facepunch.com/gmod/ents.CreateClientside)

---

### ents.FindAlongRay · Shared
`ents.FindAlongRay(start: Vector, end: Vector, mins: Vector = nil, maxs: Vector = nil) → table<Entity>`

Returns a table of all entities along the ray. The ray does not stop on collisions, meaning it will go through walls/entities.

This function is capable of detecting clientside only entities by default.

This internally uses [spatial partitioning](https://en.wikipedia.org/wiki/Space_partitioning) to avoid looping through all entities.

**Arguments:**
- `start` (Vector) — The start position of the ray.
- `end` (Vector) — The end position of the ray.
- `mins` (Vector, default `nil`) — The mins corner of the ray.
- `maxs` (Vector, default `nil`) — The maxs corner of the ray.

**Returns:**
- table<Entity> — Table of the found entities.

[wiki](https://wiki.facepunch.com/gmod/ents.FindAlongRay)

---

### ents.FindByClass · Shared
`ents.FindByClass(class: string) → table<Entity>`

Gets all entities with the given class, supports wildcards.

This function returns a sequential table, meaning it should be looped with [ipairs](https://wiki.facepunch.com/gmod/Global.ipairs) instead of [pairs](https://wiki.facepunch.com/gmod/Global.pairs) for efficiency reasons.

This works internally by iterating over [ents.GetAll](https://wiki.facepunch.com/gmod/ents.GetAll). `ents.FindByClass` is always faster than [ents.GetAll](https://wiki.facepunch.com/gmod/ents.GetAll) or [ents.Iterator](https://wiki.facepunch.com/gmod/ents.Iterator).

**Arguments:**
- `class` (string) — The class of the entities to find, supports wildcards.

**Returns:**
- table<Entity> — A table containing all found entities.

[wiki](https://wiki.facepunch.com/gmod/ents.FindByClass)

---

### ents.FindByClassAndParent · Shared
`ents.FindByClassAndParent(class: string, parent: Entity) → table<Entity>`

Finds all entities that are of given class and are children of given entity. This works internally by iterating over [ents.FindByClass](https://wiki.facepunch.com/gmod/ents.FindByClass).

**Arguments:**
- `class` (string) — The class of entities to search for.
- `parent` (Entity) — Parent of entities that are being searched for.

**Returns:**
- table<Entity> — A table of found entities or nil if none are found.

[wiki](https://wiki.facepunch.com/gmod/ents.FindByClassAndParent) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/ents.lua#L2-L26)

---

### ents.FindByModel · Shared
`ents.FindByModel(model: string) → table<Entity>`

Gets all entities with the given model, supports wildcards.

This works internally by iterating over [ents.GetAll](https://wiki.facepunch.com/gmod/ents.GetAll).

**Arguments:**
- `model` (string) — The model of the entities to find.

**Returns:**
- table<Entity> — A table of all found entities.

[wiki](https://wiki.facepunch.com/gmod/ents.FindByModel)

---

### ents.FindByName · Shared
`ents.FindByName(name: string) → table<Entity>`

Gets all entities with the given hammer targetname. This works internally by iterating over [ents.GetAll](https://wiki.facepunch.com/gmod/ents.GetAll).

Doesn't do anything on client.

**Arguments:**
- `name` (string) — The targetname to look for.

**Returns:**
- table<Entity> — A table of all found entities.

[wiki](https://wiki.facepunch.com/gmod/ents.FindByName)

---

### ents.FindInBox · Shared
`ents.FindInBox(boxMins: Vector, boxMaxs: Vector) → table<Entity>`

Returns all entities within the specified box.

This internally uses a Spatial Partition to avoid looping through all entities, so it is more efficient than using [ents.GetAll](https://wiki.facepunch.com/gmod/ents.GetAll) for this purpose.

**Arguments:**
- `boxMins` (Vector) — The box minimum coordinates.
- `boxMaxs` (Vector) — The box maximum coordinates.

**Returns:**
- table<Entity> — A table of all found entities.

> **Note:** Clientside entities will not be returned by this function. Serverside only entities without networked edicts (entity indexes), such as point logic or Constraints are not returned either

[wiki](https://wiki.facepunch.com/gmod/ents.FindInBox)

---

### ents.FindInCone · Shared
`ents.FindInCone(origin: Vector, normal: Vector, range: number, angle_cos: number) → table<Entity>`

Finds and returns all entities within the specified cone. Only entities whose [Entity:WorldSpaceCenter](https://wiki.facepunch.com/gmod/Entity:WorldSpaceCenter) is within the cone are considered to be in it.

The "cone" is actually a conical "slice" of an axis-aligned box (see: [ents.FindInBox](https://wiki.facepunch.com/gmod/ents.FindInBox)). The image to the right shows approximately how this function would look in 2D. Due to this, the entity may be farther than the specified range!

**Arguments:**
- `origin` (Vector) — The tip of the cone.
- `normal` (Vector) — Direction of the cone.
- `range` (number) — The range of the cone/box around the origin.
- `angle_cos` (number) — The cosine of the angle between the center of the cone to its edges, which is half the overall angle of the cone.

**Returns:**
- table<Entity> — A table of all found Entitys.

[wiki](https://wiki.facepunch.com/gmod/ents.FindInCone)

---

### ents.FindInPVS · Server
`ents.FindInPVS(viewPoint: Entity|Vector) → table<Entity>`

Finds all entities that lie within a [PVS (Potential Visibility Set)](https://developer.valvesoftware.com/wiki/PVS "PVS - Valve Developer Community").

**Arguments:**
- `viewPoint` (Entity|Vector) — Entity or Vector to find entities within the PVS of.

**Returns:**
- table<Entity> — The found Entitys.

> **Note:** The function won't take in to account [AddOriginToPVS](https://wiki.facepunch.com/gmod/Global.AddOriginToPVS) and the like.

[wiki](https://wiki.facepunch.com/gmod/ents.FindInPVS)

---

### ents.FindInSphere · Shared
`ents.FindInSphere(origin: Vector, radius: number) → table<Entity>`

Gets all entities within the specified sphere.

This function internally calls [util.IsBoxIntersectingSphere](https://wiki.facepunch.com/gmod/util.IsBoxIntersectingSphere) for every entity on the map based on their Orientated Bounding Box.

**Arguments:**
- `origin` (Vector) — Center of the sphere.
- `radius` (number) — Radius of the sphere.

**Returns:**
- table<Entity> — A table of all found Entitys.

[wiki](https://wiki.facepunch.com/gmod/ents.FindInSphere)

---

### ents.FireTargets · Server
`ents.FireTargets(target: string, activator: Entity, caller: Entity, usetype: number{USE}, value: number)`

Fires a use event.

**Arguments:**
- `target` (string) — Name of the target entity.
- `activator` (Entity) — Activator of the event.
- `caller` (Entity) — Caller of the event.
- `usetype` (number{USE}) — Use type.
- `value` (number) — This value is passed to ENTITY:Use, but isn't used by any default entities in the engine.

[wiki](https://wiki.facepunch.com/gmod/ents.FireTargets)

---

### ents.GetAll · Shared
`ents.GetAll() → table<Entity>`

Returns a table of all existing entities.

Consider using [ents.Iterator](https://wiki.facepunch.com/gmod/ents.Iterator) instead for better performance.

This function returns a sequential table, meaning it should be looped with [ipairs](https://wiki.facepunch.com/gmod/Global.ipairs) instead of [pairs](https://wiki.facepunch.com/gmod/Global.pairs) for efficiency reasons.

**Returns:**
- table<Entity> — Table of all existing Entitys.

[wiki](https://wiki.facepunch.com/gmod/ents.GetAll)

---

### ents.GetByIndex · Shared
`ents.GetByIndex(entIdx: number) → Entity`

Returns an entity by its index. Same as [Entity](https://wiki.facepunch.com/gmod/Global.Entity).

**Arguments:**
- `entIdx` (number) — The index of the entity.

**Returns:**
- Entity — The entity if it exists, or `NULL` if it doesn't.

[wiki](https://wiki.facepunch.com/gmod/ents.GetByIndex)

---

### ents.GetCount · Shared
`ents.GetCount(IncludeKillMe: boolean = false) → number`

Gives you the amount of currently existing entities.

Similar to **#**[ents.GetAll](https://wiki.facepunch.com/gmod/ents.GetAll)() but with better performance since the entity table doesn't have to be generated.  
If [ents.GetAll](https://wiki.facepunch.com/gmod/ents.GetAll) is already being called for iteration, than using the **#** operator on the table will be faster than calling this function since it is JITted.

**Arguments:**
- `IncludeKillMe` (boolean, default `false`) — Include entities with the FL_KILLME flag.

**Returns:**
- number — Number of entities.

[wiki](https://wiki.facepunch.com/gmod/ents.GetCount)

---

### ents.GetEdictCount · Server
`ents.GetEdictCount() → number`

Returns the amount of networked entities, which is limited to 8192.

[ents.Create](https://wiki.facepunch.com/gmod/ents.Create) will fail somewhere between 8064 and 8176 - this can vary based on the amount of player slots on the server and other entities.

See also [MAX_EDICT_BITS](https://wiki.facepunch.com/gmod/Global_Variables#maxedictbits) global variable.

**Returns:**
- number — Number of networked entities.

[wiki](https://wiki.facepunch.com/gmod/ents.GetEdictCount)

---

### ents.GetMapCreatedEntity · Shared
`ents.GetMapCreatedEntity(id: number) → Entity|nil`

Returns entity that has given [Entity:MapCreationID](https://wiki.facepunch.com/gmod/Entity:MapCreationID).

**Arguments:**
- `id` (number) — Entity's creation id.

**Returns:**
- Entity|nil — Found entity, `nil` otherwise.

[wiki](https://wiki.facepunch.com/gmod/ents.GetMapCreatedEntity)

---

### ents.Iterator · Shared
`ents.Iterator() → function, table<Entity>, number`

Returns a [Stateless Iterator](https://www.lua.org/pil/7.3.html) for all entities.
		Intended for use in [Generic For-Loops](https://www.lua.org/pil/4.3.5.html).  
		See [player.Iterator](https://wiki.facepunch.com/gmod/player.Iterator) for a similar function for all players.

**Returns:**
- function — The Iterator Function from ipairs.
- table<Entity> — Table of all existing Entities.
- number — The starting index for the table of players.

> **Note:** Internally, this function uses cached values that are stored in Lua, as opposed to [ents.GetAll](https://wiki.facepunch.com/gmod/ents.GetAll), which is a C++ function.
> 		Because a call operation from Lua to C++ *and* with a return back to Lua is quite costly, this function will be more efficient than [ents.GetAll](https://wiki.facepunch.com/gmod/ents.GetAll).

[wiki](https://wiki.facepunch.com/gmod/ents.Iterator) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/entity_iter.lua#L4-L11)

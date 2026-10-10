# duplicator

**Realm:** Shared  ·  **Members:** 34

The duplicator library allows you to specify what should be saved when someone attempts to duplicate your custom entity with the duplicator tool. It can also be used by 3rd party duplicator tools to make use of the built in system.

[wiki page](https://wiki.facepunch.com/gmod/duplicator)

### duplicator.Allow · Shared
`duplicator.Allow(classname: string)`

Allow entities with given class name to be duplicated. See [duplicator.Disallow](https://wiki.facepunch.com/gmod/duplicator.Disallow) for the opposite effect.

[duplicator.IsAllowed](https://wiki.facepunch.com/gmod/duplicator.IsAllowed) can be used to poll the status of a particular entity class. 

`duplicator.Allow` is automatically called by [scripted_ents.Register](https://wiki.facepunch.com/gmod/scripted_ents.Register) and [weapons.Register](https://wiki.facepunch.com/gmod/weapons.Register), unless the associated entity table has `ENT.DisableDuplicator` set to `true`.

This is also automatically called by [duplicator.RegisterEntityClass](https://wiki.facepunch.com/gmod/duplicator.RegisterEntityClass).

In addition to that most spawnmenu content, such as engine weapons and pickup-ables, as well as most engine NPCs in Sandbox-derived gamemodes are also allowed by default.

**Arguments:**
- `classname` (string) — An entity's classname to allow duplicating.

[wiki](https://wiki.facepunch.com/gmod/duplicator.Allow) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L300-L304)

---

### duplicator.ApplyBoneModifiers · Server
`duplicator.ApplyBoneModifiers(ply: Player, ent: Entity)`

Calls every function registered with [duplicator.RegisterBoneModifier](https://wiki.facepunch.com/gmod/duplicator.RegisterBoneModifier) on each bone the ent has.

**Arguments:**
- `ply` (Player) — The player whose entity this is.
- `ent` (Entity) — The entity in question.

[wiki](https://wiki.facepunch.com/gmod/duplicator.ApplyBoneModifiers) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L817-L844)

---

### duplicator.ApplyEntityModifiers · Server
`duplicator.ApplyEntityModifiers(ply: Player, ent: Entity)`

Calls every function registered with [duplicator.RegisterEntityModifier](https://wiki.facepunch.com/gmod/duplicator.RegisterEntityModifier) on the entity.

**Arguments:**
- `ply` (Player) — The player whose entity this is.
- `ent` (Entity) — The entity in question.

[wiki](https://wiki.facepunch.com/gmod/duplicator.ApplyEntityModifiers) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L797-L811)

---

### duplicator.BoneModifiers · Shared
`duplicator.BoneModifiers()`

[wiki](https://wiki.facepunch.com/gmod/duplicator.BoneModifiers)

---

### duplicator.ClearEntityModifier · Server
`duplicator.ClearEntityModifier(ent: Entity, key: any)`

Clears/removes the chosen entity modifier from the entity.

**Arguments:**
- `ent` (Entity) — The entity the modification is stored on.
- `key` (any) — The key of the stored entity modifier.

[wiki](https://wiki.facepunch.com/gmod/duplicator.ClearEntityModifier) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L464-L471)

---

### duplicator.ConstraintType · Shared
`duplicator.ConstraintType()`

[wiki](https://wiki.facepunch.com/gmod/duplicator.ConstraintType)

---

### duplicator.Copy · Server
`duplicator.Copy(ent: Entity, tableToAdd: table = {}) → table`

Copies the entity, and all of its constraints and entities, then returns them in a table.

**Arguments:**
- `ent` (Entity) — The entity to duplicate.
- `tableToAdd` (table, default `{}`) — A preexisting table to add entities and constraints in from.

**Returns:**
- table — A table containing duplication info which includes the following members: * table Entities * table Constraints * Vector Mins * Vector Maxs The values of Mins & Maxs from the table are returned from duplicator.WorkoutSize.

[wiki](https://wiki.facepunch.com/gmod/duplicator.Copy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L552-L582)

---

### duplicator.CopyEnts · Server
`duplicator.CopyEnts(ents: table) → table`

Copies the passed table of entities to save for later.

**Arguments:**
- `ents` (table) — A table of entities to save/copy.

**Returns:**
- table — A table containing duplication info which includes the following members: * table Entities * table Constraints * Vector Mins * Vector Maxs

[wiki](https://wiki.facepunch.com/gmod/duplicator.CopyEnts) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L584-L596)

---

### duplicator.CopyEntTable · Server
`duplicator.CopyEntTable(ent: Entity) → table`

Returns a table with some entity data that can be used to create a new entity with [duplicator.CreateEntityFromTable](https://wiki.facepunch.com/gmod/duplicator.CreateEntityFromTable).

**Arguments:**
- `ent` (Entity) — The entity table to save.

**Returns:**
- table — See Structures/EntityCopyData.

[wiki](https://wiki.facepunch.com/gmod/duplicator.CopyEntTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L495-L501)

---

### duplicator.CreateConstraintFromTable · Server · `INTERNAL`
`duplicator.CreateConstraintFromTable(constraint: table, entityList: table) → Entity, Entity, Entity, Entity`

Creates a constraint from a saved/copied constraint table.

**Arguments:**
- `constraint` (table) — Saved/copied constraint table.
- `entityList` (table) — The list of entities that are to be constrained.

**Returns:**
- Entity — The newly created constraint entity, if any.
- Entity — The second constraint related entity, if any.
- Entity — The third constraint related entity, if any.
- Entity — The fourth constraint related entity, if any.

[wiki](https://wiki.facepunch.com/gmod/duplicator.CreateConstraintFromTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L655-L695)

---

### duplicator.CreateEntityFromTable · Server
`duplicator.CreateEntityFromTable(ply: Player, entTable: table) → Entity`

"Create an entity from a table." 


This creates an entity using the data in EntTable.


If an entity factory has been registered for the entity's Class, it will be called. 


Otherwise, [duplicator.GenericDuplicatorFunction](https://wiki.facepunch.com/gmod/duplicator.GenericDuplicatorFunction) will be called instead.

**Arguments:**
- `ply` (Player) — The player who wants to create something.
- `entTable` (table) — The duplication data to build the entity with.

**Returns:**
- Entity — The newly created entity.

[wiki](https://wiki.facepunch.com/gmod/duplicator.CreateEntityFromTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L601-L649)

---

### duplicator.Disallow · Shared
`duplicator.Disallow(classname: string)`

Disallow this entity to be duplicated. Opposite of [duplicator.Allow](https://wiki.facepunch.com/gmod/duplicator.Allow).

This function is useful for temporarily disabling duplication of certain entity classes that may have been previously allowed.

**Arguments:**
- `classname` (string) — An entity's classname to disallow duplicating.

[wiki](https://wiki.facepunch.com/gmod/duplicator.Disallow) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L340-L344)

---

### duplicator.DoBoneManipulator · Server
`duplicator.DoBoneManipulator(ent: Entity, bones: table)`

"Restores the bone's data."


Loops through Bones and calls [Entity:ManipulateBoneScale](https://wiki.facepunch.com/gmod/Entity:ManipulateBoneScale), [Entity:ManipulateBoneAngles](https://wiki.facepunch.com/gmod/Entity:ManipulateBoneAngles) and [Entity:ManipulateBonePosition](https://wiki.facepunch.com/gmod/Entity:ManipulateBonePosition) on ent with the table keys and the subtable values s, a and p respectively.

**Arguments:**
- `ent` (Entity) — The entity to be bone manipulated.
- `bones` (table) — Table with a Structures/BoneManipulationData for every bone (that has manipulations applied) using the bone ID as the table index.

[wiki](https://wiki.facepunch.com/gmod/duplicator.DoBoneManipulator) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L391-L404)

---

### duplicator.DoFlex · Server
`duplicator.DoFlex(ent: Entity, flex: table, scale: number = nil)`

Restores the flex data using [Entity:SetFlexWeight](https://wiki.facepunch.com/gmod/Entity:SetFlexWeight) and [Entity:SetFlexScale](https://wiki.facepunch.com/gmod/Entity:SetFlexScale).

**Arguments:**
- `ent` (Entity) — The entity to restore the flexes on.
- `flex` (table) — The flexes to restore.
- `scale` (number, default `nil`) — The flex scale to apply.

[wiki](https://wiki.facepunch.com/gmod/duplicator.DoFlex) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L373-L386)

---

### duplicator.DoGeneric · Server
`duplicator.DoGeneric(ent: Entity, data: table)`

"Applies generic every-day entity stuff for ent from table data."


Depending on the values of Model, Angle, Pos, Skin, Flex, Bonemanip, ModelScale, ColGroup, Name, and BodyG ([table](https://wiki.facepunch.com/gmod/table) of multiple values) in the data table, this calls [Entity:SetModel](https://wiki.facepunch.com/gmod/Entity:SetModel), [Entity:SetAngles](https://wiki.facepunch.com/gmod/Entity:SetAngles), [Entity:SetPos](https://wiki.facepunch.com/gmod/Entity:SetPos), [Entity:SetSkin](https://wiki.facepunch.com/gmod/Entity:SetSkin), [duplicator.DoFlex](https://wiki.facepunch.com/gmod/duplicator.DoFlex), [duplicator.DoBoneManipulator](https://wiki.facepunch.com/gmod/duplicator.DoBoneManipulator), [Entity:SetModelScale](https://wiki.facepunch.com/gmod/Entity:SetModelScale), [Entity:SetCollisionGroup](https://wiki.facepunch.com/gmod/Entity:SetCollisionGroup), [Entity:SetName](https://wiki.facepunch.com/gmod/Entity:SetName), [Entity:SetBodygroup](https://wiki.facepunch.com/gmod/Entity:SetBodygroup) on ent.


If ent has a RestoreNetworkVars function, it is called with data.DT.

**Arguments:**
- `ent` (Entity) — The entity to be applied upon.
- `data` (table) — The data to be applied onto the entity.

[wiki](https://wiki.facepunch.com/gmod/duplicator.DoGeneric) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L944-L948)

---

### duplicator.DoGenericPhysics · Server
`duplicator.DoGenericPhysics(ent: Entity, ply: Player = nil, data: table)`

"Applies bone data, generically."


If data contains a PhysicsObjects table, it moves, re-angles and if relevent freezes all specified bones, first converting from local coordinates to world coordinates.

**Arguments:**
- `ent` (Entity) — The entity to be applied upon.
- `ply` (Player, default `nil`) — The player who owns the entity.
- `data` (table) — The data to be applied onto the entity.

[wiki](https://wiki.facepunch.com/gmod/duplicator.DoGenericPhysics) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L936-L942)

---

### duplicator.EntityClasses · Shared
`duplicator.EntityClasses()`

[wiki](https://wiki.facepunch.com/gmod/duplicator.EntityClasses)

---

### duplicator.EntityModifiers · Shared
`duplicator.EntityModifiers()`

[wiki](https://wiki.facepunch.com/gmod/duplicator.EntityModifiers)

---

### duplicator.FigureOutRequiredAddons · Shared
`duplicator.FigureOutRequiredAddons(dupe: table)`

Checks the given duplication table and tries to figure out any addons that might be required to correctly spawn the duplication. Currently this is limited to models and material overrides saved in the duplication.

**Arguments:**
- `dupe` (table) — The duplication table to process, for example from duplicator.Copy.

[wiki](https://wiki.facepunch.com/gmod/duplicator.FigureOutRequiredAddons)

---

### duplicator.FindEntityClass · Shared
`duplicator.FindEntityClass(name: string) → table`

Returns the entity class factory registered with [duplicator.RegisterEntityClass](https://wiki.facepunch.com/gmod/duplicator.RegisterEntityClass).

**Arguments:**
- `name` (string) — The name of the entity class factory.

**Returns:**
- table — Is compromised of the following members: * function Func - The function that creates the entity.

[wiki](https://wiki.facepunch.com/gmod/duplicator.FindEntityClass) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L355-L360)

---

### duplicator.GenericDuplicatorFunction · Server
`duplicator.GenericDuplicatorFunction(ply: Player, data: table) → Entity`

"Generic function for duplicating stuff" 


This is called when [duplicator.CreateEntityFromTable](https://wiki.facepunch.com/gmod/duplicator.CreateEntityFromTable) can't find an entity factory to build with. It calls [duplicator.DoGeneric](https://wiki.facepunch.com/gmod/duplicator.DoGeneric) and [duplicator.DoGenericPhysics](https://wiki.facepunch.com/gmod/duplicator.DoGenericPhysics) to apply standard duplicator stored things such as the model and position.

**Arguments:**
- `ply` (Player) — The player who wants to create something.
- `data` (table) — The duplication data to build the entity with.

**Returns:**
- Entity — The newly created entity.

[wiki](https://wiki.facepunch.com/gmod/duplicator.GenericDuplicatorFunction) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L409-L442)

---

### duplicator.GetAllConstrainedEntitiesAndConstraints · Server · `INTERNAL`
`duplicator.GetAllConstrainedEntitiesAndConstraints(ent: Entity, entStorageTable: table, constraintStorageTable: table) → table, table`

Fills entStorageTable with all of the entities in a group connected with constraints. Fills constraintStorageTable with all of the constraints constraining the group.

**Arguments:**
- `ent` (Entity) — The entity to start from
- `entStorageTable` (table) — The table the entities will be inserted into.
- `constraintStorageTable` (table) — The table the constraints will be inserted into.

**Returns:**
- table — entStorageTable
- table — constraintStorageTable

[wiki](https://wiki.facepunch.com/gmod/duplicator.GetAllConstrainedEntitiesAndConstraints) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L853-L897)

---

### duplicator.IsAllowed · Shared
`duplicator.IsAllowed(classname: string) → boolean`

Returns whether the entity can be duplicated or not.

**Arguments:**
- `classname` (string) — An entity's classname.

**Returns:**
- boolean — Returns true if the entity can be duplicated (nil otherwise).

[wiki](https://wiki.facepunch.com/gmod/duplicator.IsAllowed) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L309-L313)

---

### duplicator.Paste · Server
`duplicator.Paste(Player: Player, EntityList: table, ConstraintList: table) → table, table`

"Given entity list and constraint list, create all entities and return their tables"

Calls [duplicator.CreateEntityFromTable](https://wiki.facepunch.com/gmod/duplicator.CreateEntityFromTable) on each sub-table of EntityList. If an entity is actually created, it calls [ENTITY:OnDuplicated](https://wiki.facepunch.com/gmod/ENTITY:OnDuplicated) with the entity's duplicator data, then [duplicator.ApplyEntityModifiers](https://wiki.facepunch.com/gmod/duplicator.ApplyEntityModifiers), [duplicator.ApplyBoneModifiers](https://wiki.facepunch.com/gmod/duplicator.ApplyBoneModifiers) and finally  [ENTITY:PostEntityPaste](https://wiki.facepunch.com/gmod/ENTITY:PostEntityPaste) is called.

The constraints are then created with [duplicator.CreateConstraintFromTable](https://wiki.facepunch.com/gmod/duplicator.CreateConstraintFromTable).

**Arguments:**
- `Player` (Player) — The player who wants to create something.
- `EntityList` (table) — A table of duplicator data to create the entities from.
- `ConstraintList` (table) — A table of duplicator data to create the constraints from.

**Returns:**
- table — List of created entities.
- table — List of created constraints.

[wiki](https://wiki.facepunch.com/gmod/duplicator.Paste) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L701-L791)

---

### duplicator.RegisterBoneModifier · Shared
`duplicator.RegisterBoneModifier(key: any, boneModifier: function)`

Registers a function to be called on each of an entity's bones when [duplicator.ApplyBoneModifiers](https://wiki.facepunch.com/gmod/duplicator.ApplyBoneModifiers) is called.

**Arguments:**
- `key` (any) — The type of the key doesn't appear to matter, but it is preferable to use a string.
- `boneModifier` (function) — Function called on each bone that an ent has.

> **Note:** This function is available to call on the client, but registered functions aren't used anywhere!

[wiki](https://wiki.facepunch.com/gmod/duplicator.RegisterBoneModifier) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L365-L365)

---

### duplicator.RegisterConstraint · Shared
`duplicator.RegisterConstraint(name: string, callback: function, customData: vararg)`

Register a function used for creating a duplicator-supported constraint.

**Arguments:**
- `name` (string) — The unique name of the new constraint.
- `callback` (function) — Function to be called when this constraint is created.
- `customData` (vararg) — Arguments to be passed to the callback function when the constraint is created via duplicator.CreateConstraintFromTable.

[wiki](https://wiki.facepunch.com/gmod/duplicator.RegisterConstraint) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L327-L334)

---

### duplicator.RegisterEntityClass · Shared
`duplicator.RegisterEntityClass(name: string, function: function, args: vararg)`

This allows you to specify a specific function to be run when your SENT is pasted with the duplicator, instead of relying on the generic automatic functions.

**Arguments:**
- `name` (string) — The ClassName of the entity you wish to register a factory for.
- `function` (function) — The factory function you want to have called.
- `args` (vararg) — Strings of the names of arguments you want passed to function the from the Structures/EntityCopyData.

> **Note:** Automatically calls [duplicator.Allow](https://wiki.facepunch.com/gmod/duplicator.Allow) for the entity class.

[wiki](https://wiki.facepunch.com/gmod/duplicator.RegisterEntityClass) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L341-L350)

---

### duplicator.RegisterEntityModifier · Shared
`duplicator.RegisterEntityModifier(name: string, func: function)`

This allows you to register tweaks to entities. For instance, if you were making an "unbreakable" addon, you would use this to enable saving the "unbreakable" state of entities between duplications.

This function registers a piece of generic code that is run on all entities with this modifier. In order to have it actually run, use [duplicator.StoreEntityModifier](https://wiki.facepunch.com/gmod/duplicator.StoreEntityModifier).

This function does nothing when run clientside.

**Arguments:**
- `name` (string) — An identifier for your modification.
- `func` (function) — The function to be called for your modification.

[wiki](https://wiki.facepunch.com/gmod/duplicator.RegisterEntityModifier) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L366-L366)

---

### duplicator.RemoveMapCreatedEntities · Server
`duplicator.RemoveMapCreatedEntities()`

Help to remove certain map created entities before creating the saved entities
This is obviously so we don't get duplicate props everywhere.
It should be called before calling Paste.

[wiki](https://wiki.facepunch.com/gmod/duplicator.RemoveMapCreatedEntities) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L921-L931)

---

### duplicator.SetLocalAng · Shared
`duplicator.SetLocalAng(v: Angle)`

"When a copy is copied it will be translated according to these.
If you set them - make sure to set them back to 0 0 0!"

**Arguments:**
- `v` (Angle) — The angle to offset all pastes from.

[wiki](https://wiki.facepunch.com/gmod/duplicator.SetLocalAng) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L322-L322)

---

### duplicator.SetLocalPos · Shared
`duplicator.SetLocalPos(v: Vector)`

"When a copy is copied it will be translated according to these.
If you set them - make sure to set them back to 0 0 0!"

**Arguments:**
- `v` (Vector) — The position to offset all pastes from.

[wiki](https://wiki.facepunch.com/gmod/duplicator.SetLocalPos) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L321-L321)

---

### duplicator.StoreBoneModifier · Server
`duplicator.StoreBoneModifier(ent: Entity, boneID: number, key: any, data: table)`

Stores bone mod data for a registered bone modification function.

**Arguments:**
- `ent` (Entity) — The entity to add bone mod data to.
- `boneID` (number) — The bone ID.
- `key` (any) — The key for the bone modification.
- `data` (table) — The bone modification data that is passed to the bone modification function.

[wiki](https://wiki.facepunch.com/gmod/duplicator.StoreBoneModifier) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L476-L490)

---

### duplicator.StoreEntityModifier · Server
`duplicator.StoreEntityModifier(entity: Entity, name: string, data: table)`

Stores an entity modifier into an entity for saving.

**Arguments:**
- `entity` (Entity) — The entity to store modifier in.
- `name` (string) — Unique modifier name as defined in duplicator.RegisterEntityModifier.
- `data` (table) — Modifier data.

[wiki](https://wiki.facepunch.com/gmod/duplicator.StoreEntityModifier) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L447-L459)

---

### duplicator.WorkoutSize · Server
`duplicator.WorkoutSize(Ents: table) → Vector, Vector`

Works out the AABB size of the duplication.

**Arguments:**
- `Ents` (table) — A table of entity duplication datums.

**Returns:**
- `Mins` (Vector) — AABB mins vector.
- `Maxs` (Vector) — AABB maxs vector.

[wiki](https://wiki.facepunch.com/gmod/duplicator.WorkoutSize) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/duplicator.lua#L506-L546)

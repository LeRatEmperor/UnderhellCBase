# construct

**Realm:** Server  ·  **Members:** 2

The construct library is used to control the physical properties of entities.

[wiki page](https://wiki.facepunch.com/gmod/construct)

### construct.Magnet · Server
`construct.Magnet(ply: Player, pos: Vector, ang: Angle, model: string, material: string, key: number, maxObjects: number, strength: number, nopull: number = 0, allowrot: number = 0, startOn: number = 0, toggle: number, vel: Vector = Vector( 0, 0, 0 ), aVel: Angle = Angle( 0, 0, 0 ), frozen: boolean = false) → Entity`

Creates a magnet.

**Arguments:**
- `ply` (Player) — Player that will have the numpad control over the magnet.
- `pos` (Vector) — The position of the magnet.
- `ang` (Angle) — The angles of the magnet.
- `model` (string) — The model of the magnet.
- `material` (string) — Material of the magnet ( texture ).
- `key` (number, enum [KEY](https://wiki.facepunch.com/gmod/Enums/KEY)) — The key to toggle the magnet, see KEY.
- `maxObjects` (number) — Maximum amount of objects the magnet can hold.
- `strength` (number) — Strength of the magnet.
- `nopull` (number, default `0`) — If > 0, disallows the magnet to pull objects towards it.
- `allowrot` (number, default `0`) — If > 0, allows rotation of the objects attached.
- `startOn` (number, default `0`) — If > 0, enabled from spawn.
- `toggle` (number) — If != 0, pressing the key toggles the magnet, otherwise you'll have to hold the key to keep it enabled.
- `vel` (Vector, default `Vector( 0, 0, 0 )`) — Velocity to set on spawn.
- `aVel` (Angle, default `Angle( 0, 0, 0 )`) — Angular velocity to set on spawn.
- `frozen` (boolean, default `false`) — Freeze the magnet on start.

**Returns:**
- Entity — The magnet.

[wiki](https://wiki.facepunch.com/gmod/construct.Magnet) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/construct.lua#L95-L148)

---

### construct.SetPhysProp · Server
`construct.SetPhysProp(ply: Player, ent: Entity, physObjID: number, physObj: PhysObj, data: table)`

Sets props physical properties.

**Arguments:**
- `ply` (Player) — The player.
- `ent` (Entity) — The entity to apply properties to.
- `physObjID` (number) — You can use this or the argument below.
- `physObj` (PhysObj) — The physics object to apply the properties to.
- `data` (table) — The table containing properties to apply.

[wiki](https://wiki.facepunch.com/gmod/construct.SetPhysProp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/construct.lua#L13-L51)

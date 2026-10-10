# AMMO enumeration

**Realm:** Shared  ·  **Constants:** 2

Used by [game.AddAmmoType](https://wiki.facepunch.com/gmod/game.AddAmmoType)'s input structure - the [Structures/AmmoData](https://wiki.facepunch.com/gmod/Structures/AmmoData).

[wiki page](https://wiki.facepunch.com/gmod/Enums/AMMO)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `AMMO_FORCE_DROP_IF_CARRIED` | `1` | Shared | Forces player to drop the object they are carrying if the object was hit by this ammo type. _(REF-ONLY)_ |
| `AMMO_INTERPRET_PLRDAMAGE_AS_DAMAGE_TO_PLAYER` | `2` | Shared | Uses AmmoData.plydmg of the ammo type as the damage to deal to shot players instead of Bullet.Damage. _(REF-ONLY)_ |

# package

**Realm:** Shared, Menu  ·  **Members:** 2

The package library is a standard Lua library, it's mainly for use with the module system built into Lua.

[wiki page](https://wiki.facepunch.com/gmod/package)

### package.loaded · Shared, Menu
`package.loaded()`

[wiki](https://wiki.facepunch.com/gmod/package.loaded)

---

### package.seeall · Shared, Menu
`package.seeall(module: table)`

Sets a metatable for module with its __index field referring to the global environment, so that this module inherits values from the global environment. To be used as an option to [module](https://wiki.facepunch.com/gmod/Global.module).

**Arguments:**
- `module` (table) — The module table to be given a metatable

[wiki](https://wiki.facepunch.com/gmod/package.seeall)

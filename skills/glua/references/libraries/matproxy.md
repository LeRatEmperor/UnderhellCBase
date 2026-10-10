# matproxy

**Realm:** Client  ·  **Members:** 6

A library that allows implementing custom [material proxies](https://developer.valvesoftware.com/wiki/Material_proxies) for materials.

Material proxies allow programmatically setting specific `.vmt` shader parameters on a per-entity basis, rather being global across all instances of a material.

You can find a tutorial for making colourable textures over at this [GitHub wiki](https://github.com/fgrg2801/gmod-colorable-playermodels/wiki)

[wiki page](https://wiki.facepunch.com/gmod/matproxy)

### matproxy.ActiveList · Client · `INTERNAL`
`matproxy.ActiveList()`

[wiki](https://wiki.facepunch.com/gmod/matproxy.ActiveList)

---

### matproxy.Add · Client
`matproxy.Add(matProxyData: table)`

Register a material proxy. See [matproxy](https://wiki.facepunch.com/gmod/matproxy) for more general explanation of what they are.

**Arguments:**
- `matProxyData` (table) — The information about the proxy.

> **Note:** The `bind` function is required. The `init` function won't run without it set.

[wiki](https://wiki.facepunch.com/gmod/matproxy.Add) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/matproxy.lua#L20-L45)

---

### matproxy.Call · Client · `INTERNAL`
`matproxy.Call(uname: string, mat: IMaterial, ent: Entity)`

Called by the engine from `OnBind`. Calls [bind](https://wiki.facepunch.com/gmod/Structures/MatProxyData#bind) method of the Lua material proxy.

**Arguments:**
- `uname` (string) — The material proxy name.
- `mat` (IMaterial) — The material the proxy is being applied to.
- `ent` (Entity) — The entity the material is applied to.

[wiki](https://wiki.facepunch.com/gmod/matproxy.Call) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/matproxy.lua#L50-L58)

---

### matproxy.Init · Client · `INTERNAL`
`matproxy.Init(name: string, uname: string, mat: IMaterial, values: table)`

Called by the engine from `OnBind`. Calls [init](https://wiki.facepunch.com/gmod/Structures/MatProxyData#init) method of the Lua material proxy.

**Arguments:**
- `name` (string) — Name of the material proxy.
- `uname` (string) — Name for the active material proxy instance.
- `mat` (IMaterial) — Material the material proxy is applied to.
- `values` (table) — `.vmt` shader parameters of the material.

[wiki](https://wiki.facepunch.com/gmod/matproxy.Init) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/matproxy.lua#L63-L79)

---

### matproxy.ProxyList · Client
`matproxy.ProxyList()`

[wiki](https://wiki.facepunch.com/gmod/matproxy.ProxyList)

---

### matproxy.ShouldOverrideProxy · Client · `INTERNAL`
`matproxy.ShouldOverrideProxy(name: string) → boolean`

Called by engine to determine if a certain material proxy is registered in Lua.

**Arguments:**
- `name` (string) — The name of proxy in question

**Returns:**
- boolean — Whether the material proxy of given name is registered.

[wiki](https://wiki.facepunch.com/gmod/matproxy.ShouldOverrideProxy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/matproxy.lua#L11-L15)

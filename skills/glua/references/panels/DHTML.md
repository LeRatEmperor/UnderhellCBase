# DHTML

**Realm:** Client, Menu  ·  **Members:** 7  ·  **Inherits:** `HTML`

The DHTML control wraps the internal web engine, supports calling Javascript functions from Lua, 
		as well as running Lua from within the HTML. Running Lua code is disabled by default.

[wiki page](https://wiki.facepunch.com/gmod/DHTML)

### DHTML:AddFunction · Client, Menu
`DHTML:AddFunction(library: string, name: string, callback: function)`

Defines a Javascript function that when called will call a Lua callback.

**Arguments:**
- `library` (string) — Library name of the JS function you are defining.
- `name` (string) — Name of the JS function you are defining.
- `callback` (function) — Function called when the JS function is called.

> **Note:** Must be called after the HTML document has fully loaded.

[wiki](https://wiki.facepunch.com/gmod/DHTML:AddFunction) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhtml.lua#L126-L146)

---

### DHTML:Call · Client, Menu
`DHTML:Call(js: string)`

Runs/Executes a string as JavaScript code in a panel.

**Arguments:**
- `js` (string) — Specify JavaScript code to be executed.

> **Note:** This function is an alias of [DHTML:QueueJavascript](https://wiki.facepunch.com/gmod/DHTML:QueueJavascript) ([source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhtml.lua#L62)).
> **Note:** This function does **NOT** evaluate expression (i.e. allow you to pass variables from JavaScript (JS) to Lua context).Because a return value is nil/no value (a.k.a. void).If you wish to pass/return values from JS to Lua, you may want to use [DHTML:AddFunction](https://wiki.facepunch.com/gmod/DHTML:AddFunction) function to accomplish that job.

[wiki](https://wiki.facepunch.com/gmod/DHTML:Call) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhtml.lua#L62-L64)

---

### DHTML:GetAllowLua · Client, Menu
`DHTML:GetAllowLua() → boolean`

Returns if the loaded page can run Lua code, set by [DHTML:SetAllowLua](https://wiki.facepunch.com/gmod/DHTML:SetAllowLua)

**Returns:**
- boolean — Whether or not Lua code can be called from the loaded page.

[wiki](https://wiki.facepunch.com/gmod/DHTML:GetAllowLua)

---

### DHTML:GetScrollbars · Client, Menu · `DEPRECATED`
`DHTML:GetScrollbars() → boolean`

Returns the value set by [DHTML:SetScrollbars](https://wiki.facepunch.com/gmod/DHTML:SetScrollbars).

**Returns:**
- `show` (boolean) — True if scrollbars should be visible.

[wiki](https://wiki.facepunch.com/gmod/DHTML:GetScrollbars)

---

### DHTML:QueueJavascript · Client, Menu
`DHTML:QueueJavascript(js: string)`

Runs/Executes a string as JavaScript code in a panel.

**Arguments:**
- `js` (string) — Specify JavaScript code to be executed.

> **Note:** If [Panel:IsVisible](https://wiki.facepunch.com/gmod/Panel:IsVisible) is `false`, [PANEL:Think](https://wiki.facepunch.com/gmod/PANEL:Think) will **NOT** run, meaning the Javascript Queue will not be processed.Consider overriding [PANEL:Paint](https://wiki.facepunch.com/gmod/PANEL:Paint) to stop the panel from drawing instead.
> **Note:** This function does **NOT** evaluate expression (i.e. allow you to pass variables from JavaScript (JS) to Lua context).Because a return value is nil/no value (a.k.a. void).If you wish to pass/return values from JS to Lua, you may want to use [DHTML:AddFunction](https://wiki.facepunch.com/gmod/DHTML:AddFunction) function to accomplish that job.

[wiki](https://wiki.facepunch.com/gmod/DHTML:QueueJavascript) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/vgui/dhtml.lua#L46-L60)

---

### DHTML:SetAllowLua · Client, Menu
`DHTML:SetAllowLua(allow: boolean = false)`

Determines whether the loaded page can run Lua code or not. See [DHTML](https://wiki.facepunch.com/gmod/DHTML) for how to run Lua from a DHTML window.

**Arguments:**
- `allow` (boolean, default `false`) — Whether or not to allow Lua.

[wiki](https://wiki.facepunch.com/gmod/DHTML:SetAllowLua) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

---

### DHTML:SetScrollbars · Client, Menu · `DEPRECATED`
`DHTML:SetScrollbars(show: boolean)`

Sets if the loaded window should display scrollbars when the webpage is larger than the viewing window. This is similar to the CSS `overflow` rule.

**Arguments:**
- `show` (boolean) — True if scrollbars should be visible.

[wiki](https://wiki.facepunch.com/gmod/DHTML:SetScrollbars) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L193-L193)

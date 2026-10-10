# DMenuOptionCVar

**Realm:** Client  ·  **Members:** 6  ·  **Inherits:** `DMenuOption`  ·  `INTERNAL`

An internal panel used by [DMenu](https://wiki.facepunch.com/gmod/DMenu).
		It acts as a menu option that can be checked.
		It automatically sets and reads the given console variable.

		It can be right clicked to toggle without closing the [DMenu](https://wiki.facepunch.com/gmod/DMenu).

		Use [DMenu:AddCVar](https://wiki.facepunch.com/gmod/DMenu:AddCVar) instead.

[wiki page](https://wiki.facepunch.com/gmod/DMenuOptionCVar)

### DMenuOptionCVar:GetConVar · Client
`DMenuOptionCVar:GetConVar() → string`

Returns the [console variable](https://wiki.facepunch.com/gmod/ConVars) used by the [DMenuOptionCVar](https://wiki.facepunch.com/gmod/DMenuOptionCVar).

**Returns:**
- string — The console variable used

[wiki](https://wiki.facepunch.com/gmod/DMenuOptionCVar:GetConVar)

---

### DMenuOptionCVar:GetValueOff · Client
`DMenuOptionCVar:GetValueOff() → string`

Returns the value of the [console variable](https://wiki.facepunch.com/gmod/ConVars) when the [DMenuOptionCVar](https://wiki.facepunch.com/gmod/DMenuOptionCVar) is not checked.

**Returns:**
- string — The value

[wiki](https://wiki.facepunch.com/gmod/DMenuOptionCVar:GetValueOff)

---

### DMenuOptionCVar:GetValueOn · Client
`DMenuOptionCVar:GetValueOn() → string`

Return the value of the [console variable](https://wiki.facepunch.com/gmod/ConVars) when the [DMenuOptionCVar](https://wiki.facepunch.com/gmod/DMenuOptionCVar) is checked.

**Returns:**
- string — The value

[wiki](https://wiki.facepunch.com/gmod/DMenuOptionCVar:GetValueOn)

---

### DMenuOptionCVar:SetConVar · Client
`DMenuOptionCVar:SetConVar(cvar: string)`

Sets the [console variable](https://wiki.facepunch.com/gmod/ConVars) to be used by [DMenuOptionCVar](https://wiki.facepunch.com/gmod/DMenuOptionCVar).

**Arguments:**
- `cvar` (string) — The console variable name to set

[wiki](https://wiki.facepunch.com/gmod/DMenuOptionCVar:SetConVar)

---

### DMenuOptionCVar:SetValueOff · Client
`DMenuOptionCVar:SetValueOff(value: string)`

Sets the value of the [console variable](https://wiki.facepunch.com/gmod/ConVars) when the [DMenuOptionCVar](https://wiki.facepunch.com/gmod/DMenuOptionCVar) is not checked.

**Arguments:**
- `value` (string) — The value

[wiki](https://wiki.facepunch.com/gmod/DMenuOptionCVar:SetValueOff)

---

### DMenuOptionCVar:SetValueOn · Client
`DMenuOptionCVar:SetValueOn(value: string)`

Sets the value of the [console variable](https://wiki.facepunch.com/gmod/ConVars) when the [DMenuOptionCVar](https://wiki.facepunch.com/gmod/DMenuOptionCVar) is checked.

**Arguments:**
- `value` (string) — The value

[wiki](https://wiki.facepunch.com/gmod/DMenuOptionCVar:SetValueOn)

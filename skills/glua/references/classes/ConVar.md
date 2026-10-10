# ConVar

**Realm:** Shared, Menu  ·  **Members:** 16

An object returned by [CreateConVar](https://wiki.facepunch.com/gmod/Global.CreateConVar), [CreateClientConVar](https://wiki.facepunch.com/gmod/Global.CreateClientConVar) (which uses [CreateConVar](https://wiki.facepunch.com/gmod/Global.CreateConVar) internally), and [GetConVar](https://wiki.facepunch.com/gmod/Global.GetConVar).

It represents a console variable. See [this](https://wiki.facepunch.com/gmod/ConVars) page for more information.

[wiki page](https://wiki.facepunch.com/gmod/ConVar)

### ConVar:GetBool · Shared, Menu
`ConVar:GetBool() → boolean`

Tries to convert the current string value of a [ConVar](https://wiki.facepunch.com/gmod/ConVar) to a boolean.

**Returns:**
- boolean — The boolean value of the console variable.

[wiki](https://wiki.facepunch.com/gmod/ConVar:GetBool)

---

### ConVar:GetDefault · Shared, Menu
`ConVar:GetDefault() → string`

Returns the default value of the [ConVar](https://wiki.facepunch.com/gmod/ConVar)

**Returns:**
- string — The default value of the console variable.

[wiki](https://wiki.facepunch.com/gmod/ConVar:GetDefault)

---

### ConVar:GetFlags · Shared, Menu
`ConVar:GetFlags() → number`

Returns the [FCVAR](https://wiki.facepunch.com/gmod/Enums/FCVAR) flags of the ConVar

**Returns:**
- `flag` (number) — The bitflag.

[wiki](https://wiki.facepunch.com/gmod/ConVar:GetFlags)

---

### ConVar:GetFloat · Shared, Menu
`ConVar:GetFloat() → number`

Attempts to convert the [ConVar](https://wiki.facepunch.com/gmod/ConVar) value to a float

**Returns:**
- number — The float value of the console variable.

[wiki](https://wiki.facepunch.com/gmod/ConVar:GetFloat)

---

### ConVar:GetHelpText · Shared, Menu
`ConVar:GetHelpText() → string`

Returns the help text assigned to that convar.

**Returns:**
- string — The help text

[wiki](https://wiki.facepunch.com/gmod/ConVar:GetHelpText)

---

### ConVar:GetInt · Shared, Menu
`ConVar:GetInt() → number`

Attempts to convert the [ConVar](https://wiki.facepunch.com/gmod/ConVar) value to a integer.

**Returns:**
- number — The integer value of the console variable.

[wiki](https://wiki.facepunch.com/gmod/ConVar:GetInt)

---

### ConVar:GetMax · Shared, Menu
`ConVar:GetMax() → number`

Returns the maximum value of the [ConVar](https://wiki.facepunch.com/gmod/ConVar)

**Returns:**
- number — The maximum value of the ConVar

[wiki](https://wiki.facepunch.com/gmod/ConVar:GetMax)

---

### ConVar:GetMin · Shared, Menu
`ConVar:GetMin() → number`

Returns the minimum value of the [ConVar](https://wiki.facepunch.com/gmod/ConVar)

**Returns:**
- number — The minimum value of the ConVar

[wiki](https://wiki.facepunch.com/gmod/ConVar:GetMin)

---

### ConVar:GetName · Shared, Menu
`ConVar:GetName() → string`

Returns the name of the [ConVar](https://wiki.facepunch.com/gmod/ConVar).

**Returns:**
- string — The name of the console variable.

[wiki](https://wiki.facepunch.com/gmod/ConVar:GetName)

---

### ConVar:GetString · Shared, Menu
`ConVar:GetString() → string`

Returns the current [ConVar](https://wiki.facepunch.com/gmod/ConVar) value as a string.

**Returns:**
- string — The current console variable value as a string.

[wiki](https://wiki.facepunch.com/gmod/ConVar:GetString)

---

### ConVar:IsFlagSet · Shared, Menu
`ConVar:IsFlagSet(flag: number) → boolean`

Returns whether the specified flag is set on the [ConVar](https://wiki.facepunch.com/gmod/ConVar)

**Arguments:**
- `flag` (number, enum [FCVAR](https://wiki.facepunch.com/gmod/Enums/FCVAR)) — The FCVAR flag to test

**Returns:**
- boolean — Whether the flag is set or not

[wiki](https://wiki.facepunch.com/gmod/ConVar:IsFlagSet)

---

### ConVar:Revert · Shared, Menu
`ConVar:Revert()`

Reverts [ConVar](https://wiki.facepunch.com/gmod/ConVar) to its default value

> **Note:** This can only be ran on ConVars created from within Lua.

[wiki](https://wiki.facepunch.com/gmod/ConVar:Revert)

---

### ConVar:SetBool · Shared, Menu
`ConVar:SetBool(value: boolean)`

Sets a ConVar's value to 1 or 0 based on the input boolean. This can only be ran on ConVars created from within Lua.

**Arguments:**
- `value` (boolean) — Value to set the ConVar to.

[wiki](https://wiki.facepunch.com/gmod/ConVar:SetBool)

---

### ConVar:SetFloat · Shared, Menu
`ConVar:SetFloat(value: number)`

Sets a ConVar's value to the input number.

**Arguments:**
- `value` (number) — Value to set the ConVar to.

> **Note:** This can only be ran on ConVars created from within Lua.

[wiki](https://wiki.facepunch.com/gmod/ConVar:SetFloat)

---

### ConVar:SetInt · Shared, Menu
`ConVar:SetInt(value: number)`

Sets a ConVar's value to the input number after converting it to an integer.

**Arguments:**
- `value` (number) — Value to set the ConVar to.

> **Note:** This can only be ran on ConVars created from within Lua.

[wiki](https://wiki.facepunch.com/gmod/ConVar:SetInt)

---

### ConVar:SetString · Shared, Menu
`ConVar:SetString(value: string)`

Sets a ConVar's value to the input string. This can only be ran on ConVars created from within Lua.

**Arguments:**
- `value` (string) — Value to set the ConVar to.

[wiki](https://wiki.facepunch.com/gmod/ConVar:SetString)

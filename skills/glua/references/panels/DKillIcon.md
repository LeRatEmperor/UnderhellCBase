# DKillIcon

**Realm:** Client  ·  **Members:** 2  ·  **Inherits:** `Panel`

Uses the [killicon](https://wiki.facepunch.com/gmod/killicon) to persistently draw a killicon.

[wiki page](https://wiki.facepunch.com/gmod/DKillIcon)

### DKillIcon:GetName · Client
`DKillIcon:GetName() → string`

Gets the killicon being shown.

**Returns:**
- string — The name of the killicon currently being displayed.

[wiki](https://wiki.facepunch.com/gmod/DKillIcon:GetName)

---

### DKillIcon:SetName · Client
`DKillIcon:SetName(iconName: string)`

Sets the killicon to be displayed. You should call [Panel:SizeToContents](https://wiki.facepunch.com/gmod/Panel:SizeToContents) following this.

Killicons can be added with [killicon.Add](https://wiki.facepunch.com/gmod/killicon.Add) and [killicon.AddFont](https://wiki.facepunch.com/gmod/killicon.AddFont).

**Arguments:**
- `iconName` (string) — The name of the killicon to be displayed.

[wiki](https://wiki.facepunch.com/gmod/DKillIcon:SetName)

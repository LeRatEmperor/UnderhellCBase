# permissions

**Realm:** Client, Menu  ·  **Members:** 7

Used to ask player for various potentially dangerous permissions.

[wiki page](https://wiki.facepunch.com/gmod/permissions)

### permissions.AskToConnect · Client
`permissions.AskToConnect(address: string)`

Requests the player to connect to a specified server. The player will be prompted with a confirmation window.

**Arguments:**
- `address` (string) — The address to ask to connect to.

[wiki](https://wiki.facepunch.com/gmod/permissions.AskToConnect)

---

### permissions.Connect · Menu
`permissions.Connect(ip: string)`

Connects player to the server. This is what [permissions.AskToConnect](https://wiki.facepunch.com/gmod/permissions.AskToConnect) uses internally.

**Arguments:**
- `ip` (string) — IP address to connect.

[wiki](https://wiki.facepunch.com/gmod/permissions.Connect)

---

### permissions.EnableVoiceChat · Client
`permissions.EnableVoiceChat(enable: boolean)`

Activates player's microphone as if they pressed the speak button themself. The player will be prompted with a confirmation window which grants permission temporarily/permanently(depending on checkbox state) for the connected server (revokable). 
This is used for TTT's traitor voice channel.

**Arguments:**
- `enable` (boolean) — Enable or disable voice activity.

[wiki](https://wiki.facepunch.com/gmod/permissions.EnableVoiceChat)

---

### permissions.GetAll · Menu
`permissions.GetAll() → table<string,table>`

Returns all permissions per server. Permanent permissions are stored in `settings/permissions.bin`.

**Returns:**
- `permissions` (table<string,table>) — A table of permanent and temporary permissions granted for servers.

[wiki](https://wiki.facepunch.com/gmod/permissions.GetAll)

---

### permissions.Grant · Menu
`permissions.Grant(permission: string, temporary: boolean)`

Grants permission to the current connected server.

**Arguments:**
- `permission` (string) — Permission to grant for the server the player is currently connected.
- `temporary` (boolean) — `true` if the permission should be granted temporary.

[wiki](https://wiki.facepunch.com/gmod/permissions.Grant)

---

### permissions.IsGranted · Client, Menu
`permissions.IsGranted(permission: string) → boolean`

Returns whether the player has granted the current server a specific permission.

**Arguments:**
- `permission` (string) — The permission to poll.

**Returns:**
- boolean — Whether the permission is granted or not.

[wiki](https://wiki.facepunch.com/gmod/permissions.IsGranted)

---

### permissions.Revoke · Menu
`permissions.Revoke(permission: string, ip: string)`

Revokes permission from the server.

**Arguments:**
- `permission` (string) — Permission to revoke from the server.
- `ip` (string) — IP of the server.

[wiki](https://wiki.facepunch.com/gmod/permissions.Revoke)

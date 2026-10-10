# usermessage

**Realm:** Shared  ·  **Members:** 3  ·  `DEPRECATED`

The usermessage library is used to receive user messages from the server on the client.

> **Warning:** Usermessages have a limit of only 256 bytes!

[wiki page](https://wiki.facepunch.com/gmod/usermessage)

### usermessage.GetTable · Shared · `DEPRECATED`
`usermessage.GetTable() → table`

Returns a table of every usermessage hook

**Returns:**
- table — User message hooks

[wiki](https://wiki.facepunch.com/gmod/usermessage.GetTable) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/usermessage.lua#L53-L57)

---

### usermessage.Hook · Shared · `DEPRECATED`
`usermessage.Hook(name: string, callback: function, preArgs: vararg = nil)`

Sets a hook for the specified to be called when a usermessage with the specified name arrives.

**Arguments:**
- `name` (string) — The message name to hook to.
- `callback` (function) — The function to be called if the specified message was received.
- `preArgs` (vararg, default `nil`) — Arguments that are passed to the callback function when the hook is called.

> **Warning:** Usermessages have a limit of only 256 bytes!

[wiki](https://wiki.facepunch.com/gmod/usermessage.Hook) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/usermessage.lua#L63-L70)

---

### usermessage.IncomingMessage · Shared · `DEPRECATED` · `INTERNAL`
`usermessage.IncomingMessage(name: string, msg: bf_read)`

Called by the engine when a usermessage arrives, this method calls the hook function specified by [usermessage.Hook](https://wiki.facepunch.com/gmod/usermessage.Hook) if any.

**Arguments:**
- `name` (string) — The message name.
- `msg` (bf_read) — The message.

[wiki](https://wiki.facepunch.com/gmod/usermessage.IncomingMessage) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/usermessage.lua#L76-L87)

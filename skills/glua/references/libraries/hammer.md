# hammer

**Realm:** Server  ·  **Members:** 1

The hammer library.

[wiki page](https://wiki.facepunch.com/gmod/hammer)

### hammer.SendCommand · Server
`hammer.SendCommand(cmd: string) → string`

Sends command to Hammer, if Hammer is running with the current map loaded.

**Arguments:**
- `cmd` (string) — Command to send including arguments.

**Returns:**
- string — Returns "ok" if command succeeded otherwise returns "badcommand" All changes only happen in hammer, there is *NO* in game representation/feedback

[wiki](https://wiki.facepunch.com/gmod/hammer.SendCommand)

# FCVAR enumeration

**Realm:** Shared, Menu  ·  **Constants:** 23

Enumerations used by [AddConsoleCommand](https://wiki.facepunch.com/gmod/Global.AddConsoleCommand), [concommand.Add](https://wiki.facepunch.com/gmod/concommand.Add), [CreateClientConVar](https://wiki.facepunch.com/gmod/Global.CreateClientConVar) and [CreateConVar](https://wiki.facepunch.com/gmod/Global.CreateConVar).

[wiki page](https://wiki.facepunch.com/gmod/Enums/FCVAR)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `FCVAR_ARCHIVE` | `128` | Shared, Menu | Save the ConVar value into either client.vdf or server.vdf Reported as "a" by `cvarlist`, except Lua ConVars |
| `FCVAR_ARCHIVE_XBOX` | `16777216` | Shared, Menu | Save the ConVar value into config.vdf on XBox |
| `FCVAR_CHEAT` | `16384` | Shared, Menu | Requires `sv_cheats` to be enabled to change the ConVar or run the command Reported as "cheat" by `cvarlist` |
| `FCVAR_CLIENTCMD_CAN_EXECUTE` | `1073741824` | Shared, Menu | `IVEngineClient::ClientCmd` is allowed to execute this command Reported as "clientcmd_can_execute" by `cvarlist` |
| `FCVAR_CLIENTDLL` | `8` | Shared, Menu | ConVar is defined by the client DLL. |
| `FCVAR_DEMO` | `65536` | Shared, Menu | Force the ConVar to be recorded by demo recordings. |
| `FCVAR_DONTRECORD` | `131072` | Shared, Menu | Opposite of FCVAR_DEMO, ensures the ConVar is not recorded in demos Reported as "norecord" by `cvarlist` |
| `FCVAR_GAMEDLL` | `4` | Shared, Menu | ConVar is defined by the game DLL. |
| `FCVAR_LUA_CLIENT` | `262144` | Shared, Menu | Set automatically on all ConVars and console commands created by the client Lua state. |
| `FCVAR_LUA_SERVER` | `524288` | Shared, Menu | Set automatically on all ConVars and console commands created by the server Lua state. |
| `FCVAR_NEVER_AS_STRING` | `4096` | Shared, Menu | Tells the engine to never print this variable as a string. |
| `FCVAR_NONE` | `0` | Shared, Menu | No flags |
| `FCVAR_NOT_CONNECTED` | `4194304` | Shared, Menu | Makes the ConVar not changeable while connected to a server or in singleplayer |
| `FCVAR_NOTIFY` | `256` | Shared, Menu | For serverside ConVars, notifies all players with blue chat text when the value gets changed, also makes the convar appear in A2S_RULES Reported as "nf" by `cvarlist` |
| `FCVAR_PRINTABLEONLY` | `1024` | Shared, Menu | Forces the ConVar to only have printable characters (No control characters) Reported as "print" by `cvarlist` |
| `FCVAR_PROTECTED` | `32` | Shared, Menu | Makes the ConVar value hidden from all clients (For example `sv_password`) Reported as "prot" by `cvarlist` |
| `FCVAR_REPLICATED` | `8192` | Shared, Menu | For serverside ConVars, it will enforce its value on all clients. |
| `FCVAR_SERVER_CAN_EXECUTE` | `268435456` | Shared, Menu | The server is allowed to execute this command on clients. |
| `FCVAR_SERVER_CANNOT_QUERY` | `536870912` | Shared, Menu | Prevents the server from querying value of this ConVar |
| `FCVAR_SPONLY` | `64` | Shared, Menu | Executing the command or changing the ConVar is only allowed in singleplayer Reported as "sp" by `cvarlist` |
| `FCVAR_UNLOGGED` | `2048` | Shared, Menu | Don't log the ConVar changes to console/log files/users Reported as "log" by `cvarlist` |
| `FCVAR_UNREGISTERED` | `1` | Shared, Menu | If this is set, the convar will become anonymous and won't show up in the `find` results. |
| `FCVAR_USERINFO` | `512` | Shared, Menu | For clientside commands, sends the value to the server Reported as "user" by `cvarlist` |

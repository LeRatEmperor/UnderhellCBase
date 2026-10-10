# gameevent

**Realm:** Shared  ·  **Members:** 1

Used to interface with the built-in game events system.



The following is a list of all available game events.

> **Note:** All Serverside gameevents are networked and called clientside. It could happen that a gameevent is called twice because of this like [OnRequestFullUpdate](https://wiki.facepunch.com/gmod/gameevent/OnRequestFullUpdate).

[wiki page](https://wiki.facepunch.com/gmod/gameevent)

### gameevent.Listen · Shared
`gameevent.Listen(eventName: string)`

Adds a [game event](gameevent) listener, creating a new hook using the [hook](https://wiki.facepunch.com/gmod/hook) library, which can be listened to via [hook.Add](https://wiki.facepunch.com/gmod/hook.Add) with the given `eventName` as event.

**Arguments:**
- `eventName` (string) — The event to listen to.

> **Note:** All gameevents are called in the **Menu State**, but if you want to use them you need to use some DLL(like [this](https://github.com/RaphaelIT7/gmod-gameevent) one) or you need to create your own.

[wiki](https://wiki.facepunch.com/gmod/gameevent.Listen)

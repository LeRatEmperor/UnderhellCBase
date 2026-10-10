# notification

**Realm:** Client  ·  **Members:** 3

Used to display notifications on the screen (mid-right).

[wiki page](https://wiki.facepunch.com/gmod/notification)

### notification.AddLegacy · Client
`notification.AddLegacy(text: string, type: number, length: number)`

Adds a standard notification to your screen.

**Arguments:**
- `text` (string) — The text to display.
- `type` (number, enum [NOTIFY](https://wiki.facepunch.com/gmod/Enums/NOTIFY)) — Determines the notification method (e.g.
- `length` (number) — The number of seconds to display the notification for.

[wiki](https://wiki.facepunch.com/gmod/notification.AddLegacy) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/notification.lua#L66-L85)

---

### notification.AddProgress · Client
`notification.AddProgress(id: any, strText: string, frac: number = nil)`

Adds a notification with an animated progress bar.

**Arguments:**
- `id` (any) — Can be any type.
- `strText` (string) — The text to show
- `frac` (number, default `nil`) — If set, overrides the progress bar animation with given percentage.

[wiki](https://wiki.facepunch.com/gmod/notification.AddProgress) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/notification.lua#L26-L55)

---

### notification.Kill · Client
`notification.Kill(uid: any)`

Removes the notification after 0.8 seconds.

**Arguments:**
- `uid` (any) — The unique ID of the notification

[wiki](https://wiki.facepunch.com/gmod/notification.Kill) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/modules/notification.lua#L57-L64)

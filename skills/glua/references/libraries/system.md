# system

**Realm:** Shared, Menu  ·  **Members:** 11

The system library provides functions that allow you to gather information about the system running the game, such as operating system, uptime and battery level.

[wiki page](https://wiki.facepunch.com/gmod/system)

### system.AppTime · Shared, Menu
`system.AppTime() → number`

Returns the total uptime of the current application as reported by Steam.

This will return a similar value to [SysTime](https://wiki.facepunch.com/gmod/Global.SysTime).

**Returns:**
- number — Seconds of game uptime as an integer.

> **Note:** This function does not work on Dedicated Servers and will instead return no value.

[wiki](https://wiki.facepunch.com/gmod/system.AppTime)

---

### system.BatteryPower · Shared, Menu
`system.BatteryPower() → number`

Returns the current battery power.

**Returns:**
- number — 0-100 if a battery (laptop, UPS, etc) is present.

[wiki](https://wiki.facepunch.com/gmod/system.BatteryPower)

---

### system.FlashWindow · Client, Menu
`system.FlashWindow()`

Flashes the window, turning the border to white briefly

[wiki](https://wiki.facepunch.com/gmod/system.FlashWindow)

---

### system.GetCountry · Shared, Menu
`system.GetCountry() → string`

Returns the country code of this computer, determined by the IP of the client. Uses the steamworks API function `SteamUtils()->GetIPCountry()`.

**Returns:**
- string — Two-letter country code, using ISO 3166-1 standard.

> **Note:** This function does not work on Dedicated Servers and will instead return no value.

[wiki](https://wiki.facepunch.com/gmod/system.GetCountry)

---

### system.HasFocus · Shared, Menu
`system.HasFocus() → boolean`

Returns whether or not the game window has focus.

**Returns:**
- boolean — Whether or not the game window has focus.

> **Note:** This function does not work on dedicated servers and will instead return no value.

[wiki](https://wiki.facepunch.com/gmod/system.HasFocus)

---

### system.IsLinux · Shared, Menu
`system.IsLinux() → boolean`

Returns whether the current OS is Linux.

**Returns:**
- boolean — Whether or not the game is running on Linux.

[wiki](https://wiki.facepunch.com/gmod/system.IsLinux)

---

### system.IsOSX · Shared, Menu
`system.IsOSX() → boolean`

Returns whether the current OS is OSX.

**Returns:**
- boolean — Whether or not the game is running on OSX.

[wiki](https://wiki.facepunch.com/gmod/system.IsOSX)

---

### system.IsWindowed · Client, Menu
`system.IsWindowed() → boolean`

Returns whether the game is being run in a window or in fullscreen (you can change this by opening the menu, clicking 'Options', then clicking the 'Video' tab, and changing the Display Mode using the dropdown menu):

**Returns:**
- boolean — Is the game running in a window?

[wiki](https://wiki.facepunch.com/gmod/system.IsWindowed)

---

### system.IsWindows · Shared, Menu
`system.IsWindows() → boolean`

Returns whether the current OS is Windows.

**Returns:**
- boolean — Whether the system the game runs on is Windows or not.

[wiki](https://wiki.facepunch.com/gmod/system.IsWindows)

---

### system.SteamTime · Shared, Menu
`system.SteamTime() → number`

Returns the synchronized Steam time. This is the number of seconds since the [Unix epoch](http://en.wikipedia.org/wiki/Unix_time).

**Returns:**
- number — Current Steam-synchronized Unix time.

> **Note:** This function does not work on Dedicated Servers and will instead return no value.

[wiki](https://wiki.facepunch.com/gmod/system.SteamTime)

---

### system.UpTime · Shared, Menu
`system.UpTime() → number`

Returns the amount of seconds since the Steam user last moved their mouse.

This is a direct binding to ISteamUtils->GetSecondsSinceComputerActive, and is most likely related to Steam's automatic "Away" online status.

**Returns:**
- number — The amount of seconds since the Steam user last moved their mouse.

> **Note:** This function does not work on Dedicated Servers and will instead return no value.

[wiki](https://wiki.facepunch.com/gmod/system.UpTime)

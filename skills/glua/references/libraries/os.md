# os

**Realm:** Shared, Menu  ·  **Members:** 4

The os library is a standard Lua library originally intended to allow Lua access to various features of the Operating System it's running on, however many of the features and functions have been removed in Garry's Mod due to security issues. It's only used in Garry's Mod for date & time operations.

[wiki page](https://wiki.facepunch.com/gmod/os)

### os.clock · Shared, Menu
`os.clock() → number`

Returns the approximate cpu time the application ran.
See also [SysTime](https://wiki.facepunch.com/gmod/Global.SysTime)

**Returns:**
- number — runtime

> **Note:** This function has different precision on Linux (1/100).

[wiki](https://wiki.facepunch.com/gmod/os.clock)

---

### os.date · Shared, Menu
`os.date(format: string, time: number = os.time()) → string`

Returns the date/time as a formatted string or in a table.

**Arguments:**
- `format` (string) — The format string.
- `time` (number, default `os.time()`) — Time to use for the format.

**Returns:**
- string — Formatted date

[wiki](https://wiki.facepunch.com/gmod/os.date)

---

### os.difftime · Shared, Menu
`os.difftime(timeA: number, timeB: number) → number`

Subtracts the second from the first value and rounds the result.

**Arguments:**
- `timeA` (number) — The first value.
- `timeB` (number) — The value to subtract.

**Returns:**
- number — diffTime

[wiki](https://wiki.facepunch.com/gmod/os.difftime)

---

### os.time · Shared, Menu
`os.time(dateData: table = nil) → number`

Returns the system time in seconds past the unix epoch. If a table is supplied, the function attempts to build a system time with the specified table members.

**Arguments:**
- `dateData` (table, default `nil`) — Table to generate the time from.

**Returns:**
- number — Seconds passed since Unix epoch

[wiki](https://wiki.facepunch.com/gmod/os.time)

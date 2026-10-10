# steamworks

**Realm:** Shared, Menu  ·  **Members:** 19

Steamworks related functions.

[wiki page](https://wiki.facepunch.com/gmod/steamworks)

### steamworks.ApplyAddons · Menu
`steamworks.ApplyAddons()`

Refreshes clients addons.

[wiki](https://wiki.facepunch.com/gmod/steamworks.ApplyAddons)

---

### steamworks.Download · Client, Menu
`steamworks.Download(workshopPreviewID: string, uncompress: boolean, resultCallback: function)`

Downloads a file from the supplied addon and saves it as a `.cache` file in `garrysmod/cache/` folder.

This is mostly used to download the preview image of the addon.

In case the retrieved file is an image and you need the [IMaterial](https://wiki.facepunch.com/gmod/IMaterial), use [AddonMaterial](https://wiki.facepunch.com/gmod/Global.AddonMaterial) with the path supplied from the callback.

**Arguments:**
- `workshopPreviewID` (string) — The Preview ID of workshop item.
- `uncompress` (boolean) — Whether to uncompress the file or not, assuming it was compressed with LZMA.
- `resultCallback` (function) — The function to process retrieved data.

> **Note:** You really should be using [steamworks.DownloadUGC](https://wiki.facepunch.com/gmod/steamworks.DownloadUGC) when downloading Steam Workshop items. This is a legacy function for preview images.

[wiki](https://wiki.facepunch.com/gmod/steamworks.Download)

---

### steamworks.DownloadUGC · Client, Menu
`steamworks.DownloadUGC(workshopID: string, resultCallback: function)`

**Arguments:**
- `workshopID` (string) — The ID of workshop item to download.
- `resultCallback` (function) — The function to process retrieved data.

[wiki](https://wiki.facepunch.com/gmod/steamworks.DownloadUGC)

---

### steamworks.FileInfo · Shared, Menu
`steamworks.FileInfo(workshopItemID: string, resultCallback: function)`

Retrieves info about supplied Steam Workshop addon.

**Arguments:**
- `workshopItemID` (string) — The ID of Steam Workshop item.
- `resultCallback` (function) — The function to process retrieved data.

[wiki](https://wiki.facepunch.com/gmod/steamworks.FileInfo)

---

### steamworks.GetList · Shared, Menu
`steamworks.GetList(type: string, tags: table, offset: number, numRetrieve: number, days: number, userID: string = 0, resultCallback: function, searchText: string = nil)`

Retrieves a customized list of Steam Workshop addons.

**Arguments:**
- `type` (string) — The type of items to retrieve.
- `tags` (table) — A table of tags to match.
- `offset` (number) — How much of results to skip from first one.
- `numRetrieve` (number) — How many items to retrieve, up to `50` at a time.
- `days` (number) — When getting `popular` or `trending` content from Steam, this determines a time period, in range of days from `0` to `365`.
- `userID` (string, default `0`) — `"0"` to retrieve all addons, `"1"` to retrieve addons only published by you, or a valid SteamID64 of a user to get workshop items of.
- `resultCallback` (function) — The function to process retrieved data.
- `searchText` (string, default `nil`) — If given, will use the text to filter results.

[wiki](https://wiki.facepunch.com/gmod/steamworks.GetList)

---

### steamworks.GetPlayerName · Client, Menu · `DEPRECATED`
`steamworks.GetPlayerName(steamID64: string) → string`

Retrieves players name by their 64bit SteamID.

You must call [steamworks.RequestPlayerInfo](https://wiki.facepunch.com/gmod/steamworks.RequestPlayerInfo) a decent amount of time before calling this function.

**Arguments:**
- `steamID64` (string) — The 64bit Steam ID ( aka Community ID ) of the player

**Returns:**
- string — The name of that player

[wiki](https://wiki.facepunch.com/gmod/steamworks.GetPlayerName)

---

### steamworks.IsSubscribed · Client, Menu
`steamworks.IsSubscribed(workshopItemID: string) → boolean`

Returns whenever the client is subscribed to the specified Steam Workshop item.

**Arguments:**
- `workshopItemID` (string) — The ID of the Steam Workshop item.

**Returns:**
- boolean — Is the client subscribed to the addon or not.

[wiki](https://wiki.facepunch.com/gmod/steamworks.IsSubscribed)

---

### steamworks.OpenWorkshop · Client, Menu
`steamworks.OpenWorkshop()`

Opens the workshop website in the steam overlay browser.

[wiki](https://wiki.facepunch.com/gmod/steamworks.OpenWorkshop)

---

### steamworks.Publish · Menu · `INTERNAL`
`steamworks.Publish(filename: string, image: string, name: string, desc: string, tags: table, callback: function, fileid: number = nil, changelist: string = None given.)`

Publishes dupes, saves or demos to workshop.

**Arguments:**
- `filename` (string) — Path to the file to upload
- `image` (string) — Path to the image to use as icon
- `name` (string) — Name of the Workshop submission
- `desc` (string) — Description of the Workshop submission
- `tags` (table) — The workshop tags to apply
- `callback` (function) — Callback for when the publishing process finishes.
- `fileid` (number, default `nil`) — If set, the file ID to update
- `changelist` (string, default `None given.`) — List of changes when updating an item.

[wiki](https://wiki.facepunch.com/gmod/steamworks.Publish)

---

### steamworks.RequestPlayerInfo · Client, Menu
`steamworks.RequestPlayerInfo(steamID64: string, callback: function)`

Requests information of the player with SteamID64 for later use with [steamworks.GetPlayerName](https://wiki.facepunch.com/gmod/steamworks.GetPlayerName).

**Arguments:**
- `steamID64` (string) — The 64bit Steam ID of player.
- `callback` (function) — A callback function with the data when it arrives.

[wiki](https://wiki.facepunch.com/gmod/steamworks.RequestPlayerInfo)

---

### steamworks.SetFileCompleted · Menu
`steamworks.SetFileCompleted(workshopid: string) → string`

Sets the workshop item as "completed" by the player. There will be a visual indicator on the Steam Workshop for completed items.

**Arguments:**
- `workshopid` (string) — The Steam Workshop item id

**Returns:**
- string — Whatever you have put in as first argument

[wiki](https://wiki.facepunch.com/gmod/steamworks.SetFileCompleted)

---

### steamworks.SetFilePlayed · Menu
`steamworks.SetFilePlayed(workshopid: string) → string`

Sets whether you have played this addon or not. This will be shown to the user in the Steam Workshop itself:

**Arguments:**
- `workshopid` (string) — The Steam Workshop item ID

**Returns:**
- string — Whatever you have put in as first argument

[wiki](https://wiki.facepunch.com/gmod/steamworks.SetFilePlayed)

---

### steamworks.SetShouldMountAddon · Menu
`steamworks.SetShouldMountAddon(workshopItemID: string, shouldMount: boolean)`

Sets if an addon should be enabled or disabled. Call [steamworks.ApplyAddons](https://wiki.facepunch.com/gmod/steamworks.ApplyAddons) afterwards to update.

**Arguments:**
- `workshopItemID` (string) — The ID of the Steam Workshop item we should enable/disable
- `shouldMount` (boolean) — true to enable the item, false to disable.

[wiki](https://wiki.facepunch.com/gmod/steamworks.SetShouldMountAddon)

---

### steamworks.ShouldMountAddon · Client, Menu
`steamworks.ShouldMountAddon(workshopItemID: string) → boolean`

Returns whenever the specified Steam Workshop addon will be mounted or not.

**Arguments:**
- `workshopItemID` (string) — The ID of the Steam Workshop

**Returns:**
- boolean — Will the workshop item be mounted or not

[wiki](https://wiki.facepunch.com/gmod/steamworks.ShouldMountAddon)

---

### steamworks.Subscribe · Menu · `INTERNAL`
`steamworks.Subscribe(workshopItemID: string)`

Subscribes to the specified workshop addon. Call [steamworks.ApplyAddons](https://wiki.facepunch.com/gmod/steamworks.ApplyAddons) afterwards to update.

**Arguments:**
- `workshopItemID` (string) — The ID of the Steam Workshop item we should subscribe to

[wiki](https://wiki.facepunch.com/gmod/steamworks.Subscribe)

---

### steamworks.Unsubscribe · Menu · `INTERNAL`
`steamworks.Unsubscribe(workshopItemID: string)`

Unsubscribes to the specified workshop addon. Call [steamworks.ApplyAddons](https://wiki.facepunch.com/gmod/steamworks.ApplyAddons) afterwards to update.

This function should `never` be called without a user's consent and should not be called if the addon is currently in use (aka: the user is not in the main menu) as it may result in unexpected behaviour.

**Arguments:**
- `workshopItemID` (string) — The ID of the Steam Workshop item we should unsubscribe from.

[wiki](https://wiki.facepunch.com/gmod/steamworks.Unsubscribe)

---

### steamworks.ViewFile · Client, Menu
`steamworks.ViewFile(workshopItemID: string)`

Opens the workshop website for specified Steam Workshop item in the Steam overlay browser.

**Arguments:**
- `workshopItemID` (string) — The ID of workshop item.

[wiki](https://wiki.facepunch.com/gmod/steamworks.ViewFile)

---

### steamworks.Vote · Menu · `INTERNAL`
`steamworks.Vote(workshopItemID: string, upOrDown: boolean)`

Makes the user vote for the specified addon

**Arguments:**
- `workshopItemID` (string) — The ID of workshop item.
- `upOrDown` (boolean) — Sets if the user should vote up/down.

[wiki](https://wiki.facepunch.com/gmod/steamworks.Vote)

---

### steamworks.VoteInfo · Client, Menu · `DEPRECATED`
`steamworks.VoteInfo(workshopItemID: string, resultCallback: function)`

Retrieves vote info of supplied addon.

**Arguments:**
- `workshopItemID` (string) — The ID of workshop item.
- `resultCallback` (function) — The function to process retrieved data.

[wiki](https://wiki.facepunch.com/gmod/steamworks.VoteInfo)

# UGCPublishWindow

**Realm:** Menu  ·  **Members:** 8  ·  **Inherits:** `DFrame`

A window that is used to publish dupes and saves

[wiki page](https://wiki.facepunch.com/gmod/UGCPublishWindow)

### UGCPublishWindow:CheckInput · Menu
`UGCPublishWindow:CheckInput()`

Checks if the Tags and Title are valid and if so it enables the publish button.

[wiki](https://wiki.facepunch.com/gmod/UGCPublishWindow:CheckInput)

---

### UGCPublishWindow:DisplayError · Menu
`UGCPublishWindow:DisplayError(err: string)`

Displays the given error message.

**Arguments:**
- `err` (string) — The error message.

[wiki](https://wiki.facepunch.com/gmod/UGCPublishWindow:DisplayError)

---

### UGCPublishWindow:DoPublish · Menu
`UGCPublishWindow:DoPublish(wsid: string, err: string)`

Publishes the Item or throws an error if the Title or Tags are invalid

**Arguments:**
- `wsid` (string) — The workshop id
- `err` (string) — If wsid is nil, this will be the error message

[wiki](https://wiki.facepunch.com/gmod/UGCPublishWindow:DoPublish)

---

### UGCPublishWindow:FitContents · Menu
`UGCPublishWindow:FitContents()`

Rezises the panel to nicely fit all children

[wiki](https://wiki.facepunch.com/gmod/UGCPublishWindow:FitContents)

---

### UGCPublishWindow:GetChosenTag · Menu
`UGCPublishWindow:GetChosenTag() → string`

Returns the name of the current selected tag.

**Returns:**
- `tag` (string) — The choosen tag, or nil if none is selected.

[wiki](https://wiki.facepunch.com/gmod/UGCPublishWindow:GetChosenTag)

---

### UGCPublishWindow:OnPublishFinished · Menu
`UGCPublishWindow:OnPublishFinished(wsid: string, err: string)`

Called when the Item was published or if any error occurred while publishing

**Arguments:**
- `wsid` (string) — The workshop id
- `err` (string) — If wsid is nil, this will be the error message

[wiki](https://wiki.facepunch.com/gmod/UGCPublishWindow:OnPublishFinished)

---

### UGCPublishWindow:Setup · Menu
`UGCPublishWindow:Setup(ugcType: string, file: string, imageFile: string, handler: WorkshopFileBase)`

updated the Workshop items list.

**Arguments:**
- `ugcType` (string) — The type / namespace of the WorkshopFileBase that created this panel
- `file` (string) — The File to publish
- `imageFile` (string) — The Image
- `handler` (WorkshopFileBase) — The WorkshopFileBase that created this panel

[wiki](https://wiki.facepunch.com/gmod/UGCPublishWindow:Setup)

---

### UGCPublishWindow:UpdateWorkshopItems · Menu
`UGCPublishWindow:UpdateWorkshopItems()`

updated the Workshop items list.

[wiki](https://wiki.facepunch.com/gmod/UGCPublishWindow:UpdateWorkshopItems)

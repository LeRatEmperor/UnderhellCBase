# HTML

**Realm:** Client, Menu  ·  **Members:** 9  ·  **Inherits:** `Panel`

The HTML control can be used to display web pages just like an internet browser.

[DHTML](https://wiki.facepunch.com/gmod/DHTML) has additional functionality for interfacing with the page, such as sending and receiving data.

## Blocked URL Extentions

This means your url cannot end in any of these extensions, e.g.: (http://yourdomain.com/garry.exe)
* .exe
* .bat
* .dll
* .zip
* .mp3
* .swf

[wiki page](https://wiki.facepunch.com/gmod/HTML)

### HTML:ConsoleMessage · Client, Menu · `hook`
`HTML:ConsoleMessage(msg: string, file: string, lineNr: number, severity: string)`

Called when the page inside the [HTML](https://wiki.facepunch.com/gmod/HTML) window runs the `console.log` javascript function.

On the x86-64 beta, it's called for all built-in `console.*` javascript functions.

Overwriting this function in any way will disable default behavior of printing the message to the in-game console.

**Arguments:**
- `msg` (string) — The message to be logged (or Lua code to be executed; see above).
- `file` (string) — The message source file, if any.
- `lineNr` (number) — The line number in the file the message was output from.
- `severity` (string) — The severity of the message.

[wiki](https://wiki.facepunch.com/gmod/HTML:ConsoleMessage)

---

### HTML:OnBeginLoadingDocument · Client · `hook`
`HTML:OnBeginLoadingDocument(url: string)`

Called when this panel begins loading a page.

**Arguments:**
- `url` (string) — The URL of the current page.

[wiki](https://wiki.facepunch.com/gmod/HTML:OnBeginLoadingDocument)

---

### HTML:OnCallback · Client · `hook`
`HTML:OnCallback(library: string, name: string, arguments: table) → boolean`

Called by the engine when a callback function is called.

**Arguments:**
- `library` (string) — Library name of the JS function that was called.
- `name` (string) — Name of the JS function that was called.
- `arguments` (table) — Table containing all arguments passed to the JS function.

**Returns:**
- boolean — Return `true` to suppress default engine action.

[wiki](https://wiki.facepunch.com/gmod/HTML:OnCallback)

---

### HTML:OnChangeAddressBar · Client · `hook`
`HTML:OnChangeAddressBar(url: string)`

Called when this panel's address changes.

**Arguments:**
- `url` (string) — The URL of the new page.

[wiki](https://wiki.facepunch.com/gmod/HTML:OnChangeAddressBar)

---

### HTML:OnChangeTargetURL · Client · `hook`
`HTML:OnChangeTargetURL(url: string)`

Called by HTML panels when the target URL of the frame has changed, this happens when you hover over a link.

**Arguments:**
- `url` (string) — New target URL.

[wiki](https://wiki.facepunch.com/gmod/HTML:OnChangeTargetURL)

---

### HTML:OnChangeTitle · Client · `hook`
`HTML:OnChangeTitle(newTitle: string)`

Called by HTML panels when the title of the loaded page has been changed.

**Arguments:**
- `newTitle` (string) — The new title of the page.

[wiki](https://wiki.facepunch.com/gmod/HTML:OnChangeTitle)

---

### HTML:OnChildViewCreated · Client · `hook`
`HTML:OnChildViewCreated(sourceURL: string, targetURL: string, isPopup: boolean)`

Called by HTML panels when the page attempts to open a new child view (such as a popup or new tab).

**Arguments:**
- `sourceURL` (string) — The URL of the page requesting to create a child.
- `targetURL` (string) — The URL of the requested child.
- `isPopup` (boolean) — True if the requested view is a popup.

[wiki](https://wiki.facepunch.com/gmod/HTML:OnChildViewCreated)

---

### HTML:OnDocumentReady · Client · `hook`
`HTML:OnDocumentReady(url: string)`

Called by HTML panels when the panel's DOM has been set up. You can run JavaScript in here.

**Arguments:**
- `url` (string) — The URL of the current page.

[wiki](https://wiki.facepunch.com/gmod/HTML:OnDocumentReady)

---

### HTML:OnFinishLoadingDocument · Client · `hook`
`HTML:OnFinishLoadingDocument(url: string)`

Called when this panel successfully loads a page.

**Arguments:**
- `url` (string) — The URL of the current page.

[wiki](https://wiki.facepunch.com/gmod/HTML:OnFinishLoadingDocument)

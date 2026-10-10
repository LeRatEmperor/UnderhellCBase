# chat

**Realm:** Client  ·  **Members:** 6

The chat library's purpose is to interface with the default chatbox.

[wiki page](https://wiki.facepunch.com/gmod/chat)

### chat.AddText · Client
`chat.AddText(arguments: vararg)`

Adds text to the local player's chat box (which only they can read).

**Arguments:**
- `arguments` (vararg) — The message to be added to the chat box.

[wiki](https://wiki.facepunch.com/gmod/chat.AddText)

---

### chat.Close · Client
`chat.Close()`

Closes the chat window.

[wiki](https://wiki.facepunch.com/gmod/chat.Close)

---

### chat.GetChatBoxPos · Client
`chat.GetChatBoxPos() → number, number`

Returns the chatbox position.

**Returns:**
- number — The X coordinate of the chatbox's position.
- number — The Y coordinate of the chatbox's position.

[wiki](https://wiki.facepunch.com/gmod/chat.GetChatBoxPos)

---

### chat.GetChatBoxSize · Client
`chat.GetChatBoxSize() → number, number`

Returns the chatbox size.

**Returns:**
- number — The width of the chatbox.
- number — The height of the chatbox.

[wiki](https://wiki.facepunch.com/gmod/chat.GetChatBoxSize)

---

### chat.Open · Client
`chat.Open(mode: number)`

Opens the chat window.

**Arguments:**
- `mode` (number) — If equals 1, opens public chat, otherwise opens team chat.

[wiki](https://wiki.facepunch.com/gmod/chat.Open)

---

### chat.PlaySound · Client
`chat.PlaySound()`

Plays the chat "tick" sound.

[wiki](https://wiki.facepunch.com/gmod/chat.PlaySound)

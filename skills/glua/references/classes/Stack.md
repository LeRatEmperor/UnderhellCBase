# Stack

**Realm:** Shared, Menu  ·  **Members:** 5

An object returned by [util.Stack](https://wiki.facepunch.com/gmod/util.Stack).

Like a Lua table, a Stack is a container. It follows the principle of LIFO (last in, first out).

The Stack works like a stack of papers: the first page you put down (push) will be the last one you remove (pop). That also means that the last page you put down, will be the first to be removed.

[wiki page](https://wiki.facepunch.com/gmod/Stack)

### Stack:Pop · Shared, Menu
`Stack:Pop(amount: number = 1) → any`

Pop an item from the stack

**Arguments:**
- `amount` (number, default `1`) — Amount of items you want to pop.

**Returns:**
- `object` (any) — Latest popped item.

[wiki](https://wiki.facepunch.com/gmod/Stack:Pop) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L257-L277)

---

### Stack:PopMulti · Shared, Menu
`Stack:PopMulti(amount: number = 1) → table`

Pop an item from the stack

**Arguments:**
- `amount` (number, default `1`) — Amount of items you want to pop.

**Returns:**
- `items` (table) — The Popped Items.

[wiki](https://wiki.facepunch.com/gmod/Stack:PopMulti) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L279-L305)

---

### Stack:Push · Shared, Menu
`Stack:Push(object: any)`

Push an item onto the stack

**Arguments:**
- `object` (any) — The item you want to push

[wiki](https://wiki.facepunch.com/gmod/Stack:Push) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L251-L255)

---

### Stack:Size · Shared, Menu
`Stack:Size() → number`

Returns the size of the stack

**Returns:**
- number — The size of the stack

[wiki](https://wiki.facepunch.com/gmod/Stack:Size) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L317-L319)

---

### Stack:Top · Shared, Menu
`Stack:Top() → any`

Get the item at the top of the stack

**Returns:**
- any — The item at the top of the stack

[wiki](https://wiki.facepunch.com/gmod/Stack:Top) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/util.lua#L307-L315)

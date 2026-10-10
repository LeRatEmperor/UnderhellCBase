# bit

**Realm:** Shared, Menu  ·  **Members:** 12

The bitwise library contains useful functions for bitwise operations.
Make sure you're familiar with [Bitwise Operators](https://code.tutsplus.com/articles/understanding-bitwise-operators--active-11301)

[wiki page](https://wiki.facepunch.com/gmod/bit)

### bit.arshift · Shared, Menu
`bit.arshift(value: number, shiftCount: number) → number`

Returns the arithmetically shifted value.

**Arguments:**
- `value` (number) — The value to be manipulated.
- `shiftCount` (number) — Amounts of bits to shift.

**Returns:**
- number — The shifted value.

[wiki](https://wiki.facepunch.com/gmod/bit.arshift)

---

### bit.band · Shared, Menu
`bit.band(value: number, ...: vararg) → number`

Performs the bitwise `and` for all values specified.

**Arguments:**
- `value` (number) — The value to be manipulated.
- `...` (vararg) — Values bit to perform bitwise "and" with.

**Returns:**
- number — Result of bitwise "and" operation.

[wiki](https://wiki.facepunch.com/gmod/bit.band)

---

### bit.bnot · Shared, Menu
`bit.bnot(value: number) → number`

Returns the bitwise not of the value. Inverts every bit of the 32bit integer.

**Arguments:**
- `value` (number) — The value to be inverted.

**Returns:**
- number — The result of bitwise not.

[wiki](https://wiki.facepunch.com/gmod/bit.bnot)

---

### bit.bor · Shared, Menu
`bit.bor(value1: number, ...: vararg) → number`

Returns the bitwise OR of all values specified.

**Arguments:**
- `value1` (number) — The first value.
- `...` (vararg) — Extra values to be evaluated.

**Returns:**
- number — The bitwise OR result between all numbers.

[wiki](https://wiki.facepunch.com/gmod/bit.bor)

---

### bit.bswap · Shared, Menu
`bit.bswap(value: number) → number`

Swaps the byte order.

**Arguments:**
- `value` (number) — The value to be byte swapped.

**Returns:**
- number — The resulting swapped value.

[wiki](https://wiki.facepunch.com/gmod/bit.bswap)

---

### bit.bxor · Shared, Menu
`bit.bxor(value: number, otherValues: number = nil) → number`

Returns the bitwise xor of all values specified.

**Arguments:**
- `value` (number) — The value to be manipulated.
- `otherValues` (number, default `nil`) — Values bit xor with.

**Returns:**
- number — The XORed value.

[wiki](https://wiki.facepunch.com/gmod/bit.bxor)

---

### bit.lshift · Shared, Menu
`bit.lshift(value: number, shiftCount: number) → number`

Returns the result of shifting given value left bitwise by given number of bits. See [this wiki article](https://en.wikipedia.org/wiki/Bitwise_operation#Bit_shifts) for more details.

**Arguments:**
- `value` (number) — The value to be manipulated.
- `shiftCount` (number) — Amounts of bits to shift left by.

**Returns:**
- number — The resulting value.

> **Note:** The returned value will be clamped to a signed 32-bit integer, even on 64-bit builds.

[wiki](https://wiki.facepunch.com/gmod/bit.lshift)

---

### bit.rol · Shared, Menu
`bit.rol(value: number, shiftCount: number) → number`

Returns the left rotated value.

**Arguments:**
- `value` (number) — The value to be manipulated.
- `shiftCount` (number) — Amounts of bits to rotate left by.

**Returns:**
- number — The shifted value.

[wiki](https://wiki.facepunch.com/gmod/bit.rol)

---

### bit.ror · Shared, Menu
`bit.ror(value: number, shiftCount: number) → number`

Returns the right rotated value.

**Arguments:**
- `value` (number) — The value to be manipulated.
- `shiftCount` (number) — Amounts of bits to rotate right by.

**Returns:**
- number — The shifted value.

[wiki](https://wiki.facepunch.com/gmod/bit.ror)

---

### bit.rshift · Shared, Menu
`bit.rshift(value: number, shiftCount: number) → number`

Returns the right shifted value.

**Arguments:**
- `value` (number) — The value to be manipulated.
- `shiftCount` (number) — Amounts of bits to shift right by.

**Returns:**
- number — The shifted value.

> **Note:** The returned value will be clamped to a signed 32-bit integer, even on 64-bit builds.

[wiki](https://wiki.facepunch.com/gmod/bit.rshift)

---

### bit.tobit · Shared, Menu
`bit.tobit(value: number) → number`

Normalizes the specified value and clamps it in the range of a signed 32bit integer.

**Arguments:**
- `value` (number) — The value to be normalized.

**Returns:**
- number — The 32 bits of the provided value.

[wiki](https://wiki.facepunch.com/gmod/bit.tobit)

---

### bit.tohex · Shared, Menu
`bit.tohex(value: number, characters: number = 8) → string`

Returns the hexadecimal representation of the number with the specified number of characters.

**Arguments:**
- `value` (number) — The value to be normalized.
- `characters` (number, default `8`) — Maximum number of characters, if set.

**Returns:**
- string — The hexadecimal representation, such as "00000001".

[wiki](https://wiki.facepunch.com/gmod/bit.tohex)

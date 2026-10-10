# debugoverlay

**Realm:** Shared  ·  **Members:** 12

The debugoverlay library is mainly useful for 3D debugging, it can be used to draw shapes on the screen for debug purposes.

> **Note:** These functions will not do anything unless the `developer` console variable is set to non 0.

[wiki page](https://wiki.facepunch.com/gmod/debugoverlay)

### debugoverlay.Axis · Shared
`debugoverlay.Axis(origin: Vector, ang: Angle, size: number, lifetime: number = 1, ignoreZ: boolean = false)`

Displays an axis indicator at the specified position, with 3 lines pointing in the positive direction (i.e. direction in which the values increase) of each axis.

**Arguments:**
- `origin` (Vector) — Position origin.
- `ang` (Angle) — Angle of the axis.
- `size` (number) — Size of the axis.
- `lifetime` (number, default `1`) — Number of seconds to appear.
- `ignoreZ` (boolean, default `false`) — If true, will draw on top of everything; ignoring the Z buffer.

> **Note:** This function will silently fail if the `developer` [ConVar](https://wiki.facepunch.com/gmod/ConVar) is set to `0`.  
> 		It is not networked to clients, except for the [listen server host](https://wiki.facepunch.com/gmod/Player:IsListenServerHost).  
> 		It will not work when the game is paused.

[wiki](https://wiki.facepunch.com/gmod/debugoverlay.Axis)

---

### debugoverlay.Box · Shared
`debugoverlay.Box(origin: Vector, mins: Vector, maxs: Vector, lifetime: number = 1, color: Color = Color( 255, 255, 255, 255 ))`

Displays a solid coloured box at the specified position.

**Arguments:**
- `origin` (Vector) — Position origin.
- `mins` (Vector) — Minimum bounds of the box.
- `maxs` (Vector) — Maximum bounds of the box.
- `lifetime` (number, default `1`) — Number of seconds to appear.
- `color` (Color, default `Color( 255, 255, 255, 255 )`) — The color of the box.

> **Note:** This function will silently fail if the `developer` [ConVar](https://wiki.facepunch.com/gmod/ConVar) is set to `0`.  
> It is not networked to clients, except for the [listen server host](https://wiki.facepunch.com/gmod/Player:IsListenServerHost).  
> It will not work when the game is paused.

[wiki](https://wiki.facepunch.com/gmod/debugoverlay.Box)

---

### debugoverlay.BoxAngles · Shared
`debugoverlay.BoxAngles(pos: Vector, mins: Vector, maxs: Vector, ang: Angle, lifetime: number = 1, color: Color = Color( 255, 255, 255, 255 ))`

Displays a solid colored rotated box at the specified position.

**Arguments:**
- `pos` (Vector) — World position.
- `mins` (Vector) — The mins of the box (lowest corner).
- `maxs` (Vector) — The maxs of the box (highest corner).
- `ang` (Angle) — The angle to draw the box at.
- `lifetime` (number, default `1`) — Amount of seconds to show the box.
- `color` (Color, default `Color( 255, 255, 255, 255 )`) — The color of the box.

> **Note:** This function will silently fail if the `developer` [ConVar](https://wiki.facepunch.com/gmod/ConVar) is set to `0`.  
> It is not networked to clients, except for the [listen server host](https://wiki.facepunch.com/gmod/Player:IsListenServerHost).  
> It will not work when the game is paused.

[wiki](https://wiki.facepunch.com/gmod/debugoverlay.BoxAngles)

---

### debugoverlay.Cross · Shared
`debugoverlay.Cross(position: Vector, size: number, lifetime: number = 1, color: Color = Color( 255, 255, 255 ), ignoreZ: boolean = false)`

Creates a coloured cross at the specified position for the specified time.

**Arguments:**
- `position` (Vector) — Position origin.
- `size` (number) — Size of the cross.
- `lifetime` (number, default `1`) — Number of seconds the cross will appear for.
- `color` (Color, default `Color( 255, 255, 255 )`) — The color of the cross.
- `ignoreZ` (boolean, default `false`) — If true, will draw on top of everything; ignoring the Z buffer.

> **Note:** This function will silently fail if the `developer` [ConVar](https://wiki.facepunch.com/gmod/ConVar) is set to `0`.  
> It is not networked to clients, except for the [listen server host](https://wiki.facepunch.com/gmod/Player:IsListenServerHost).  
> It will not work when the game is paused.

[wiki](https://wiki.facepunch.com/gmod/debugoverlay.Cross)

---

### debugoverlay.EntityTextAtPosition · Shared
`debugoverlay.EntityTextAtPosition(pos: Vector, line: number, text: string, lifetime: number = 1, color: Color = Color( 255, 255, 255 ))`

Displays 2D text at the specified coordinates.

**Arguments:**
- `pos` (Vector) — The position in 3D to display the text.
- `line` (number) — Line of text, will offset text on the to display the new line unobstructed.
- `text` (string) — The text to display.
- `lifetime` (number, default `1`) — Number of seconds to appear.
- `color` (Color, default `Color( 255, 255, 255 )`) — The color of the box.

> **Note:** This function will silently fail if the `developer` [ConVar](https://wiki.facepunch.com/gmod/ConVar) is set to `0`.  
> It is not networked to clients, except for the [listen server host](https://wiki.facepunch.com/gmod/Player:IsListenServerHost).  
> It will not work when the game is paused.

[wiki](https://wiki.facepunch.com/gmod/debugoverlay.EntityTextAtPosition)

---

### debugoverlay.Grid · Shared
`debugoverlay.Grid(position: Vector)`

Draws a 3D grid of limited size in given position.

**Arguments:**
- `position` (Vector)

> **Note:** This function will silently fail if the `developer` [ConVar](https://wiki.facepunch.com/gmod/ConVar) is set to `0`.  
> It is not networked to clients, except for the [listen server host](https://wiki.facepunch.com/gmod/Player:IsListenServerHost).  
> It will not work when the game is paused.

[wiki](https://wiki.facepunch.com/gmod/debugoverlay.Grid)

---

### debugoverlay.Line · Shared
`debugoverlay.Line(pos1: Vector, pos2: Vector, lifetime: number = 1, color: Color = Color( 255, 255, 255 ), ignoreZ: boolean = false)`

Displays a coloured line at the specified position.

**Arguments:**
- `pos1` (Vector) — First position of the line.
- `pos2` (Vector) — Second position of the line.
- `lifetime` (number, default `1`) — Number of seconds to appear.
- `color` (Color, default `Color( 255, 255, 255 )`) — The color of the line.
- `ignoreZ` (boolean, default `false`) — If true, will draw on top of everything; ignoring the Z buffer.

> **Note:** This function will silently fail if the `developer` [ConVar](https://wiki.facepunch.com/gmod/ConVar) is set to `0`.  
> It is not networked to clients, except for the [listen server host](https://wiki.facepunch.com/gmod/Player:IsListenServerHost).  
> It will not work when the game is paused.

[wiki](https://wiki.facepunch.com/gmod/debugoverlay.Line)

---

### debugoverlay.ScreenText · Shared
`debugoverlay.ScreenText(x: number, y: number, text: string, lifetime: number = 1, color: Color = Color( 255, 255, 255 ))`

Displays text triangle at the specified coordinates.

**Arguments:**
- `x` (number) — The position of the text, from 0 ( left ) to 1 ( right ).
- `y` (number) — The position of the text, from 0 ( top ) to 1 ( bottom ).
- `text` (string) — The text to display.
- `lifetime` (number, default `1`) — Number of seconds to appear.
- `color` (Color, default `Color( 255, 255, 255 )`) — The color of the box.

> **Note:** This function will silently fail if the `developer` [ConVar](https://wiki.facepunch.com/gmod/ConVar) is set to `0`.  
> It is not networked to clients, except for the [listen server host](https://wiki.facepunch.com/gmod/Player:IsListenServerHost).  
> It will not work when the game is paused.

[wiki](https://wiki.facepunch.com/gmod/debugoverlay.ScreenText)

---

### debugoverlay.Sphere · Shared
`debugoverlay.Sphere(origin: Vector, size: number, lifetime: number = 1, color: Color = Color( 255, 255, 255 ), ignoreZ: boolean = false)`

Displays a coloured sphere at the specified position.

**Arguments:**
- `origin` (Vector) — Position origin.
- `size` (number) — Size of the sphere.
- `lifetime` (number, default `1`) — Number of seconds to appear.
- `color` (Color, default `Color( 255, 255, 255 )`) — The color of the sphere.
- `ignoreZ` (boolean, default `false`) — If true, will draw on top of everything; ignoring the Z buffer.

> **Note:** This function will silently fail if the `developer` [ConVar](https://wiki.facepunch.com/gmod/ConVar) is set to `0`.  
> It is not networked to clients, except for the [listen server host](https://wiki.facepunch.com/gmod/Player:IsListenServerHost).  
> It will not work when the game is paused.

[wiki](https://wiki.facepunch.com/gmod/debugoverlay.Sphere)

---

### debugoverlay.SweptBox · Shared
`debugoverlay.SweptBox(vStart: Vector, vEnd: Vector, vMins: Vector, vMaxs: Vector, ang: Angle, lifetime: number = 1, color: Color = Color( 255, 255, 255 ))`

Displays "swept" box, two boxes connected with lines by their vertices.

**Arguments:**
- `vStart` (Vector) — The start position of the box.
- `vEnd` (Vector) — The end position of the box.
- `vMins` (Vector) — The "minimum" edge of the box.
- `vMaxs` (Vector) — The "maximum" edge of the box.
- `ang` (Angle) — The angle to draw the box at.
- `lifetime` (number, default `1`) — Number of seconds to appear.
- `color` (Color, default `Color( 255, 255, 255 )`) — The color of the box.

> **Note:** This function will silently fail if the `developer` [ConVar](https://wiki.facepunch.com/gmod/ConVar) is set to `0`.  
> It is not networked to clients, except for the [listen server host](https://wiki.facepunch.com/gmod/Player:IsListenServerHost).  
> It will not work when the game is paused.

[wiki](https://wiki.facepunch.com/gmod/debugoverlay.SweptBox)

---

### debugoverlay.Text · Shared
`debugoverlay.Text(origin: Vector, text: string, lifetime: number = 1, viewCheck: boolean = false)`

Displays text at the specified position.

**Arguments:**
- `origin` (Vector) — Position origin.
- `text` (string) — String message to display.
- `lifetime` (number, default `1`) — Number of seconds to appear.
- `viewCheck` (boolean, default `false`) — Clip text that is obscured.

> **Note:** This function will silently fail if the `developer` [ConVar](https://wiki.facepunch.com/gmod/ConVar) is set to `0`.  
> It is not networked to clients, except for the [listen server host](https://wiki.facepunch.com/gmod/Player:IsListenServerHost).  
> It will not work when the game is paused.

[wiki](https://wiki.facepunch.com/gmod/debugoverlay.Text)

---

### debugoverlay.Triangle · Shared
`debugoverlay.Triangle(pos1: Vector, pos2: Vector, pos3: Vector, lifetime: number = 1, color: Color = Color( 255, 255, 255 ), ignoreZ: boolean = false)`

Displays a colored triangle at the specified coordinates.

**Arguments:**
- `pos1` (Vector) — First point of the triangle.
- `pos2` (Vector) — Second point of the triangle.
- `pos3` (Vector) — Third point of the triangle.
- `lifetime` (number, default `1`) — Number of seconds to appear.
- `color` (Color, default `Color( 255, 255, 255 )`) — The color of the box.
- `ignoreZ` (boolean, default `false`) — If true, will draw on top of everything; ignoring the Z buffer.

> **Note:** This function will silently fail if the `developer` [ConVar](https://wiki.facepunch.com/gmod/ConVar) is set to `0`.  
> It is not networked to clients, except for the [listen server host](https://wiki.facepunch.com/gmod/Player:IsListenServerHost).  
> It will not work when the game is paused.

[wiki](https://wiki.facepunch.com/gmod/debugoverlay.Triangle)

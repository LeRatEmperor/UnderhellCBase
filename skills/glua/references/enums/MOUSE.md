# MOUSE enumeration

**Realm:** Shared, Menu  ·  **Constants:** 10

Enumerations used by:
* [input.IsMouseDown](https://wiki.facepunch.com/gmod/input.IsMouseDown)
* [input.WasMousePressed](https://wiki.facepunch.com/gmod/input.WasMousePressed)
* [input.WasMouseDoublePressed](https://wiki.facepunch.com/gmod/input.WasMouseDoublePressed)

It's also part of the [BUTTON_CODE](https://wiki.facepunch.com/gmod/Enums/BUTTON_CODE).
# Catch mouse wheel
You can catch the mouse wheel's value by:
```lua
local testVal = 0
hook.Add("InputMouseApply", "testMouseWheel", function(cmd, x, y, ang)
    testVal = testVal + cmd:GetMouseWheel() * 2 --any scale number you want to use
    print(testVal)
end)
```

[wiki page](https://wiki.facepunch.com/gmod/Enums/MOUSE)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `MOUSE_4` | `110` | Shared, Menu | Mouse 4 button ( Sometimes, mouse wheel tilt left ) |
| `MOUSE_5` | `111` | Shared, Menu | Mouse 5 button ( Sometimes, mouse wheel tilt right ) |
| `MOUSE_COUNT` | `7` | Shared, Menu | Mouse button count |
| `MOUSE_FIRST` | `107` | Shared, Menu | First mouse button |
| `MOUSE_LAST` | `113` | Shared, Menu | Last mouse button |
| `MOUSE_LEFT` | `107` | Shared, Menu | Left mouse button |
| `MOUSE_MIDDLE` | `109` | Shared, Menu | Middle mouse button, aka the wheel press |
| `MOUSE_RIGHT` | `108` | Shared, Menu | Right mouse button |
| `MOUSE_WHEEL_DOWN` | `113` | Shared, Menu | Mouse wheel scroll down |
| `MOUSE_WHEEL_UP` | `112` | Shared, Menu | Mouse wheel scroll up |

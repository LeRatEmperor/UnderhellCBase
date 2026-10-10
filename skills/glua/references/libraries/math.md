# math

**Realm:** Shared, Menu  ·  **Members:** 87

The math library is a standard Lua library that provides functions for manipulating numbers. In Garry's Mod several additional math functions have been added.

[wiki page](https://wiki.facepunch.com/gmod/math)

### math.abs · Shared, Menu
`math.abs(x: number) → number`

Calculates the absolute value of a number (effectively removes any negative sign).

**Arguments:**
- `x` (number) — The number to get the absolute value of.

**Returns:**
- number — The absolute value.

[wiki](https://wiki.facepunch.com/gmod/math.abs)

---

### math.acos · Shared, Menu
`math.acos(cos: number) → number`

Returns the [arccosine](https://en.wikipedia.org/wiki/Arccosine) of the given number.

**Arguments:**
- `cos` (number) — Cosine value in range of -1 to 1.

**Returns:**
- number — An angle in radians, between 0 and pi, which has the given cos value.

[wiki](https://wiki.facepunch.com/gmod/math.acos)

---

### math.AngleDifference · Shared, Menu
`math.AngleDifference(a: number, b: number) → number`

Calculates the difference between two angles.

**Arguments:**
- `a` (number) — The first angle.
- `b` (number) — The second angle.

**Returns:**
- number — The difference between the angles between -180 and 180

[wiki](https://wiki.facepunch.com/gmod/math.AngleDifference) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L191-L201)

---

### math.Approach · Shared, Menu
`math.Approach(current: number, target: number, change: number) → number`

Gradually approaches the target value by the specified amount.

**Arguments:**
- `current` (number) — The value we're currently at.
- `target` (number) — The target value.
- `change` (number) — The amount that the current value is allowed to change by to approach the target.

**Returns:**
- number — New current value, closer to the target than it was previously.

[wiki](https://wiki.facepunch.com/gmod/math.Approach) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L168-L184)

---

### math.ApproachAngle · Shared, Menu
`math.ApproachAngle(currentAngle: number, targetAngle: number, rate: number) → number`

Increments an angle towards another by specified rate.

**Arguments:**
- `currentAngle` (number) — The current angle to increase
- `targetAngle` (number) — The angle to increase towards
- `rate` (number) — The amount to approach the target angle by

**Returns:**
- number — Modified angle

> **Note:** This function is for numbers representing angles (0-360), NOT [Angle](https://wiki.facepunch.com/gmod/Angle) objects!

[wiki](https://wiki.facepunch.com/gmod/math.ApproachAngle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L203-L209)

---

### math.asin · Shared, Menu
`math.asin(normal: number) → number`

Returns the [arcsine](https://en.wikipedia.org/wiki/Inverse_trigonometric_functions) of the given number.

**Arguments:**
- `normal` (number) — Sine value in the range of -1 to 1.

**Returns:**
- number — An angle in radians, in the range -pi/2 to pi/2, which has the given sine value.

[wiki](https://wiki.facepunch.com/gmod/math.asin)

---

### math.atan · Shared, Menu
`math.atan(normal: number) → number`

Returns the [arctangent](https://en.wikipedia.org/wiki/Inverse_trigonometric_functions) of the given number.

**Arguments:**
- `normal` (number) — Tangent value.

**Returns:**
- number — An angle in radians, in the range -pi/2 to pi/2, which has the given tangent.

[wiki](https://wiki.facepunch.com/gmod/math.atan)

---

### math.atan2 · Shared, Menu
`math.atan2(y: number, x: number) → number`

functions like [math.atan](https://wiki.facepunch.com/gmod/math.atan)(y / x), except it also takes into account the quadrant of the angle and so doesn't have a limited range of output.

**Arguments:**
- `y` (number) — Y coordinate.
- `x` (number) — X coordinate.

**Returns:**
- number — The angle of the line from (0, 0) to (x, y) in radians, in the left-open interval (-pi, pi]

> **Note:** The Y argument comes first!

[wiki](https://wiki.facepunch.com/gmod/math.atan2)

---

### math.BinToInt · Shared, Menu
`math.BinToInt(string: string) → number`

Converts a binary string into a number.

**Arguments:**
- `string` (string) — Binary string to convert

**Returns:**
- number — Base 10 number.

[wiki](https://wiki.facepunch.com/gmod/math.BinToInt) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L17-L19)

---

### math.BSplinePoint · Shared, Menu
`math.BSplinePoint(fraction: number, points: table, fractionMax: number) → Vector`

Basic code for Bézier-Spline algorithm.

**Arguments:**
- `fraction` (number) — A number in the range `[0,fractionMax]` which controls which location along the spline's length should be evaluated as the return value.
- `points` (table) — A table of Vectors that form the spline.
- `fractionMax` (number) — The maximum value of the `fraction` argument.

**Returns:**
- Vector — The point on the Bézier curve that corresponds to the given `fraction` argument.

[wiki](https://wiki.facepunch.com/gmod/math.BSplinePoint) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L132-L148)

---

### math.calcBSplineN · Shared, Menu · `INTERNAL`
`math.calcBSplineN(i: number, k: number, t: number, tinc: number) → number`

Basic code for Bezier-Spline algorithm, helper function for [math.BSplinePoint](https://wiki.facepunch.com/gmod/math.BSplinePoint).

**Arguments:**
- `i` (number)
- `k` (number)
- `t` (number)
- `tinc` (number)

**Returns:**
- number

[wiki](https://wiki.facepunch.com/gmod/math.calcBSplineN) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L90-L130)

---

### math.ceil · Shared, Menu
`math.ceil(number: number) → number`

Ceils or rounds a number up.

	See [math.floor](https://wiki.facepunch.com/gmod/math.floor) for the inverse of this function.

**Arguments:**
- `number` (number) — The number to be rounded up.

**Returns:**
- number — ceiled numbers

[wiki](https://wiki.facepunch.com/gmod/math.ceil)

---

### math.CHSpline · Shared, Menu
`math.CHSpline(frac: number, point0: Vector, tan0: Vector, point1: Vector, tan1: Vector) → Vector`

Cubic Hermite spline algorithm.

**Arguments:**
- `frac` (number) — From 0 to 1, where alongside the spline the point will be.
- `point0` (Vector) — First point for the spline.
- `tan0` (Vector) — Tangent for the first point for the spline.
- `point1` (Vector) — Second point for the spline.
- `tan1` (Vector) — Tangent for the second point for the spline.

**Returns:**
- Vector — Point on the cubic Hermite spline, at given fraction.

[wiki](https://wiki.facepunch.com/gmod/math.CHSpline) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L148-L159)

---

### math.Clamp · Shared, Menu
`math.Clamp(input: number, min: number, max: number) → number`

Clamps a number between a minimum and maximum value.

**Arguments:**
- `input` (number) — The number to clamp.
- `min` (number) — The minimum value.
- `max` (number) — The maximum value, this function will never return a number greater than this.

**Returns:**
- number — The clamped value.

[wiki](https://wiki.facepunch.com/gmod/math.Clamp) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L39-L41)

---

### math.cos · Shared, Menu
`math.cos(number: number) → number`

Returns the [cosine](https://en.wikipedia.org/wiki/Trigonometric_functions#cos) of given angle.

**Arguments:**
- `number` (number) — Angle in radians

**Returns:**
- number — Cosine of given angle in the range (-1, 1)

[wiki](https://wiki.facepunch.com/gmod/math.cos)

---

### math.cosh · Shared, Menu
`math.cosh(number: number) → number`

Returns the [hyperbolic cosine](https://en.wikipedia.org/wiki/Cosh_(mathematical_function)) of the given angle.

**Arguments:**
- `number` (number) — Angle in radians.

**Returns:**
- number — The hyperbolic cosine of the given angle.

[wiki](https://wiki.facepunch.com/gmod/math.cosh)

---

### math.CubicBezier · Shared, Menu
`math.CubicBezier(frac: number, p0: Vector, p1: Vector, p2: Vector, p3: Vector) → Vector`

Lerp point between 4 control points with cubic bezier.

See [math.QuadraticBezier](https://wiki.facepunch.com/gmod/math.QuadraticBezier) for a similar function which works with 3 control points.

**Arguments:**
- `frac` (number) — The fraction for finding the result.
- `p0` (Vector) — First control point
- `p1` (Vector) — First tangent
- `p2` (Vector) — Second tangent
- `p3` (Vector) — Second control point

**Returns:**
- Vector — Point between control points at the specified fraction

[wiki](https://wiki.facepunch.com/gmod/math.CubicBezier) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L220-L226)

---

### math.deg · Shared, Menu
`math.deg(radians: number) → number`

Converts radians to degrees.

**Arguments:**
- `radians` (number) — Value to be converted to degrees.

**Returns:**
- number — degrees

[wiki](https://wiki.facepunch.com/gmod/math.deg) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/[builtin:deg]#L-L1-L-L1)

---

### math.Dist · Shared, Menu · `DEPRECATED`
`math.Dist(x1: number, y1: number, x2: number, y2: number) → number`

Returns the difference between two points in 2D space. Alias of [math.Distance](https://wiki.facepunch.com/gmod/math.Distance).

**Arguments:**
- `x1` (number) — X position of first point
- `y1` (number) — Y position of first point
- `x2` (number) — X position of second point
- `y2` (number) — Y position of second point

**Returns:**
- number — Distance between the two points.

[wiki](https://wiki.facepunch.com/gmod/math.Dist) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L6-L10)

---

### math.Distance · Shared, Menu
`math.Distance(x1: number, y1: number, x2: number, y2: number) → number`

Returns the difference between two points in 2D space.

**Arguments:**
- `x1` (number) — X position of first point
- `y1` (number) — Y position of first point
- `x2` (number) — X position of second point
- `y2` (number) — Y position of second point

**Returns:**
- number — Distance between the two points

[wiki](https://wiki.facepunch.com/gmod/math.Distance) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L6-L10)

---

### math.DistanceSqr · Shared, Menu
`math.DistanceSqr(x1: number, y1: number, x2: number, y2: number) → number`

Returns the squared difference between two points in 2D space. This is computationally faster than [math.Distance](https://wiki.facepunch.com/gmod/math.Distance).

**Arguments:**
- `x1` (number) — X position of first point
- `y1` (number) — Y position of first point
- `x2` (number) — X position of second point
- `y2` (number) — Y position of second point

**Returns:**
- number — The squared distance between the two points.

[wiki](https://wiki.facepunch.com/gmod/math.DistanceSqr) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L10-L14)

---

### math.ease.InBack · Shared, Menu
`math.ease.InBack(fraction: number) → number`

Eases in by reversing the direction of the ease slightly before returning.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value

> **Note:** This doesn't work properly when used with [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) as it clamps the fraction between 0 and 1. Using your own version of [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) that is unclamped would be necessary instead.

[wiki](https://wiki.facepunch.com/gmod/math.ease.InBack) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L128-L130)

---

### math.ease.InBounce · Shared, Menu
`math.ease.InBounce(fraction: number) → number`

Eases in like a bouncy ball.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value

> **Note:** This doesn't work properly when used with [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) as it clamps the fraction between 0 and 1. Using your own version of [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) that is unclamped would be necessary instead.

[wiki](https://wiki.facepunch.com/gmod/math.ease.InBounce) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L168-L170)

---

### math.ease.InCirc · Shared, Menu
`math.ease.InCirc(fraction: number) → number`

Eases in using a circular function.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InCirc) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L114-L116)

---

### math.ease.InCubic · Shared, Menu
`math.ease.InCubic(fraction: number) → number`

Eases in by cubing the fraction.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InCubic) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L61-L63)

---

### math.ease.InElastic · Shared, Menu
`math.ease.InElastic(fraction: number) → number`

Eases in like a rubber band.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value

> **Note:** This doesn't work properly when used with [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) as it clamps the fraction between 0 and 1. Using your own version of [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) that is unclamped would be necessary instead.

[wiki](https://wiki.facepunch.com/gmod/math.ease.InElastic) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L142-L148)

---

### math.ease.InExpo · Shared, Menu
`math.ease.InExpo(fraction: number) → number`

Eases in using an exponential equation with a base of 2 and where the fraction is used in the exponent.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InExpo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L97-L99)

---

### math.ease.InOutBack · Shared, Menu
`math.ease.InOutBack(fraction: number) → number`

Eases in and out by reversing the direction of the ease slightly before returning on both ends.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value

> **Note:** This doesn't work properly when used with [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) as it clamps the fraction between 0 and 1. Using your own version of [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) that is unclamped would be necessary instead.

[wiki](https://wiki.facepunch.com/gmod/math.ease.InOutBack) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L136-L140)

---

### math.ease.InOutBounce · Shared, Menu
`math.ease.InOutBounce(fraction: number) → number`

Eases in and out like a bouncy ball.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value

> **Note:** This doesn't work properly when used with [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) as it clamps the fraction between 0 and 1. Using your own version of [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) that is unclamped would be necessary instead.

[wiki](https://wiki.facepunch.com/gmod/math.ease.InOutBounce) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L187-L191)

---

### math.ease.InOutCirc · Shared, Menu
`math.ease.InOutCirc(fraction: number) → number`

Eases in and out using a circular function.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InOutCirc) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L122-L126)

---

### math.ease.InOutCubic · Shared, Menu
`math.ease.InOutCubic(fraction: number) → number`

Eases in and out by cubing the fraction.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InOutCubic) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L69-L71)

---

### math.ease.InOutElastic · Shared, Menu
`math.ease.InOutElastic(fraction: number) → number`

Eases in and out like a rubber band.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value

> **Note:** This doesn't work properly when used with [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) as it clamps the fraction between 0 and 1. Using your own version of [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) that is unclamped would be necessary instead.

[wiki](https://wiki.facepunch.com/gmod/math.ease.InOutElastic) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L158-L166)

---

### math.ease.InOutExpo · Shared, Menu
`math.ease.InOutExpo(fraction: number) → number`

Eases in and out using an exponential equation with a base of 2 and where the fraction is used in the exponent.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InOutExpo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L105-L112)

---

### math.ease.InOutQuad · Shared, Menu
`math.ease.InOutQuad(fraction: number) → number`

Eases in and out by squaring the fraction.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InOutQuad) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L57-L59)

---

### math.ease.InOutQuart · Shared, Menu
`math.ease.InOutQuart(fraction: number) → number`

Eases in and out by raising the fraction to the power of 4.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InOutQuart) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L81-L83)

---

### math.ease.InOutQuint · Shared, Menu
`math.ease.InOutQuint(fraction: number) → number`

Eases in and out by raising the fraction to the power of 5.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InOutQuint) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L93-L95)

---

### math.ease.InOutSine · Shared, Menu
`math.ease.InOutSine(fraction: number) → number`

Eases in and out using [math.sin](https://wiki.facepunch.com/gmod/math.sin).

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InOutSine) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L45-L47)

---

### math.ease.InQuad · Shared, Menu
`math.ease.InQuad(fraction: number) → number`

Eases in by squaring the fraction.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InQuad) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L49-L51)

---

### math.ease.InQuart · Shared, Menu
`math.ease.InQuart(fraction: number) → number`

Eases in by raising the fraction to the power of 4.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InQuart) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L73-L75)

---

### math.ease.InQuint · Shared, Menu
`math.ease.InQuint(fraction: number) → number`

Eases in by raising the fraction to the power of 5.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InQuint) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L85-L87)

---

### math.ease.InSine · Shared, Menu
`math.ease.InSine(fraction: number) → number`

Eases in using [math.sin](https://wiki.facepunch.com/gmod/math.sin).

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.InSine) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L37-L39)

---

### math.ease.OutBack · Shared, Menu
`math.ease.OutBack(fraction: number) → number`

Eases out by reversing the direction of the ease slightly before finishing.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value

> **Note:** This doesn't work properly when used with [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) as it clamps the fraction between 0 and 1. Using your own version of [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) that is unclamped would be necessary instead.

[wiki](https://wiki.facepunch.com/gmod/math.ease.OutBack) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L132-L134)

---

### math.ease.OutBounce · Shared, Menu
`math.ease.OutBounce(fraction: number) → number`

Eases out like a bouncy ball.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value

> **Note:** This doesn't work properly when used with [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) as it clamps the fraction between 0 and 1. Using your own version of [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) that is unclamped would be necessary instead.

[wiki](https://wiki.facepunch.com/gmod/math.ease.OutBounce) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L172-L185)

---

### math.ease.OutCirc · Shared, Menu
`math.ease.OutCirc(fraction: number) → number`

Eases out using a circular function.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.OutCirc) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L118-L120)

---

### math.ease.OutCubic · Shared, Menu
`math.ease.OutCubic(fraction: number) → number`

Eases out by cubing the fraction.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.OutCubic) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L65-L67)

---

### math.ease.OutElastic · Shared, Menu
`math.ease.OutElastic(fraction: number) → number`

Eases out like a rubber band.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value

> **Note:** This doesn't work properly when used with [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) as it clamps the fraction between 0 and 1. Using your own version of [Lerp](https://wiki.facepunch.com/gmod/Global.Lerp) that is unclamped would be necessary instead.

[wiki](https://wiki.facepunch.com/gmod/math.ease.OutElastic) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L150-L156)

---

### math.ease.OutExpo · Shared, Menu
`math.ease.OutExpo(fraction: number) → number`

Eases out using an exponential equation with a base of 2 and where the fraction is used in the exponent.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.OutExpo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L101-L103)

---

### math.ease.OutQuad · Shared, Menu
`math.ease.OutQuad(fraction: number) → number`

Eases out by squaring the fraction.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.OutQuad) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L53-L55)

---

### math.ease.OutQuart · Shared, Menu
`math.ease.OutQuart(fraction: number) → number`

Eases out by raising the fraction to the power of 4.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.OutQuart) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L77-L79)

---

### math.ease.OutQuint · Shared, Menu
`math.ease.OutQuint(fraction: number) → number`

Eases out by raising the fraction to the power of 5.

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.OutQuint) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L89-L91)

---

### math.ease.OutSine · Shared, Menu
`math.ease.OutSine(fraction: number) → number`

Eases out using [math.sin](https://wiki.facepunch.com/gmod/math.sin).

**Arguments:**
- `fraction` (number) — Fraction of the progress to ease, from 0 to 1

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.ease.OutSine) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math/ease.lua#L41-L43)

---

### math.EaseInOut · Shared, Menu
`math.EaseInOut(progress: number, easeIn: number = 0, easeOut: number = 1) → number`

Calculates the progress of a value fraction, taking in to account given easing fractions

**Arguments:**
- `progress` (number) — Fraction of the progress to ease, from 0 to 1.
- `easeIn` (number, default `0`) — Fraction of how much easing to begin with, from 0 to 1.
- `easeOut` (number, default `1`) — Fraction of how much easing to end with, from 0 to 1.

**Returns:**
- number — "Eased" Value, from 0 to 1

[wiki](https://wiki.facepunch.com/gmod/math.EaseInOut) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L60-L85)

---

### math.exp · Shared, Menu
`math.exp(exponent: number) → number`

Returns e to the power of the input.

**Arguments:**
- `exponent` (number) — The exponent for the function.

**Returns:**
- number — e to the specified power

[wiki](https://wiki.facepunch.com/gmod/math.exp)

---

### math.Factorial · Shared, Menu
`math.Factorial(val_in: number) → number`

Simple function that calculates [factorial](https://en.wikipedia.org/wiki/Factorial) of a whole number.

**Arguments:**
- `val_in` (number) — An whole number to get a factorial of.

**Returns:**
- number — The factorial of given number.

[wiki](https://wiki.facepunch.com/gmod/math.Factorial) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L244-L257)

---

### math.floor · Shared, Menu
`math.floor(number: number) → number`

Floors or rounds a number down.

	See [math.ceil](https://wiki.facepunch.com/gmod/math.ceil) for the inverse of this function.

**Arguments:**
- `number` (number) — The number to be rounded down.

**Returns:**
- number — floored numbers

[wiki](https://wiki.facepunch.com/gmod/math.floor)

---

### math.fmod · Shared, Menu
`math.fmod(base: number, modulator: number) → number`

Returns the modulus of the specified values.

While this is similar to the `%` operator, **it will return a negative value if the first argument is negative**, whereas the % operator will return a **positive** value **even if the first operand is negative**.

This function is also slower than the `%` operator.

**Arguments:**
- `base` (number) — The base value.
- `modulator` (number) — The modulator.

**Returns:**
- number — The calculated modulus.

[wiki](https://wiki.facepunch.com/gmod/math.fmod)

---

### math.frexp · Shared, Menu
`math.frexp(x: number) → number, number`

**Lua reference description**: Returns `m` and `e` such that `x = m2e`, `e` is an integer and the absolute value of `m` is in the range ((0.5, 1) (or zero when x is zero).

Used to split the number value into a normalized fraction and an exponent. Two values are returned: the first is a multiplier in the range `1/2` (**inclusive**) to `1` (**exclusive**) and the second is an integer exponent.

The result is such that `x = m*2^e`.

**Arguments:**
- `x` (number) — The value to get the normalized fraction and the exponent from.

**Returns:**
- number — m, multiplier - between `0.5` and `1`.
- number — e, exponent - always an integer.

[wiki](https://wiki.facepunch.com/gmod/math.frexp)

---

### math.huge · Shared, Menu
`math.huge()`

[wiki](https://wiki.facepunch.com/gmod/math.huge)

---

### math.IntToBin · Shared, Menu
`math.IntToBin(int: number) → string`

Converts an integer to a binary (base-2) string.

**Arguments:**
- `int` (number) — Number to be converted.

**Returns:**
- string — Binary number string.

[wiki](https://wiki.facepunch.com/gmod/math.IntToBin) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L30-L33)

---

### math.IsNearlyEqual · Shared, Menu
`math.IsNearlyEqual(a: number, b: number, tolerance: number = 1e-8) → boolean`

Checks if two floating point numbers are nearly equal.

This is useful to mitigate  [accuracy issues in floating point numbers](https://en.wikipedia.org/wiki/Floating-point_arithmetic#Accuracy_problems). See examples below.

**Arguments:**
- `a` (number) — The first number to compare.
- `b` (number) — The second number to compare.
- `tolerance` (number, default `1e-8`) — The maximum difference between the two numbers to consider them equal.

**Returns:**
- boolean — True if the difference between the two numbers is less than or equal to the tolerance.

[wiki](https://wiki.facepunch.com/gmod/math.IsNearlyEqual) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L275-L281)

---

### math.ldexp · Shared, Menu
`math.ldexp(normalizedFraction: number, exponent: number) → number`

Takes a normalised number and returns the floating point representation.

Effectively it returns the result of `normalizedFraction * 2.0 ^ exponent`. [math.frexp](https://wiki.facepunch.com/gmod/math.frexp) is the opposite function.

**Arguments:**
- `normalizedFraction` (number) — The value to get the normalized fraction and the exponent from.
- `exponent` (number) — The value to get the normalized fraction and the exponent from.

**Returns:**
- number — result

[wiki](https://wiki.facepunch.com/gmod/math.ldexp)

---

### math.log · Shared, Menu
`math.log(x: number, base: number = e) → number`

With one argument, return the natural logarithm of x (to base e).

With two arguments, return the logarithm of x to the given base, calculated as log(x)/log(base).

**Arguments:**
- `x` (number) — The value to get the base from exponent from.
- `base` (number, default `e`) — The logarithmic base.

**Returns:**
- number — Logarithm of x to the given base

[wiki](https://wiki.facepunch.com/gmod/math.log)

---

### math.log10 · Shared, Menu
`math.log10(x: number) → number`

Returns the base-10 logarithm of x. This is usually more accurate than math.log(x, 10).

**Arguments:**
- `x` (number) — The value to get the base from exponent from.

**Returns:**
- number — The result.

[wiki](https://wiki.facepunch.com/gmod/math.log10)

---

### math.max · Shared, Menu
`math.max(numbers: vararg) → number`

Returns the largest value of all arguments.

**Arguments:**
- `numbers` (vararg) — Numbers to get the largest from

**Returns:**
- number — The largest number

[wiki](https://wiki.facepunch.com/gmod/math.max)

---

### math.min · Shared, Menu
`math.min(numbers: vararg) → number`

Returns the smallest value of all arguments.

**Arguments:**
- `numbers` (vararg) — Numbers to get the smallest from.

**Returns:**
- number — The smallest number

[wiki](https://wiki.facepunch.com/gmod/math.min)

---

### math.mod · Shared, Menu · `DEPRECATED`
`math.mod(base: number, modulator: number) → number`

Returns the modulus of the specified values. Same as [math.fmod](https://wiki.facepunch.com/gmod/math.fmod).

**Arguments:**
- `base` (number) — The base value
- `modulator` (number) — Modulator

**Returns:**
- number — The calculated modulus

[wiki](https://wiki.facepunch.com/gmod/math.mod)

---

### math.modf · Shared, Menu
`math.modf(base: number) → number, number`

Returns the integral and fractional component of the modulo operation.

**Arguments:**
- `base` (number) — The base value.

**Returns:**
- number — The integral component.
- number — The fractional component.

[wiki](https://wiki.facepunch.com/gmod/math.modf)

---

### math.NormalizeAngle · Shared, Menu
`math.NormalizeAngle(angle: number) → number`

Normalizes angle, so it returns value between -180 and 180.

**Arguments:**
- `angle` (number) — The angle to normalize, in degrees.

**Returns:**
- number — The normalized angle, in the range of -180 to 180 degrees.

[wiki](https://wiki.facepunch.com/gmod/math.NormalizeAngle) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L186-L188)

---

### math.pi · Shared, Menu
`math.pi()`

[wiki](https://wiki.facepunch.com/gmod/math.pi)

---

### math.pow · Shared, Menu
`math.pow(x: number, y: number) → number`

Returns x raised to the power y.
In particular, math.pow(1.0, x) and math.pow(x, 0.0) always return 1.0, even when x is a zero or a [nan](https://wiki.facepunch.com/gmod/nan). If both x and y are finite, x is negative, and y is not an integer then math.pow(x, y) is undefined.

**Arguments:**
- `x` (number) — Base.
- `y` (number) — Exponent.

**Returns:**
- number — y power of x

[wiki](https://wiki.facepunch.com/gmod/math.pow)

---

### math.QuadraticBezier · Shared, Menu
`math.QuadraticBezier(frac: number, p0: Vector, p1: Vector, p2: Vector) → Vector`

Lerp point between 3 control points with quadratic bezier.

See [math.CubicBezier](https://wiki.facepunch.com/gmod/math.CubicBezier) for a function which works with 4 control points.

**Arguments:**
- `frac` (number) — The fraction for finding the result.
- `p0` (Vector) — First control point
- `p1` (Vector) — Tangent
- `p2` (Vector) — Second control point

**Returns:**
- Vector — Point between control points at the specified fraction

[wiki](https://wiki.facepunch.com/gmod/math.QuadraticBezier) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L232-L238)

---

### math.rad · Shared, Menu
`math.rad(degrees: number) → number`

Converts an angle in degrees to it's equivalent in radians.

**Arguments:**
- `degrees` (number) — The angle measured in degrees.

**Returns:**
- number — radians

[wiki](https://wiki.facepunch.com/gmod/math.rad) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/[builtin:rad]#L-L1-L-L1)

---

### math.Rand · Shared, Menu
`math.Rand(min: number, max: number) → number`

Returns a random float between min and max.

See also [math.random](https://wiki.facepunch.com/gmod/math.random)

**Arguments:**
- `min` (number) — The minimum value.
- `max` (number) — The maximum value.

**Returns:**
- number — Random float between min and max.

[wiki](https://wiki.facepunch.com/gmod/math.Rand) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L47-L49)

---

### math.random · Shared, Menu
`math.random(m: number = nil, n: number = nil) → number`

When called without arguments, returns a uniform pseudo-random real number in the range 0 to 1 which includes 0 but excludes 1.

When called with an integer number m, returns a uniform pseudo-random integer in the range 1 to m inclusive.

When called with two integer numbers m and n, returns a uniform pseudo-random integer in the range m to n inclusive.

See also [math.Rand](https://wiki.facepunch.com/gmod/math.Rand)

**Arguments:**
- `m` (number, default `nil`) — If m is the only parameter: upper limit.
- `n` (number, default `nil`) — Upper limit.

**Returns:**
- number — Random value

[wiki](https://wiki.facepunch.com/gmod/math.random)

---

### math.randomseed · Shared, Menu
`math.randomseed(seed: number)`

Seeds the random number generator. The same seed will guarantee the same sequence of numbers each time with [math.random](https://wiki.facepunch.com/gmod/math.random).

For shared random values across predicted realms, use [util.SharedRandom](https://wiki.facepunch.com/gmod/util.SharedRandom).

**Arguments:**
- `seed` (number) — The new seed

> **Warning:** Usage of this function affects **ALL** random numbers in the game. This means that improper use (such as setting the seed to a static value that doesn't change with time) can negatively affect other addons or the base game.
> 
> It is a good idea to set the seed back to at least something like [SysTime](https://wiki.facepunch.com/gmod/Global.SysTime) in those cases.

[wiki](https://wiki.facepunch.com/gmod/math.randomseed)

---

### math.Remap · Shared, Menu
`math.Remap(value: number, inMin: number, inMax: number, outMin: number, outMax: number) → number`

Remaps the value from one range to another

**Arguments:**
- `value` (number) — The value
- `inMin` (number) — The minimum of the initial range
- `inMax` (number) — The maximum of the initial range
- `outMin` (number) — The minimum of new range
- `outMax` (number) — The maximum of new range

**Returns:**
- number — The number in the new range

[wiki](https://wiki.facepunch.com/gmod/math.Remap) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L215-L217)

---

### math.Round · Shared, Menu
`math.Round(value: number, decimals: number = 0) → number`

Rounds the given value to the nearest whole number or to the given decimal places.

**Arguments:**
- `value` (number) — The value to round.
- `decimals` (number, default `0`) — The decimal places to round to.

**Returns:**
- number — The rounded value.

[wiki](https://wiki.facepunch.com/gmod/math.Round) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L151-L156)

---

### math.Sign · Shared, Menu · `NEW`
`math.Sign(value: number) → number`

Returns the mathematical negative/positive sign of the input number.

**Arguments:**
- `value` (number) — The input number.

**Returns:**
- number — `-1` for inputs of less than 0, `0` if given a 0, `1` for inputs above 0.

[wiki](https://wiki.facepunch.com/gmod/math.Sign)

---

### math.sin · Shared, Menu
`math.sin(number: number) → number`

Returns the [sine](https://en.wikipedia.org/wiki/Trigonometric_functions) of given angle.

**Arguments:**
- `number` (number) — Angle in radians

**Returns:**
- number — Sine for given angle in the range (-1, 1)

[wiki](https://wiki.facepunch.com/gmod/math.sin)

---

### math.sinh · Shared, Menu
`math.sinh(number: number) → number`

Returns the [hyperbolic sine](https://en.wikipedia.org/wiki/Hyperbolic_functions) of the given angle.

**Arguments:**
- `number` (number) — Angle in radians.

**Returns:**
- number — The hyperbolic sine of the given angle.

[wiki](https://wiki.facepunch.com/gmod/math.sinh)

---

### math.SnapTo · Shared, Menu
`math.SnapTo(input: number, snapTo: number) → number`

Snaps a number to the closest multiplicative of given number. See also [Angle:SnapTo](https://wiki.facepunch.com/gmod/Angle:SnapTo).

**Arguments:**
- `input` (number) — The number to snap.
- `snapTo` (number) — What to snap the input number to.

**Returns:**
- number — The clamped value.

[wiki](https://wiki.facepunch.com/gmod/math.SnapTo) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L212-L214)

---

### math.sqrt · Shared, Menu
`math.sqrt(value: number) → number`

Returns the square root of the number.

**Arguments:**
- `value` (number) — Value to get the square root of.

**Returns:**
- number — squareRoot

[wiki](https://wiki.facepunch.com/gmod/math.sqrt)

---

### math.tan · Shared, Menu
`math.tan(value: number) → number`

Returns the tangent of the given angle.

**Arguments:**
- `value` (number) — Angle in radians

**Returns:**
- number — The tangent of the given angle.

[wiki](https://wiki.facepunch.com/gmod/math.tan)

---

### math.tanh · Shared, Menu
`math.tanh(number: number) → number`

Returns the [hyperbolic tangent](https://en.wikipedia.org/wiki/Hyperbolic_functions) of the given number.

**Arguments:**
- `number` (number) — Angle in radians.

**Returns:**
- number — The hyperbolic tangent of the given angle.

[wiki](https://wiki.facepunch.com/gmod/math.tanh)

---

### math.tau · Shared, Menu
`math.tau()`

[wiki](https://wiki.facepunch.com/gmod/math.tau)

---

### math.TimeFraction · Shared, Menu
`math.TimeFraction(start: number, end: number, current: number) → number`

Returns the fraction of where the current time is relative to the start and end times

**Arguments:**
- `start` (number) — Start time in seconds
- `end` (number) — End time in seconds
- `current` (number) — Current time in seconds

**Returns:**
- number — Fraction

[wiki](https://wiki.facepunch.com/gmod/math.TimeFraction) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L211-L213)

---

### math.Truncate · Shared, Menu
`math.Truncate(num: number, digits: number = 0) → number`

Trim unwanted decimal places.

**Arguments:**
- `num` (number) — The number to truncate
- `digits` (number, default `0`) — The amount of digits to keep after the point.

**Returns:**
- number — The result.

[wiki](https://wiki.facepunch.com/gmod/math.Truncate) · [source](https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/extensions/math.lua#L159-L166)

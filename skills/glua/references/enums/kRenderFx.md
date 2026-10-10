# kRenderFx enumeration

**Realm:** Shared  ·  **Constants:** 25

Used by [Entity:SetRenderFX](https://wiki.facepunch.com/gmod/Entity:SetRenderFX) and returned by [Entity:GetRenderFX](https://wiki.facepunch.com/gmod/Entity:GetRenderFX).

Most of these require alpha value of entitys color to be less than 255 to have any visible effect.

[wiki page](https://wiki.facepunch.com/gmod/Enums/kRenderFx)

| Constant | Value | Realm | Description |
|---|---|---|---|
| `kRenderFxClampMinScale` | `19` | Shared |  |
| `kRenderFxDistort` | `15` | Shared | Flickers ( randomizes ) the entitys transparency |
| `kRenderFxEnvRain` | `20` | Shared |  |
| `kRenderFxEnvSnow` | `21` | Shared |  |
| `kRenderFxExplode` | `17` | Shared |  |
| `kRenderFxFadeFast` | `6` | Shared | Quickly fades away the entity, making it completely invisible. |
| `kRenderFxFadeSlow` | `5` | Shared | Slowly fades away the entity, making it completely invisible over 3 seconds. |
| `kRenderFxFlickerFast` | `13` | Shared | Same as Strobe Fast, but the interval is more randomized. |
| `kRenderFxFlickerSlow` | `12` | Shared | Same as Strobe Slow, but the interval is more randomized. |
| `kRenderFxGlowShell` | `18` | Shared |  |
| `kRenderFxHologram` | `16` | Shared | Same as Distort, but fades the entity away the farther you are from it. |
| `kRenderFxNoDissipation` | `14` | Shared |  |
| `kRenderFxNone` | `0` | Shared | None. |
| `kRenderFxPulseFast` | `2` | Shared | Quickly pulses the entitys transparency, +-15 to the current alpha. |
| `kRenderFxPulseFastWide` | `4` | Shared | Quickly pulses the entitys transparency, +-60 to the current alpha. |
| `kRenderFxPulseFastWider` | `24` | Shared | Quickly pulses the entitys transparency, from 0 to 255. |
| `kRenderFxPulseSlow` | `1` | Shared | Slowly pulses the entitys transparency, +-15 to the current alpha. |
| `kRenderFxPulseSlowWide` | `3` | Shared | Slowly pulses the entitys transparency, +-60 to the current alpha. |
| `kRenderFxRagdoll` | `23` | Shared | Is ragdoll, can be set to force an entity to create a clientside ragdoll. |
| `kRenderFxSolidFast` | `8` | Shared | Quickly solidifies the entity, making it fully opaque. |
| `kRenderFxSolidSlow` | `7` | Shared | Slowly solidifies the entity, making it fully opaque. |
| `kRenderFxSpotlight` | `22` | Shared |  |
| `kRenderFxStrobeFast` | `10` | Shared | Quickly switches the entitys transparency between its alpha and 0. |
| `kRenderFxStrobeFaster` | `11` | Shared | Very quickly switches the entitys transparency between its alpha and 0. |
| `kRenderFxStrobeSlow` | `9` | Shared | Slowly switches the entitys transparency between its alpha and 0. |

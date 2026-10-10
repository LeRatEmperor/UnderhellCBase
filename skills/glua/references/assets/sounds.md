# Engine sound paths (sounds.json)

Sound file paths bundled with GMod and its mounted games. Play with:

```lua
entity:EmitSound("path/to/sound.wav")        -- positional, networked
sound.Play("path/to/sound.wav", pos)          -- one-shot at a position
surface.PlaySound("path/to/sound.wav")        -- 2D UI sound (client)
```

Paths are relative to each game's `sound/` folder. Mount points below; counts are recursive file totals. Browse the tree for exact paths.

## css  (1174 files)
- `ambient/` — 311 files  e.g. 3dmeagle.wav, guit1.wav, opera.wav
- `bot/` — 486 files  e.g. a.wav, a_bunch_of_them.wav, aah.wav
- `buttons/` — 6 files  e.g. bell1.wav, blip2.wav, button11.wav
- `common/` — 13 files  e.g. bass.wav, center.wav, frontleft.wav
- `doors/` — 3 files  e.g. door_metal_gate_close1.wav, door_metal_gate_move1.wav, door_metal_gate_move2.wav
- `hostage/` — 19 files
- `items/` — 9 files  e.g. ammopickup.wav, defuser_equip.wav, equip_nvg.wav
- `physics/` — 48 files
- `player/` — 90 files  e.g. bhit_helmet-1.wav, damage1.wav, damage2.wav
- `radio/` — 36 files  e.g. blow.wav, bombdef.wav, bombpl.wav
- `resource/` — 1 files  e.g. warning.wav
- `ui/` — 6 files  e.g. achievement_earned.wav, buttonclick.wav, buttonclickrelease.wav
- `weapons/` — 146 files  e.g. clipempty_pistol.wav, clipempty_rifle.wav, debris1.wav

## garrysmod  (57 files)
- `ambient/` — 3 files  e.g. construct_tone.wav, forest_day.wav, forest_night.wav
- `garrysmod/` — 9 files  e.g. balloon_pop_cute.wav, content_downloaded.wav, save_load1.wav
- `phx/` — 27 files  e.g. eggcrack.wav, epicmetal_hard.wav, epicmetal_hard1.wav
- `player/` — 2 files
- `sfx/` — 1 files  e.g. skidding.wav
- `thrusters/` — 15 files  e.g. hover00.wav, hover01.wav, hover02.wav

## hl2  (5523 files)
- `ambience/` — 2 files  e.g. mechwhine.wav, wind1.wav
- `ambient/` — 607 files  e.g. _period.wav
- `beams/` — 1 files  e.g. beamstart5.wav
- `buttons/` — 32 files  e.g. blip1.wav, button1.wav, button10.wav
- `combined/` — 63 files
- `common/` — 8 files  e.g. bugreporter_failed.wav, bugreporter_succeeded.wav, null.wav
- `doors/` — 47 files  e.g. default_locked.wav, default_move.wav, default_stop.wav
- `friends/` — 3 files  e.g. friend_join.wav, friend_online.wav, message.wav
- `hl1/` — 84 files
- `items/` — 12 files  e.g. ammo_pickup.wav, ammocrate_close.wav, ammocrate_open.wav
- `music/` — 56 files  e.g. hl1_song10.mp3, hl1_song11.mp3, hl1_song14.mp3
- `npc/` — 1283 files
- `physics/` — 408 files
- `plats/` — 35 files  e.g. bigstop1.wav, elevator_large_start1.wav, elevator_large_stop1.wav
- `player/` — 91 files  e.g. breathe1.wav, geiger1.wav, geiger2.wav
- `resource/` — 1 files  e.g. warning.wav
- `test/` — 9 files
- `tools/` — 5 files
- `ui/` — 3 files  e.g. buttonclick.wav, buttonclickrelease.wav, buttonrollover.wav
- `vehicles/` — 76 files  e.g. atv_ammo_close.wav, atv_ammo_open.wav, chopper_rotor2.wav
- `vo/` — 2553 files
- `weapons/` — 144 files  e.g. 357_fire2.wav, debris1.wav, debris2.wav


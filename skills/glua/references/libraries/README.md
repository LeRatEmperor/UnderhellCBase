# Libraries

Libraries are GLua's global function namespaces — tables of dot-called functions grouped by purpose (`net.Start`, `render.DrawLine`, `string.format`, `table.insert`, `hook.Add`, `timer.Create`, `ents.Create`). Members are called with a dot on the namespace itself (`util.JSONToTable(...)`), not with a colon — colon syntax is for methods on object instances (entities, panels, players), which live in the meta/types category, not here. A few libraries are thin wrappers over engine systems: `surface`/`draw`/`cam`/`render` push GPU draw state, `sound`/`Material` paths reference asset strings, and `hook.Add` registers callbacks that the engine invokes for you rather than functions you call directly.

Choose a unit by the job: networking (`net`, `http`, `concommand`), drawing (`surface`, `draw`, `render`, `cam`, `mesh`), data (`table`, `string`, `math`, `util`, `bit`, `file`, `sql`), world/entities (`ents`, `player`, `team`, `constraint`), and control flow (`hook`, `timer`, `coroutine`). When in doubt, scan the table below by Description, then open the per-unit file for the exact member list.

## Most-used
- [net](net.md) — modern client/server networking; pair `net.Start`/`net.Send` with `util.AddNetworkString`.
- [hook](hook.md) — register and run callbacks for engine and gamemode events (`hook.Add`/`hook.Run`).
- [timer](timer.md) — run functions after a delay or on a repeating interval.
- [ents](ents.md) — create and find entities (`ents.Create`, `ents.FindInSphere`, `ents.GetAll`).
- [table](table.md) — insert, remove, copy, and iterate Lua tables; the workhorse data library.
- [string](string.md) — format, split, match, and manipulate text.
- [math](math.md) — clamping, interpolation, randomness, and numeric helpers.
- [util](util.md) — JSON, traces, network strings, effects, and a grab-bag of helpers.
- [surface](surface.md) — low-level 2D drawing of text, rects, and textures in HUD paint hooks.
- [draw](draw.md) — convenience wrappers over `surface` for common 2D shapes and text.
- [render](render.md) — powerful low-level control over how the world and scene are rendered.
- [file](file.md) — find, read, and write files within the game's allowed paths.
- [player](player.md) — get the player objects in the game (`player.GetAll`, `player.GetByID`).
- [concommand](concommand.md) — create console commands to trigger code and network basic events.

## Realm notes
- Client-only: `surface`, `draw`, `cam`, `render`, `mesh`, `halo`, `gui`, `input`, `spawnmenu`, `vgui`, `chat`, `notification` — calling them on the server errors.
- Server-only: `ents.Create`, `constraint`, `navmesh`, `ai`, `resource`, `numpad`, `umsg` live in server realm; remember `util.AddNetworkString` must run server-side before clients can receive that net message.
- Shared: `net`, `hook`, `timer`, `table`, `string`, `math`, `util`, `file`, `ents` (find functions), `player` run on both realms — but networked actions still need matching send/receive halves across client and server.
- Menu realm: `serverlist` (and the Menu portion of `gui`/`input`/`derma`) only exist in the main-menu state, not in-game.

**Open the per-unit file for exact signatures — do not guess.**

| Unit | Realm | Members | Description |
|---|---|---|---|
| [achievements](achievements.md) | Client, Menu | 16 | This library is used internally by Garry's Mod to help keep track of achievement progress and unlock the appropriate achievements once a ce… · [wiki](https://wiki.facepunch.com/gmod/achievements) |
| [ai](ai.md) | Server | 6 | The ai library. · [wiki](https://wiki.facepunch.com/gmod/ai) |
| [ai_schedule](ai_schedule.md) | Server | 1 | Allows you to set up a schedule for NPCs to follow. · [wiki](https://wiki.facepunch.com/gmod/ai_schedule) |
| [ai_task](ai_task.md) | Server | 1 | Used to create tasks for scripted NPCs. · [wiki](https://wiki.facepunch.com/gmod/ai_task) |
| [baseclass](baseclass.md) | Shared, Menu | 2 | The baseclass library. · [wiki](https://wiki.facepunch.com/gmod/baseclass) |
| [bit](bit.md) | Shared, Menu | 12 | The bitwise library contains useful functions for bitwise operations. · [wiki](https://wiki.facepunch.com/gmod/bit) |
| [cam](cam.md) | Client | 15 | This directs all drawing to be done to a certain 2D or 3D plane or position, until the corresponding "End" function is called. · [wiki](https://wiki.facepunch.com/gmod/cam) |
| [chat](chat.md) | Client | 6 | The chat library's purpose is to interface with the default chatbox. · [wiki](https://wiki.facepunch.com/gmod/chat) |
| [cleanup](cleanup.md) | Shared | 8 | The cleanup library allows you to control what happens to custom entities when the clean-up buttons are pressed in the Utilities tab of the… · [wiki](https://wiki.facepunch.com/gmod/cleanup) |
| [concommand](concommand.md) | Shared, Menu | 5 | The concommand library is used to create console commands which can be used to network (basic) information & events between the client and… · [wiki](https://wiki.facepunch.com/gmod/concommand) |
| [constraint](constraint.md) | Server | 29 | The constraint library allows you to control the constraint system built into the physics engine (rope, weld, ballsockets, etc). · [wiki](https://wiki.facepunch.com/gmod/constraint) |
| [construct](construct.md) | Server | 2 | The construct library is used to control the physical properties of entities. · [wiki](https://wiki.facepunch.com/gmod/construct) |
| [controlpanel](controlpanel.md) | Client | 2 | The controlpanel library. · [wiki](https://wiki.facepunch.com/gmod/controlpanel) |
| [cookie](cookie.md) | Shared, Menu | 4 | Functions to persist data on a user's computer. · [wiki](https://wiki.facepunch.com/gmod/cookie) |
| [coroutine](coroutine.md) | Shared, Menu | 8 | Coroutines are similar to threads, however they do not run simultaneously. · [wiki](https://wiki.facepunch.com/gmod/coroutine) |
| [cvars](cvars.md) | Shared, Menu | 7 | The cvars library allows you to control what happens when a cvar (console variable) is changed. · [wiki](https://wiki.facepunch.com/gmod/cvars) |
| [debug](debug.md) | Shared, Menu | 17 | The debug library is intended to help you debug your scripts, however it also has several other powerful uses. · [wiki](https://wiki.facepunch.com/gmod/debug) |
| [debugoverlay](debugoverlay.md) | Shared | 12 | The debugoverlay library is mainly useful for 3D debugging, it can be used to draw shapes on the screen for debug purposes. · [wiki](https://wiki.facepunch.com/gmod/debugoverlay) |
| [derma](derma.md) | Client, Menu | 13 | The derma library allows you to add custom derma controls and create & modify derma skins. · [wiki](https://wiki.facepunch.com/gmod/derma) |
| [dragndrop](dragndrop.md) | Client, Menu | 11 | The drag'n'drop library, used internally by certain base panels to allow for drag'n'drop functionality, like spawnmenu's customizations. · [wiki](https://wiki.facepunch.com/gmod/dragndrop) |
| [draw](draw.md) | Client, Menu | 11 | The draw library's purpose is to simplify the usage of the surface library. · [wiki](https://wiki.facepunch.com/gmod/draw) |
| [drive](drive.md) | Shared | 12 | The drive library is for adding custom control modes to the new "remote control" entity piloting system in Garry's Mod 13. · [wiki](https://wiki.facepunch.com/gmod/drive) |
| [duplicator](duplicator.md) | Shared | 34 | The duplicator library allows you to specify what should be saved when someone attempts to duplicate your custom entity with the duplicator… · [wiki](https://wiki.facepunch.com/gmod/duplicator) |
| [effects](effects.md) | Shared | 7 | The effects library allows you to manually add scripted effects. · [wiki](https://wiki.facepunch.com/gmod/effects) |
| [engine](engine.md) | Shared, Menu | 22 | The engine library provides functions to access various features in the game's engine, most are related to the demo and save systems. · [wiki](https://wiki.facepunch.com/gmod/engine) |
| [ents](ents.md) | Shared | 20 | The ents library provides functions for creating and finding entities in the game. · [wiki](https://wiki.facepunch.com/gmod/ents) |
| [file](file.md) | Shared, Menu | 13 | The file library provides functions for finding, reading and writing to files. · [wiki](https://wiki.facepunch.com/gmod/file) |
| [frame_blend](frame_blend.md) | Client | 8 | The frame blending library. · [wiki](https://wiki.facepunch.com/gmod/frame_blend) |
| [game](game.md) | Shared, Menu | 40 | The game library provides functions to access various features in the game's engine, most of it's functions are related to controlling the… · [wiki](https://wiki.facepunch.com/gmod/game) |
| [gameevent](gameevent.md) | Shared | 1 | Used to interface with the built-in game events system. · [wiki](https://wiki.facepunch.com/gmod/gameevent) |
| [gamemode](gamemode.md) | Shared | 3 | The gamemode library provides functions relating to the gamemode system in Garry's Mod. · [wiki](https://wiki.facepunch.com/gmod/gamemode) |
| [gmod](gmod.md) | Shared | 1 | Similar purpose to the game and engine, allows access to various features of the game's engine. · [wiki](https://wiki.facepunch.com/gmod/gmod) |
| [gmsave](gmsave.md) | Server | 5 | The gmsave library provides functions relating to the singleplayer save system in Garry's Mod. · [wiki](https://wiki.facepunch.com/gmod/gmsave) |
| [gui](gui.md) | Client, Menu | 22 | The gui library is similar to the input but features functions that are more focused on the mouse's interaction with GUI panels. · [wiki](https://wiki.facepunch.com/gmod/gui) |
| [GWEN](GWEN.md) | Client, Menu | 4 | GWEN is a system that allows you to load a spritesheet and generate a skin out of it. · [wiki](https://wiki.facepunch.com/gmod/GWEN) |
| [halo](halo.md) | Client | 3 | The halo library is used to draw glowing outlines around entities, an example of this can be seen by picking up props with the physgun in G… · [wiki](https://wiki.facepunch.com/gmod/halo) |
| [hammer](hammer.md) | Server | 1 | The hammer library. · [wiki](https://wiki.facepunch.com/gmod/hammer) |
| [hook](hook.md) | Shared, Menu | 5 | The hook library allows you to add hooks called by the game engine, allowing multiple scripts to modify game function. · [wiki](https://wiki.facepunch.com/gmod/hook) |
| [http](http.md) | Shared, Menu | 2 | The http library allows either the server or client to communicate with external websites via HTTP, both `GET` (http.Fetch) and `POST` (htt… · [wiki](https://wiki.facepunch.com/gmod/http) |
| [input](input.md) | Client, Menu | 23 | The input library allows you to gather information about the clients input devices (mouse & keyboard), such as the cursor position and whet… · [wiki](https://wiki.facepunch.com/gmod/input) |
| [jit](jit.md) | Shared, Menu | 21 | Library to work with the LuaJIT functionality of gmod. · [wiki](https://wiki.facepunch.com/gmod/jit) |
| [killicon](killicon.md) | Client | 8 | The killicon library is used to add to and control the icons that appear in the top right of your screen when a player is killed. · [wiki](https://wiki.facepunch.com/gmod/killicon) |
| [language](language.md) | Client, Menu | 2 | The language library is used for translation. · [wiki](https://wiki.facepunch.com/gmod/language) |
| [list](list.md) | Shared, Menu | 9 | The list library allows you add and retrieve values to and from lists. · [wiki](https://wiki.facepunch.com/gmod/list) |
| [markup](markup.md) | Client, Menu | 3 | The markup library only contains a single function to create a MarkupObject. · [wiki](https://wiki.facepunch.com/gmod/markup) |
| [math](math.md) | Shared, Menu | 87 | The math library is a standard Lua library that provides functions for manipulating numbers. · [wiki](https://wiki.facepunch.com/gmod/math) |
| [matproxy](matproxy.md) | Client | 6 | A library that allows implementing custom material proxies for materials. · [wiki](https://wiki.facepunch.com/gmod/matproxy) |
| [menu](menu.md) | Client | 1 | The menu library. · [wiki](https://wiki.facepunch.com/gmod/menu) |
| [menubar](menubar.md) | Client | 3 | The menubar library. · [wiki](https://wiki.facepunch.com/gmod/menubar) |
| [mesh](mesh.md) | Client | 15 | The mesh library allows you to create meshes. · [wiki](https://wiki.facepunch.com/gmod/mesh) |
| [motionsensor](motionsensor.md) | Shared, Menu | 11 | Functions related to Kinect for Windows usage in GMod. · [wiki](https://wiki.facepunch.com/gmod/motionsensor) |
| [navmesh](navmesh.md) | Server | 27 | The navigation mesh library. · [wiki](https://wiki.facepunch.com/gmod/navmesh) |
| [net](net.md) | Shared | 52 | The net library is one of a number of ways to send data between the client and server. · [wiki](https://wiki.facepunch.com/gmod/net) |
| [notification](notification.md) | Client | 3 | Used to display notifications on the screen (mid-right). · [wiki](https://wiki.facepunch.com/gmod/notification) |
| [numpad](numpad.md) | Server | 8 | The numpad module allows you to execute functions on a key press or release. · [wiki](https://wiki.facepunch.com/gmod/numpad) |
| [os](os.md) | Shared, Menu | 4 | The os library is a standard Lua library originally intended to allow Lua access to various features of the Operating System it's running o… · [wiki](https://wiki.facepunch.com/gmod/os) |
| [package](package.md) | Shared, Menu | 2 | The package library is a standard Lua library, it's mainly for use with the module system built into Lua. · [wiki](https://wiki.facepunch.com/gmod/package) |
| [permissions](permissions.md) | Client, Menu | 7 | Used to ask player for various potentially dangerous permissions. · [wiki](https://wiki.facepunch.com/gmod/permissions) |
| [physenv](physenv.md) | Shared | 10 | The physenv library allows you to control the physics environment created by the engine, and lets you modify constants such as gravity and… · [wiki](https://wiki.facepunch.com/gmod/physenv) |
| [player](player.md) | Shared | 12 | The player library is used to get the Lua objects that represent players in-game. · [wiki](https://wiki.facepunch.com/gmod/player) |
| [player_manager](player_manager.md) | Shared | 14 | The player_manager library lets you manage players, such as setting their models or creating player classes. · [wiki](https://wiki.facepunch.com/gmod/player_manager) |
| [presets](presets.md) | Client | 7 | The presets library lets you add and modify the pre-set options for scripted tools (selected via the white bar at the top of each tools con… · [wiki](https://wiki.facepunch.com/gmod/presets) |
| [properties](properties.md) | Shared | 7 | The properties library gives you access to the menu that shows up when right clicking entities while holding C. · [wiki](https://wiki.facepunch.com/gmod/properties) |
| [render](render.md) | Client, Menu | 141 | The render library is a powerful set of functions that let you control how the world and its contents are rendered. · [wiki](https://wiki.facepunch.com/gmod/render) |
| [resource](resource.md) | Server | 3 | The resource library is used to control what files are sent to clients who join a server, this includes models, materials, sounds, text fil… · [wiki](https://wiki.facepunch.com/gmod/resource) |
| [saverestore](saverestore.md) | Shared | 13 | The saverestore library contains functions relating to the singleplayer save system built into the game. · [wiki](https://wiki.facepunch.com/gmod/saverestore) |
| [scripted_ents](scripted_ents.md) | Shared | 10 | The scripted_ents library allows you to access information about any scripted entities loaded into the game, as well as register your own e… · [wiki](https://wiki.facepunch.com/gmod/scripted_ents) |
| [search](search.md) | Client | 2 | The search library · [wiki](https://wiki.facepunch.com/gmod/search) |
| [serverlist](serverlist.md) | Menu | 8 | Menu state library to query the master server list. · [wiki](https://wiki.facepunch.com/gmod/serverlist) |
| [sound](sound.md) | Shared | 11 | Used primarily for adding new soundscript entries. · [wiki](https://wiki.facepunch.com/gmod/sound) |
| [spawnmenu](spawnmenu.md) | Client | 24 | The spawnmenu library is a set of functions that allow you to control the spawn (Q) menu. · [wiki](https://wiki.facepunch.com/gmod/spawnmenu) |
| [sql](sql.md) | Shared, Menu | 10 | The SQL library allows you to access powerful database software included with Garry's Mod. · [wiki](https://wiki.facepunch.com/gmod/sql) |
| [steamworks](steamworks.md) | Shared, Menu | 19 | Steamworks related functions. · [wiki](https://wiki.facepunch.com/gmod/steamworks) |
| [string](string.md) | Shared, Menu | 47 | The string *type* is a sequence of characters. · [wiki](https://wiki.facepunch.com/gmod/string) |
| [surface](surface.md) | Client, Menu | 32 | The surface library allows you to draw text and shapes on the screen. · [wiki](https://wiki.facepunch.com/gmod/surface) |
| [system](system.md) | Shared, Menu | 11 | The system library provides functions that allow you to gather information about the system running the game, such as operating system, upt… · [wiki](https://wiki.facepunch.com/gmod/system) |
| [table](table.md) | Shared, Menu | 46 | The table type is an object that can store multiple values. · [wiki](https://wiki.facepunch.com/gmod/table) |
| [team](team.md) | Shared | 20 | The team library gives you access to the team system built into the Source engine, and allows you to create custom teams and get informatio… · [wiki](https://wiki.facepunch.com/gmod/team) |
| [timer](timer.md) | Shared, Menu | 14 | The timer library is a very useful set of functions which allow you to run a function periodically or after a given delay. · [wiki](https://wiki.facepunch.com/gmod/timer) |
| [umsg](umsg.md) | Server | 13 | The umsg (user message) library was previously the most common way of sending information from the server to the client. · [wiki](https://wiki.facepunch.com/gmod/umsg) |
| [undo](undo.md) | Shared | 11 | The undo library allows you to add custom entities to the undo list, allowing users to "undo" their creation with their undo (default: ) ke… · [wiki](https://wiki.facepunch.com/gmod/undo) |
| [usermessage](usermessage.md) | Shared | 3 | The usermessage library is used to receive user messages from the server on the client. · [wiki](https://wiki.facepunch.com/gmod/usermessage) |
| [utf8](utf8.md) | Shared, Menu | 9 | The utf8 library provides basic support for UTF-8 encoding. · [wiki](https://wiki.facepunch.com/gmod/utf8) |
| [util](util.md) | Shared, Menu | 91 | This is the list of utility functions. · [wiki](https://wiki.facepunch.com/gmod/util) |
| [vgui](vgui.md) | Client, Menu | 15 | The vgui library allows you to script and create your own panels using Valve's Graphical User Interface (VGUI) system. · [wiki](https://wiki.facepunch.com/gmod/vgui) |
| [video](video.md) | Client, Menu | 1 | The video library. · [wiki](https://wiki.facepunch.com/gmod/video) |
| [weapons](weapons.md) | Shared | 6 | The weapons library allows you to access information about any scripted weapons loaded into the game, as well as register your own weapons. · [wiki](https://wiki.facepunch.com/gmod/weapons) |
| [widgets](widgets.md) | Shared | 2 | The widgets library. · [wiki](https://wiki.facepunch.com/gmod/widgets) |

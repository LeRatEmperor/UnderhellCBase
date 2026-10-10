# Structs (upstream gap — not yet populated)

`wiki.json` ships with **0 structs** (`STRUCTS: {}`). This is a known scraper
limitation, not an absence of structs in GMod. The wiki *does* document structs
(e.g. `TraceResult`, `CamData`, `SWEP`, `ENT`, `Bullet`, `HUDPaint` tables,
`PhysicsObject` properties, etc.) under <https://wiki.facepunch.com/gmod/Structs>.

**Why empty:** the generator's selector (`generator/scrape.py`, roughly
`:scope > ul > li > a`) does not descend into structs nested under
`details.level2`, so the STRUCTS category comes back empty.

**To backfill:** fix the scrape selector to walk the Structs tree, re-run the
scrape, then re-run `generator/build_glua_skill.py` — a `structs/` folder with one
file per struct will be generated the same way classes/libraries are.

Until then, for struct fields consult the wiki Structs index linked above.

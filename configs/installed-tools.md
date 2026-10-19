# Installed Tools & Plugins

## CLI binaries (in /home/z/my-project/.local/bin/)
- `bili` / `bili-proxy` — billion-context plugin (v0.1.201)
- `chelper` / `coding-helper` — @z_ai/coding-helper (v0.1.1)
- `claude` — @anthropic-ai/claude-code (v2.1.303)

## Global node modules (in /home/z/my-project/.local/lib/node_modules/)
- billion-context
- @z_ai/coding-helper
- @anthropic-ai/claude-code

## Claude Code plugins installed (via `claude plugin install`)
- `glm-plan-usage@zai-coding-plugins` v0.0.1
- `glm-plan-bug@zai-coding-plugins` v0.0.1

## ZCode plugin config (written to ~/.zcode/cli/config.json)
- hooks.enabled = true
- SessionStart hook: billion-context/dist/zcode/bootstrap-hook.js
- MCP server `bili`: billion-context/dist/zcode/mcp-entry.js

## Cloned source repos (in /home/z/my-project/repos/)
- garrysmod (Facepunch) — full GMod Lua source for API reference
- billion-context — built dist for zcode plugin
- zai-coding-plugins — plugin marketplace source
- source-sdk-2013 — studiomdl sources (with kalloc/ALIGN/materialsys fixes)
- bf3_sweps_fresh — user's main GitHub repo

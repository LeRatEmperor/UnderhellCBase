# Z.AI Agent Setup Guide: Persistent Garry's Mod Sandbox Environment

Use the instructions and prompt below to configure your Z.AI agent to build, maintain, and interact with a persistent Garry's Mod server environment.

---

## 1. Z.AI Agent Setup Prompt

Copy and paste the prompt below directly into your Z.AI agent chat interface:

```text
Goal: Set up a persistent, headless Garry's Mod dedicated server environment in my workspace disk that survives context resets and session wipes.

Please perform the following steps:

1. Identify Persistent Storage:
   - Locate the permanent/persistent directory in this environment (e.g., /workspace, /data, or user home directory that persists across session resets).
   - Create a dedicated root folder named gmod_sandbox/ in that persistent location.

2. Install SteamCMD & GMod Server (App ID 4020):
   - Download and set up steamcmd inside gmod_sandbox/steamcmd/.
   - Run SteamCMD with +login anonymous and download the Garry's Mod dedicated server (+app_update 4020 validate) into gmod_sandbox/server/.

3. Configure Headless & Visual Testing Environment:
   - Ensure required 32-bit/64-bit dependencies, xvfb, and screenshot utilities (like scrot or imagemagick) are installed or available in the environment.
   - Create a custom test addon folder at gmod_sandbox/server/garrysmod/addons/ai_test_addon/lua/.

4. Create a Master Control & Recovery Script (manage_gmod.sh):
   - Write a persistent bash script at gmod_sandbox/manage_gmod.sh that supports the following arguments/functions:
     * ./manage_gmod.sh start — Launches the server headlessly using xvfb-run in the background and logs console output to gmod_sandbox/logs/console.log.
     * ./manage_gmod.sh stop — Gracefully kills the running srcds_run process.
     * ./manage_gmod.sh status — Checks if the server is actively running.
     * ./manage_gmod.sh screenshot — Captures the virtual display buffer and saves latest_frame.png for vision model evaluation.
     * ./manage_gmod.sh logs — Displays the tail of console.log to check for Lua errors.

5. Create a PERSISTENCE_README.md File:
   - Write a brief summary file in the workspace explaining:
     * The exact directory paths used.
     * How to instantly re-hook or check the server status after a context reset using ./gmod_sandbox/manage_gmod.sh.

Please execute these steps now, verify that the server files download successfully to the persistent directory, and report back once the management script is ready.
```

---

## 2. Re-engaging the Agent After Context Resets

When the agent undergoes a context reset or memory wipe, send this short follow-up prompt to restore its context instantly:

```text
Please read `PERSISTENCE_README.md` and check the status of the Garry's Mod server using `./gmod_sandbox/manage_gmod.sh status`. We are resuming our GMod addon testing workflow.
```

---

## 3. Recommended Workflow & Execution Loop

Once set up, instruct the agent to follow this closed feedback loop when developing GLua addons:

1. **Write Code:** Agent generates or updates `.lua` files inside `gmod_sandbox/server/garrysmod/addons/ai_test_addon/lua/`.
2. **Reload / Test:** Agent triggers hot-reloading or soft restarts via `./manage_gmod.sh`.
3. **Parse Console Logs:** Agent executes `./manage_gmod.sh logs` to scan for syntax errors, stack traces, or missing globals.
4. **Visual Inspection:** Agent runs `./manage_gmod.sh screenshot` and uses its visual model to inspect UI placement, model rendering, or entity spawning.
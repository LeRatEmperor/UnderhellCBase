#!/usr/bin/env python3
"""cuh_relay_client.py — Client for the GMod console relay.

Sends Lua commands to a running GMod server via the file-based relay
and receives the output.

Usage:
    python3 cuh_relay_client.py

This opens an interactive prompt where you can type Lua commands.
The commands are executed inside the running GMod server and the
output is displayed.

Prerequisites:
    - GMod server running with cuh_console_relay.lua installed
    - The GMod server's data/ directory must be accessible at the
      path specified by GMOD_DATA_DIR below
"""

import os
import sys
import time
import uuid
import textwrap

# CONFIG: Set this to your GMod server's data directory.
# For a local listen server: typically garrysmod/data/
# For a dedicated server: typically <server_root>/garrysmod/data/
# You can also set the GMOD_DATA_DIR environment variable.
GMOD_DATA_DIR = os.environ.get("GMOD_DATA_DIR", "/home/z/.steam/steam/steamapps/common/GarrysMod/garrysmod/data")

# For this container, we'll use a shared directory
# The GMod relay reads/writes files in data/cuh_relay/
RELAY_DIR = os.path.join(GMOD_DATA_DIR, "cuh_relay")


def send_command(lua_code):
    """Send a Lua command to GMod and return the output."""
    cmd_id = str(uuid.uuid4())[:8]

    # Write command file: first line = ID, rest = Lua code
    cmd_path = os.path.join(RELAY_DIR, "cmd.txt")
    content = f"{cmd_id}\n{lua_code}"

    os.makedirs(RELAY_DIR, exist_ok=True)
    with open(cmd_path, "w") as f:
        f.write(content)

    # Poll for output file
    out_path = os.path.join(RELAY_DIR, f"out_{cmd_id}.txt")
    timeout = 10  # seconds
    start = time.time()

    while time.time() - start < timeout:
        if os.path.exists(out_path):
            with open(out_path, "r") as f:
                output = f.read()
            os.remove(out_path)
            return output
        time.sleep(0.2)

    return f"[TIMEOUT] No response after {timeout}s. Is the relay running?"


def main():
    print(f"[CUH Relay] GMod data dir: {GMOD_DATA_DIR}")
    print(f"[CUH Relay] Relay dir: {RELAY_DIR}")
    print(f"[CUH Relay] Type Lua commands. Ctrl+C to exit.")
    print()

    # Check if the relay directory exists
    if not os.path.exists(RELAY_DIR):
        os.makedirs(RELAY_DIR, exist_ok=True)
        print(f"[CUH Relay] Created relay directory. Make sure GMod is running with the relay script.")

    # Test connection
    print("[CUH Relay] Testing connection...")
    result = send_command('print("CUH relay connected! Server time: " .. tostring(CurTime()))')
    print(f"[CUH Relay] Response: {result}")
    print()

    if "TIMEOUT" in result:
        print("[CUH Relay] Could not connect. Make sure:")
        print("  1. GMod is running")
        print("  2. cuh_console_relay.lua is installed in lua/autorun/server/")
        print(f"  3. GMod's data directory is at: {GMOD_DATA_DIR}")
        print("  4. You can set GMOD_DATA_DIR env var to override")
        return

    # Interactive loop
    while True:
        try:
            cmd = input("lua> ").strip()
            if not cmd:
                continue
            if cmd in ("exit", "quit"):
                break

            # Multi-line support: if the line ends with a backslash, read more
            while cmd.endswith("\\"):
                cmd = cmd[:-1] + "\n" + input("... ")

            result = send_command(cmd)
            print(result)
            print()
        except (KeyboardInterrupt, EOFError):
            print("\n[CUH Relay] Bye!")
            break


if __name__ == "__main__":
    main()

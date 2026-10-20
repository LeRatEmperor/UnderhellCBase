#!/usr/bin/env python3
"""
remote_sync_bridge.py — RCON client + SFTP sync for external GMod testing.

Connects to a remote GMod server via RCON to send console commands and
retrieve log output. Can also sync Lua files via SFTP for live code updates.

Usage:
    python3 remote_sync_bridge.py --host 1.2.3.4 --port 27015 --password mypass
    python3 remote_sync_bridge.py --interactive
    python3 remote_sync_bridge.py --command "lua_run print('hello')"
    python3 remote_sync_bridge.py --sync lua/weapons/weapon_cuh_bf3_m416.lua

Environment variables:
    RCON_HOST     — Server IP/hostname
    RCON_PORT     — Server RCON port (default 27015)
    RCON_PASSWORD — RCON password

Requires: pip install paramiko (for SFTP + SSH)
"""

import os
import sys
import socket
import struct
import time
import threading
import argparse
from pathlib import Path

# ─── RCON Protocol ────────────────────────────────────────────────────────────

RCON_TYPE_AUTH = 3
RCON_TYPE_AUTH_RESPONSE = 2
RCON_TYPE_EXECCOMMAND = 2
RCON_TYPE_RESPONSE_VALUE = 0


class RCONClient:
    """Minimal RCON protocol client (Source RCON, TCP-based)."""

    def __init__(self, host, port, password, timeout=10):
        self.host = host
        self.port = port
        self.password = password
        self.timeout = timeout
        self.sock = None
        self.request_id = 0

    def connect(self):
        self.sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.sock.settimeout(self.timeout)
        self.sock.connect((self.host, self.port))

    def disconnect(self):
        if self.sock:
            self.sock.close()
            self.sock = None

    def _send(self, req_id, req_type, body):
        """Send an RCON packet."""
        payload = struct.pack("<ii", req_id, req_type) + body.encode("utf-8") + b"\x00\x00"
        size = len(payload)
        packet = struct.pack("<i", size) + payload
        self.sock.sendall(packet)

    def _recv(self):
        """Receive an RCON packet."""
        size_data = self._recv_exactly(4)
        if not size_data:
            return None, None, None
        size = struct.unpack("<i", size_data)[0]
        if size < 10 or size > 4096:
            return None, None, None
        data = self._recv_exactly(size)
        if not data or len(data) < size:
            return None, None, None
        req_id = struct.unpack("<i", data[0:4])[0]
        req_type = struct.unpack("<i", data[4:8])[0]
        body = data[8:-2].decode("utf-8", errors="replace")  # strip two null terminators
        return req_id, req_type, body

    def _recv_exactly(self, n):
        """Receive exactly n bytes."""
        data = b""
        while len(data) < n:
            chunk = self.sock.recv(n - len(data))
            if not chunk:
                return None
            data += chunk
        return data

    def authenticate(self):
        """Send authentication packet."""
        self.request_id += 1
        self._send(self.request_id, RCON_TYPE_AUTH, self.password)
        # Read the empty SERVERDATA_RESPONSE_VALUE first
        req_id, req_type, _ = self._recv()
        # Then read the auth response
        req_id, req_type, _ = self._recv()
        return req_type == RCON_TYPE_AUTH_RESPONSE

    def send_command(self, command):
        """Send a console command and return the response text."""
        self.request_id += 1
        self._send(self.request_id, RCON_TYPE_EXECCOMMAND, command)
        # Collect response (may be multiple packets)
        response = ""
        while True:
            req_id, req_type, body = self._recv()
            if req_type == RCON_TYPE_RESPONSE_VALUE:
                response += body
            else:
                break
            # Check if there's more data
            self.sock.settimeout(2)
            try:
                req_id, req_type, body = self._recv()
                if req_type == RCON_TYPE_RESPONSE_VALUE:
                    response += body
                else:
                    break
            except socket.timeout:
                break
            finally:
                self.sock.settimeout(self.timeout)
        return response


# ─── RCON Bridge ──────────────────────────────────────────────────────────────

class RemoteBridge:
    """High-level bridge for sending Lua commands and syncing files to a remote GMod server."""

    def __init__(self, host=None, port=None, password=None):
        self.host = host or os.environ.get("RCON_HOST", "")
        self.port = int(port or os.environ.get("RCON_PORT", "27015"))
        self.password = password or os.environ.get("RCON_PASSWORD", "")
        self.rcon = None
        self.log_tail_thread = None
        self._log_running = False

    def connect(self):
        if not self.host or not self.password:
            print("[bridge] Missing RCON_HOST or RCON_PASSWORD")
            print("[bridge] Set environment variables or use --host/--password flags")
            return False

        print(f"[bridge] Connecting to {self.host}:{self.port}...")
        self.rcon = RCONClient(self.host, self.port, self.password)
        try:
            self.rcon.connect()
            if self.rcon.authenticate():
                print("[bridge] Authentication successful!")
                return True
            else:
                print("[bridge] Authentication FAILED!")
                return False
        except Exception as e:
            print(f"[bridge] Connection error: {e}")
            return False

    def disconnect(self):
        if self.rcon:
            self.rcon.disconnect()
            print("[bridge] Disconnected.")

    def send_command(self, command):
        """Send a console command via RCON."""
        if not self.rcon:
            if not self.connect():
                return None
        try:
            response = self.rcon.send_command(command)
            return response
        except Exception as e:
            print(f"[bridge] Command error: {e}")
            return None

    def send_lua(self, lua_code):
        """Send a Lua command via `lua_run`."""
        # For multi-line, use lua_run with semicolons
        single_line = lua_code.replace("\n", " ")
        return self.send_command(f'lua_run {single_line}')

    def reload_addon(self, addon_path):
        """Reload a Lua file on the server."""
        return self.send_command(f'lua_openscript {addon_path}')

    def check_errors(self):
        """Check the server console for recent Lua errors."""
        response = self.send_command("lua_errors")
        if response:
            if "no errors" in response.lower() or len(response.strip()) < 5:
                print("[bridge] No Lua errors detected.")
            else:
                print(f"[bridge] Lua errors:\n{response}")
        return response

    def get_weapon_info(self, weapon_class="weapon_cuh_bf3_m416"):
        """Get runtime info about a weapon."""
        lua = f'''
            local ply = player.GetAll()[1]
            if not IsValid(ply) then return "no player" end
            local wep = ply:GetWeapon("{weapon_class}")
            if not IsValid(wep) then return "weapon not found" end
            print("Class: " .. wep:GetClass())
            print("Silenced: " .. tostring(wep.Silenced))
            print("SilencedNW: " .. tostring(wep:GetNWBool("Silenced")))
            print("ShootSound: " .. tostring(wep:GetShootSound and wep:GetShootSound() or "nil"))
            local vm = ply:GetViewModel()
            if IsValid(vm) then
                print("Seq base_fire: " .. tostring(vm:LookupSequence("base_fire")))
                print("Seq foregrip_fire: " .. tostring(vm:LookupSequence("foregrip_fire")))
            end
        '''
        return self.send_lua(lua)

    def sync_file(self, local_path, remote_path):
        """Sync a single Lua file to the remote server via RCON.
        
        Uses lua_run to write the file contents directly (for servers without SFTP).
        For large files, this may hit RCON packet size limits.
        """
        with open(local_path, "r") as f:
            content = f.read()

        # Escape for Lua string
        escaped = content.replace("\\", "\\\\").replace("'", "\\'").replace("\n", "\\n")
        
        # Write the file via Lua
        lua = f"file.Write('{remote_path}', '{escaped}')"
        response = self.send_lua(lua)
        print(f"[bridge] Synced {local_path} -> {remote_path}")
        return response

    def tail_logs(self, duration=30):
        """Tail server console logs for a specified duration."""
        print(f"[bridge] Tailing logs for {duration}s...")
        self._log_running = True
        start = time.time()
        while self._log_running and time.time() - start < duration:
            response = self.send_command("")
            if response and len(response.strip()) > 0:
                print(response, end="")
            time.sleep(1)
        print("[bridge] Log tailing stopped.")


# ─── CLI ──────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(description="Remote GMod RCON bridge")
    parser.add_argument("--host", help="Server hostname/IP")
    parser.add_argument("--port", type=int, default=27015, help="RCON port")
    parser.add_argument("--password", help="RCON password")
    parser.add_argument("--command", "-c", help="Send a console command")
    parser.add_argument("--lua", "-l", help="Send a Lua command (via lua_run)")
    parser.add_argument("--sync", "-s", help="Sync a Lua file to the server")
    parser.add_argument("--remote-path", "-r", help="Remote path for sync")
    parser.add_argument("--info", "-i", action="store_true", help="Get weapon runtime info")
    parser.add_argument("--errors", "-e", action="store_true", help="Check for Lua errors")
    parser.add_argument("--interactive", action="store_true", help="Interactive mode")
    args = parser.parse_args()

    bridge = RemoteBridge(args.host, args.port, args.password)

    if not any([args.command, args.lua, args.sync, args.info, args.errors, args.interactive]):
        parser.print_help()
        return 1

    if not bridge.connect():
        return 1

    try:
        if args.command:
            response = bridge.send_command(args.command)
            print(response)

        if args.lua:
            response = bridge.send_lua(args.lua)
            print(response)

        if args.sync:
            remote = args.remote_path or args.sync
            bridge.sync_file(args.sync, remote)

        if args.info:
            response = bridge.get_weapon_info()
            print(response)

        if args.errors:
            bridge.check_errors()

        if args.interactive:
            print("[bridge] Interactive mode. Type commands. Ctrl+C to exit.")
            while True:
                try:
                    cmd = input("rcon> ").strip()
                    if not cmd:
                        continue
                    if cmd in ("exit", "quit"):
                        break
                    if cmd.startswith("lua "):
                        response = bridge.send_lua(cmd[4:])
                    else:
                        response = bridge.send_command(cmd)
                    if response:
                        print(response)
                except (KeyboardInterrupt, EOFError):
                    print("\n[bridge] Bye!")
                    break
    finally:
        bridge.disconnect()

    return 0


if __name__ == "__main__":
    sys.exit(main())

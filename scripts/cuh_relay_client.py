#!/usr/bin/env python3
"""cuh_relay_client.py — Send Lua commands to GMod via GitHub relay.

Writes commands to the cuh-relay branch on UnderhellCBase, then polls
for output files that the Windows sync script pushes back.

Usage:
    python3 cuh_relay_client.py "lua command here"
    python3 cuh_relay_client.py --interactive
"""

import os, sys, time, uuid, subprocess, tempfile, json

REPO_DIR = "/home/z/my-project/repos/cuh-relay-bridge"
REPO_URL = "git@github.com:LeRatEmperor/UnderhellCBase.git"
BRANCH = "cuh-relay"
GIT_SSH = "/home/z/.venv/bin/python3 /home/z/my-project/scripts/git-ssh-wrapper.py"


def ensure_repo():
    """Clone or update the relay repo."""
    if not os.path.exists(REPO_DIR):
        os.makedirs(REPO_DIR)
        env = os.environ.copy()
        env["GIT_SSH_COMMAND"] = GIT_SSH
        subprocess.run(["git", "init"], cwd=REPO_DIR, capture_output=True)
        subprocess.run(["git", "remote", "add", "origin", REPO_URL], cwd=REPO_DIR, capture_output=True)
        # Create orphan branch
        subprocess.run(["git", "checkout", "--orphan", BRANCH], cwd=REPO_DIR, capture_output=True)
        subprocess.run(["git", "commit", "--allow-empty", "-m", "Init relay branch"],
                       cwd=REPO_DIR, capture_output=True)
        env["GIT_SSH_COMMAND"] = GIT_SSH
        subprocess.run(["git", "push", "--force", "origin", BRANCH], cwd=REPO_DIR,
                       env=env, capture_output=True)
    else:
        # Pull latest (in case there are output files from the Windows side)
        env = os.environ.copy()
        env["GIT_SSH_COMMAND"] = GIT_SSH
        subprocess.run(["git", "fetch", "origin"], cwd=REPO_DIR, env=env, capture_output=True)
        subprocess.run(["git", "reset", "--hard", f"origin/{BRANCH}"], cwd=REPO_DIR, capture_output=True)


def send_command(lua_code):
    """Send a Lua command and wait for output."""
    cmd_id = str(uuid.uuid4())[:8]

    # Write command file
    cmd_path = os.path.join(REPO_DIR, "cmd.txt")
    content = f"{cmd_id}\n{lua_code}"

    with open(cmd_path, "w") as f:
        f.write(content)

    # Commit and push
    env = os.environ.copy()
    env["GIT_SSH_COMMAND"] = GIT_SSH
    subprocess.run(["git", "add", "cmd.txt"], cwd=REPO_DIR, capture_output=True)
    subprocess.run(["git", "commit", "-m", f"Relay cmd {cmd_id}"], cwd=REPO_DIR, capture_output=True)
    subprocess.run(["git", "push", "origin", BRANCH], cwd=REPO_DIR, env=env, capture_output=True)

    print(f"[relay] Command {cmd_id} pushed. Waiting for GMod to execute...")

    # Poll for output file
    out_file = f"out_{cmd_id}.txt"
    timeout = 60  # seconds — user needs to have GMod running + sync script
    start = time.time()

    while time.time() - start < timeout:
        time.sleep(3)
        # Pull to check for output
        subprocess.run(["git", "fetch", "origin"], cwd=REPO_DIR, env=env, capture_output=True)
        subprocess.run(["git", "reset", "--hard", f"origin/{BRANCH}"], cwd=REPO_DIR, capture_output=True)

        out_path = os.path.join(REPO_DIR, out_file)
        if os.path.exists(out_path):
            with open(out_path, "r") as f:
                output = f.read()
            # Clean up
            subprocess.run(["git", "rm", out_file], cwd=REPO_DIR, capture_output=True)
            subprocess.run(["git", "commit", "-m", f"Relay output consumed {cmd_id}"],
                          cwd=REPO_DIR, capture_output=True)
            subprocess.run(["git", "push", "origin", BRANCH], cwd=REPO_DIR, env=env, capture_output=True)
            return output

        elapsed = int(time.time() - start)
        if elapsed % 10 == 0:
            print(f"[relay] Still waiting... ({elapsed}s elapsed)")

    return f"[TIMEOUT] No response after {timeout}s. Is GMod running + sync script active?"


def main():
    if len(sys.argv) < 2:
        print("Usage:")
        print(f"  {sys.argv[0]} 'lua command here'")
        print(f"  {sys.argv[0]} --interactive")
        sys.exit(1)

    ensure_repo()

    if sys.argv[1] == "--interactive":
        print("[relay] Interactive mode. Type Lua commands. Ctrl+C to exit.")
        while True:
            try:
                cmd = input("lua> ").strip()
                if not cmd: continue
                if cmd in ("exit", "quit"): break
                result = send_command(cmd)
                print(result)
                print()
            except (KeyboardInterrupt, EOFError):
                print("\n[relay] Bye!")
                break
    else:
        cmd = " ".join(sys.argv[1:])
        result = send_command(cmd)
        print(result)


if __name__ == "__main__":
    main()

#!/home/z/.venv/bin/python3
"""SSH wrapper for git using paramiko.

Git calls this as: <wrapper> [-o <opt>]... <user>@<host> <command>
where <command> is a single shell-quoted string like:
  git-upload-pack 'LeRatEmperor/UnderhellCBase.git'
"""
import sys
import os
import paramiko
import select
import threading

def main():
    args = sys.argv[1:]
    if not args:
        sys.stderr.write("git-ssh-wrapper: no args\n")
        sys.exit(1)
    
    # Strip -o Option=Value pairs (we don't process them)
    rest = []
    i = 0
    while i < len(args):
        if args[i] == '-o' and i + 1 < len(args):
            i += 2
        elif args[i].startswith('-o'):
            i += 1
        elif args[i] == '-G':
            # -G means "configuration check" — we don't actually connect
            # but git calls this first to verify config. Just exit 0.
            sys.exit(0)
        elif args[i] == '-p' and i + 1 < len(args):
            # -p <port>
            i += 2
        else:
            rest.append(args[i])
            i += 1
    
    if not rest:
        sys.stderr.write("git-ssh-wrapper: no host\n")
        sys.exit(1)
    
    # rest[0] is user@host, rest[1] is the command (or rest is just user@host)
    user_host = rest[0]
    command = rest[1] if len(rest) > 1 else ""
    
    if not command:
        sys.stderr.write("git-ssh-wrapper: no command\n")
        sys.exit(1)
    
    # Parse user@host
    if '@' in user_host:
        username, host = user_host.split('@', 1)
    else:
        username, host = None, user_host
    
    # Strip any port from host
    if ':' in host:
        host, port_str = host.split(':', 1)
        port = int(port_str)
    else:
        port = 22
    
    # Load the deploy key
    key_path = '/home/z/.ssh/id_ed25519_underhellcbase'
    if not os.path.exists(key_path):
        sys.stderr.write(f"git-ssh-wrapper: key not found at {key_path}\n")
        sys.exit(1)
    
    try:
        pkey = paramiko.Ed25519Key.from_private_key_file(key_path)
    except Exception as e:
        sys.stderr.write(f"git-ssh-wrapper: failed to load key: {e}\n")
        sys.exit(1)
    
    # Connect
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        client.connect(host, port=port, username=username or 'git', pkey=pkey,
                       look_for_keys=False, allow_agent=False, timeout=30)
    except Exception as e:
        sys.stderr.write(f"git-ssh-wrapper: connection failed: {e}\n")
        sys.exit(1)
    
    # Run the command (command is already shell-quoted by git)
    try:
        chan = client.get_transport().open_session()
        # Set environment variables git requested (GIT_PROTOCOL=version=2 etc)
        # GitHub's SSH server doesn't accept arbitrary env, so skip for now
        chan.exec_command(command)
        
        # Forward stdin -> channel (background thread)
        def forward_stdin():
            try:
                while True:
                    data = sys.stdin.buffer.read(4096)
                    if not data:
                        chan.shutdown_write()
                        break
                    chan.sendall(data)
            except Exception:
                pass
        
        stdin_thread = threading.Thread(target=forward_stdin, daemon=True)
        stdin_thread.start()
        
        # Read from channel and forward to stdout/stderr
        while True:
            r, _, _ = select.select([chan], [], [], 1.0)
            if chan.recv_ready():
                data = chan.recv(65536)
                if not data:
                    break
                sys.stdout.buffer.write(data)
                sys.stdout.buffer.flush()
            if chan.recv_stderr_ready():
                data = chan.recv_stderr(65536)
                sys.stderr.buffer.write(data)
                sys.stderr.buffer.flush()
            if chan.exit_status_ready() and not chan.recv_ready() and not chan.recv_stderr_ready():
                break
        
        exit_code = chan.recv_exit_status()
        sys.exit(exit_code)
    finally:
        client.close()

if __name__ == '__main__':
    main()

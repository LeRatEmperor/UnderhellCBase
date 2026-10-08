#!/usr/bin/env python3
"""Basic Lua syntax sanity check: balance of (), [], {}, function/end, if/end, etc."""
import os
import re
import sys

OUT_DIR = "/home/z/my-project/wwiiunderhell_kate/lua/weapons"
FILES = [
    "kate_baseball_bat.lua",
    "kate_claymore.lua",
    "kate_combatknife.lua",
    "kate_dagger.lua",
    "kate_fireaxe.lua",
    "kate_icepick.lua",
    "kate_shovel.lua",
    "kate_sledgehammer.lua",
    "kate_trenchknife.lua",
    "kate_flamethrower.lua",
    "kate_flammenwerfer35.lua",
]


def strip_strings_and_comments(text):
    """Replace string literals and comments with placeholders so the brace
    balance check doesn't get fooled by '{' inside a string."""
    out = []
    i = 0
    n = len(text)
    while i < n:
        c = text[i]
        # Long comment --[[ ... ]]
        if c == '-' and i + 1 < n and text[i+1] == '-' and i + 3 < n and text[i+2] == '[' and text[i+3] == '[':
            end = text.find(']]', i + 4)
            if end == -1:
                end = n
            else:
                end += 2
            out.append('  ')
            i = end
            continue
        # Line comment --
        if c == '-' and i + 1 < n and text[i+1] == '-':
            end = text.find('\n', i + 2)
            if end == -1:
                end = n
            out.append(' ' * (end - i))
            i = end
            continue
        # Double-quote string
        if c == '"':
            j = i + 1
            while j < n:
                if text[j] == '\\':
                    j += 2
                    continue
                if text[j] == '"':
                    j += 1
                    break
                j += 1
            out.append(' ' * (j - i))
            i = j
            continue
        # Single-quote string
        if c == "'":
            j = i + 1
            while j < n:
                if text[j] == '\\':
                    j += 2
                    continue
                if text[j] == "'":
                    j += 1
                    break
                j += 1
            out.append(' ' * (j - i))
            i = j
            continue
        # Long string [[ ... ]]
        if c == '[' and i + 1 < n and text[i+1] == '[':
            end = text.find(']]', i + 2)
            if end == -1:
                end = n
            else:
                end += 2
            out.append(' ' * (end - i))
            i = end
            continue
        out.append(c)
        i += 1
    return ''.join(out)


def check_balance(stripped):
    """Check basic balance of parens, brackets, braces."""
    stack = []
    pairs = {')': '(', ']': '[', '}': '{'}
    opens = {'(', '[', '{'}
    for c in stripped:
        if c in opens:
            stack.append(c)
        elif c in pairs:
            if not stack or stack[-1] != pairs[c]:
                return f"mismatched {c} (top={stack[-1] if stack else 'none'})"
            stack.pop()
    if stack:
        return f"unclosed {stack[-1]!r}"
    return None


def check_blocks(stripped):
    """Rough check that function/if/for/while/do/else blocks have matching end."""
    # Tokenize on word boundaries
    tokens = re.findall(r"[A-Za-z_][A-Za-z0-9_]*|\s+|.", stripped)
    keywords = {'function', 'if', 'for', 'while', 'do', 'repeat'}
    ends_needed = 0
    skip_until = None
    for tok in tokens:
        if tok.isspace() or len(tok) == 0:
            continue
        if skip_until:
            if tok == skip_until:
                skip_until = None
            continue
        if tok in keywords:
            if tok in ('function', 'if', 'for', 'while', 'repeat'):
                ends_needed += 1
            # 'do' is its own block end, also 'else' starts a sub-block but no new 'end' is needed.
            # For simplicity we just count function/if/for/while/repeat + end.
        elif tok == 'end':
            if ends_needed == 0:
                return "extra 'end'"
            ends_needed -= 1
    if ends_needed > 0:
        return f"missing {ends_needed} 'end'"
    return None


def main():
    exit_code = 0
    for fname in FILES:
        fpath = os.path.join(OUT_DIR, fname)
        with open(fpath) as f:
            text = f.read()
        stripped = strip_strings_and_comments(text)
        err1 = check_balance(stripped)
        err2 = check_blocks(stripped)
        if err1 or err2:
            print(f"FAIL  {fname}")
            if err1:
                print(f"      balance: {err1}")
            if err2:
                print(f"      blocks : {err2}")
            exit_code = 1
        else:
            print(f"OK    {fname}")
    sys.exit(exit_code)


if __name__ == "__main__":
    main()

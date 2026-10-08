#!/usr/bin/env python3
"""
Better duplicate function remover:
- Uses regex to find ALL "function SWEP:X(" definitions
- For each duplicate, removes the LATER occurrence (and its body)
- Uses a smarter depth tracker that handles single-line if/then/end
"""
import os
import re

WWII_DIR = "/home/z/my-project/worldwarii_underhell"
WEAPONS_DIR = os.path.join(WWII_DIR, "lua", "weapons")


def count_block_keywords(line):
    """Count block-opening and block-closing keywords on a single line.
    Returns (opens, closes).
    Single-line `if X then return end` should net to 0.
    """
    # Strip comments and strings first
    code = re.sub(r'--.*$', '', line)  # line comments
    code = re.sub(r'"[^"]*"', '""', code)  # double-quoted strings
    code = re.sub(r"'[^']*'", "''", code)  # single-quoted strings

    opens = 0
    closes = 0

    # Find all 'function' keywords
    opens += len(re.findall(r'\bfunction\b', code))
    # Find all 'end' keywords
    closes += len(re.findall(r'\bend\b', code))

    # 'if X then' on a single line opens a block IF there's no matching 'end' on same line
    # 'for X do' / 'while X do' / 'do' opens a block
    # 'repeat ... until' is a different construct (closes with 'until')
    # 'function ... end' (anonymous) is also a block

    # Actually, since we count both 'function' (open) and 'end' (close), and
    # 'if X then ... end' would also need to be counted:
    # - 'if X then' → +1 open
    # - 'for X do' → +1 open
    # - 'while X do' → +1 open
    # - 'do' (standalone) → +1 open
    # - 'else' / 'elseif' → 0 (no change)
    # - 'end' → -1 close (already counted above)

    # So we need to count 'then', 'do' (when they open a block), and 'function' as opens.
    # But 'then' might be part of a single-line `if X then Y end` (which is balanced).

    # Count 'then' occurrences that OPEN a block:
    # - 'if X then' → +1 (opens if-block)
    # - 'elseif X then' → 0 (continuation branch, NOT a new block)
    # We need to exclude 'elseif ... then' from the count.
    # Strip out 'elseif ... then' patterns first, then count remaining 'then'
    code_without_elseif = re.sub(r'\belseif\b.*?\bthen\b', '', code)
    then_count = len(re.findall(r'\bthen\b', code_without_elseif))
    opens += then_count

    # Count 'do' that OPEN a block:
    # - 'for X do' → +1
    # - 'while X do' → +1
    # - standalone 'do' → +1
    # All 'do' keywords open a block (no equivalent of 'elseif' for do)
    do_count = len(re.findall(r'\bdo\b', code))
    opens += do_count

    return opens, closes


def find_function_blocks(lines):
    """Find all function blocks: returns list of (start_idx, end_idx, func_name)."""
    blocks = []
    i = 0
    while i < len(lines):
        line = lines[i]
        m = re.match(r'^function SWEP:(\w+)\(', line)
        if not m:
            i += 1
            continue
        func_name = m.group(1)
        # Track depth using block keywords
        # The function definition itself opens a block (depth=1)
        depth = 1
        j = i + 1
        while j < len(lines) and depth > 0:
            l = lines[j]
            opens, closes = count_block_keywords(l)
            depth += opens - closes
            j += 1
        blocks.append((i, j, func_name))
        i = j
    return blocks


def remove_duplicate_functions(filepath):
    """Keep the FIRST definition of each SWEP function, remove later duplicates."""
    with open(filepath) as f:
        lines = f.readlines()

    blocks = find_function_blocks(lines)

    seen = {}
    blocks_to_remove = []
    for idx, (start, end, name) in enumerate(blocks):
        if name in seen:
            # This is a duplicate — remove it (keep the first one)
            blocks_to_remove.append((start, end, name))
        else:
            seen[name] = (start, end)

    if not blocks_to_remove:
        return False

    # Sort descending so removals don't affect earlier indices
    blocks_to_remove.sort(reverse=True)
    for start, end, name in blocks_to_remove:
        # Look back to remove preceding blank lines and comment headers
        actual_start = start
        # Remove the preceding "-- ===" header if present
        while actual_start > 0:
            prev_line = lines[actual_start - 1].strip()
            if prev_line == '' or prev_line.startswith('--'):
                actual_start -= 1
            else:
                break
        del lines[actual_start:end]

    with open(filepath, 'w') as f:
        f.writelines(lines)
    return True


def main():
    print("=== Better Duplicate Function Remover ===")
    fixed_count = 0
    for filename in sorted(os.listdir(WEAPONS_DIR)):
        if not filename.startswith('uh_codww2_') or not filename.endswith('.lua'):
            continue
        filepath = os.path.join(WEAPONS_DIR, filename)
        if not os.path.isfile(filepath):
            continue
        # Check for duplicates first
        with open(filepath) as f:
            content = f.read()
        func_names = re.findall(r'^function SWEP:(\w+)\(', content, re.MULTILINE)
        from collections import Counter
        counts = Counter(func_names)
        dups = {n: c for n, c in counts.items() if c > 1}
        if dups:
            print(f"  {filename}: duplicates = {dups}")
            if remove_duplicate_functions(filepath):
                fixed_count += 1
    print(f"\nFixed {fixed_count} files.")


if __name__ == '__main__':
    main()

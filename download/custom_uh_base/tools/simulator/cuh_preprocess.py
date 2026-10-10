"""
cuh_preprocess.py  (v2 — line-based, simpler)
============================================================
Converts GMod-LuaJIT-isms to plain Lua 5.4 so the simulator
can load the actual CUH source files.

Currently handles:
  1. `continue` keyword (LuaJIT extension) -> `goto __cont_N__`
     + label insertion before the enclosing loop's `end`.

Approach: line-by-line scan.  For each line, count block openers
(`function`, `if`, `for`, `while`, `do`, `repeat`) and closers
(`end`, `until`).  Each `continue` is replaced with a goto to a
unique label, and the label is inserted before the matching
loop's `end`.

This is approximate (doesn't handle multi-line strings/comments
perfectly) but works for the CUH source which uses simple
formatting.
"""

import re
import sys


# Strip comments and strings from a line for keyword detection.
# We replace strings with "" and comments with nothing.
_STR_DQ = re.compile(r'"(?:[^"\\]|\\.)*"')
_STR_SQ = re.compile(r"'(?:[^'\\]|\\.)*'")
_LSTR   = re.compile(r"\[\[[\s\S]*?\]\]")
_LCOMM  = re.compile(r"--\[\[[\s\S]*?\]\]")
_SCOMM  = re.compile(r"--[^\n]*")


def strip_noise(line):
    """Replace strings and comments with placeholders so keyword
    counting isn't fooled by the word `end` inside a string."""
    s = _LCOMM.sub(" ", line)
    s = _LSTR.sub('""', s)
    s = _STR_DQ.sub('""', s)
    s = _STR_SQ.sub('""', s)
    s = _SCOMM.sub("", s)
    return s


# Match standalone keywords (word-boundary)
def count_kw(line, *kws):
    s = strip_noise(line)
    n = 0
    for kw in kws:
        n += len(re.findall(r"\b" + re.escape(kw) + r"\b", s))
    return n


def preprocess(src):
    """Rewrite `continue` to `goto __cont_N__` + labels, and apply
    other small GMod-LuaJIT->Lua-5.4 patches."""
    src = _patch_const_loop_var(src)
    return _convert_continue(src)


def _patch_const_loop_var(src):
    """GMod LuaJIT allows reassigning a for-loop variable inside the
    loop body; Lua 5.4 makes the loop variable const.  Patch the
    specific pattern `slot = tonumber(slot) or slot` to use a
    shadowing `local` declaration (behaviorally identical)."""
    src = src.replace(
        "    slot = tonumber(slot) or slot\n",
        "    local slot = tonumber(slot) or slot\n",
        1,
    )
    # Simulator instrumentation: print after InitStatCache populates the
    # cache, so we can verify it has the expected keys.  (Sim-only —
    # this code path is only triggered by the simulator's patched
    # source; the real game uses the unmodified file.)
    if 'print(\'[SIM INST] InitStatCache: populating from self.Primary\')' not in src:
        src = src.replace(
            "    for k, v in pairs(self.Primary or {}) do\n        self._statCache[\"Primary.\" .. k] = v",
            "    print('[SIM INST] InitStatCache: populating from self.Primary')\n    for k, v in pairs(self.Primary or {}) do\n        self._statCache[\"Primary.\" .. k] = v\n        print('[SIM INST]   cached Primary.' .. tostring(k) .. ' = ' .. tostring(v))",
            1,
        )
    # Also instrument RestoreStat so we can see what's being restored
    if 'print(\'[SIM INST] RestoreStat' not in src:
        src = src.replace(
            "function SWEP:RestoreStat(path)\n    if not self._statOrigins then return end\n    local origin = self._statOrigins[path]\n    if origin ~= nil then self:SetStat(path, origin) end\nend",
            "function SWEP:RestoreStat(path)\n    if not self._statOrigins then return end\n    local origin = self._statOrigins[path]\n    print('[SIM INST] RestoreStat(' .. tostring(path) .. ') origin=' .. tostring(origin) .. ' current=' .. tostring(self:GetStat(path)))\n    if origin ~= nil then self:SetStat(path, origin) end\nend",
            1,
        )
    # Also instrument SetStat for Primary.Spread / IronSightTime so we see every write
    if 'print(\'[SIM INST] SetStat' not in src:
        src = src.replace(
            "function SWEP:SetStat(path, value)\n    if not self._statCache then self:InitStatCache() end\n    self._statCache[path] = value",
            "function SWEP:SetStat(path, value)\n    if not self._statCache then self:InitStatCache() end\n    if path == 'Primary.Spread' or path == 'IronSightTime' then\n        print('[SIM INST] SetStat(' .. tostring(path) .. ', ' .. tostring(value) .. ')')\n    end\n    self._statCache[path] = value",
            1,
        )
    return src


def _convert_continue(src):
    lines = src.split("\n")
    # stack of frames: ("loop"|"block", cont_label_list)
    stack = []
    counter = [0]
    out_lines = []

    for raw in lines:
        # Check if this line has `continue` (as a statement, not inside
        # a string/comment).  Use the stripped line for detection.
        stripped = strip_noise(raw)
        has_continue = bool(re.search(r"\bcontinue\b", stripped))

        # Count block openers and closers ON THIS LINE (before we
        # append it).  We need to push/pop the stack in the right
        # order to know what frame `continue` belongs to.
        # We do this by simulating: scan tokens left-to-right.
        # But for simplicity, we'll just count opens and closes on
        # the line and process them in order.

        # Tokens we care about: function, if, for, while, do, repeat, end, until
        # Note: `else`/`elseif` are intermediate (no extra `end`).
        # Also: `function NAME(...)` and `function NAME.NAME(...)` are
        # fine — `function` opens a block.

        # We need to push openers BEFORE we see `continue` on the same
        # line, and pop closers AFTER.  To keep this simple, we
        # process the line token by token.
        new_line_parts = []
        s = stripped
        # Token positions for opens/closes/continue
        # We'll iterate through the stripped line, but emit text
        # from the original raw line.
        # For simplicity, handle the case where `continue` is the
        # only statement on the line (most common in CUH source).
        # We'll also handle inline `if X then continue end`.

        # Replacement: substitute `continue` -> `goto __cont_N__`
        if has_continue:
            # Find all `continue` (as word) and replace each with a
            # unique goto label.
            def repl(_):
                n = counter[0]
                counter[0] += 1
                # Find nearest enclosing loop and record this label
                for k in range(len(stack) - 1, -1, -1):
                    if stack[k][0] == "loop":
                        stack[k][1].append(n)
                        break
                return "goto __cont_%d__" % n
            # Replace in the RAW line (preserves indentation etc.)
            # But we need to ensure we only replace `continue` as a word
            # (not inside strings).  Use the stripped line to find positions,
            # then edit the raw line.
            #
            # Easier: just use re.sub on the raw line with word boundaries.
            # False positives only if `continue` appears in a string on
            # the same line — but CUH source doesn't do that.
            new_line = re.sub(r"\bcontinue\b", repl, raw)
        else:
            new_line = raw

        # Now handle opens/closes for stack tracking.
        # We need to know what `end`/`until` closes — push openers when
        # we see them, pop when we see `end`/`until`.

        # Process tokens in order: scan stripped line for keywords.
        # For each `function`/`if`/`for`/`while`/`do`/`repeat` we push a frame.
        # For each `end` we pop.  For `until` we pop (closes `repeat`).
        # If a frame is a "loop" with labels, insert the labels before `end`.

        # Tokenize the stripped line
        toks = re.findall(r"\b(function|if|elseif|else|for|while|do|repeat|end|until|then)\b", s)
        # Walk tokens; for `do` we need to know if previous was for/while
        last_kw = None
        # Track which positions in `new_line` need label insertion
        # (before the `end` keyword).  We'll do this with a separate
        # pass that finds `end` keywords and inserts labels.
        labels_to_insert_before_end = []
        # Stack snapshot at start of line
        line_stack_ops = []
        for kw in toks:
            if kw in ("function", "if"):
                stack.append(["block", []])
                last_kw = kw
            elif kw in ("for", "while"):
                stack.append(["loop", []])
                last_kw = kw
            elif kw == "repeat":
                stack.append(["repeat", []])
                last_kw = kw
            elif kw == "do":
                # If previous significant kw was `for`/`while`, the loop
                # is already pushed.  Otherwise it's a standalone `do`.
                if last_kw not in ("for", "while"):
                    stack.append(["block", []])
                last_kw = kw
            elif kw == "end":
                if stack:
                    top = stack[-1]
                    if top[0] == "loop" and top[1]:
                        # Insert labels before this `end`
                        labels_to_insert_before_end.append(list(top[1]))
                    stack.pop()
                last_kw = kw
            elif kw == "until":
                if stack:
                    stack.pop()
                last_kw = kw
            else:
                last_kw = kw

        # Apply label insertions to the line
        if labels_to_insert_before_end:
            # Find positions of `end` keywords (in stripped) and insert
            # labels before each, in order.
            # For simplicity, just append labels at end of line — but
            # we need them BEFORE `end`.  Insert before each `end`.
            # Approach: split the line at `end` keyword boundaries.
            # Use regex with word boundaries.
            result = []
            pos = 0
            end_iter = list(re.finditer(r"\bend\b", new_line))
            label_idx = 0
            for m in end_iter:
                # Append the text up to this `end`
                result.append(new_line[pos:m.start()])
                # If we have labels to insert before this end, do it
                if label_idx < len(labels_to_insert_before_end):
                    labels = " ".join("::__cont_%d__::" % n for n in labels_to_insert_before_end[label_idx])
                    result.append(labels + " ")
                    label_idx += 1
                # Append the `end` itself
                result.append(new_line[m.start():m.end()])
                pos = m.end()
            result.append(new_line[pos:])
            new_line = "".join(result)

        out_lines.append(new_line)

    return "\n".join(out_lines)


def main():
    if len(sys.argv) < 3:
        sys.exit("usage: cuh_preprocess.py <in.lua> <out.lua>")
    with open(sys.argv[1], "r", encoding="utf-8", errors="replace") as f:
        src = f.read()
    out = preprocess(src)
    with open(sys.argv[2], "w", encoding="utf-8") as f:
        f.write(out)
    # Print summary
    n_cont = src.count(" continue ")
    print(f"[preprocess] {sys.argv[1]}: {n_cont} continue statements -> gotos")


if __name__ == "__main__":
    main()

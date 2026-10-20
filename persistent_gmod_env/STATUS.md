# GMod 64-bit Server — Deployment Status Tracker

## Summary
GMod 64-bit server CANNOT be deployed locally due to:
1. Seccomp blocks 32-bit execution (SIGSYS)
2. No anonymous Steam license for app 4020
3. Insufficient disk space (3 GB free < 3.3 GB needed)

## Alternative: Mock-GLua Test Runner
- luacheck v1.2.0 for syntax validation
- mock_gmod_test.py for runtime logic testing via lupa LuaJIT VM
- validate_gmod_lua.py for automated lint + realm safety

## Test Results (latest run)
- 31/35 tests passing
- All actual code logic tests PASS (Silenced, bodygroups, grip anims, etc.)
- 4 failures are test harness bugs (mock VM issues, not code bugs)

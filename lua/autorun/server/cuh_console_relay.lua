-- cuh_console_relay.lua
-- Place in: lua/autorun/server/cuh_console_relay.lua
--
-- GMod-side relay. Polls data/cuh_relay/cmd.txt for Lua commands,
-- executes them, writes output to data/cuh_relay/out_<ID>.txt.
--
-- The Windows sync script (cuh_relay_sync.bat) handles copying files
-- between GitHub and the GMod data directory.

cuh_relay = cuh_relay or {}

if SERVER then
    local relayDir = "cuh_relay/"
    file.CreateDir(relayDir)

    cuh_relay.lastCmdContent = ""

    local function execLua(luaCode)
        local captured = {}
        local oldPrint = print
        print = function(...)
            local args = {...}
            local parts = {}
            for i, v in ipairs(args) do parts[i] = tostring(v) end
            table.insert(captured, table.concat(parts, "\t"))
        end

        local fn, err = CompileString(luaCode, "CUH_Relay", false)
        if not fn then
            print = oldPrint
            return "COMPILE ERROR: " .. tostring(err)
        end

        local ok, result = pcall(fn)
        print = oldPrint

        if not ok then
            return "RUNTIME ERROR: " .. tostring(result)
        end

        local output = table.concat(captured, "\n")
        if result ~= nil then
            output = output .. "\n[return] " .. tostring(result)
        end
        return output
    end

    hook.Add("Think", "CUH_Relay_Poll", function()
        local cmdFile = file.Open("cuh_relay/cmd.txt", "r", "DATA")
        if not cmdFile then return end

        local content = cmdFile:Read()
        cmdFile:Close()

        if not content or content == "" then return end
        if content == cuh_relay.lastCmdContent then return end

        cuh_relay.lastCmdContent = content

        local cmdId = content:match("^(.-)\n") or "0"
        local luaCode = content:match("\n(.*)$") or ""

        local output = execLua(luaCode)

        local outFile = file.Open("cuh_relay/out_" .. cmdId .. ".txt", "w", "DATA")
        if outFile then
            outFile:Write(output)
            outFile:Close()
        end

        file.Write("cuh_relay/cmd.txt", "")
    end)

    print("[CUH] Console relay started. Polling data/cuh_relay/cmd.txt")
end

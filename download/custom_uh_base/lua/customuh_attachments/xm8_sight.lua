-- xm8_sight.lua
-- CustomUH attachment — Default Ironsight (bodygroup-only, no model swap)
-- Ported from TFA format.

if not ATTACHMENT then
    ATTACHMENT = {}
end

ATTACHMENT.Name = "Default Ironsight"
ATTACHMENT.ShortName = ""
ATTACHMENT.Icon = "entities/ins2_att_fsi.png"
ATTACHMENT.Description = {}

ATTACHMENT.WeaponTable = {
    ["Bodygroups_V"] = {
        [2] = 0,
    },
    ["Bodygroups_W"] = {
        [2] = 0,
    },
    ["VElements"] = {
        ["barrel"] = {
            ["bodygroup"] = {
                [1] = 0,
                [2] = 0,
            },
        },
    },
    ["WElements"] = {
        ["barrel"] = {
            ["bodygroup"] = {
                [1] = 0,
                [2] = 0,
            },
        },
    },
}

function ATTACHMENT:Attach(wep)
end

function ATTACHMENT:Detach(wep)
end

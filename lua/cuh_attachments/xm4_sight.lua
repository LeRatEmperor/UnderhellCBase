if not ATTACHMENT then ATTACHMENT = {} end

ATTACHMENT.Name = "Default Ironsight"
ATTACHMENT.ShortName = ""
ATTACHMENT.Icon = "entities/ins2_att_fsi.png"
ATTACHMENT.ModelPath = nil
ATTACHMENT.PartClass = nil

ATTACHMENT.Description = {}

-- The XM4's barrel VElement has bodygroups {[2]=1, [1]=1} by default,
-- which HIDE the ironsight. This attachment sets them to 0 to SHOW it.
ATTACHMENT.WeaponTable = {
    ["Bodygroups_V"] = {
        [2] = 0,
    },
    ["Bodygroups_W"] = {
        [2] = 0,
    },
    ["VElements"] = {
        ["barrel"] = {
            ["bodygroups"] = {
                [1] = 0,
                [2] = 0,
            },
        },
    },
    ["WElements"] = {
        ["barrel"] = {
            ["bodygroups"] = {
                [1] = 0,
                [2] = 0,
            },
        },
    },
}

function ATTACHMENT:Attach(wep)
    wep:CleanupVElements()
    wep:InitVElements()
    wep:CleanupWElements()
    wep:InitWElements()
end

function ATTACHMENT:Detach(wep)
    wep:CleanupVElements()
    wep:InitVElements()
    wep:CleanupWElements()
    wep:InitWElements()
end

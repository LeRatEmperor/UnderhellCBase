if not ATTACHMENT then ATTACHMENT = {} end

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
    -- Re-init both VElements and WElements so the bodygroup overrides
    -- applied via WeaponTable.VElements / WeaponTable.WElements take
    -- effect on the ClientsideModels. (ApplyAttachments' Step 6 also
    -- does this, but calling here makes the Attach side-effect
    -- self-contained for callers that invoke Attach directly.)
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

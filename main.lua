REWORKEDITEMS = RegisterMod("Reworked Items", 1)

REWORKEDITEMS.Enums = require("ri_scripts.Enums")
REWORKEDITEMS.Helpers = require("ri_scripts.Helpers")

local scripts = {
    "passives.Skatole",
    "passives.Transcendence",
    "passives.MomsLipstick",
    "passives.Steven",
    "passives.LittleSteven",
    "passives.GhostBaby",
    "passives.StemCells",
    "passives.Abel",
    "passives.TheBody",
    "passives.MomsPearls",
    "passives.AcidBaby",
    "passives.Leprosy",

	"actives.Teleport",
}

for i = 1 , #scripts do
    require("ri_scripts."..scripts[i])
end
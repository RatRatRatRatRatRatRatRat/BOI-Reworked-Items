REWORKEDITEMS = RegisterMod("Reworked Items", 1)

local scripts = {
    "Helpers",
    "Enums",

    "items.passives.Skatole",
    --"passives.Transcendence",
    "items.passives.MomsLipstick",
    "items.passives.Steven",
    "items.passives.LittleSteven",
    "items.passives.GhostBaby",
    "items.passives.StemCells",
    "items.passives.Abel",
    "items.passives.TheBody",
    "items.passives.MomsPearls",
    "items.passives.GodsFlesh",
    "items.passives.AcidBaby",
    "items.passives.Leprosy",

	"items.actives.Teleport",
}

for i = 1 , #scripts do
    require("ri_scripts."..scripts[i])
end
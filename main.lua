REWORKEDITEMS = RegisterMod("Reworked Items", 1)

local scripts = {
    "Helpers",
    "Enums",

    "items.passives.NumberOne",
    "items.passives.Skatole",
    "items.passives.Transcendence",
    "items.passives.MomsLipstick",
    "items.passives.Steven",
    "items.passives.LittleSteven",
    "items.passives.PageantBoy",
    "items.passives.Ipecac",
    "items.passives.ToughLove",
    --"items.passives.SpiritOfTheNight",
    "items.passives.GhostBaby",
    "items.passives.RainbowBaby",
    "items.passives.StemCells",
    "items.passives.Fate",
    --"items.passives.DeadDove",
    "items.passives.Abel",
    "items.passives.SpiderBaby",
    "items.passives.TheBody",
    "items.passives.MomsPearls",
    "items.passives.Zodiac",
    "items.passives.GodsFlesh",
    "items.passives.LilLoki",
    "items.passives.DarkPrincesCrown",
    "items.passives.DeadTooth",
    "items.passives.ShardOfGlass",
    "items.passives.AcidBaby",
    "items.passives.DadsLostCoin",
    "items.passives.AngryFly",
    "items.passives.Leprosy",
    --"items.passives.Duality",

    "items.actives.Necronomicon",
    "items.actives.ThePoop",
	"items.actives.Teleport",
    "items.actives.SpiderButt",
    "items.actives.Flush",
    "items.actives.MegaBlast",
    --"items.actives.Void",
    "items.actives.Pause",
    "items.actives.BookOfVirtues",
    "items.actives.MomsBracelet",
    "items.actives.MegaMush",

    "cards.HugeGrowth",

    --"pills.Horf",

    "runes.Berkano",

    "slots.KeyMaster",
    "slots.BombBum",

    "characters.Eve",
    "characters.Samson",
    --"characters.Apollyon",

    "rooms.Library",

    "compatibility.EIDCompat",
}

for i = 1 , #scripts do
    include("ri_scripts."..scripts[i])
end
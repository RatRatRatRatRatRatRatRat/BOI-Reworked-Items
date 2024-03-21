REWORKEDITEMS = RegisterMod("Reworked Items", 1)

local scripts = {
    "Helpers",
    "Enums",

    --Rebirth Passives
    "items.passives.NumberOne",
    "items.passives.Skatole",
    "items.passives.Transcendence",
    "items.passives.MomsLipstick",
    "items.passives.Steven",
    "items.passives.DrFetus",
    "items.passives.LittleSteven",
    "items.passives.MomsKnife",
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
    --"items.passives.Anemic",
    --"items.passives.MonstrosLung",
    "items.passives.TheBody",

    --Afterbirth Passives
    "items.passives.MomsPearls",
    "items.passives.Zodiac",
    "items.passives.GodsFlesh",
    "items.passives.LilLoki",

    --Afterbirth+ Passives
    "items.passives.DarkPrincesCrown",
    "items.passives.DeadTooth",
    "items.passives.ShardOfGlass",
    "items.passives.AcidBaby",
    "items.passives.DadsLostCoin",
    "items.passives.AngryFly",
    "items.passives.Leprosy",
    --"items.passives.Duality",

    --Repentance Passives
    "items.passives.SpiritSword",
    "items.passives.GlitchedCrown",


    --Rebirth Actives
    "items.actives.Necronomicon",
    "items.actives.ThePoop",
	"items.actives.Teleport",
    "items.actives.MonstrosTooth",
    "items.actives.SpiderButt",
    "items.actives.Flush",

    --Afertbirth Actives
    "items.actives.MegaBlast",

    --Afertbirth+ Actives
    --"items.actives.Void",
    "items.actives.Pause",

    --Repentance Actives
    "items.actives.BookOfVirtues",
    "items.actives.MomsBracelet",
    "items.actives.MegaMush",
    "items.actives.BagOfCrafting",



    "cards.HugeGrowth",

    "pills.Horf",

    "runes.Berkano",

    "slots.KeyMaster",
    "slots.BombBum",

    --"characters.Eve",
    --"characters.Samson",
    --"characters.Lazarus",
    --"characters.Apollyon",

    "rooms.Secret",
    "rooms.Library",

    "compatibility.EIDCompat",
}

for i = 1 , #scripts do
    include("ri_scripts."..scripts[i])
end
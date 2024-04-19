REWORKEDITEMS = RegisterMod("Reworked Items", 1)
local mod = REWORKEDITEMS
local game = Game()

--[[
TODO LIST:

REBIRTH COLLECTIBLE CHANGES
TOGGLES
]]

local CollectibleChanges = {
    --rebirth
    --[CollectibleType.COLLECTIBLE_NUMBER_ONE] =         "rebirth.numberone",
    [CollectibleType.COLLECTIBLE_SKATOLE] =            "rebirth.skatole",
    --[CollectibleType.COLLECTIBLE_1UP] =                "rebirth.1up!", --implement next update
    [CollectibleType.COLLECTIBLE_TRANSCENDENCE] =      "rebirth.transcendence",
    --[CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL] =     "rebirth.thebookofbelial",
    --[CollectibleType.COLLECTIBLE_NECRONOMICON] =       "rebirth.thenecronomicon", --Not doable with current api
    --[CollectibleType.COLLECTIBLE_POOP] =               "rebirth.thepoop",
    --[CollectibleType.COLLECTIBLE_KAMIKAZE] =           "rebirth.kamikaze",
    [CollectibleType.COLLECTIBLE_TELEPORT] =           "rebirth.teleport",
    [CollectibleType.COLLECTIBLE_STEVEN] =             "rebirth.steven",
    [CollectibleType.COLLECTIBLE_DR_FETUS] =           "rebirth.drfetus",
    --[CollectibleType.COLLECTIBLE_LEMON_MISHAP] =       "rebirth.lemonmishap",
    --[CollectibleType.COLLECTIBLE_CHOCOLATE_MILK] =     "rebirth.chocolatemilk",
    --[CollectibleType.COLLECTIBLE_MONSTROS_TOOTH] =     "rebirth.monstrostooth",
    [CollectibleType.COLLECTIBLE_LITTLE_STEVEN] =      "rebirth.littlesteven",
    [CollectibleType.COLLECTIBLE_BEAN] =               "rebirth.thebean",
    --[CollectibleType.COLLECTIBLE_MOMS_KNIFE] =         "rebirth.momsknife",
    --[CollectibleType.COLLECTIBLE_DEAD_BIRD] =          "rebirth.deadbird",
    --[CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON] =   "rebirth.whoreofbabylon",
    --[CollectibleType.COLLECTIBLE_PAGEANT_BOY] =        "rebirth.pageantboy",
    --[CollectibleType.COLLECTIBLE_SCAPULAR] =           "rebirth.scapular", --implement next 
    --[CollectibleType.COLLECTIBLE_IPECAC] =             "rebirth.ipecac" --reimplement next update?
    --[CollectibleType.COLLECTIBLE_BLOODY_LUST] =        "rebirth.bloodylust", --implement next update
    [CollectibleType.COLLECTIBLE_EPIC_FETUS] =         "rebirth.epicfetus",
    [CollectibleType.COLLECTIBLE_ABEL] =               "rebirth.abel",
    [CollectibleType.COLLECTIBLE_TELEPATHY_BOOK] =     "rebirth.telepathyfordummies",
    [CollectibleType.COLLECTIBLE_SPIDERBABY] =         "rebirth.spiderbaby", --improve next update
    --[CollectibleType.COLLECTIBLE_BLACK_LOTUS] =        "rebirth.blacklotus",
    --[CollectibleType.COLLECTIBLE_MONSTROS_LUNG] =      "rebirth.monstroslung",
    --[CollectibleType.COLLECTIBLE_BFFS] =               "rebirth.bffs!",
    --[CollectibleType.COLLECTIBLE_LITTLE_BAGGY] =       "rebirth.littlebaggy",
    --[CollectibleType.COLLECTIBLE_FLUSH] =              "rebirth.flush!",
    --[CollectibleType.COLLECTIBLE_BLUE_BOX] =           "rebirth.pandorasbox",
    --[CollectibleType.COLLECTIBLE_TAURUS] =             "rebirth.taurus", --implement next update
    --[CollectibleType.COLLECTIBLE_HOLY_MANTLE] =        "rebirth.holymantle",
    --[CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE] = "rebirth.ludovicotechnique",
    --[CollectibleType.COLLECTIBLE_BODY] =               "rebirth.thebody",
}

local CoinChanges = {
    [CoinSubType.COIN_STICKYNICKEL] = "stickynickel",
}

local CharacterChanges = {
    --[PlayerType.PLAYER_EVE] =       "eve",
    --[PlayerType.PLAYER_SAMSON] =    "samson",
    --[PlayerType.PLAYER_APOLLYON] =  "apollyon",

    --[PlayerType.PLAYER_LAZARUS_B] = "lazarusb",
}

local SlotChanges = {
    [SlotVariant.SHELL_GAME] = "shellgame",
    [SlotVariant.KEY_MASTER] = "keymaster",
    [SlotVariant.BOMB_BUM] =   "bombbum",
}

local RoomChanges = {
    [RoomType.ROOM_TREASURE] = "treasure",
    [RoomType.ROOM_SECRET] = "secret",
    [RoomType.ROOM_LIBRARY] = "library",
}


include("ri_scripts.Helpers")


function mod:LoadFilesFromList(scripts, path)
    for _, str in pairs(scripts) do
        include(path..str)
    end
end

function mod:LoadFilesFromListComparison(scripts, list, path)
    for id, str in pairs(scripts) do
        if list[id] then
            include(path..str)
        end
    end
end


mod:LoadFilesFromList(CollectibleChanges, "ri_scripts.items.")





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
    --"items.passives.EpicFetus",
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
    "items.actives.Kamikaze",
	"items.actives.Teleport",
    "items.actives.MonstrosTooth",
    "items.actives.SpiderButt",
    "items.actives.Flush",

    --Afertbirth Actives
    "items.actives.MegaBlast",

    --Afertbirth+ Actives
    --"items.actives.Void",
    "items.actives.Pause",
    "items.actives.Clicker",

    --Repentance Actives
    "items.actives.BookOfVirtues",
    "items.actives.MomsBracelet",
    "items.actives.MegaMush",
    "items.actives.BagOfCrafting",

    "cards.HugeGrowth",

    "pills.Horf",

    "runes.Berkano",

    "pickups.StickyNickel",

    "slots.KeyMaster",
    "slots.BombBum",

    --"characters.Eve",
    "characters.Samson",
    --"characters.Lazarus",
    --"characters.Apollyon",

    "rooms.Secret",
    "rooms.Library",

    "compatibility.EIDCompat",
}



--for i = 1 , #scripts do
    --include("ri_scripts."..scripts[i])
--end
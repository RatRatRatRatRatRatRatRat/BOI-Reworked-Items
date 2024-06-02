REWORKEDITEMS = RegisterMod("Reworked Items", 1)
local mod = REWORKEDITEMS
local game = Game()

include("ri_scripts.savedata")(mod)

local scripts = {
    achievements = {},

    cards = {
        theworld = include("ri_scripts.cards.theworld"),
        berkano = include("ri_scripts.cards.berkano"),
        hugegrowth = include("ri_scripts.cards.hugegrowth"),
        reverseworld = include("ri_scripts.cards.reverseworld"),
        soulofazazel = include("ri_scripts.cards.soulofazazel"),
    },

    characters = {
        eve = include("ri_scripts.characters.eve"),
        samson = include("ri_scripts.characters.samson"),
        lost = include("ri_scripts.characters.lost"),
        --apollyon = include("ri_scripts.characters.apollyon")

        --cain B (make his bag of crafting swing damage scale ???)
        --apollyon B

        --coop = include("ri_scripts.characters.coop")
    },

    collectibles = {
        rebirth = {
            numberone = include("ri_scripts.items.rebirth.numberone"),
            skatole = include("ri_scripts.items.rebirth.skatole"),
            oneup = include("ri_scripts.items.rebirth.1up!"),
            transcendence = include("ri_scripts.items.rebirth.transcendence"),
            --thepoop = include("ri_scripts.items.rebirth.thepoop"),
            kamikaze = include("ri_scripts.items.rebirth.kamikaze"),
            teleport = include("ri_scripts.items.rebirth.teleport"),
            steven = include("ri_scripts.items.rebirth.steven"),
            drfetus = include("ri_scripts.items.rebirth.drfetus"),
            --chocomilk needs more synergiess
            monstrostooth = include("ri_scripts.items.rebirth.monstrostooth"),
            littlesteven = include("ri_scripts.items.rebirth.littlesteven"),
            thebean = include("ri_scripts.items.rebirth.thebean"),
            momsknife = include("ri_scripts.items.rebirth.momsknife"),
            whoreofbabylon = include("ri_scripts.items.rebirth.whoreofbabylon"),
            pageantboy = include("ri_scripts.items.rebirth.pageantboy"),
            scapular = include("ri_scripts.items.rebirth.scapular"),
            --bum friend should drop items hell yeah
            ipecac = include("ri_scripts.items.rebirth.ipecac"),
            --epic fetus target shouldnt vanish methinks
            spiderbutt = include("ri_scripts.items.rebirth.spiderbutt"),
            bloodlust = include("ri_scripts.items.rebirth.bloodlust"),
            epicfetus = include("ri_scripts.items.rebirth.epicfetus"),
            abel = include("ri_scripts.items.rebirth.abel"),
            telepathyfordummies = include("ri_scripts.items.rebirth.telepathyfordummies"),
            spiderbaby = include("ri_scripts.items.rebirth.spiderbaby"),
            --placenta should be better? i think
            monstroslung = include("ri_scripts.items.rebirth.monstroslung"),
            --bffs
            --little baggy
            drybaby = include("ri_scripts.items.rebirth.drybaby"),
            --dark bum
            flush = include("ri_scripts.items.rebirth.flush"),
            --pandoras box
            --taurus
            holymantle = include("ri_scripts.items.rebirth.holymantle"),
            lazarusrags = include("ri_scripts.items.rebirth.lazarusrags"),
            thebody = include("ri_scripts.items.rebirth.thebody")
        },
        afterbirth = {
            --mega bean
            --lil chest
            --no. 2
            --bumbo?
            --key bum
            zodiac = include("ri_scripts.items.afterbirth.zodiac"),
            godsflesh = include("ri_scripts.items.afterbirth.godsflesh"),
            --gb bug
            milk = include("ri_scripts.items.afterbirth.milk"),
            megablast = include("ri_scripts.items.afterbirth.megablast")
        },
        afterbirthplus = {
            darkprincescrown = include("ri_scripts.items.afterbirth+.darkprincescrown"),
            apple = include("ri_scripts.items.afterbirth+.apple"),
            deadtooth = include("ri_scripts.items.afterbirth+.deadtooth"),
            --linger bean
            --glass of shard
            --tarot cloth (more synergies)
            --belly button
            --contagion
            --shade
            --depression
            --hushy
            --king baby?
            --maybe even big chhubby??? who knows
            --plan c
            --void
            --dataminer
            --clicker = include("ri_scripts.items.afterbirth+.clicker"),
            --acid baby
            --duality
            --make eucharist easier to get
            --brown nugget i hate it so much
            --deliriumous
            --mystery gift? wait this is fine nvm. or is it?
            --telekenesis sucks
            --leprosy
            --pop 
            --plan B (baby shoots out of issac)           
        },
        repentance = {
            spiritsword = include("ri_scripts.items.repentance.spiritsword"),
            --jupiter (this ones fine but people hate it? weird...)
            momsbracelet = include("ri_scripts.items.repentance.momsbracelet"),
            megamush = include("ri_scripts.items.repentance.megamush"),
            rkey = include("ri_scripts.items.repentance.rkey"),
            --lil portal
            glitchedcrown = include("ri_scripts.items.repentance.glitchedcrown"),
            bagofcrafting = include("ri_scripts.items.repentance.bagofcrafting"),
        },
    },

    pickups = {
        --goldenhearts = include("ri_scripts.pickups.goldenhearts")
        bonehearts = include("ri_scripts.pickups.bonehearts"),
        rottenhearts = include("ri_scripts.pickups.rottenhearts"),
        stickynickel = include("ri_scripts.pickups.stickynickel"),
        --goldenkey = include("ri_scripts.pickups.goldenkey"),
        --goldenbomb = include("ri_scripts.pickups.goldenbomb"),
    },

    pills = {
        --horf = include("ri_scripts.pills.horf") --30s ipecac (similar to r u a wizard) ?
    },

    rooms = {
        secret = include("ri_scripts.rooms.secret"),
        library = include("ri_scripts.rooms.library")
    },

    slots = {
        --fortunemachine = include("ri_scripts.slots.fortunemachine"),
        keymaster = include("ri_scripts.slots.keymaster"),
        bombbum = include("ri_scripts.slots.bombbum")
        --maybe the rotten guy
    },

    trinkets = {},

    --eid = include("ri_scripts.eid")
}


local CollectibleChanges = {
    --rebirth
    --[CollectibleType.COLLECTIBLE_NUMBER_ONE] =         "rebirth.numberone",
    [CollectibleType.COLLECTIBLE_SKATOLE] =            "rebirth.skatole",
    --[CollectibleType.COLLECTIBLE_1UP] =                "rebirth.1up!", --implement next update
    [CollectibleType.COLLECTIBLE_TRANSCENDENCE] =      "rebirth.transcendence",
    --[CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL] =     "rebirth.thebookofbelial",
    --[CollectibleType.COLLECTIBLE_NECRONOMICON] =       "rebirth.thenecronomicon", --Not doable with current api :(
    --[CollectibleType.COLLECTIBLE_POOP] =               "rebirth.thepoop",
    [CollectibleType.COLLECTIBLE_KAMIKAZE] =           "rebirth.kamikaze",
    [CollectibleType.COLLECTIBLE_TELEPORT] =           "rebirth.teleport!",
    [CollectibleType.COLLECTIBLE_STEVEN] =             "rebirth.steven",
    [CollectibleType.COLLECTIBLE_DR_FETUS] =           "rebirth.drfetus",
    --[CollectibleType.COLLECTIBLE_LEMON_MISHAP] =       "rebirth.lemonmishap",
    --[CollectibleType.COLLECTIBLE_CHOCOLATE_MILK] =     "rebirth.chocolatemilk",
    [CollectibleType.COLLECTIBLE_MONSTROS_TOOTH] =     "rebirth.monstrostooth",
    [CollectibleType.COLLECTIBLE_LITTLE_STEVEN] =      "rebirth.littlesteven",
    [CollectibleType.COLLECTIBLE_BEAN] =               "rebirth.thebean",
    [CollectibleType.COLLECTIBLE_MOMS_KNIFE] =         "rebirth.momsknife",
    --[CollectibleType.COLLECTIBLE_DEAD_BIRD] =          "rebirth.deadbird",
    --[CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON] =   "rebirth.whoreofbabylon",
    --[CollectibleType.COLLECTIBLE_PAGEANT_BOY] =        "rebirth.pageantboy",
    [CollectibleType.COLLECTIBLE_SCAPULAR] =           "rebirth.scapular", --implement next 
    --[CollectibleType.COLLECTIBLE_IPECAC] =             "rebirth.ipecac", --reimplement next update
    [CollectibleType.COLLECTIBLE_BLOODY_LUST] =        "rebirth.bloodlust", --implement next update
    [CollectibleType.COLLECTIBLE_EPIC_FETUS] =         "rebirth.epicfetus",
    [CollectibleType.COLLECTIBLE_ABEL] =               "rebirth.abel",
    [CollectibleType.COLLECTIBLE_TELEPATHY_BOOK] =     "rebirth.telepathyfordummies",
    [CollectibleType.COLLECTIBLE_SPIDERBABY] =         "rebirth.spiderbaby", --improve next update
    --[CollectibleType.COLLECTIBLE_BLACK_LOTUS] =        "rebirth.blacklotus",
    [CollectibleType.COLLECTIBLE_MONSTROS_LUNG] =      "rebirth.monstroslung",
    --[CollectibleType.COLLECTIBLE_BFFS] =               "rebirth.bffs!",
    --[CollectibleType.COLLECTIBLE_LITTLE_BAGGY] =       "rebirth.littlebaggy",
    --[CollectibleType.COLLECTIBLE_FLUSH] =              "rebirth.flush!",
    --[CollectibleType.COLLECTIBLE_BLUE_BOX] =           "rebirth.pandorasbox",
    --[CollectibleType.COLLECTIBLE_UNICORN_STUMP] =      "rebirth.unicornstump",
    --[CollectibleType.COLLECTIBLE_TAURUS] =             "rebirth.taurus", --implement next update
    --[CollectibleType.COLLECTIBLE_HOLY_MANTLE] =        "rebirth.holymantle",
    [CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE] = "rebirth.ludovicotechnique",
    --[CollectibleType.COLLECTIBLE_BODY] =               "rebirth.thebody",
}

local CoinChanges = {
    [CoinSubType.COIN_STICKYNICKEL] = "stickynickel",
}

local CharacterChanges = {
    --[PlayerType.PLAYER_EVE] =       "eve",
    [PlayerType.PLAYER_SAMSON] =    "samson",
    --[PlayerType.PLAYER_APOLLYON] =  "apollyon",

    --[PlayerType.PLAYER_LAZARUS_B] = "lazarusb",
}

local SlotChanges = {
    --[SlotVariant.SHELL_GAME] = "shellgame",
    [SlotVariant.KEY_MASTER] = "keymaster",
    [SlotVariant.BOMB_BUM] =   "bombbum",
}

local RoomChanges = {
    --[RoomType.ROOM_TREASURE] = "treasure",
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


--mod:LoadFilesFromList(CollectibleChanges, "ri_scripts.items.")
--mod:LoadFilesFromList(CharacterChanges, "ri_scripts.characters.")
--mod:LoadFilesFromList(SlotChanges, "ri_scripts.slots.")




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

--	<trinket description="You feel stumped" gfx="trinket_unicornstump.png" id="1" name="Unicorn Stump" />

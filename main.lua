REWORKEDITEMS = RegisterMod("Reworked Items", 1)
local mod = REWORKEDITEMS

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
            --lilchest = include("ri_scripts.items.afterbirth.lilchest"),
            --no. 2
            --bumbo?
            --key bum
            zodiac = include("ri_scripts.items.afterbirth.zodiac"),
            godsflesh = include("ri_scripts.items.afterbirth.godsflesh"),
            gbbug = include("ri_scripts.items.afterbirth.gbbug"),
            milk = include("ri_scripts.items.afterbirth.milk"),
            megablast = include("ri_scripts.items.afterbirth.megablast")
        },
        afterbirthplus = {
            darkprincescrown = include("ri_scripts.items.afterbirth+.darkprincescrown"),
            apple = include("ri_scripts.items.afterbirth+.apple"),
            deadtooth = include("ri_scripts.items.afterbirth+.deadtooth"),
            --linger bean
            shardofglass = include("ri_scripts.items.afterbirth+.shardofglass"),
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
            --duality
            --make eucharist easier to get
            --brown nugget i hate it so much
            --deliriumous
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

--for i = 1 , #scripts do
    --include("ri_scripts."..scripts[i])
--end

--	<trinket description="You feel stumped" gfx="trinket_unicornstump.png" id="1" name="Unicorn Stump" />

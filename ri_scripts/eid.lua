if not EID then return end

local ItemDescriptionsEnglish = {
    [CollectibleType.COLLECTIBLE_NUMBER_ONE] = "↑ {{Tears}} +1.5 Tears#↑ {{Tears}} x1.2 Tears multiplier#↓ {{Range}} -1.5 Range#↓ {{Range}} x0.8 Range multiplier",
    [CollectibleType.COLLECTIBLE_1UP] = "↑ +1 Life#Isaac respawns with 6 health made up of Red and Soul Hearts",
    [CollectibleType.COLLECTIBLE_TRANSCENDENCE] = "Flight#+1 Fly orbital",
    [CollectibleType.COLLECTIBLE_POOP] = "Throws a poop",
    [CollectibleType.COLLECTIBLE_KAMIKAZE] = "Causes an explosion at Isaac's location#Deals 40 damage#Using the item on cooldown causes tiny explosions",
    [CollectibleType.COLLECTIBLE_MONSTROS_TOOTH] = "Monstro falls on an enemy and instantly kills them#Bosses and surrounding enemies take 120 damage#Monstro fires a volley of shots if the first enemy was killed#{{Warning}} Monstro falls on Isaac if the room has no enemies",
    [CollectibleType.COLLECTIBLE_LITTLE_STEVEN] = "Shoots homing tears#Deals 3.5 damage per tear#{{Collectible50}} Deals 4.5 damage if Isaac has Steven",
    [CollectibleType.COLLECTIBLE_BEAN] = "{{Poison}} Farts a poison cloud when the player uses an active item#The poison deals Isaac's damage 6 times",
    [CollectibleType.COLLECTIBLE_MOMS_KNIFE] = "Isaac's tears are replaced by a throwable knife#{{Damage}} The knife deals 2x Isaac's damage while held and caps at 6x damage at 1/3 charge#Charging further only increases throwing range#Damage reduces to 2x when returning to Isaac#The knife can open a door made of flesh",
    [CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON] = "When on one Red Heart or less:#↑ {{Speed}} +0.3 Speed#↑ {{Damage}} +1.5 Damage",
    [CollectibleType.COLLECTIBLE_PAGEANT_BOY] = "{{Coin}} Spawns 7 random coins#One coin is guaranteed to be special",
    [CollectibleType.COLLECTIBLE_SCAPULAR] = "{{HolyMantleSmall}} Isaac gains a holy mantle when damaged down to one heart or less#Can only happen once per room#Exiting and re-entering the room allows the effect to trigger again",
    [CollectibleType.COLLECTIBLE_IPECAC] = "↑ {{Damage}} +2 Damage#↑ {{Damage}} x1.5 Damage multiplier#↓ {{Tears}} x0.33 Fire rate multiplier#↓ {{Range}} x0.8 Range multiplier#↓ {{Shotspeed}} x0.8 Shot speed multiplier#Isaac's tears are fired in an arc#{{Poison}} The tears explode and poison enemies where they land",
    [CollectibleType.COLLECTIBLE_SPIDER_BUTT] = "{{Slow}} Slows down enemies for 4 seconds#Deals 10 damage to all enemies#Enemies with 10 HP or less gain a slight white tint while holding#Enemies killed by the item spawn blue spiders",
    [CollectibleType.COLLECTIBLE_BLOODY_LUST] = "↑ {{Damage}} Taking damage grants a damage up#Applies up to 6 times#{{Timer}} The number of damage ups decreases after not taking damage for a minute",
    --abel
    [CollectibleType.COLLECTIBLE_SPIDERBABY] = "Taking damage spawns 4-8 blue spiders",
    [CollectibleType.COLLECTIBLE_PLACENTA] = "↑ {{Heart}} +1 Health#{{Heart}} Heals 1 heart#{{HalfHeart}} 10% chance to heal half a heart on room clear",
    [CollectibleType.COLLECTIBLE_MONSTROS_LUNG] = "↓ {{Tears}} x0.23 Fire rate multiplier#↓ {{Range}} x0.67 Range multiplier#{{Chargeable}} Tears are charged and released in a shotgun style attack",
    [CollectibleType.COLLECTIBLE_LITTLE_BAGGY] = "{{Pill}} Identifies all pills#{{Pill}} Spawns 1 pill on pickup#Isaac can carry 2 pills#Turns all cards into pills",
    [CollectibleType.COLLECTIBLE_HOLY_MANTLE] = "Negates the first hit taken once before clearing a room",
    [CollectibleType.COLLECTIBLE_LAZARUS_RAGS] = "Once per floor, when you die:#Resurrect with half a heart#Lose 1 Red Heart container#",
    [CollectibleType.COLLECTIBLE_BODY] = "↑ {{Heart}} +3 Health#{{Heart}}Red Hearts have a 50% chance to be doubled",

    [CollectibleType.COLLECTIBLE_LIL_CHEST] = "{{Chest}} Clearing a room has a 17% chance to spawn the contents of a chest#Chest contents have a 50% chance to include an additional trinket",
    [CollectibleType.COLLECTIBLE_GB_BUG] = "{{Throwable}} Throwable (double-tap shoot)#Downgrades enemies and rerolls pickups it comes in contact with",
    [CollectibleType.COLLECTIBLE_MILK] = "{{Tears}} Taking damage grants +1 Fire rate for the duration of the room and spawns a puddle of milk#↑ Standing in the puddle of milk grants a x2 Fire rate multiplier",
    --[CollectibleType.COLLECTIBLE_MEGA_BLAST] = "{{Warning}} SINGLE USE {{Warning}}#{{Timer}} Fires a huge Mega Satan blood beam for 30 seconds#The beam persists between rooms and floors",

    [CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN] = "When on 1 Red Heart or less:#↑ {{Tears}} +2 Fire rate#↑ {{Range}} +1.5 Range#↑ {{Shotspeed}} +0.2 Shot speed",
    [CollectibleType.COLLECTIBLE_APPLE] = "{{BleedingOut}} 10% chance to shoot razors that cause bleeding, which deals 10% of the enemy's max health in damage every 5 seconds#{{Luck}} 100% chance at 9 luck",
    [CollectibleType.COLLECTIBLE_DEAD_TOOTH] = "{{Poison}} While firing, Isaac is surrounded by a growing green aura that poisons enemies#The aura grows to double the size after 1 second",
    [CollectibleType.COLLECTIBLE_SHARD_OF_GLASS] = "Upon taking damage:#{{Heart}} 25% chance to spawn a Red Heart#{{BleedingOut}} Isaac bleeds, spewing tears in the direction he is shooting#The bleeding does half a Red Heart of damage every 20 seconds#The bleeding stops if any heart is picked up, all Red Hearts are empty, or the next damage would kill Isaac",

    [CollectibleType.COLLECTIBLE_MOMS_BRACELET] = "Allows Isaac to pick up and throw rocks, TNT, poops, slots, friendly Dips, Hosts and other obstacles#Allows carrying them between rooms",
    [CollectibleType.COLLECTIBLE_MEGA_MUSH] = "{{Warning}} SINGLE USE {{Warning}}#Gigantifies Isaac and grants:#↑ {{Damage}} x4 Damage multiplier#↑ {{Range}} +2 Range#↓ {{Tears}} -1.9 Tears#Invincibility#Ability to crush enemies and obstacles#{{Timer}} Lasts for 60 seconds and persists between rooms and floors",
    [CollectibleType.COLLECTIBLE_R_KEY] = "{{Warning}} SINGLE USE {{Warning}}#Restarts the entire run#All items, trinkets, stats and pickups collected are kept#The timer does not reset#{{Warning}} Isaac now takes full heart damage starting from the first floor",
    [CollectibleType.COLLECTIBLE_BLOODY_GUST] = "When taking damage, receive:#↑ {{Speed}} Speed up#↑ {{Tears}} Fire rate up#Caps at +1.02 speed and +3 fire rate#{{Timer}} The number of stat ups decreases after not taking damage for a minute"
}

local CardDescriptionsEnglish = {
    [Card.CARD_WORLD] = "{{Timer}} Full mapping effect for the floor (except {{SuperSecretRoom}} Super Secret Room)#{{CurseLost}} Removes curse of the lost for the floor",
    [Card.RUNE_BERKANO] = "Summons a random amount of blue flies and blue spiders#Amount summoned is always 3 or more and scales with luck",
    [Card.CARD_HUGE_GROWTH] = "Gigantifies Isaac and grants:#↑ {{Damage}} x4 Damage multiplier#↑ {{Range}} +2 Range#↓ {{Tears}} -1.9 Tears#Invincibility#Ability to crush enemies and obstacles#{{Timer}} Lasts for 15 seconds and persists between rooms and floors",
    [Card.CARD_REVERSE_WORLD] = "{{ErrorRoom}} Teleports Isaac to the Error Room",
    --[Card.CARD_SOUL_AZAZEL] = "{{Collectible441}} Fires a Mega Blast beam for 15 seconds",
}

if FiendFolio then
    CardDescriptionsEnglish[Card.RUNE_BERKANO] = "Summons a random amount of blue flies, blue spiders, and blue scuzz#Amount summoned is always 3 or more and scales with luck"
end

EID.descriptions["en_us"].CharacterInfo[5] = {"Eve", "Eve has a +6.25% chance for heart drops to be {{SoulHeart}} Soul Hearts"}
EID.descriptions["en_us"].CharacterInfo[6] = {"Samson", "Samson deals 24 contact damage per second"}
EID.descriptions["en_us"].CharacterInfo[23] = {"Tainted Cain", "Touching an item pedestal turns it into a variety of pickups#Gain collectibles by crafting 8 pickups together in the Bag of Crafting#The Bag's contents can be shifted with {{ButtonRT}} to replace specific pickups when full#The Bag's swing deals Isaac's damage"}

for id, desc in pairs(ItemDescriptionsEnglish) do
    EID:addCollectible(id, desc)
end

for id, desc in pairs(CardDescriptionsEnglish) do
    EID:addCard(id, desc)
end
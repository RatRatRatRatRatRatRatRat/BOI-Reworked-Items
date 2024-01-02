if not EID then return end

EID:addCollectible(CollectibleType.COLLECTIBLE_NUMBER_ONE, "↑ {{Tears}} +1.5 Tears#↑ {{Tears}} x1.2 Tears multiplier#↓ {{Range}} -1.5 Range#↓ {{Range}} x0.8 Range multiplier")

--EID:addCollectible(CollectibleType.COLLECTIBLE_SKATOLE, "All fly enemies are friendly") -- Change isn't mentioned in EID

EID:addCollectible(CollectibleType.COLLECTIBLE_TRANSCENDENCE, "Flight#+1 Fly orbital")

EID:addCollectible(CollectibleType.COLLECTIBLE_MOMS_LIPSTICK, "↑ {{Range}} +3.75 Range#{{UnknownHeart}} Spawns 1 random heart#{{Trinket156}} 5% chance to spawn Mother's Kiss trinket instead")

EID:addCollectible(CollectibleType.COLLECTIBLE_POOP, "Throws a poop")

EID:addCollectible(CollectibleType.COLLECTIBLE_TELEPORT, "Teleports Isaac into a random room on the map#Direction of the teleport can be influenced with the movement keys")

--EID:addCollectible(CollectibleType.COLLECTIBLE_STEVEN, "↑ {{Damage}} +1 Damage") -- Change is only visual, not mentioned in EID

EID:addCollectible(CollectibleType.COLLECTIBLE_LITTLE_STEVEN, "Shoots homing tears#Deals 3.5 damage per tear#{{Collectible50}} Deals 4.5 damage if Isaac has Steven")

EID:addCollectible(CollectibleType.COLLECTIBLE_IPECAC, "↑ {{Damage}} +Damage x 10 (If the damage is less than 40)#↑ {{Damage}} +Damage x 5 + 20 (If the damage is greater than 40)#↓ {{Tears}} x0.33 Fire rate multiplier#↓ {{Range}} x0.8 Range multiplier#↓ {{Shotspeed}} -0.2 Shot speed#Isaac's tears are fired in an arc#{{Poison}} The tears explode and poison enemies where they land")

EID:addCollectible(CollectibleType.COLLECTIBLE_GHOST_BABY, "Shoots piercing + spectral tears#Deals 3.5 damage per tear")

EID:addCollectible(CollectibleType.COLLECTIBLE_SPIDER_BUTT, "{{Slow}} Slows down enemies for 4 seconds#Deals 10 damage to all enemies#Enemies with 10 HP or less gain a slight white tint while holding#Enemies killed by the item spawn blue spiders")

EID:addCollectible(CollectibleType.COLLECTIBLE_STEM_CELLS, "↑ {{Heart}} +1 Health#↑ {{Shotspeed}} +0.16 Shot speed#{{Heart}} Heals 1 heart#{{Trinket119}} Spawns the Stem Cell trinket")

EID:addCollectible(CollectibleType.COLLECTIBLE_ABEL, "Mirrors Isaac's movement#Shoots towards Isaac#Deals 3.5 damage per tear#{{Player2}} Deals +3 damage as Cain#{{Collectible90}} Deals +3.5 damage if Isaac has The Small Rock")

EID:addCollectible(CollectibleType.COLLECTIBLE_SPIDERBABY, "Taking damage spawns 4-8 blue spiders")

--EID:addCollectible(CollectibleType.COLLECTIBLE_FLUSH, "Turns all non-boss enemies into poop#Instantly kills poop enemies and bosses#Extinguishes fire places and fills the room with water#Turns lava pits into walkable ground") -- Change isn't mentioned in EID

EID:addCollectible(CollectibleType.COLLECTIBLE_BODY, "↑ {{Heart}} +3 Health#{{Heart}} Full health")

EID:addCollectible(CollectibleType.COLLECTIBLE_MOMS_PEARLS, "↑ {{Range}} +2.5 Range#↑ {{Luck}} +1 Luck#{{SoulHeart}} +1 Soul Heart#{{Trinket38}} Spawns the Mom's Pearl trinket")

--EID:addCollectible(CollectibleType.COLLECTIBLE_ZODIAC, "Grants a random zodiac item effect every floor") -- Change is only visual, not mentioned in EID

--EID:addCollectible(CollectibleType.COLLECTIBLE_GODS_FLESH, "Tears can shrink enemies#Shrunken enemies can be crushed and killed by walking over them") -- Change has more to do with the status effect, isn't menioned in EID.

EID:addCollectible(CollectibleType.COLLECTIBLE_LIL_LOKI, "Shoots 4 tears in an alternating cardinal and diagonal pattern#Deals 4 damage per tear")

EID:addCollectible(CollectibleType.COLLECTIBLE_DEAD_TOOTH, "{{Poison}} While firing, Isaac is surrounded by a constantly growing green aura that poisons enemies")

EID:addCollectible(CollectibleType.COLLECTIBLE_SHARD_OF_GLASS, "Upon taking damage:#{{Heart}} 25% chance to spawn a Red Heart#{{BleedingOut}} Isaac bleeds, spewing tears in the direction he is shooting#The bleeding does half a Red Heart of damage every 20 seconds#The bleeding stops if any heart is picked up, all Red Hearts are empty, or the next damage would kill Isaac")

--EID:addCollectible(CollectibleType.COLLECTIBLE_PAUSE, "Pauses all enemies in the room until Isaac shoots#Touching a paused enemy still deals damage to Isaac#Enemies unpause after 30 seconds") -- Change isn't mentioned in EID

EID:addCollectible(CollectibleType.COLLECTIBLE_ACID_BABY, "{{Pill}} Spawns a random pill every 7 rooms#{{Pill}} Identifies all pills#{{Poison}} Using a pill poisons all enemies in the room")

EID:addCollectible(CollectibleType.COLLECTIBLE_ANGRY_FLY, "Orbits a random enemy until that enemy dies#{{Bait}} Inflicts the enemy it orbits with the bait effect#Deals 30 contact damage per second to other enemies")

EID:addCollectible(CollectibleType.COLLECTIBLE_LEPROSY, "Taking damage spawns a projectile blocking orbital#Caps at 3 orbitals#Orbitals are destroyed and spawn half red hearts if they take too much damage")

--Cards and Runes

EID:addCard(Card.RUNE_BERKANO, "Summons a random amount of blue flies and blue spiders#Amount summoned is always 3 or more and scales with luck")
if FiendFolio then
    EID:addCard(Card.RUNE_BERKANO, "Summons a random amount of blue flies, blue spiders, and blue scuzz#Amount summoned is always 3 or more and scales with luck")
end

EID:addCard(Card.CARD_HUGE_GROWTH, "{{Collectible625}} Gigantifies Isaac and grants:#↑ {{Damage}} x4 Damage multiplier#↑ {{Range}} +2 Range#↓ {{Tears}} -1.9 Tears#Invincibility#Ability to crush enemies and obstacles#{{Timer}} Lasts for 30 seconds and persists between rooms and floors")
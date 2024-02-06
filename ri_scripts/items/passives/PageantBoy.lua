local gamedata = Isaac.GetPersistentGameData()

REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_ADD_COLLECTIBLE, function(_, Type, Charge, FirstTime, Slot, VarData, Player)
    if FirstTime then
        local rng = RNG()
        rng:SetSeed(Player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PAGEANT_BOY):GetSeed())
        Player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PAGEANT_BOY):Next()

        local RCG = WeightedOutcomePicker() --Random Coin Generator
        RCG:AddOutcomeWeight(CoinSubType.COIN_NICKEL, 5)
        RCG:AddOutcomeWeight(CoinSubType.COIN_DIME, 3)

        if gamedata:Unlocked(Achievement.LUCKY_PENNIES) then RCG:AddOutcomeWeight(CoinSubType.COIN_LUCKYPENNY, 3) end
        if gamedata:Unlocked(Achievement.STICKY_NICKELS) then RCG:AddOutcomeWeight(CoinSubType.COIN_STICKYNICKEL, 1) end
        if gamedata:Unlocked(Achievement.GOLDEN_PENNY) then RCG:AddOutcomeWeight(CoinSubType.COIN_GOLDEN, 1) end

        for i = 1, 4 do
            local position = Game():GetRoom():FindFreePickupSpawnPosition(Player.Position, 1, true)
            local subtype = CoinSubType.COIN_PENNY
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, subtype, position, Vector.Zero, Player):ToPickup():SetDropDelay(i)
        end
        for i = 5, 7 do
            local position = Game():GetRoom():FindFreePickupSpawnPosition(Player.Position, 1, true)
            local subtype = RCG:PickOutcome(rng)
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COIN, subtype, position, Vector.Zero, Player):ToPickup():SetDropDelay(i)
        end

        return {Type, 0, false, Slot, VarData}  
    end
end, CollectibleType.COLLECTIBLE_PAGEANT_BOY)
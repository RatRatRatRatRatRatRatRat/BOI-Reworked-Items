local mod = REWORKEDITEMS

local A_MISSING_PAGE_REPLACEMENT_CHANCE = 0.1
local MISSING_PAGE_2_REPLACEMENT_CHANCE = 0.05

mod:AddCallback(ModCallbacks.MC_POST_PICKUP_SELECTION, function(_, _, variant, subtype)
    if variant == PickupVariant.PICKUP_TRINKET and subtype ~= TrinketType.TRINKET_MISSING_PAGE then
        if PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_NECRONOMICON) then
            if Game():GetItemPool():HasTrinket(TrinketType.TRINKET_MISSING_PAGE) then
                local rng = RNG()
                rng:SetSeed(Game():GetRoom():GetDecorationSeed())

                if rng:RandomFloat() < A_MISSING_PAGE_REPLACEMENT_CHANCE then
                    return {PickupVariant.PICKUP_TRINKET, TrinketType.TRINKET_MISSING_PAGE}
                end
            end
        end
    end  
end)

mod:AddCallback(ModCallbacks.MC_PRE_GET_COLLECTIBLE, function(_)
    if PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_NECRONOMICON) then
        if Game():GetItemPool():CanSpawnCollectible(CollectibleType.COLLECTIBLE_MISSING_PAGE_2, false) then
            local rng = RNG()
            rng:SetSeed(Game():GetRoom():GetDecorationSeed())

            if rng:RandomFloat() < MISSING_PAGE_2_REPLACEMENT_CHANCE then
                return CollectibleType.COLLECTIBLE_MISSING_PAGE_2
            end
        end
    end
end)
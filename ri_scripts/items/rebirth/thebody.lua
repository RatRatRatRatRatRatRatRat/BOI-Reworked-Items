local mod = REWORKEDITEMS

---@param pickup EntityPickup
function mod:DoubleRedHearts(pickup)
    if pickup.SubType == HeartSubType.HEART_FULL and PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_BODY) then
        local rng = pickup:GetDropRNG()
        if rng:PhantomFloat() > 0.5 or PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_HUMBLEING_BUNDLE) then
            pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_DOUBLEPACK)
            pickup:GetSprite():Play("Spawn")
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.DoubleRedHearts, PickupVariant.PICKUP_HEART)
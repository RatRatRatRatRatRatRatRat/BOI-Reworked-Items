---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_ADD_COLLECTIBLE, function(_, _, _, istouched, _, _, player)
    if not istouched then return end
    for _, pickup in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART)) do
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_MOMS_LIPSTICK)
        if pickup.FrameCount == 0 and rng:RandomFloat() < 0.05 then
            if REWORKEDITEMS:TrySpawnTrinketFromItem(player.Position, TrinketType.TRINKET_MOTHERS_KISS) then
                pickup:Remove()
                break
            end
        end
    end
end, CollectibleType.COLLECTIBLE_MOMS_LIPSTICK)
---@param player EntityPlayer
REWORKEDITEMS:AddCallback(REWORKEDITEMS.Enums.Callbacks.POST_COLLECTIBLE_PICKUP, function(_, player, istouched)
    if istouched then return end
    for _, pickup in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART)) do
        if pickup.FrameCount == 0 then
            print("YEAA")
            if REWORKEDITEMS.Helpers.TrySpawnTrinketFromItem(player.Position, TrinketType.TRINKET_MOTHERS_KISS) then
                pickup:Remove()
                break
            end
        end
    end
end, CollectibleType.COLLECTIBLE_MOMS_LIPSTICK)
---@param player EntityPlayer
REWORKEDITEMS:AddCallback(REWORKEDITEMS.Enums.Callbacks.POST_COLLECTIBLE_PICKUP, function(_, player, istouched)
    if istouched then return end
    REWORKEDITEMS.Helpers.SpawnPickupFromItem(player.Position, PickupVariant.PICKUP_PILL)
end, CollectibleType.COLLECTIBLE_ACID_BABY)

---@param pickup EntityPickup
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, function(_, pickup)
    local pillcolor = pickup.SubType
    if pillcolor > PillColor.PILL_GIANT_FLAG then
        pillcolor = pillcolor - PillColor.PILL_GIANT_FLAG
    end
    if pillcolor ~= PillColor.PILL_GOLD then
        if REWORKEDITEMS.Helpers.DoesAnyPlayerHaveCollectibleEffect(CollectibleType.COLLECTIBLE_ACID_BABY) then
            Game():GetItemPool():IdentifyPill(pillcolor)
        end
    end
end, PickupVariant.PICKUP_PILL)
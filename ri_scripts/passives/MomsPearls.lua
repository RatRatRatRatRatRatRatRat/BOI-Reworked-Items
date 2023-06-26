---@param player EntityPlayer
REWORKEDITEMS:AddCallback(REWORKEDITEMS.Enums.Callbacks.POST_COLLECTIBLE_PICKUP, function(_, player, istouched)
    if istouched then return end
    REWORKEDITEMS.Helpers.TrySpawnTrinketFromItem(player.Position, TrinketType.TRINKET_MOMS_PEARL)
end, CollectibleType.COLLECTIBLE_MOMS_PEARLS)
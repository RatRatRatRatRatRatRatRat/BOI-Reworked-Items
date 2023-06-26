---@param player EntityPlayer
REWORKEDITEMS:AddCallback(REWORKEDITEMS.Enums.Callbacks.POST_COLLECTIBLE_PICKUP, function(_, player, istouched)
    if istouched then return end
    REWORKEDITEMS.Helpers.TrySpawnTrinketFromItem(player.Position, TrinketType.TRINKET_STEM_CELL)
end, CollectibleType.COLLECTIBLE_STEM_CELLS)
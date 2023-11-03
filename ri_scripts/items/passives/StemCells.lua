---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, function(_, _, _, istouched, _, _, player)
    if not istouched then return end
    REWORKEDITEMS:TrySpawnTrinketFromItem(player.Position, TrinketType.TRINKET_STEM_CELL)
end, CollectibleType.COLLECTIBLE_STEM_CELLS)
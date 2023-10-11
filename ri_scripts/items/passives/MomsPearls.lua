---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_ADD_COLLECTIBLE, function(_, _, _, istouched, _, _, player)
    if istouched then return end
    REWORKEDITEMS:TrySpawnTrinketFromItem(player.Position, TrinketType.TRINKET_MOMS_PEARL)
end, CollectibleType.COLLECTIBLE_MOMS_PEARLS)
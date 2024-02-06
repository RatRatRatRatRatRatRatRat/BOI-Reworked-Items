local mod = REWORKEDITEMS

---@param player EntityPlayer
mod:AddCallback(ModCallbacks.MC_PLAYER_INIT_POST_LEVEL_INIT_STATS, function(_, player)
    player:AddCollectible(CollectibleType.COLLECTIBLE_BLOOD_RIGHTS)
end, PlayerType.PLAYER_SAMSON)

local NumberOneTearMultiplier = 1.2

---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_NUMBER_ONE) then
        local tears = 30 / (player.MaxFireDelay + 1)
        tears = tears * NumberOneTearMultiplier
        player.MaxFireDelay = (30 / tears) - 1
    end
end, CacheFlag.CACHE_FIREDELAY)
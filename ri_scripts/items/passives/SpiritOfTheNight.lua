---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
    local data = player:GetData()
    local num = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SPIRIT_NIGHT)
    if data.NumSpiritOfTheNight ~= nil then
        if data.NumSpiritOfTheNight ~= num then
            data.NumSpiritOfTheNight = num
            player:AddCacheFlags(CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY, true)
        end
    else
        data.NumSpiritOfTheNight = num
    end
end)

---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, player)
    local mult = REWORKEDITEMS:GetDamageMultiplier(player)
    player.Damage = player.Damage + 0.6 * mult * player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SPIRIT_NIGHT)
end, CacheFlag.CACHE_DAMAGE)

---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, player)

end, CacheFlag.CACHE_FIREDELAY)
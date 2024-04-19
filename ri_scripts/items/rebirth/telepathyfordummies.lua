local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:TelepathyForDummiesRange(player)
    local count = player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_TELEPATHY_BOOK)
    if count > 1 then
        player.TearRange = player.TearRange + 120 * mod:GetRangeMultiplier(player) * (count - 1)
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.TelepathyForDummiesRange, CacheFlag.CACHE_RANGE)
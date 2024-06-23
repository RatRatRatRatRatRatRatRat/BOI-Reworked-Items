local mod = REWORKEDITEMS
local bible = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_BIBLE)
bible.MaxCharges = 3

--[[
bible.CacheFlags = bible.CacheFlags | CacheFlag.CACHE_TEARFLAG

---@param player EntityPlayer
function mod:BibleCache(player)
    if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BIBLE) then
        if not (player.TearFlags & TearFlags.TEAR_SPECTRAL > 0) then
            player.TearFlags = player.TearFlags | TearFlags.TEAR_SPECTRAL
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.BibleCache, CacheFlag.CACHE_TEARFLAG)
]]
local mod = REWORKEDITEMS
local game = Game()

local config = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE)
config.CacheFlags = config.CacheFlags | CacheFlag.CACHE_SHOTSPEED

---@param player EntityPlayer
function mod:LudovicoShotSpeedUp(player)
    player.ShotSpeed = player.ShotSpeed + 0.2 * player:GetCollectibleNum(CollectibleType.COLLECTIBLE_LUDOVICO_TECHNIQUE)
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.LudovicoShotSpeedUp, CacheFlag.CACHE_SHOTSPEED)

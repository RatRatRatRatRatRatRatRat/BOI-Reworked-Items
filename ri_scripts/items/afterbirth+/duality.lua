local mod = REWORKEDITEMS
local game = Game()

---@param player EntityPlayer
function mod:BlockDuality(player)
    if not player:IsCollectibleBlocked(CollectibleType.COLLECTIBLE_DUALITY) then
        player:BlockCollectible(CollectibleType.COLLECTIBLE_DUALITY)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.BlockDuality)
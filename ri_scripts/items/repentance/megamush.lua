local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:BlockMegaMushRecharge(player)
    if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_MEGA_MUSH) then return false end
end
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_TRIGGER_ROOM_CLEAR, mod.BlockMegaMushRecharge)
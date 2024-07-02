local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:SoulBHeartLimit(player)
    return 12
end
mod:AddCallback(ModCallbacks.MC_PLAYER_GET_HEART_LIMIT, mod.SoulBHeartLimit, PlayerType.PLAYER_THEFORGOTTEN_B)

local mod = REWORKEDITEMS

---@param player EntityPlayer
local function TaintedLazarusSwap(_, player)
    if player:GetPlayerType() == PlayerType.PLAYER_LAZARUS_B or player:GetPlayerType() == PlayerType.PLAYER_LAZARUS2_B then
        local sprite = player:GetSprite()
        if sprite:GetAnimation() == "Sad" and sprite:GetFrame() == 0 then
            player:StopExtraAnimation()
        end
    end
end

mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_TRIGGER_ROOM_CLEAR, TaintedLazarusSwap, PlayerVariant.PLAYER)
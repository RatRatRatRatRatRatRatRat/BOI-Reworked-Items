---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_PLAYER_TRIGGER_ROOM_CLEAR, function(_, player)
    if player:GetMegaBlastDuration() > 0 then return false end
end)
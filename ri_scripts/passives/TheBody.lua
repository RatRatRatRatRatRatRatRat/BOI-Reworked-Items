---@param player EntityPlayer
REWORKEDITEMS:AddCallback(REWORKEDITEMS.Enums.Callbacks.POST_COLLECTIBLE_PICKUP, function(_, player, istouched)
    if istouched then return end
    player:AddHearts(player:GetMaxHearts() - player:GetHearts())
end, CollectibleType.COLLECTIBLE_BODY)
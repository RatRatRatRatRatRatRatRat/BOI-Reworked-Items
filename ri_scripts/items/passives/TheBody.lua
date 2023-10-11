---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_ADD_COLLECTIBLE, function(_, _, _, istouched, _, _, player)
    if not istouched then return end
    player:AddHearts(player:GetMaxHearts() - player:GetHearts())
end, CollectibleType.COLLECTIBLE_BODY)
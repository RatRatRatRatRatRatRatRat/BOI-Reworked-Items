---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, function(_, _, _, istouched, _, _, player)
    if not istouched then return end
    player:SetFullHearts()
end, CollectibleType.COLLECTIBLE_BODY)
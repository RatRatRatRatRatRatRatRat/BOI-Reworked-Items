---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, function(_, player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN) then
    if player:GetHealthType() == HealthType.SOUL then
        if player:GetSoulHearts() == 2 then
            player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN, false, 1)
        else
            player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN)
        end
    elseif player:GetHealthType() == HealthType.LOST then
        if player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) == 0 then
            player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN, true, 1)
        else
            player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN)
        end    
    end
end
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN) then
        if player:GetHealthType() == HealthType.SOUL then
            if player:GetSoulHearts() == 2 then
                player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN, false, 1)
            else
                player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN)
            end
        elseif player:GetHealthType() == HealthType.LOST then
            if player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) == 0 then
                player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN, true, 1)
            else
                player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN)
            end    
        end
    end
    end
end)
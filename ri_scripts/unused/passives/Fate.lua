local mod = REWORKEDITEMS

---@param player EntityPlayer
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, function(_, player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_FATE) then
        local rng = RNG()
        rng:SetSeed(Game():GetRoom():GetDecorationSeed())
        if rng:RandomFloat() < 0.25 then
            local sillynumber = rng:RandomInt(1, 3)
            
            if sillynumber == 1 then
                player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_BROTHER_BOBBY)
            elseif sillynumber == 2 then
                player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_FATES_REWARD)
            elseif sillynumber == 3 then
                player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_BLUE_BABYS_ONLY_FRIEND)
            end
        end
    end
end)
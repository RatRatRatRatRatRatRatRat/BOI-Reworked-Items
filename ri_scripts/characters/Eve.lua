local mod = REWORKEDITEMS

---@param player EntityPlayer
mod:AddCallback(ModCallbacks.MC_PLAYER_INIT_POST_LEVEL_INIT_STATS, function(_, player)
    player:RemoveCollectible(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON)
end, PlayerType.PLAYER_EVE)

---@param player EntityPlayer
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, function(_, player)
            if player:GetHearts() <= 2 and not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON) then
                player:UseCard(Card.CARD_EMPRESS, UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOANIM)
            end
end, PlayerType.PLAYER_EVE)

---@param player EntityPlayer
local function AddWhoreOfBabylon(_, player)
    if player:GetHearts() <= 2 and not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON) then
        player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, AddWhoreOfBabylon, PlayerType.PLAYER_EVE)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_LEVEL, --[[YO!!!]] AddWhoreOfBabylon, PlayerType.PLAYER_EVE)
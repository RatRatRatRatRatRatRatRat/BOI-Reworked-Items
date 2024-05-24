local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:ActivateWhoreOfBabylon(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON) then
        if player:GetHearts() <= 2 and not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON) then
            player:UseCard(Card.CARD_EMPRESS, UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOANIM)
        end
    end
end

---@param player EntityPlayer
function mod:AddWhoreOfBabylon(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON) then
        if player:GetHearts() <= 2 and not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON) then
           player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, --[[YO!!!!!]] mod.ActivateWhoreOfBabylon)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, mod.AddWhoreOfBabylon)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_LEVEL, --[[YO!!!]] mod.AddWhoreOfBabylon)
local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:BlockScapular(player)
    if not player:IsCollectibleBlocked(CollectibleType.COLLECTIBLE_SCAPULAR) then
        player:BlockCollectible(CollectibleType.COLLECTIBLE_SCAPULAR)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.BlockScapular)

---@param player EntityPlayer
function mod:ScapularNewRoom(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_SCAPULAR, false, true) then
        local effects = player:GetEffects()
        if not effects:HasNullEffect(NullItemID.ID_HOLY_CARD) then
            effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_SCAPULAR)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, mod.ScapularNewRoom)

---@param entity Entity
function mod:ScapularTakeDmg(entity)
    local player = entity:ToPlayer()
    print("A")

    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_SCAPULAR, false, true) then
        if player:GetHearts() + player:GetSoulHearts() + player:GetBoneHearts() <= 2 then
            local effects = player:GetEffects()
            if effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_SCAPULAR) then
                player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
                effects:RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_SCAPULAR)
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_TAKE_DMG, mod.ScapularTakeDmg, EntityType.ENTITY_PLAYER)
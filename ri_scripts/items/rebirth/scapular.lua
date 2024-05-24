local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:BlockScapular(player)
    if not player:IsCollectibleBlocked(CollectibleType.COLLECTIBLE_SCAPULAR) then
        player:BlockCollectible(CollectibleType.COLLECTIBLE_SCAPULAR)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.BlockScapular)

---@param entity Entity
function mod:ScapularTakeDmg(entity)
    local player = entity:ToPlayer()

    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_SCAPULAR, false, true) then
        if player:GetHearts() + player:GetSoulHearts() + player:GetBoneHearts() <= 1 then
            local effects = player:GetEffects()
            if not effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_SCAPULAR) then
                effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
                effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_SCAPULAR)
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_TAKE_DMG, mod.ScapularTakeDmg, EntityType.ENTITY_PLAYER)
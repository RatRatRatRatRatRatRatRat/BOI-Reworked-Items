local mod = REWORKEDITEMS
local sfx = SFXManager()
local newcostume = Isaac.GetCostumeIdByPath("gfx/characters/020_transcendence_2.anm2")

---@param player EntityPlayer
function mod:TranscendencePickup(id, charge, isfirst, slot, vardata, player)
    if isfirst then
        player:AddPrettyFly()
        player:StopExtraAnimation()
        sfx:Stop(SoundEffect.SOUND_THUMBSUP)
    end
    player:AddNullCostume(newcostume)
end

---@param player EntityPlayer
function mod:TranscendenceRemove(player)
    player:TryRemoveNullCostume(newcostume)
end

mod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, mod.TranscendencePickup, CollectibleType.COLLECTIBLE_TRANSCENDENCE)
mod:AddCallback(ModCallbacks.MC_POST_TRIGGER_COLLECTIBLE_REMOVED, mod.TranscendenceRemove, CollectibleType.COLLECTIBLE_TRANSCENDENCE)

---@param player EntityPlayer
function mod:UseHangedMan(_, player, _)
    player:AddNullCostume(newcostume)
end

---@param player EntityPlayer
function mod:NewRoomTranscendenceCostume(player)
    if (not player.Variant == PlayerVariant.CO_OP_BABY) and player:IsNullItemCostumeVisible(newcostume, "body") and
    not (player:HasCollectible(CollectibleType.COLLECTIBLE_TRANSCENDENCE) or
    player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_TRANSCENDENCE)) then
        player:TryRemoveNullCostume(newcostume)
    end    
end

mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseHangedMan, Card.CARD_HANGED_MAN)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, mod.NewRoomTranscendenceCostume)
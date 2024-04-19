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
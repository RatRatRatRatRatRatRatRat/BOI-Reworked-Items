local mod = REWORKEDITEMS
Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_MEGA_MUSH).MaxCharges = 0

---@param player EntityPlayer
---@param useflag UseFlag
function mod:UseMegaMush(_, _, player, useflag)
    if useflag & UseFlag.USE_OWNED then
        local peffect = player:GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_MEGA_MUSH)
        peffect.Cooldown = peffect.Cooldown + 1800
        return {
            Remove = true
        }
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseMegaMush, CollectibleType.COLLECTIBLE_MEGA_MUSH)
local mod = REWORKEDITEMS
Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_MEGA_BLAST).MaxCharges = 0

---@param player EntityPlayer
---@param useflag UseFlag
function mod:UseMegaBlast(_, _, player, useflag)
    if useflag & UseFlag.USE_OWNED then
        player:SetMegaBlastDuration(player:GetMegaBlastDuration() + 900)
        return {
            Remove = true
        }
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseMegaBlast, CollectibleType.COLLECTIBLE_MEGA_BLAST)
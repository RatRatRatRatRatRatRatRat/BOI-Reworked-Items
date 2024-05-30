local mod = REWORKEDITEMS

function mod:RKEYStatus(iscontinued)
    if not iscontinued then
        mod.Data.RKEYUSED = 0
    end
end
mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.RKEYStatus)

function mod:UseRKEY()
    if mod.Data.RKEYUSED then
        mod.Data.RKEYUSED = mod.Data.RKEYUSED + 1
    else
        mod.Data.RKEYUSED = 1
    end
end
mod:AddCallback(ModCallbacks.MC_USE_ITEM, mod.UseRKEY, CollectibleType.COLLECTIBLE_R_KEY)

---@param player EntityPlayer
function mod:RKEYTakeDMG(player, dmg, flags, ref, count)
    if not mod.Data.RKEYUSED then
        mod.Data.RKEYUSED = 0
    end
    if dmg == 1 and mod.Data.RKEYUSED > 0 then
        player:TakeDamage(2, flags, ref, count)
        return false
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, mod.RKEYTakeDMG)
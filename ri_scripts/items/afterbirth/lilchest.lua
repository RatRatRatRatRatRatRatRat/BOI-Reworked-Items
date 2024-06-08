local mod = REWORKEDITEMS

---@param familiar EntityFamiliar
function mod:LilChestUpdate(familiar)

    return true
end

mod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_UPDATE, mod.LilChestUpdate, FamiliarVariant.LIL_CHEST)
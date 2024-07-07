local mod = REWORKEDITEMS

---@param tear EntityTear
mod:AddCallback(ModCallbacks.MC_POST_FAMILIAR_FIRE_PROJECTILE, function(_, tear)
    tear:AddTearFlags(TearFlags.TEAR_PIERCING)
    tear:ChangeVariant(TearVariant.CUPID_BLUE)
end, FamiliarVariant.GHOST_BABY)
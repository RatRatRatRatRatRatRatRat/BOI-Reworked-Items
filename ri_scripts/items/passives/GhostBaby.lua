---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_FAMILIAR_FIRE_PROJECTILE, function(_, tear, familiar)
    if familiar and familiar.Variant == FamiliarVariant.GHOST_BABY then
        tear:AddTearFlags(TearFlags.TEAR_PIERCING)
        tear:ChangeVariant(TearVariant.CUPID_BLUE)
    end
end)
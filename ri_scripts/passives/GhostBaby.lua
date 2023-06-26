---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, function(_, tear)
    if tear.SpawnerEntity and tear.SpawnerType == EntityType.ENTITY_FAMILIAR and tear.SpawnerVariant == FamiliarVariant.GHOST_BABY then
        tear:AddTearFlags(TearFlags.TEAR_PIERCING)
        tear:ChangeVariant(TearVariant.CUPID_BLUE)
    end
end)
local baseTearVariants = 10
local newTearVariants = 5

local newTearChance = newTearVariants / (baseTearVariants + newTearVariants)

---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, function(_, tear)
    if tear.SpawnerEntity and tear.SpawnerType == EntityType.ENTITY_FAMILIAR and tear.SpawnerVariant == FamiliarVariant.RAINBOW_BABY then
        local familiar = tear.SpawnerEntity:ToFamiliar()
        local rng = familiar:GetDropRNG()
        if rng:RandomFloat() < newTearChance then
        end
    end
end)
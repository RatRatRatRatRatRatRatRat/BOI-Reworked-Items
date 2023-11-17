local baseTearVariants = 10
local newTearVariants = 5

local newTearChance = newTearVariants / (baseTearVariants + newTearVariants)

---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_FAMILIAR_FIRE_PROJECTILE, function(_, tear)
    local familiar = tear.SpawnerEntity:ToFamiliar()
    local rng = familiar:GetDropRNG()
    if rng:RandomFloat() < newTearChance then
    end
end, FamiliarVariant.RAINBOW_BABY)
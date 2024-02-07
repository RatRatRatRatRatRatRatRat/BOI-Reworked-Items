local baseTearVariants = 10
local newTearVariants = 2

local newTearChance = newTearVariants / (baseTearVariants + newTearVariants)

---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_FAMILIAR_FIRE_PROJECTILE, function(_, tear)
    local familiar = tear.SpawnerEntity:ToFamiliar()
    if not familiar then return end

    local rng = familiar:GetDropRNG()
    if rng:RandomFloat() < newTearChance then
        for _, tear2 in pairs(Isaac.FindByType(EntityType.ENTITY_TEAR)) do
            if tear2.InitSeed ~= tear.InitSeed
            and tear2.FrameCount == 0 
            and tear2.SpawnerType == EntityType.ENTITY_FAMILIAR 
            and tear2.SpawnerVariant == FamiliarVariant.RAINBOW_BABY then
                return
            end
        end

        tear:ClearTearFlags(tear.TearFlags)

        local newtearvariant = rng:RandomInt(1, newTearVariants)
        if newtearvariant == 1 then
            tear:ChangeVariant(TearVariant.ICE)
            tear.Color = Color(1, 1, 1, 1)
            tear.Scale = 1
            tear.CollisionDamage = 3.5
            tear:AddTearFlags(TearFlags.TEAR_ICE)
        elseif newtearvariant == 2 then
            tear:ChangeVariant(TearVariant.BLUE)
            tear.Color = Color(1.5, 2, 2, 1)
            tear.Scale = 1.1
            tear.CollisionDamage = 10
            tear:AddTearFlags(TearFlags.TEAR_HOMING)
        end

        if familiar.Player:GetEffects():HasTrinketEffect(TrinketType.TRINKET_BABY_BENDER) then
            tear:AddTearFlags(TearFlags.TEAR_HOMING)
        end
    end
end, FamiliarVariant.RAINBOW_BABY)
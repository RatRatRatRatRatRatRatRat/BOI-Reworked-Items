---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, function(_, tear)
    if tear.SpawnerEntity and tear.SpawnerType == EntityType.ENTITY_FAMILIAR and tear.SpawnerVariant == FamiliarVariant.ABEL then
        local familiar = tear.SpawnerEntity:ToFamiliar()
        if familiar.Player then
            local player = familiar.Player
            if REWORKEDITEMS.Helpers.DoesPlayerHaveCollectibleEffect(player, CollectibleType.COLLECTIBLE_SMALL_ROCK) then
                tear:ChangeVariant(TearVariant.BLOOD)
            end
        end
    end
end)

---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, function(_, tear)
    if tear.FrameCount ~= 1 then return end
    if tear.SpawnerEntity and tear.SpawnerType == EntityType.ENTITY_FAMILIAR and tear.SpawnerVariant == FamiliarVariant.ABEL then
        local familiar = tear.SpawnerEntity:ToFamiliar()
        if familiar.Player then
            local player = familiar.Player
            if REWORKEDITEMS.Helpers.DoesPlayerHaveCollectibleEffect(player, CollectibleType.COLLECTIBLE_SMALL_ROCK) then
                if REWORKEDITEMS.Helpers.DoesPlayerHaveCollectibleEffect(player, CollectibleType.COLLECTIBLE_BFFS) then
                    tear.CollisionDamage = tear.CollisionDamage + 7
                    tear.Scale = tear.Scale + 0.7
                else
                    tear.CollisionDamage = tear.CollisionDamage + 3.5
                    tear.Scale = tear.Scale + 0.35
                end
            end
        end
    end
end)
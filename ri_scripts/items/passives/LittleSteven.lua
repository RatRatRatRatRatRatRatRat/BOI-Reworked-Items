---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, function(_, tear)
    if tear.FrameCount ~= 1 then return end
    if tear.SpawnerEntity and tear.SpawnerType == EntityType.ENTITY_FAMILIAR and tear.SpawnerVariant == FamiliarVariant.LITTLE_STEVEN then
        local familiar = tear.SpawnerEntity:ToFamiliar()
        if familiar.Player then
            local player = familiar.Player
            if player:HasCollectible(CollectibleType.COLLECTIBLE_STEVEN) then
                if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
                    tear.CollisionDamage = tear.CollisionDamage + 2
                    tear.Scale = tear.Scale + 0.2
                else
                    tear.CollisionDamage = tear.CollisionDamage + 1
                    tear.Scale = tear.Scale + 0.1
                end
            end
        end
    end
end)
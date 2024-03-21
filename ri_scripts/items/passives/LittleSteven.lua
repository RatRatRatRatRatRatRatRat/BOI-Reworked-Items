---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_FAMILIAR_FIRE_PROJECTILE, function(_, tear)
    local familiar = tear.SpawnerEntity:ToFamiliar()
    if familiar and familiar.Player then
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
end, FamiliarVariant.LITTLE_STEVEN)
local mod = REWORKEDITEMS

---@param tear EntityTear
function mod:LittleStevenFireTear(tear)
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
end

mod:AddCallback(ModCallbacks.MC_POST_FAMILIAR_FIRE_PROJECTILE, mod.LittleStevenFireTear, FamiliarVariant.LITTLE_STEVEN)
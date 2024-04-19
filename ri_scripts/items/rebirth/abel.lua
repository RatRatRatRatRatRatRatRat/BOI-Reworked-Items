local mod = REWORKEDITEMS

---@param tear EntityTear
function mod:AbelFireTear(tear)
    local familiar = tear.SpawnerEntity:ToFamiliar()
    if familiar and familiar.Player then
        local player = familiar.Player
        if player:HasCollectible(CollectibleType.COLLECTIBLE_SMALL_ROCK) then
            if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
                tear.CollisionDamage = tear.CollisionDamage + 7
                tear.Scale = tear.Scale + 0.7
            else
                tear.CollisionDamage = tear.CollisionDamage + 3.5
                tear.Scale = tear.Scale + 0.35
            end

            tear:ChangeVariant(TearVariant.BLOOD)
        end
    end
end

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_FAMILIAR_FIRE_PROJECTILE, mod.AbelFireTear, FamiliarVariant.ABEL)
local mod = REWORKEDITEMS

---@param tear EntityTear
function mod:AbelFireTear(tear)
    if tear.SpawnerEntity then

        local familiar = tear.SpawnerEntity:ToFamiliar()
        if familiar and familiar.Player then

            local player = familiar.Player
            if player then
                if not(player:GetPlayerType() == PlayerType.PLAYER_CAIN
                or player:GetPlayerType() == PlayerType.PLAYER_CAIN_B) 
                and player:HasCollectible(CollectibleType.COLLECTIBLE_SMALL_ROCK) then
                    if player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
                        tear.CollisionDamage = tear.CollisionDamage + 8
                    else
                        tear.CollisionDamage = tear.CollisionDamage + 4
                    end
                    tear:ChangeVariant(TearVariant.BLOOD)
                end
            end
        end
    end
end
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_FAMILIAR_FIRE_PROJECTILE, mod.AbelFireTear, FamiliarVariant.ABEL)
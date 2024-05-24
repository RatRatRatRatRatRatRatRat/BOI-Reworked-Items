local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:NumberOneCache(player, cache)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_NUMBER_ONE) then
        if cache & CacheFlag.CACHE_FIREDELAY > 0 then
            player.MaxFireDelay = player.MaxFireDelay / 1.2
        end

        if cache & CacheFlag.CACHE_RANGE > 0 then
            if not player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC)
            and not player:HasCollectible(CollectibleType.COLLECTIBLE_HAEMOLACRIA) then
                player.TearFallingAcceleration = 0.9
            end
        end
    end
end

---@param tear EntityTear
function mod:FireNumberOneTear(tear)
    if not tear.SpawnerEntity then return end

    local player = tear.SpawnerEntity:ToPlayer()
    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_NUMBER_ONE) then
        tear:GetData().PissTear = true
    end
end


---@param tear EntityTear
function mod:NumberOneTearDeath(tear)
    if tear:GetData().PissTear then
        local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, tear.Position, Vector.Zero, nil):ToEffect()
        if creep then
            creep:GetSprite():ReplaceSpritesheet(0, "gfx/effects/effect_pisspool.png", true)
            creep.Timeout = 15

            local scale = math.ceil(tear.Size) / 8
            creep.SpriteScale = Vector(scale, scale)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.NumberOneCache)
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.FireNumberOneTear)
mod:AddCallback(ModCallbacks.MC_POST_TEAR_DEATH, mod.NumberOneTearDeath)


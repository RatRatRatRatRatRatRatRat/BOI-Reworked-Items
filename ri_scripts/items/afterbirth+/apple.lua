local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:BlockApple(player)
    if not player:IsCollectibleBlocked(CollectibleType.COLLECTIBLE_APPLE) then
        player:BlockCollectible(CollectibleType.COLLECTIBLE_APPLE)
    end
end

---@param tear EntityTear
function mod:FireAppleTear(tear)
    if not tear.SpawnerEntity and tear.SpawnerType ~= EntityType.ENTITY_PLAYER then return end
    local player = tear.SpawnerEntity:ToPlayer()

    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_APPLE, false, true) then
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_APPLE)
        if rng:RandomFloat() < math.max(0.1, 1 / (10 - math.min(9, player.Luck))) then
            if tear.Variant < TearVariant.RAZOR then
                tear:ChangeVariant(TearVariant.RAZOR)
                tear:GetData().IsAppleTear = true
            end
        end
    end
end

---@param bomb EntityBomb
function mod:FireAppleBomb(bomb)
    if not bomb.SpawnerEntity and bomb.SpawnerType ~= EntityType.ENTITY_PLAYER then return end
    local player = bomb.SpawnerEntity:ToPlayer()

    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_APPLE, false, true) then
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_APPLE)
        if rng:RandomFloat() < math.max(0.1, 1 / (10 - math.min(9, player.Luck))) then
            bomb:GetData().IsAppleTear = true
        end
    end
end

---@param effect EntityEffect
function mod:FireAppleRocket(effect)
    if not effect.SpawnerEntity and effect.SpawnerType ~= EntityType.ENTITY_PLAYER then return end
    local player = effect.SpawnerEntity:ToPlayer()

    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_APPLE, false, true) then
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_APPLE)
        if rng:RandomFloat() < math.max(0.1, 1 / (10 - math.min(9, player.Luck))) then
            effect:GetData().IsAppleTear = true
        end
    end
end

---@param knife EntityKnife
function mod:FireAppleKnife(knife)
    if not knife.SpawnerEntity and knife.SpawnerType ~= EntityType.ENTITY_PLAYER then return end
    local player = knife.SpawnerEntity:ToPlayer()

    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_APPLE, false, true) then
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_APPLE)
        if rng:RandomFloat() < math.max(0.1, 1 / (10 - math.min(9, player.Luck))) then
            knife:GetData().IsAppleTear = true
        else
            knife:GetData().IsAppleTear = false
        end
    end
end

---@param entity Entity
---@param source EntityRef
function mod:ApplyAppleTearBleeding(entity, _, _, source)
    local coll = source.Entity
    if coll and coll:GetData().IsAppleTear then
        entity:AddBleeding(source, 150)
    end
end


---@param laser EntityLaser
---@param coll Entity
function mod:AppleLaserCollision(laser, coll)
    if not laser.SpawnerEntity and laser.SpawnerType ~= EntityType.ENTITY_PLAYER then return end
    local player = laser.SpawnerEntity:ToPlayer()

    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_APPLE, false, true) then
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_APPLE)
        if rng:RandomFloat() < math.max(0.1, 1 / (10 - math.min(9, player.Luck))) then
            coll:AddBleeding(EntityRef(player), 150)
        end
    end
end


mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.BlockApple)

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.FireAppleTear)
mod:AddCallback(ModCallbacks.MC_POST_FIRE_BOMB, mod.FireAppleBomb)
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, mod.FireAppleRocket, EffectVariant.ROCKET)
mod:AddCallback(ModCallbacks.MC_POST_FIRE_BRIMSTONE_BALL, mod.FireAppleRocket)
mod:AddCallback(ModCallbacks.MC_POST_FIRE_KNIFE, mod.FireAppleKnife)
mod:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, mod.FireAppleKnife)

mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.ApplyAppleTearBleeding)
mod:AddCallback(ModCallbacks.MC_POST_LASER_COLLISION, mod.AppleLaserCollision)
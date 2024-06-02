local mod = REWORKEDITEMS

mod.OverrideIpecacList = {
    [WeaponType.WEAPON_BRIMSTONE] = true,
    [WeaponType.WEAPON_LASER] = true,
    [WeaponType.WEAPON_KNIFE] = true,
    [WeaponType.WEAPON_BOMBS] = true,
    [WeaponType.WEAPON_ROCKETS] = true,
    [WeaponType.WEAPON_TECH_X] = true,
    [WeaponType.WEAPON_BONE] = true,
}

---@param player EntityPlayer
function mod:IpecacEvaluateCache(player, cache)
    if mod.OverrideIpecacList[player:GetWeapon(1):GetWeaponType()] then
        player:UnblockCollectible(CollectibleType.COLLECTIBLE_IPECAC)
    else
        player:BlockCollectible(CollectibleType.COLLECTIBLE_IPECAC)            
    end

    if player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC, false, true) and player:IsCollectibleBlocked(CollectibleType.COLLECTIBLE_IPECAC) then
        if cache & CacheFlag.CACHE_FIREDELAY > 0 and not player:HasCollectible(CollectibleType.COLLECTIBLE_HAEMOLACRIA) then
            player.MaxFireDelay = player.MaxFireDelay * 3
        end

        if cache & CacheFlag.CACHE_RANGE > 0 and not player:HasCollectible(CollectibleType.COLLECTIBLE_HAEMOLACRIA) and not player:HasCollectible(CollectibleType.COLLECTIBLE_CRICKETS_BODY) then
            player.TearFallingAcceleration = 0.8
            player.TearRange = player.TearRange * 0.8
        end

        if cache & CacheFlag.CACHE_SHOTSPEED > 0 then
            player.ShotSpeed = player.ShotSpeed * 0.8
        end

        if cache & CacheFlag.CACHE_DAMAGE > 0 then
            player.Damage = player.Damage + 2
        end
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.IpecacEvaluateCache)



---@param player EntityPlayer
function mod:NumberOneEvaluateCache(player, cache)

    if cache & CacheFlag.CACHE_FIREDELAY > 0 then
        --player.MaxFireDelay = player.MaxFireDelay / 1.5
    end

    if cache & CacheFlag.CACHE_RANGE > 0 then
        player.TearFallingAcceleration = 0.6
    end
end

--mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.NumberOneEvaluateCache)

---@param tear EntityTear
function mod:IpecacFireTear(tear)
    if not tear.SpawnerEntity then return end
    local player = tear.SpawnerEntity:ToPlayer()

    if player then
        --tear.Color = Color.TearNumberOne
    end

    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC, false, true) then
        tear.Color = Color.TearIpecac

        if not player:HasCollectible(CollectibleType.COLLECTIBLE_HAEMOLACRIA) then
            tear.Scale = tear.Scale * 1.2
        end

        tear.CollisionDamage = tear.BaseDamage * 5

        tear:AddTearFlags(TearFlags.TEAR_EXPLOSIVE | TearFlags.TEAR_POISON)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.IpecacFireTear)
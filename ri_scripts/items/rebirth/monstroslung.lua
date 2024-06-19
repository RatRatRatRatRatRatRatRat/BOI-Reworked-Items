local mod = REWORKEDITEMS
local lung = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_MONSTROS_LUNG)
lung.CacheFlags = lung.CacheFlags | CacheFlag.CACHE_RANGE

---@param player EntityPlayer
function mod:MonstrosLungRangeCache(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_MONSTROS_LUNG) then
        if player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC)
        or player:HasCollectible(CollectibleType.COLLECTIBLE_CRICKETS_BODY)
        or player:HasCollectible(CollectibleType.COLLECTIBLE_HAEMOLACRIA) then
            player.TearRange = player.TearRange * (10/12)
        else
            player.TearRange = player.TearRange * (2/3)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.MonstrosLungRangeCache, CacheFlag.CACHE_RANGE)

---@param tear EntityTear
function mod:MonstrosLungFireTear(tear)
    if not tear.SpawnerEntity then return end
    local player = tear.SpawnerEntity:ToPlayer()

    if player and player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
        local rng = tear:GetDropRNG()
        tear:GetData().MonstrosLungRange = player.TearRange * (1.1 - 0.9 * rng:RandomFloat())
        tear.FallingAcceleration = 0
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, mod.MonstrosLungFireTear)

---@param tear EntityTear
function mod:MonstrosLungTearUpdate(tear)
    if not tear.SpawnerEntity then return end
    local player = tear.SpawnerEntity:ToPlayer()

    if player and player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
        local data = tear:GetData()
        if data.MonstrosLungRange then
            tear.FallingSpeed = -0.8 + (tear.FrameCount * 30 / data.MonstrosLungRange)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.MonstrosLungTearUpdate)
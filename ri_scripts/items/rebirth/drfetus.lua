local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:DrFetusWeaponCache(player)
    if player:HasWeaponType(WeaponType.WEAPON_KNIFE) and player:GetCollectibleNum(CollectibleType.COLLECTIBLE_DR_FETUS) > 0 then
        player:EnableWeaponType(WeaponType.WEAPON_KNIFE, false)
        player:EnableWeaponType(WeaponType.WEAPON_BOMBS, true)
    end
end

---@param bomb EntityBomb
function mod:FireDrFetusBomb(bomb)
    if not bomb.SpawnerEntity and bomb.SpawnerType ~= EntityType.ENTITY_PLAYER then return end
    local player = bomb.SpawnerEntity:ToPlayer()

    if player then
        local data = bomb:GetData()

        if not bomb:HasTearFlags(TearFlags.TEAR_SAD_BOMB) then
            if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BRIMSTONE) > 0 then
                bomb:AddTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB)
            end

            if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TECHNOLOGY) > 0 then
                data.TechnologyBomb = true
            end
        end
    end
end

---@param coll Entity
function mod:PreventBrimstoneBombLaserCollision(laser, coll)
    if coll.Type == EntityType.ENTITY_BOMB then
        local bomb = coll:ToBomb()

        if bomb and bomb:HasTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB) then
            return true
        end
    end
end

---@param bomb EntityBomb
function mod:DrFetusBombUpdate(bomb)

end


--mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.DrFetusWeaponCache, CacheFlag.CACHE_WEAPON)
mod:AddCallback(ModCallbacks.MC_POST_FIRE_BOMB, mod.FireDrFetusBomb)
mod:AddCallback(ModCallbacks.MC_PRE_LASER_COLLISION, mod.PreventBrimstoneBombLaserCollision)
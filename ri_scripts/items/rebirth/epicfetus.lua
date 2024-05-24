local mod = REWORKEDITEMS





--[[
---@param player EntityPlayer
function mod:EpicFetusWeaponCache(player)
    if  player:HasWeaponType(WeaponType.WEAPON_ROCKETS) and player:GetCollectibleNum(CollectibleType.COLLECTIBLE_EPIC_FETUS) > 0 then
        player:EnableWeaponType(WeaponType.WEAPON_ROCKETS, false)
        player:EnableWeaponType(WeaponType.WEAPON_BOMBS, true)
    end
end

---@param bomb EntityBomb
function mod:FireEpicFetusBomb(bomb)
    if not bomb.SpawnerEntity and bomb.SpawnerEntity ~= EntityType.ENTITY_PLAYER then return end
    local player = bomb.SpawnerEntity:ToPlayer()

    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_EPIC_FETUS) then
        local rocket = Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_ROCKET, bomb.SubType, bomb.Position, bomb.Velocity, player):ToBomb()
        if rocket then
            rocket:SetRocketAngle(rocket.Velocity:GetAngleDegrees())
            rocket:GetSprite().Rotation = rocket.Velocity:GetAngleDegrees()
            rocket:AddTearFlags(bomb.Flags)
            rocket.Size = bomb.Size
            rocket.SizeMulti = bomb.SizeMulti
            rocket.RadiusMultiplier = bomb.RadiusMultiplier
            
            local data = rocket:GetData() 
            data = bomb:GetData()

            local dmg = player.Damage * 10
            if dmg > 40 then
                dmg = player.Damage * 5 + 20
            end
            if player:HasCollectible(CollectibleType.COLLECTIBLE_MR_MEGA) then
                dmg = dmg + 10
            end
            rocket.ExplosionDamage = dmg

            bomb:Remove()
        end
    end
end

mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.EpicFetusWeaponCache, CacheFlag.CACHE_WEAPON)
mod:AddPriorityCallback(ModCallbacks.MC_POST_FIRE_BOMB, CallbackPriority.LATE, mod.FireEpicFetusBomb)
]]
local mod = REWORKEDITEMS

--[[
---@param player EntityPlayer
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, player)
    if player:HasWeaponType(WeaponType.WEAPON_KNIFE) and player:GetCollectibleNum(CollectibleType.COLLECTIBLE_DR_FETUS) > 0 then
        player:EnableWeaponType(WeaponType.WEAPON_KNIFE, false)
        player:EnableWeaponType(WeaponType.WEAPON_BOMBS, true)
    end
end, CacheFlag.CACHE_WEAPON)
]]

---@param bomb EntityBomb
mod:AddCallback(ModCallbacks.MC_POST_FIRE_BOMB, function(_, bomb)
    if not bomb.SpawnerEntity and bomb.SpawnerEntity ~= EntityType.ENTITY_PLAYER then return end
    local player = bomb.SpawnerEntity:ToPlayer()

    if player then
        local data = bomb:GetData()
        if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BRIMSTONE) > 0 then
            bomb:AddTearFlags(TearFlags.TEAR_BRIMSTONE_BOMB)
        end

        --[[
        if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MOMS_KNIFE) > 0 then
            data.IsMomsKnifeBomb = true
        end
        ]]
    end
end)

---@param bomb EntityBomb
mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, function(_, bomb)
    if not bomb.SpawnerEntity and bomb.SpawnerEntity ~= EntityType.ENTITY_PLAYER then return end
    local player = bomb.SpawnerEntity:ToPlayer()

    if player then
        local data = bomb:GetData()

        if bomb:IsDead() then
            if data.IsMomsKnifeBomb then
                for i = 1, 4 do
                    local newknife = player:FireKnife(player, 0, false, 0, 0)
                    newknife.Rotation = 90 * i
                    newknife:Shoot(1, 100)
                end
            end
        end
    end
end)
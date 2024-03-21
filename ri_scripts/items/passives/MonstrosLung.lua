local mod = REWORKEDITEMS

---@param tear EntityTear
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, function(_, tear)
    local player = tear.SpawnerEntity:ToPlayer() or tear.SpawnerEntity:ToFamiliar().Player
end)

---@param tear EntityTear
mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, function(_, tear)
    local player = tear.SpawnerEntity:ToPlayer() or tear.SpawnerEntity:ToFamiliar().Player

    tear:GetData().fallsped = tear:GetData().fallsped or tear.FallingSpeed
    
    if player and player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
        print("------------------------------------")
        print("Current: "..tear.FallingSpeed)
        print("Previous: "..tear:GetData().fallsped)

        tear:GetData().fallsped = tear.FallingSpeed
    end
end)
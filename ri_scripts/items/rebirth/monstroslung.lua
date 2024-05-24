local mod = REWORKEDITEMS

---@param tear EntityTear
function mod:MonstrosLungFireTear(tear)
    if not tear.SpawnerEntity then return end
    local player = tear.SpawnerEntity:ToPlayer()

    if player and player:HasWeaponType(WeaponType.WEAPON_MONSTROS_LUNGS) then
        tear:GetData().MonstrosLungRange = player.TearRange
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
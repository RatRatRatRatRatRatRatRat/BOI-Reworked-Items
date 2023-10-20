---@param familiar EntityFamiliar
REWORKEDITEMS:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, function(_, familiar)
    local data = familiar:GetData()
    local sprite = familiar:GetSprite()
    if data.IsCardinal == nil then
        data.IsCardinal = false
        data.Switch = true     
    end

    if (sprite:IsPlaying("FloatDown") or sprite:IsPlaying("FloatUp") or sprite:IsPlaying("FloatSide")) and not data.Switch then
        data.Switch = true
    end 

    if (sprite:IsPlaying("FloatShootDown") or sprite:IsPlaying("FloatShootUp") or sprite:IsPlaying("FloatShootSide")) and data.Switch then
        data.Switch = false
        data.IsCardinal = not data.IsCardinal
    end
end, FamiliarVariant.LIL_LOKI)

---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_TEAR_INIT, function(_, tear)
    if tear.SpawnerEntity and tear.SpawnerType == EntityType.ENTITY_FAMILIAR and tear.SpawnerVariant == FamiliarVariant.LIL_LOKI then
        local familiar = tear.SpawnerEntity:ToFamiliar()
        if familiar:GetData().IsCardinal then
            tear.Velocity = tear.Velocity:Rotated(45)
        end
        tear.CollisionDamage = 4
    end
end)
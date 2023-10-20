local mindistance = 72

---@param familiar EntityFamiliar
REWORKEDITEMS:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, function(_, familiar)
    local target = familiar.Target
    if target and target.Type ~= EntityType.ENTITY_PLAYER and target.Position:Distance(familiar.Position) < mindistance then
        target:AddBaited(EntityRef(familiar), 2)
    end
end, FamiliarVariant.ANGRY_FLY)
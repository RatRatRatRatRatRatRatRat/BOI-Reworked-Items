local fartradius = 50

---@param effect EntityEffect
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, effect)
    if not effect.Parent then return end
    if not effect.Parent.Type == EntityType.ENTITY_PLAYER then return end

    local player = effect.Parent:ToPlayer()

    local scale = math.min(effect.FrameCount / 60 + 1, 2)
    effect.SpriteScale = Vector(scale, scale)
    for _, entity in ipairs(Isaac.FindInRadius(effect.Position, scale * fartradius)) do
        if entity:IsVulnerableEnemy() and (entity.Position - effect.Position):Length() > fartradius then
            entity:AddPoison(EntityRef(player), 60, player.Damage)
        end
    end
end, EffectVariant.FART_RING)
---@param familiar EntityFamiliar
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_ENTITY_KILL, function(_, familiar)
    if familiar.Variant == FamiliarVariant.LEPROSY then
        local heart = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_HALF, familiar.Position, Vector.Zero, nil):ToPickup()
        heart.Timeout = 60
    end
end, EntityType.ENTITY_FAMILIAR)
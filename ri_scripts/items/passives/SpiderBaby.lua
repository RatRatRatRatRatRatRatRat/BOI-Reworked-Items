---@param player EntityPlayer
REWORKEDITEMS:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, CallbackPriority.LATE, function(_, player)
    player = player:ToPlayer()
    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SPIDERBABY) > 0 then
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIDERBABY)
        for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_SPIDER)) do
            print("A")
            print(entity.Velocity)
            print(entity.Position)
        end
    end
end, EntityType.ENTITY_PLAYER)
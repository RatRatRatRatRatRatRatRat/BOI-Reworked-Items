---@param player EntityPlayer
REWORKEDITEMS:AddPriorityCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, CallbackPriority.LATE, function(_, player)
    player = player:ToPlayer()
    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SPIDERBABY) > 0 then
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIDERBABY)
        for _ = 0, rng:RandomInt(3) do
            player:ThrowBlueSpider(Game():GetLevel():GetCurrentRoom():FindFreePickupSpawnPosition(player.Position, 0, true, false), Vector.Zero)
        end
    end
end, EntityType.ENTITY_PLAYER)
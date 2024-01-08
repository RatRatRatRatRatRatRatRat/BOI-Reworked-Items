local flyvariant = Isaac.GetEntityVariantByName("Fly Orbital [Transendence]")

Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_TRANSCENDENCE).Type = ItemType.ITEM_FAMILIAR
Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_TRANSCENDENCE).CacheFlags = CacheFlag.CACHE_FAMILIARS | CacheFlag.CACHE_FLYING

---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, player)
    player:CheckFamiliar(flyvariant, player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TRANSCENDENCE), player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_TRANSCENDENCE))
end, CacheFlag.CACHE_FAMILIARS)

---@param familiar EntityFamiliar
REWORKEDITEMS:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, function(_, familiar)
    familiar:AddToOrbit(0)
	familiar.OrbitDistance = Vector(25,20)
	familiar.OrbitSpeed = 0.045
end, flyvariant)

---@param familiar EntityFamiliar
REWORKEDITEMS:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, function(_, familiar)
    local player = familiar.Player
    if not player then
        player = Game():GetPlayer(0)
    end
	familiar.Velocity = familiar:GetOrbitPosition(player.Position + player.Velocity) - familiar.Position
end, flyvariant)
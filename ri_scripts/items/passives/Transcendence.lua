local numTranscendence = {}
local flyvariant = Isaac.GetEntityVariantByName("Fly Orbital [Transendence]")

---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
    local id = tostring(player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_TRANSCENDENCE):GetSeed())
    if numTranscendence[id] == nil then
        numTranscendence[id] = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TRANSCENDENCE)
    elseif numTranscendence[id] ~= player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TRANSCENDENCE) then
        numTranscendence[id] = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TRANSCENDENCE)
        player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS, true)
    end
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, function(_)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TRANSCENDENCE) > 0 then
            player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS, true)
        end
    end
end)

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
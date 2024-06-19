local playerhasfiredlist = {}

local tearstochange = {
    [TearVariant.BLUE] = true,
    [TearVariant.BLOOD] = true,
    [TearVariant.BELIAL] = true,
    [TearVariant.MULTIDIMENSIONAL] = true,
    [TearVariant.COIN] = true,
}

---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, function(_, tear)
    if tear.SpawnerType == EntityType.ENTITY_PLAYER then
        local player = tear.SpawnerEntity:ToPlayer()
        local id = tostring(player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_TOUGH_LOVE):GetSeed())
        if not playerhasfiredlist[id] then
            playerhasfiredlist[id] = true
            if player:HasCollectible(CollectibleType.COLLECTIBLE_TOUGH_LOVE) then
                if tearstochange[tear.Variant] then
                    tear:ChangeVariant(TearVariant.TOOTH)
                end
                tear.CollisionDamage = player.Damage * 3.2
            end
        end
    end
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
    for i = 0, Game():GetNumPlayers() - 1 do
        local id = tostring(Game():GetPlayer(i):GetCollectibleRNG(CollectibleType.COLLECTIBLE_TOUGH_LOVE):GetSeed())
        playerhasfiredlist[id] = false
    end
end)
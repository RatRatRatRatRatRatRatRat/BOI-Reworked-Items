
local pauseTime = -1

REWORKEDITEMS:AddCallback(ModCallbacks.MC_USE_ITEM, function(_, item, rng, player, flags, slot, data)
    MusicManager():PitchSlide(0)

    local room = Game():GetRoom()
    for ind = 0, room:GetGridSize() do
        local grid = room:GetGridEntity(ind)
        if grid and grid:GetType() == GridEntityType.GRID_DECORATION then
            local sprite = grid:GetSprite()
            sprite:Stop()
        end
    end

    pauseTime = 900
end, CollectibleType.COLLECTIBLE_PAUSE)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
    if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_PAUSE) then
        if player:GetFireDirection() ~= Direction.NO_DIRECTION then
            pauseTime = 0
        end
    end
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
    if pauseTime == 0 then
        MusicManager():PitchSlide(1)

        local room = Game():GetRoom()
        for ind = 1, room:GetGridSize() do
            local grid = room:GetGridEntity(ind)
            if grid and grid:GetType() == GridEntityType.GRID_DECORATION then
                local sprite = grid:GetSprite()
                sprite:Continue()
            end
        end
    end

    if pauseTime > -1 then
        pauseTime = pauseTime - 1
    end
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
    pauseTime = -1
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, effect)
    if pauseTime > 0 then
        if effect.FrameCount == 1 then
            if (effect.SpawnerType and effect.SpawnerType == EntityType.ENTITY_PLAYER) then
                effect:SetPauseTime(pauseTime)
            else
                effect:Remove()
            end
        end
    end
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_NPC_UPDATE, function(_, npc)
    if pauseTime > 0 then
        if npc.FrameCount == 1 then
            if (npc.SpawnerType and npc.SpawnerType == EntityType.ENTITY_PLAYER) then
                npc:SetPauseTime(pauseTime)
            else
                npc:Remove()
            end
        end
    end
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PROJECTILE_UPDATE, function(_, proj)
    if pauseTime > 0 then
        if proj.FrameCount == 1 then
            if (proj.SpawnerType and proj.SpawnerType == EntityType.ENTITY_PLAYER) then
                proj:SetPauseTime(pauseTime)
            else
                proj:Remove()
            end
        end
    end
end)
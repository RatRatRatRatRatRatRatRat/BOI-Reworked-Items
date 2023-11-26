
local pauseTime = -1

REWORKEDITEMS:AddCallback(ModCallbacks.MC_USE_ITEM, function(_, item, rng, player, flags, slot, data)
    if pauseTime == -1 then
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
    end
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

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, function(_, effect) --freeze if effect spawns while already paused
    if pauseTime > 0 then
        effect:SetPauseTime(pauseTime)
    end
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_NPC_INIT, function(_, npc) --freeze if projectile spawns while already paused
    if pauseTime > 0 then
        npc:SetPauseTime(pauseTime)
    end
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PROJECTILE_INIT, function(_, proj) --freeze if projectile spawns while already paused
    if pauseTime > 0 then
        proj:SetPauseTime(pauseTime)
    end
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, function(_, bomb) --new: bombs now freeze
    if bomb:GetPauseTime() == 0 and pauseTime > -1 then
        bomb:SetPauseTime(pauseTime)
    end

    if pauseTime > 0 then
        bomb:GetSprite():Stop()

        bomb.Velocity = Vector.Zero --this makes bombs hard to push which isn't ideal. idk how to get megatroll bombs from not targetting the player otherwise
        bomb:SetExplosionCountdown(bomb:GetExplosionCountdown()+1)
    end

    if pauseTime == 0 then
        bomb:GetSprite():Continue()
    end
end)

--todo: make it so entities keep their original velocity after pausing and unpausing
---@param player EntityPlayer
---@param flags CacheFlag
REWORKEDITEMS:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, CallbackPriority.LATE, function(_, player, flags)
    if player:GetPlayerType() == PlayerType.PLAYER_APOLLYON or player:GetPlayerType() == PlayerType.PLAYER_APOLLYON_B then
        if flags & CacheFlag.CACHE_DAMAGE > 0 then
            local mult = REWORKEDITEMS:GetDamageMultiplier(player)
            if player.Damage > 3.5 * mult then
                player.Damage = 3.5 * mult + (player.Damage - 3.5 * mult) * 0.75
            end
        end
        if flags & CacheFlag.CACHE_FIREDELAY > 0 then
            local mult = REWORKEDITEMS:GetTearMultiplier(player)
            local tears = 30 / (player.MaxFireDelay + 1)
            if tears > (30/11) * mult then
                tears = (30/11) * mult + (tears - (30/11) * mult) * 0.75
                player.MaxFireDelay = (30 / tears) - 1
            end
        end
        if flags & CacheFlag.CACHE_SPEED > 0 then
            local mult = REWORKEDITEMS:GetSpeedMultiplier(player)
            if player.MoveSpeed > mult then
                player.MoveSpeed = mult + (player.MoveSpeed - mult) * 0.75
            end
        end
        if flags & CacheFlag.CACHE_RANGE > 0 then
            local mult = REWORKEDITEMS:GetRangeMultiplier(player)
            if player.TearRange > 260 * mult then
                player.TearRange = 260 * mult + (player.TearRange - 260 * mult) * 0.75
            end
        end
        if flags & CacheFlag.CACHE_SHOTSPEED > 0 then
            local mult = REWORKEDITEMS:GetShotSpeedMultiplier(player)
            if player.ShotSpeed > mult then
                player.ShotSpeed = mult + (player.ShotSpeed - mult) * 0.75
            end
        end
        if flags & CacheFlag.CACHE_LUCK > 0 then
            if player.Luck > 0 then
                player.Luck = player.Luck * 0.75
            end
        end
    end
end)

local mod = REWORKEDITEMS

---@param player EntityPlayer
---@param flags CacheFlag
mod:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, CallbackPriority.LATE - 20, function(_, player, flags)
    if player:GetPlayerType() == PlayerType.PLAYER_APOLLYON or player:GetPlayerType() == PlayerType.PLAYER_APOLLYON_B then
        if flags & CacheFlag.CACHE_DAMAGE > 0 then
            local mult = mod:GetDamageMultiplier(player)
            if player.Damage > 3.5 * mult then
                print(mult)
                print(player.Damage)
                player.Damage = 3.5 * mult + (player.Damage - 3.5 * mult) * 0.75
                print(player.Damage)
            end
        end
        if flags & CacheFlag.CACHE_FIREDELAY > 0 then
            local mult = mod:GetTearMultiplier(player)
            local tears = 30 / (player.MaxFireDelay + 1)
            if tears > (30/11) * mult then
                tears = (30/11) * mult + (tears - (30/11) * mult) * 0.75
                player.MaxFireDelay = (30 / tears) - 1
            end
        end
        if flags & CacheFlag.CACHE_SPEED > 0 then
            local mult = mod:GetSpeedMultiplier(player)
            if player.MoveSpeed > mult then
                player.MoveSpeed = mult + (player.MoveSpeed - mult) * 0.75
            end
        end
        if flags & CacheFlag.CACHE_RANGE > 0 then
            local mult = mod:GetRangeMultiplier(player)
            if player.TearRange > 260 * mult then
                player.TearRange = 260 * mult + (player.TearRange - 260 * mult) * 0.75
            end
        end
        if flags & CacheFlag.CACHE_SHOTSPEED > 0 then
            local mult = mod:GetShotSpeedMultiplier(player)
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

--[[
---@param player EntityPlayer
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, function(_, player)
    if player:GetType() == PlayerType.PLAYER_APOLLYON and Game():GetLevel():GetStage() > LevelStage.STAGE3_2 then
        player.CanFly = true
        player:AddCostume(Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_BIBLE))
    end
end, CacheFlag.CACHE_FLYING)
]]

---@param player EntityPlayer
local function AddFlight(_, player)
    if Game():GetLevel():GetStage() > LevelStage.STAGE3_2 and not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BIBLE) then
        player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_BIBLE)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, AddFlight, PlayerType.PLAYER_APOLLYON)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_LEVEL, --[[YO!!!]] AddFlight, PlayerType.PLAYER_APOLLYON)
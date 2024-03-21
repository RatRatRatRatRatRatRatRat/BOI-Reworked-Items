local mod = REWORKEDITEMS
local portalvariant = Isaac.GetEntityVariantByName("Locust Portal")

Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_VOID).MaxCharges = 4

---@param rng RNG
---@param player EntityPlayer
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, function(_, _, rng, player)
    for _, pickup in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP)) do
        if pickup.Variant ~= PickupVariant.PICKUP_COLLECTIBLE and not pickup:ToPickup():IsShopItem() then
            pickup:Remove()
            Isaac.Spawn(EntityType.ENTITY_EFFECT, portalvariant, 0, pickup.Position, Vector.Zero, nil)
        end
    end

    player:AnimateCollectible(CollectibleType.COLLECTIBLE_VOID, "UseItem")
    return true
end, CollectibleType.COLLECTIBLE_VOID)

---@param player EntityPlayer
---@param flags CacheFlag
mod:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, CallbackPriority.LATE - 20, function(_, player, flags)
    if player:GetPlayerType() == PlayerType.PLAYER_APOLLYON or player:GetPlayerType() == PlayerType.PLAYER_APOLLYON_B then
        if flags & CacheFlag.CACHE_DAMAGE > 0 then
            local mult = mod:GetDamageMultiplier(player)
            if player.Damage > 3.5 * mult then
                player.Damage = 3.5 * mult + (player.Damage - 3.5 * mult) * 0.75
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

---@param npc EntityNPC
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, function(_, npc)
    if npc:IsEnemy() and PlayerManager.AnyoneIsPlayerType(PlayerType.PLAYER_APOLLYON) then
        local rng = npc:GetDropRNG()
        if rng:RandomFloat() < 0.1 then
            Isaac.Spawn(EntityType.ENTITY_EFFECT, portalvariant, 0, npc.Position, Vector.Zero, nil)
        end
    end
end)

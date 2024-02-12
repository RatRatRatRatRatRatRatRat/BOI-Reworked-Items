local mod = REWORKEDITEMS
local portalvariant = Isaac.GetEntityVariantByName("Locust Portal")

Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_VOID).MaxCharges = 4

---@param rng RNG
---@param player EntityPlayer
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, function(_, _, rng, player)
    for _, pickup in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP)) do
        pickup = pickup:ToPickup()
        if pickup.Variant ~= PickupVariant.PICKUP_COLLECTIBLE and not pickup:IsShopItem() and not pickup.Touched then
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

---@params tear EntityTear
mod:AddCallback(ModCallbacks.MC_POST_NPC_DEATH, function(_, npc)
    if npc:IsEnemy() and PlayerManager.AnyoneIsPlayerType(PlayerType.PLAYER_APOLLYON) then
        local rng = npc:GetDropRNG()
        if rng:RandomFloat() < 0.1 then
            Isaac.Spawn(EntityType.ENTITY_EFFECT, portalvariant, 0, npc.Position, Vector.Zero, nil)
        end
    end
end)

---@params effect EntityEffect
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, function(_, effect)
    local data = effect:GetData()
    data.maxflies = 3
    data.cooldown = 30
    effect.DepthOffset = -99
end, portalvariant)

---@params effect EntityEffect
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, effect)
    local sprite = effect:GetSprite()
    local data = effect:GetData()

    if sprite:IsFinished("Spawn") then
        sprite:Play("Idle")
    end

    if sprite:IsPlaying("Idle") then
        if sprite:IsOverlayPlaying() then
            if sprite:IsOverlayEventTriggered("Shoot") then
                local fly = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, 0, effect.Position, Vector.Zero, effect):ToFamiliar()
                fly:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
                fly:PickEnemyTarget(9999)
                fly:SetColor(Color(0, 0, 0, 1, 0.63, 0.38, 0.94), 30, 1, true, true)
            end
        else
            if data.maxflies == 0 then
                sprite:Play("Death")
            elseif data.cooldown > 0 then            
                data.cooldown = data.cooldown - 1
            else
                data.cooldown = 30
                data.maxflies = data.maxflies - 1
                sprite:PlayOverlay("SpawnOverlay", true)
            end
        end
    end

    if sprite:IsFinished("Death") then
        effect:Remove()
    end
end, portalvariant)

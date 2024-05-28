local mod = REWORKEDITEMS
local game = Game()
local config = Isaac.GetItemConfig()

config:GetCollectible(CollectibleType.COLLECTIBLE_VOID).MaxCharges = 3

---@param player EntityPlayer
function mod:ApollyonBattery(player)
    if not player:HasCollectible(CollectibleType.COLLECTIBLE_BATTERY) then
        player:AddInnateCollectible(CollectibleType.COLLECTIBLE_BATTERY, 1)
        player:RemoveCostume(config:GetCollectible(CollectibleType.COLLECTIBLE_BATTERY))
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.ApollyonBattery, PlayerType.PLAYER_APOLLYON)

---@param player EntityPlayer
function mod:VoidItems(type, rng, player, flags, slot, customdata)
    local indexes = {}
    for _, pickup in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP)) do
        pickup = pickup:ToPickup()
        if pickup.Variant ~= PickupVariant.PICKUP_COLLECTIBLE and pickup.Price == 0 then
            if pickup:CanReroll() then
                pickup:Remove()
                Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil)
                local rng = pickup:GetDropRNG()
                local fly = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, rng:RandomInt(5) + 1, pickup.Position, Vector.Zero, player):ToFamiliar()
                fly:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
                fly.Player = player
            end
        end
    end
    
    for _, pickup in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)) do
        pickup = pickup:ToPickup()
        if pickup.SubType ~= 0 and pickup.Price == 0 then
            local index = pickup.Index
            if index > 0 then
                if indexes[index] then
                    pickup:TryRemoveCollectible()
                else
                    player:SalvageCollectible(pickup)
                    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil)
                    indexes[index] = true
                end
            else
                player:SalvageCollectible(pickup)
                Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pickup.Position, Vector.Zero, nil)
            end
        end
    end

    local QueuedItemData = player.QueuedItem
    if QueuedItemData.Item then
        player:SalvageCollectible(QueuedItemData.Item.ID)
        QueuedItemData.Item = nil
        player.QueuedItem = QueuedItemData
    end

    player:AnimateCollectible(CollectibleType.COLLECTIBLE_VOID, "UseItem")
    return true
end

mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, mod.VoidItems, CollectibleType.COLLECTIBLE_VOID)




--[[

config:GetCollectible(CollectibleType.COLLECTIBLE_VOID).MaxCharges = 4
config:GetCollectible(CollectibleType.COLLECTIBLE_VOID).Type = ItemType.ITEM_PASSIVE

---@param player EntityPlayer
function mod:RenderVoid(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_VOID) then

    end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.RenderVoid)



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

]]
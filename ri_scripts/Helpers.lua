local Helpers = {}

---@param player EntityPlayer
---@param item CollectibleType
function Helpers.DoesPlayerHaveCollectibleEffect(player, item)
    if player:HasCollectible(item, false) then
        return true
    elseif player:GetEffects():HasCollectibleEffect(item) then
        return true
    else
        return false
    end
end

---@param player EntityPlayer
---@param item TrinketType
function Helpers.DoesPlayerHaveTrinketEffect(player, item)
    if player:HasTrinket(item, false) then
        return true
    elseif player:GetEffects():HasTrinketEffect(item) then
        return true
    else
        return false
    end
end

---@param item CollectibleType
function Helpers.DoesAnyPlayerHaveCollectibleEffect(item)
    for i = 0, Game():GetNumPlayers() -1 do
        local player = Game():GetPlayer(i)    
        if player:HasCollectible(item, false) then
            return true
        elseif player:GetEffects():HasCollectibleEffect(item) then
            return true
        end
    end
    return false
end

---@param player EntityPlayer
function Helpers.AddFireRate(player, amount)
    local tears = 30 / (player.MaxFireDelay + 1)
    player.MaxFireDelay = math.max((30 / (tears + amount)) - 1, -0.75)
end

---@param player EntityPlayer
function Helpers.MultiplyFireRate(player, amount)
    local tears = 30 / (player.MaxFireDelay + 1)
    player.MaxFireDelay = math.max((30 / (tears * amount)) - 1, -0.75)
end

---@param pickup PickupVariant
function Helpers.SpawnPickupFromItem(position, pickup, subtype)
    if not subtype then
        subtype = 0
    end
    local newposition = Game():GetRoom():FindFreePickupSpawnPosition(position, 1)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, pickup, subtype, newposition, Vector.Zero, nil)
end

---@param trinket TrinketType
function Helpers.TrySpawnTrinketFromItem(position, trinket)
    local pool = Game():GetItemPool()
    if pool:RemoveTrinket(trinket) == true then
        local newposition = Game():GetRoom():FindFreePickupSpawnPosition(position, 1)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, trinket, newposition, Vector.Zero, nil)
        return true
    else
        return false
    end
end

---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
    local data = player:GetData()
    local item = player.QueuedItem
    local id = 0
    local istouched = false
    if item.Item then
        id = item.Item.ID
        istouched = item.Touched
    end
    data.ReworkedItemsQueuedItem = data.ReworkedItemsQueuedItem or 0
    data.ReworkedItemsItemTouched = istouched or false
    if data.ReworkedItemsQueuedItem ~= id then
        if data.ReworkedItemsQueuedItem == 0 then
            data.ReworkedItemsQueuedItem = id
        else
            Isaac.RunCallbackWithParam(REWORKEDITEMS.Enums.Callbacks.POST_COLLECTIBLE_PICKUP, data.ReworkedItemsQueuedItem, player, data.ReworkedItemsItemTouched)
            data.ReworkedItemsQueuedItem = id
        end
    end
end)


--not quite cooked yet
---@param player EntityPlayer
function Helpers.AddFlatDamageUp(player, amount)
    local damage = player.Damage
    local multiplier = 1
    if damage > (3.5 * 1.2) and Helpers.DoesPlayerHaveTrinketEffect(player, TrinketType.TRINKET_CRACKED_CROWN) then
        multiplier = multiplier * 1.2
    end
    if Helpers.DoesPlayerHaveCollectibleEffect(player, CollectibleType.COLLECTIBLE_CRICKETS_HEAD)
    or Helpers.DoesPlayerHaveCollectibleEffect(player, CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM)
    or Helpers.DoesPlayerHaveCollectibleEffect(player, CollectibleType.COLLECTIBLE_BLOOD_OF_THE_MARTYR) 
    and player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL) then
        multiplier = multiplier * 1.5
    end
    if Helpers.DoesPlayerHaveCollectibleEffect(player, CollectibleType.COLLECTIBLE_ALMOND_MILK) then
        multiplier = multiplier * 0.3
    elseif Helpers.DoesPlayerHaveCollectibleEffect(player, CollectibleType.COLLECTIBLE_SOY_MILK) then
        multiplier = multiplier * 0.2      
    end
    if Helpers.DoesPlayerHaveCollectibleEffect(player, CollectibleType.COLLECTIBLE_20_20) then
        multiplier = multiplier * 0.8
    end
    if Helpers.DoesPlayerHaveCollectibleEffect(player, CollectibleType.COLLECTIBLE_EVES_MASCARA) then
        multiplier = multiplier * 2
    end
    if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_SUCCUBUS) then
        multiplier = multiplier * 1.5 ^ (player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_SUCCUBUS))
    end
    if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_STAR_OF_BETHLEHEM) then
        multiplier = multiplier * 1.5 ^ (player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_STAR_OF_BETHLEHEM))
    end
end

return Helpers
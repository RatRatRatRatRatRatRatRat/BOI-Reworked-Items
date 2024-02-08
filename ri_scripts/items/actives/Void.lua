local mod = REWORKEDITEMS
local json = require("json")

Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_VOID).MaxCharges = 4

local VoidStatsUp = {
    MoveSpeed = 0.2,
    FireRate = 0.5,
    Damage = 1,
    Range = 100,
    Luck = 1
}

local PlayerVoidedCollectibleData = {}

local function AddPlayerVoidData(player)
    local id = tostring(player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SAD_ONION):GetSeed())
    PlayerVoidedCollectibleData[id] = {
        Collectibles = {},
        Stats = {
            MoveSpeed = 0,
            FireRate = 0,
            Damage = 0,
            Range = 0,
            Luck = 0,
        },
    }
end

local function VoidItem(player, rng, item)
    local id = tostring(player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SAD_ONION):GetSeed())
    local stats = PlayerVoidedCollectibleData[id].Stats

    local stat1 = rng:RandomInt(1, 5)
    local stat2 = rng:RandomInt(1, 5)
    while stat2 == stat1 do
        stat2 = rng:RandomInt(1, 5)
    end 

    if stat1 == 1 or stat2 == 1 then
        stats.MoveSpeed = stats.MoveSpeed + VoidStatsUp.MoveSpeed
        player:AddCacheFlags(CacheFlag.CACHE_SPEED)
    end
    if stat1 == 2 or stat2 == 2 then
        stats.FireRate = stats.FireRate + VoidStatsUp.FireRate     
        player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY)
    end
    if stat1 == 3 or stat2 == 3 then
        stats.Damage = stats.Damage + VoidStatsUp.Damage
        player:AddCacheFlags(CacheFlag.CACHE_DAMAGE)
    end
    if stat1 == 4 or stat2 == 4 then
        stats.Range = stats.Range + VoidStatsUp.Range
        player:AddCacheFlags(CacheFlag.CACHE_RANGE)
    end
    if stat1 == 5 or stat2 == 5 then
        stats.Luck = stats.Luck + VoidStatsUp.Luck
        player:AddCacheFlags(CacheFlag.CACHE_LUCK)
    end
    player:EvaluateItems()
    table.insert(PlayerVoidedCollectibleData[id].Collectibles, item)
end

mod:AddPriorityCallback(ModCallbacks.MC_POST_GAME_STARTED, CallbackPriority.IMPORTANT, function(_, iscontinued)
    if mod:HasData() and iscontinued then
        PlayerVoidedCollectibleData = json.decode(mod:LoadData())
        local cache = CacheFlag.CACHE_DAMAGE | CacheFlag.CACHE_FIREDELAY | CacheFlag.CACHE_LUCK | CacheFlag.CACHE_RANGE | CacheFlag.CACHE_SPEED
        for _, player in pairs(PlayerManager.GetPlayers()) do
            player:AddCacheFlags(cache, true)
        end
    else
        PlayerVoidedCollectibleData = {}
    end
end)

mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT, function()
    mod:SaveData(json.encode(PlayerVoidedCollectibleData))
    PlayerVoidedCollectibleData = {}
end)

mod:AddCallback(ModCallbacks.MC_PLAYER_INIT_PRE_LEVEL_INIT_STATS, function(_, player)
    local id = tostring(player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SAD_ONION):GetSeed())
    if PlayerVoidedCollectibleData[id] == nil then
        AddPlayerVoidData(player)
    end
end)

---@param player EntityPlayer
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, function(_, item, _, player, flags)
    if flags & UseFlag.USE_VOID > 0 then 
        player:RemoveCostume(Isaac.GetItemConfig():GetCollectible(item))
        return true 
    end
end)

local blacklistoftheitems = {
    [CollectibleType.COLLECTIBLE_NULL] = true,
    [CollectibleType.COLLECTIBLE_DADS_NOTE] = true,
}

---@param rng RNG
---@param player EntityPlayer
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, function(_, _, rng, player)
    local id = tostring(player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SAD_ONION):GetSeed())
    if PlayerVoidedCollectibleData[id] == nil then
        AddPlayerVoidData(player)
    end
    local collectiblelist = PlayerVoidedCollectibleData[id].Collectibles

    local sillylist = {}

    for _, pedestal in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)) do
        pedestal = pedestal:ToPickup()
        local item = pedestal.SubType
        if not blacklistoftheitems[item] then
            if not pedestal:IsShopItem() then
                local options = pedestal.OptionsPickupIndex
                if options > 0 then
                    if sillylist[options] == nil or sillylist[options].Distance > player.Position:Distance(pedestal.Position) then
                        sillylist[options] = {
                            Item = item,
                            Distance = player.Position:Distance(pedestal.Position)
                        }
                    end
                else
                    VoidItem(player, rng, item)
                    rng:Next()
               end
                pedestal:Remove()
                Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, pedestal.Position, Vector.Zero, nil)    
             end
        end        
    end

    for _, sillierlist in pairs(sillylist) do
        VoidItem(player, rng, sillierlist.Item)
        rng:Next()
    end

    if not player:IsItemQueueEmpty() then
        local item = player.QueuedItem.Item.ID
        local queueItemData = player.QueuedItem
        if queueItemData.Item ~= nil and queueItemData.Item:IsCollectible() and not blacklistoftheitems[item] then
            queueItemData.Item = nil
            player.QueuedItem = queueItemData --thahanks guwah
            VoidItem(player, rng, item)
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_APOLLYON and player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
        if rng:RandomFloat() <= 0.1 then
            if #collectiblelist > 0 then
                local position = Game():GetRoom():FindFreePickupSpawnPosition(player.Position)
                Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, collectiblelist[rng:RandomInt(#collectiblelist) + 1], position, Vector.Zero, nil)
            end
        end
    end 

    player:EvaluateItems()
    player:AnimateCollectible(CollectibleType.COLLECTIBLE_VOID, "UseItem")
    mod:SaveData(json.encode(PlayerVoidedCollectibleData))
    return true
end, CollectibleType.COLLECTIBLE_VOID)

---@param player EntityPlayer
mod:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, CallbackPriority.LATE - 10, function(_, player, flags)
    local id = tostring(player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SAD_ONION):GetSeed())
    if PlayerVoidedCollectibleData[id] == nil then
        AddPlayerVoidData(player)
    end
    local stats = PlayerVoidedCollectibleData[id].Stats
    if flags & CacheFlag.CACHE_DAMAGE > 0 then
        local mult = REWORKEDITEMS:GetDamageMultiplier(player)
        player.Damage = player.Damage + stats.Damage * mult
    end
    if flags & CacheFlag.CACHE_FIREDELAY > 0 then
        local mult = REWORKEDITEMS:GetTearMultiplier(player)
        local tears = 30 / (player.MaxFireDelay + 1)
        tears = tears + stats.FireRate * mult
        player.MaxFireDelay = (30 / tears) - 1
    end
    if flags & CacheFlag.CACHE_SPEED > 0 then
        local mult = REWORKEDITEMS:GetSpeedMultiplier(player)
        player.MoveSpeed = player.MoveSpeed + stats.MoveSpeed * mult
    end
    if flags & CacheFlag.CACHE_RANGE > 0 then
        local mult = REWORKEDITEMS:GetRangeMultiplier(player)
        player.TearRange = player.TearRange + stats.Range * mult
    end
    if flags & CacheFlag.CACHE_LUCK > 0 then
        player.Luck = player.Luck + stats.Luck
    end
end)












---@param pickup EntityPickup
--you shpuld get a real hobbie nerd!!!!!!!!!!!!!!! >:(
REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_PICKUP_VOIDED, function(_, pickup, isblackrune)
    if not isblackrune and Isaac.GetItemConfig():GetCollectible(pickup.SubType).Type == ItemType.ITEM_ACTIVE then
        local sprite = pickup:GetSprite()
        local spritesheet = sprite:GetLayer(1):GetSpritesheetPath()
        pickup:Morph(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, CollectibleType.COLLECTIBLE_BREAKFAST, true, true)
        sprite:ReplaceSpritesheet(1, spritesheet, true)
    end
end, PickupVariant.PICKUP_COLLECTIBLE)
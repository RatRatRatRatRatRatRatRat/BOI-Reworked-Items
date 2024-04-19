local mod = REWORKEDITEMS
local game = Game()

local config = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_CLICKER)
config.MaxCharges = 4

local ClickerRoomCharge = {
    [RoomType.ROOM_NULL] = nil,
    [RoomType.ROOM_DEFAULT] = 4,
    [RoomType.ROOM_SHOP] = 8,
    [RoomType.ROOM_ERROR] = 4,
    [RoomType.ROOM_TREASURE] = 12,
    [RoomType.ROOM_BOSS] = 8,
    [RoomType.ROOM_MINIBOSS] = 6,
    [RoomType.ROOM_SECRET] = 8,
    [RoomType.ROOM_SUPERSECRET] = 8,
    [RoomType.ROOM_ARCADE] = 6,
    [RoomType.ROOM_CURSE] = 6,
    [RoomType.ROOM_CHALLENGE] = 12,
    [RoomType.ROOM_LIBRARY] = 12,
    [RoomType.ROOM_SACRIFICE] = 6,
    [RoomType.ROOM_DEVIL] = 12,
    [RoomType.ROOM_ANGEL] = 12,
    [RoomType.ROOM_DUNGEON] = nil,
    [RoomType.ROOM_BOSSRUSH] = nil,
    [RoomType.ROOM_ISAACS] = 6,
    [RoomType.ROOM_BARREN] = 6,
    [RoomType.ROOM_CHEST] = 6,
    [RoomType.ROOM_DICE] = 6,
    [RoomType.ROOM_BLACK_MARKET] = 12,
    [RoomType.ROOM_GREED_EXIT] = nil,
    [RoomType.ROOM_PLANETARIUM] = 12,
    [RoomType.ROOM_TELEPORTER] = nil,
    [RoomType.ROOM_TELEPORTER_EXIT] = nil,
    [RoomType.ROOM_SECRET_EXIT] = nil,
    [RoomType.ROOM_BLUE] = nil,
    [RoomType.ROOM_ULTRASECRET] = 12,
}

local ClickerCharge = 4

---@param rng RNG
---@param player EntityPlayer
---@param slot ActiveSlot
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, function(_, _, rng, player, flags, slot)
    local room = game:GetRoom()
    local level = game:GetLevel()
    local desc = level:GetCurrentRoomDesc()

    if not ClickerRoomCharge[desc.Data.Type] then return end
    if desc.GridIndex == 84 then return end --starting room

    local data
    local counter = 0
    repeat
        data = RoomConfigHolder.GetRandomRoom(rng:RandomInt(1000000000, 9999999999), true, desc.Data.StageID, desc.Data.Type, desc.Data.Shape, -1, -1, 0, 10, desc.AllowedDoors, desc.Data.Subtype)
        counter = counter + 1
    until data.Variant ~= desc.Data.Variant or counter > 999

    if data then
        for i = 0, room:GetGridSize() - 1 do
            room:RemoveGridEntityImmediate(i, 0, false)
        end
    
        for _, entity in pairs(Isaac.GetRoomEntities()) do
            if entity.Type > EntityType.ENTITY_FAMILIAR then
                entity:Remove()     
            end
        end

        desc.Data = data
        level:ChangeRoom(level:GetCurrentRoomIndex(), -1)
        player:UseActiveItem(CollectibleType.COLLECTIBLE_D7, UseFlag.USE_NOANIM)
    end

    if flags & UseFlag.USE_OWNED > 0 and slot then
        ClickerCharge = ClickerRoomCharge[desc.Data.Type]
    end

    ItemOverlay.Show(Giantbook.CLICKER)
    player:AnimateCollectible(CollectibleType.COLLECTIBLE_CLICKER, "UseItem")
    return true
end, CollectibleType.COLLECTIBLE_CLICKER)

mod:AddCallback(ModCallbacks.MC_PLAYER_GET_ACTIVE_MAX_CHARGE, function(_, _, player)
    return ClickerCharge
end, CollectibleType.COLLECTIBLE_CLICKER)
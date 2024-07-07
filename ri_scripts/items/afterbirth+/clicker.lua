local mod = REWORKEDITEMS
local game = Game()

local config = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_CLICKER)
config.MaxCharges = 3

---@param rng RNG
---@param player EntityPlayer
---@param slot ActiveSlot
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, function(_, _, rng, player, flags, slot)
    local room = game:GetRoom()
    local level = game:GetLevel()
    local desc = level:GetRoomByIdx(level:GetCurrentRoomIndex())

    if desc.Data.Type ~= RoomType.ROOM_DEFAULT then 
        player:AnimateCollectible(CollectibleType.COLLECTIBLE_CLICKER, "UseItem")
        return true 
    end
    if desc.GridIndex == 84 then
        player:AnimateCollectible(CollectibleType.COLLECTIBLE_CLICKER, "UseItem")
        return true 
    end
    if StageAPI and StageAPI.GetCurrentRoom() then
        ItemOverlay.Show(Giantbook.CLICKER)
        player:UseActiveItem(CollectibleType.COLLECTIBLE_D7, UseFlag.USE_NOANIM)
        player:AnimateCollectible(CollectibleType.COLLECTIBLE_CLICKER, "UseItem")
        return true 
    end

    local data
    local counter = 0
    repeat
        data = RoomConfigHolder.GetRandomRoom(rng:RandomInt(1000000000, 9999999999), true, desc.Data.StageID, desc.Data.Type, desc.Data.Shape, -1, -1, 0, 10, desc.AllowedDoors, desc.Data.Subtype)
        counter = counter + 1
    until data.Variant ~= desc.Data.Variant or counter > 999

    if data then
        for i = 0, room:GetGridSize() - 1 do
            if room:GetGridEntity(i) and not room:GetGridEntity(i):ToDoor() and not room:GetGridEntity(i):ToWall() then
                room:RemoveGridEntityImmediate(i, 0, false)
            end
        end
   
        for _, entity in pairs(Isaac.GetRoomEntities()) do
            if entity.Type > EntityType.ENTITY_FAMILIAR then
                entity:Remove()
            end
        end

        local index = level:GetCurrentRoomIndex()
        level:ChangeRoom(84, -1)
        desc.Data = data
        level:ChangeRoom(index, -1)

        player:UseActiveItem(CollectibleType.COLLECTIBLE_D7, UseFlag.USE_NOANIM)
    end

    ItemOverlay.Show(Giantbook.CLICKER)
    player:AnimateCollectible(CollectibleType.COLLECTIBLE_CLICKER, "UseItem")
    return true
end, CollectibleType.COLLECTIBLE_CLICKER)
local mod = REWORKEDITEMS
local game = Game()
local firstdoor = nil
local startcount = nil

mod:AddCallback(ModCallbacks.MC_POST_GRID_ENTITY_DOOR_UPDATE, function(_, door)
    if PlayerManager.FirstCollectibleOwner(CollectibleType.COLLECTIBLE_DUALITY, true) == nil then return end

    local level = game:GetLevel()
    local room = level:GetCurrentRoom()

    if door.TargetRoomType == RoomType.ROOM_DEVIL or door.TargetRoomType == RoomType.ROOM_ANGEL then
        if room:IsClear() then
            if room:IsCurrentRoomLastBoss() or game:IsGreedFinalBoss() then
                if not firstdoor then
                    firstdoor = door.Slot
                    print(door.Slot)
                end
                if firstdoor then
                    if level:GetRoomByIdx(GridRooms.ROOM_DEVIL_IDX, -1).VisitedCount == 0 then
                        if not startcount then
                            startcount = game:GetFrameCount()
                        end
                        if startcount == game:GetFrameCount() then
                            if door.Slot ~= firstdoor then
                                room:RemoveDoor(door.Slot)
                            end
                        end
                        if game:GetFrameCount() - startcount > 30 then
                            startcount = game:GetFrameCount()
                            level:GetRoomByIdx(GridRooms.ROOM_DEVIL_IDX, -1).Data = nil
                            if door.TargetRoomType == RoomType.ROOM_DEVIL then
                                door:SetRoomTypes(1, RoomType.ROOM_ANGEL)
                                level:InitializeDevilAngelRoom(true, false)
                            else
                                door:SetRoomTypes(1, RoomType.ROOM_DEVIL)
                                level:InitializeDevilAngelRoom(false, true)
                            end
                            door:GetSprite():Play('Opened', true)
                            level:GetRoomByIdx(GridRooms.ROOM_DEVIL_IDX, -1).SurpriseMiniboss = false
                        end
                    end
                end
            end
        end
    end
end)

mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function()
    if PlayerManager.FirstCollectibleOwner(CollectibleType.COLLECTIBLE_DUALITY, true) == nil then return end

    firstdoor = nil
    startcount = nil
end)
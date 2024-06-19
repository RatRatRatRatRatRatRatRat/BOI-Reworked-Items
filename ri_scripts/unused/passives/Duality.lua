local mod = REWORKEDITEMS
local game = Game()



mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, function()
    local room = game:GetRoom()
    if room:GetType() ~= RoomType.ROOM_BOSS then return end

    for slot = 0, DoorSlot.NUM_DOOR_SLOTS - 1 do
        local door = room:GetDoor(slot)
        if door and door.Desc and door.TargetRoomType == RoomType.ROOM_ANGEL or door.TargetRoomType == RoomType.ROOM_DEVIL then
            room:RemoveDoor(slot)        
        end
    end
    room:TrySpawnDevilRoomDoor(true, true)
end)

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function()
    local room = game:GetRoom()
    if room:GetType() ~= RoomType.ROOM_BOSS then return end

    for slot = 0, DoorSlot.NUM_DOOR_SLOTS - 1 do
        local door = room:GetDoor(slot)
        if door then  
            if door.Desc and door.TargetRoomType == RoomType.ROOM_ANGEL or door.TargetRoomType == RoomType.ROOM_DEVIL then
                room:RemoveDoor(slot)    
                print("A")
            end
        end
    end
    game:GetLevel():InitializeDevilAngelRoom(true, false)
    --room:TrySpawnDevilRoomDoor(false, true)
end)

--[[
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_GRID_ENTITY_DOOR_UPDATE, function(_, door)
    if not PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_DUALITY) then return end

    local room = Game():GetRoom()
    if not firstdoor then
        if room:IsCurrentRoomLastBoss() then
            if room:IsClear() then
                firstdoor = door.DoorSlot
                print(door.DoorSlot)
            end
        end
    end
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_UPDATE, function()
    if not PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_DUALITY) then return end

    local level = Game():GetLevel()
    local room = level:GetCurrentRoom()
    if firstdoor then
        if room:IsCurrentRoomLastBoss() then
            if room:IsClear() then
                local door = room:GetDoor(firstdoor);
                if level:GetRoomByIdx(-1, -1).VisitedCount == 0 then
                    if not startcount then
                        startcount = Game():GetFrameCount()
                    end
                    if Game():GetFrameCount() - startcount > 30 then
                        startcount = Game():GetFrameCount()
                        level:GetRoomByIdx(-1, -1).Data = nil
                        if door.TargetRoomType == 14 then
                            door:SetRoomTypes(1, 15)
                            level:InitializeDevilAngelRoom(true, false)
                        else door:SetRoomTypes(1, 14)
                            level:InitializeDevilAngelRoom(false, true)
                        end
                        door:GetSprite():Play('Opened', true)
                        level:GetRoomByIdx(-1, -1).SurpriseMiniboss = false
                    end
                end
            end
        end
    end
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function()
    firstdoor = nil;
    startcount = nil;
end)
]]
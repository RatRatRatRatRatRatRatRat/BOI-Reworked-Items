local function OnRender()
    local room = Game():GetRoom()
    local descriptor = Game():GetLevel():GetCurrentRoomDesc()
    if descriptor.SurpriseMiniboss and descriptor.Data.Type == RoomType.ROOM_SECRET then
        for i = 0, DoorSlot.NUM_DOOR_SLOTS do
            local door = room:GetDoor(i)
            if door ~= nil and door:GetVariant() == DoorVariant.DOOR_LOCKED_BARRED then
                door:SetVariant(DoorVariant.DOOR_LOCKED_DOUBLE)
                door:TryUnlock(Isaac.GetPlayer(0), true)
                SFXManager():Stop(SoundEffect.SOUND_UNLOCK00)
                door:SetLocked(true)
            end
        end
    end
end

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_RENDER, OnRender)
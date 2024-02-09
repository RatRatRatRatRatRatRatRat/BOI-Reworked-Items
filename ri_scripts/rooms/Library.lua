local mod = REWORKEDITEMS

mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, function(_)
    local room = Game():GetRoom()
    if room:IsFirstVisit() and room:GetType() == RoomType.ROOM_LIBRARY then
        for _, pickup in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE)) do
            pickup:ToPickup().OptionsPickupIndex = 1
        end
    end    
end)
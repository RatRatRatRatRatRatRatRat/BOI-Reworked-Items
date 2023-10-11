local manager = Game():GetPlayerManager()

---@param pickup EntityPickup
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, function(_, pickup)
    if not manager:AnyoneHasCollectible(CollectibleType.COLLECTIBLE_ACID_BABY) then return end
    local pillcolor = pickup.SubType
    if pillcolor > PillColor.PILL_GIANT_FLAG then
        pillcolor = pillcolor - PillColor.PILL_GIANT_FLAG
    end
    if pillcolor ~= PillColor.PILL_GOLD then
        Game():GetItemPool():IdentifyPill(pillcolor)
    end
end, PickupVariant.PICKUP_PILL)
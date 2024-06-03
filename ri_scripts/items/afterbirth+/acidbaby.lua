local mod = REWORKEDITEMS

---@param pickup EntityPickup
function mod:AcidBabyIdentifyPills(pickup)
    if not PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_ACID_BABY) then return end
    local pillcolor = pickup.SubType
    if pillcolor > PillColor.PILL_GIANT_FLAG then
        pillcolor = pillcolor - PillColor.PILL_GIANT_FLAG
    end
    if pillcolor ~= PillColor.PILL_GOLD then
        Game():GetItemPool():IdentifyPill(pillcolor)
    end
end

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.AcidBabyIdentifyPills, PickupVariant.PICKUP_PILL)
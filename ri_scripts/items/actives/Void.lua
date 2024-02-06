Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_VOID).MaxCharges = 4

---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, function(_, item, _, player, flags)
    if flags & UseFlag.USE_VOID > 0 then 
        player:RemoveCostume(Isaac.GetItemConfig():GetCollectible(item))
        return true 
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
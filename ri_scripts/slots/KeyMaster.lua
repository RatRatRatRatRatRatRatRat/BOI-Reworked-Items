local GoldenPrize = 1984

REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_SLOT_COLLISION, function(_, slot, player)
    if player.Type ~= EntityType.ENTITY_PLAYER then return end
    if slot:GetPrizeType() == GoldenPrize then return false end
    player = player:ToPlayer()

    if player:HasGoldenKey() and slot:GetState() == 1 then
        player:RemoveGoldenKey()
        local sprite = slot:GetSprite()
        sprite:ReplaceSpritesheet(2, "gfx/items/slots/slot_007_key_master_gold.png", true)
        sprite:Play("PayPrize")
        slot:SetState(GoldenPrize)
        return false
    end
end, SlotVariant.KEY_MASTER)

---@param slot EntitySlot
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_SLOT_UPDATE, function(_, slot)
    if slot:GetState() ~= GoldenPrize then return end

    local sprite = slot:GetSprite()
    if sprite:IsFinished("PayPrize") then
        sprite:Play("Prize")
    end

    if sprite:IsPlaying("Prize") then
        if sprite:IsEventTriggered("Prize") then
            local collectible = Game():GetItemPool():GetCollectible(ItemPoolType.POOL_KEY_MASTER, true, slot.DropSeed)
            local position = Game():GetRoom():FindFreePickupSpawnPosition(slot.Position + Vector(0, 80))
            slot:GetSprite():Play("Teleport")
            slot:SetState(4)
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, collectible, position, Vector.Zero, slot)    
        elseif sprite:IsFinished("Prize") then
            slot:SetState(4)
            sprite:Play("Teleport")
        end
    end
end, SlotVariant.KEY_MASTER)
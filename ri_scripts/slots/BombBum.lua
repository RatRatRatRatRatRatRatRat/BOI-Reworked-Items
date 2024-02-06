local GoldenPrize = 1984

REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_SLOT_COLLISION, function(_, slot, player)
    if player.Type ~= EntityType.ENTITY_PLAYER then return end
    if slot:GetPrizeType() == GoldenPrize then return false end  
    player = player:ToPlayer()

    if player:HasGoldenBomb() and slot:GetState() == 1 then
        player:RemoveGoldenBomb()
        local sprite = slot:GetSprite()
        sprite:ReplaceSpritesheet(2, "gfx/items/slots/slot_009_bomb_bum_gold.png", true)
        sprite:Play("PayPrize")
        slot:SetState(GoldenPrize)
        return false
    end
end, SlotVariant.BOMB_BUM)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_SLOT_UPDATE, function(_, slot)
    if slot:GetState() ~= GoldenPrize then return end

    local sprite = slot:GetSprite()
    if sprite:IsFinished("PayPrize") then
        sprite:Play("Prize")
    end

    if sprite:IsPlaying("Prize") then
        if sprite:IsEventTriggered("Prize") then
            local collectible = Game():GetItemPool():GetCollectible(ItemPoolType.POOL_BOMB_BUM, true, slot.DropSeed)
            local position = Game():GetRoom():FindFreePickupSpawnPosition(slot.Position + Vector(0, 80))
            slot:GetSprite():Play("Teleport")
            slot:SetState(4)
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, collectible, position, Vector.Zero, slot)    
        elseif sprite:IsFinished("Prize") then
            slot:SetState(4)
            sprite:Play("Teleport")
        end
    end
end, SlotVariant.BOMB_BUM)
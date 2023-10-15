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
        slot:SetState(2)
        slot:SetPrizeType(GoldenPrize)
        return false
    end
end, SlotVariant.KEY_MASTER)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_SLOT_UPDATE, function(_, slot)
    if slot:GetPrizeType() ~= GoldenPrize then return end

    if slot:GetState() == 1 then
        slot:GetSprite():Play("Prize")
        slot:SetState(2)
    end
end, SlotVariant.KEY_MASTER)
local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:UseDevil(_, player)
    if player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL) > 1 then
        ItemOverlay:GetSprite():Stop(true)
    end
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseDevil, Card.CARD_DEVIL)
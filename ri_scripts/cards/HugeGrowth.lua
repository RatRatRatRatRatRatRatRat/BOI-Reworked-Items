local mod = REWORKEDITEMS
Isaac.GetItemConfig():GetCard(Card.CARD_HUGE_GROWTH).MimicCharge = 12

---@param player EntityPlayer
---@param useflag UseFlag
function mod:PreUseHugeGrowth(_, player, useflag)
    player:UseActiveItem(CollectibleType.COLLECTIBLE_MEGA_MUSH)
    local peffect = player:GetEffects():GetCollectibleEffect(CollectibleType.COLLECTIBLE_MEGA_MUSH)
    peffect.Cooldown = peffect.Cooldown - 450
    player:AnimateCard(Card.CARD_HUGE_GROWTH, "UseItem")
    mod:TrySayAnnouncerLine(SoundEffect.SOUND_HUGE_GROWTH, useflag)
    return true
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_CARD, mod.PreUseHugeGrowth, Card.CARD_HUGE_GROWTH)
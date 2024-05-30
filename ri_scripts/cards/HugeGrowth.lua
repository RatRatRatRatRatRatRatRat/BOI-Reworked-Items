local mod = REWORKEDITEMS
Isaac.GetItemConfig():GetCard(Card.CARD_HUGE_GROWTH).MimicCharge = 12

---@param player EntityPlayer
---@param useflag UseFlag
function mod:UseHugeGrowth(_, player, useflag)
    player:UseActiveItem(CollectibleType.COLLECTIBLE_MEGA_MUSH)
    player:AnimateCard(Card.CARD_HUGE_GROWTH, "UseItem")
    mod:TrySayAnnouncerLine(SoundEffect.SOUND_HUGE_GROWTH, useflag)
    return true
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_CARD, mod.UseHugeGrowth, Card.CARD_HUGE_GROWTH)
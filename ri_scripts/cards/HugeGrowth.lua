Isaac.GetItemConfig():GetCard(Card.CARD_HUGE_GROWTH).MimicCharge = 12

---@param player EntityPlayer
---@param useflag UseFlag
REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_USE_CARD, function(_, _, player, useflag)
    player:UseActiveItem(CollectibleType.COLLECTIBLE_MEGA_MUSH)
    player:AnimateCard(Card.CARD_HUGE_GROWTH, "UseItem")
    REWORKEDITEMS:TrySayAnnouncerLine(SoundEffect.SOUND_HUGE_GROWTH, useflag)
    return true
end, Card.CARD_HUGE_GROWTH)
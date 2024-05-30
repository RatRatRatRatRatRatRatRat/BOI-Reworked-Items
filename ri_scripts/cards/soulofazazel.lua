local mod = REWORKEDITEMS
Isaac.GetItemConfig():GetCard(Card.CARD_SOUL_AZAZEL).MimicCharge = 12

---@param player EntityPlayer
function mod:UseSoulAzazel(_, player)
    player:SetMegaBlastDuration(player:GetMegaBlastDuration() + 225)
end
mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseSoulAzazel, Card.CARD_SOUL_AZAZEL)
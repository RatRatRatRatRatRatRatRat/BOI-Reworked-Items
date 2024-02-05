---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_USE_PILL, function(_, _, pillcolor, player, useflag)
    player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_IPECAC)
    player:AnimatePill(pillcolor, "UseItem")
    Game():GetHUD():ShowItemText("Horf!", "")
    if pillcolor > PillColor.NUM_PILLS then
        REWORKEDITEMS:TrySayAnnouncerLine(SoundEffect.SOUND_MEGA_HORF, useflag)
    else
        REWORKEDITEMS:TrySayAnnouncerLine(SoundEffect.SOUND_HORF, useflag)
    end
    return true
end, PillEffect.PILLEFFECT_HORF)
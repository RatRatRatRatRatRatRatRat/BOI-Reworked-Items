local ipecac = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_IPECAC)
local horf = Isaac.GetItemConfig():GetPillEffect(PillEffect.PILLEFFECT_HORF)

horf.MimicCharge = 3

---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_USE_PILL, function(_, _, pillcolor, player, useflag)
    local data = player:GetData()

    if not data.HasHorf then
        player:AddInnateCollectible(CollectibleType.COLLECTIBLE_IPECAC, 1)
        player:AnimatePill(pillcolor, "UseItem")
    
        data.HasHorf = true
    end

    Game():GetHUD():ShowItemText("Horf!", "")
    if pillcolor > PillColor.NUM_PILLS then
        REWORKEDITEMS:TrySayAnnouncerLine(SoundEffect.SOUND_MEGA_HORF, useflag)
        player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_MY_REFLECTION)
    else
        REWORKEDITEMS:TrySayAnnouncerLine(SoundEffect.SOUND_HORF, useflag)
    end
    return true
end, PillEffect.PILLEFFECT_HORF)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_ROOM_EXIT, function(_)
    for _, player in pairs(PlayerManager.GetPlayers()) do
        local data = player:GetData()

        if data.HasHorf then
            player:AddInnateCollectible(CollectibleType.COLLECTIBLE_IPECAC, -1)
            player:RemoveCostume(ipecac)

            data.HasHorf = false
        end
    end
end)
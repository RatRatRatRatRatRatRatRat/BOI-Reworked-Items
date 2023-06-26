---@param player EntityPlayer
REWORKEDITEMS:AddCallback(REWORKEDITEMS.Enums.Callbacks.POST_COLLECTIBLE_PICKUP, function(_, player, istouched)
    print("YEAH")
    player:UsePill(PillEffect.PILLEFFECT_PRETTY_FLY, PillColor.PILL_BLUE_BLUE, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
    player:StopExtraAnimation()
    SFXManager():Stop(SoundEffect.SOUND_THUMBSUP)
    player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS)
    player:EvaluateItems()
end, CollectibleType.COLLECTIBLE_TRANSCENDENCE)
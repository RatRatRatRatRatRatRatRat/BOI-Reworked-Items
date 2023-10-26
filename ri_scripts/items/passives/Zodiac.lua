local zodiacplayerevent = {}

---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
    if not player:HasCollectible(CollectibleType.COLLECTIBLE_ZODIAC) then return end
    local id = tostring(player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_ZODIAC):GetSeed())
    if not zodiacplayerevent[id] then
        if player:IsExtraAnimationFinished() == true then
            local item = player:GetZodiacEffect()
            player:AnimateCollectible(item, "Pickup")
            SFXManager():Play(SoundEffect.SOUND_POWERUP1)
            zodiacplayerevent[id] = true
        end
    end
end)

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, function(_)
    for i = 0, Game():GetNumPlayers() - 1 do
        local player = Game():GetPlayer(i)
        if player:HasCollectible(CollectibleType.COLLECTIBLE_ZODIAC) then
            zodiacplayerevent[tostring(player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_ZODIAC):GetSeed())] = false
        end
    end
end)
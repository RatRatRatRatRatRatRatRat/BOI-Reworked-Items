local mod = REWORKEDITEMS

---@param rng RNG
function mod:JudasDevilCardOverride(rng, card, playing, runes, runeonly)
    if PlayerManager.AnyoneIsPlayerType(PlayerType.PLAYER_JUDAS) then
        if card ~= Card.CARD_DEVIL and (not runeonly) then
            if rng:RandomFloat() < 0.1 then
                return Card.CARD_DEVIL
            end
        end     
    end
end
mod:AddCallback(ModCallbacks.MC_GET_CARD, mod.JudasDevilCardOverride)

---@param player EntityPlayer
function mod:JudasDevilCardStart(player)
    if player:GetPlayerType() == PlayerType.PLAYER_JUDAS then
        player:AddCard(Card.CARD_DEVIL)
    end
end
mod:AddCallback(ModCallbacks.MC_PLAYER_INIT_POST_LEVEL_INIT_STATS, mod.JudasDevilCardStart)
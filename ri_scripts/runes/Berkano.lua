---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_USE_CARD, function(_, _, player, _)
    local rng = player:GetCardRNG(Card.RUNE_BERKANO)
    local highest = math.min(4 + player.Luck, 12)

    local flies = rng:RandomInt(highest)
    local spiders = rng:RandomInt(highest)

    if flies > 0 then
       player:AddBlueFlies(flies, player.Position, player)
    end
    if spiders > 0 then
        for i = 1, spiders do
            player:ThrowBlueSpider(player.Position, player.Position + RandomVector())
        end
    end

    if FiendFolio then
        local skuzz = rng:RandomInt(highest) + 1
        if skuzz > 0 then
            for i = 1, skuzz do
		        FiendFolio.ThrowFriendlySkuzz(player, RandomVector() * 2)
            end
        end
    end
end, Card.RUNE_BERKANO)
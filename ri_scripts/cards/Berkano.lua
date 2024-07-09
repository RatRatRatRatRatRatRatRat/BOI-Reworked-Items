local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:UseBerkano(_, player, _)
    local rng = player:GetCardRNG(Card.RUNE_BERKANO)

    local flies = rng:RandomInt(4, 8)
    local spiders = rng:RandomInt(4, 8)

    if flies > 0 then
       player:AddBlueFlies(flies, player.Position, player)
    end
    if spiders > 0 then
        for i = 1, spiders do
            player:ThrowBlueSpider(player.Position, player.Position + RandomVector())
        end
    end

    if FiendFolio then
        local skuzz = rng:RandomInt(4, 8)
        if skuzz > 0 then
            for i = 1, skuzz do
		        FiendFolio.ThrowFriendlySkuzz(player, RandomVector() * 2)
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseBerkano, Card.RUNE_BERKANO)
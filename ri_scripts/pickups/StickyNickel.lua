local mod = REWORKEDITEMS

---@param coin EntityPickup
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, function(_, coin)
    if not coin.SubType == CoinSubType.COIN_STICKYNICKEL then return end

    if coin:GetSprite():IsPlaying("Touched") then
        coin.Timeout = -1
    end
end, PickupVariant.PICKUP_COIN)
local mod = REWORKEDITEMS

---@param coin EntityPickup
function mod:StopStickyNickelFading(coin)
    if not coin.SubType == CoinSubType.COIN_STICKYNICKEL then return end

    if coin:GetSprite():IsPlaying("Touched") then
        coin.Timeout = -1
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, mod.StopStickyNickelFading, PickupVariant.PICKUP_COIN)
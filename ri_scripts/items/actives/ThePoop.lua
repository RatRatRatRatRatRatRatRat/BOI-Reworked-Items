REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, function(_, collectible, rng, player, flags, slot, data)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_MIDAS_TOUCH) then
        REWORKEDITEMS:TryHoldPoop(player, 1)
    elseif player:HasCollectible(CollectibleType.COLLECTIBLE_HALLOWED_GROUND) then
        REWORKEDITEMS:TryHoldPoop(player, 16)
    elseif player:HasCollectible(CollectibleType.COLLECTIBLE_SKATOLE) then
        REWORKEDITEMS:TryHoldPoop(player, 12)
    elseif player:HasCollectible(CollectibleType.COLLECTIBLE_FIRE_MIND) then
        REWORKEDITEMS:TryHoldPoop(player, 13)
    elseif player:HasTrinket(TrinketType.TRINKET_MECONIUM) then
        REWORKEDITEMS:TryHoldPoop(player, 15)
    elseif player:HasTrinket(TrinketType.TRINKET_BROWN_CAP) then
        REWORKEDITEMS:TryHoldPoop(player, 14)
    elseif player:HasTrinket(TrinketType.TRINKET_PETRIFIED_POOP) then
        REWORKEDITEMS:TryHoldPoop(player, 11)
    else
        REWORKEDITEMS:TryHoldPoop(player, 0);
    end

    return true
end, CollectibleType.COLLECTIBLE_POOP)
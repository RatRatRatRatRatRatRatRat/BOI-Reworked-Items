REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, function(_, type, variant, subtype, _, _, _, seed)
	if type == EntityType.ENTITY_PICKUP and variant == PickupVariant.PICKUP_COIN and subtype == 0 then
        if PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_DADS_LOST_COIN) then	
            local rng = RNG()
	    	rng:SetSeed(seed)
		    if rng:RandomInt(1, 100) == 1 then
			    return {type, variant, CoinSubType.COIN_LUCKYPENNY, seed}
		    end
        end
	end
end)
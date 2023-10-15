REWORKEDITEMS:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, CallbackPriority.IMPORTANT, function(_, player)
    local effects = player:GetEffects()
    local data = player:GetData()
    local multi = 1
    local damage = 40

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BRIMSTONE) > 0 or
    player:GetCollectibleNum(CollectibleType.COLLECTIBLE_DR_FETUS) > 0 or
    player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MOMS_KNIFE) > 0 or
    player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TECH_X) > 0 or
    player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TECHNOLOGY) > 0 or
    player:GetPlayerType() == PlayerType.PLAYER_THEFORGOTTEN then
        damage = 2
    end

	if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_EVES_MASCARA) > 0 then
		multi = multi * 2.0
	end

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_20_20) > 0 then
		multi = multi * 0.8
	end

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_ALMOND_MILK) > 0 then
		multi = multi * 0.3
	elseif player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SOY_MILK) > 0 then
		multi = multi * 0.2
	end

	if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CRICKETS_HEAD) > 0 or
	   player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM) > 0 or
	   (player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BLOOD_OF_THE_MARTYR) > 0 and
		effects:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL) > 0)
	then
		multi = multi * 1.5
	end

    if REPENTOGON then
        multi = multi * player:GetD8DamageModifier()
        multi = multi * (1 + player:GetDeadEyeCharge() / 8)
    end

    REWORKEDITEMS:IsInHallowedCreep(player)
    REWORKEDITEMS:IsInHallowedGroundAura(player)
    if data.PeterModInStarAura and data.PeterModInStarAura > 0 then
        multi = multi * 1.8
    end
    if data.PeterModInHallowedCreep and data.PeterModInHallowedCreep > 0 then
        multi = multi * 1.2
    elseif data.PeterModInHallowedAura and data.PeterModInHallowedAura > 0 then
        multi = multi * 1.2
    end

	for _, familiar in ipairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.SUCCUBUS)) do
		if (player.Position - familiar.Position):Length() < 100 then
			multi = multi * 1.5
		end
	end

    local crown = player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN)
    if crown > 0 then
        if (player.Damage / (REWORKEDITEMS:GetDamageMultiplier(player) * crown)) > 3.5 then
            multi = multi * crown
        end
    end

    player.Damage = player.Damage - damage * multi

end, CacheFlag.CACHE_DAMAGE)

---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, function(_, tear)
    if tear.SpawnerType == EntityType.ENTITY_PLAYER then
        local player = tear.SpawnerEntity:ToPlayer()
        if player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) then
            local damage = player.Damage * 10
            if damage > 40 then
                damage = player.Damage * 5 + 20
            end
            tear.CollisionDamage = damage
            tear.Scale = math.sqrt((30 / (player.MaxFireDelay + 1)) * 3)
        end
    end
end)
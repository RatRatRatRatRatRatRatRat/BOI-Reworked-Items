REWORKEDITEMS:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, CallbackPriority.IMPORTANT, function(_, player)
    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_IPECAC) == 0 then return end

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
        multi = multi * 1.5
    end
    --[[
    if data.PeterModInHallowedCreep and data.PeterModInHallowedCreep > 0 then
        multi = multi * 1.2
    elseif data.PeterModInHallowedAura and data.PeterModInHallowedAura > 0 then
        multi = multi * 1.2
    end
    ]]

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

    if player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B then
        player.Damage = player.Damage - damage * multi * 0.75
    else
        player.Damage = player.Damage - damage * multi
    end

end, CacheFlag.CACHE_DAMAGE)

---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, function(_, tear)
    if tear.SpawnerEntity and tear.SpawnerType == EntityType.ENTITY_PLAYER then
        local player = tear.SpawnerEntity:ToPlayer()
        if player and player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) then
            local mult = tear.CollisionDamage / player.Damage
            local damage = player.Damage * 10 * mult
            if damage > 40 then
                damage = player.Damage * 5 * mult + 20
            end
            tear.CollisionDamage = damage
            tear.Scale = (tear.Scale / player.Damage) * damage * 0.3
        end
    end
end)
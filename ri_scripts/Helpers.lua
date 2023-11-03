local mod = REWORKEDITEMS

---@param pickup PickupVariant
function mod:SpawnPickupFromItem(position, pickup, subtype)
    if not subtype then
        subtype = 0
    end
    local newposition = Game():GetRoom():FindFreePickupSpawnPosition(position, 1)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, pickup, subtype, newposition, Vector.Zero, nil)
end

---@param trinket TrinketType
function mod:TrySpawnTrinketFromItem(position, trinket)
    if Isaac.GetItemConfig():GetTrinket(trinket):IsAvailable() then
        if Game():GetItemPool():RemoveTrinket(trinket) == true then
            local newposition = Game():GetRoom():FindFreePickupSpawnPosition(position, 0, true, false)
            Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_TRINKET, trinket, newposition, Vector.Zero, nil)
            return true
        end
    end
    return false
end

local playerdamagemodifiers = {
    [PlayerType.PLAYER_CAIN] = 1.2,
    [PlayerType.PLAYER_JUDAS] = 1.35,
    [PlayerType.PLAYER_BLACKJUDAS] = 2,
    [PlayerType.PLAYER_BLUEBABY] = 1.05,
    [PlayerType.PLAYER_AZAZEL] = 1.5,
    [PlayerType.PLAYER_LAZARUS2] = 1.4,
    [PlayerType.PLAYER_KEEPER] = 1.5,
    [PlayerType.PLAYER_THEFORGOTTEN] = 1.5,

    [PlayerType.PLAYER_MAGDALENE_B] = 0.75,
    [PlayerType.PLAYER_CAIN_B] = 1.35,
    [PlayerType.PLAYER_EVE_B] = 1.2,
    [PlayerType.PLAYER_AZAZEL_B] = 1.5,
    [PlayerType.PLAYER_LAZARUS2_B] = 1.5,
    [PlayerType.PLAYER_THELOST_B] = 1.3,
    [PlayerType.PLAYER_THEFORGOTTEN_B] = 1.5,
}

---@param player EntityPlayer
function mod:GetDamageMultiplier(player)
	local data = player:GetData()
	local effects = player:GetEffects()
    local type = player:GetPlayerType()
	local multi = 1.0

    if playerdamagemodifiers[type] ~= nil then
        multi = multi * playerdamagemodifiers[type]
    elseif type == PlayerType.PLAYER_EVE
    and effects:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON) == 0 then
        multi = multi * 0.75
    end

	if effects:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_MEGA_MUSH) > 0 then
		multi = multi * 4.0
	end

	if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_EVES_MASCARA) > 0 then
		multi = multi * 2.0
	end

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_POLYPHEMUS) > 0 and
	   player:GetCollectibleNum(CollectibleType.COLLECTIBLE_20_20) == 0
	then
		multi = multi * 2.0
	end

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SACRED_HEART) > 0 then
		multi = multi * 2.3
	end

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_ALMOND_MILK) > 0 then
		multi = multi * 0.3
	elseif player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SOY_MILK) > 0 then
		multi = multi * 0.2
	end

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_IMMACULATE_HEART) > 0 then
		multi = multi * 1.2
	end

    if effects:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT) > 0 then
		multi = multi * 2.0
	end

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_HAEMOLACRIA) > 0 then
		multi = multi * 1.5
	end

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_20_20) > 0 then
		multi = multi * 0.8
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

    mod:IsInHallowedCreep(player)
    mod:IsInHallowedGroundAura(player)
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
        if (player.Damage / (multi * crown)) > 3.5 then
            multi = multi * crown
        end
    end

	return multi
end

---@param player EntityPlayer
function mod:GetTearMultiplier(player, tearsup)
    local data = player:GetData()
    local multi = 1.0

    --Brimstone
    if player:HasWeaponType(2) then
        if player:GetPlayerType() == PlayerType.PLAYER_AZAZEL and
        player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BRIMSTONE) == 0 then
            multi = multi * 0.267
        else
            multi = multi * 0.33
        end
    end

    --Dr. Fetus
    if player:HasWeaponType(5) then
        multi = multi * 0.4
    end

    --Lung
    if player:HasWeaponType(7) then
        multi = multi * 0.23
    end

    --Tech X
    if player:HasWeaponType(9) then
        if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MONSTROS_LUNG) > 0 then
            multi = multi * 0.32
        else
            multi = multi
        end
    end

    --Forgotten etc
    if player:HasWeaponType(10) then
      multi = multi * 0.5
    end

    --C section, Knife, Epic Fetus, Technology, Ludo and Sword doesn't change it?
    --Please report any unknown or forgotten synergy

    --Ipecac
    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_IPECAC) > 0 then
        if not player:HasWeaponType(2) and
        not player:HasWeaponType(4) and
        not player:HasWeaponType(5) and
        not player:HasWeaponType(6) and
        not player:HasWeaponType(8) and
        not player:HasWeaponType(9) and
        not player:HasWeaponType(10) and
        not player:HasWeaponType(13) and
        not player:HasWeaponType(14) then
            multi = multi * 0.33
        end
    end

    --Almond/Soy Milk
    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_ALMOND_MILK) > 0 then
      multi = multi * 4
    elseif player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SOY_MILK) > 0 then
      multi = multi * 5.5
    end

    if player:GetPlayerType() == PlayerType.PLAYER_EVE_B then
      multi = multi * 0.66
    end

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_EVES_MASCARA) > 0 then
      multi = multi * 0.66
    end

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_TECHNOLOGY_2) > 0 then
      multi = multi * 0.66
    end

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_INNER_EYE) > 0 and
        player:GetCollectibleNum(CollectibleType.COLLECTIBLE_20_20) == 0 then
      multi = multi * 0.51
    elseif player:GetEffects():HasNullEffect(NullItemID.ID_REVERSE_HANGED_MAN) and
        player:GetCollectibleNum(CollectibleType.COLLECTIBLE_20_20) == 0 then
      multi = multi * 0.51
    elseif player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MUTANT_SPIDER) > 0 and
        player:GetCollectibleNum(CollectibleType.COLLECTIBLE_20_20) == 0 then
      multi = multi * 0.42
    elseif player:GetCollectibleNum(CollectibleType.COLLECTIBLE_POLYPHEMUS) > 0 and
        player:GetCollectibleNum(CollectibleType.COLLECTIBLE_20_20) == 0 and
        not player:HasWeaponType(14) then
      multi = multi * 0.42
    end

    --Cards
    if player:GetEffects():HasNullEffect(NullItemID.ID_REVERSE_CHARIOT) then
      multi = multi * 4
    end

    --Misc
    if player:GetPlayerType() == PlayerType.PLAYER_JUDAS and
        player:GetCollectibleNum(CollectibleType.COLLECTIBLE_BIRTHRIGHT) > 0 and
        player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_DECAP_ATTACK) then
      multi = multi * 3
    end

    if REPENTOGON then
    local epiphora = player:GetEpiphoraCharge()
    if epiphora >= 270 then
        multi = multi * 2
    elseif epiphora >= 180 then
        multi = multi * (5/3)
    elseif epiphora >= 90 then
        multi = multi * (4/3)
    end

    multi = multi * player:GetD8FireDelayModifier()
    end

    mod:IsInHallowedCreep(player)
    mod:IsInHallowedGroundAura(player)

    if data.PeterModInStarAura and data.PeterModInStarAura > 0 then
        multi = multi * 2.5
    elseif data.PeterModInHallowedCreep and data.PeterModInHallowedCreep > 0 then
        multi = multi * 2.5
    elseif data.PeterModInHallowedAura and data.PeterModInHallowedAura > 0 then
        multi = multi * 2.5
    end

    return multi
end

---@param player EntityPlayer
function mod:AddFlatRange(player, range)
    local multi = 1

    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_NUMBER_ONE) > 0 then
        multi = multi * 0.8
    end
    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_CRICKETS_BODY) > 0 then
        multi = multi * 0.8
    end
    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_IPECAC) > 0 then
        multi = multi * 0.8 ---i have no idea what the multiplier is
    end
    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_MY_REFLECTION) > 0 then
        multi = multi * 2
    end
    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_HAEMOLACRIA) > 0 then
        multi = multi * 0.8
    end

    if REPENTOGON then
        multi = multi * player:GetD8RangeModifier()
    end

    local crown = player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN)
    if crown > 0 then
        if (player.TearRange / (40 * multi * crown)) > 6.5 then
            multi = multi * crown
        end
    end

    player.TearRange = player.TearRange + range * multi * 40
end

---@param player EntityPlayer
function mod:AddFlatSpeed(player, speed)
    local multi = 1

    if REPENTOGON then
        multi = multi * player:GetD8SpeedModifier()
    end

    local crown = player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN)
    if crown > 0 then
        if (player.MoveSpeed / (multi * crown)) > 1 then
            multi = multi * crown
        end
    end

    player.MoveSpeed = player.MoveSpeed + speed * multi
end

---@param player EntityPlayer
function mod:AddFlatShotSpeed(player, shotspeed)
    local multi = 1

    local crown = player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN)
    if crown > 0 then
        if (player.ShotSpeed / (multi * crown)) > 1 then
            multi = multi * crown
        end
    end

    player.ShotSpeed = player.ShotSpeed + shotspeed * multi
end


---@param player EntityPlayer
function mod:IsInHallowedGroundAura(player)
    local data = player:GetData()
    local hallowedaura = 0
    local staraura = 0
    data.PeterModInHallowedAura = data.PeterModInHallowedAura or 0
    data.PeterModInStarAura = data.PeterModInHallowedAura or 0

    for _, effect in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.HALLOWED_GROUND)) do
        if effect.Parent
        and (effect.Parent.Type == EntityType.ENTITY_POOP
        or effect.Parent.Type == EntityType.ENTITY_FAMILIAR
        and effect.Parent.Variant == FamiliarVariant.DIP) then
            local scale = ((effect.SpriteScale.X + effect.SpriteScale.Y) * 70 / 2) + player.Size
            if player.Position:Distance(effect.Position) < scale then
                hallowedaura = hallowedaura + 1
            end
        elseif effect.Parent
        and effect.Parent.Type == EntityType.ENTITY_FAMILIAR
        and effect.Parent.Variant == FamiliarVariant.STAR_OF_BETHLEHEM then
            local scale = 70 + player.Size
            if player.Position:Distance(effect.Position) < scale then
                staraura = staraura + 1
            end
        end
    end

    if hallowedaura ~= data.PeterModInHallowedAura then
        data.PeterModInHallowedAura = hallowedaura
    end
    if staraura ~= data.PeterModInStarAura then
        data.PeterModInStarAura = staraura
    end
end

---@param player EntityPlayer
function mod:IsInHallowedCreep(player)
    local data = player:GetData()
    local auranum = 0
    data.PeterModInHallowedCreep = data.PeterModInHallowedCreep or 0

    for _, effect in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.CREEP_LIQUID_POOP)) do
        effect = effect:ToEffect()
        local scale = ((effect.SpriteScale.X + effect.SpriteScale.Y) * 36 / 2)
        if effect.State == 64 and player.Position:Distance(effect.Position) <= scale then
            auranum = auranum + 1
        end
    end

    if auranum ~= data.PeterModInHallowedCreep then
        data.PeterModInHallowedCreep = auranum
    end
end

---@param player EntityPlayer
function mod:TryHoldPoop(player, poopVariant)
    local poop = Isaac.Spawn(EntityType.ENTITY_POOP, poopVariant, 0, player.Position, Vector.Zero, player)
    for i = 1, 20 do
        poop:Update()
    end
    player:TryHoldEntity(poop)
    SFXManager():Play(SoundEffect.SOUND_POOPITEM_HOLD)
end
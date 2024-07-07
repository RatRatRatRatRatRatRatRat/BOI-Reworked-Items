local mod = REWORKEDITEMS

local IpecacWeaponCheck = {
    [WeaponType.WEAPON_BRIMSTONE] = true,
    [WeaponType.WEAPON_LASER] = true,
    [WeaponType.WEAPON_KNIFE] = true,
    [WeaponType.WEAPON_BOMBS] = true,
    [WeaponType.WEAPON_LUDOVICO_TECHNIQUE] = true,
    [WeaponType.WEAPON_TECH_X] = true,
    [WeaponType.WEAPON_BONE] = true,
}

---@param player EntityPlayer
function mod:IpecacFlatDamage(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) then
        local weapon = player:GetWeapon(1)
        if weapon and not IpecacWeaponCheck[weapon:GetWeaponType()] then
            local mult = 1

            if player:HasCollectible(CollectibleType.COLLECTIBLE_20_20) then
                mult = mult * 0.8
            end      

            if player:HasCollectible(CollectibleType.COLLECTIBLE_ALMOND_MILK) then
                mult = mult * 0.3
            elseif player:HasCollectible(CollectibleType.COLLECTIBLE_SOY_MILK) then
                mult = mult * 0.2
            end

            if player:HasCollectible(CollectibleType.COLLECTIBLE_MAGIC_MUSHROOM)
            or player:HasCollectible(CollectibleType.COLLECTIBLE_CRICKETS_HEAD)
            or (player:HasCollectible(CollectibleType.COLLECTIBLE_BLOOD_OF_THE_MARTYR) 
            and player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_BOOK_OF_BELIAL)) then
                mult = mult * 1.5
            end

            for _, succubus in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.SUCCUBUS)) do
                if (player.Position - succubus.Position):Length() < 100 then
                    mult = mult * 1.5
                end
            end

            if player:HasCollectible(CollectibleType.COLLECTIBLE_EVES_MASCARA) then
                mult = mult * 2
            end

            if player:GetPlayerType() == PlayerType.PLAYER_BETHANY_B then
                mult = mult * 0.75
            end

            --repentogon ones

            if player:GetHallowedGroundCountdown() > 0 then
                mult = mult * 1.5
            end

            local crown = 1 + 0.2 * player:GetTrinketMultiplier(TrinketType.TRINKET_CRACKED_CROWN)
            if player.Damage / crown > 3.5 then
                mult = mult * crown
            end

            mult = mult * player:GetD8DamageModifier()
            mult = mult * (1 + player:GetDeadEyeCharge() / 8)

            player.Damage = player.Damage - 36 * mult
        end
    end
end

---@param player EntityPlayer
function mod:IpecacDamageMult(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) then
        player.Damage = player.Damage * 1.5
    end
end

---@param tear EntityTear
function mod:FireIpecacTear(tear)
    if not tear.SpawnerEntity and tear.SpawnerType ~= EntityType.ENTITY_PLAYER then return end
    local player = tear.SpawnerEntity:ToPlayer()

    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_IPECAC) then
        tear.Scale = tear.Scale * 2
    end
end

mod:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, CallbackPriority.EARLY, mod.IpecacFlatDamage, CacheFlag.CACHE_DAMAGE)
mod:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, CallbackPriority.LATE, mod.IpecacDamageMult, CacheFlag.CACHE_DAMAGE)
mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.FireIpecacTear)
local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:ShadeCache(player)
    local count = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SHADE)
    if count > 0 then
        local data = mod.GetPlayerData(player)
        if data.ShadeHits == nil then
            data.ShadeHits = 0
        end
        count = math.min(6, data.ShadeHits + count + player:GetEffects():GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_BOX_OF_FRIENDS) - 1)
        player:CheckFamiliar(FamiliarVariant.SHADE, count, player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SHADE))
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.ShadeCache, CacheFlag.CACHE_FAMILIARS)

---@param familiar EntityFamiliar
function mod:ShadeUpdate(familiar)
    familiar.State = 0
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.ShadeUpdate, FamiliarVariant.SHADE)

---@param player EntityPlayer
function mod:ShadeReset(player)
    local data = mod.GetPlayerData(player)
    if data.ShadeHits then
        data.ShadeHits = data.ShadeHits + 1
    else
        data.ShadeHits = 1
    end
    player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS, true)
end
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_TRIGGER_ROOM_CLEAR, mod.ShadeReset)

---@param entity Entity
function mod:ShadeTakeDMG(entity, _, flags)
    local player = entity:ToPlayer()

    if player and not (flags & DamageFlag.DAMAGE_NO_PENALTIES > 0) and player:HasCollectible(CollectibleType.COLLECTIBLE_SHADE) then
        mod.GetPlayerData(player).ShadeHits = 0
        for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.SHADE)) do
            local familiar = entity:ToFamiliar()
            if familiar and familiar.Player:GetPlayerIndex() == player:GetPlayerIndex() then
                local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF01, 0, familiar.Position, Vector.Zero, nil)
                poof.Color = Color(0, 0, 0, 1)
            end
        end
        player:AddCacheFlags(CacheFlag.CACHE_FAMILIARS, true)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TAKE_DMG, mod.ShadeTakeDMG, EntityType.ENTITY_PLAYER)
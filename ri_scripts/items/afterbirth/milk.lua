local mod = REWORKEDITEMS
Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_MILK).Quality = 2

---@param player EntityPlayer
function mod:MilkTearMult(player)
    local data = player:GetData()
    local ismilk = false

    for _, milk in pairs(Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_PUDDLE_MILK)) do
        local vector = player.Position - milk.Position
        vector.X = vector.X / 2
        if vector:LengthSquared() < 1000 * (milk.SpriteScale.X) then
            ismilk = true
            break
        end
    end

    if ismilk then
        if not data.MilkMultiplier then
            data.MilkMultiplier = true
            player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY, true)
        end
    elseif data.MilkMultiplier then
        data.MilkMultiplier = false
        player:AddCacheFlags(CacheFlag.CACHE_FIREDELAY, true)
    end
end

---@param player EntityPlayer
function mod:MilkCache(player)
    if player:GetData().MilkMultiplier then
        player.MaxFireDelay = player.MaxFireDelay / 2
    end
end

---@param effect EntityEffect
function mod:MilkUpdate(effect)
    effect.Timeout = math.max(270, effect.Timeout)
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.MilkTearMult)
mod:AddPriorityCallback(ModCallbacks.MC_EVALUATE_CACHE, CallbackPriority.LATE, mod.MilkCache, CacheFlag.CACHE_FIREDELAY)
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, mod.MilkUpdate, EffectVariant.PLAYER_CREEP_PUDDLE_MILK)
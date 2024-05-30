local mod = REWORKEDITEMS
local sfx = SFXManager()

---@param player EntityPlayer
function mod:LostInitMantle(player)
    local data = mod.GetPlayerData(player)
    data.HolyMantleCharged = true
end
mod:AddCallback(ModCallbacks.MC_PLAYER_INIT_POST_LEVEL_INIT_STATS, mod.LostInitMantle, PlayerType.PLAYER_THELOST)

---@param player EntityPlayer
function mod:PlayerUpdateMantle(player)
    local data = mod.GetPlayerData(player)
    if data.HolyMantleCharged == nil then
        data.HolyMantleCharged = true
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.PlayerUpdateMantle)

---@param player EntityPlayer
function mod:BlockMantle(player)
    if not player:IsCollectibleBlocked(CollectibleType.COLLECTIBLE_HOLY_WATER) then
        player:BlockCollectible(CollectibleType.COLLECTIBLE_HOLY_WATER)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.BlockMantle)

---@param player EntityPlayer
function mod:MantlePickup(id, charge, isfirst, slot, vardata, player)
    if isfirst then
        local data = mod.GetPlayerData(player)
        data.HolyMantleCharged = true
        local effects = player:GetEffects()
        if not effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) then
            effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
        end
    else
        local data = mod.GetPlayerData(player)
        data.HolyMantleCharged = true
        player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, mod.MantlePickup, CollectibleType.COLLECTIBLE_HOLY_MANTLE)

---@param player EntityPlayer
function mod:HolyMantleRemove(player)
    local data = mod.GetPlayerData(player)
    data.HolyMantleCharged = false
    --player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
end
mod:AddCallback(ModCallbacks.MC_POST_TRIGGER_COLLECTIBLE_REMOVED, mod.HolyMantleRemove, CollectibleType.COLLECTIBLE_HOLY_MANTLE)

---@param player EntityPlayer
function mod:MantleNewRoom(player)
    local data = mod.GetPlayerData(player)
    if not data.HolyMantleCharged then
        player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, mod.MantleNewRoom)

---@param player EntityPlayer
function mod:MantleRecharge(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_HOLY_MANTLE, false, true) then
        local data = mod.GetPlayerData(player)
        if not data.HolyMantleCharged then
            data.HolyMantleCharged = true
            player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_TRIGGER_ROOM_CLEAR, mod.MantleRecharge)

---@param player EntityPlayer
function mod:MantleRevive(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_HOLY_MANTLE, false, true) then
        local data = mod.GetPlayerData(player)
        data.HolyMantleCharged = true
        player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_REVIVE, mod.MantleRevive)

---@param player EntityPlayer
function mod:MantlePreventDamage(player)
    local effects = player:GetEffects()
    if player:GetDamageCooldown() == 0 and effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) then
        local data = mod.GetPlayerData(player)
        if data.HolyMantleCharged then
            data.HolyMantleCharged = false
        else
            if effects:GetNullEffectNum(NullItemID.ID_HOLY_CARD) <= effects:GetCollectibleEffectNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE) then
                effects:RemoveNullEffect(NullItemID.ID_HOLY_CARD)
            end
        end
        effects:RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)

        sfx:Play(SoundEffect.SOUND_HOLY_MANTLE)
        local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, 11, player.Position, player.Velocity, player):ToEffect()
        poof:FollowParent(player)
        poof.DepthOffset = 99

        player:SetMinDamageCooldown(60)
        return false
    end
end
mod:AddPriorityCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, CallbackPriority.LATE, mod.MantlePreventDamage)
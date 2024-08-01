local mod = REWORKEDITEMS
local game = Game()
local sfx = SFXManager()

---@param player EntityPlayer
function mod:PlayerHasMantle(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
    or (player:GetPlayerType() == PlayerType.PLAYER_THELOST and Isaac:GetPersistentGameData():Unlocked(Achievement.LOST_HOLDS_HOLY_MANTLE))
    or player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE) then
        return true
    else
        return false
    end
end

---@param player EntityPlayer
function mod:CheckMantle(player)
    if mod:PlayerHasMantle(player) then
        local data = mod.GetPlayerData(player) 
        local effects = player:GetEffects()
        if mod:PlayerHasMantle(player) then
            if data.HolyMantleCharged then
                if not effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) then
                    effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
                end
            else
                if effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) then
                    effects:RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
                end
                data.HolyMantleCharged = false
            end
        end
    end
end

function mod:MantleGameStart(iscontinued)
    if iscontinued then
        for _, player in pairs(PlayerManager.GetPlayers()) do
            mod:CheckMantle(player)
        end
    else
        for _, player in pairs(PlayerManager.GetPlayers()) do
            local data = mod.GetPlayerData(player)
            local effects = player:GetEffects()
            if mod:PlayerHasMantle(player) then
                data.HolyMantleCharged = true
                if not effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) then
                    effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
                end
            end
        end
    end
end

---@param player EntityPlayer
function mod:MantleRoomClear(player)
    local data = mod.GetPlayerData(player)
    if not data.HolyMantleCharged and mod:PlayerHasMantle(player) then
        data.HolyMantleCharged = true
        player:SetColor(Color(1, 1, 1, 1, 2, 2, 2), 3, 1, true, true)
        mod:CheckMantle(player)
    end
end

---@param npc EntityNPC
---@param coll Entity
function mod:TouchFireInnapropriately(npc, coll)
    -- 4: white fireplace
    if npc.Variant ~= 4 then return end

    local player = coll:ToPlayer()
    if player and (not player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE)) then
        mod.GetPlayerData(player).HolyMantleCharged = true
        local effects = player:GetEffects()
        if not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) then
            effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
        end
    end
end

---@param player EntityPlayer
function mod:PickupMantle(type, charge, firsttime, slot, vardata, player)
    if firsttime then
        mod.GetPlayerData(player).HolyMantleCharged = true
    end
end

---@param player EntityPlayer
---@param source EntityRef
function mod:MantlePreventDamage(player, _, flags, source)
    if flags & DamageFlag.DAMAGE_RED_HEARTS > 0 then return end
    if source and source.Type == EntityType.ENTITY_FIREPLACE and source.Variant == 4 then return end

    local data = mod.GetPlayerData(player)
    local effects = player:GetEffects()
    if player:GetDamageCooldown() == 0 
    and data.HolyMantleCharged 
    and effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
    and not player:HasInvincibility(flags) then
        player:SetMinDamageCooldown(60)
        data.HolyMantleCharged = false
        effects:RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
        sfx:Play(SoundEffect.SOUND_HOLY_MANTLE)

        local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, 11, player.Position, player.Velocity, player):ToEffect()
        if poof then
            poof:FollowParent(player)
            poof.DepthOffset = 99
        end

        return false
    end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.MantleGameStart)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, mod.CheckMantle)
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_TRIGGER_ROOM_CLEAR, mod.MantleRoomClear)
mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, mod.TouchFireInnapropriately, EntityType.ENTITY_FIREPLACE)
mod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, mod.PickupMantle, CollectibleType.COLLECTIBLE_HOLY_MANTLE)
mod:AddPriorityCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, CallbackPriority.LATE, mod.MantlePreventDamage)
--[[
---@param player EntityPlayer
function mod:MantleNewRoom(player)
    local data = mod.GetPlayerData(player)
    if data.HolyMantleCharged == nil then
        data.HolyMantleCharged = true
    end

    local effects = player:GetEffects()
    local hasmantle = false
    if player:GetPlayerType() == PlayerType.PLAYER_THELOST and Isaac:GetPersistentGameData():Unlocked(Achievement.LOST_HOLDS_HOLY_MANTLE) then
        hasmantle = true
    elseif effects:HasNullEffect(NullItemID.ID_LOST_CURSE) then
        hasmantle = true
    end

    if hasmantle then
        effects:RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE, -1)
    end

    if (player:HasCollectible(CollectibleType.COLLECTIBLE_HOLY_MANTLE, false, true) or hasmantle) and data.HolyMantleCharged == true then
        effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, mod.MantleNewRoom)

---@param player EntityPlayer
function mod:MantleRecharge(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_HOLY_MANTLE, false, true) or (player:GetPlayerType() == PlayerType.PLAYER_THELOST and Isaac:GetPersistentGameData():Unlocked(Achievement.LOST_HOLDS_HOLY_MANTLE)) then
        local data = mod.GetPlayerData(player)
        
        if not data.HolyMantleCharged then
            data.HolyMantleCharged = true

            player:SetColor(Color(1, 1, 1, 1, 2, 2, 2), 3, 1, true, true)
            player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_TRIGGER_ROOM_CLEAR, mod.MantleRecharge)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_REVIVE, mod.MantleRecharge)

---@param player EntityPlayer
---@param source EntityRef
function mod:MantlePreventDamage(player, _, flags, source)
    if flags & DamageFlag.DAMAGE_RED_HEARTS > 0 then return end
    if source and source.Type == EntityType.ENTITY_FIREPLACE and source.Variant == 4 then return end

    local data = mod.GetPlayerData(player)
    local effects = player:GetEffects()
    if player:GetDamageCooldown() == 0 and data.HolyMantleCharged and effects:HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) then
        player:SetMinDamageCooldown(60)
        data.HolyMantleCharged = false
        effects:RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
        sfx:Play(SoundEffect.SOUND_HOLY_MANTLE)

        local poof = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, 11, player.Position, player.Velocity, player):ToEffect()
        if poof then
            poof:FollowParent(player)
            poof.DepthOffset = 99
        end

        return false
    end
end
mod:AddPriorityCallback(ModCallbacks.MC_PRE_PLAYER_TAKE_DMG, CallbackPriority.LATE, mod.MantlePreventDamage)

---@param player EntityPlayer
function mod:MantlePickup(id, charge, isfirst, slot, vardata, player)
    if not isfirst then
        if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_HOLY_MANTLE, false, true) == 1 then
            mod.GetPlayerData(player).HolyMantleCharged = false
            player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
        else
            local data = mod.GetPlayerData(player)
            if not data.HolyMantleCharged then
                player:GetEffects():RemoveCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
            end
        end
    else
        mod.GetPlayerData(player).HolyMantleCharged = true
    end
end
mod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, mod.MantlePickup, CollectibleType.COLLECTIBLE_HOLY_MANTLE)

---@param npc EntityNPC
---@param coll Entity
function mod:TouchFireInnapropriately(npc, coll)
    -- 4: white fireplace
    if npc.Variant ~= 4 then return end

    local player = coll:ToPlayer()
    if player and (not player:GetEffects():HasNullEffect(NullItemID.ID_LOST_CURSE)) then
        mod.GetPlayerData(player).HolyMantleCharged = true
        local effects = player:GetEffects()
        if not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE) then
            effects:AddCollectibleEffect(CollectibleType.COLLECTIBLE_HOLY_MANTLE)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_COLLISION, mod.TouchFireInnapropriately, EntityType.ENTITY_FIREPLACE)
]]

--[[
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
]]
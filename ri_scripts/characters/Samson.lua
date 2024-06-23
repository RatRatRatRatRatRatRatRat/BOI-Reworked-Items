local mod = REWORKEDITEMS
local SamsonCollision = false

---@param player EntityPlayer
---@param coll Entity
function mod:SamsonCollision(player, coll)
    if player:GetPlayerType() == PlayerType.PLAYER_SAMSON then
        local npc = coll:ToNPC()

        if npc and npc:IsVulnerableEnemy() then
            if npc:GetDamageCountdown() == 0 then
                SamsonCollision = true
                npc:TakeDamage(12, DamageFlag.DAMAGE_COUNTDOWN, EntityRef(player), 15)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_COLLISION, mod.SamsonCollision)

---@param entity Entity
---@param source EntityRef
function mod:SamsonCollisionDamage(entity, amount, flags, source, countdown)
    if SamsonCollision then
        SamsonCollision = false
        return true 
    end

    local npc = entity:ToNPC()
    if npc and flags & DamageFlag.DAMAGE_COUNTDOWN > 0 and source and source.Entity and source.Entity.Type then
        local player = source.Entity:ToPlayer()
        if player and player:GetPlayerType() == PlayerType.PLAYER_SAMSON then
            SamsonCollision = true     
            entity:SetDamageCountdown(0)
            entity:TakeDamage(amount + 12, flags, source, countdown)
            return false
        end
    end
end
mod:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, mod.SamsonCollisionDamage)

--[[
---@param npc EntityNPC
mod:AddCallback(ModCallbacks.MC_POST_TAKE_DMG, function(_, npc)
    local player = npc:ToPlayer()
    if player and player:GetPlayerType() == PlayerType.PLAYER_SAMSON then
        game:GetLevel():SetStateFlag(LevelStateFlag.STATE_REDHEART_DAMAGED, false)
    end
end, EntityType.ENTITY_PLAYER)

---@param npc EntityNPC
---@param coll Entity
mod:AddCallback(ModCallbacks.MC_POST_NPC_COLLISION, function(_, npc, coll)
    local player = coll:ToPlayer()
    if player and npc:IsVulnerableEnemy() and player:GetPlayerType() == PlayerType.PLAYER_SAMSON and player:GetData().SamsonContactDamageCooldown == 0 then
        npc:TakeDamage(12, 0, EntityRef(player), 0)
        player:GetData().SamsonContactDamageCooldown = 15
    end
end)

---@param player EntityPlayer
function mod:PreSamsonClicker(_, rng, player, flags, slot)
    if player:GetPlayerType() == PlayerType.PLAYER_SAMSON then
        player:AddInnateCollectible(CollectibleType.COLLECTIBLE_BLOODY_LUST, -1)
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, mod.PreSamsonClicker, CollectibleType.COLLECTIBLE_CLICKER)
]]
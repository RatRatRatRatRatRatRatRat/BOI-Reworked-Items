local mod = REWORKEDITEMS
local game = Game()

---@param player EntityPlayer
function mod:SamsonInitLevelStats(player)
    player:RemoveCollectible(CollectibleType.COLLECTIBLE_BLOODY_LUST)
end

mod:AddCallback(ModCallbacks.MC_PLAYER_INIT_POST_LEVEL_INIT_STATS, mod.SamsonInitLevelStats, PlayerType.PLAYER_EVE)

---@param player EntityPlayer
function mod:SamsonPeffectUpdate(player)
    if player:GetPlayerType() == PlayerType.PLAYER_SAMSON then
        local data = player:GetData()
        if data.SamsonContactDamageCooldown then
            if data.SamsonContactDamageCooldown > 0 then
                data.SamsonContactDamageCooldown = data.SamsonContactDamageCooldown - 1
            end
        else
            data.SamsonContactDamageCooldown = 15
        end
        
        if not player:HasCollectible(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON) then
            player:AddInnateCollectible(CollectibleType.COLLECTIBLE_BLOODY_LUST, 1)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.SamsonPeffectUpdate, PlayerVariant.PLAYER)

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
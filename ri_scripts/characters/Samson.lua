local mod = REWORKEDITEMS
local game = Game()

local BloodLust = {
    Timer = 3600,
    MaxCount = 6,

    SamsonTimer = 2700,
    MaxCountBirthright = 14,
}

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, function(_, player)
    if player:GetPlayerType() == PlayerType.PLAYER_SAMSON then
        local data = player:GetData()
        if data.SamsonContactDamageCooldown then
            if data.SamsonContactDamageCooldown > 0 then
                data.SamsonContactDamageCooldown = data.SamsonContactDamageCooldown - 1
            end
        else
            data.SamsonContactDamageCooldown = 15
        end
    end
end)

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
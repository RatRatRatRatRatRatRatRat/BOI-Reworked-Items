local manager = Game():GetPlayerManager()

---@param npc EntityNPC
REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, function(_, npc)
    if npc:HasEntityFlags(EntityFlag.FLAG_SHRINK) and npc:IsDead() then
        return true
    end
end)
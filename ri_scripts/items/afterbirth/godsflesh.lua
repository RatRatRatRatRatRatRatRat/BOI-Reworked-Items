local mod = REWORKEDITEMS

---@param npc EntityNPC
function mod:GodsFleshStopDeathEffects(npc)
    if npc:HasEntityFlags(EntityFlag.FLAG_SHRINK) and npc:IsDead() then
        return true
    end
end

mod:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, mod.GodsFleshStopDeathEffects)

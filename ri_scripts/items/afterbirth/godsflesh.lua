local mod = REWORKEDITEMS

---@param npc EntityNPC
function mod:GodsFleshStopDeathEffects(npc)
    if npc:HasEntityFlags(EntityFlag.FLAG_SHRINK) == true and npc:IsDead() then
        if npc:IsChampion() then
            npc:Morph(npc.Type, npc.Variant, npc.SubType, ChampionColor.BROWN)
        end
        return true
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, mod.GodsFleshStopDeathEffects)

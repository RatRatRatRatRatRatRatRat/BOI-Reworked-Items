local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:SlownessImmunity(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_BURSTING_SACK) then
        player:ClearEntityFlags(EntityFlag.FLAG_SLOW)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.SlownessImmunity)

---@param npc EntityNPC
function mod:BurstingSackPreventDeathEffects(npc)
    if PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_BURSTING_SACK) and npc:IsDead() then
        if EntityConfig.GetEntity(npc.Type, npc.Variant, npc.SubType):HasEntityTags(EntityTag.SPIDER) then
            if npc:IsChampion() then
                npc:Morph(npc.Type, npc.Variant, npc.SubType, ChampionColor.BROWN)
            end
            return true
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, mod.BurstingSackPreventDeathEffects)
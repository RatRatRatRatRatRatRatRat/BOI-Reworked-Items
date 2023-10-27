local manager = Game():GetPlayerManager()

---@param npc EntityNPC
REWORKEDITEMS:AddCallback(ModCallbacks.MC_PRE_NPC_UPDATE, function(_, npc)
    if not manager:AnyoneHasCollectible(CollectibleType.COLLECTIBLE_SKATOLE) then return end
    if npc:IsDead() then
        local data = XMLData.GetEntityByTypeVarSub(npc.Type, npc.Variant).tags
        local strng = ""
        if data then
            for i = 1, #data do
                local charact = string.sub(data, i, i)
                if charact == " " then
                    strng = ""
                else
                    strng = strng..charact
                end

                if strng == "fly" then
                    return true
                end
            end
        end
    end
end)

---@param npc EntityNPC
REWORKEDITEMS:AddCallback(ModCallbacks.MC_NPC_UPDATE, function(_, npc)
    if not manager:AnyoneHasCollectible(CollectibleType.COLLECTIBLE_SKATOLE) then return end
    if npc.Type == EntityType.ENTITY_SUCKER and npc.Variant == 4 then
        -- if npc.State == NpcState.STATE_ATTACK then -- causes mama fly to move around randomly without spawning the nests
        --     npc.State = NpcState.STATE_IDLE
        --     npc.TargetPosition = Vector.Zero
        --     npc.I2 = 0
        --     npc.GridCollisionClass = GridCollisionClass.COLLISION_SOLID
        -- end
        npc.TargetPosition = Vector.Zero -- this causes mama fly to chase after isaac instead of move around randomly
    elseif npc.Type == EntityType.ENTITY_WILLO then
        if npc.State == NpcState.STATE_ATTACK then
            npc.State = NpcState.STATE_INIT -- i cant use idle since it doesnt recalculate the orbit, so init works lol
        end
    elseif npc.Type == EntityType.ENTITY_WILLO_L2 then
        npc.ProjectileCooldown = 45
    end
end)
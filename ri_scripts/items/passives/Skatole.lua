local flyblacklist = {
    [EntityType.ENTITY_BOOMFLY] = true,
    [EntityType.ENTITY_SUCKER] = true,
    [EntityType.ENTITY_WILLO] = true,
    [EntityType.ENTITY_WILLO_L2] = true,
}

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

--[[
    
---@param tear EntityProjectile
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PROJECTILE_INIT, function(_, tear)
    if not REWORKEDITEMS.Helpers.DoesAnyPlayerHaveCollectibleEffect(CollectibleType.COLLECTIBLE_SKATOLE) then return end
    if not tear.SpawnerEntity then return end
    if flyblacklist[tear.SpawnerType] and not tear.SpawnerEntity:HasEntityFlags(EntityFlag.FLAG_CHARM) then
       tear:Remove()
    end
end)

---@param effect EntityEffect
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, function(_, effect)
    if not REWORKEDITEMS.Helpers.DoesAnyPlayerHaveCollectibleEffect(CollectibleType.COLLECTIBLE_SKATOLE) then return end
    if effect.SpawnerEntity and effect.SpawnerType == EntityType.ENTITY_SUCKER then
        effect:Remove()
    end
end, EffectVariant.ENEMY_BRIMSTONE_SWIRL)
]]
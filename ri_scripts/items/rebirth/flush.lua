local mod = REWORKEDITEMS

mod.newflushables = {
    [EntityType.ENTITY_TURDLET] = {[0] = true},
    [EntityType.ENTITY_COLOSTOMIA] = {[0] = true},
    [EntityType.ENTITY_GURGLING] = {[2] = true},
}

function mod:MoreFlush()
    for _, npc in ipairs(Isaac.GetRoomEntities()) do
        if mod.newflushables[npc.Type] ~= nil then
            npc = npc:ToNPC()
            local sillylist = mod.newflushables[npc.Type]
            if sillylist[npc.Variant] then
                local sprite = npc:GetSprite()
                npc:KillUnique()
                sprite:Play("Flush")
                if not sprite:IsPlaying("Flush") then
                    sprite:Play("Death")
                    npc:Die()
                end
            end
        end
    end
end

REWORKEDITEMS:AddCallback(ModCallbacks.MC_USE_ITEM, mod.MoreFlush, CollectibleType.COLLECTIBLE_FLUSH)
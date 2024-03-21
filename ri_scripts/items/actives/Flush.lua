local newflushables = {
    [EntityType.ENTITY_TURDLET] = {[0] = true},
    [EntityType.ENTITY_COLOSTOMIA] = {[0] = true},
    [EntityType.ENTITY_GURGLING] = {[2] = true},
}

REWORKEDITEMS:AddCallback(ModCallbacks.MC_USE_ITEM, function()
    for _, npc in ipairs(Isaac.GetRoomEntities()) do
        if newflushables[npc.Type] ~= nil then
            npc = npc:ToNPC()
            local sillylist = newflushables[npc.Type]
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
end, CollectibleType.COLLECTIBLE_FLUSH)
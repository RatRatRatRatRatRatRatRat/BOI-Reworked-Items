---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
    if player:GetHeldEntity() then
        for _, slot in ipairs(Isaac.FindByType(EntityType.ENTITY_SLOT)) do
            slot:AddEntityFlags(EntityFlag.FLAG_HELD)
            if player:TryHoldEntity(slot) then
                return true
            else
                print("DESPAIR")
            end
        end
    end

    for _, slot in ipairs(Isaac.FindByType(EntityType.ENTITY_SLOT)) do
        slot:AddEntityFlags(EntityFlag.FLAG_HELD)
        if player:TryHoldEntity(slot) then
            return true
        else
            print("DESPAIR")
        end
    end
end)
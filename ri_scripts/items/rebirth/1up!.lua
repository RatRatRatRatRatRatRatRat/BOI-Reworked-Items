local mod = REWORKEDITEMS

--Lazarus Rags and Soul of Lazarus take priority.
---@param player EntityPlayer
function mod:OneUpRevive(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_1UP, false, true) 
    and not player:HasCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS, false, true) then
        local canrevive = true
        for i = PillCardSlot.PRIMARY, PillCardSlot.QUATERNARY do
            if player:GetCard(i) == Card.CARD_SOUL_LAZARUS then
                canrevive = false
                break
            end
        end

        if canrevive then
            player:Revive()

            --local level = Game():GetLevel()
            --level:ChangeRoom(level:GetPreviousRoomIndex())

            player:AnimateCollectible(CollectibleType.COLLECTIBLE_1UP)
            player:RemoveCollectible(CollectibleType.COLLECTIBLE_1UP)

            player:AddHearts(12)
            local maxhp = player:GetMaxHearts()
            if maxhp < 12 then
                player:AddSoulHearts(12 - maxhp)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_TRIGGER_PLAYER_DEATH, mod.OneUpRevive)
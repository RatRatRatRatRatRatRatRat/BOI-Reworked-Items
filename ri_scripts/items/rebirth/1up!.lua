local mod = REWORKEDITEMS
local game = Game()

---@param player EntityPlayer
function mod:OneUpAnimate(player)
    local data = player:GetData()
    if data.AnimateOneUp then
        data.AnimateOneUp = false
        player:AnimateCollectible(CollectibleType.COLLECTIBLE_1UP)
    end
end

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
            player:GetData().AnimateOneUp = true
            game:StartRoomTransition(game:GetLevel():GetLastRoomDesc().GridIndex, Direction.NO_DIRECTION)

            player:RemoveCollectible(CollectibleType.COLLECTIBLE_1UP)

            player:AddHearts(12)
            local maxhp = player:GetMaxHearts()
            if maxhp == 0 then
                player:AddSoulHearts(11)
            elseif maxhp < 12 then
                player:AddSoulHearts(12 - maxhp)
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, mod.OneUpAnimate)
mod:AddCallback(ModCallbacks.MC_PRE_TRIGGER_PLAYER_DEATH, mod.OneUpRevive)
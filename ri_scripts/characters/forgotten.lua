local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:ForgottenPeffectUpdate(player)
    local type = player:GetPlayerType()
    if type == PlayerType.PLAYER_THESOUL then
        local data = player:GetData()
        local soul = player:GetSubPlayer():GetMaxHearts()

        if soul == 0 then
            if not data.HasNoHearts then
                data.HasNoHearts = true
                player:AddInnateCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
            end
        else
            if data.HasNoHearts then
                data.HasNoHearts = false
                player:AddInnateCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT, -1)
            end
        end
    elseif type == PlayerType.PLAYER_THEFORGOTTEN then
        local data = player:GetData()
        local soul = player:GetMaxHearts()

        if soul == 0 then
            if not data.HasNoHearts then
                data.HasNoHearts = true
                player:AddInnateCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT)
            end
        else
            if data.HasNoHearts then
                data.HasNoHearts = false
                player:AddInnateCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT, -1)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.ForgottenPeffectUpdate)

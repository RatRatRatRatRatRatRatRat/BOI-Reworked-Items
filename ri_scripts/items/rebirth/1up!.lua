local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:PreRevive1UP(player)
    local count = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_1UP)
    if count > 0 then
        player:GetData().Num1UP = count
    end
end

---@param player EntityPlayer
function mod:Revive1UP(player)
    local count = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_1UP)
    local data = player:GetData()

    if count < data.Num1UP then
        print("WAHHH")
    end

    print()
end

mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_REVIVE,  mod.PreRevive1UP)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_REVIVE, mod.Revive1UP)
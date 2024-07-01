local mod = REWORKEDITEMS
local game = Game()

function mod:JudasBForceDevil()
    local IsJudasB = false
    for _, player in pairs(PlayerManager.GetPlayers()) do
        if player:GetPlayerType() == PlayerType.PLAYER_JUDAS_B then
            IsJudasB = true
            break
        end
    end

    if IsJudasB then
        game:AddDevilRoomDeal()
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.JudasBForceDevil)

---@param player EntityPlayer
function mod:JudasBNumberMagnet(player)
    if player:GetPlayerType() == PlayerType.PLAYER_JUDAS_B then
        player:AddSmeltedTrinket(TrinketType.TRINKET_NUMBER_MAGNET)
    end
end
mod:AddCallback(ModCallbacks.MC_PLAYER_INIT_POST_LEVEL_INIT_STATS, mod.JudasBNumberMagnet)
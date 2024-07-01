local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:LilithAdoptionPapersStart(player)
    if player:GetPlayerType() == PlayerType.PLAYER_LILITH then
        player:AddSmeltedTrinket(TrinketType.TRINKET_ADOPTION_PAPERS)
    end
end
--mod:AddCallback(ModCallbacks.MC_PLAYER_INIT_POST_LEVEL_INIT_STATS, mod.LilithAdoptionPapersStart)
local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:StopGlassBleeding(player)
    if player:HasEntityFlags(EntityFlag.FLAG_BLEED_OUT) then
        player:AddBleeding(EntityRef(player), -1) 
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_ADD_HEARTS, mod.StopGlassBleeding)
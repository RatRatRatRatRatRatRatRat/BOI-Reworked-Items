local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:BoneHeartHealthConversion(player, bones)
    if player:GetHealthType() == HealthType.SOUL then
        local bones
        if bones > 0 then
            for i = 1, bones * 8 do
                player:AddBoneOrbital(player.Position)
            end
            return(0)
        end
    end
end
mod:AddCallback(1009, mod.BoneHeartHealthConversion, AddHealthType.BONE)
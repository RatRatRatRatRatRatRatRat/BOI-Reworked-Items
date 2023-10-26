local hplist = {}

---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
    if player:GetCollectibleNum(CollectibleType.COLLECTIBLE_SHARD_OF_GLASS) == 0  then return end
    local id = tostring(player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SHARD_OF_GLASS):GetSeed())
    local extrahearts = (player:GetSoulHearts() + player:GetEternalHearts() + player:GetBoneHearts())
    if hplist[id] == nil then
        hplist[id] = extrahearts
    elseif hplist[id] < extrahearts then
        hplist[id] = extrahearts
        if player:HasEntityFlags(EntityFlag.FLAG_BLEED_OUT) then
            player:AddBleeding(EntityRef(player), -1)
        end
    else
        hplist[id] = extrahearts
    end
end)
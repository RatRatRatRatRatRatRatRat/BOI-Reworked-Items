local mod = REWORKEDITEMS
local config = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS)
config.Quality = 2

---@param player EntityPlayer
function mod:PlayerUpdateRags(player)
    local data = mod.GetPlayerData(player)
    if data.LazarusRags then
        player:AddCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS)
    end
    data.LazarusRags = false
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_INIT, mod.PlayerUpdateRags)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_LEVEL, mod.PlayerUpdateRags)

---@param player EntityPlayer
function mod:BlockRags(player)
    if not player:IsCollectibleBlocked(CollectibleType.COLLECTIBLE_LAZARUS_RAGS) then
        player:BlockCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.BlockRags)

---@param player EntityPlayer
function mod:RagsRevive(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS, false, true) then
        local data = mod.GetPlayerData(player)
        data.LazarusRags = true
        player:Revive()
        player:SetMinDamageCooldown(150)
        player:RemoveCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS)
        player:AddCostume(config)

        local maxhp = player:GetMaxHearts()
        if maxhp > 2 then
            player:AddMaxHearts(-2)
            if player:GetHealthType() == HealthType.COIN then
                player:AddHearts(1)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_TRIGGER_PLAYER_DEATH, mod.RagsRevive)
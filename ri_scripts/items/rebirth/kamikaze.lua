local mod = REWORKEDITEMS
local game = Game()
local kamikaze = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_KAMIKAZE)

local KamikazeMaxCooldown = 60
kamikaze.MaxCooldown = 0

---@param rng RNG
---@param player EntityPlayer
function mod:KamikazePreUseItem(_, rng, player)
    local data = player:GetData()
    if data.KamikazeCooldown ~= 0 then
        game:BombExplosionEffects(player.Position, 10, 0, Color.Defualt, player, 0.8)
        return true
    else
        data.KamikazeCooldown = KamikazeMaxCooldown
    end
end

mod:AddPriorityCallback(ModCallbacks.MC_PRE_USE_ITEM, CallbackPriority.EARLY, mod.KamikazePreUseItem, CollectibleType.COLLECTIBLE_KAMIKAZE)


---@param player EntityPlayer
function mod:KamikazePlayerUpdate(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_KAMIKAZE) then
        local data = player:GetData()
        data.KamikazeCooldown = data.KamikazeCooldown or 0
        if data.KamikazeCooldown > 0 then
            data.KamikazeCooldown = data.KamikazeCooldown - 1
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.KamikazePlayerUpdate)
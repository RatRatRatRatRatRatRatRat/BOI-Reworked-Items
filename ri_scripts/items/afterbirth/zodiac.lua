local mod = REWORKEDITEMS
local config = Isaac.GetItemConfig()

---@param player EntityPlayer
function mod:TryAnimateZodiac(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_ZODIAC) then
        player:GetData().AnimateZodiac = true
    end
end

---@param player EntityPlayer
function mod:AnimateZodiac(player)
    local data = player:GetData()
    if data.AnimateZodiac and player:IsExtraAnimationFinished() then
        data.AnimateZodiac = false
        player:AnimateCollectible(player:GetZodiacEffect())
        player:GetHeldSprite().Color = Color(1, 1, 1, 1, 0, 0, 0, 2, 2, 2, 1)     
    end
end

---@param player EntityPlayer
function mod:AnimateZodiacQuick(id, charge, isfirst, slot, vardata, player)
    player:AnimateCollectible(player:GetZodiacEffect())
    player:GetHeldSprite().Color = Color(1, 1, 1, 1, 0, 0, 0, 2, 2, 2, 1)
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_LEVEL, mod.TryAnimateZodiac)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.AnimateZodiac)
mod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, mod.AnimateZodiacQuick, CollectibleType.COLLECTIBLE_ZODIAC)
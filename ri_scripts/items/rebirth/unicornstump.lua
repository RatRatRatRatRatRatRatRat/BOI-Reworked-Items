local mod = REWORKEDITEMS
local game = Game()

local stump = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_UNICORN_STUMP)
stump.Type = ItemType.ITEM_PASSIVE

---@param player EntityPlayer
function mod:UnicornStumpRecharge(player)
    player:GetData().UnicornStump = false
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, mod.UnicornStumpRecharge)

--I love you sooooooooooooooooo much
---@param player EntityPlayer
---@param coll Entity
function mod:UnicornStumpCollision(player, coll)
    if coll:IsActiveEnemy() and player:HasCollectible(CollectibleType.COLLECTIBLE_UNICORN_STUMP) then
        local data = player:GetData()
        if not data.UnicornStump then
            player:UseActiveItem(CollectibleType.COLLECTIBLE_UNICORN_STUMP)
            data.UnicornStump = true
        end
    end
end
mod:AddPriorityCallback(ModCallbacks.MC_PRE_PLAYER_COLLISION, CallbackPriority.EARLY - 200, mod.UnicornStumpCollision, coll)
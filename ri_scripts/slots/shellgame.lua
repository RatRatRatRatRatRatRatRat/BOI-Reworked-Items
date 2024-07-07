local mod = REWORKEDITEMS
local game = Game()
local config = Isaac.GetItemConfig()
local pool = game:GetItemPool()



--[[
How Shell Game Rework would work:
>If skatole isnt in the pool, but any other item is or the beggar has selected an item already, manually add a 10% chance for the drop to be a collectible
>If the drop is a collectible, select a collectible (should be removed from the pool + data should be permanent)
>Render the collectible in the animation (or a question mark if curse of the unknown)
>Override the payout!! with the collectible (do it on collectible spawn)
]]


---@param slot EntitySlot
function mod:ShellGameUpdate(slot)
    local data = slot:GetData()
    local sprite = slot:GetSprite()
    --slot:SetPrizeType(100)

    if slot:GetState() == 2 then
        if not data.PrizeCollectible then
            data.PrizeCollectible = pool:GetCollectible(ItemPoolType.POOL_SHELL_GAME, false, slot:GetDropRNG():GetSeed())
            slot:SetPrizeCollectible(data.PrizeCollectible)
        end
        sprite:ReplaceSpritesheet(0, config:GetCollectible(data.PrizeCollectible).GfxFileName, true)
        print(sprite:GetLayer(0):GetSpritesheetPath())
    elseif slot:GetState() == 5 and slot:GetPrizeType() == PickupVariant.PICKUP_COLLECTIBLE and sprite:IsEventTriggered("Prize") then
        local collectible
        if not data.PrizeCollectible then
            collectible = pool:GetCollectible(ItemPoolType.POOL_SHELL_GAME, false, slot:GetDropRNG():GetSeed())
        else
            collectible = data.PrizeCollectible
            pool:RemoveCollectible(data.PrizeCollectible)
        end
        local position = Game():GetRoom():FindFreePickupSpawnPosition(slot.Position + Vector(0, 80))
        slot:SetState(4)
        Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, collectible, position, Vector.Zero, slot) 
        sprite:Play("Teleport")
        return true
    else
        data.PrizeCollectible = nil
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SLOT_UPDATE, mod.ShellGameUpdate, SlotVariant.SHELL_GAME)

---@param slot EntitySlot
function mod:NewShellGamePool(slot, id)
    if id ~= 0 then
        return pool:GetCollectible(ItemPoolType.POOL_SHELL_GAME, false, slot:GetDropRNG():GetSeed())
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SLOT_SET_PRIZE_COLLECTIBLE, mod.NewShellGamePool, SlotVariant.SHELL_GAME)
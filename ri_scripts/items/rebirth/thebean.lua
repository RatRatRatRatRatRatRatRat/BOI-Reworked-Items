local mod = REWORKEDITEMS
local game = Game()
local config = Isaac.GetItemConfig()
config:GetCollectible(CollectibleType.COLLECTIBLE_BEAN).Type = ItemType.ITEM_PASSIVE


---@param player EntityPlayer
function mod:BeanUseActive(id, rng, player, flags, slot)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_BEAN) and not (flags & UseFlag.USE_VOID > 0) and (flags & UseFlag.USE_OWNED > 0) then
        local item = config:GetCollectible(id)
        local charges = player:GetActiveCharge(slot)
        if item.ChargeType == 0 and item.MaxCharges > 0 and charges > 0 then
            game:Fart(player.Position, 85 * math.sqrt(charges), player, math.sqrt(charges))
        end
    end
end
mod:AddPriorityCallback(ModCallbacks.MC_PRE_USE_ITEM, CallbackPriority.LATE, mod.BeanUseActive)

--[[
---@param player EntityPlayer
function mod:BeanCooldown(player)
    local data = player:GetData()
    if data.BeanCooldown and data.BeanCooldown > 0 then
        data.BeanCooldown = data.BeanCooldown - 1
    end
end

mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, mod.BeanUseActive)

        local data = player:GetData()
        print(id)
        data.BeanCooldown = data.BeanCooldown or 0
        if data.BeanCooldown == 0 then
            data.BeanCooldown = 0
            
            local ret = Isaac.RunCallbackWithParam("MC_BEAN_ACTIVE", CollectibleType, player, id, flags)
            if ret == true then
                return true
            end
        end
]]

--[[
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.BeanCooldown)

---@param player EntityPlayer
function mod:BeanNormalEffect(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_BEAN) then
        player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_BLACK_BEAN)
    else
        game:Fart(player.Position, 85, player)
    end
end

mod:AddPriorityCallback("MC_BEAN_ACTIVE", CallbackPriority.LATE, mod.BeanNormalEffect)

---@param player EntityPlayer
function mod:BeanCookbook(player)
    Isaac.CreateTimer(function()
        local flags = player:GetBombFlags()
        if not (flags & TearFlags.TEAR_POISON > 0) then
            flags = flags | TearFlags.TEAR_POISON
        end
        local room = game:GetRoom()
        local position = room:FindFreePickupSpawnPosition(room:GetRandomTileIndex())
        local bomb = Isaac.Spawn(EntityType.ENTITY_BOMB, BombVariant.BOMB_TROLL, 0, position, Vector.Zero, player):ToBomb()
        if bomb then bomb:AddTearFlags(flags) end
    end, 6, 6, false)
end

---@param player EntityPlayer
function mod:BeanSynergyEffects(player, id, flags)
    if id == CollectibleType.COLLECTIBLE_BUTTER_BEAN then
        --not sure
        --the black butter bean synergy

    elseif id == CollectibleType.COLLECTIBLE_MAMA_MEGA then
        --big fart noises
        --poisons enemies with the wave effect thing
        --wave effect now green

    elseif id == CollectibleType.COLLECTIBLE_MEAT_CLEAVER then
        if flags & UseFlag.USE_CARBATTERY > 0 then
            Isaac.CreateTimer(function()
                game:Fart(player.Position + Vector(0, 80), 40, player, 0.4)
                game:Fart(player.Position + Vector(0, -80), 40, player, 0.4)                
                game:Fart(player.Position + Vector(80, 0), 40, player, 0.4)
                game:Fart(player.Position + Vector(-80, 0), 40, player, 0.4)
            end, 16, 1, false)
        else
            Isaac.CreateTimer(function()
                game:Fart(player.Position + Vector(0, 40), 60, player, 0.6)
                game:Fart(player.Position + Vector(0, -40), 60, player, 0.6)                
                game:Fart(player.Position + Vector(40, 0), 60, player, 0.6)
                game:Fart(player.Position + Vector(-40, 0), 60, player, 0.6)
            end, 8, 1, false)
        end

        return false

    elseif id == CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK then
        player:AnimateCollectible(CollectibleType.COLLECTIBLE_ANARCHIST_COOKBOOK, "UseItem")
        return true

    elseif id == CollectibleType.COLLECTIBLE_KIDNEY_BEAN then
        game:CharmFart(player.Position, 85, player)
        return true

    elseif config:GetCollectible(id).ChargeType ~= 0 then
        return false
    end
end

mod:AddCallback("MC_BEAN_ACTIVE", mod.BeanSynergyEffects)
]]
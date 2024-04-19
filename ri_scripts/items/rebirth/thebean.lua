local mod = REWORKEDITEMS
local game = Game()
local bean = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_BEAN)
bean.Type = ItemType.ITEM_PASSIVE

---@param player EntityPlayer
function mod:BeanUseActive(id, rng, player, flags, slot)
    if id ~= CollectibleType.COLLECTIBLE_BEAN and player:HasCollectible(CollectibleType.COLLECTIBLE_BEAN) and not (flags & UseFlag.USE_VOID > 0) and (flags & UseFlag.USE_OWNED > 0) then
        local data = player:GetData()
        data.BeanCooldown = data.BeanCooldown or 0
        if data.BeanCooldown == 0 then
            data.BeanCooldown = 30
            
            local ret = Isaac.RunCallbackWithParam("MC_BEAN_ACTIVE", CollectibleType, player, id)
            if ret == true then
                return true
            end
        end
    end
end

---@param player EntityPlayer
function mod:BeanCooldown(player)
    local data = player:GetData()
    if data.BeanCooldown and data.BeanCooldown > 0 then
        data.BeanCooldown = data.BeanCooldown - 1
    end
end

mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, mod.BeanUseActive)
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
function mod:BeanSynergyEffects(player, id)
    if id == CollectibleType.COLLECTIBLE_BUTTER_BEAN then
        --not sure
        --the black butter bean synergy

    elseif id == CollectibleType.COLLECTIBLE_MAMA_MEGA then
        --big fart noises
        --poisons enemies with the wave effect thing
        --wave effect now green

    elseif id == CollectibleType.COLLECTIBLE_MEAT_CLEAVER then
        Isaac.CreateTimer(function()
            game:Fart(player.Position + Vector(40, 0), 60, player, 0.6)
            game:Fart(player.Position + Vector(-40, 0), 60, player, 0.6)
        end, 8, 1, false)
        return false
    end
end

mod:AddCallback("MC_BEAN_ACTIVE", mod.BeanSynergyEffects)
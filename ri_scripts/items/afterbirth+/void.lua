local mod = REWORKEDITEMS
local config = Isaac.GetItemConfig()
config:GetCollectible(CollectibleType.COLLECTIBLE_VOID).MaxCharges = 4

---@param player EntityPlayer
function mod:VoidRoomEntry(player)
    local items = player:GetVoidedCollectiblesList()
    if #items > 0 then
        for _, id in pairs(items) do
            local item = config:GetCollectible(id)
            if item.ChargeType == ItemConfig.CHARGE_NORMAL then
                player:GetEffects():AddCollectibleEffect(id)
            end
        end        
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, mod.VoidRoomEntry)

function mod:PreUseVoid(_, _, _, flags)
    if flags & UseFlag.USE_VOID > 0 then
        return true
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, mod.PreUseVoid)

--[[
---@param player EntityPlayer
function mod:VoidDamageCache(player)
    local data = mod.GetPlayerData(player)
    if data.VoidDamageUps then
        player.Damage = player.Damage + data.VoidDamageUps
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.VoidDamageCache, CacheFlag.CACHE_DAMAGE)

---@param player EntityPlayer
function mod:VoidTearCache(player)
    local data = mod.GetPlayerData(player)
    if data.VoidDamageUps then
        local tears = 30 / (player.MaxFireDelay + 1)
        tears = tears + data.VoidDamageUps * 0.5
        player.MaxFireDelay = (30 / tears) - 1
    end
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.VoidTearCache, CacheFlag.CACHE_FIREDELAY)

---@param effect EntityEffect
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_INIT, function(_, effect)
    local data = effect:GetData()
    local rng = effect:GetDropRNG()

    data.maxflies = rng:RandomInt(5) + 1
    data.locustsubtype = rng:RandomInt(5) + 1

    if data.locustsubtype == LocustSubtypes.LOCUST_OF_WRATH then
        data.maxflies = 1
    else
        data.maxflies = rng:RandomInt(2) + 1
        if data.locustsubtype == LocustSubtypes.LOCUST_OF_CONQUEST then
            data.maxflies = data.maxflies * 2
        end
    end

    data.cooldown = 20
    effect.DepthOffset = -99
end, portalvariant)

---@param effect EntityEffect
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, effect)
    local sprite = effect:GetSprite()
    local data = effect:GetData()

    if sprite:IsFinished("Spawn") then
        sprite:Play("Idle")
    end

    if sprite:IsPlaying("Idle") then
        if sprite:IsOverlayPlaying() then
            if sprite:IsOverlayEventTriggered("Shoot") then
                for i = 0, data.maxflies - 1 do
                local fly = Isaac.Spawn(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLUE_FLY, data.locustsubtype, effect.Position, Vector(12, 0):Rotated(i * (360 / (data.maxflies))), effect):ToFamiliar()
                    fly:ClearEntityFlags(EntityFlag.FLAG_APPEAR)
                    fly:PickEnemyTarget(9999)
                    fly:SetColor(Color(0, 0, 0, 1, 0.63, 0.38, 0.94), 30, 1, true, true)
                end
                sprite:Play("Death")
                sprite:StopOverlay()
            end
        else
            if data.cooldown > 0 then            
                data.cooldown = data.cooldown - 1
            else
                data.cooldown = 30
                sprite:PlayOverlay("SpawnOverlay", true)
            end
        end
    end

    if sprite:IsFinished("Death") then
        effect:Remove()
    end
end, portalvariant)


--[[
    -- Watch for a Void absorbing active items
function EID:CheckVoidAbsorbs(_, _, player)
	local playerID = EID:getPlayerID(player)
	EID.absorbedItems[tostring(playerID)] = EID.absorbedItems[tostring(playerID)] or {}
	for _,v in ipairs(EID:VoidRoomCheck()) do
		EID.absorbedItems[tostring(playerID)][tostring(v)] = true
	end
	EID.RecheckVoid = true
end
EID:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, EID.CheckVoidAbsorbs, CollectibleType.COLLECTIBLE_VOID)
]]
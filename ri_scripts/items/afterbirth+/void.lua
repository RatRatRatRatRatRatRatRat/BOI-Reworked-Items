local mod = REWORKEDITEMS
local portalvariant = Isaac.GetEntityVariantByName("Locust Portal")

Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_VOID).MaxCharges = 2

---@param rng RNG
---@param player EntityPlayer
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, function(_, _, rng, player)
    for _, pickup in pairs(Isaac.FindByType(EntityType.ENTITY_PICKUP)) do
        pickup = pickup:ToPickup()
        if pickup.Variant ~= PickupVariant.PICKUP_COLLECTIBLE and not pickup:IsShopItem() then
            pickup:Remove()
            Isaac.Spawn(EntityType.ENTITY_EFFECT, portalvariant, 0, pickup.Position, Vector.Zero, nil)
        end
    end

    player:AnimateCollectible(CollectibleType.COLLECTIBLE_VOID, "UseItem")
    return true
end, CollectibleType.COLLECTIBLE_VOID)

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
local mod = REWORKEDITEMS

---@param heart EntityPickup
---@param coll Entity
function mod:LostHealthBoneHearts(heart, coll)
    local player = coll:ToPlayer()
    if player and player:GetHealthType() == HealthType.LOST then
        local subtype = heart.SubType
        if subtype == HeartSubType.HEART_FULL then

        elseif subtype == HeartSubType.HEART_ETERNAL then
            player:UseCard(Card.CARD_HOLY, UseFlag.USE_NOANIM | UseFlag.USE_NOANNOUNCER | UseFlag.USE_NOHUD)
        elseif subtype == HeartSubType.HEART_BONE then
            for _ = 1, 8 do
                player:AddBoneOrbital(player.Position)
            end
        elseif subtype == HeartSubType.HEART_ROTTEN then
            player:AddBlueFlies(8, player.Position, player)
        end

        heart:PlayPickupSound()
        heart:GetSprite():Play("Collect")
        heart:Die()
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PICKUP_COLLISION, mod.LostHealthBoneHearts, PickupVariant.PICKUP_HEART)

---@param player EntityPlayer
function mod:BoneHeartHealthConversion(player, bones, healthtype)
    if player:GetHealthType() == HealthType.LOST then
    end
end
mod:AddCallback(1009, mod.BoneHeartHealthConversion, AddHealthType.BONE)
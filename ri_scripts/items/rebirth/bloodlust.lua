local mod = REWORKEDITEMS
local game = Game()
local sfx = SFXManager()

--this is the stupidest table ive ever made
local BloodLustTimerFlashIntervals = {
    [30] = true,
    [60] = true,
    [90] = true,
    [150] = true,
    [300] = true,
}


---@param player EntityPlayer
function mod:UpdateBloodLustCounter(player)
    local data = player:GetData()
    player:SetBloodLustCounter(data.BloodLustCounter)
    player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_BLOODY_LUST)
    player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_BLOODY_GUST)   
end

---@param player EntityPlayer
function mod:BloodLustTimer(player)
    local data = player:GetData()
    data.BloodLustCounter = player:GetBloodLustCounter()

    if data.BloodLustCounter and data.BloodLustCounter > 0 then
        if data.BloodLustTimer and data.BloodLustTimer > 0 then
            data.BloodLustTimer = data.BloodLustTimer - 1
            if BloodLustTimerFlashIntervals[data.BloodLustTimer] then
                player:SetColor(Color(1, 1, 1, 1, 1, 0, 0), 2, 10, true, false)
            end
        else
            data.BloodLustCounter = data.BloodLustCounter - 1
            mod:UpdateBloodLustCounter(player)

            if data.BloodLustCounter > 0 then
                if player:GetPlayerType() == PlayerType.PLAYER_SAMSON then
                    data.BloodLustTimer = 45 * 30
                else
                    data.BloodLustTimer = 60 * 30
                end
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.BloodLustTimer)

---@param player EntityPlayer
function mod:BloodLustCounterReset(player)
    local data = player:GetData()

    if data.BloodLustCounter and data.BloodLustCounter > 0 then
        mod:UpdateBloodLustCounter(player)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_LEVEL, mod.BloodLustCounterReset)

---@param entity Entity
function mod:BloodLustTakeDmg(entity)
    local player = entity:ToPlayer()

    if player and (player:HasCollectible(CollectibleType.COLLECTIBLE_BLOODY_LUST) or player:HasCollectible(CollectibleType.COLLECTIBLE_BLOODY_GUST)) then
        local data = player:GetData()
        if player:GetPlayerType() == PlayerType.PLAYER_SAMSON then
            data.BloodLustTimer = 45 * 30
            if player:HasCollectible(CollectibleType.COLLECTIBLE_BIRTHRIGHT) then
                data.BloodLustCounter = math.min(14, data.BloodLustCounter + 1)
            else
                data.BloodLustCounter = math.min(6, data.BloodLustCounter + 1)          
            end
        else
            data.BloodLustTimer = 60 * 30
            data.BloodLustCounter = math.min(6, data.BloodLustCounter + 1)
        end
        mod:UpdateBloodLustCounter(player)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_TAKE_DMG, mod.BloodLustTakeDmg, EntityType.ENTITY_PLAYER)
local mod = REWORKEDITEMS

---@param player EntityPlayer
function mod:EveBPeffectUpdate(player)
    local data = player:GetData()
    data.ClotBoost = data.ClotBoost or 0
    data.ClotCounter = data.ClotCounter or 0

    local hearts = player:GetEternalHearts() + player:GetHearts() + player:GetSoulHearts() + player:GetBoneHearts()

    local clots = 0
    local index = player:GetPlayerIndex()
    for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLOOD_BABY)) do
        local familiar = entity:ToFamiliar()
        if familiar and familiar.Player and familiar.Player:GetPlayerIndex() == index then
            clots = clots + 1
        end
    end

    if player:GetShootingJoystick():Length() ~= 0 and hearts > 1 then
        local charge = player:GetEveSumptoriumCharge()

        if charge == 0 then
            data.ClotBoost = math.min(3, data.ClotBoost + 1)
            data.ClotCounter = 0
        else
            data.ClotCounter = data.ClotCounter + 1
            if data.ClotCounter >= (3 - data.ClotBoost) then
                data.ClotCounter = 0
                player:SetEveSumptoriumCharge(charge + 1)
            end
        end
    else
        data.ClotBoost = 0
        data.ClotCounter = 0
    end

    local effects = player:GetEffects()
    if clots == 0 and hearts <= 1 and not player:GetEffects():HasNullEffect(NullItemID.ID_BLOODY_BABYLON) then
        ItemOverlay.Show(Giantbook.WHORE_OF_BABYLON)
        effects:AddNullEffect(NullItemID.ID_BLOODY_BABYLON)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.EveBPeffectUpdate, PlayerType.PLAYER_EVE_B)

---@param player EntityPlayer
function mod:EveBRoomEffects(player)
    local clots = 0
    local index = player:GetPlayerIndex()
    for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLOOD_BABY)) do
        local familiar = entity:ToFamiliar()
        if familiar and familiar.Player and familiar.Player:GetPlayerIndex() == index then
            clots = clots + 1
            familiar.Position = player.Position
        end
    end

    if player:GetPlayerType() == PlayerType.PLAYER_EVE_B then
        local effects = player:GetEffects()
        if clots == 0 and player:GetEternalHearts() + player:GetHearts() + player:GetSoulHearts() + player:GetBoneHearts() <= 1 and not player:GetEffects():HasNullEffect(NullItemID.ID_BLOODY_BABYLON) then
            effects:AddNullEffect(NullItemID.ID_BLOODY_BABYLON)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, mod.EveBRoomEffects)

---@param familiar EntityFamiliar
function mod:ClotSpawn(familiar)
    if familiar.Player and familiar.Player:GetPlayerType() == PlayerType.PLAYER_EVE_B then
        local player = familiar.Player
        local effects = player:GetEffects()
        if effects:HasNullEffect(NullItemID.ID_BLOODY_BABYLON) then
            local clots = 0
            local index = player:GetPlayerIndex()
            for _, entity in pairs(Isaac.FindByType(EntityType.ENTITY_FAMILIAR, FamiliarVariant.BLOOD_BABY)) do
                local familiar = entity:ToFamiliar()
                if familiar and familiar.Player and familiar.Player:GetPlayerIndex() == index then
                    clots = clots + 1
                    familiar.Position = player.Position
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.ClotSpawn, FamiliarVariant.BLOOD_BABY)
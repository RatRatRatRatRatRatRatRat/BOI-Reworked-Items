local mod = REWORKEDITEMS
local game = Game()

function mod:FortuneMachinePlanetariumBoost(chance)
    if mod.Data.FortuneMachinePlanetariumBonus then
        return chance + 0.1
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PLANETARIUM_APPLY_ITEMS, mod.FortuneMachinePlanetariumBoost)

---@param slot EntitySlot
function mod:PreFortuneMachineUpdate(slot)
    if not Isaac.GetPersistentGameData():Unlocked(Achievement.PLANETARIUMS) then return end
    if mod.Data.FortuneMachinePlanetariumBonus then return end

    local sprite = slot:GetSprite()

    if sprite:IsEventTriggered("Prize") then
        local rng = slot:GetDropRNG()
        if rng:RandomFloat() < 0.1 then
            game:GetHUD():ShowFortuneText("The stars are calling")
            mod.Data.FortuneMachinePlanetariumBonus = true
            return true
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_SLOT_UPDATE, mod.PreFortuneMachineUpdate, SlotVariant.FORTUNE_TELLING_MACHINE)
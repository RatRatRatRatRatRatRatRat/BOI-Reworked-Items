local mod = REWORKEDITEMS

---@param familiar EntityFamiliar
function mod:DryBabyUpdate(familiar)
    local sprite = familiar:GetSprite()
    if sprite:IsFinished("Hit") then
        sprite:Play("Idle")
        local player = familiar.Player
        if player then
            player:UseActiveItem(CollectibleType.COLLECTIBLE_NECRONOMICON, UseFlag.USE_NOANIM | UseFlag.USE_NOHUD)
        end
        return true
    end
end

mod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_UPDATE, mod.DryBabyUpdate, FamiliarVariant.DRY_BABY)
local mod = REWORKEDITEMS
local sfx = SFXManager()

---@param player EntityPlayer
function mod:BlockPlacenta(player)
    if not player:IsCollectibleBlocked(CollectibleType.COLLECTIBLE_PLACENTA) then
        player:BlockCollectible(CollectibleType.COLLECTIBLE_PLACENTA)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.BlockPlacenta)

---@param player EntityPlayer
function mod:PlacentaHeal(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_PLACENTA, false, true) then
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_PLACENTA)
        if rng:RandomFloat() < 0.1 then
            player:AddHealth(1)

            local effect = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.HEART, 0, player.Position + Vector(0, -40), Vector.Zero, player):ToEffect()
            if effect then
                effect.DepthOffset = 999
            end
            sfx:Play(SoundEffect.SOUND_VAMP_GULP)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_TRIGGER_ROOM_CLEAR, mod.PlacentaHeal)

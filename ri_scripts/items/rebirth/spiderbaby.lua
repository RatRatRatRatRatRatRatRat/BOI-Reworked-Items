local mod = REWORKEDITEMS
local sfx = SFXManager()

---@param entity Entity
function mod:SpiderBabyTakeDmg(entity)
    local player = entity:ToPlayer()
    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_SPIDERBABY) then
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SPIDERBABY)
        for _ = 0, rng:RandomInt(3) do
            player:ThrowBlueSpider(Game():GetLevel():GetCurrentRoom():FindFreePickupSpawnPosition(player.Position, 0, true, false), Vector.Zero)
        end
        sfx:Play(SoundEffect.SOUND_BOIL_HATCH)
    end
end

mod:AddCallback(ModCallbacks.MC_POST_TAKE_DMG, mod.SpiderBabyTakeDmg, EntityType.ENTITY_PLAYER)
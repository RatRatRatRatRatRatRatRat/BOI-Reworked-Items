local mod = REWORKEDITEMS
local game = Game()

---@param rng RNG
---@param player EntityPlayer
function mod:LemonMishapPreUseItem(_, rng, player)
    local data = player:GetData()
    data.LemonMishapCount = data.LemonMishapCount + 12
    data.LemonMishapTimer = 0

    player:AnimateCollectible(CollectibleType.COLLECTIBLE_LEMON_MISHAP, "UseItem")
    return true
end

mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, mod.LemonMishapPreUseItem, CollectibleType.COLLECTIBLE_LEMON_MISHAP)

---@param player EntityPlayer
function mod:LemonMishapPlayerUpdate(player)
    local data = player:GetData()
    data.LemonMishapCount = data.LemonMishapCount or 0
    if data.LemonMishapCount > 0 then
        data.LemonMishapTimer = data.LemonMishapTimer or 30
        if data.LemonMishapTimer == 0 then
            local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, player.Position, Vector.Zero, nil):ToEffect()
            if creep then
                creep:GetSprite():ReplaceSpritesheet(0, "gfx/effects/effect_pisspool.png", true)
                creep.Timeout = 300
            end
            
            local pee = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TEAR_POOF_B, 0, player.Position, Vector.Zero, nil):ToEffect()
            if pee then
                pee.Color = Color(1, 1, 0, 1, 1, 1, 0)
                pee.DepthOffset = -99
            end

            data.LemonMishapCount = data.LemonMishapCount - 1
            data.LemonMishapTimer = 5
        else
            data.LemonMishapTimer = data.LemonMishapTimer - 1
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, mod.LemonMishapPlayerUpdate)
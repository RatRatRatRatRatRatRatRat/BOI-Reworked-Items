local mod = REWORKEDITEMS

local StevenTearVariantOverride = {
    [TearVariant.BLUE] = true,
    [TearVariant.BLOOD] = true,
    [TearVariant.BELIAL] = true,
}

---@param tear EntityTear
function mod:StevenFireTear(tear)
    if not tear.SpawnerEntity then return end
    local player = tear.SpawnerEntity:ToPlayer()
    if player and player:HasCollectible(CollectibleType.COLLECTIBLE_STEVEN) then
        if StevenTearVariantOverride[tear.Variant] then
            tear:ChangeVariant(TearVariant.MULTIDIMENSIONAL)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, mod.StevenFireTear)
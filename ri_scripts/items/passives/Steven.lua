local tearstochange = {
        [TearVariant.BLUE] = true,
        [TearVariant.BLOOD] = true,
        [TearVariant.BELIAL] = true,
}

---@param tear EntityTear
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_FIRE_TEAR, function(_, tear)
    if tear.SpawnerType == EntityType.ENTITY_PLAYER then
        local player = tear.SpawnerEntity:ToPlayer()
        if player:HasCollectible(CollectibleType.COLLECTIBLE_STEVEN) then
            if tearstochange[tear.Variant] then
                tear:ChangeVariant(TearVariant.MULTIDIMENSIONAL)
            end
        end
    end
end)
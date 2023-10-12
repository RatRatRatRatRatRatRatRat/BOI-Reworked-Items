local manager = Game():GetPlayerManager()

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_UPDATE, function(_)
    if not manager:AnyoneHasCollectible(CollectibleType.COLLECTIBLE_SPIDER_BUTT) then return end
    for _, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity.HitPoints <= 10 and entity:IsActiveEnemy() and not entity:IsInvincible() then
            entity:SetColor(Color(1, 1, 1, 1, 0.3, 0.3, 0.3), 1, 1, true, true)
        end
    end
end)
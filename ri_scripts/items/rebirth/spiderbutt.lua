local mod = REWORKEDITEMS

function mod:SpiderButtFlashWhite()
    if not PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_SPIDER_BUTT) then return end
    local frames = (math.sin(Game():GetFrameCount() / 4) + 1) * 0.15 + 0.1

    for _, entity in ipairs(Isaac.GetRoomEntities()) do
        if entity.HitPoints <= 10 and entity:IsActiveEnemy() and not entity:IsInvincible() then
            entity:SetColor(Color(1, 1, 1, 1, frames, frames, frames), 1, 1, true, true)
        end
    end
end

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.SpiderButtFlashWhite)
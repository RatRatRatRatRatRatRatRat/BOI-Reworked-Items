local mod = REWORKEDITEMS
local game = Game()

function mod:KeepLadder()
    if PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_EUCHARIST) and PlayerManager.AnyoneHasCollectible(CollectibleType.COLLECTIBLE_STAIRWAY) then
        local level = game:GetLevel()
        if level:GetCurrentRoomIndex() == level:GetStartingRoomIndex() and level:GetAbsoluteStage() ~= LevelStage.STAGE8 then
            -- First check that there isn't already a ladder
            if #Isaac.FindByType(EntityType.ENTITY_EFFECT, EffectVariant.TALL_LADDER) == 0 then
                Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.TALL_LADDER, 1, Vector(440, 160), Vector.Zero, nil)
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, mod.KeepLadder)
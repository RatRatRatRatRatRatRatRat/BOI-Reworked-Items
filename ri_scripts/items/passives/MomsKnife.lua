local mod = REWORKEDITEMS

--[[
List of SYNERGIES:
brim: YES
tech: YES
dr fetus: NO!!!
epic fetus: YES
monstro: YES
ludo: YES
tech x: YES
forgor: YES
]]

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, function(_)
    local room = Game():GetRoom()
    if room:GetType() == RoomType.ROOM_BOSS and room:IsClear() then
        local level = Game():GetLevel()
        if level:GetStage() == LevelStage.STAGE3_2 and level:GetStageType() >= StageType.STAGETYPE_REPENTANCE then
            for i = 0, DoorSlot.NUM_DOOR_SLOTS do
                local door = room:GetDoor(i)

                if door and door:IsLocked() and door.TargetRoomType == RoomType.ROOM_BOSS then
                    for _, knife in pairs(Isaac.FindByType(EntityType.ENTITY_KNIFE)) do
                        if knife.Position:Distance(door.Position) < 16 then
                            if knife.SpawnerEntity and knife.SpawnerType == EntityType.ENTITY_PLAYER then
                                local player = knife.SpawnerEntity:ToPlayer()
                                if player and player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE, false) then
                                    door:SetLocked(false)
                                    SFXManager():Play(SoundEffect.SOUND_DEATH_BURST_LARGE)
                                    Game():SpawnParticles(door.Position, EffectVariant.BLOOD_PARTICLE, 30, 8) 
                                    break
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)
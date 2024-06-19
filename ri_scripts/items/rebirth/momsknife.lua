local mod = REWORKEDITEMS
local game = Game()
local sfx = SFXManager()

function mod:MomsKnifeFleshDoor()
    local level = game:GetLevel()
    local room = level:GetCurrentRoom()

    if room:GetType() == RoomType.ROOM_BOSS and room:IsClear() and level:GetStage() == LevelStage.STAGE3_2 and level:GetStageType() >= StageType.STAGETYPE_REPENTANCE then
        for slot = 0, DoorSlot.NUM_DOOR_SLOTS do
            local door = room:GetDoor(slot)
            if door and door:IsLocked() and door.TargetRoomType == RoomType.ROOM_BOSS then
                for _, knife in pairs(Isaac.FindByType(EntityType.ENTITY_KNIFE)) do
                    if knife.SpawnerEntity and knife.SpawnerType == EntityType.ENTITY_PLAYER and knife.Position:Distance(door.Position) < 16 then
                        local player = knife.SpawnerEntity:ToPlayer()
                        if player and player:HasCollectible(CollectibleType.COLLECTIBLE_MOMS_KNIFE, false) then
                            door:SetLocked(false)
                            game:SpawnParticles(door.Position, EffectVariant.BLOOD_PARTICLE, 30, 8) 
                            sfx:Play(SoundEffect.SOUND_DEATH_BURST_LARGE)
                            break
                        end
                    end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.MomsKnifeFleshDoor)

---@param knife EntityKnife
function mod:FetusKnifeFire(knife)
    local data = knife:GetData()
    if knife and knife.SpawnerEntity then
        local player = knife.SpawnerEntity:ToPlayer()
        if player and (not player:HasWeaponType(WeaponType.WEAPON_FETUS)) and player:HasCollectible(CollectibleType.COLLECTIBLE_DR_FETUS) then
            if knife.Position:Distance(player.Position) <= 31 then
                data.KnifeHasBeenFiredLikeCrazy = false
            elseif knife.Charge >= 1/4 then
                if not data.KnifeHasBeenFiredLikeCrazy then
                    data.KnifeHasBeenFiredLikeCrazy = true
                    local bomb = player:FireBomb(knife.Position, Vector.Zero, player)
                    if bomb then
                        bomb:GetData().FetusKnife = true
                        if not bomb:HasTearFlags(TearFlags.TEAR_SPECTRAL) then
                            bomb:AddTearFlags(TearFlags.TEAR_SPECTRAL)
                        end
                        bomb:SetExplosionCountdown(math.floor(knife.MaxDistance / 10) + 20)
                        bomb.DepthOffset = 99
                        bomb.Parent = knife
                   end
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, mod.FetusKnifeFire, 0)

---@param bomb EntityBomb
function mod:FetusKnifeBomb(bomb)
    local data = bomb:GetData()
    if data.FetusKnife then
        print("YAA")
        if bomb.Parent and bomb.Parent.Type == EntityType.ENTITY_KNIFE then
            local knife = bomb.Parent:ToKnife()
            if knife then
                local room = game:GetRoom()
                if knife:GetKnifeDistance() >= knife.MaxDistance or room:GetGridCollision(room:GetGridIndex(knife.Position)) == GridCollisionClass.COLLISION_WALL then
                    --bomb.Velocity = player.Velocity
                    bomb.DepthOffset = 0
                    bomb.Parent = nil
                    data.FetusKnife = false
                else
                    bomb.Velocity = knife.Position - bomb.Position
                end
            end
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_BOMB_UPDATE, mod.FetusKnifeBomb)
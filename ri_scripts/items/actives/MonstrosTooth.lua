local mod = REWORKEDITEMS

local MonstroProjectiles = {
    Speed = 4.5,
    SpeedOffset = 4,
    AngleOffset = 20,
}

local function FindNewTarget(effect)
    local position = effect.Position
    for _, entity in pairs(Isaac.GetRoomEntities()) do
        if entity:IsActiveEnemy(false) and entity:IsVulnerableEnemy() then
            if not effect.TargetPosition
            or (entity.Position + entity.Velocity):Distance(position) < (effect.TargetPosition):Distance(position) then 
                effect.TargetPosition = entity.Position + entity.Velocity
            end
        end             
    end
end

local function MonstroBossProjectiles(effect)
    FindNewTarget(effect)

    local rng = effect:GetDropRNG()
    local position = effect.Position
    local targetposition = effect.TargetPosition

    if not targetposition then
        print("UNSTABLE!!")
        return
    end

    for _ = 1, 12 do
        local speed = 4.5 + rng:RandomFloat() * 6
        local angle = rng:RandomInt(-20, 20)
        local velocity = ((targetposition - position):Rotated(angle)):Resized(speed)
        local projectile = Isaac.Spawn(EntityType.ENTITY_TEAR, TearVariant.BLOOD, 0, effect.Position, velocity, nil):ToTear()
        projectile.Height = -23
        projectile.FallingSpeed = -12.5 + rng:RandomFloat() * 5
        projectile.FallingAcceleration = 0.2
        projectile.Scale = 0.75 + rng:RandomFloat() * 0.5
        projectile.CollisionDamage = 6
    end

    Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.POOF02, 5, effect.Position + Vector(0, -40), Vector.Zero, nil).Color = Color(1, 1, 1, 0.5)
    SFXManager():Play(SoundEffect.SOUND_BOSS_SPIT_BLOB_BARF)
end

---@params effect EntityEffect
mod:AddCallback(ModCallbacks.MC_POST_EFFECT_UPDATE, function(_, effect)
    local sprite = effect:GetSprite()
    local data = effect:GetData()
    data.HasFired = data.HasFired or false

    if sprite:IsPlaying("JumpDown") then
        if sprite:IsEventTriggered("Land") then            
            if effect.Target and effect.Target:IsActiveEnemy() and not effect.Target:IsBoss() then 
                effect.Target:Die()
            end
        end

    elseif sprite:IsPlaying("Taunt") then
        if sprite:IsEventTriggered("Shoot") then
            MonstroBossProjectiles(effect)
        end

    elseif sprite:IsFinished("Taunt") then
            sprite:Play("JumpUp")

    elseif sprite:IsPlaying("JumpUp") then
        if data.HasFired == false then
            data.HasFired = true
            if Isaac.CountEnemies() > 0 and not effect.Target then 
                FindNewTarget(effect)
                if effect.TargetPosition then
                    sprite:Play("Taunt")
                    if effect.TargetPosition.X > effect.Position.X then
                        sprite.FlipX = true
                    end
                end
            end
        end
    end
end, EffectVariant.MONSTROS_TOOTH)
---@param knife EntityKnife
local function PostKnifeUpdate(_, knife)
    if (knife.FrameCount > 0) then
        return;
    end
    if (knife.Variant ~= 4) then
        return;
    end
    knife.TargetPosition = Vector(4,0);
    local parent = knife.Parent;
    if (not parent) then
        for _, ent in ipairs(Isaac.FindByType(8,knife.Variant,0)) do
            if (GetPtrHash(ent.SpawnerEntity) == GetPtrHash(knife.SpawnerEntity)) then
                parent = ent;
                break;
            end
        end
    end
    if (parent) then
        knife.Position = parent.Position + Vector.FromAngle(knife.Rotation) * 8;
        knife.Velocity = Vector.Zero;
        local player = parent:ToPlayer()
        if player and player:GetPlayerType() == PlayerType.PLAYER_CAIN_B then
            knife.CollisionDamage = player.Damage
        end
    end
end
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, PostKnifeUpdate, 4)
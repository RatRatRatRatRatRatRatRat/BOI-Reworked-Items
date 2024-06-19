local WhitelistVariants = {
    [1] = true,
    [2] = true,
    [3] = true,
    [9] = true,
    [10] = true,
    [11] = true,
}

local function PostKnifeUpdate(_, knife)
    if (knife.FrameCount > 0) then
        return;
    end
    if (not WhitelistVariants[knife.Variant]) then
        return;
    end
    local targetPosition = knife.TargetPosition;
    local scale = targetPosition.X / 90 + 1;
    knife.TargetPosition = Vector(4,0);
    knife.Scale = knife.Scale * scale;
    knife.SpriteScale = knife.SpriteScale * scale;

    local parent = nil;
    if (not parent) then
        for _, ent in ipairs(Isaac.FindByType(8,knife.Variant,0)) do
            if ent.SpawnerEntity and (GetPtrHash(ent.SpawnerEntity) == GetPtrHash(knife.SpawnerEntity)) then
                parent = ent;
                break;
            end
        end
    end
    if (parent) then
        knife.Position = parent.Position + Vector.FromAngle(knife.Rotation) * 8;
        knife.Velocity = Vector.Zero;
    end
end
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_KNIFE_UPDATE, PostKnifeUpdate, 4)
local mod = REWORKEDITEMS
local game = Game()

---@param player EntityPlayer
function mod:BlockDarkCrown(player)
    if not player:IsCollectibleBlocked(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN) then
        player:BlockCollectible(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN)
    end
end

---@param player EntityPlayer
function mod:AddDarkCrown(player)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN, false, true) then
        if player:GetHearts() <= 2 and not player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN) then
            player:GetEffects():AddCollectibleEffect(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN)
        end
    end
end

---@param player EntityPlayer
function mod:RenderDarkCrown(player, offset)
    if player:HasCollectible(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN, false, true) then
        local data = player:GetData()

        if not data.DarkCrownSprite then
            data.DarkCrownSprite = Sprite()
            data.DarkCrownSprite:Load("gfx/darkprincescrown.anm2", true)
            data.DarkCrownSprite.PlaybackSpeed = 0.5
        end
        local sprite = data.DarkCrownSprite

        if player:GetEffects():HasCollectibleEffect(CollectibleType.COLLECTIBLE_DARK_PRINCES_CROWN) then
            if not sprite:IsPlaying("FloatGlow") then
                sprite:Play("FloatGlow")
            end
        else
            if not sprite:IsPlaying("FloatNoGlow") then
                sprite:Play("FloatNoGlow")
            end             
        end

        if not game:IsPaused() then
            sprite:Update()
        end

        if player:HasCollectible(CollectibleType.COLLECTIBLE_CROWN_OF_LIGHT, false, true) then
            sprite:Render(Isaac.WorldToRenderPosition(player.Position + Vector(0, -10)) + offset)
        else
            sprite:Render(Isaac.WorldToRenderPosition(player.Position) + offset)
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, --[[YO!!!!!]] mod.BlockDarkCrown)

mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, --[[YO!!!!!]] mod.AddDarkCrown)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, mod.AddDarkCrown)
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_LEVEL, --[[YO!!!]] mod.AddDarkCrown)

mod:AddCallback(ModCallbacks.MC_PRE_PLAYER_RENDER, mod.RenderDarkCrown)
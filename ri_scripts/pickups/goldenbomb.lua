local mod = REWORKEDITEMS
local game = Game()

local IsGoldenBomb = false

function mod:PostGoldenBombFloor()
    if IsGoldenBomb then
        IsGoldenBomb = false
        game:GetPlayer():AddGoldenBomb()
    end
end
mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, mod.PostGoldenBombFloor)

function mod:PreGoldenBombFloor()
    if game:GetPlayer():HasGoldenBomb() then
        IsGoldenBomb = true
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_LEVEL_INIT, mod.PreGoldenBombFloor)

---@param player EntityPlayer
function mod:UseGoldenBomb(player)
    if player:HasGoldenBomb() then
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SAD_ONION)
        if rng:RandomFloat() < 0.1 then
            player:RemoveGoldenBomb()
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_USE_BOMB, mod.UseGoldenBomb)
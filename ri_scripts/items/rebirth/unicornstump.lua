local mod = REWORKEDITEMS
local game = Game()

local stump = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_UNICORN_STUMP)
stump.Hidden = true
--game:GetItemPool():RemoveCollectible(CollectibleType.COLLECTIBLE_UNICORN_STUMP)

TrinketType.TRINKET_UNICORN_STUMP = Isaac.GetTrinketIdByName("Unicorn Stump")
--I love you sooooooooooooooooo much
---@param entity Entity
function mod:UnicornStumpTakeDamage(entity)
    local player = entity:ToPlayer()

    if player then
        local count = player:GetTrinketMultiplier(TrinketType.TRINKET_UNICORN_STUMP)
        if count > 0 then
            local rng = player:GetTrinketRNG(TrinketType.TRINKET_UNICORN_STUMP)

            if rng:RandomFloat() < 0.05 * count + math.max(0, player.Luck / 40) then
                player:UseActiveItem(CollectibleType.COLLECTIBLE_MY_LITTLE_UNICORN, UseFlag.USE_NOANIM)
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_TAKE_DMG, mod.UnicornStumpTakeDamage, EntityType.ENTITY_PLAYER)
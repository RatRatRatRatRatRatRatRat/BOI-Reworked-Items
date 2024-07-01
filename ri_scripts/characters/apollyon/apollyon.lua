local mod = REWORKEDITEMS
local game = Game()
local variant = Isaac.GetEntityVariantByName("Locust Portal")

---@param player EntityPlayer
function mod:ResetPortals(player)
    if player:GetPlayerType() == PlayerType.PLAYER_APOLLYON then
    local data = player:GetData()
    local room = game:GetRoom()
    data.PortalCount = 0

    if not room:IsClear() then
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SAD_ONION)
        local position
        repeat
            position = room:GetGridPosition(room:GetRandomTileIndex(rng:RandomInt(9999999999) + 1))
        until room:GetGridCollisionAtPos(position) == GridCollisionClass.COLLISION_NONE
        Isaac.Spawn(EntityType.ENTITY_EFFECT, variant, 0, position, Vector.Zero, player)
        data.PortalCount = data.PortalCount + 1
    end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PLAYER_NEW_ROOM_TEMP_EFFECTS, mod.ResetPortals)

---@param player EntityPlayer
function mod:SpawnLocustPortals(player)
    local data = player:GetData()
    local room = game:GetRoom()
    data.PortalCount = data.PortalCount or 0
    if not room:IsClear() and player:GetPlayerType() == PlayerType.PLAYER_APOLLYON and data.PortalCount < 3 then
        local rng = player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_SAD_ONION)

        if rng:RandomFloat() < 0.005 then
            local position
            repeat
                position = room:GetGridPosition(room:GetRandomTileIndex(rng:RandomInt(9999999999) + 1))
            until room:GetGridCollisionAtPos(position) == GridCollisionClass.COLLISION_NONE
            Isaac.Spawn(EntityType.ENTITY_EFFECT, variant, 0, position, Vector.Zero, player)
            data.PortalCount = data.PortalCount + 1
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.SpawnLocustPortals)
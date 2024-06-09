local mod = REWORKEDITEMS
FamiliarVariant.LIL_CHEST_TWO = Isaac.GetEntityVariantByName("Lil Chest Two")

---@param player EntityPlayer
function mod:BlockLilChest(player)
    if not player:IsCollectibleBlocked(CollectibleType.COLLECTIBLE_LIL_CHEST) then
        player:BlockCollectible(CollectibleType.COLLECTIBLE_LIL_CHEST)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, mod.BlockLilChest)

---@param player EntityPlayer
function mod:LilChestCache(player)
    local num = player:GetCollectibleNum(CollectibleType.COLLECTIBLE_LIL_CHEST, false, true)
    player:CheckFamiliar(FamiliarVariant.LIL_CHEST_TWO, num, player:GetCollectibleRNG(CollectibleType.COLLECTIBLE_LIL_CHEST))
end
mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, mod.LilChestCache, CacheFlag.CACHE_FAMILIARS)

---@param familiar EntityFamiliar
function mod:LilChestSpawn(familiar)
    familiar:AddToFollowers()
end
mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.LilChestSpawn, FamiliarVariant.LIL_CHEST_TWO)

function mod:LilChestPriority()
    return 6
end
mod:AddCallback(ModCallbacks.MC_GET_FOLLOWER_PRIORITY, mod.LilChestPriority, FamiliarVariant.LIL_CHEST_TWO)

---@param familiar EntityFamiliar
function mod:LilChestUpdate(familiar)
    local sprite = familiar:GetSprite()

    local count = 8
    if familiar.Player and familiar.Player:HasCollectible(CollectibleType.COLLECTIBLE_BFFS) then
        count = count - 1
    end

    if sprite:IsPlaying("Float") then
        if familiar.RoomClearCount >= count then
            familiar.RoomClearCount = 0
            sprite:Play("Spawn", true)
        end
    elseif sprite:IsPlaying("Spawn") then
        if sprite:GetFrame() == 5 then
            local chest = Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_CHEST, ChestSubType.CHEST_CLOSED, familiar.Position, familiar.Velocity, nil):ToPickup()
            if chest then
                chest.Visible = false
                chest:TryOpenChest()
                chest:Remove()
            end

            sprite:Play("Float", true)
        end
    else
        sprite:Play("Float", true)
    end

    familiar:FollowParent()
end

mod:AddCallback(ModCallbacks.MC_FAMILIAR_UPDATE, mod.LilChestUpdate, FamiliarVariant.LIL_CHEST_TWO)
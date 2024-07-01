local mod = REWORKEDITEMS
local variant = Isaac.GetEntityVariantByName("Locust Portal")
local void = Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_VOID)
void.MaxCharges = 1

function mod:PreUseVoid(_, _, player)
    Isaac.Spawn(EntityType.ENTITY_EFFECT, variant, 0, player.Position, Vector.Zero, player)
    player:AnimateCollectible(CollectibleType.COLLECTIBLE_VOID, "UseItem")
    return true
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, mod.PreUseVoid, CollectibleType.COLLECTIBLE_VOID)
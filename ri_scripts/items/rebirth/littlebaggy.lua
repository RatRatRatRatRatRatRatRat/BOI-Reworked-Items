local mod = REWORKEDITEMS
local game = Game()
Isaac.GetItemConfig():GetCollectible(CollectibleType.COLLECTIBLE_LITTLE_BAGGY).Quality = 1

function mod:IdentifyAllPills()
    for pillcolor = 0, PillEffect.NUM_PILL_EFFECTS do
        game:GetItemPool():IdentifyPill(pillcolor)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_ADD_COLLECTIBLE, mod.IdentifyAllPills, CollectibleType.COLLECTIBLE_LITTLE_BAGGY)
--<passive cache="all" description="Explosive shots" gfx="Collectibles_149_Ipecac.png" id="1" name=" Ipecac " tags="bob" />

--["Ipecac"] = Isaac.GetItemIdByName(" Ipecac "),

local shittyitems = {
    CollectibleType.COLLECTIBLE_BROTHER_BOBBY,
    CollectibleType.COLLECTIBLE_SISTER_MAGGY,
    CollectibleType.COLLECTIBLE_MULTIDIMENSIONAL_BABY,
    CollectibleType.COLLECTIBLE_HEADLESS_BABY,
    CollectibleType.COLLECTIBLE_LIL_DELIRIUM,
    CollectibleType.COLLECTIBLE_MONSTER_MANUAL
}

function REWORKEDITEMS:SoulOfForgod()
    local p = Game():GetNumPlayers() - 1
    local player = Isaac.GetPlayer(p)
    player:ChangePlayerType(PlayerType.PLAYER_BLUEBABY)
end

--REWORKEDITEMS:AddCallback(ModCallbacks.MC_USE_CARD, REWORKEDITEMS.SoulOfForgod, Card.CARD_SOUL_FORGOTTEN)

function REWORKEDITEMS:bootyballs(npc)
    if npc.Price < 0 and npc.Price > -10 then
        for _, item in pairs(shittyitems) do
            if npc.SubType == item then
                npc:Morph(npc.Type, npc.Variant, 0, true)
            end
        end
    end
end

REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, REWORKEDITEMS.bootyballs, PickupVariant.PICKUP_COLLECTIBLE)

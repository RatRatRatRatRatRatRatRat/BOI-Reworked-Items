REWORKEDITEMS = RegisterMod("Reworked Items", 1)

local scripts = {
    "Helpers",
    "Enums",

    "items.passives.NumberOne",
    "items.passives.Skatole",
    "items.passives.Transcendence",
    "items.passives.MomsLipstick",
    "items.passives.Steven",
    "items.passives.LittleSteven",
    "items.passives.Ipecac",
    "items.passives.ToughLove",
    --"items.passives.SpiritOfTheNight",
    "items.passives.GhostBaby",
    --"items.passives.RainbowBaby",
    "items.passives.StemCells",
    --"items.passives.DeadDove",
    "items.passives.Abel",
    --"items.passives.SpiderBaby",
    "items.passives.TheBody",
    "items.passives.MomsPearls",
    "items.passives.Zodiac",
    "items.passives.GodsFlesh",
    "items.passives.LilLoki",
    "items.passives.DarkPrincesCrown",
    "items.passives.DeadTooth",
    "items.passives.ShardOfGlass",
    "items.passives.AcidBaby",
    "items.passives.AngryFly",
    "items.passives.Leprosy",

    "items.actives.ThePoop",
	"items.actives.Teleport",
    "items.actives.SpiderButt",
    "items.actives.Flush",
    --"items.actives.MomsBracelet",

    "slots.KeyMaster",
    "slots.BombBum",

    "compatibility.EIDCompat",
}

for i = 1 , #scripts do
    require("ri_scripts."..scripts[i])
end

---@param player EntityPlayer
REWORKEDITEMS:AddCallback(ModCallbacks.MC_POST_PLAYER_UPDATE, function(_, player)
    local heldEntity = player:GetHeldEntity()
    if heldEntity then
        print(heldEntity.Type.. "." ..heldEntity.Variant.. "." ..heldEntity.SubType)
    end
end)
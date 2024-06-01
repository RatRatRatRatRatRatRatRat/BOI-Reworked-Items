local mod = REWORKEDITEMS
local game = Game()

function mod:UseWorld()
    game:GetLevel():RemoveCurses(LevelCurse.CURSE_OF_THE_LOST)
end

mod:AddCallback(ModCallbacks.MC_USE_CARD, mod.UseWorld, Card.CARD_WORLD)
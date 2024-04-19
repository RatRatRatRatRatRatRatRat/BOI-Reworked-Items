local mod = REWORKEDITEMS
local game = Game()
local pool = game:GetItemPool()

function mod:AddMissingPage2ToPools()

end

function mod:NecronomiconPickup(type, charge, isfirst)
    if isfirst then
        mod:AddMissingPage2ToPools()
    end
end
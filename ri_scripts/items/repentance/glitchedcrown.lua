local mod = REWORKEDITEMS

---@param pickup EntityPickup
function mod:NextCollectibleOption(pickup)
    local options = pickup:GetCollectibleCycle()
    if options and #options > 0 then
        table.insert(options, pickup.SubType)
        pickup:Morph(5, 100, options[1], true, true, true)

        for idx = 2, #options do
            pickup:AddCollectibleCycle(options[idx])
        end

        pickup:GetData().FakeFrameCount = 0
    end
end

---@param pickup EntityPickup
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_RENDER, function(_, pickup)
    if Game():IsPaused() and #pickup:GetCollectibleCycle() > 0 and Isaac.GetFrameCount() % 2 == 1 then
        local data = pickup:GetData()
        if not data.FakeFrameCount then
            data.FakeFrameCount = pickup.FrameCount
        end
        pickup:Update()
    end
end, PickupVariant.PICKUP_COLLECTIBLE)


---@param pickup EntityPickup
mod:AddCallback(ModCallbacks.MC_POST_PICKUP_UPDATE, function(_, pickup)
    local data = pickup:GetData()
    if not data.FakeFrameCount or not Game():IsPaused() then
        return
    end

    local optionscount = #(pickup:GetCollectibleCycle())

    if optionscount then
        if optionscount >= 8 then
            mod:NextCollectibleOption(pickup)
        elseif optionscount >= 4 and data.FakeFrameCount >= 6 then
            mod:NextCollectibleOption(pickup)
        elseif optionscount > 0 and data.FakeFrameCount >= 30 then
            mod:NextCollectibleOption(pickup)
        end
    end

    data.FakeFrameCount = data.FakeFrameCount + 1
end, PickupVariant.PICKUP_COLLECTIBLE)
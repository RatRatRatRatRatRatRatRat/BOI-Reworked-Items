local mod = REWORKEDITEMS

local TryHoldDistance = 40



function mod:UseMomsBracelet(type, rng, player, flags, itemSlot, customdata)
    for _, slot in ipairs(Isaac.FindByType(EntityType.ENTITY_SLOT)) do
        if player.Position:Distance(slot.Position) <= TryHoldDistance
        and not player:GetData().HeldSlotData -- Previous slot isn't still held / midair
        and (slot:ToSlot():GetState() == 1 or slot:ToSlot():GetState() == 3) then -- Only pick them up when they're idle or destroyed
            local slot = slot:ToSlot()
            local slotSprite = slot:GetSprite()

            -- Create the helper entity to hold
            local helper = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.GRID_ENTITY_PROJECTILE_HELPER, 0, slot.Position, Vector.Zero, player)
            helper.Parent = player
            player:TryHoldEntity(helper)


            -- Store the slot's data
            player:GetData().HeldSlotData = {
                Variant       = slot.Variant,
                SubType       = slot.SubType,
                Seed          = slot.DropSeed,
                State         = slot:GetState(),
                PrizeType     = slot:GetPrizeType(),
                DonationValue = slot:GetDonationValue(),
                Timeout       = slot:GetTimeout(),
                Touch         = slot:GetTouch(),
                Offset        = slot.PositionOffset,
                Data          = slot:GetData(),
            }


            -- Store the slot's sprite data
            local helperSprite = helper:GetSprite()
            helperSprite:Load(slotSprite:GetFilename())

            helperSprite:Play(slotSprite:GetAnimation(), true)
            helperSprite:SetFrame(slotSprite:GetFrame())
            helperSprite:PlayOverlay(slotSprite:GetOverlayAnimation(), true)
            helperSprite:SetOverlayFrame(slotSprite:GetOverlayFrame())

            helperSprite.PlaybackSpeed = 0
            helper.PositionOffset = slot.PositionOffset

            for i, layer in pairs(slotSprite:GetAllLayers()) do
                helperSprite:ReplaceSpritesheet(i - 1, layer:GetSpritesheetPath())
            end
            helperSprite:LoadGraphics()


            -- Remove the original slot
            slot:Remove()
            return true
        end
    end
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_ITEM, mod.UseMomsBracelet, CollectibleType.COLLECTIBLE_MOMS_BRACELET)



function mod:ThrownSlotConvert(tear)
    local data = tear.SpawnerEntity:GetData().HeldSlotData
    local tearSprite = tear:GetSprite()

    -- Create the slot
    local slot = Game():Spawn(EntityType.ENTITY_SLOT, data.Variant, tear.Position, Vector.Zero, tear.SpawnerEntity, data.SubType, data.Seed):ToSlot()
    local slotSprite = slot:GetSprite()

    -- Load custom data
    for i, entry in pairs(data.Data) do
        slot:GetData()[i] = entry
    end

    slot:Update()


    -- Get destroyed if thrown
    if tear.Velocity:Length() > 1 then
        -- Already destroyed ones disappear
        if data.State == 3 then
            slot:Remove()
            SFXManager():Play(SoundEffect.SOUND_POT_BREAK)

            for i = 1, 6 do
                local vector = Vector.FromAngle(math.random(359)):Resized(3)
                local rocks = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.ROCK_PARTICLE, 0, slot.Position, vector, slot):ToEffect()
                rocks:Update()
                rocks:GetSprite():SetAnimation("rubble_alt", false)
            end

        -- Not destroyed yet
        else
            local config = EntityConfig.GetEntity(slot.Type, slot.Variant)
            local gibCount = config:GetGibsAmount()

            -- For beggars
            if gibCount > 0 then
                slot:Kill()
                slot:Remove()

            -- For machines
            else
                slot:SetState(3)

                local anim = slot.Variant == SlotVariant.MOMS_DRESSING_TABLE and "Broken" or "Death"
                slotSprite:Play(anim, true)
                Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.BOMB_EXPLOSION, 0, slot.Position, Vector.Zero, slot)
            end

            -- Donation machines and the closet Isaac should not drop stuff
            if  slot.Variant ~= SlotVariant.DONATION_MACHINE
            and slot.Variant ~= SlotVariant.GREED_DONATION_MACHINE
            and slot.Variant ~= SlotVariant.HOME_CLOSET_PLAYER then
                slot:CreateDropsFromExplosion()
            end
        end


    -- Otherwise get placed normally
    else
        -- Load the slot data
        slot:SetState(data.State)
        slot:SetPrizeType(data.PrizeType)
        slot:SetDonationValue(data.DonationValue)
        slot:SetTimeout(data.Timeout)
        slot:SetTouch(data.Touch)

        -- Load the sprite data
        slotSprite:Play(tearSprite:GetAnimation(), true)
        slotSprite:SetFrame(tearSprite:GetFrame())
        slotSprite:PlayOverlay(tearSprite:GetOverlayAnimation(), true)
        slotSprite:SetOverlayFrame(tearSprite:GetOverlayFrame())

        for i, layer in pairs(tearSprite:GetAllLayers()) do
            slotSprite:ReplaceSpritesheet(i - 1, layer:GetSpritesheetPath())
        end
        slotSprite:LoadGraphics()
    end


    tear.SpawnerEntity:GetData().HeldSlotData = nil
    tear:Remove()
end



function mod:ThrownSlotUpdate(tear)
    local data = tear.SpawnerEntity:GetData().HeldSlotData

    if data then
        -- Set the shadow size
        local config = EntityConfig.GetEntity(EntityType.ENTITY_SLOT, data.Variant)
        tear:SetShadowSize(config:GetShadowSize())

        -- Set the offset
        tear.SpriteOffset = data.Offset * 0.65

        -- On landing
        if tear:IsDead() then
            mod:ThrownSlotConvert(tear)
        end
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_UPDATE, mod.ThrownSlotUpdate, TearVariant.GRIDENT)

-- On collision with an entity
function mod:ThrownSlotCollision(tear, target, bool)
    if tear.SpawnerEntity:GetData().HeldSlotData then
        mod:ThrownSlotConvert(tear)
    end
end
mod:AddCallback(ModCallbacks.MC_POST_TEAR_COLLISION, mod.ThrownSlotCollision, TearVariant.GRIDENT)

-- Dumb rotten very bad failsafe for the seed being 0 for absolutely no reason :(
function mod:ThrownSlotFailsafe(type, variant, subtype, position, velocity, spawner, seed)
    if type == EntityType.ENTITY_TEAR and variant == TearVariant.GRIDENT and seed == 0 then
        return { type, variant, subtype, spawner.Index }
    end
end
mod:AddPriorityCallback(ModCallbacks.MC_PRE_ENTITY_SPAWN, CallbackPriority.EARLY, mod.ThrownSlotFailsafe)
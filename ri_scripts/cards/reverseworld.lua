local mod = REWORKEDITEMS
local game = Game()
Isaac.GetItemConfig():GetCard(Card.CARD_REVERSE_WORLD).MimicCharge = 12

---@param player EntityPlayer
---@param useflag UseFlag
function mod:UseReverseWorldError(_, player, useflag)
    game:StartRoomTransition(GridRooms.ROOM_ERROR_IDX, Direction.NO_DIRECTION, RoomTransitionAnim.TELEPORT, player)
    mod:TrySayAnnouncerLine(SoundEffect.SOUND_REVERSE_WORLD, useflag)
    return true
end
mod:AddCallback(ModCallbacks.MC_PRE_USE_CARD, mod.UseReverseWorldError, Card.CARD_REVERSE_WORLD)
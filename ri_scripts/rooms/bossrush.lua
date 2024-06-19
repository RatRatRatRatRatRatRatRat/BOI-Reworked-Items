local mod = REWORKEDITEMS
local game = Game()

--"stolen" from im_tem thanks bro
function mod:BossRushRoomClear()
	if game:GetStateFlag(GameStateFlag.STATE_BOSSRUSH_DOOR_SPAWNED) then
		game.BossRushParTime = 30 * 60 * 60 * 24	--is 24 hours enough?............
	end
	if game:GetStateFlag(GameStateFlag.STATE_BLUEWOMB_DOOR_SPAWNED) then
		game.BlueWombParTime = 30 * 60 * 60 * 24	--24 hours here too
	end
end

function mod:BossRushStart(iscontinued)
	if not iscontinued then
		game.BlueWombParTime = 54000		--i hate this game sometimes :)
	end
end

mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, mod.BossRushRoomClear)
mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, mod.BossRushStart)
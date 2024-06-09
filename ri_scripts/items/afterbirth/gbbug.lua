local mod = REWORKEDITEMS
local game = Game()

---@param familiar EntityFamiliar
function mod:GameBreakingInit(familiar)
    familiar.GridCollisionClass = EntityGridCollisionClass.GRIDCOLL_WALLS
end

---@param familiar EntityFamiliar
---@param coll Entity
function mod:GameBreakingCollision(familiar, coll)
    local npc = coll:ToNPC()
    if npc and npc:CanReroll() then
        familiar.SubType = 1
        game:DevolveEnemy(npc)
    end
end

mod:AddCallback(ModCallbacks.MC_FAMILIAR_INIT, mod.GameBreakingInit, FamiliarVariant.GB_BUG)
mod:AddCallback(ModCallbacks.MC_PRE_FAMILIAR_COLLISION, mod.GameBreakingCollision, FamiliarVariant.GB_BUG)
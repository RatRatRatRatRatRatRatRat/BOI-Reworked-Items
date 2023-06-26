if not EID then return end

local Enums = require("repentagon_scripts.Enums")

--Blower
EID:addCollectible(Enums.Collectibles.LeafBlower, "On use grants player a leaf blower # Player shoots blast of air instead of tears #{{ArrowUp}} Blast of air pushes nearby enemies and projectiles away #Air Blast doesn't deal any damage #{{ArrowDown}} Shooting pushes player into opposite direction #To cancel the effect use this item again")

--Comically Large Cannon
EID:addCollectible(Enums.Collectibles.CANNON, "Shoots a rocket # Costs 7 bombs to use")

--Squeaky Shoes
EID:addCollectible(Enums.Collectibles.SQUEAKY_SHOES, "{{ArrowUp}} +0.15 speed # Has a chance to scare nearby enemies with every step")

--Petrifly
EID:addCollectible(Enums.Collectibles.Petrifly, "Fly familiar which follows the player and blocks projectiles#Blocking a projectile has a 1/5 chance to spawn 6 troll bombs")

--Sack of Kids
EID:addCollectible(Enums.Collectibles.EmptySack, "Spawns familiar following Player # {{ArrowUp}} Spawns 1-4 mini isaacs after clearing 3 rooms")

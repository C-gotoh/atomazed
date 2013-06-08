
Level = class("Level", GameState)

function Level:__init()
	love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginContact, endContact)
end

--Collision function
function beginContact(a, b, coll)
	
end
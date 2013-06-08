require("core/helper")
require("core/physicshelper")
require("core/state")

require("classes/wall")
require("classes/electron")

MainState = class("MainState", State)

function MainState:__init()

end

function MainState:load()
	self.walls = {}
	self.el = {}
    love.graphics.setFont(resources.fonts.default)
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(beginContact, endContact)

    wall = Wall(world, 512, 0, 1024, 4, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 512, 768, 1024, 4, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 1024, 384, 4, 768, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 0, 384, 4, 768, "static")
    table.insert(self.walls, wall)

    el = Electron(world, 200, 200)
    table.insert(self.el, el)
end

function MainState:update(dt)
    world:update(dt)
end

function MainState:draw()
	for index, wall in pairs(self.walls) do
		wall:draw()
	end
	for index, el in pairs(self.el) do
		el:draw()
	end
end

function MainState:restart()
    world:destroy()
    self:__init()
end

function MainState:keypressed(key, u)
end


function MainState:mousepressed(x, y, button)
end

--Collision function
function beginContact(a, b, coll)
end
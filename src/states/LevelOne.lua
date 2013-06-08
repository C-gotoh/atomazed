require("core/helper")
require("core/physicshelper")
require("core/state")

require("classes/wall")
require("classes/electron")
require("classes/magnet")

LevelOne = class("LevelOne", State)

function LevelOne:__init()

end

function LevelOne:load()
	self.walls = {}
	self.el = {}
    self.magnet = {}

    love.graphics.setFont(resources.fonts.default)
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginContact, endContact)

    wall = Wall(world, 512, 0, 1024, 4, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 512, 768, 1024, 4, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 1024, 384, 4, 768, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 0, 384, 4, 768, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 200, 300, 10, 600, "static")
    table.insert(self.walls, wall)

    el = Electron(world, 300, 300)
    el.body:setLinearVelocity(0, 200)
    table.insert(self.el, el)

    magnet = Magnet(world, 250, 400, 20, 150, 2)
    table.insert(self.magnet, magnet)

end

function LevelOne:update(dt)
    world:update(dt)
    for index, magnet in pairs(self.magnet) do
        for index2, el in pairs(self.el) do
            magnet:addForce(el)
        end
    end
end

function LevelOne:draw()
	for index, wall in pairs(self.walls) do
		wall:draw()
	end
	for index, el in pairs(self.el) do
		el:draw()
	end
    for index, magnet in pairs(self.magnet) do
        magnet:draw()
    end
end

function LevelOne:restart()
    world:destroy()
    self:__init()
end

function LevelOne:keypressed(key, u)
end


function LevelOne:mousepressed(x, y, button)
end

--Collision function
function beginContact(a, b, coll)
end
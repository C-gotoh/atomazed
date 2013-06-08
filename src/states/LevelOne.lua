require("core/helper")
require("core/physicshelper")
require("core/state")

require("classes/wall")
require("classes/electron")
require("classes/proton")
require("classes/magnet")
require("classes/shock")

LevelOne = class("LevelOne", State)

function LevelOne:__init()
	self.force = 0
end

function LevelOne:load()
    self.all = {}
	self.walls = {}
    table.insert(self.all, self.walls)
	self.el = {}
    table.insert(self.all, self.el)
    self.proton = {}
    table.insert(self.all, self.proton)
    self.magnet = {}
    table.insert(self.all, self.magnet)

    love.graphics.setFont(resources.fonts.default)
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginContact, endContact)

    wall = Wall(world, 512, 0, 1024, 4, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 512, 600, 1024, 4, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 1024, 300, 4, 600, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 0, 300, 4, 600, "static")
    table.insert(self.walls, wall)

    el = Electron(world, 100, 200)
    el.body:setLinearVelocity(300, 400)
    table.insert(self.el, el)

    --[[el = Electron(world, 100, 100)
    el.body:setLinearVelocity(0, 400)
    table.insert(self.el, el)

    magnet = Magnet(world, 250, 400, 20, 200, 8)
    table.insert(self.magnet, magnet)

    magnet = Magnet(world, 600, 400, 20, 200, 10)
    table.insert(self.magnet, magnet)

    magnet = Magnet(world, 350, 200, 20, 200, 8)
    table.insert(self.magnet, magnet)

    magnet = Magnet(world, 700, 200, 20, 200, 10)
    table.insert(self.magnet, magnet)

    proton = Proton(world, 400, 100)
    proton.body:setLinearVelocity(0, 300)
    table.insert(self.proton, proton)  --]]
end

function LevelOne:update(dt)
    world:update(dt)
    for index, magnet in pairs(self.magnet) do
        for index2, el in pairs(self.el) do
            magnet:addForce(el)
        end
    end

    for index, el in pairs(self.el) do 
        fraction(el)
        print(el.body:getLinearVelocity())
end
    if love.mouse.isDown("l") then
    	down = true
    	self.force = self.force + dt
    	print(down)
    elseif down then
    	Shock:fire(self.force)
    	down = false

    end
    for index, table in pairs(self.all) do
        for index2, whatever in pairs(table) do
            if whatever.update then
                whatever:update(dt)
            end
        end
    end
end

function LevelOne:draw()
    for index, table in pairs(self.all) do
        for index2, whatever in pairs(table) do
            if whatever.draw then
                whatever:draw()
            end
        end
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
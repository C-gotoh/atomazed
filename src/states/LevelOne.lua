require("core/helper")
require("core/physicshelper")
require("core/state")

require("classes/wall")
require("classes/electron")
require("classes/proton")
require("classes/magnet")
require("classes/shock")
require("classes/biribiri")

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
    self.biribiri = {}
    table.insert(self.all, self.biribiri)

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
    el.body:setLinearVelocity(0, 100)
    table.insert(self.el, el)

    el = Electron(world, 750, 450)
    el.body:setLinearVelocity(0, 0)
   table.insert(self.el, el)

    proton = Proton(world, 400, 100)
    proton.body:setLinearVelocity(0, 100)
    table.insert(self.proton, proton)


    proton = Proton(world, 300, 450)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    for i = 1, 20, 1 do
        proton = Proton(world, math.random(50, 1000), math.random(50, 550))
        proton.body:setLinearVelocity(math.random(0, 400), math.random(0, 400))
        table.insert(self.proton, proton)
    end

    for i = 1, 20, 1 do
        el = Electron(world, math.random(50, 1000), math.random(50, 550))
        el.body:setLinearVelocity(math.random(0, 400), math.random(0, 400))
        table.insert(self.el, el)
    end

    magnet = Magnet(world, 250, 400, 20, 200, 12, "Electron")
    table.insert(self.magnet, magnet)

    magnet = Magnet(world, 800, 400, 20, 200, 12, "Proton")
    table.insert(self.magnet, magnet)

    magnet = Magnet(world, 350, 200, 20, 200, 12, "Proton")
    table.insert(self.magnet, magnet)

    magnet = Magnet(world, 700, 200, 20, 200, 12, "Electron")
    table.insert(self.magnet, magnet)

    self.darkness = 0 
    self.maxElectrons = 22
    self.minElectrons = 18

    biribiri = Biribiri(world, 400, 400)
    biribiri.body:setLinearVelocity(0, 0)
    table.insert(self.biribiri, biribiri)
end

function LevelOne:update(dt)
    world:update(dt)
    for index, magnet in pairs(self.magnet) do
        for index2, el in pairs(self.el) do
            magnet:addForce(el)
        end
        for index2, proton in pairs(self.proton) do
            magnet:addForce(proton)
        end
    end

    for index, el in pairs(self.el) do 
        fraction(el)
end
    if love.mouse.isDown("l") then
    	down = true
    	self.force = self.force + dt
    elseif down then
    	Shock:fire(self.force)
    	down = false
        self.force = 1

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
    self.darkness = ((self.maxElectrons-#self.el)/self.minElectrons)
    love.graphics.setColor(0, 0, 0, 255*self.darkness)
    love.graphics.rectangle("fill", 0, 0, 1024, 600)
end

function LevelOne:restart()
    self:__init()
    self:load()
end

function LevelOne:keypressed(key, u)
    if key == "r" then
        self:restart()
    end
end


function LevelOne:mousepressed(x, y, button)
end

--Collision function
function beginContact(a, b, coll)
    levelone:beginContact(a, b, coll)
end

function LevelOne:beginContact(a, b, coll)
    local objecta = a:getUserData()
    local objectb = b:getUserData()

    if (objecta.__name == "Proton") and (objectb.__name == "Electron") then
        for index, value in pairs(self.el) do 
            if value == objectb then
                table.remove(self.el, index)
                value.body:destroy()
            end
        end
        for index, value in pairs(self.proton) do
            if value == objecta then
                table.remove(self.proton, index)
                value.body:destroy()
            end
        end
    elseif (objecta.__name == "Electron") and (objectb.__name == "Proton") then
        for index, value in pairs(self.el) do 
            if value == objecta then
                table.remove(self.el, index)
                value.body:destroy()
            end
        end
        for index, value in pairs(self.proton) do
            if value == objectb then
                table.remove(self.proton, index)
                value.body:destroy()
            end
        end
    end
end
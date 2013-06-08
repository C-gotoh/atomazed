require("core/helper")
require("core/physicshelper")
require("core/state")

require("classes/wall")
require("classes/electron")
require("classes/proton")
require("classes/magnet")
require("classes/shock")
require("classes/portal")
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
    self.portal = {}
    table.insert(self.all, self.portal)
    self.positionQueue = {}

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
    el.body:setLinearVelocity(0, 400)
    table.insert(self.el, el)

--[[el = Electron(world, 750, 450)
    el.body:setLinearVelocity(0, 0)
   table.insert(self.el, el)

    proton = Proton(world, 400, 100)
    proton.body:setLinearVelocity(0, 100)
    table.insert(self.proton, proton)


    proton = Proton(world, 300, 450)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    magnet = Magnet(world, 250, 400, 20, 200, 12, "Electron")
    table.insert(self.magnet, magnet)

    magnet = Magnet(world, 800, 400, 20, 200, 12, "Proton")
    table.insert(self.magnet, magnet)

    magnet = Magnet(world, 350, 200, 20, 200, 12, "Proton")
    table.insert(self.magnet, magnet)

    magnet = Magnet(world, 700, 200, 20, 200, 12, "Electron")
    table.insert(self.magnet, magnet)]]

    portal = Portal(world, 100, 300, 800, 200)
    table.insert(self.portal, portal)

    self.darkness = 0 
    self.maxElectrons = 22
    self.minElectrons = 50
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
                if (whatever.__name == "Electron") or (whatever.__name == "Proton") then
                    fraction(whatever, 0.2)
                    limitSystem(whatever, 400)
                end
            end
        end
    end
    for index, value in pairs(self.positionQueue) do
        value[1].body:setPosition(value[2], value[3])
        value[1].body:setLinearVelocity(unpack(value[4]))
        table.remove(self.positionQueue, index)
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
    if ((objecta.__name == "Electron") or (objecta.__name == "Proton")) and (objectb.__name == "Portal") then
        local move = {objecta, objectb.xt, objectb.yt, {objecta.body:getLinearVelocity()}}
        table.insert(self.positionQueue, move)
    elseif ((objectb.__name == "Electron") or (objectb.__name == "Proton")) and (objecta.__name == "Portal") then
        local move = {objectb, objecta.xt, objecta.yt, {objectb.body:getLinearVelocity()}}
        table.insert(self.positionQueue, move)
    end
end
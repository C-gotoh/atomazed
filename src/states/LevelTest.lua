require("core/helper")
require("core/physicshelper")
require("core/state")

require("classes/wall")
require("classes/electron")
require("classes/proton")
require("classes/magnet")
require("classes/shock")
require("classes/portal")

require("classes/explosion")
require("classes/shockeffect")


LevelTest = class("LevelTest", State)

function LevelTest:__init()
    self.force = 0
    self.index = 1
end

function LevelTest:load()
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
    self.particles = {}
    table.insert(self.all, self.particles)
    self.shockeffect = {}
    table.insert(self.all, self.shockeffect)
    

    love.graphics.setFont(resources.fonts.default)
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginContact, endContact)

    local wall = Wall(world, 512, 0, 1024, 4, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 512, 600, 1024, 4, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 1024, 300, 4, 600, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 0, 300, 4, 600, "static")
    table.insert(self.walls, wall)

    local el = Electron(world, 100, 200)
    el.body:setLinearVelocity(0, 800)
    table.insert(self.el, el)

    el = Electron(world, 750, 450)
    el.body:setLinearVelocity(0, 0)
    table.insert(self.el, el)

    local proton = Proton(world, 400, 100)
    proton.body:setLinearVelocity(0, 100)
    table.insert(self.proton, proton)


    proton = Proton(world, 300, 450)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local magnet = Magnet(world, 250, 400, 20, 200, 12, "Electron")
    table.insert(self.magnet, magnet)

    magnet = Magnet(world, 800, 400, 20, 200, 12, "Proton")
    table.insert(self.magnet, magnet)

    magnet = Magnet(world, 350, 200, 20, 200, 12, "Proton")
    table.insert(self.magnet, magnet)

    magnet = Magnet(world, 700, 200, 20, 200, 12, "Electron")
    table.insert(self.magnet, magnet)

    portal = Portal(world, 100, 300, 800, 200)
    table.insert(self.portal, portal)

    

    self.darkness = 0 
    self.maxElectrons = 22
    self.minElectrons = 0
end

function LevelTest:update(dt)
    world:update(dt)
    if self.minElectrons >= #self.el then
        local canvas = love.graphics.newScreenshot()
        screenshot = love.graphics.newImage(canvas)
        local save = {}
        save.saves = self.index+1
        success = love.filesystem.write( "save.lua", table.show(save, "saved"))
        local canvas = love.graphics.newScreenshot()
        screenshot = love.graphics.newImage(canvas)
        stack:push(gameover)
    end
    for index, magnet in pairs(self.magnet) do
        for index2, el in pairs(self.el) do
            magnet:addForce(el)
        end
        for index2, proton in pairs(self.proton) do
            magnet:addForce(proton)
        end
    end

    for index, proton in pairs(self.proton) do
        for indexzwo, protonzwo in pairs(self.proton) do
            if proton ~= protonzwo then
                proton:addForce(protonzwo)
            end
        end
    end

    for index, electron in pairs(self.el) do
        for indexzwo, electronzwo in pairs(self.el) do
            if electron ~= electronzwo then
                electron:addForce(electronzwo)
            end
        end
    end

    for index, proton in pairs(self.proton) do
        for index, electron in pairs(self.el) do
            proton:addForce(electron)
            electron:addForce(proton)
        end
    end

    if love.mouse.isDown("l") then
        down = true
        self.force = self.force + dt
        if self.force > 1 then
            self.force = 1
        end
    elseif down then
        Shock:fire(self.force)
        down = false
        self.force = 0

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

function LevelTest:draw()
    for index, table in pairs(self.all) do
        for index2, whatever in pairs(table) do
            if whatever.draw then
                whatever:draw()
            end
        end
    end
    self.darkness = ((self.maxElectrons-#self.el)/self.minElectrons)
    love.graphics.setColor(0, 0, 0, 0*self.darkness)
    love.graphics.rectangle("fill", 0, 0, 1024, 600)
end

function LevelTest:restart()
    self:__init()
    self:load()
end

function LevelTest:keypressed(key, u)
    if key == "r" then
        self:restart()
    elseif key == "escape" then
        stack:pop()
        stack:current():load()
    end
end


function LevelTest:mousepressed(x, y, button)
end

--Collision function
function beginContact(a, b, coll)
    LevelTest:beginContact(a, b, coll)
end

function LevelTest:beginContact(a, b, coll)
    local objecta = a:getUserData()
    local objectb = b:getUserData()

    if (objecta.__name == "Proton") and (objectb.__name == "Electron") then
        for index, value in pairs(self.el) do 
            if value == objectb then
            	
                table.remove(self.el, index)
                local p1 = Explosion(value.body:getX(), value.body:getY(), 56, 222, 255, 120)
    			p1.system:start()
    			table.insert(self.particles, p1)
    			value.body:destroy()
            end
        end
        for index, value in pairs(self.proton) do
            if value == objecta then
            	
                table.remove(self.proton, index)
                local p1 = Explosion(value.body:getX(), value.body:getY(), 255, 0, 0, 120)
    			p1.system:start()
    			table.insert(self.particles, p1)
    			value.body:destroy()
            end
        end
    elseif (objecta.__name == "Electron") and (objectb.__name == "Proton") then
        for index, value in pairs(self.el) do 
            if value == objecta then
            	
                table.remove(self.el, index)
                local p1 = Explosion(value.body:getX(), value.body:getY(), 56, 222, 255, 120)
    			p1.system:start()
    			table.insert(self.particles, p1)
    			value.body:destroy()
            end
        end
        for index, value in pairs(self.proton) do
            if value == objectb then

                table.remove(self.proton, index)
                local p1 = Explosion(value.body:getX(), value.body:getY(), 255, 0, 0, 120)
    			p1.system:start()
    			table.insert(self.particles, p1)
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
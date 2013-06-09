require("core/helper")
require("core/physicshelper")
require("core/state")

require("classes/wall")
require("classes/coloredwall")
require("classes/electron")
require("classes/proton")
require("classes/magnet")
require("classes/shock")
require("classes/portal")

require("classes/tail")
require("classes/explosion")
require("classes/shockeffect")

Level = class("Level", State)

function Level:__init()
    self.force = 0
    self.index = 0
    self.string = {"", 0, 0}
    self.stringtimer = 0
    self.mousetype = 1
end

function Level:load()
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

    local magnet = Magnet(world, 250, 400, 20, 200, 12, "Electron")
    table.insert(self.magnet, magnet)

    local proton = Proton(world, 400, 100)
    proton.body:setLinearVelocity(0, 100)
    table.insert(self.proton, proton)

    local el = Electron(world, 100, 200)
    el.body:setLinearVelocity(0, 800)
    table.insert(self.el, el)

    local cwall = ColoredWall(world, 220, 200, 50, 400, "static", 10, 10, 10, 20)
    table.insert(self.walls, cwall)

    self.darkness = 0 
    self.maxElectrons = 22
    self.minElectrons = -1
    self.endtimer = 0

    self.limitshock = 3
    self.magnetlimitp = 1
    self.magnetlimite = 1
    self.down = false
end

function Level:update(dt)
    world:update(dt)
    if self.minElectrons >= #self.el then
        self.endtimer = self.endtimer + dt
        if self.endtimer > 1.5 then 
            local canvas = love.graphics.newScreenshot()
            screenshot = love.graphics.newImage(canvas)
            local save = {}
            save.saves = self.index+1
            success = love.filesystem.write( "save.lua", table.show(save, "saved"))
            local canvas = love.graphics.newScreenshot()
            screenshot = love.graphics.newImage(canvas)
            stack:push(gameover)
        end
    end
    for index, magnet in pairs(self.magnet) do
        for index2, el in pairs(self.el) do
            magnet:addForce(el, dt)
        end
        for index2, proton in pairs(self.proton) do
            magnet:addForce(proton, dt)
        end
    end
    for index, portal in pairs(self.portal) do
        for index2, el in pairs(self.el) do
            portal:addForce(el, dt)
        end
        for index2, proton in pairs(self.proton) do
            portal:addForce(proton, dt)
        end
    end
    for index, proton in pairs(self.proton) do
        for indexzwo, protonzwo in pairs(self.proton) do
            if proton ~= protonzwo then
                proton:addForce(protonzwo, dt)
            end
        end
    end

    for index, electron in pairs(self.el) do
        for indexzwo, electronzwo in pairs(self.el) do
            if electron ~= electronzwo then
                electron:addForce(electronzwo, dt)
            end
        end
    end

    for index, proton in pairs(self.proton) do
        for index, electron in pairs(self.el) do
            proton:addForce(electron, dt)
            electron:addForce(proton, dt)
        end
    end

    if love.mouse.isDown("l") then
        if self.mousetype == 1 then
            self.force = self.force + dt
            self.down = true
        elseif self.mousetype == 2 then
            self.down = false
            self.force = 0
        end
        if self.force > 1 then
            self.force = 1
        end
    elseif self.down then
        Shock:fire(self.force)
        self.down = false
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
    if self.stringtimer < 3 then
        self.stringtimer = self.stringtimer + dt
    end
end

function Level:draw()
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
    if self.stringtimer < 6 then
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.setFont(resources.fonts.thirty)
        love.graphics.print(self.string[1], self.string[2], self.string[3])
    end
    if self.mousetype == 2 then
        love.graphics.setColor(255, 255, 255,  15)
        love.graphics.circle("fill", love.mouse.getX(), love.mouse.getY(), 25)
        love.graphics.circle("fill", love.mouse.getX(), love.mouse.getY(), 20)
        love.graphics.setColor(255, 255, 255, 15)
        love.graphics.circle("fill", love.mouse.getX(), love.mouse.getY(), 20)
        love.graphics.circle("fill", love.mouse.getX(), love.mouse.getY(), 15)
        love.graphics.setColor(255, 255, 255, 15)
        love.graphics.circle("fill", love.mouse.getX(), love.mouse.getY(), 15)
        love.graphics.setColor(255, 255, 255, 15)
        love.graphics.circle("fill", love.mouse.getX(), love.mouse.getY(), 8)
    end
end

function Level:restart()
    self:__init()
    self:load()
end

function Level:keypressed(key, u)
    if key == "r" then
        self:restart()
    elseif key == "escape" then
        stack:pop()
        stack:current():load()
    elseif key == " " then
        if self.mousetype == 1 then
            self.mousetype = 2
        elseif self.mousetype == 2 then
            self.mousetype = 1
        end
    end
end


function Level:mousepressed(x, y, button)
    if button == "m" then
        if self.mousetype == 1 then
            self.mousetype = 2
        elseif self.mousetype == 2 then
            self.mousetype = 1
        end
    end
    if button == "l" then
        if (self.magnetlimitp > 0) and (self.mousetype == 2) then
            local magnet = Magnet(world, love.mouse.getX(), love.mouse.getY(), 20, 200, 12, "Electron")
            table.insert(self.magnet, magnet)
            self.magnetlimitp = self.magnetlimitp - 1
        end
    elseif button == "r" then
        if (self.magnetlimite > 0) and (self.mousetype == 2) then
            local magnet = Magnet(world, love.mouse.getX(), love.mouse.getY(), 20, 200, 12, "Proton")
            table.insert(self.magnet, magnet)
            self.magnetlimite = self.magnetlimite - 2
        end
    end
end

--Collision function
function beginContact(a, b, coll)
    stack:current():beginContact(a, b, coll)
end

function Level:beginContact(a, b, coll)
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
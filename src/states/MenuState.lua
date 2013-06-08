require("core/resources")
require("core/helper")
require("core/state")

MenuState = class("MenuState", State)

function MenuState:__init()
    self.menupoints = {"Credits","New Game", "Resume","Exit"}
    self.index = 1
    self.runner = 0
    self.runner2 = 0
    self.font = resources.fonts.big
end

function MenuState:load()
    world = love.physics.newWorld()
    magnet = Magnet(world, love.graphics.getWidth() / 2 + 100, love.graphics.getHeight()/3, 20, 150, 12, "Electron")
    magnet2 = Magnet(world, love.graphics.getWidth() / 2  -100, love.graphics.getHeight()/3, 20, 150, 12, "Electron")
    self.el = Electron(world, 345, 150)
    self.el.body:setLinearVelocity(0, 63)
    self.index = 1
    love.graphics.setFont(self.font)
end


function MenuState:update(dt)
    magnet:addForce(self.el)
    magnet2:addForce(self.el)
    world:update(dt)
    self.runner = self.runner + dt/10
    if self.runner > 0.1 then
        self.runner = -0.1
    end
    love.timer.sleep(0.05)
    self.wobble = 1 + math.abs(self.runner)
    self.runner2 = self.runner2 + dt/7
    if self.runner2 > 0.1 then
        self.runner2 = -0.1
    end
    self.yscale = 1 + math.abs(self.runner2)

    local mousex, mousey = love.mouse.getPosition()
    if (mousey > 450 ) and (mousey < 500) then
        if (mousex > 1) and (mousex < 1) then
            self.index = 1
        end
    end
end


function MenuState:draw()
    love.graphics.setColor(255, 255, 255)

    for i = 1, 4, 1 do
        local scale = 1
        local text = self.menupoints[i]
        local x = i*(love.graphics.getWidth()/4.5)
        if (i-1) == self.index then
            scale = self.wobble
        else
            scale = self.wobble*0.8
        end
        love.graphics.print(text, x, 450, 0, scale-0.25, scale, self.font:getWidth(text)/2, self.font:getHeight(text)/2)
    end
    self.el:draw()
    magnet:draw()
    magnet2:draw()
end


function MenuState:keypressed(key, u)
    if key == "right" or key ==  "d" then
        if self.index < 3 then
            self.index = self.index + 1
        elseif self.index == 3 then
            self.index = 0
        end
    elseif key == "left" or key == "a" then
        if self.index > 0 then
            self.index = self.index -1
        elseif self.index == 0 then
            self.index = 3
        end
    elseif key == "return" then
        if self.index == 0 then
            stack:push(credit)
        elseif self.index == 1 then
            stack:push(levels[1])
        elseif self.index == 2 then 
            if love.filesystem.exists("save.lua") then
            chunk = love.filesystem.load( "save.lua" )
            chunk()
            stack:push(levels[saved.saves])
            else
            end
        elseif self.index == 3 then
            love.event.push("quit")
        end
    end
end

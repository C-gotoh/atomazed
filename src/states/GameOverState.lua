require("core/helper")

GameOverState = class("GameOverState", State)

function GameOverState:__init()
    self.menulist = {"Main Menu", "Restart" , "Exit"}
end

function GameOverState:load()
    self.flag = true
    self.index = 2
    self.shades = 250
    self.runner = 0
end

function GameOverState:update(dt)
    if self.flag == true and self.shades > 100 then
        self.shades = self.shades - dt * 280
    elseif self.flag == false then
        self.shades = self.shades + dt * 380
        if self.shades > 255 then
            self.shades = 255
        end
    end
    if self.flag == true and self.runner < 1 then
        self.runner = self.runner + dt*3
        if self.runner > 1 then
            self.runner = 1
        end
    elseif self.flag == false then
        self.runner = self.runner - dt*5
    end
    if self.runner < 0 then 
        if self.index == 1 then
            stack:pop()
            stack:pop()
            main:restart()
        elseif self.index == 2 then
            main:restart()
            stack:pop()
        elseif self.index == 3 then
            love.event.quit()
        end
    end
end

function GameOverState:draw()
    love.graphics.setColor(255, 255, 255, self.shades)
    love.graphics.draw(screenshot, 0, 0)

    love.graphics.setColor(255, 255, 255, 255*self.runner)
    love.graphics.setFont(resources.fonts.big)
    love.graphics.print("GAME OVER", 370, 200)
    for i, v in pairs(self.menulist) do
        local scroll = i * 200 + 50
        if i == self.index then
            love.graphics.setFont(resources.fonts.forty)
            love.graphics.print(v, scroll, 400)
        else
            love.graphics.setFont(resources.fonts.thirty)
            love.graphics.print(v, scroll, 400)
        end
    end
    love.graphics.setFont(resources.fonts.thirty)
end

function GameOverState:keypressed(key, unicode)
    if key == "left" or key == "a" then
        self.index = self.index -1
        if self.index < 1 then self.index = 3 end
    end
    if key == "right" or key == "d" then
        self.index = self.index + 1
        if self.index > 3 then self.index = 1 end
    end
    if key == "return" then
        self.flag = false       
    end
end
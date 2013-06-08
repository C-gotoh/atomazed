require("core/helper")
require("core/resources")

CreditsState = class("CreditsState", State)

function CreditsState:__init()
    self.bg = resources.images.arena
    self.names = {
                    {"Code:", "Arne Beer", "Hans-Ole", "Julian Tobergte"}, 
                    {"Graphics:", "Arne Beer", "Hans-Ole", "Julian Tobergte"}, 
                    {"Sounds:", "Gibts net"},
                    {"Idea:", "Arne Beer", "Hans-Ole", "Julian Tobergte"}
                }
end

function CreditsState:load()
    love.graphics.setFont(resources.fonts.default)
end

function CreditsState:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(self.bg, 0, 0)

    love.graphics.setColor(0, 0, 0)
    local y = 30
    for i = 1, #self.names, 1 do
        y = y + resources.fonts.default:getHeight()
        love.graphics.print(self.names[i][1], 50, y)
        for a = 2, #self.names[i], 1 do
            y = y + resources.fonts.default:getHeight()
            love.graphics.print(self.names[i][a], 60, y)
        end
    end
end

function CreditsState:keypressed(key, u)
    stack:push(menu)
end
require("core/resources")
require("core/stackhelper")
require("core/helper")

require("states/MainState")
require("states/MenuState")


function love.load()
    resources = Resources()

    resources:addFont("seventeen", "data/font/SwankyandMooMoo.ttf", 17)
    resources:addFont("twenty", "data/font/SwankyandMooMoo.ttf", 20)
    resources:addFont("twentyfive", "data/font/SwankyandMooMoo.ttf", 25)
    resources:addFont("thirty", "data/font/SwankyandMooMoo.ttf", 30)
    resources:addFont("forty", "data/font/SwankyandMooMoo.ttf", 40)
    resources:addFont("fifty", "data/font/SwankyandMooMoo.ttf", 60)
    
    resources:addFont("default", "data/font/SwankyandMooMoo.ttf", 20)
    resources:addFont("big", "data/font/SwankyandMooMoo.ttf", 60)

    resources:load()
    
    love.graphics.setMode(1024, 768, false, true, 0) -- Fensteroberfläche

    stack = StackHelper()
    main = MainState()
    menu = MenuState()
    
    stack:push(menu)
end


function love.update(dt)
    stack:update(dt)
end

function love.draw()
    stack:draw()
end 

function love.keypressed(key, u)
    stack:current():keypressed(key, u)
end

function love.keyreleased(key, u)
    stack:current():keyreleased(key, u)
end

function love.mousepressed(x, y, button)
    stack:current():mousepressed(x, y, button)
end

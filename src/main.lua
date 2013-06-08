require("util/resources")
require("util/gamestack")

require("states/MenuState")
require("states/LevelOne")

resources = Resources("data/")

function reset()
    -- start game
    stack = GameStack()
    main = MenuState()
    stack:push(main)
end

function love.load()
    resources:addFont("normal", "DejaVuSans.ttf", 20)

    resources:load()
  

    love.graphics.setMode(1024, 768, false, true, 0)
  
    levelone = LevelOne()

    reset()
end

function love.update(dt)
    stack:update(dt)
end

function love.draw()
    stack:draw()
end

function love.keypressed(k, u)
    stack:keypressed(k, u)
end

function love.mousepressed( x, y, button )
    stack:mousepressed(x, y, button)
end

function love.quit()
end

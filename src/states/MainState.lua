require("core/helper")
require("core/physicshelper")
require("core/state")


MainState = class("MainState", State)

function MainState:__init()

end

function MainState:load()
    love.graphics.setFont(resources.fonts.default)
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 9.81*64, true)
    world:setCallbacks(beginContact, endContact)

end

function MainState:update(dt)
    world:update(dt)
end

function MainState:draw()
end

function MainState:restart()
    world:destroy()
    self:__init()
end

function MainState:keypressed(key, u)
end


function MainState:mousepressed(x, y, button)
end

--Collision function
function beginContact(a, b, coll)
end
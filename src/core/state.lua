require("core/helper")

State = class("State")

State.renderBelow = false

function State:update(dt) end
function State:draw() end
function State:shutdown() end
function State:keypressed(key, u) end
function State:keyreleased(key, u) end
function State:mousepressed(x, y, key) end
function State:load() end

require("core/helper")

function DestroyBody(entity)
    local physics = entity:getComponent("PhysicsComponent")
    physics.body:destroy()
    engine:removeEntity(entity)
end

function distanceBetween(pos1, pos2)
    relativeX = pos1[1] - pos2[1]
    relativeY = pos1[2] - pos2[2]
    return math.sqrt(relativeX*relativeX + relativeY*relativeY)
end
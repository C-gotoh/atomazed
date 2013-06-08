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


function limitSystem(object, int)
    local rofl = {object.body:getLinearVelocity()}
    if rofl[1] > int then
        object.body:setLinearVelocity(int, rofl[2])
    end
    if rofl[2] > int then
        object.body:setLinearVelocity(rofl[1], int)
    end
    if rofl[2] < -int then
        object.body:setLinearVelocity(rofl[1], -int)
    end
    if rofl[1] < -int then
        object.body:setLinearVelocity(-int, rofl[2])
    end
end
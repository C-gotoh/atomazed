function Magnet:__init(world, x, y, r, force)
    self.body = love.physics.newBody(world, x, y, static)
    self.shape = love.physics.newCircleShape(r)
end

function Magnet:addForce(a)
    local posAx, posAy = a.body:getPosition()
    local posMx, posMy = self.body:getPosition()
    local distance = math.sqrt((posAx - posMx})^2 + (posAy - posBy)^2)

    if distance < r then
        local vectorscale = math.cos (distance * (1/force))
        forcevectorx = vectorscale*(posMx - posAx)
        forcevectory = vectorscale*(posMy - posAy)
        newvectorx, newvectory = a.body:getLinearVelocity()
        a.body:setLinearVelocity((newvectorx+forcevectorx),(newvectory+forcevectory))
    end
end

function Magnet:update(dt)

end

function Magnet:draw()
    love.graphic.circle("fill", self.body:getX, self.body:getY, 20)
end
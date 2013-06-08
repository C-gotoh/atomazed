function Magnet:__init(world, x, y, force)
    self.body = love.physics.newBody(world, x, y, static)
end

function Magnet:addforce(aX,aY,bX,bY)
    local posA = a.get.pos
    local posB = b.get.pos
    local distance = sqrt((posA.getX - posB.getX)^2 + (posA.getY - posB.getY)^2)

    if distance < ((math.pi/2)*force) then
        length = math.cos (distance * (1/force))
        forcevectorx = length*(bX - aX)
        forcevectory = length*(bY - aY)
        newvectorx = aX.getVelocity + forcevectorx
        newvectory = aY.getVelocity + forcevectory
    end
end

function Magnet:update(dt)

end

function Magnet:draw()
    love.graphic.draw(resources.graphic.electron, self.body:getX, self.body:getY)
end
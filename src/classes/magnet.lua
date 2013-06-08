Magnet = class("Magnet")

function Magnet:__init(world, x, y, r, fr, force)
    self.body = love.physics.newBody(world, x, y, static)
    self.shape = love.physics.newCircleShape(r)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fr = fr
    self.force = force
end

function Magnet:addForce(a)
    local posAx, posAy = a.body:getPosition()
    local posMx, posMy = self.body:getPosition()
    local distance = math.sqrt((posAx - posMx)^2 + (posAy - posMy)^2)

    if distance < self.fr then
        local vectorscale = (self.fr/distance) * (1/self.force)
        forcevectorx = vectorscale*(posMx - posAx)
        forcevectory = vectorscale*(posMy - posAy)
        newvectorx, newvectory = a.body:getLinearVelocity()
        a.body:applyForce(forcevectorx,forcevectory)
    end
end

function Magnet:update(dt)

end

function Magnet:draw()
    love.graphics.setColor(255, 37, 0, 255)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), 25)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), 20)
    love.graphics.setColor(255, 37, 0, 200)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), 20)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), 15)
    love.graphics.setColor(255, 37, 0, 120)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), 15)
    love.graphics.setColor(255, 37, 0, 80)
    love.graphics.circle("fill", self.body:getX(), self.body:getY(), 8)
end
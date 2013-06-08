Magnet = class("Magnet")

function Magnet:__init(world, x, y, r, fr, force, typ)
    self.body = love.physics.newBody(world, x, y, static)
    self.shape = love.physics.newCircleShape(r)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
    self.fr = fr
    self.force = force
    self.type = typ
end

function Magnet:addForce(object)
    local posAx, posAy = object.body:getPosition()
    local posMx, posMy = self.body:getPosition()
    local distance = math.sqrt((posAx - posMx)^2 + (posAy - posMy)^2)

    if distance < self.fr then
        local vectorscale = (self.fr/distance) * (1/self.force)
        if object.__name ~= self.type then
            vectorscale = -vectorscale
        end
        forcevectorx = vectorscale*(posMx - posAx)
        forcevectory = vectorscale*(posMy - posAy)
        newvectorx, newvectory = object.body:getLinearVelocity()
        object.body:applyForce(forcevectorx,forcevectory)
    end
end

function Magnet:update(dt)

end

function Magnet:draw()
    if self.type == "Electron" then
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
    elseif self.type == "Proton" then
        love.graphics.setColor(56, 222, 255, 255)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 25)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 20)
        love.graphics.setColor(56, 222, 255, 200)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 20)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 15)
        love.graphics.setColor(56, 222, 255, 12)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 15)
        love.graphics.setColor(56, 222, 255, 80)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 8)
    end 
end
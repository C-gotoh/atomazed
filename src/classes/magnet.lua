Magnet = class("Magnet")

function Magnet:__init(world, x, y, r, fr, force, typ)
    self.body = love.physics.newBody(world, x, y, static)
    self.shape = love.physics.newCircleShape(r)
    self.radius = r
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
    self.fr = fr -- range
    self.rangevisual = self.fr
    self.rangevisual2 = self.fr
    self.variabler = self.fr
    self.force = force
    self.type = typ
    self.counter = 0
    self.color_fac = force / 12
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
    



    if self.rangevisual < self.radius then
        self.rangevisual = self.fr
        self.counter = 0
    end
    
    self.rangevisual = self.rangevisual - (1+self.counter)
    self.counter = self.counter + 0.01



    self.rangevisual2 = self.rangevisual2 + 0.05

    self.variabler = 10*(math.sin(self.rangevisual2))+self.radius+15

end

function Magnet:draw()

    if self.type == "Electron" then
        love.graphics.setColor(255, 37, 0,  self.color_fac * 255)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 25)
        love.graphics.setColor(255, 255, 255, self.color_fac * 255)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 20)
        love.graphics.setColor(255, 37, 0, self.color_fac * 200)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 20)
        love.graphics.setColor(255, 255, 255, self.color_fac * 255)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 15)
        love.graphics.setColor(255, 37, 0, self.color_fac * 120)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 15)
        love.graphics.setColor(255, 37, 0, self.color_fac * 80)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 8)

        --visualize
        love.graphics.setColor(255, 37, 0, self.color_fac * 80)
        love.graphics.circle("line", self.body:getX(), self.body:getY(), self.variabler)

        love.graphics.setColor(255, 255, 255, 5)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.rangevisual)

        love.graphics.setColor(255, 37, 0, self.color_fac * 80)
        love.graphics.circle("line", self.body:getX(), self.body:getY(), self.rangevisual)

    elseif self.type == "Proton" then
        love.graphics.setColor(56 + (self.color_fac * 0.1), 222 + (self.color_fac * 0.1), 255 + (self.color_fac * 0.1), self.color_fac * 255)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 25)
        love.graphics.setColor(255, 255, 255, self.color_fac * 255)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 20)
        love.graphics.setColor(56, 222, 255, self.color_fac * 200)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 20)
        love.graphics.setColor(255, 255, 255, self.color_fac * 255)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 15)
        love.graphics.setColor(56, 222, 255, self.color_fac * 12)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 15)
        love.graphics.setColor(56, 222, 255, self.color_fac * 80)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), 8)

        --visualize
        love.graphics.setColor(56, 222, 255, self.color_fac * 80)
        love.graphics.circle("line", self.body:getX(), self.body:getY(), self.variabler)

        love.graphics.setColor(255, 255, 255, 5)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.rangevisual)

        love.graphics.setColor(255, 222, 255, self.color_fac * 80)
        love.graphics.circle("line", self.body:getX(), self.body:getY(), self.rangevisual)
    end 
end
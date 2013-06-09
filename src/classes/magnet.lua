Magnet = class("Magnet")

function Magnet:__init(world, x, y, r, fr, force, typ)
    self.body = love.physics.newBody(world, x, y, static)
    self.shape = love.physics.newCircleShape(r)
    self.radius = r
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
    self.fr = fr -- range
    self.rangevisual = 0
    self.wobblecounter = 0
    self.wobbleradius = fr
    self.force = force
    self.type = typ
    self.outercounter = 0
    self.fadevalue = 255
    self.color_fac = force / 12
end

function Magnet:addForce(object, dt)
    local posAx, posAy = object.body:getPosition()
    local posMx, posMy = self.body:getPosition()
    local distance = math.sqrt((posAx - posMx)^2 + (posAy - posMy)^2)
    self.dtf = dt * 60
    if distance < self.fr then
        local vectorscale = (self.fr/distance) * (1/self.force)
        if object.__name ~= self.type then
            vectorscale = -vectorscale
        end
        forcevectorx = vectorscale*(posMx - posAx)
        forcevectory = vectorscale*(posMy - posAy)
        newvectorx, newvectory = object.body:getLinearVelocity()
        object.body:applyForce((forcevectorx * self.dtf),(forcevectory * self.dtf))
    end
end

function Magnet:update(dt)

    -- calculate outer

    if self.rangevisual > self.fr then
        self.rangevisual = 0
        self.outercounter = 0
        self.fadevalue = 255 -- reset fade
    end
    
    self.rangevisual = self.rangevisual + (1+self.outercounter)
    self.outercounter = self.outercounter + 0.01

         -- calc fade
    self.fadevalue = 255 - self.rangevisual



    -- calculate innerwobble

    self.wobblecounter = self.wobblecounter + 0.05

    self.wobbleradius = 10*(math.sin(self.wobblecounter))

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

        --visualize range

            --inner wobble

        love.graphics.setColor(255, 37, 0, self.color_fac * 80)
        love.graphics.circle("line", self.body:getX(), self.body:getY(), self.wobbleradius+self.radius+20)

            --outer

        love.graphics.setColor(255, 255, 255, 5)
        --love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.rangevisual)

        love.graphics.setColor(255, 37, 0, self.fadevalue)
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

        --visualize range

            -- inner wobble

        love.graphics.setColor(56, 222, 255, self.color_fac * 80)
        love.graphics.circle("line", self.body:getX(), self.body:getY(), self.wobbleradius+self.radius+20)

            -- outer circle

        love.graphics.setColor(255, 255, 255, 5)
        love.graphics.circle("fill", self.body:getX(), self.body:getY(), self.rangevisual)

        love.graphics.setColor(255, 222, 255, self.fadevalue)
        love.graphics.circle("line", self.body:getX(), self.body:getY(), self.rangevisual)
    end 
end
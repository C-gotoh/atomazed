Electron = class("Electron")

function Electron:__init(world, x, y)
	self.body = love.physics.newBody(world, x, y, "dynamic")
	self.shape = love.physics.newCircleShape(10)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setUserData(self)
	self.fixture:setRestitution(0.5)
	self.tail = Tail(x, y, 0, 0, 255, 120)
	self.x = x
	self.y = y
	self.wobble = 1
	self.fr = 100
	self.force = 15
	self.tail.system:start()
end

function Electron:addForce(object, dt)
    local posAx, posAy = object.body:getPosition()
    local posMx, posMy = self.body:getPosition()
    local distance = math.sqrt((posAx - posMx)^2 + (posAy - posMy)^2)
    self.dtf = dt * 60

    if distance < self.fr then
        local vectorscale = (self.fr/distance) * (1/self.force)
        if object.__name == self.__name then
            vectorscale = -vectorscale
        end
        forcevectorx = vectorscale*(posMx - posAx)
        forcevectory = vectorscale*(posMy - posAy)
        newvectorx, newvectory = object.body:getLinearVelocity()
        object.body:applyForce(forcevectorx * self.dtf,forcevectory *self.dtf)
    end
end

function Electron:update(dt)
	self.tail.system:setPosition(self.body:getX(), self.body:getY())
	self.tail:update(dt)
	if self.flag == true then
		self.wobble = self.wobble + dt*0.2
		if self.wobble > 1 then
			self.flag = false
		end
	else 
		self.wobble = self.wobble - dt*0.2
		if self.wobble < 0.8 then
			self.flag = true
		end
	end
end

function Electron:draw()
	self.tail:draw()
	love.graphics.setColor(56, 222, 255, 80)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 15*self.wobble)
	love.graphics.setColor(56, 222, 255, 120)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 10*self.wobble)
	love.graphics.setColor(56, 222, 255, 200)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 7*self.wobble)
	love.graphics.setColor(56, 222, 255, 255)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 4*self.wobble)
end
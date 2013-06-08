Proton = class("Proton")

function Proton:__init(world, x, y)
	self.body = love.physics.newBody(world, x, y, "dynamic")
	self.shape = love.physics.newCircleShape(18)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setUserData(self)
	self.fixture:setRestitution(0.5)  
	self.wobble = 1
	self.fr = 100
	self.force = 13
end

function Proton:update(dt)
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

function Proton:addForce(object)
    local posAx, posAy = object.body:getPosition()
    local posMx, posMy = self.body:getPosition()
    local distance = math.sqrt((posAx - posMx)^2 + (posAy - posMy)^2)

    if distance < self.fr then
        local vectorscale = (self.fr/distance) * (1/self.force)
        if object.__name == self.__name then
            vectorscale = -vectorscale
        end
        forcevectorx = vectorscale*(posMx - posAx)
        forcevectory = vectorscale*(posMy - posAy)
        newvectorx, newvectory = object.body:getLinearVelocity()
        object.body:applyForce(forcevectorx,forcevectory)
    end
end

function Proton:draw()
	love.graphics.setColor(255, 37, 0, 80)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 25*self.wobble)
	love.graphics.setColor(255, 37, 0, 120)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 20*self.wobble)
	love.graphics.setColor(255, 37, 0, 200)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 15*self.wobble)
	love.graphics.setColor(255, 37, 0, 255)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 8*self.wobble)
end
Portal = class("Portal")

function Portal:__init(world, x, y, xt, yt)
	self.body = love.physics.newBody(world, x, y, "static")
	self.shape = love.physics.newCircleShape(5)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setUserData(self)
	self.xt = xt
	self.yt = yt
	self.wobble = 1
	self.fr = 50
	self.force = 1
end

function Portal:update(dt)
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

function Portal:addForce(object)
    local posAx, posAy = object.body:getPosition()
    local posMx, posMy = self.body:getPosition()
    local distance = math.sqrt((posAx - posMx)^2 + (posAy - posMy)^2)

    if distance < self.fr then
        local vectorscale = (self.fr/distance) * (1/self.force)
        forcevectorx = vectorscale*(posMx - posAx)
        forcevectory = vectorscale*(posMy - posAy)
        newvectorx, newvectory = object.body:getLinearVelocity()
        object.body:applyForce(forcevectorx,forcevectory)
    end
end

function Portal:draw()
	love.graphics.setColor(50, 50, 50, 80)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 15*self.wobble)
	love.graphics.setColor(100, 100, 100, 120)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 10*self.wobble)
	love.graphics.setColor(150, 150, 150, 200)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 7*self.wobble)
	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 4*self.wobble)

	love.graphics.setColor(0, 255, 0, 50)
	love.graphics.circle("fill", self.xt, self.yt, 15)
	love.graphics.setColor(150, 150, 150, 200)
	love.graphics.circle("fill", self.xt, self.yt, 10)
	love.graphics.setColor(100, 100, 100, 120)
	love.graphics.circle("fill", self.xt, self.yt, 7)
	love.graphics.setColor(0, 255, 0, 255)
	love.graphics.circle("fill", self.xt, self.yt, 4)
end
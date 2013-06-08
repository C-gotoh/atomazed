Electron = class("Electron")

function Electron:__init(world, x, y)
	self.body = love.physics.newBody(world, x, y, "dynamic")
	self.shape = love.physics.newCircleShape(20)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setUserData(self)
	self.wobble = 1
end

function Electron:update(dt)
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
	love.graphics.setColor(56, 222, 255, 80)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 15*self.wobble)
	love.graphics.setColor(56, 222, 255, 120)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 10*self.wobble)
	love.graphics.setColor(56, 222, 255, 200)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 7*self.wobble)
	love.graphics.setColor(56, 222, 255, 255)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 4*self.wobble)
end
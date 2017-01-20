Tail = class("Tail")

function Tail:__init(x, y, r, g, b, a)
	self.system = love.graphics.newParticleSystem(resources.images.particle, 1000)
	self.system:setEmitterLifetime(-1)
	self.system:setPosition(x, y)
	self.system:setSpeed(10, 12)
	self.system:setEmissionRate(80)
	self.system:setColors(r,g,b,a,r,g,b,a)
	self.system:setSizes(0.3, 0.3)
	self.system:setParticleLifetime(1, 2)
	self.system:setDirection(180)
	self.system:setSpread(30)
end

function Tail:update(dt)
	self.system:update(dt)
end

function Tail:draw()
	love.graphics.draw(self.system)
end

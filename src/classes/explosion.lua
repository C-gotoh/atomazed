Explosion = class("Explosion")

function Explosion:__init(x, y, r, g, b, a)
	self.system = love.graphics.newParticleSystem(resources.images.particle, 1000)
	self.system:setLifetime(0.25)
	self.system:setPosition(x, y)
	self.system:setSpeed(200, 250)
	self.system:setColors(255,255,255,255,r,g,b,a)
	self.system:setSizes(0.3, 0.3)
	self.system:setParticleLife(1, 1)
	self.system:setEmissionRate(400)
	self.system:setRadialAcceleration(-500, -500)
	self.system:setDirection(360)
	self.system:setSpread(360)
end

function Explosion:update(dt)
	self.system:update(dt)
end

function Explosion:draw()
	self.system:draw(dt)
end
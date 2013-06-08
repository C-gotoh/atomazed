Shockeffect = class("shockeffect")

function Shockeffect:__init(world, x, y, intensity, maxradius)
	self.x = x
	self.y = y
	self.wobble = 1
	self.r = 1
	if intensity > 255 then
		self.intensity = 255
	else
		self.intensity = intensity
	end
	self.maxradius = maxradius * 1/2
end

function Shockeffect:update(dt)
	if self.maxradius > self.r then
		self.r = self.r + 3
	else
		self.intensity = 0
	end
	if self.intensity > 0 then
		self.intensity = self.intensity - 5
	end
end

function Shockeffect:draw()
	love.graphics.setColor(255, 255, 255, self.intensity)
	love.graphics.circle("line", self.x, self.y, self.r)

	love.graphics.setColor(240, 240, 240, self.intensity)
	love.graphics.circle("line", self.x, self.y, self.r-50)

	--love.graphics.setColor(200, 200, 200, self.intensity)
	--love.graphics.circle("line", self.x, self.y, self.r-100)
end
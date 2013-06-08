Shockeffect = class("shockeffect")

function Shockeffect:__init(world, x, y)
	self.x = x
	self.y = y
	self.wobble = 1
	self.r = 1
end

function Shockeffect:update(dt)
	self.r = self.r + 1
end

function Shockeffect:draw()
	love.graphics.setColor(255, 255, 255, 80)
	love.graphics.circle("line", self.x, self.y, self.r)
	--[[love.graphics.setColor(255, 37, 0, 120)
	love.graphics.circle("line", self.x, self.y, i)
	love.graphics.setColor(255, 37, 0, 200)
	love.graphics.circle("line", self.x, self.y, i)
	love.graphics.setColor(255, 37, 0, 255)
	love.graphics.circle("line", self.x, self.y, i)
	--]]
end
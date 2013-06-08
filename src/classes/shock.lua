Shock = class("Shock")

function Shock:fire(force)
	self.x = love.mouse.getX()
	self.y = love.mouse.getY()
	self.forcec = force
	for index, value in pairs(levelone.el) do
		self.forcec = (1/(distance(value.body:getX(), value.body:getY(), self.x, self.y)))
		value.body:applyForce((self.forcec*(value.x-self.x)), (self.forcec*(value.y - self.y)))
	end
end
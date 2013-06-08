Shock = class("Shock")

function Shock:fire(force)
	self.x = love.mouse.getX()
	self.y = love.mouse.getY()
	for index, value in pairs(levelone.el) do
		force = (1/(distance(value.body:getX(), value.body:getY(), self.x, self.y)^2))
		value.body:applyForce((force*math.abs(value.x-self.x)), (force*math.abs(value.y - self.y)))
	end
end
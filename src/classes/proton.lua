Proton = class("Proton")

function Proton:__init(world, x, y)
	self.body = love.physics.newBody(world, x, y, "dynamic")
	self.shape = love.physics.newCircleShape(20)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setUserData(self)
end

function Proton:update(dt)

end

function Proton:draw()
	love.graphics.setColor(0, 0, 255, 125)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 20)
end
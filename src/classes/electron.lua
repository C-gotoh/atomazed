Electron = class("Electron")

function Electron:__init(world, x, y)
	self.body = love.physics.newBody(world, x, y, "dynamic")
	self.shape = love.physics.newCircleShape(20)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setUserData(self)
end

function Electron:update(dt)

end

function Electron:draw()
	love.graphics.setColor(0, 0, 255, 125)
	love.graphics.circle("fill", self.body:getX(), self.body:getY(), 20)
end
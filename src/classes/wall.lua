Wall = class("Wall")

function Wall:__init(world, x, y, l, h, type)
    self.body = love.physics.newBody(world, x, y, type)
    self.shape = love.physics.newRectangleShape(l, h)
    self.fixture = love.physics.newFixture(self.body, self.shape)
   	self.fixture:setUserData(self)
end
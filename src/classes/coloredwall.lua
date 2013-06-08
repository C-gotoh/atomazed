ColoredWall = class("ColoredWall")

function ColoredWall:__init(world, x, y, l, h, type, r, g, b, a)
    self.body = love.physics.newBody(world, x, y, type)
    self.shape = love.physics.newRectangleShape(l, h)
    self.fixture = love.physics.newFixture(self.body, self.shape)
   	self.fixture:setUserData(self)
   	self.r = r 
   	self.g = g
   	self.b = b 
   	self.a = a  
end

function ColoredWall:draw()
	love.graphics.setColor(self.r, self.g, self.b, self.a)
	love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end
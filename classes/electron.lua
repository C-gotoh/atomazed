function Electron:__init(world, x, y)
	self.body = love.physics.newBody(world, x, y, dynamic)
end

function Electron:changeVelocity(x,y)
	
end

function Electron:update(dt)

end

function Electron:draw()
	love.graphics.draw(resources.graphic.electron, self.body:getX, self.body:get)
end
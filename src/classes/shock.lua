Shock = class("Shock")

function Shock:fire(force)
	self.x = love.mouse.getX()
	self.y = love.mouse.getY()
	self.forcec = force*4000
	fireradius = 400

	for index, value in pairs(levelone.el) do
		if (distance(value.body:getX(),value.body:getY(),self.x,self.y) < 150) then
			self.distancescale = (1/(distance(value.body:getX(), value.body:getY(), self.x, self.y)))
			self.vectorlength = math.sqrt((value.body:getX()-self.x)^2 + (value.body:getY() - self.y)^2)
			self.xforce = (self.distancescale*self.forcec*((value.body:getX()-self.x)/self.vectorlength))
			if self.xforce > 4000 then
				self.xforce = 4000
			end
			self.yforce = (self.distancescale*self.forcec*((value.body:getY() - self.y)/self.vectorlength))
			if self.yforce > 4000 then
				self.yforce = 4000
			end
			value.body:applyForce(self.xforce, self.yforce)

			draw()

		end
	end
end

function love.draw()
    love.graphics.circle( "fill", 300, 300, 50, 100 )
end
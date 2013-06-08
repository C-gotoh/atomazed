Shock = class("Shock")

function Shock:fire(force)
	self.x = love.mouse.getX()
	self.y = love.mouse.getY()
	self.scaledforce = force*400
	self.fireradius = 400

	for index, value in pairs(levelone.el) do
		if (distance(value.body:getX(),value.body:getY(),self.x,self.y) < self.fireradius) then
			self.distancescale = (self.fireradius/(distance(value.body:getX(), value.body:getY(), self.x, self.y)))
			if self.distancescale > 50 then
				self.distancescale = 50
			end
			self.vectorlength = math.sqrt((value.body:getX()-self.x)^2 + (value.body:getY() - self.y)^2)
			self.xforce = (self.distancescale*self.scaledforce*((value.body:getX()-self.x)/self.vectorlength))
			if self.xforce > 400 then
				self.xforce = 400
			end
			if self.xforce < 400 then
				self.xforce = -400
			end
			self.yforce = (self.distancescale*self.scaledforce*((value.body:getY() - self.y)/self.vectorlength))
			if self.yforce > 400 then
				self.yforce = 400
			end
			if self.yforce < 400 then
				self.yforce = -400
			end
			value.body:applyForce(self.xforce, self.yforce)


		end
	end
end
Shock = class("Shock")

function Shock:fire(force)
	self.x = love.mouse.getX()
	self.y = love.mouse.getY()
	self.force = force
	if self.force < 2 then
		self.force = 10
	elseif self.force > 2 then
		self.force = 150
	else
		self.force = 70
	end

	print (self.force)

	self.fireradius = 300

	for index, value in pairs(levelone.el) do
		if (distance(value.body:getX(),value.body:getY(),self.x,self.y) < self.fireradius) then
			self.distancescale = (self.fireradius/(distance(value.body:getX(), value.body:getY(), self.x, self.y)))

			self.vectorlength = math.sqrt((value.body:getX()-self.x)^2 + (value.body:getY() - self.y)^2)
			self.xforce = (self.distancescale*self.force*((value.body:getX()-self.x)/self.vectorlength))
			if self.xforce > 400 then
				self.xforce = 400
			end
			if self.xforce < -400 then
				self.xforce = -400
			end
			self.yforce = (self.distancescale*self.force*((value.body:getY() - self.y)/self.vectorlength))
			if self.yforce > 400 then
				self.yforce = 400
			end
			if self.yforce < -400 then
				self.yforce = -400
			end
			print(self.xforce, self.yforce)
			value.body:applyForce(self.xforce, self.yforce)
			--limitSystem(value, 400)
			--value.body:applyForce(200,200)
		end
	end
end
Shock = class("Shock")

function Shock:fire(force)
	if stack:current().limitshock == 0 and stack:current().mousetype == 1 then
		return
	elseif stack:current().mousetype == 1 then
		stack:current().limitshock = stack:current().limitshock - 1
		self.x = love.mouse.getX()
		self.y = love.mouse.getY()
		self.force = force
		if self.force > 25 then
			self.force = 25
		end
		self.fireradius = 200

		self.maxforce = 20

		shockeffect = Shockeffect(world, self.x, self.y, self.force, self.fireradius)

		table.insert(stack:current().shockeffect, shockeffect)

		for index, value in pairs(stack:current().el) do
			if (distance(value.body:getX(),value.body:getY(),self.x,self.y) < self.fireradius) then
				self.distancescale = 1
				self.distancescale = (self.fireradius/math.sqrt(distance(value.body:getX(), value.body:getY(), self.x, self.y)))
				if self.distancescale < 0 then
				self.distancescale = 0
				end
				self.vectorlength = math.sqrt((value.body:getX()-self.x)^2 + (value.body:getY() - self.y)^2)

				self.xforce = (self.distancescale*self.force*((value.body:getX()-self.x)/self.vectorlength))
				self.xforce = self.xforce

				self.yforce = (self.distancescale*self.force*((value.body:getY() - self.y)/self.vectorlength))
				self.yforce = self.yforce 

				if math.abs(self.xforce) > self.maxforce or math.abs(self.yforce) > self.maxforce then

					if math.abs(self.xforce) > math.abs(self.yforce) then

						if math.abs(self.yforce) > self.maxforce then
							self.ratio = math.abs(self.maxforce/self.xforce)

							if self.xforce > 0 then
								self.xforce = self.maxforce
							else
								self.xforce = -self.maxforce
							end

							self.yforce = self.yforce*self.ratio
							value.body:applyForce(self.xforce,self.yforce)
						else
							self.ratio = math.abs(self.maxforce/self.xforce)

							if self.xforce > 0 then
								self.xforce = self.maxforce
							else
								self.xforce = -self.maxforce
							end
							
							self.yforce = self.yforce*self.ratio
							value.body:applyForce(self.xforce,self.yforce)
						end

					else

						if math.abs(self.xforce) > self.maxforce then

							self.ratio = math.abs(self.maxforce/self.yforce)
							
							if self.yforce > 0 then
								self.yforce = self.maxforce
							else
								self.yforce = -self.maxforce
							end
							
							self.xforce = self.xforce*self.ratio
							value.body:applyForce(self.xforce,self.yforce)
						else

							self.ratio = math.abs(self.maxforce/self.yforce)
							
							if self.yforce > 0 then
								self.yforce = self.maxforce
							else
								self.yforce = -self.maxforce
							end
							
							self.xforce = self.xforce*self.ratio
							value.body:applyForce(self.xforce,self.yforce)
						end
					end
				end

				value.body:applyLinearImpulse(self.xforce, self.yforce, self.x, self.y)

			end
		end

		for index, value in pairs(stack:current().proton) do
			if (distance(value.body:getX(),value.body:getY(),self.x,self.y) < self.fireradius) then
				self.distancescale = (self.fireradius/(distance(value.body:getX(), value.body:getY(), self.x, self.y)))

				self.vectorlength = math.sqrt((value.body:getX()-self.x)^2 + (value.body:getY() - self.y)^2)
				self.xforce = (self.distancescale*self.force*((value.body:getX()-self.x)/self.vectorlength))
				if self.xforce > self.maxforce then
					self.xforce = self.maxforce
				end
				if self.xforce < -self.maxforce then
					self.xforce = -self.maxforce
				end
				self.yforce = (self.distancescale*self.force*((value.body:getY() - self.y)/self.vectorlength))
				if self.yforce > self.maxforce then
					self.yforce = self.maxforce
				end
				if self.yforce < -self.maxforce then
					self.yforce = -self.maxforce
				end
				value.body:applyLinearImpulse(self.xforce, self.yforce, self.x, self.y)
			end
		end

	end
end
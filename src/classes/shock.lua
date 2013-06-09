Shock = class("Shock")

function Shock:fire(force)
	if stack:current().limitshock == 0 and stack:current().mousetype == 1 then
		return
	elseif stack:current().mousetype == 1 then
		stack:current().limitshock = stack:current().limitshock - 1
		self.x = love.mouse.getX()
		self.y = love.mouse.getY()
		self.force = force
		print("force " .. self.force)
		if self.force > 25 then
			self.force = 25
		end
		self.fireradius = 200

		shockeffect = Shockeffect(world, self.x, self.y, self.force, self.fireradius)

		table.insert(stack:current().shockeffect, shockeffect)

		for index, value in pairs(stack:current().el) do
			if (distance(value.body:getX(),value.body:getY(),self.x,self.y) < self.fireradius) then
				self.distancescale = 1
				self.distancescale = (self.fireradius/math.sqrt(distance(value.body:getX(), value.body:getY(), self.x, self.y)))
				if self.distancescale < 0 then
				self.distancescale = 0
				end
				print("distancescale " .. self.distancescale)
				self.vectorlength = math.sqrt((value.body:getX()-self.x)^2 + (value.body:getY() - self.y)^2)

				self.xforce = (self.distancescale*self.force*((value.body:getX()-self.x)/self.vectorlength))
				self.xforce = self.xforce * 100

				-- if self.xforce > 6 then
				--  	self.xforce = 6
				-- end
				-- if self.xforce < -6 then
				-- 	self.xforce = -6
				-- end
				-- self.xforce = self.xforce * 100
				print("xforce " .. self.xforce)
				
				self.yforce = (self.distancescale*self.force*((value.body:getY() - self.y)/self.vectorlength))
				self.yforce = self.yforce * 100

				-- if self.yforce > 6 then
				--  	self.yforce = 6
				-- end
				-- if self.yforce < -6 then
				-- 	self.yforce = -6
				-- end
				-- self.yforce = self.yforce * 100

				print("yforce " .. self.yforce)
				if math.abs(self.xforce) > 800 or math.abs(self.yforce) > 800 then

					if math.abs(self.xforce) > math.abs(self.yforce) then

						if math.abs(self.yforce) > 800 then
							self.ratio = math.abs(800/self.xforce)

							if self.xforce > 0 then
								self.xforce = 800
							else
								self.xforce = -800
							end

							self.yforce = self.yforce*self.ratio
							print(self.xforce .. " lol " .. self.yforce)
							value.body:applyForce(self.xforce,self.yforce)
						else
							self.ratio = math.abs(800/self.xforce)

							if self.xforce > 0 then
								self.xforce = 800
							else
								self.xforce = -800
							end
							
							self.yforce = self.yforce*self.ratio
							print(self.xforce .. " lol " .. self.yforce)
							value.body:applyForce(self.xforce,self.yforce)
						end

					else

						if math.abs(self.xforce) > 800 then

							self.ratio = math.abs(800/self.yforce)
							
							if self.yforce > 0 then
								self.yforce = 800
							else
								self.yforce = -800
							end
							
							self.xforce = self.xforce*self.ratio
							print(self.xforce .. " lol " .. self.yforce)
							value.body:applyForce(self.xforce,self.yforce)
						else

							self.ratio = math.abs(800/self.yforce)
							
							if self.yforce > 0 then
								self.yforce = 800
							else
								self.yforce = -800
							end
							
							self.xforce = self.xforce*self.ratio
							print(self.xforce .. " lol " .. self.yforce)
							value.body:applyForce(self.xforce,self.yforce)
						end
					end
				end

				print("-------")
				print(self.xforce .. " lol " .. self.yforce)
				value.body:applyForce(self.xforce, self.yforce)

			end
		end

		print("//////////")
		for index, value in pairs(stack:current().proton) do
			if (distance(value.body:getX(),value.body:getY(),self.x,self.y) < self.fireradius) then
				self.distancescale = (self.fireradius/(distance(value.body:getX(), value.body:getY(), self.x, self.y)))

				self.vectorlength = math.sqrt((value.body:getX()-self.x)^2 + (value.body:getY() - self.y)^2)
				self.xforce = (self.distancescale*self.force*((value.body:getX()-self.x)/self.vectorlength))
				if self.xforce > 800 then
					self.xforce = 800
				end
				if self.xforce < -800 then
					self.xforce = -800
				end
				self.yforce = (self.distancescale*self.force*((value.body:getY() - self.y)/self.vectorlength))
				if self.yforce > 800 then
					self.yforce = 800
				end
				if self.yforce < -800 then
					self.yforce = -800
				end
				value.body:applyForce(self.xforce, self.yforce)
			end
		end

	end
end
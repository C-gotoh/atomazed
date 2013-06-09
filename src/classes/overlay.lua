function drawStats()
	
	local x = love.graphics.getWidth() - 170
	
	love.graphics.setColor(255,255,255,200)	
	love.graphics.setFont(resources.fonts.twenty)
	love.graphics.print(stack:current().limitshock, x - 33, 20)

	-- draws Black White Circle
	love.graphics.circle("line", x, 30, 10, 100)
	love.graphics.circle("line", x, 30, 7, 100)
	love.graphics.circle("line", x, 30, 4, 100)	

	x = love.graphics.getWidth() - 100
	love.graphics.setColor(255,255,255,200)
	love.graphics.print(stack:current().magnetlimitp, x - 33, 20)

	--draws Red Circle
	love.graphics.setColor(255, 37, 0, 80)
	love.graphics.circle("fill", x, 30, 10, 100)
	love.graphics.setColor(255, 37, 0, 80)
	love.graphics.circle("fill", x, 30, 4, 100)

	x = love.graphics.getWidth() - 30
	love.graphics.setColor(255,255,255,200)
	love.graphics.print(stack:current().magnetlimite, x - 33, 20)

	-- draws Blue Circle
	love.graphics.setColor(56, 222, 255, 80)
	love.graphics.circle("fill", x, 30, 10, 100)
	love.graphics.setColor(30, 222, 255, 80)
	love.graphics.circle("fill", x, 30, 4, 100)

	if stack:current().maxElectrons then
		love.graphics.print(stack:current().maxElectrons-stack:current().maxElectrons .. "/" .. 
			stack:current().maxElectrons-stack:current().minElectrons .. "  Electrons", 110, 20)
		love.graphics.print(stack:current().__name,30, 20)
	end
end
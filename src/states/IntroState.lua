require("classes/overlay")

IntroState = class("IntroState", State)

function IntroState:__init()
	self.font = resources.fonts.thirty
end

function IntroState:load()
	love.graphics.setFont(self.font)
    self.limitshock = 10
    self.magnetlimitp = 4
    self.magnetlimite = 2
end

function IntroState:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("Press \"R\" for Restart", 50, 50 )
	love.graphics.setColor(200, 50, 0, 255)
	love.graphics.print("Press 'Left mousebutton' to create a shockwave  \n or to place a Proton Tower", 50, 150 )	
	love.graphics.setColor(0, 50, 200, 255)
	love.graphics.print("Press 'Right mousebutton' to place a Electron Tower", 50, 250 )
	love.graphics.setColor(50, 200, 50, 255)
	love.graphics.print("Press middle 'Mousebutton' or 'Space' \n to switch Mousemode  ", 50, 350 )	

	drawStats()

	-- White Circles
	love.graphics.setColor(255,255,255,200)
	love.graphics.circle("line", 750, 120, 14, 100)
	love.graphics.circle("line", 750, 120, 10, 100)
	love.graphics.circle("line", 750, 120, 6, 100)

	-- Blue Circle
	love.graphics.setColor(56, 222, 255, 80)
	love.graphics.circle("fill", 750, 220, 14, 100)
	love.graphics.setColor(30, 222, 255, 80)
	love.graphics.circle("fill",750, 220, 6, 100)

	-- Red Circle
	love.graphics.setColor(255, 37, 0, 80)
	love.graphics.circle("fill", 750, 170, 14, 100)
	love.graphics.setColor(255, 37, 0, 80)
	love.graphics.circle("fill",750, 170, 6, 100)

	-- Right text
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("Shockwave", 800, 100 )	
	love.graphics.setColor(200, 50, 0, 255)
	love.graphics.print("Protonmagnet", 800, 150 )	
	love.graphics.setColor(0, 50, 200, 255)
	love.graphics.print("Electronmagnet", 800, 200 )	
end

function IntroState:keypressed(key, button)
	if key then 
		stack:pop()
		stack:push(levels[1])
	end
end
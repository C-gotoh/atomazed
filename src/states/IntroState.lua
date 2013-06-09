IntroState = class("IntroState", State)

function IntroState:__init()
	self.font = resources.fonts.thirty
end

function IntroState:load()
	love.graphics.setFont(self.font)
end

function IntroState:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("Press \"R\" for Restart", 50, 50 )
	love.graphics.setColor(200, 50, 0, 255)
	love.graphics.print("Press 'Left mousebutton' to create a shockwave  \n or to place a Proton Tower", 50, 150 )	
	love.graphics.setColor(50, 200, 50, 255)
	love.graphics.print("Press 'Right mousebutton' to place a Electron Tower", 50, 250 )
	love.graphics.setColor(0, 50, 200, 255)
	love.graphics.print("Press middle 'Mousebutton' or 'Space' \n to switch Mousemode  ", 50, 350 )	
end

function IntroState:keypressed(key, button)
	if key then 
		stack:pop()
		stack:push(levels[1])
	end
end
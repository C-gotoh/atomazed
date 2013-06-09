IntroState = class("IntroState", State)

function IntroState:__init()
	self.font = resources.fonts.forty
end

function IntroState:load()
	love.graphics.setFont(self.font)
end

function IntroState:draw()
	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.print("Press \"R\" for Restart", 50, 50 )
	love.graphics.print("Press left mousebutton to create a shockwave", 50, 150 )	
end

function IntroState:keypressed(key, button)
	if key then 
		stack:pop()
		stack:push(levels[1])
	end
end
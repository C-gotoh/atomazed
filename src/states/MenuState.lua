require("src/util/helper")
require("src/util/gamestate")

MenuState = class("MenuState", GameState)

function MenuState:__init()
	love.graphics.setFont(resources.fonts.normal)
end

function MenuState:update(dt)

end

function MenuState:draw()
	love.graphics.print("ROFLCOPTER BIATCH", 200, 200)
end
require("src/util/helper")
require("src/util/gamestate")
require("src/states/Level")

LevelOne = class("LevelOne", Level)


function LevelOne:__init()
	self.__super.__init(self)
	world = love.physics.newWorld(0, 0, true)
end

function LevelOne:start()

end

function LevelOne:update(dt)

end

function LevelOne:draw()

end

function beginCollision(a, b, coll)

end
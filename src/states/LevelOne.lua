require("src/util/helper")
require("src/util/gamestate")
require("src/states/Level")

LevelOne = class("LevelOne", Level)


function LevelOne:__init()
	self.__super.__init(self)
end

function LevelOne:start()

end

function LevelOne:update(dt)

end

function LevelOne:draw()

end

function beginCollision(a, b, coll)

end
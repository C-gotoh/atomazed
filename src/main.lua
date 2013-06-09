require("core/mathhelper")
require("core/resources")
require("core/stackhelper")
require("core/helper")

require("states/Level")
require("states/Level1")
require("states/Level2")
require("states/Level2_1")
require("states/Level2_2")
require("states/Level3")
require("states/Level4")
require("states/Level5")
require("states/Level6")
require("states/Level7")
require("states/Level8")
require("states/Level9")
require("states/Level10")
require("states/Level11")
require("states/Level12")
require("states/Level13")
require("states/Level14")
require("states/Level15")
require("states/LevelEnd")
require("states/MenuState")
require("states/GameOverState")
require("states/CreditsState")
require("states/IntroState")


function love.load()
    resources = Resources()

    resources:addFont("seventeen", "data/font/Audiowide-Regular.ttf", 15)
    resources:addFont("twenty", "data/font/Audiowide-Regular.ttf", 15)
    resources:addFont("twentyfive", "data/font/Audiowide-Regular.ttf", 23)
    resources:addFont("thirty", "data/font/Audiowide-Regular.ttf", 25)
    resources:addFont("forty", "data/font/Audiowide-Regular.ttf", 32)
    resources:addFont("fifty", "data/font/Audiowide-Regular.ttf", 40)
    
    resources:addFont("default", "data/font/Audiowide-Regular.ttf", 18)
    resources:addFont("big", "data/font/Audiowide-Regular.ttf", 50)
    resources:addImage("particle", "data/images/particle.png", 60)

    resources:load()
    
    love.graphics.setMode(1024, 600, false, true, 0) -- Fensteroberfläche

    stack = StackHelper()
    menu = MenuState()
    gameover = GameOverState()
    credit = CreditsState()
    intro = IntroState()
    levels = {}
    level1 = Level1()
    level2 = Level2()
    level2_1 = Level2_1()
    level3 = Level3()
    level4 = Level4()
    level5 = Level5()
    level6 = Level6()
    level7 = Level7()
    level8 = Level8()
    level9 = Level9()
    level10 = Level10()
    level11 = Level11()
    level20 = Level20()
    level21 = Level21()

    levelend = LevelEnd()

    levels[1] = level1
    levels[2] = level2_1
    levels[3] = level3
    levels[4] = level4
    levels[5] = level5
    levels[6] = level6
    levels[7] = level7
    levels[8] = level8
    levels[9] = level9
    levels[10] = level10
    levels[11] = level11

    levels[23] = levelend
    stack:push(menu)
end


function love.update(dt)
    stack:update(dt)
end

function love.draw()
    stack:draw()
end 

function love.keypressed(key, u)
    stack:current():keypressed(key, u)
end

function love.keyreleased(key, u)
    stack:current():keyreleased(key, u)
end

function love.mousepressed(x, y, button)
    stack:current():mousepressed(x, y, button)
end

require("core/helper")
require("core/physicshelper")
require("core/state")

require("classes/wall")
require("classes/coloredwall")
require("classes/electron")
require("classes/proton")
require("classes/magnet")
require("classes/shock")
require("classes/portal")

require("classes/tail")
require("classes/explosion")
require("classes/shockeffect")


Level5 = class("Level5", Level)

function Level5:__init()
    self.__super.__init(self)
    self.force = 0
    self.index = 5
    self.string = {"Even more tricky...", 200, 100}
end

function Level5:load()
    self.all = {}
    self.walls = {}
    table.insert(self.all, self.walls)
    self.el = {}
    table.insert(self.all, self.el)
    self.proton = {}
    table.insert(self.all, self.proton)
    self.magnet = {}
    table.insert(self.all, self.magnet)
    self.portal = {}
    table.insert(self.all, self.portal)
    self.positionQueue = {}
    self.particles = {}
    table.insert(self.all, self.particles)
    self.shockeffect = {}
    table.insert(self.all, self.shockeffect)
    

    love.graphics.setFont(resources.fonts.default)
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginContact, endContact)

    local wall = Wall(world, 512, 0, 1024, 4, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 512, 600, 1024, 4, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 1024, 300, 4, 600, "static")
    table.insert(self.walls, wall)
    wall = Wall(world, 0, 300, 4, 600, "static")
    table.insert(self.walls, wall)


    local el = Electron(world,50, 300)
    table.insert(self.el, el)

    self.darkness = 0 
    self.maxElectrons = 22
    self.minElectrons = 0
    self.endtimer = 0

    self.limitshock = 1
    self.limitmagnet1 = 0
    self.limitmagnet2 = 0

    local cwall = ColoredWall(world, 270, 600, 30, 400, "static", 100, 100, 100, 255)
    table.insert(self.walls, cwall)
        
    local cwall = ColoredWall(world, 270, 600, 30, 500, "static", 100, 100, 100, 255)
    table.insert(self.walls, cwall)

    local cwall = ColoredWall(world, 650, 200, 30, 400, "static", 100, 100, 100, 255)
    table.insert(self.walls, cwall)

    local magnet = Magnet(world, 270, 350, 20, 200, 12, "Electron")
    table.insert(self.magnet, magnet)

    local magnet = Magnet(world, 650, 400, 20, 200, 12, "Electron")
    table.insert(self.magnet, magnet)

    local proton = Proton(world, 840, 330)
    table.insert(self.proton, proton)
end

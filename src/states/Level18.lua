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


Level18 = class("Level18", Level)

function Level18:__init()
    self.__super.__init(self)
    self.force = 0
    self.index = 11
    self.string = {"They call it the square.", 200, 100}
end

function Level18:load()
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

    self.darkness = 0 
    self.maxElectrons = 2
    self.minElectrons = 0
    self.endtimer = 0

    self.limitshock = 2
    self.magnetlimitp = 0
    self.magnetlimite = 0

    local cwall = ColoredWall(world, 512, 300, 250, 250, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)

    local el = Electron(world,512, 50)
    table.insert(self.el, el)

    local el = Electron(world,512, 550)
    table.insert(self.el, el)

    local proton = Proton(world, 500, 300)
    table.insert(self.proton, proton)

    local proton = Proton(world, 660, 300)
    table.insert(self.proton, proton)

    local magnet = Magnet(world, 512, 300, 20, 150, 12, "Proton")
    table.insert(self.magnet, magnet)
end

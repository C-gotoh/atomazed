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
require("classes/overlay")

Level14 = class("Level14", Level)

function Level14:__init()
    self.__super.__init(self)
    self.force = 0
    self.index = 14
    self.string = {"", 0, 0}
    self.stringtimer = 0
    self.mousetype = 1
    self.feedback = false
    self.feedbacktimer = 0.5
    self.disabled = false
end

function Level14:load()
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

    local proton = Proton(world, 50, 550)
    table.insert(self.proton, proton)

    local el = Electron(world, 450, 250)
    table.insert(self.el, el)

    local el = Electron(world, 900, 50)
    table.insert(self.el, el)

    local portal = Portal(world, 350, 80, 900, 550)
    table.insert(self.portal, portal)

    local portal = Portal(world, 600, 250, 400, 350)
    table.insert(self.portal, portal)

    local proton = Proton(world, 800, 450)
    table.insert(self.proton, proton)

    local cwall = ColoredWall(world, 512, 300, 10, 600, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)
    cwall = ColoredWall(world, 512, 300, 1024, 10, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)

    self.darkness = 0 
    self.maxElectrons = 2
    self.minElectrons = 0
    self.endtimer = 0

    self.limitshock = 2
    self.magnetlimitp = 0
    self.magnetlimite = 0
    self.down = false
end
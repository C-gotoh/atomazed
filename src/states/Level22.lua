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

Level22 = class("Level22", Level)

function Level22:__init()
    self.__super.__init(self)
    self.force = 0
    self.index = 12
    self.string = {"", 0, 0}
    self.stringtimer = 0
    self.mousetype = 1
    self.feedback = false
    self.feedbacktimer = 0.5
    self.disabled = false
end

function Level22:load()
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

    local el = Electron(world, 200, 150)
    table.insert(self.el, el)

    local portal = Portal(world, 400, 350, 850, 450)
    table.insert(self.portal, portal)

    local proton = Proton(world, 750, 570)
    table.insert(self.proton, proton)

    local cwall = ColoredWall(world, 512, 500, 10, 210, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)
    cwall = ColoredWall(world, 768, 400, 502, 10, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)
    cwall = ColoredWall(world, 850, 550, 10, 160, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)
    cwall = ColoredWall(world, 850, 420, 10, 30, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)

    self.darkness = 0 
    self.maxElectrons = 2
    self.minElectrons = 0
    self.endtimer = 0

    self.limitshock = 1
    self.magnetlimitp = 0
    self.magnetlimite = 1
    self.down = false
end
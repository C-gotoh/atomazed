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

Level13 = class("Level13", Level)

function Level13:__init()
    self.__super.__init(self)
    self.force = 0
    self.index = 0
    self.string = {"", 0, 0}
    self.stringtimer = 0
    self.mousetype = 1
    self.feedback = false
    self.feedbacktimer = 0.5
    self.disabled = false
end

function Level13:load()
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


    local proton = Proton(world, 200, 100)
    table.insert(self.proton, proton)

    local el = Electron(world, 250, 550)
    table.insert(self.el, el)

    local cwall = ColoredWall(world, 300, 500, 600, 10, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)

    self.darkness = 0 
    self.maxElectrons = 1
    self.minElectrons = 0
    self.endtimer = 0

    self.limitshock = 2
    self.magnetlimitp = 2
    self.magnetlimite = 0
    self.down = false
end
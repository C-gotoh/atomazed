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
    self.string = {"HansHardcore", 250, 100}
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

    local magnet = Magnet(world, 250, 400, 20, 200, 12, "Electron")
    table.insert(self.magnet, magnet)

    local proton = Proton(world, 400, 100)
    proton.body:setLinearVelocity(0, 100)
    table.insert(self.proton, proton)

    local el = Electron(world, 100, 200)
    el.body:setLinearVelocity(0, 800)
    table.insert(self.el, el)

    local cwall = ColoredWall(world, 220, 200, 50, 400, "static", 10, 10, 10, 20)
    table.insert(self.walls, cwall)

    self.darkness = 0 
    self.maxElectrons = 22
    self.minElectrons = 0
    self.endtimer = 0

    self.limitshock = 3
    self.limitmagnet1 = 0
    self.limitmagnet2 = 0

end

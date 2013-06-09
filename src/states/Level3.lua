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

require("classes/explosion")
require("classes/shockeffect")


Level3 = class("Level3", Level)

function Level3:__init()
    self.__super.__init(self)
    self.force = 0
    self.index = 3
    self.string = {"Control the flock", 750, 400}
end

function Level3:load()
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

    local proton = Proton(world, 800, 480)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 850, 430)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 831, 568)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 730, 560)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 931, 360)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 621, 240)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 730, 25)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 890, 480)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 600, 453)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 481, 280)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 500, 490)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 800, 534)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 705, 361)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 682, 200)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 700, 311)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local el = Electron(world, 150, 173)
    el.body:setLinearVelocity(0, 0)
    table.insert(self.el, el)

    local el = Electron(world, 151, 132)
    el.body:setLinearVelocity(0, 0)
    table.insert(self.el, el)

    local el = Electron(world, 30, 40)
    el.body:setLinearVelocity(0, 0)
    table.insert(self.el, el)

    local el = Electron(world, 100, 100)
    el.body:setLinearVelocity(0, 0)
    table.insert(self.el, el)

    local cwall = ColoredWall(world, 200, 200, 20, 400, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)

    local cwall = ColoredWall(world, 400, 400, 20, 400, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)

    local cwall = ColoredWall(world, 600, 200, 20, 400, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)


    self.darkness = 0 
    self.maxElectrons = 1
    self.minElectrons = 0
    self.endtimer = 0

    self.limitshock = 15
    self.magnetlimitp = 0
    self.magnetlimite = 0
end

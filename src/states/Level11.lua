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


Level11 = class("Level11", Level)

function Level11:__init()
    self.__super.__init(self)
    self.force = 0
    self.index = 11
    self.string = {"More Objects!", 500, 50}
end

function Level11:load()
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

    local proton = Proton(world, 580, 400)
    proton.body:setLinearVelocity(0, 10)
    table.insert(self.proton, proton)

    local proton = Proton(world, 580, 400)
    proton.body:setLinearVelocity(200, 200)
    table.insert(self.proton, proton)

    local proton = Proton(world, 733, 434)
    proton.body:setLinearVelocity(0, 10)
    table.insert(self.proton, proton)

    local proton = Proton(world, 769, 315)
    proton.body:setLinearVelocity(0, 10)
    table.insert(self.proton, proton)

    local proton = Proton(world, 539, 256)
    proton.body:setLinearVelocity(0, 10)
    table.insert(self.proton, proton)


    local proton = Proton(world, 583, 431)
    proton.body:setLinearVelocity(0, 10)
    table.insert(self.proton, proton)



    local el = Electron(world, 213, 200)
    proton.body:setLinearVelocity(0, 5)
    table.insert(self.el, el)

    local el = Electron(world, 300, 300)
    proton.body:setLinearVelocity(0, 5)
    table.insert(self.el, el)

    local el = Electron(world, 403, 50)
    proton.body:setLinearVelocity(0, 5)
    table.insert(self.el, el)

    local el = Electron(world, 303, 500)
    proton.body:setLinearVelocity(0, 5)
    table.insert(self.el, el)

    local el = Electron(world, 203, 100)
    proton.body:setLinearVelocity(0, 5)
    table.insert(self.el, el)

    local el = Electron(world, 263, 160)
    proton.body:setLinearVelocity(0, 5)
    table.insert(self.el, el)

    self.darkness = 0 
    self.maxElectrons = 6
    self.minElectrons = 2
    self.endtimer = 0

    self.limitshock = 3
    self.magnetlimitp = 0
    self.magnetlimite = 0
end

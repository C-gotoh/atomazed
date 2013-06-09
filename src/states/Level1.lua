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


Level1 = class("Level1", Level)

function Level1:__init()
    self.__super.__init(self)
    self.force = 0
    self.index = 1
    self.string = {"Well, try to push that Electrons in those Protons", 100, 500}
end

function Level1:load()
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

    local el = Electron(world, 153, 100)
    proton.body:setLinearVelocity(0, 5)
    table.insert(self.el, el)

    self.darkness = 0 
    self.maxElectrons = 22
    self.minElectrons = 0
    self.endtimer = 0

    self.limitshock = 3
    self.limitmagnet1 = 1
    self.limitmagnet2 = 1
end

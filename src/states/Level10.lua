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


Level10 = class("Level10", Level)

function Level10:__init()
    self.__super.__init(self)
    self.force = 0
    self.index = 1
    self.string = {"Repulsion can be a good thing.", 100, 450}
end

function Level10:load()
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

    local cwall = ColoredWall(world, love.graphics.getWidth()/2, 100, 20, 200, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)

    local cwall = ColoredWall(world, love.graphics.getWidth()/2, 500, 20, 200, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)

    local proton = Proton(world, 733, 434)
    proton.body:setLinearVelocity(0, 10)
    table.insert(self.proton, proton)

    local proton = Proton(world, 769, 315)
    proton.body:setLinearVelocity(0, 10)
    table.insert(self.proton, proton)



    local el = Electron(world, 213, 200)
    proton.body:setLinearVelocity(0, 5)
    table.insert(self.el, el)

    local el = Electron(world, 153, 100)
    proton.body:setLinearVelocity(0, 5)
    table.insert(self.el, el)

    self.darkness = 0 
    self.maxElectrons = 2
    self.minElectrons = 2
    self.endtimer = 0

    self.limitshock = 3
    self.magnetlimitp = 1
    self.magnetlimite = 1

    local magnet = Magnet(world, 350, 300, 20, 200, 12, "Proton")
    table.insert(self.magnet, magnet)
end

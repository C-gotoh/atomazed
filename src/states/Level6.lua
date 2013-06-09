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


Level6 = class("Level6", Level)

function Level6:__init()
    self.__super.__init(self)
    self.force = 0
    self.index = 6
    self.string = {"Use the Portal... \n It's a one way ticket", 330, 320}
end

function Level6:load()
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


    local proton = Proton(world, 850, 400)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 900, 300)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local proton = Proton(world, 850, 200)
    proton.body:setLinearVelocity(0, 0)
    table.insert(self.proton, proton)

    local el = Electron(world, 300, 200)
    el.body:setLinearVelocity(0, 0)
    table.insert(self.el, el)

    local el = Electron(world, 300, 400)
    el.body:setLinearVelocity(0, 0)
    table.insert(self.el, el)

    local el = Electron(world, 300, 300)
    el.body:setLinearVelocity(0, 0)
    table.insert(self.el, el)

    local el = Electron(world, 200, 300)
    el.body:setLinearVelocity(0, 0)
    table.insert(self.el, el)

    local cwall = ColoredWall(world, 640, 300, 60, 600, "static", 100, 100, 100, 50)
    table.insert(self.walls, cwall)

    local portal = Portal(world, 500, 300, 800, 400)
    table.insert(self.portal, portal)

    self.darkness = 0 
    self.maxElectrons = 22
    self.minElectrons = 1
    self.endtimer = 0

    self.limitshock = 5
    self.magnetlimitp = 1
    self.magnetlimite = 0

end

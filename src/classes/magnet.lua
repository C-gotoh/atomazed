function Magnet:__init(world, x, y, force)
    self.body = love.physics.newBody(world, x, y, static)
end

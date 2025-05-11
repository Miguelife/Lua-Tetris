Spritesheet = {}
Spritesheet.__index = Spritesheet

function Spritesheet.new(path, tileSize)
    local self = setmetatable({ }, Spritesheet)
    self.path = path
    self.tileSize = tileSize
    self.image = love.graphics.newImage(path)
    return self
end

function Spritesheet:getSprite(x, y)
    return love.graphics.newQuad(
        x * self.tileSize,
        y * self.tileSize,
        self.tileSize,
        self.tileSize,
        self.image:getWidth(),
        self.image:getHeight()
    )
end

function Spritesheet:draw(sprite, x, y)
    love.graphics.draw(
        self.image,
        sprite,
        x * Constants.tileSize,
        y * Constants.tileSize,
        0,
        Constants.tileSize / self.tileSize,
        Constants.tileSize / self.tileSize
    )
end
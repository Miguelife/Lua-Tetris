--[[
    spritesheet.lua
    
    Utility for loading and managing sprite sheets for game graphics.
    Handles loading image files, extracting individual sprites as quads,
    and drawing sprites at specified locations with proper scaling.
]]

-- REQUIRES
local Constants = require("src.utils.constants")

-- Spritesheet
local Spritesheet = {}
Spritesheet.__index = Spritesheet

---Creates a new Spritesheet instance
---@param path string Path to the image file containing the spritesheet
---@param tileSize number The size of each tile/sprite in the sheet (both width and height)
---@return table The new Spritesheet instance
function Spritesheet.new(path, tileSize)
    local self = setmetatable({ }, Spritesheet)
    -- Path to the spritesheet image
    self.path = path
    -- Size of each tile in the original spritesheet
    self.tileSize = tileSize
    -- The loaded image resource
    self.image = love.graphics.newImage(path)
    return self
end

---Extracts a sprite/quad from the spritesheet at the specified grid coordinates
---@param x number The x coordinate in the grid (0-based)
---@param y number The y coordinate in the grid (0-based)
---@return userdata The LÖVE Quad object representing the extracted sprite
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

---Draws a sprite at the specified grid coordinates
---@param sprite userdata The LÖVE Quad object to draw
---@param x number The x coordinate to draw at (in grid cells, not pixels)
---@param y number The y coordinate to draw at (in grid cells, not pixels)
function Spritesheet:draw(sprite, x, y)
    love.graphics.draw(
        self.image,
        sprite,
        x * Constants.tileSize,
        y * Constants.tileSize,
        0,
        Constants.tileSize / self.tileSize, -- Scale factor for width
        Constants.tileSize / self.tileSize  -- Scale factor for height
    )
end

return Spritesheet

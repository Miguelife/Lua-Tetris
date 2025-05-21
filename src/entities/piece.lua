--[[
    piece.lua
    
    Represents a single square piece of a tetrimino in the game.
    Each tetrimino is composed of multiple Piece objects arranged in a specific pattern.
    This class handles the positioning and rendering of individual pieces.
]]

-- REQUIRES
local Spritesheet = require("src.utils.spritesheet")
local Constants = require("src.utils.constants")

-- MARK: PIECE
local Piece = {}
Piece.__index = Piece

---Creates a new piece at the specified coordinates with the given sprite
---@param x number The x coordinate relative to tetrimino center
---@param y number The y coordinate relative to tetrimino center
---@param sprite table The sprite object to use for rendering this piece
---@return table The new Piece instance
function Piece.new(x, y, sprite)
    local self = setmetatable({ }, Piece)
    -- Position of the piece relative to its parent tetrimino
    self.position = { x = x, y = y }
    -- Visual representation of the piece
    self.sprite = sprite
    return self
end

---Draws the piece on screen using its sprite and position
function Piece:draw()
    local spritesheet = Spritesheet.new("assets/spritesheets/spritesheet.png", Constants.spriteSheetTileSize)

    love.graphics.setColor(1, 1, 1) -- White color tint (no tint)
    spritesheet:draw(self.sprite, self.position.x, self.position.y)
end

return Piece
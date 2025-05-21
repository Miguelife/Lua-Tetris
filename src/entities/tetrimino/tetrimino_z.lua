--[[
    tetrimino_z.lua
    
    Z-shaped tetrimino implementation.
    Extends the base Tetrimino class and implements the specific
    shape and behavior of the Z tetrimino.
    This piece is the mirror image of the S tetrimino.
]]

-- REQUIRES
local Piece = require("src.entities.piece")
local Tetrimino = require("src.entities.tetrimino.tetrimino_base")
local Spritesheet = require("src.utils.spritesheet")
local Constants = require("src.utils.constants")

-- MARK: TETRIMINO Z
local TetriminoZ = {}
TetriminoZ.__index = TetriminoZ
setmetatable(TetriminoZ, Tetrimino)

---Creates a new Z-shaped tetrimino
---@return table The new TetriminoZ instance
function TetriminoZ.new()
    local self = setmetatable(Tetrimino.new(), TetriminoZ)

    -- Load the specific sprite for this tetrimino
    local spritesheet = Spritesheet.new("assets/spritesheets/spritesheet.png", Constants.spriteSheetTileSize)
    self.sprite = spritesheet:getSprite(1, 0)
    return self
end

---Gets the pieces that make up this tetrimino based on its current rotation
---@return table Array of Piece objects positioned to form a Z shape
function TetriminoZ:getPieces()
    -- Rotation 0: Z shape horizontal orientation
    if self.rotation == 0 then
        return {
            Piece.new(-1, 0, self.sprite),  -- Top left
            Piece.new(0, 0, self.sprite),   -- Top middle
            Piece.new(0, 1, self.sprite),   -- Bottom middle
            Piece.new(1, 1, self.sprite),   -- Bottom right
        }
    -- Rotation 90: Z shape vertical orientation
    elseif self.rotation == 90 then
        return {
            Piece.new(1, 0, self.sprite),   -- Top right
            Piece.new(1, 1, self.sprite),   -- Middle right
            Piece.new(0, 1, self.sprite),   -- Middle left
            Piece.new(0, 2, self.sprite),   -- Bottom left
        }
    -- Rotation 180: Z shape horizontal orientation (same as 0 but shifted down)
    elseif self.rotation == 180 then
        return {
            Piece.new(-1, 1, self.sprite),  -- Middle left
            Piece.new(0, 1, self.sprite),   -- Middle middle
            Piece.new(0, 2, self.sprite),   -- Bottom middle
            Piece.new(1, 2, self.sprite),   -- Bottom right
        }
    -- Rotation 270: Z shape vertical orientation (same as 90 but shifted left)
    elseif self.rotation == 270 then
        return {
            Piece.new(0, 0, self.sprite),   -- Top middle
            Piece.new(0, 1, self.sprite),   -- Middle middle
            Piece.new(-1, 1, self.sprite),  -- Middle left
            Piece.new(-1, 2, self.sprite),  -- Bottom left
        }
    end
    
    -- Default case (should never happen, but ensures we always return something)
    return {}
end

return TetriminoZ

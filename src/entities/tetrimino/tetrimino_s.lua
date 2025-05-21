--[[
    tetrimino_s.lua
    
    S-shaped tetrimino implementation.
    Extends the base Tetrimino class and implements the specific
    shape and behavior of the S tetrimino.
]]

-- REQUIRES
local Piece = require("src.entities.piece")
local Tetrimino = require("src.entities.tetrimino.tetrimino_base")
local Spritesheet = require("src.utils.spritesheet")
local Constants = require("src.utils.constants")

-- MARK: TETRIMINO S
local TetriminoS = {}
TetriminoS.__index = TetriminoS
setmetatable(TetriminoS, Tetrimino)

---Creates a new S-shaped tetrimino
---@return table The new TetriminoS instance
function TetriminoS.new()
    local self = setmetatable(Tetrimino.new(), TetriminoS)

    -- Load the specific sprite for this tetrimino
    local spritesheet = Spritesheet.new("assets/spritesheets/spritesheet.png", Constants.spriteSheetTileSize)
    self.sprite = spritesheet:getSprite(2, 0)
    return self
end

---Gets the pieces that make up this tetrimino based on its current rotation
---@return table Array of Piece objects positioned to form an S shape
function TetriminoS:getPieces()
    -- Rotation 0: S shape horizontal orientation
    if self.rotation == 0 then
        return {
            Piece.new(0, 0, self.sprite),   -- Top middle
            Piece.new(1, 0, self.sprite),   -- Top right
            Piece.new(-1, 1, self.sprite),  -- Bottom left
            Piece.new(0, 1, self.sprite),   -- Bottom middle
        }
    -- Rotation 90: S shape vertical orientation
    elseif self.rotation == 90 then
        return {
            Piece.new(0, 0, self.sprite),   -- Top
            Piece.new(0, 1, self.sprite),   -- Middle top
            Piece.new(1, 1, self.sprite),   -- Middle right
            Piece.new(1, 2, self.sprite),   -- Bottom right
        }
    -- Rotation 180: S shape horizontal orientation (same as 0 but shifted down)
    elseif self.rotation == 180 then
        return {
            Piece.new(0, 1, self.sprite),   -- Middle middle
            Piece.new(1, 1, self.sprite),   -- Middle right
            Piece.new(-1, 2, self.sprite),  -- Bottom left
            Piece.new(0, 2, self.sprite),   -- Bottom middle
        }
    -- Rotation 270: S shape vertical orientation (same as 90 but shifted left)
    elseif self.rotation == 270 then
        return {
            Piece.new(-1, 0, self.sprite),  -- Top left
            Piece.new(-1, 1, self.sprite),  -- Middle left
            Piece.new(0, 1, self.sprite),   -- Middle middle
            Piece.new(0, 2, self.sprite),   -- Bottom middle
        }
    end
    
    -- Default case (should never happen, but ensures we always return something)
    return {}
end

return TetriminoS

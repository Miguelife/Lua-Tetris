--[[
    tetrimino_i.lua
    
    I-shaped tetrimino implementation (long straight piece).
    Extends the base Tetrimino class and implements the specific
    shape and behavior of the I tetrimino.
]]

-- REQUIRES
local Piece = require("src.entities.piece")
local Tetrimino = require("src.entities.tetrimino.tetrimino_base")
local Spritesheet = require("src.utils.spritesheet")
local Constants = require("src.utils.constants")

-- MARK: TETRIMINO I
local TetriminoI = {}
TetriminoI.__index = TetriminoI
setmetatable(TetriminoI, Tetrimino)

---Creates a new I-shaped tetrimino (long straight piece)
---@return table The new TetriminoI instance
function TetriminoI.new()
    local self = setmetatable(Tetrimino.new(), TetriminoI)

    -- Load the specific sprite for this tetrimino
    local spritesheet = Spritesheet.new("assets/spritesheets/spritesheet.png", Constants.spriteSheetTileSize)
    self.sprite = spritesheet:getSprite(5, 0)
    return self
end

---Gets the pieces that make up this tetrimino based on its current rotation
---@return table Array of Piece objects positioned to form an I shape
function TetriminoI:getPieces()
    -- Rotation 0: horizontal line
    if self.rotation == 0 then
        return {
            Piece.new(-1, 0, self.sprite), -- Leftmost
            Piece.new(0, 0, self.sprite),  -- Center-left
            Piece.new(1, 0, self.sprite),  -- Center-right
            Piece.new(2, 0, self.sprite),  -- Rightmost
        }
    -- Rotation 90: vertical line (offset to right)
    elseif self.rotation == 90 then
        return {
            Piece.new(1, -1, self.sprite), -- Top
            Piece.new(1, 0, self.sprite),  -- Upper middle
            Piece.new(1, 1, self.sprite),  -- Lower middle
            Piece.new(1, 2, self.sprite),  -- Bottom
        }
    -- Rotation 180: horizontal line (offset down)
    elseif self.rotation == 180 then
        return {
            Piece.new(-1, 1, self.sprite), -- Leftmost
            Piece.new(0, 1, self.sprite),  -- Center-left
            Piece.new(1, 1, self.sprite),  -- Center-right
            Piece.new(2, 1, self.sprite),  -- Rightmost
        }
    -- Rotation 270: vertical line
    elseif self.rotation == 270 then
        return {
            Piece.new(0, -1, self.sprite), -- Top
            Piece.new(0, 0, self.sprite),  -- Upper middle
            Piece.new(0, 1, self.sprite),  -- Lower middle
            Piece.new(0, 2, self.sprite),  -- Bottom
        }
    end
    
    -- Default case (should never happen, but ensures we always return something)
    return {}
end

return TetriminoI

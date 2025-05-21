--[[
    tetrimino_l.lua
    
    L-shaped tetrimino implementation.
    Extends the base Tetrimino class and implements the specific
    shape and behavior of the L tetrimino.
]]

-- REQUIRES
local Piece = require("src.entities.piece")
local Tetrimino = require("src.entities.tetrimino.tetrimino_base")
local Spritesheet = require("src.utils.spritesheet")
local Constants = require("src.utils.constants")

-- MARK: TETRIMINO L
local TetriminoL = {}
TetriminoL.__index = TetriminoL
setmetatable(TetriminoL, Tetrimino)

---Creates a new L-shaped tetrimino
---@return table The new TetriminoL instance
function TetriminoL.new()
    local self = setmetatable(Tetrimino.new(), TetriminoL)

    -- Load the specific sprite for this tetrimino
    local spritesheet = Spritesheet.new("assets/spritesheets/spritesheet.png", Constants.spriteSheetTileSize)
    self.sprite = spritesheet:getSprite(4, 0)
    return self
end

---Gets the pieces that make up this tetrimino based on its current rotation
---@return table Array of Piece objects positioned to form an L shape
function TetriminoL:getPieces()
    -- Rotation 0: L shape with vertical line on right
    if self.rotation == 0 then
        return {
            Piece.new(1, 0, self.sprite),   -- Top right
            Piece.new(-1, 1, self.sprite),  -- Bottom left
            Piece.new(0, 1, self.sprite),   -- Bottom middle
            Piece.new(1, 1, self.sprite),   -- Bottom right
        }
    -- Rotation 90: L shape pointing down
    elseif self.rotation == 90 then
        return {
            Piece.new(0, 0, self.sprite),   -- Top
            Piece.new(0, 1, self.sprite),   -- Middle
            Piece.new(0, 2, self.sprite),   -- Bottom
            Piece.new(1, 2, self.sprite),   -- Bottom right hook
        }
    -- Rotation 180: L shape with vertical line on left
    elseif self.rotation == 180 then
        return {
            Piece.new(-1, 1, self.sprite),  -- Middle left
            Piece.new(0, 1, self.sprite),   -- Middle
            Piece.new(1, 1, self.sprite),   -- Middle right
            Piece.new(-1, 2, self.sprite),  -- Bottom left hook
        }
    -- Rotation 270: L shape pointing up
    elseif self.rotation == 270 then
        return {
            Piece.new(-1, 0, self.sprite),  -- Top left hook
            Piece.new(0, 0, self.sprite),   -- Top
            Piece.new(0, 1, self.sprite),   -- Middle
            Piece.new(0, 2, self.sprite),   -- Bottom
        }
    end
    
    -- Default case (should never happen, but ensures we always return something)
    return {}
end

return TetriminoL

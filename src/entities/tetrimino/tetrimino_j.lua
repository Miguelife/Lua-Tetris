--[[
    tetrimino_j.lua
    
    J-shaped tetrimino implementation.
    Extends the base Tetrimino class and implements the specific
    shape and behavior of the J tetrimino (looks like a mirrored L).
]]

-- REQUIRES
local Piece = require("src.entities.piece")
local Tetrimino = require("src.entities.tetrimino.tetrimino_base")
local Spritesheet = require("src.utils.spritesheet")
local Constants = require("src.utils.constants")

-- MARK: TETRIMINO J
local TetriminoJ = {}
TetriminoJ.__index = TetriminoJ
setmetatable(TetriminoJ, Tetrimino)

---Creates a new J-shaped tetrimino
---@return table The new TetriminoJ instance
function TetriminoJ.new()
    local self = setmetatable(Tetrimino.new(), TetriminoJ)

    -- Load the specific sprite for this tetrimino
    local spritesheet = Spritesheet.new("assets/spritesheets/spritesheet.png", Constants.spriteSheetTileSize)
    self.sprite = spritesheet:getSprite(6, 0)
    return self
end

---Gets the pieces that make up this tetrimino based on its current rotation
---@return table Array of Piece objects positioned to form a J shape
function TetriminoJ:getPieces()
    -- Rotation 0: J shape with vertical line on left
    if self.rotation == 0 then
        return {
            Piece.new(-1, 0, self.sprite),  -- Top left
            Piece.new(-1, 1, self.sprite),  -- Bottom left
            Piece.new(0, 1, self.sprite),   -- Middle
            Piece.new(1, 1, self.sprite),   -- Right
        }
    -- Rotation 90: J shape pointing up
    elseif self.rotation == 90 then
        return {
            Piece.new(0, 0, self.sprite),   -- Top
            Piece.new(0, 1, self.sprite),   -- Middle
            Piece.new(0, 2, self.sprite),   -- Bottom
            Piece.new(-1, 2, self.sprite),  -- Bottom left hook
        }
    -- Rotation 180: J shape with vertical line on right
    elseif self.rotation == 180 then
        return {
            Piece.new(-1, 1, self.sprite),  -- Left
            Piece.new(0, 1, self.sprite),   -- Middle
            Piece.new(1, 1, self.sprite),   -- Right
            Piece.new(1, 2, self.sprite),   -- Bottom right hook
        }
    -- Rotation 270: J shape pointing down
    elseif self.rotation == 270 then
        return {
            Piece.new(1, 0, self.sprite),   -- Top right hook
            Piece.new(0, 0, self.sprite),   -- Top
            Piece.new(0, 1, self.sprite),   -- Middle 
            Piece.new(0, 2, self.sprite),   -- Bottom
        }
    end
    
    -- Default case (should never happen, but ensures we always return something)
    return {}
end

return TetriminoJ

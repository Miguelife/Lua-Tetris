--[[
    tetrimino_t.lua
    
    T-shaped tetrimino implementation.
    Extends the base Tetrimino class and implements the specific
    shape and behavior of the T tetrimino.
]]

-- REQUIRES
local Piece = require("src.entities.piece")
local Tetrimino = require("src.entities.tetrimino.tetrimino_base")
local Spritesheet = require("src.utils.spritesheet")
local Constants = require("src.utils.constants")

-- MARK: TETRIMINO T
local TetriminoT = {}
TetriminoT.__index = TetriminoT
setmetatable(TetriminoT, Tetrimino)

---Creates a new T-shaped tetrimino
---@return table The new TetriminoT instance
function TetriminoT.new()
    local self = setmetatable(Tetrimino.new(), TetriminoT)

    -- Load the specific sprite for this tetrimino
    local spritesheet = Spritesheet.new("assets/spritesheets/spritesheet.png", Constants.spriteSheetTileSize)
    self.sprite = spritesheet:getSprite(3, 0)
    return self
end

---Gets the pieces that make up this tetrimino based on its current rotation
---@return table Array of Piece objects positioned to form a T shape
function TetriminoT:getPieces()
    -- Rotation 0: T shape upright
    if self.rotation == 0 then
        return {
            Piece.new(-1, 1, self.sprite), -- Left
            Piece.new(0, 0, self.sprite),  -- Top center
            Piece.new(0, 1, self.sprite),  -- Center
            Piece.new(1, 1, self.sprite),  -- Right
        }
    -- Rotation 90: T shape pointing right
    elseif self.rotation == 90 then
        return {
            Piece.new(0, 0, self.sprite),  -- Top
            Piece.new(0, 1, self.sprite),  -- Center
            Piece.new(1, 1, self.sprite),  -- Right
            Piece.new(0, 2, self.sprite),  -- Bottom
        }
    -- Rotation 180: T shape upside down
    elseif self.rotation == 180 then
        return {
            Piece.new(-1, 1, self.sprite), -- Left
            Piece.new(0, 1, self.sprite),  -- Center
            Piece.new(1, 1, self.sprite),  -- Right
            Piece.new(0, 2, self.sprite),  -- Bottom center
        }
    -- Rotation 270: T shape pointing left
    elseif self.rotation == 270 then
        return {
            Piece.new(0, 0, self.sprite),  -- Top
            Piece.new(0, 1, self.sprite),  -- Center
            Piece.new(0, 2, self.sprite),  -- Bottom
            Piece.new(-1, 1, self.sprite), -- Left
        }
    end
    
    -- Default case (should never happen, but ensures we always return something)
    return {}
end

return TetriminoT

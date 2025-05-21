--[[
    tetrimino_o.lua
    
    O-shaped tetrimino implementation (square shape).
    Extends the base Tetrimino class and implements the specific
    shape of the O tetrimino, which is unique because it doesn't
    change appearance when rotated.
]]

-- REQUIRES
local Piece = require("src.entities.piece")
local Tetrimino = require("src.entities.tetrimino.tetrimino_base")
local Spritesheet = require("src.utils.spritesheet")
local Constants = require("src.utils.constants")

-- MARK: TETRIMINO O
local TetriminoO = {}
TetriminoO.__index = TetriminoO
setmetatable(TetriminoO, Tetrimino)

---Creates a new O-shaped tetrimino (square shape)
---@return table The new TetriminoO instance
function TetriminoO.new()
    local self = setmetatable(Tetrimino.new(), TetriminoO)

    -- Load the specific sprite for this tetrimino
    local spritesheet = Spritesheet.new("assets/spritesheets/spritesheet.png", Constants.spriteSheetTileSize)
    self.sprite = spritesheet:getSprite(0, 0)
    return self
end

---Gets the pieces that make up this tetrimino
---@return table Array of Piece objects positioned to form an O shape (square)
---Note: The O tetrimino is the only one that looks the same in all rotations
function TetriminoO:getPieces()
    -- The O tetrimino is a 2x2 square and doesn't change with rotation
    return {
        Piece.new(0, 0, self.sprite),  -- Top left
        Piece.new(1, 0, self.sprite),  -- Top right
        Piece.new(0, 1, self.sprite),  -- Bottom left
        Piece.new(1, 1, self.sprite),  -- Bottom right
    }
end

return TetriminoO

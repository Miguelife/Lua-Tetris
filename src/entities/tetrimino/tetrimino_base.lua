--[[
    tetrimino_base.lua
    
    Base class for all Tetrimino shapes in the game.
    Provides common functionality shared by all tetrimino types including
    position tracking, rotation handling, and rendering.
    
    This class is meant to be extended by specific tetrimino shape classes.
]]

-- REQUIRES
local Spritesheet = require("src.utils.spritesheet")
local Constants = require("src.utils.constants")

-- MARK: TETRIMINO BASE
local Tetrimino = {}
Tetrimino.__index = Tetrimino

---Creates a new Tetrimino instance
---@return table The new Tetrimino instance
function Tetrimino.new()
    local self = setmetatable({ }, Tetrimino)
    -- Position of the tetrimino on the grid
    self.position = { x = 0, y = 0 }
    -- Current rotation in degrees (0, 90, 180, 270)
    self.rotation = 0
    -- Whether this tetrimino is currently in play
    self.active = true
    return self
end

---Returns the pieces that make up this tetrimino
---Should be overridden by derived classes to return the specific shape
---@return table An empty array (to be overridden by subclasses)
function Tetrimino:getPieces()
    return {}
end

---Rotates the tetrimino by the specified degrees
---@param degrees number The degrees to rotate (typically 90 or -90)
function Tetrimino:addDegrees(degrees)
    self.rotation = self.rotation + degrees
    
    -- Normalize rotation to stay within 0-270 range
    if self.rotation == 360 then
        self.rotation = 0
    elseif self.rotation == -90 then 
        self.rotation = 270
    end
end

---Draws the tetrimino on screen
---Uses a spritesheet to render each piece at its position
function Tetrimino:draw()
    love.graphics.setColor(1, 1, 1)
    for _, piece in ipairs(self:getPieces()) do
        -- Calculate absolute position based on tetrimino position and piece offset
        local x = piece.position.x + self.position.x
        local y = piece.position.y + self.position.y

        local spritesheet = Spritesheet.new("assets/spritesheets/spritesheet.png", Constants.spriteSheetTileSize)
        spritesheet:draw(piece.sprite, x, y)
    end
end

return Tetrimino

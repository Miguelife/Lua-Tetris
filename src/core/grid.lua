--[[
    grid.lua
    
    Represents the game grid/playfield where tetriminos fall and accumulate.
    Handles collision detection, line clearing, piece movement and rotation.
    This is a central component of the game mechanics.
]]

-- REQUIRES
local Piece = require("src.entities.piece")
local Constants = require("src.utils.constants")

-- MARK: GRID
local Grid = {}
Grid.__index = Grid

---Creates a new game grid
---@return table The new Grid instance
function Grid.new()
    local self = setmetatable({ }, Grid)
    -- Standard Tetris dimensions (10×20)
    self.width = 10
    self.height = 20
    -- Center-top position for spawning new tetriminos
    self.spawnPoint = { x = 4, y = 0 }
    -- Collection of all settled pieces on the grid
    self.pieces = {}
    return self
end

---Checks if a position on the grid is free (no piece and within bounds)
---@param x number The x coordinate to check
---@param y number The y coordinate to check
---@return boolean True if the position is free, false otherwise
function Grid:isFreeAt(x, y)
    -- Check collision with existing pieces
    for _, piece in ipairs(self.pieces) do
        if piece.position.x == x and piece.position.y == y then
            return false
        end
    end

    -- Check collision with grid boundaries
    if (x < 0 or x >= self.width) or (y < 0 or y >= self.height) then
        return false
    end
    
    return true
end

---Adds a tetrimino's pieces to the grid when it can no longer move
---@param tetrimino table The tetrimino to add to the grid
function Grid:addTetrimino(tetrimino)
    -- Convert the tetrimino's relative pieces to absolute pieces on the grid
    for _, piece in ipairs(tetrimino:getPieces()) do
        table.insert(self.pieces, Piece.new(piece.position.x + tetrimino.position.x, piece.position.y + tetrimino.position.y, piece.sprite))
    end
end

---Checks for and clears any full lines on the grid
---@return number The number of lines cleared
function Grid:clearLines()
    -- We check if there are any full lines.
    local linesCleared = 0

    -- We go through each row of the grid to check for full lines.
    for y = 0, self.height - 1 do
        local isLineFull = true

        -- If we find a free space, the line is not full.
        for x = 0, self.width - 1 do
            if self:isFreeAt(x, y) then
                isLineFull = false
                break
            end
        end
        
        -- If the line is full
        if isLineFull then
            linesCleared = linesCleared + 1

            -- We remove all pieces in that line.
            for i = #self.pieces, 1, -1 do
                if self.pieces[i].position.y == y then
                    table.remove(self.pieces, i)
                end
            end

            -- We move all pieces above the line down.
            for i = #self.pieces, 1, -1 do
                if self.pieces[i].position.y < y then
                    self.pieces[i].position.y = self.pieces[i].position.y + 1
                end
            end
        end
    end
    
    return linesCleared
end

---Attempts to move a tetrimino by the specified offset
---@param tetrimino table The tetrimino to move
---@param x number The horizontal distance to move (negative = left, positive = right)
---@param y number The vertical distance to move (negative = up, positive = down)
---@return boolean Whether the move was successful
function Grid:move(tetrimino, x, y)
    -- Check if all tetrimino pieces can move to the new position
    local canMove = true
    for _, piece in ipairs(tetrimino:getPieces()) do
        if not self:isFreeAt(piece.position.x + tetrimino.position.x + x, piece.position.y + tetrimino.position.y + y) then
            canMove = false
            break
        end
    end
    
    -- Move the tetrimino if possible
    if canMove then
        tetrimino.position.x = tetrimino.position.x + x
        tetrimino.position.y = tetrimino.position.y + y
    end

    -- Update tetrimino active state based on downward movement
    -- If a tetrimino can't move down (y direction), it's no longer active
    tetrimino.active = canMove and y ~= 0

    return canMove
end

---Attempts to rotate a tetrimino by the specified degrees
---@param tetrimino table The tetrimino to rotate
---@param degrees number The degrees to rotate (typically 90 or -90)
function Grid:rotate(tetrimino, degrees)
    -- Apply the rotation
    tetrimino:addDegrees(degrees)

    -- Check if any pieces in the rotated position would collide
    local canRotate = true
    for _, piece in ipairs(tetrimino:getPieces()) do
        if not self:isFreeAt(piece.position.x + tetrimino.position.x, piece.position.y + tetrimino.position.y) then
            canRotate = false
            break
        end
    end

    -- If rotation causes collision, attempt wall kick (shifting the piece to make it fit)
    if not canRotate then   
        -- Try shifting right
        local canMove = self:move(tetrimino, 1, 0)
        if not canMove then
            -- Try shifting left
            canMove = self:move(tetrimino, -1, 0)
        end

        if not canMove then
            -- Try shifting further right
            canMove = self:move(tetrimino, 2, 0)
        end

        if not canMove then
            -- Try shifting further left
            canMove = self:move(tetrimino, -2, 0)
        end

        -- If all wall kicks fail, revert the rotation
        if not canMove then
            tetrimino:addDegrees(-degrees)
        end
    end
end

---Handles keyboard input for tetrimino movement and rotation
---@param key string The key that was pressed
---@param tetrimino table The current active tetrimino to control
function Grid:keypressed(key, tetrimino)
    -- Movement
    if key == "down" then
        self:move(tetrimino, 0, 1)     -- Move down
    elseif key == "up" then
        self:hardDrop(tetrimino)       -- Drop to bottom instantly
    elseif key == "left" then
        self:move(tetrimino, -1, 0)    -- Move left
    elseif key == "right" then
        self:move(tetrimino, 1, 0)     -- Move right
    -- Rotation
    elseif key == "q" then
        self:rotate(tetrimino, -90)    -- Rotate counter-clockwise
    elseif key == "e" then
        self:rotate(tetrimino, 90)     -- Rotate clockwise
    end
end

---Drops a tetrimino straight down until it hits something
---@param tetrimino table The tetrimino to drop
function Grid:hardDrop(tetrimino)
    local hasMoved = true
    -- Keep moving down until the tetrimino can't move further
    while hasMoved do
        hasMoved = self:move(tetrimino, 0, 1)
    end
end

---Draws the grid and all settled pieces on it
---@param onGame boolean Whether the game is in active gameplay (if false, only draws background)
function Grid:draw(onGame)
    -- Draw background with appropriate color based on game state
    if not onGame then
        love.graphics.setColor(1, 1, 1)          -- Full white in menu/non-game states
    else
        love.graphics.setColor(0.8, 0.8, 0.8)    -- Slightly dimmed in active gameplay
    end
    
    -- Load and draw the background image
    local background = love.graphics.newImage("assets/images/background.png")
    love.graphics.draw(background, 0, 0, 0, 2.5, 2.5)

    -- Exit early if not in the game state
    if not onGame then
        return
    end

    -- Draw grid lines
    love.graphics.setColor(1, 1, 1, 0.25)  -- Semi-transparent white
    -- Horizontal grid lines
    for y = 0, self.height do
        love.graphics.line(0, y * Constants.tileSize, self.width * Constants.tileSize, y * Constants.tileSize)
    end
    -- Vertical grid lines
    for x = 0, self.width do
        love.graphics.line(x * Constants.tileSize, 0, x * Constants.tileSize, self.height * Constants.tileSize)
    end

    -- Draw all settled pieces on the grid
    love.graphics.setColor(0.8, 0.8, 0.8)  -- Light gray for pieces
    for _, piece in ipairs(self.pieces) do
        piece:draw()
    end
end

return Grid

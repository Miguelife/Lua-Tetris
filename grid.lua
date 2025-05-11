Grid = {}
Grid.__index = Grid

function Grid.new()
    local self = setmetatable({ }, Grid)
    self.width = 10
    self.height = 20
    self.spawnPoint = { x = 4, y = 0 }
    self.pieces = {}
    return self
end

function Grid:isFreeAt(x, y)
    for _, piece in ipairs(self.pieces) do
        if piece.x == x and piece.y == y then
            return false
        end
    end

    if (x < 0 or x >= self.width) or (y < 0 or y >= self.height) then
        return false
    end
    
    return true
end

function Grid:addTetrimino(tetrimino)
    for _, piece in ipairs(tetrimino:getPieces()) do
        table.insert(self.pieces, Piece.new(piece.x + tetrimino.x, piece.y + tetrimino.y, piece.sprite))
    end
end

function Grid:clearLines()
    -- We check if there are any full lines.
    local hasClearedLines = false

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
            hasClearedLines = true

            -- We remove all pieces in that line.
            for i = #self.pieces, 1, -1 do
                if self.pieces[i].y == y then
                    table.remove(self.pieces, i)
                end
            end

            -- We move all pieces above the line down.
            for i = #self.pieces, 1, -1 do
                if self.pieces[i].y < y then
                    self.pieces[i].y = self.pieces[i].y + 1
                end
            end
        end
    end
    
    return hasClearedLines
end

function Grid:draw(onGame)
    -- Background
    if not onGame then
        love.graphics.setColor(1, 1, 1)
    else
        love.graphics.setColor(0.8, 0.8, 0.8)
    end
    
    local background = love.graphics.newImage("assets/images/background.png")
    love.graphics.draw(background, 0, 0, 0, 2.5, 2.5)

    -- Draw pieces
    for _, piece in ipairs(self.pieces) do
        Spritesheet:draw(piece.sprite, piece.x, piece.y)
    end
end

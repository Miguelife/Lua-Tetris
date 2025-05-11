-- MARK: TETRIMINO
Tetrimino = {}
Tetrimino.__index = Tetrimino

function Tetrimino.new()
    local self = setmetatable({ }, Tetrimino)
    self.x = 0
    self.y = 0
    self.rotation = 0
    self.active = true
    return self
end

function Tetrimino:getPieces()
    return {}
end

function Tetrimino:move(x, y)
    local canMove = true
    for _, piece in ipairs(self:getPieces()) do
        if not GameController.grid:isFreeAt(piece.x + self.x + x, piece.y + self.y + y) then
            canMove = false
            break
        end
    end
    
    if canMove then
        self.x = self.x + x
        self.y = self.y + y
    end

    self.active = canMove and y ~= 0

    return canMove
end


function Tetrimino:rotate(degrees)
    local canRotate = true
    self:addDegrees(degrees)

    for _, piece in ipairs(self:getPieces()) do
        if not GameController.grid:isFreeAt(piece.x + self.x, piece.y + self.y) then
            canRotate = false
            break
        end
    end

    if not canRotate then   
        local canMove = self:move(1, 0)
        if not canMove then
            canMove = self:move(-1, 0)
        end

        if not canMove then
            canMove = self:move(2, 0)
        end

        if not canMove then
            canMove = self:move(-2, 0)
        end

        if not canMove then
            self:addDegrees(-degrees)
        end
    end
end

function Tetrimino:addDegrees(degrees)
    self.rotation = self.rotation + degrees
    
    if self.rotation == 360 then
        self.rotation = 0
    elseif self.rotation == -90 then 
        self.rotation = 270
    end
end

function Tetrimino:hardDrop()
    local hasMoved = true
    while hasMoved do
        hasMoved = self:move(0, 1)
    end
end

function Tetrimino:draw()
    love.graphics.setColor(1, 1, 1)
    for _, piece in ipairs(self:getPieces()) do
        local x = piece.x + self.x
        local y = piece.y + self.y
        
        Spritesheet:draw(self.sprite, x, y)
    end
end

function Tetrimino:keypressed(key)
    -- Movement
    if key == "down" then
        self:move(0, 1)
    elseif key == "up" then
        self:hardDrop()
    elseif key == "left" then
        self:move(-1, 0)
    elseif key == "right" then
        self:move(1, 0)
    -- Rotation
    elseif key == "q" then
        self:rotate(-90)
    elseif key == "e" then
        self:rotate(90)
    end
end

-- MARK: TETRIMINO T
TetriminoT = {}
TetriminoT.__index = TetriminoT
setmetatable(TetriminoT, Tetrimino)

function TetriminoT.new()
    local self = setmetatable(Tetrimino.new(), TetriminoT)
    self.sprite = Spritesheet:getSprite(3, 0)
    return self
end

function TetriminoT:getPieces()
    if self.rotation == 0 then
        return {
            Piece.new(-1, 1, self.sprite),
            Piece.new(0, 0, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(1, 1, self.sprite),
        }
    elseif self.rotation == 90 then
        return {
            Piece.new(0, 0, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(1, 1, self.sprite),
            Piece.new(0, 2, self.sprite),
        }
    elseif self.rotation == 180 then
        return {
            Piece.new(-1, 1, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(1, 1, self.sprite),
            Piece.new(0, 2, self.sprite),
        }
    elseif self.rotation == 270 then
        return {
            Piece.new(0, 0, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(0, 2, self.sprite),
            Piece.new(-1, 1, self.sprite),
        }
    end
end

-- MARK: TETRIMINO I
TetriminoI = {}
TetriminoI.__index = TetriminoI
setmetatable(TetriminoI, Tetrimino)

function TetriminoI.new()
    local self = setmetatable(Tetrimino.new(), TetriminoI)
    self.sprite = Spritesheet:getSprite(5, 0)
    return self
end

function TetriminoI:getPieces()
    if self.rotation == 0 then
        return {
            Piece.new(-1, 0, self.sprite),
            Piece.new(0, 0, self.sprite),
            Piece.new(1, 0, self.sprite),
            Piece.new(2, 0, self.sprite),
        }
    elseif self.rotation == 90 then
        return {
            Piece.new(1, 0, self.sprite),
            Piece.new(1, 1, self.sprite),
            Piece.new(1, 2, self.sprite),
            Piece.new(1, 3, self.sprite),
        }
    elseif self.rotation == 180 then
        return {
            Piece.new(-1,1, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(1, 1, self.sprite),
            Piece.new(2, 1, self.sprite),
        }
    elseif self.rotation == 270 then
        return {
            Piece.new(0, 0, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(0, 2, self.sprite),
            Piece.new(0, 3, self.sprite),
        }
    end
end


-- MARK: TETRIMINO O
TetriminoO = {}
TetriminoO.__index = TetriminoO
setmetatable(TetriminoO, Tetrimino)

function TetriminoO.new()
    local self = setmetatable(Tetrimino.new(), TetriminoO)
    self.sprite = Spritesheet:getSprite(0, 0)
    return self
end

function TetriminoO:getPieces()
    return {
        Piece.new(0, 0, self.sprite),
        Piece.new(1, 0, self.sprite),
        Piece.new(0, 1, self.sprite),
        Piece.new(1, 1, self.sprite),
    }
end

-- MARK: TETRIMINO S
TetriminoS = {}
TetriminoS.__index = TetriminoS
setmetatable(TetriminoS, Tetrimino)

function TetriminoS.new()
    local self = setmetatable(Tetrimino.new(), TetriminoS)
    self.sprite = Spritesheet:getSprite(2, 0)
    return self
end

function TetriminoS:getPieces()
    if self.rotation == 0 then
        return {
            Piece.new(-1, 1, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(0, 0, self.sprite),
            Piece.new(1, 0, self.sprite),
        }
    elseif self.rotation == 90 then
        return {
            Piece.new(0, 0, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(1, 1, self.sprite),
            Piece.new(1, 2, self.sprite),
        }
    elseif self.rotation == 180 then
        return {
            Piece.new(-1, 2, self.sprite),
            Piece.new(0, 2, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(1, 1, self.sprite),
        }
    elseif self.rotation == 270 then
        return {
            Piece.new(-1, 0, self.sprite),
            Piece.new(-1, 1, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(0, 2, self.sprite),
        }
    end
end

-- MARK: TETRIMINO Z
TetriminoZ = {}
TetriminoZ.__index = TetriminoZ
setmetatable(TetriminoZ, Tetrimino)

function TetriminoZ.new()
    local self = setmetatable(Tetrimino.new(), TetriminoZ)
    self.sprite = Spritesheet:getSprite(1, 0)
    return self
end

function TetriminoZ:getPieces()
    if self.rotation == 0 then
        return {
            Piece.new(-1, 0, self.sprite),
            Piece.new(0, 0, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(1, 1, self.sprite),
        }
    elseif self.rotation == 90 then
        return {
            Piece.new(1, 0, self.sprite),
            Piece.new(1, 1, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(0, 2, self.sprite),
        }
    elseif self.rotation == 180 then
        return {
            Piece.new(-1, 1, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(0, 2, self.sprite),
            Piece.new(1, 2, self.sprite),
        }
    elseif self.rotation == 270 then
        return {
            Piece.new(0, 0, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(-1, 1, self.sprite),
            Piece.new(-1, 2, self.sprite),
        }
    end
end

-- MARK: TETRIMINO L
TetriminoL = {}
TetriminoL.__index = TetriminoL
setmetatable(TetriminoL, Tetrimino)

function TetriminoL.new()
    local self = setmetatable(Tetrimino.new(), TetriminoL)
    self.sprite = Spritesheet:getSprite(4, 0)
    return self
end

function TetriminoL:getPieces()
    if self.rotation == 0 then
        return {
            Piece.new(1, 0, self.sprite),
            Piece.new(-1, 1, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(1, 1, self.sprite),
        }
    elseif self.rotation == 90 then
        return {
            Piece.new(0, 0, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(0, 2, self.sprite),
            Piece.new(1, 2, self.sprite),
        }
    elseif self.rotation == 180 then
        return {
            Piece.new(-1, 1, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(1, 1, self.sprite),
            Piece.new(-1, 2, self.sprite),
        }
    elseif self.rotation == 270 then
        return {
            Piece.new(-1, 0, self.sprite),
            Piece.new(0, 0, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(0, 2, self.sprite),
        }
    end
end

-- MARK: TETRIMINO J
TetriminoJ = {}
TetriminoJ.__index = TetriminoJ
setmetatable(TetriminoJ, Tetrimino)

function TetriminoJ.new()
    local self = setmetatable(Tetrimino.new(), TetriminoJ)
    self.sprite = Spritesheet:getSprite(6, 0)
    return self
end

function TetriminoJ:getPieces()
    if self.rotation == 0 then
        return {
            Piece.new(-1, 0, self.sprite),
            Piece.new(-1, 1, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(1, 1, self.sprite),
        }
    elseif self.rotation == 90 then
        return {
            Piece.new(0, 0, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(0, 2, self.sprite),
            Piece.new(-1, 2, self.sprite),
        }
    elseif self.rotation == 180 then
        return {
            Piece.new(-1, 1, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(1, 1, self.sprite),
            Piece.new(1, 2, self.sprite),
        }
    elseif self.rotation == 270 then
        return {
            Piece.new(1, 0, self.sprite),
            Piece.new(0, 0, self.sprite),
            Piece.new(0, 1, self.sprite),
            Piece.new(0, 2, self.sprite),
        }
    end
end

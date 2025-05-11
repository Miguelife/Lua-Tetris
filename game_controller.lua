-- MARK: GAME CONTROLLER
GameController = {}
GameController.__index = GameController

function GameController.new()
    local self = setmetatable({ }, GameController)
    self.timer = 0
    self.grid = Grid.new()
    self.state = "INITIAL"
    self.tetriminos = {
        TetriminoT,
        TetriminoI,
        TetriminoO,
        TetriminoS,
        TetriminoZ,
        TetriminoL,
        TetriminoJ
    }
    self.currentTetrimino = self:generateTetrimino()
    return self
end

function GameController:start()
    self.state = "GAME"
    self.currentTetrimino = self:generateTetrimino()
    self.grid = Grid.new()
    self.timer = 0
end

function GameController:update(dt)
    if self.state == "INITIAL" then
        self:updateInitial(dt)
    elseif self.state == "GAME" then
        self:updateGame(dt)
    elseif self.state == "GAME_OVER" then
        self:updateGameOver(dt)
    elseif self.state == "PAUSE" then
        self:updatePause(dt)
    end
end

function GameController:keypressed(key)
    if self.state == "INITIAL" then
        self:keypressedInitial(key)
    elseif self.state == "GAME" then
        self:keypressedGame(key)
    elseif self.state == "GAME_OVER" then
        self:keypressedGameOver(key)
    elseif self.state == "PAUSE" then
        self:keypressedPause(key)
    end
end

function GameController:draw()
    if self.state == "INITIAL" then
        self:drawInitial()
    elseif self.state == "GAME" then
        self:drawGame()
    elseif self.state == "GAME_OVER" then
        self:drawGameOver()
    elseif self.state == "PAUSE" then
        self:drawPause()
    end
end

function GameController:getWindowSize()
    return { x = self.grid.width * Constants.tileSize, y = self.grid.height * Constants.tileSize }
end

-- MARK: INITIAL
function GameController:keypressedInitial(key)
    if key == "space" then
        self:start()
    end
end

function GameController:updateInitial(dt)
    
end

function GameController:drawInitial()
    -- Grid
    local emptyGrid = Grid.new()
    emptyGrid:draw(false)

    -- Title text
    local windowSize = self:getWindowSize()
    love.graphics.setColor(1, 1, 1)
    local text = "Tetris!"
    local originalFont = love.graphics.getFont()
    local largeFont = love.graphics.newFont(48)
    love.graphics.setFont(largeFont)
    local textWidth = largeFont:getWidth(text)
    local tetrisTextHeight = largeFont:getHeight()
    love.graphics.print(
        text,
        windowSize.x / 2 - textWidth / 2,
        tetrisTextHeight / 1.5
    )
    love.graphics.setFont(originalFont)

    -- Press start text
    local windowSize = self:getWindowSize()
    love.graphics.setColor(1, 1, 1)
    local text = "Press space to start"
    local originalFont = love.graphics.getFont()
    local largeFont = love.graphics.newFont(24)
    love.graphics.setFont(largeFont)
    local textWidth = largeFont:getWidth(text)
    local pressStartTextHeight = largeFont:getHeight()
    love.graphics.print(
        text,
        windowSize.x / 2 - textWidth / 2,
        tetrisTextHeight * 1.5 + pressStartTextHeight / 1.5
    )
    love.graphics.setFont(originalFont)
end

-- MARK: GAME
function GameController:updateGame(dt)
    GameController.timer = GameController.timer + dt
    if GameController.timer >= Constants.updateTime then
        GameController.timer = 0

        self.currentTetrimino:move(0, 1)

        if not self.currentTetrimino.active then
            self.grid:addTetrimino(self.currentTetrimino)
            local hasClearedLines = self.grid:clearLines()
            local gameOver = not self.grid:isFreeAt(self.grid.spawnPoint.x, self.grid.spawnPoint.y)

            if gameOver then
                Audio.playEffect("gameover1")
                self.state = "GAME_OVER"
                return
            end

            self.currentTetrimino = self:generateTetrimino()

            local effect = hasClearedLines and "upgrade4" or "hit1"
            Audio.playEffect(effect)
        end
    end
end

function GameController:keypressedGame(key)
    if key == "escape" then
        self.state = "PAUSE"
    end

    if key == "up" or key == "down" then
        self.timer = 0
    end 
    self.currentTetrimino:keypressed(key)
end

function GameController:drawGame()
    self.grid:draw(true)
    self.currentTetrimino:draw()
end

function GameController:generateTetrimino()
    local tetrimino = self.tetriminos[math.random(1, #self.tetriminos)].new()
    tetrimino.x = self.grid.spawnPoint.x
    tetrimino.y = self.grid.spawnPoint.y
    return tetrimino
end

-- MARK: GAME OVER
function GameController:updateGameOver(dt)

end

function GameController:keypressedGameOver(key)
    if key == "space" then
        self:start()
    end
end

function GameController:drawGameOver()
    -- Grid
    local emptyGrid = Grid.new()
    emptyGrid:draw(false)

    -- Title text
    local windowSize = self:getWindowSize()
    love.graphics.setColor(1, 1, 1)
    local text = "Game Over!"
    local originalFont = love.graphics.getFont()
    local largeFont = love.graphics.newFont(48)
    love.graphics.setFont(largeFont)
    local textWidth = largeFont:getWidth(text)
    local tetrisTextHeight = largeFont:getHeight()
    love.graphics.print(
        text,
        windowSize.x / 2 - textWidth / 2,
        tetrisTextHeight / 1.5
    )
    love.graphics.setFont(originalFont)

    -- Press start text
    local windowSize = self:getWindowSize()
    love.graphics.setColor(1, 1, 1)
    local text = "Press space to restart"
    local originalFont = love.graphics.getFont()
    local largeFont = love.graphics.newFont(24)
    love.graphics.setFont(largeFont)
    local textWidth = largeFont:getWidth(text)
    local pressStartTextHeight = largeFont:getHeight()
    love.graphics.print(
        text,
        windowSize.x / 2 - textWidth / 2,
        tetrisTextHeight * 1.5 + pressStartTextHeight / 1.5
    )
    love.graphics.setFont(originalFont)
end

-- MARK: PAUSE
function GameController:updatePause(dt)
    
end

function GameController:keypressedPause(key)
    if key == "space" then
        self.state = "GAME"
    end
end

function GameController:drawPause()
    -- Grid
    local emptyGrid = Grid.new()
    emptyGrid:draw(false)

    -- Title text
    local windowSize = self:getWindowSize()
    love.graphics.setColor(1, 1, 1)
    local text = "Tetris!"
    local originalFont = love.graphics.getFont()
    local largeFont = love.graphics.newFont(48)
    love.graphics.setFont(largeFont)
    local textWidth = largeFont:getWidth(text)
    local tetrisTextHeight = largeFont:getHeight()
    love.graphics.print(
        text,
        windowSize.x / 2 - textWidth / 2,
        tetrisTextHeight / 1.5
    )
    love.graphics.setFont(originalFont)

    -- Press start text
    local windowSize = self:getWindowSize()
    love.graphics.setColor(1, 1, 1)
    local text = "Press space to resume"
    local originalFont = love.graphics.getFont()
    local largeFont = love.graphics.newFont(24)
    love.graphics.setFont(largeFont)
    local textWidth = largeFont:getWidth(text)
    local pressStartTextHeight = largeFont:getHeight()
    love.graphics.print(
        text,
        windowSize.x / 2 - textWidth / 2,
        tetrisTextHeight * 1.5 + pressStartTextHeight / 1.5
    )
    love.graphics.setFont(originalFont)
end
-- MARK: GAME CONTROLLER
GameController = {}
GameController.__index = GameController

function GameController.new()
    local self = setmetatable({ }, GameController)
    self.timer = 0
    self.grid = Grid.new()
    self.state = "INITIAL"
    self.uiWidth = 150
    self.linesCleared = 0
    self.level = 1
    self.score = 0
    self.linesPerLevel = 10
    self.scoreMultiplier = 100
    self.updateTime = 1
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
    self.linesCleared = 0
    self.level = 1
    self.score = 0
    self.linesPerLevel = 10
    self.updateTime = 1
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
    return { x = self.grid.width * Constants.tileSize + self.uiWidth, y = self.grid.height * Constants.tileSize }
end

function GameController:drawDefaultScreen(title, text)
        -- Title text
        local windowSize = self:getWindowSize()
        love.graphics.setColor(1, 1, 1)
        local originalFont = love.graphics.getFont()
        local largeFont = love.graphics.newFont(48)
        love.graphics.setFont(largeFont)
        local textWidth = largeFont:getWidth(title)
        local tetrisTextHeight = largeFont:getHeight()
        love.graphics.print(
            title,
            windowSize.x / 2 - textWidth / 2,
            tetrisTextHeight / 1.5
        )
        love.graphics.setFont(originalFont)
    
        -- Text
        local windowSize = self:getWindowSize()
        love.graphics.setColor(1, 1, 1)
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

function GameController:drawUI()
    love.graphics.setColor(0, 0, 0, 0.25)
    love.graphics.rectangle("fill", self:getWindowSize().x - self.uiWidth, 0, self.uiWidth, self:getWindowSize().y)

    love.graphics.setColor(1, 1, 1)
    local originalFont = love.graphics.getFont()
    local newFont = love.graphics.newFont(22)
    love.graphics.setFont(newFont)
    love.graphics.print("Level: " .. self.level, self:getWindowSize().x - self.uiWidth + 10, 10)
    love.graphics.print("Lines: " .. self.linesCleared, self:getWindowSize().x - self.uiWidth + 10, 50)
    love.graphics.print("Score: " .. self.score, self:getWindowSize().x - self.uiWidth + 10, 90)
    love.graphics.setFont(originalFont)
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
    -- Screen
    self:drawDefaultScreen("Tetris!", "Press space to start")
end

-- MARK: GAME
function GameController:updateGame(dt)
    GameController.timer = GameController.timer + dt
    if GameController.timer >= self.updateTime then
        GameController.timer = 0

        self.currentTetrimino:move(0, 1)

        if not self.currentTetrimino.active then
            self.grid:addTetrimino(self.currentTetrimino)
            local linesCleared = self.grid:clearLines()

            if linesCleared > 0 then
                self.linesCleared = self.linesCleared + linesCleared
                self.score = linesCleared * self.scoreMultiplier
            end
        
            if self.linesCleared >= self.linesPerLevel then
                self.level = self.level + 1
                self.updateTime = self.updateTime * 0.9
                self.linesPerLevel = self.linesPerLevel + 1
                self.scoreMultiplier = self.scoreMultiplier * 1.5
            end

            local gameOver = not self.grid:isFreeAt(self.grid.spawnPoint.x, self.grid.spawnPoint.y)

            if gameOver then
                Audio.playEffect("gameover1")
                self.state = "GAME_OVER"
                return
            end

            self.currentTetrimino = self:generateTetrimino()

            local effect = linesCleared > 0 and "upgrade4" or "hit1"
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
    self:drawUI()
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
    self:drawDefaultScreen("Game Over!", "Press space to restart")
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
    self:drawDefaultScreen("Paused", "Press space to resume")
end
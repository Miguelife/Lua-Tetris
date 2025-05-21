-- REQUIRES
local State = require("src.core.state_machine.states.state_base")

local Grid = require("src.core.grid")
local Tetriminos = require("src.entities.tetrimino.init")
local Audio = require("src.utils.audio")
local Constants = require("src.utils.constants")

-- MARK: STATE GAME
local StateGame = {}
StateGame.__index = StateGame
setmetatable(StateGame, State)

function StateGame.new()
    local self = setmetatable(State.new(), StateGame)
    self.timer = 0
    self.grid = Grid.new()
    self.linesCleared = 0
    self.level = 1
    self.score = 0
    self.linesPerLevel = 10
    self.scoreMultiplier = 100
    self.updateTime = 1
    self.tetriminos = {
        Tetriminos.T,
        Tetriminos.I,
        Tetriminos.O,
        Tetriminos.S,
        Tetriminos.Z,
        Tetriminos.L,
        Tetriminos.J
    }
    self.currentTetrimino = self:generateTetrimino()
    return self
end

function StateGame:update(dt)
    self.timer = self.timer + dt
    if self.timer >= self.updateTime then
        self.timer = 0

        self.grid:move(self.currentTetrimino, 0, 1)

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
                self.stateMachine:change("GAME_OVER")
                return
            end

            self.currentTetrimino = self:generateTetrimino()

            local effect = linesCleared > 0 and "upgrade4" or "hit1"
            Audio.playEffect(effect)
        end
    end
end

function StateGame:keypressed(key)
    if key == "escape" then
        self.stateMachine:change("PAUSE")
    end

    if key == "up" or key == "down" then
        self.timer = 0
    end 
    self.grid:keypressed(key, self.currentTetrimino)
end

function StateGame:draw()
    self.grid:draw(true)
    self.currentTetrimino:draw()
    self:drawUI()
end

function StateGame:drawUI()
    -- love.graphics.setColor(0, 0, 0, 0.25)
    -- love.graphics.rectangle("fill", self:getWindowSize().x, 0, self.uiWidth, self:getWindowSize().y)

    -- love.graphics.setColor(1, 1, 1)
    -- local originalFont = love.graphics.getFont()
    -- local newFont = love.graphics.newFont(22)
    -- love.graphics.setFont(newFont)
    -- love.graphics.print("Level: " .. self.level, self:getWindowSize().x + 10, 10)
    -- love.graphics.print("Lines: " .. self.linesCleared, self:getWindowSize().x  + 10, 50)
    -- love.graphics.print("Score: " .. self.score, self:getWindowSize().x + 10, 90)
    -- love.graphics.setFont(originalFont)
end

function StateGame:getWindowSize()
    return { x = self.grid.width * Constants.tileSize, y = self.grid.height * Constants.tileSize }
end

function StateGame:generateTetrimino()
    local tetrimino = self.tetriminos[math.random(1, #self.tetriminos)].new()
    tetrimino.position.x = self.grid.spawnPoint.x
    tetrimino.position.y = self.grid.spawnPoint.y
    return tetrimino
end

return StateGame

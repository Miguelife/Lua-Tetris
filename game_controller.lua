GameController = {}
GameController.__index = GameController

function GameController.new()
    local self = setmetatable({ }, GameController)
    self.timer = 0
    self.grid = Grid.new()
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

function GameController:update(dt)
    GameController.timer = GameController.timer + dt
    if GameController.timer >= Constants.updateTime then
        GameController.timer = 0

        self.currentTetrimino:move(0, 1)

        if not self.currentTetrimino.active then
            self.grid:addTetrimino(self.currentTetrimino)
            local hasClearedLines = self.grid:clearLines()
            self.currentTetrimino = self:generateTetrimino()

            local effect = hasClearedLines and "upgrade4.ogg" or "hit1.ogg"
            local audio = love.audio.newSource("assets/effects/"..effect, "static")
            audio:setVolume(0.7)
            audio:play()
        end
    end
end

function GameController:generateTetrimino()
    local tetrimino = self.tetriminos[math.random(1, #self.tetriminos)].new()
    tetrimino.x = self.grid.spawnPoint.x
    tetrimino.y = self.grid.spawnPoint.y
    return tetrimino
end

function GameController:keypressed(key)
    if key == "up" or key == "down" then
        self.timer = 0
    end 
    self.currentTetrimino:keypressed(key)
end

function GameController:draw()
    self.grid:draw()
    self.currentTetrimino:draw()
end
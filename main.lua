-- MARK: REQUIRES
local GameController = require("src.core.game_controller")
local Constants = require("src.utils.constants")
local Audio = require("src.utils.audio")

local gameController = GameController.new()

-- MARK: LOAD
function love.load()
    -- Random seed
    math.randomseed(os.time())

    -- Window
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Tetris!')
    love.window.setMode(10 * Constants.tileSize, 20 * Constants.tileSize)

    -- Audio
    Audio.playMusic("retro_beat")
end

-- MARK: UPDATE
function love.update(dt)
    gameController:update(dt)
end

-- MARK: KEY PRESSED
function love.keypressed(key)
    gameController:keypressed(key)
end

-- MARK: DRAW
function love.draw()
    gameController:draw()
end
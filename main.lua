-- MARK: REQUIRES
require "game_controller"
require "grid"
require "tetrimino"
require "constants"
require "piece"
require "spritesheet"
require "audio"
require "window"

-- MARK: LOAD
function love.load()
    -- Random seed
    math.randomseed(os.time())
    
    -- Spritesheet
    Spritesheet = Spritesheet.new("assets/spritesheets/spritesheet.png", Constants.spriteSheetTileSize)

    -- GameController
    GameController = GameController.new()

    -- Window
    Window.load()

    -- Audio
    Audio.playMusic("retro_beat")
end

-- MARK: UPDATE
function love.update(dt)
    GameController:update(dt)
end

-- MARK: KEY PRESSED
function love.keypressed(key)
    GameController:keypressed(key)
end

-- MARK: DRAW
function love.draw()
    GameController:draw()
end
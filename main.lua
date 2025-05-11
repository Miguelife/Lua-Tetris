-- MARK: REQUIRES
require "game_controller"
require "grid"
require "tetrimino"
require "constants"
require "piece"
require "spritesheet"

-- MARK: LOAD
function love.load()
    -- Random seed
    math.randomseed(os.time())
    
    -- Spritesheet
    Spritesheet = Spritesheet.new("assets/spritesheets/spritesheet.png", Constants.spriteSheetTileSize)

    -- GameController
    GameController = GameController.new()

    -- Window
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Tetris!')
    love.window.setMode(GameController.grid.width * Constants.tileSize, GameController.grid.height * Constants.tileSize)

    local music = love.audio.newSource("assets/music/retro_beat.ogg", "stream")
    music:setLooping(true)
    music:play()
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
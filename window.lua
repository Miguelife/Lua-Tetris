Window = {}


function Window.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Tetris!')
    local windowSize = GameController:getWindowSize()
    love.window.setMode(windowSize.x, windowSize.y)
end
-- WINDOW_WIDTH = 800
-- WINDOW_HEIGHT = 600

-- UPDATE_SPEED = 0.25

-- function love.load()
--     -- Random seed
--     math.randomseed(os.time())

--     -- Window
--     love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
--     love.window.setTitle('RPG')
--     love.graphics.setDefaultFilter('nearest', 'nearest')

--     -- Player
--     Player = { }
--     Player.x = WINDOW_WIDTH / 2;
--     Player.y = WINDOW_HEIGHT / 2;
--     Player.size = 20
--     Player.direction = "right"
--     Player.appleCount = 0

--     -- Apple
--     Apple = { }
--     Apple.x = math.random(0, WINDOW_WIDTH)
--     Apple.y = math.random(0, WINDOW_HEIGHT)

--     -- Timer
--     Timer = { }
--     Timer.value = 0
-- end

-- function love.update(dt)
--     local canMove = false

--     -- Timer
--     Timer.value = Timer.value + dt
--     if Timer.value >= UPDATE_SPEED then
--         canMove = true
--         Timer.value = 0
--     end

--     if love.keyboard.isDown("right") then
--         Player.direction = "right"
--     elseif love.keyboard.isDown("left") then
--         Player.direction = "left"
--     elseif love.keyboard.isDown("up") then
--         Player.direction = "up"
--     elseif love.keyboard.isDown("down") then
--         Player.direction = "down"
--     end

--     if not canMove then return end

--     if Player.direction == "right" then
--         Player.x = Player.x + Player.size
--     elseif Player.direction == "left" then
--         Player.x = Player.x - Player.size
--     elseif Player.direction == "up" then
--         Player.y = Player.y - Player.size
--     elseif Player.direction == "down" then
--         Player.y = Player.y + Player.size
--     end

--     if Player.x < 0 then
--         Player.x = WINDOW_WIDTH
--     elseif Player.x > WINDOW_WIDTH then
--         Player.x = 0
--     elseif Player.y < 0 then
--         Player.y = WINDOW_HEIGHT
--     elseif Player.y > WINDOW_HEIGHT then
--         Player.y = 0
--     end

--     if Player.x < Apple.x + Player.size and Player.x + Player.size > Apple.x and Player.y < Apple.y + Player.size and Player.y + Player.size > Apple.y then
--         Apple.x = math.random(0, WINDOW_WIDTH)
--         Apple.y = math.random(0, WINDOW_HEIGHT)
--         Player.appleCount = Player.appleCount + 1
--     end
-- end

-- function love.draw()
--     -- PASTEL PINK BACKGROUND
--     love.graphics.setColor(1, 0.5, 0.5)
--     love.graphics.rectangle('fill', 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT)

--     -- Player
--     love.graphics.setColor(1, 1, 1)
--     love.graphics.rectangle('fill', Player.x, Player.y, Player.size, Player.size)

--     -- Apple
--     love.graphics.setColor(1, 0, 0)
--     love.graphics.rectangle('fill', Apple.x, Apple.y, 20, 20)

--     -- Stats
--     love.graphics.setColor(1, 1, 1)
--     love.graphics.print(Player.appleCount, WINDOW_WIDTH / 2, 20)
-- end
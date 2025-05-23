-- love.graphics.setDefaultFilter('nearest', 'nearest')

-- -- Window size
-- WINDOW_WIDTH = 800
-- WINDOW_HEIGHT = 600

-- -- Paddle settings
-- PADDLE_WIDTH = 10
-- PADDLE_HEIGHT = 80
-- PADDLE_SPEED = 300

-- -- Ball settings
-- BALL_SIZE = 10
-- BALL_SPEED = 250
-- reboteCount = 0 -- cuenta rebotes entre jugadores

-- paused = false

-- function love.load()
--     love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
--     love.window.setTitle('Pong!')
--     -- Player paddles
--     player1X = 20
--     player1Y = (WINDOW_HEIGHT - PADDLE_HEIGHT) / 2
--     player2X = WINDOW_WIDTH - 20 - PADDLE_WIDTH
--     player2Y = (WINDOW_HEIGHT - PADDLE_HEIGHT) / 2
--     -- Bolas: lista de bolas
--     balls = {}
--     addBall()
--     -- Scores
--     score1 = 0
--     score2 = 0
--     font = love.graphics.newFont(32)
--     pauseFont = love.graphics.newFont(60)
--     love.graphics.setFont(font)
--     -- Fondo inicial pastel
--     bgR, bgG, bgB = 1, 0.7137, 0.7568
-- end

-- function addBall()
--     local direction = (math.random(2) == 1 and 1 or -1)
--     table.insert(balls, {
--         x = (WINDOW_WIDTH - BALL_SIZE) / 2,
--         y = (WINDOW_HEIGHT - BALL_SIZE) / 2,
--         dx = BALL_SPEED * direction,
--         dy = BALL_SPEED * (math.random()*2 - 1)
--     })
-- end

-- function love.update(dt)
--     if paused then return end
--     -- Player 1 controls (W/S/A/D)
--     if love.keyboard.isDown('w') then
--         player1Y = math.max(0, player1Y - PADDLE_SPEED * dt)
--     elseif love.keyboard.isDown('s') then
--         player1Y = math.min(WINDOW_HEIGHT - PADDLE_HEIGHT, player1Y + PADDLE_SPEED * dt)
--     end
--     if love.keyboard.isDown('a') then
--         player1X = math.max(0, player1X - PADDLE_SPEED * dt)
--     elseif love.keyboard.isDown('d') then
--         player1X = math.min(WINDOW_WIDTH/2 - PADDLE_WIDTH, player1X + PADDLE_SPEED * dt)
--     end
--     -- Player 2 controls (Up/Down/Left/Right)
--     if love.keyboard.isDown('up') then
--         player2Y = math.max(0, player2Y - PADDLE_SPEED * dt)
--     elseif love.keyboard.isDown('down') then
--         player2Y = math.min(WINDOW_HEIGHT - PADDLE_HEIGHT, player2Y + PADDLE_SPEED * dt)
--     end
--     if love.keyboard.isDown('left') then
--         player2X = math.max(WINDOW_WIDTH/2, player2X - PADDLE_SPEED * dt)
--     elseif love.keyboard.isDown('right') then
--         player2X = math.min(WINDOW_WIDTH - PADDLE_WIDTH, player2X + PADDLE_SPEED * dt)
--     end
--     -- Movimiento y colisiones de todas las bolas
--     for i, ball in ipairs(balls) do
--         ball.x = ball.x + ball.dx * dt
--         ball.y = ball.y + ball.dy * dt
--         -- Rebote con arriba/abajo
--         if ball.y <= 0 then
--             ball.y = 0
--             ball.dy = -ball.dy
--         elseif ball.y + BALL_SIZE >= WINDOW_HEIGHT then
--             ball.y = WINDOW_HEIGHT - BALL_SIZE
--             ball.dy = -ball.dy
--         end
--         -- Rebote con palas
--         local hit = false
--         if ball.x <= player1X + PADDLE_WIDTH and ball.x + BALL_SIZE >= player1X and ball.y + BALL_SIZE > player1Y and ball.y < player1Y + PADDLE_HEIGHT then
--             ball.x = player1X + PADDLE_WIDTH
--             ball.dx = -ball.dx * 1.1
--             ball.dy = ball.dy * 1.1
--             hit = true
--         elseif ball.x + BALL_SIZE >= player2X and ball.x <= player2X + PADDLE_WIDTH and ball.y + BALL_SIZE > player2Y and ball.y < player2Y + PADDLE_HEIGHT then
--             ball.x = player2X - BALL_SIZE
--             ball.dx = -ball.dx * 1.1
--             ball.dy = ball.dy * 1.1
--             hit = true
--         end
--         if hit then
--             bgR = 0.3 + math.random() * 0.7
--             bgG = 0.3 + math.random() * 0.7
--             bgB = 0.3 + math.random() * 0.7
--             reboteCount = reboteCount + 1
--             if reboteCount >= 5 then
--                 -- reinicia velocidad de todas las bolas
--                 for _, b in ipairs(balls) do
--                     local signx = b.dx > 0 and 1 or -1
--                     local signy = b.dy > 0 and 1 or -1
--                     b.dx = BALL_SPEED * signx
--                     b.dy = BALL_SPEED * (math.random()*2 - 1)
--                 end
--                 if #balls < 2 then
--                     addBall()
--                 end
--                 reboteCount = 0
--             end
--         end
--         -- Puntuación
--         if ball.x < 0 then
--             score2 = score2 + 1
--             resetBalls(-1)
--             break
--         elseif ball.x > WINDOW_WIDTH then
--             score1 = score1 + 1
--             resetBalls(1)
--             break
--         end
--     end
-- end

-- function resetBalls(direction)
--     balls = {}
--     addBall()
--     reboteCount = 0
--     -- Restaura el fondo a pastel rosa al reiniciar
--     bgR, bgG, bgB = 1, 0.7137, 0.7568
-- end

-- function love.draw()
--     -- Fondo dinámico
--     love.graphics.clear(bgR, bgG, bgB)
--     if paused then
--         -- Draw pause menu
--         love.graphics.setFont(pauseFont)
--         love.graphics.setColor(1, 1, 1)
--         local pauseText = "PAUSA"
--         local pauseWidth = pauseFont:getWidth(pauseText)
--         local pauseHeight = pauseFont:getHeight()
--         love.graphics.print(pauseText, (WINDOW_WIDTH - pauseWidth) / 2, (WINDOW_HEIGHT - pauseHeight) / 2)
--         love.graphics.setFont(font)
--     else
--         -- Círculo central blanco semitransparente
--         love.graphics.setColor(1, 1, 1, 1)
--         love.graphics.circle('line', WINDOW_WIDTH/2, WINDOW_HEIGHT/2, 16)
--         love.graphics.setColor(1, 1, 1)
--         -- Línea discontinua central (red de tenis)
--         local dashHeight = 20
--         local gap = 15
--         local centerX = WINDOW_WIDTH / 2 - 2
--         for y = 0, WINDOW_HEIGHT, dashHeight + gap do
--             love.graphics.rectangle('fill', centerX, y, 4, dashHeight)
--         end
--         -- Paddles (white)
--         love.graphics.setColor(1, 1, 1)
--         love.graphics.rectangle('fill', player1X, player1Y, PADDLE_WIDTH, PADDLE_HEIGHT)
--         love.graphics.rectangle('fill', player2X, player2Y, PADDLE_WIDTH, PADDLE_HEIGHT)
--         -- Todas las bolas (blancas)
--         for _, ball in ipairs(balls) do
--             love.graphics.rectangle('fill', ball.x, ball.y, BALL_SIZE, BALL_SIZE)
--         end
--         -- Draw scores (white, centered)
--         local scoreText = tostring(score1) .. '    |    ' .. tostring(score2)
--         local scoreWidth = font:getWidth(scoreText)
--         love.graphics.print(scoreText, (WINDOW_WIDTH - scoreWidth) / 2, 40)
--     end
-- end

-- function love.keypressed(key)
--     if key == 'escape' then
--         paused = not paused
--     end
-- end

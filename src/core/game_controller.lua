--[[
    game_controller.lua
    
    Main controller for the Tetris game that manages game states and core functionality.
    Acts as the central point of control, delegating to the appropriate state objects
    through the state machine to handle updates, input, and rendering.
]]

-- MARK: REQUIRES
local States = require("src.core.state_machine.init")
local StateMachine = require("src.core.state_machine.state_machine")

---@class GameController
---@field stateMachine StateMachine The state machine that controls game states
-- MARK: GAME CONTROLLER
local GameController = {}
GameController.__index = GameController

---Creates a new GameController instance to manage the game
---@return GameController The new GameController instance
function GameController.new()
    local self = setmetatable({ }, GameController)
    -- Initialize the state machine with the initial game state
    self.stateMachine = StateMachine.new(States.INITIAL)
    
    -- UI configuration (currently commented out)
    -- self.uiWidth = 150
    return self
end

---Updates the game state and logic
---@param dt number Delta time since last update (in seconds)
function GameController:update(dt)
    -- Delegate update to the state machine which will update the current state
    self.stateMachine:update(dt)
end

---Handles key press events for the game
---@param key string The key that was pressed
function GameController:keypressed(key)
    -- Delegate key press handling to the state machine
    self.stateMachine:keypressed(key)
end

---Draws the current game state to the screen
function GameController:draw()
    -- Delegate drawing to the state machine
    self.stateMachine:draw()
end

-- function GameController:drawDefaultScreen(title, text)
--         -- Title text
--         local windowSize = self:getWindowSize()
--         love.graphics.setColor(1, 1, 1)
--         local originalFont = love.graphics.getFont()
--         local largeFont = love.graphics.newFont(48)
--         love.graphics.setFont(largeFont)
--         local textWidth = largeFont:getWidth(title)
--         local tetrisTextHeight = largeFont:getHeight()
--         love.graphics.print(
--             title,
--             windowSize.x / 2 - textWidth / 2,
--             tetrisTextHeight / 1.5
--         )
--         love.graphics.setFont(originalFont)
    
--         -- Text
--         local windowSize = self:getWindowSize()
--         love.graphics.setColor(1, 1, 1)
--         local originalFont = love.graphics.getFont()
--         local largeFont = love.graphics.newFont(24)
--         love.graphics.setFont(largeFont)
--         local textWidth = largeFont:getWidth(text)
--         local pressStartTextHeight = largeFont:getHeight()
--         love.graphics.print(
--             text,
--             windowSize.x / 2 - textWidth / 2,
--             tetrisTextHeight * 1.5 + pressStartTextHeight / 1.5
--         )
--         love.graphics.setFont(originalFont)
-- end

return GameController

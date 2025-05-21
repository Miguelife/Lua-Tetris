--[[
    state_machine.lua
    
    Implementation of the State design pattern for managing game states.
    Handles transitions between different game states (e.g., initial, gameplay, pause, game over)
    and delegates update, input, and drawing to the current active state.
]]

-- MARK: REQUIRES
local States = require("src.core.state_machine.init")

---@class StateMachine
---@field state table The current state object
-- MARK: STATE MACHINE
local StateMachine = {}
StateMachine.__index = StateMachine
setmetatable(StateMachine, StateMachine)

---Creates a new state machine with the given initial state
---@param state table The initial state class to set
---@return StateMachine The new StateMachine instance
function StateMachine.new(state)
    local self = setmetatable({ }, StateMachine)
    -- Initialize with the provided state
    self.state = state.new(self)
    return self
end

---Changes the current state to a new state
---@param state string The name of the state to change to
function StateMachine:change(state)
    -- Creates a new instance of the requested state and makes it the current state
    self.state = States[state].new(self)
end

---Updates the current state logic
---@param dt number Delta time since last update (in seconds)
function StateMachine:update(dt)
    -- Delegate update to the current state
    self.state:update(dt)
end

---Handles key press events for the current state
---@param key string The key that was pressed
function StateMachine:keypressed(key)
    -- Delegate key press handling to the current state
    self.state:keypressed(key)
end

---Draws the current state content to the screen
function StateMachine:draw()
    -- Delegate drawing to the current state
    self.state:draw()
end

return StateMachine
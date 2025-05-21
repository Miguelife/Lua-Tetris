--[[
    state_base.lua
    
    Base class for all game states in the state machine.
    Provides the interface that all concrete states must implement.
    Part of the State pattern implementation for game flow control.
]]

-- MARK: STATE BASE
local State = {}
State.__index = State

---Creates a new State instance
---@return table The new State instance
function State.new()
    local self = setmetatable({ }, State)
    return self
end

---Updates the state logic
---@param dt number Delta time since last update (in seconds)
function State:update(dt)
    -- To be implemented by concrete states
end

---Handles key press events
---@param key string The key that was pressed
function State:keypressed(key)
    -- To be implemented by concrete states
end

---Draws the state content to the screen
function State:draw()
    -- To be implemented by concrete states
end

return State

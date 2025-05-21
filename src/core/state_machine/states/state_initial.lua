-- MARK: REQUIRES
local State = require("src.core.state_machine.states.state_base")

-- MARK: STATE INITIAL
local StateInitial = {}
StateInitial.__index = StateInitial
setmetatable(StateInitial, State)

function StateInitial.new(stateMachine)
    local self = setmetatable(State.new(), StateInitial)
    self.stateMachine = stateMachine
    return self
end

function StateInitial:update(dt)
end

function StateInitial:keypressed(key)
    if key == "space" then
        self.stateMachine:change("GAME")
    end
end

function StateInitial:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Tetris!", 100, 100)
    love.graphics.print("Press space to start", 100, 150)
end

return StateInitial 
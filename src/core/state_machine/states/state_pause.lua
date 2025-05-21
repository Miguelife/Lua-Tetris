-- MARK: REQUIRES
local State = require("src.core.state_machine.states.state_base")

-- MARK: STATE PAUSE
local StatePause = {}
StatePause.__index = StatePause
setmetatable(StatePause, State)

function StatePause.new(stateMachine)
    local self = setmetatable(State.new(), StatePause)
    self.stateMachine = stateMachine
    return self
end

function StatePause:update(dt)
end

function StatePause:keypressed(key)
    if key == "space" then
        self.stateMachine:change("GAME")
    end
end

function StatePause:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("PAUSE", 100, 100)
    love.graphics.print("Press space to resume", 100, 150)
end

return StatePause

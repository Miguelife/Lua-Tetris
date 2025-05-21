-- MARK: REQUIRES
local State = require("src.core.state_machine.states.state_base")

-- MARK: STATE GAME_OVER
local StateGameOver = {}
StateGameOver.__index = StateGameOver
setmetatable(StateGameOver, State)

function StateGameOver.new(stateMachine)
    local self = setmetatable(State.new(), StateGameOver)
    self.stateMachine = stateMachine
    
    return self
end

function StateGameOver:update(dt)
end

function StateGameOver:keypressed(key)
    if key == "space" then
        self.stateMachine:change("GAME")
    end
end

function StateGameOver:draw()
    self:drawDefaultScreen("Game Over!", "Press space to restart")
end

return StateGameOver

-- MARK: STATES MODULE LOADER
-- This file facilitates the import of all states

---@class States
---@field BASE table Base state class
---@field INITIAL table Initial state class
---@field GAME table Game state class
---@field GAME_OVER table Game over state class
---@field PAUSE table Pause state class

-- Import the base state class
local State = require("src.core.state_machine.states.state_base")

-- Import all states
local StateInitial = require("src.core.state_machine.states.state_initial")
local StateGame = require("src.core.state_machine.states.state_game")
local StateGameOver = require("src.core.state_machine.states.state_game_over")
local StatePause = require("src.core.state_machine.states.state_pause")

-- Export a module containing all state classes
return {
    BASE = State,
    INITIAL = StateInitial,
    GAME = StateGame,
    GAME_OVER = StateGameOver,
    PAUSE = StatePause
}
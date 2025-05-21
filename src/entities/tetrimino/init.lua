-- MARK: TETRIMINO MODULE LOADER
-- This file facilitates the import of all tetriminos

-- Import the base tetrimino class
local Tetrimino = require("src.entities.tetrimino.tetrimino_base")

-- Import all tetrimino types
local TetriminoT = require("src.entities.tetrimino.tetrimino_t")
local TetriminoI = require("src.entities.tetrimino.tetrimino_i")
local TetriminoO = require("src.entities.tetrimino.tetrimino_o")
local TetriminoS = require("src.entities.tetrimino.tetrimino_s")
local TetriminoZ = require("src.entities.tetrimino.tetrimino_z")
local TetriminoL = require("src.entities.tetrimino.tetrimino_l")
local TetriminoJ = require("src.entities.tetrimino.tetrimino_j")

-- Export a module containing all tetrimino classes
return {
    Tetrimino = Tetrimino,
    T = TetriminoT,
    I = TetriminoI,
    O = TetriminoO,
    S = TetriminoS,
    Z = TetriminoZ,
    L = TetriminoL,
    J = TetriminoJ
}

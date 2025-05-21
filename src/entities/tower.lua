--[[
    tower.lua
    
    Represents the tower of accumulated tetrimino pieces in the game.
    This class is currently disabled/commented out but may be used
    in future implementations to handle the stack of pieces that have
    settled at the bottom of the playfield.
]]

-- -- REQUIRES
-- local Spritesheet = require("src.utils.spritesheet")

-- local Tower = {}
-- Tower.__index = Tower

-- ---Creates a new Tower instance to represent accumulated pieces
-- ---@return table The new Tower instance
-- function Tower.new()
--     local self = setmetatable({ }, Tower)
--     -- Position of the tower on the screen
--     self.position = { x = 0, y = 0 }
--     -- Visual representation of the tower
--     self.sprite = Spritesheet:getSprite(0, 0)
--     return self
-- end

-- ---Draws the tower on screen
-- function Tower:draw()
--     love.graphics.setColor(1, 1, 1)
--     Spritesheet:draw(self.sprite, self.position.x, self.position.y)
-- end

-- return Tower
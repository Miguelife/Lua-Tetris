Piece = {}
Piece.__index = Piece

function Piece.new(x, y, sprite)
    local self = setmetatable({ }, Piece)
    self.x = x
    self.y = y
    self.sprite = sprite
    return self
end
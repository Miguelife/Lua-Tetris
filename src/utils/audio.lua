--[[
    audio.lua
    
    Utility for playing audio in the game.
    Handles both background music (looped, streamed) and
    sound effects (one-time, preloaded).
]]

local Audio = {}

---Plays background music that loops continuously
---@param music string The name of the music file (without extension, assumed to be .ogg)
function Audio.playMusic(music)
    local music = love.audio.newSource("assets/music/"..music..".ogg", "stream")
    music:setLooping(true) -- Music will loop continuously
    music:play()
end

---Plays a sound effect once
---@param effect string The name of the effect file (without extension, assumed to be .ogg)
function Audio.playEffect(effect)
    local effect = love.audio.newSource("assets/effects/"..effect..".ogg", "static")
    effect:setVolume(0.7) -- Effect volume is slightly reduced
    effect:play()
end

return Audio

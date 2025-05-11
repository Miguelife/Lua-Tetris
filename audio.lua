Audio = {}

function Audio.playMusic(music)
    local music = love.audio.newSource("assets/music/"..music..".ogg", "stream")
    music:setLooping(true)
    music:play()
end

function Audio.playEffect(effect)
    local effect = love.audio.newSource("assets/effects/"..effect..".ogg", "static")
    effect:setVolume(0.7)
    effect:play()
end
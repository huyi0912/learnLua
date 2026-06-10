local blockImage
local sound
local bgm
function love.load()
    font = love.graphics.newFont("fonts/Songti.ttc", 20)
    love.graphics.setFont(font)
    blockImage = love.graphics.newImage("images/block.png")
    sound = love.audio.newSource("audio/click.mp3", "static")
    sound:setVolume(0.8)
    bgm = love.audio.newSource("audio/bgm.mp3", "stream")
    bgm:setLooping(true)
    bgm:setVolume(0.5)
    bgm:play()
end

function love.keypressed(key)
    if key == "right" or key == "left" then
        sound:clone():play()
    end
end

local x, y = 400, 300
function love.update(dt)
    if love.keyboard.isDown("right") then
        x = x + 200 * dt
    elseif love.keyboard.isDown("left") then
        x = x - 200 * dt
    end
    if love.keyboard.isDown("up") then
        y = y - 200 * dt
    elseif love.keyboard.isDown("down") then
        y = y + 200 * dt
    end
end

function love.draw()
    if blockImage then
        love.graphics.draw(blockImage, x, y)
    end
end

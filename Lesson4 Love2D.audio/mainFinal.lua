local blockImage
local sound
local bgm
function love.load()
    font = love.graphics.newFont("fonts/Songti.ttc", 20)
    love.graphics.setFont(font)
    blockImage = love.graphics.newImage("images/block.png")

    sound = love.audio.newSource("audio/click.mp3", "static")
    sound:setVolume(0.8)                                  -- 設定音量 (範圍為 0.0 到 1.0)​

    bgm = love.audio.newSource("audio/bgm.mp3", "stream") -- 載入音效​
    bgm:setLooping(true)                                  -- 設定無限循環播放​
    bgm:setVolume(0.4)                                    -- 設定音量 (0.0 到 1.0) ​
    bgm:play()                                            -- 開始播放背景音樂​
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

function love.keypressed(key) -- 按下空白鍵時播放音效 ​
    if key == "right" or key == "left" or key == "down" then
        -- clone() 可讓同一音效在連續快速按下時重複疊加，不會被中斷​
        sound:clone():play()
    end
end

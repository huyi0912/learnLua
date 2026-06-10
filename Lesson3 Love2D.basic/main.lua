local blockImage
function love.load()
    font = love.graphics.newFont("fonts/Songti.ttc", 20)
    love.graphics.setFont(font)
    blockImage = love.graphics.newImage("images/block.png")
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
    --love.graphics.print("你好,love2d!", 400, 300)
    --love.graphics.circle("fill", x, y, 30)
    -- love.graphics.print("左右移動！", 10, 10)
    if blockImage then
        love.graphics.draw(blockImage, x, y)
    end
end
